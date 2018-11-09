Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DFFC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590BD20892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t8F0IN0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590BD20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbeKJEQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:16:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43518 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeKJEQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:16:12 -0500
Received: by mail-pg1-f195.google.com with SMTP id n10-v6so1188723pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 10:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JxD7kSkr4geOJC7eAPZ5I5uWHT9Cuv2yw07CVEu3ka0=;
        b=t8F0IN0RccyPgUJchAX8wq6xyLMo1oGUhuAWW8CFx9XB7F6FLFKtKQS4w1SwCo/iuA
         F0Udee4DAVY/JujMk1ocjUq7iqh7S9Pk8MnVUWzDcoTrzYNkAQVblRxZXgcIYAmg7Sfs
         GQ2jnE2tCx1FCS+wuv9lZwmEIOMckDEvdvHgNaUedoEZJaToFTNH4tZEj53IeMtQLOYx
         0SRJcgJcN+Iqr4mmxtLf3+ZkxmdjGqDiatqM1lXkEJ/S3fzbsv/iSqNRjAzFguIgKA9Z
         7ai1qlLAPUtq4nuzgl6GExwgVb30hlGiAb/8KF6tynCFaBCMwqldV/LTRoajgG5fKQu4
         zkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JxD7kSkr4geOJC7eAPZ5I5uWHT9Cuv2yw07CVEu3ka0=;
        b=thtW5stGgJDFjHmBJ0oC2GEeWwwybPF/WFTEIOsDNgZnzuUo0ODfbu5BgpRLKAAwCi
         9ucrv3Xv/vO2EL/Wk/OPqqyICLMbBq+Cm+1VN0MYHFAXa8r9kqmmesHwfl4o1YP6Ps0x
         YtgxfdD57/wPu/0kS975aGwFj7LP0Xnr9vjuxXETg3kM/3/lJWkPD/XR3wNS70RpkZbB
         ZoIOk4GQ0dzFGwfLEqsWwbIF6b4Y4yUywDoO8xdM5saPeYtACRUKeDIgEBbZmJxcpAqP
         vw3afIuyN6uw3c7O2WyWiD87la9+lV9u4kkMmSo3bLUdyR4rGLqbTviiZTOqjAm6g7j0
         oEBg==
X-Gm-Message-State: AGRZ1gLyGrJnkn2yaBnVxBZ0/skhpL7aoLYFh4dewEM30ExVgsJpSWvL
        LHN3Cri8m5HKEhY8+yBQ7tU2LA==
X-Google-Smtp-Source: AJdET5dAhFEyxJohMBANUoZ5fGj+1zU8rhgCO6S/pRCu+vziPH2AOjgU88aNdZKjlS3uP/jglQ+8HQ==
X-Received: by 2002:a63:d40a:: with SMTP id a10mr8236693pgh.394.1541788464604;
        Fri, 09 Nov 2018 10:34:24 -0800 (PST)
Received: from hackmann.mtv.corp.google.com ([2620:0:1000:1601:82f7:8f1:8c08:a97a])
        by smtp.gmail.com with ESMTPSA id q195sm7870491pgq.7.2018.11.09.10.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 10:34:23 -0800 (PST)
Subject: Re: [PATCH v2 2/2] kbuild: consolidate Clang compiler flags
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Matthias Kaehlcke <mka@chromium.org>, joel@jms.id.au,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
References: <1541473495-25262-1-git-send-email-yamada.masahiro@socionext.com>
 <1541473495-25262-2-git-send-email-yamada.masahiro@socionext.com>
 <CAKwvOd=JwjVu=uk3egVJxTm9vPcF=Jx2Bexx1Wx=Z-PC38X3Uw@mail.gmail.com>
From:   Greg Hackmann <ghackmann@google.com>
Message-ID: <9c4868dd-82fa-aa5c-843e-e1f78ffbc7e2@google.com>
Date:   Fri, 9 Nov 2018 10:34:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOd=JwjVu=uk3egVJxTm9vPcF=Jx2Bexx1Wx=Z-PC38X3Uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2018 10:29 AM, Nick Desaulniers wrote:
> On Mon, Nov 5, 2018 at 7:05 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>> Collect basic Clang options such as --target, --prefix, --gcc-toolchain,
>> -no-integrated-as into a single variable CLANG_FLAGS so that it can be
>> easily reused in other parts of Makefile.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> Changes in v2:
>>   - Use := flavor instead of = because $(CLANG_FLAGS) is expanded soon anyway
>>
>>   Makefile | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index da11700..e173a73 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -487,18 +487,17 @@ endif
>>
>>   ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
>>   ifneq ($(CROSS_COMPILE),)
>> -CLANG_TARGET   := --target=$(notdir $(CROSS_COMPILE:%-=%))
>> +CLANG_FLAGS    := --target=$(notdir $(CROSS_COMPILE:%-=%))
>>   GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
>> -CLANG_PREFIX   := --prefix=$(GCC_TOOLCHAIN_DIR)
>> +CLANG_FLAGS    += --prefix=$(GCC_TOOLCHAIN_DIR)
>>   GCC_TOOLCHAIN  := $(realpath $(GCC_TOOLCHAIN_DIR)/..)
>>   endif
>>   ifneq ($(GCC_TOOLCHAIN),)
>> -CLANG_GCC_TC   := --gcc-toolchain=$(GCC_TOOLCHAIN)
>> +CLANG_FLAGS    += --gcc-toolchain=$(GCC_TOOLCHAIN)
>>   endif
>> -KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>> -KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>> -KBUILD_CFLAGS += -no-integrated-as
>> -KBUILD_AFLAGS += -no-integrated-as
>> +CLANG_FLAGS    += -no-integrated-as
>> +KBUILD_CFLAGS  += $(CLANG_FLAGS)
>> +KBUILD_AFLAGS  += $(CLANG_FLAGS)
>>   endif
>>
>>   RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
>> --
>> 2.7.4
>>
> 
> Thanks for this patch, Masahiro, it's a good simplification.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> Would you mind waiting for a tested-by from Stefan, and maybe an ack
> from Greg (added to cc)?
> 

Acked-by: Greg Hackmann <ghackmann@google.com>
