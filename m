Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA92BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7292172C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uDD7KnX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7292172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeHUEtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 00:49:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35133 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeHUEtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 00:49:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id z4-v6so2668645pgv.2;
        Mon, 20 Aug 2018 18:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dKVsrW00CNKloDa80Kme9P8vzKmI8wIFmueRM37sjWI=;
        b=uDD7KnX5l2EyOScsBVAjF2uUZBunRuV041D9UI0a998l6gYfaYrd+sS8dvvkBLdh9T
         KRRxUVxxOynbLz/ZTR1E613vr0dkTuFs37adszckE5dStJwgL5MQFU6ZzyfyApxB5DWN
         m447wnGVno30uGz5PNAe+iREV2yXuf8ZO/1R4yAclc4wn5kMznR8w4pFtPon9EKVnh03
         u2bE1zu9E1auaMjUAJfWHcoMirVBYxYnSEYR7MKWwHfO3pNQmDxWfF9RAWf2J3qy6Byw
         FdbdR5WK9zoeLXJEXA+a/jaJglQlicrNFhegnx1DXyS12oLRq9yuBFXgsg4XidzOrk0a
         SJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dKVsrW00CNKloDa80Kme9P8vzKmI8wIFmueRM37sjWI=;
        b=cqgKWD/mOGBwwsNoLNffXTvsmYutwSvBryVkLUQptOHo9/HrJ59S/R6TGPN+NMvCYt
         3WMf2lTEu3ssATzGmGCMrM6cSvpoQpjL4qUnP4N39EYbpI8mq+ZMcH2AZ4aBwNLU57Fb
         36XhJctYXRQk/1v9V3xgsjeTfoe5wAH1koQWei73MStrQy4UX/1+XBcIOTg4V57m7qw9
         D1ZBh5hpnIFMfWQOxMrycFNcLZ10Ys2dtT3l45soJHF/5StkakUSBoIG7p2Wtz0MAwXF
         gE1rxVGKx0fOd7WjLz05GtP31Ku3zY3drQCkedSR7YuDhd5hNXullWlzy3Qe0Y9a6Dkm
         d7Og==
X-Gm-Message-State: AOUpUlGL7/+REGM3dLOvUDkppLMUsmPeM0Ac0hQ5CJwcMtKIC2rNifKF
        K1rXioiKmKj1peZ/mn2tYjU=
X-Google-Smtp-Source: AA+uWPyh6WYLNBLFz1EHsLznfPYryyI6LGzaYG18bGXx3ldoBHSLEwHBAEqvtKXWRYheMjzpeQzOaQ==
X-Received: by 2002:a65:6243:: with SMTP id q3-v6mr44589539pgv.273.1534815077611;
        Mon, 20 Aug 2018 18:31:17 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id e7-v6sm15166526pgc.55.2018.08.20.18.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 18:31:17 -0700 (PDT)
Subject: Re: [PATCH] scripts/dtc: consolidate include path options in Makefile
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1530669563-32637-1-git-send-email-yamada.masahiro@socionext.com>
 <cfb66b67-f423-0c26-0b22-0d57a581b44a@gmail.com>
 <CAL_Jsq+iAxmKvZ+RAD-VSOWirYOxc52mJHU5f5gybhWwQn2w_g@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <7fba348e-9fd3-9661-248d-82917f8f6676@gmail.com>
Date:   Mon, 20 Aug 2018 18:31:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+iAxmKvZ+RAD-VSOWirYOxc52mJHU5f5gybhWwQn2w_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/18 14:32, Rob Herring wrote:
> On Mon, Aug 20, 2018 at 1:55 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 07/03/18 18:59, Masahiro Yamada wrote:
>>> It is tedious to specify extra compiler options for every file.
>>> HOST_EXTRACFLAGS is useful to add options to all files in a
>>> directory.
>>>
>>> -I$(src)/libfdt is needed for all the files in this directory
>>> to include libfdt_env.h etc. from scripts/dtc/libfdt/.
>>>
>>> On the other hand, -I$(src) is used to include check-in headers
>>> from generated C files.  Thus, I added it only to dtc-lexer.lex.o
>>> and dtc-parser.tab.o .
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> ---
>>>
>>>  scripts/dtc/Makefile | 18 ++++--------------
>>>  1 file changed, 4 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
>>> index 9cac65b..1c943e0 100644
>>> --- a/scripts/dtc/Makefile
>>> +++ b/scripts/dtc/Makefile
>>> @@ -9,21 +9,11 @@ dtc-objs    := dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
>>>  dtc-objs     += dtc-lexer.lex.o dtc-parser.tab.o
>>>
>>>  # Source files need to get at the userspace version of libfdt_env.h to compile
>>> +HOST_EXTRACFLAGS := -I$(src)/libfdt
>>
>> Shouldn't that be += instead of :=?
> 
> I don't think so. The definition is local to the file (and reset
> before each makefile is included).
> 
> Rob
> 

Every other place where HOST_EXTRACFLAGS is assigned a value, += is used
instead of :=, including the example in Documentation/kbuild/makefiles.txt

What makes scripts/dtc/Makefile different than the other makefiles?

-Frank

