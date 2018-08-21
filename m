Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C36C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 05:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CB72172D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 05:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dL1zjEHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CB72172D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeHUI41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 04:56:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36519 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeHUI40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 04:56:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17-v6so1687367pgv.3;
        Mon, 20 Aug 2018 22:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uUzjv8ses5pBwL7pzI6a8FJO/j+U3Xxr0+eMjhaPvHc=;
        b=dL1zjEHv3FrfIpdHCDvOFHUMgm/PQyxAr7pi8y0hDe7seBzcH9JnC75tEpVoEsmZ0X
         3/VjyqE3VvmCBWTWuiwnfAo4iaY0buJe4ErdpOINv0Uq4UGFlTdyY9StyUo/fJ/y+EPK
         XoScMTLZug5vy6DDNBtGdsxG4yevCPGcX8k1VkR6L+SxX1UIeCumsvo83aG7TsjF7/yK
         BnSOEAVnmue4iPYOF7hPS/CiDelivz6a/Vu/0b1KxjlEdH2fEp7MTJfgOrMI+NmZLcW1
         nO1phhiPhhox0JyrVSIvRxrVTgjFY1rKf+DpOw+SI3nfcbh/AP318Wo9ABvnRJRT7Z9Q
         diGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uUzjv8ses5pBwL7pzI6a8FJO/j+U3Xxr0+eMjhaPvHc=;
        b=sRJPXrflHeBNbSUOzadz4IofZvO8SYMr4FbORf84+SckInBtt1NU4BqnaRGl0GMpf1
         8ipVMckV/wfDE9bROf8UT+aOjan3LTOfAyWSBof3ejkEwejvX3jYyLBmQekz2ZBZgaNT
         Ij+zMh0bcGwZVMwaB8ubnf5rmOpZtVX1v3yj4QRNxuNKws2jBDCJzGl+2+pl3kydhFLV
         e1n1T9GtVLpb/EihLDMX0zXszvScxkCvnU9uZGD4WGH5NO6j1dyBwWdtQB5VVfXyZqQ1
         X7BxOumD4TU2RbXHWs6Jv4VCrzVP2mSXSeNvioOviUC/8kM+nPQGqGeHIOT2EY3hEgIm
         Rrgw==
X-Gm-Message-State: AOUpUlFjfSFqHbCYSp6TnViq+TiTb80y8hT4w/E1lymnGZ80kgMLSWgr
        nDgq9VPM2quqo00OiizMiWQ=
X-Google-Smtp-Source: AA+uWPxE5dZtNBCRt9EDo8RrCnOUjjKpim2R0QcB/Yo7ySnZEnPLRrnFRESj9+rOTHpkcFnAqjAZyA==
X-Received: by 2002:a62:90d4:: with SMTP id q81-v6mr51796756pfk.37.1534829869421;
        Mon, 20 Aug 2018 22:37:49 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id r23-v6sm18231531pfj.5.2018.08.20.22.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 22:37:48 -0700 (PDT)
Subject: Re: [PATCH] scripts/dtc: consolidate include path options in Makefile
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1530669563-32637-1-git-send-email-yamada.masahiro@socionext.com>
 <cfb66b67-f423-0c26-0b22-0d57a581b44a@gmail.com>
 <CAL_Jsq+iAxmKvZ+RAD-VSOWirYOxc52mJHU5f5gybhWwQn2w_g@mail.gmail.com>
 <7fba348e-9fd3-9661-248d-82917f8f6676@gmail.com>
 <CAK7LNATFbykSHcDZqovTZ0aN9kHvZw3Q4Mamb1gwMwRhg7_s-A@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <78d8984c-211a-65c3-ab43-b3c02373ef0a@gmail.com>
Date:   Mon, 20 Aug 2018 22:37:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNATFbykSHcDZqovTZ0aN9kHvZw3Q4Mamb1gwMwRhg7_s-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/18 19:08, Masahiro Yamada wrote:
> Hi Frank,
> 
> 2018-08-21 10:31 GMT+09:00 Frank Rowand <frowand.list@gmail.com>:
>> On 08/20/18 14:32, Rob Herring wrote:
>>> On Mon, Aug 20, 2018 at 1:55 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>
>>>> On 07/03/18 18:59, Masahiro Yamada wrote:
>>>>> It is tedious to specify extra compiler options for every file.
>>>>> HOST_EXTRACFLAGS is useful to add options to all files in a
>>>>> directory.
>>>>>
>>>>> -I$(src)/libfdt is needed for all the files in this directory
>>>>> to include libfdt_env.h etc. from scripts/dtc/libfdt/.
>>>>>
>>>>> On the other hand, -I$(src) is used to include check-in headers
>>>>> from generated C files.  Thus, I added it only to dtc-lexer.lex.o
>>>>> and dtc-parser.tab.o .
>>>>>
>>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>>> ---
>>>>>
>>>>>  scripts/dtc/Makefile | 18 ++++--------------
>>>>>  1 file changed, 4 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
>>>>> index 9cac65b..1c943e0 100644
>>>>> --- a/scripts/dtc/Makefile
>>>>> +++ b/scripts/dtc/Makefile
>>>>> @@ -9,21 +9,11 @@ dtc-objs    := dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
>>>>>  dtc-objs     += dtc-lexer.lex.o dtc-parser.tab.o
>>>>>
>>>>>  # Source files need to get at the userspace version of libfdt_env.h to compile
>>>>> +HOST_EXTRACFLAGS := -I$(src)/libfdt
>>>>
>>>> Shouldn't that be += instead of :=?
>>>
>>> I don't think so. The definition is local to the file (and reset
>>> before each makefile is included).
>>>
>>> Rob
>>>
>>
>> Every other place where HOST_EXTRACFLAGS is assigned a value, += is used
>> instead of :=, including the example in Documentation/kbuild/makefiles.txt
>>
>> What makes scripts/dtc/Makefile different than the other makefiles?
>>
>> -Frank
>>
> 
> 
> := and += work in the same way in here.

Unless I do: HOST_EXTRACFLAGS=xxx make
where "xxx" is some random flag I feel like adding in a particular build.

Or is there something else buried in the kernel makefiles that leads to
a result different than I get from a simple example of recursive make files?

-Frank

> 
> 
> As Rob said, HOST_EXTRACFLAGS is reset in each makefile
> because HOST_EXTRACFLAGS is not export'ed.
> (scripts/gcc-plugins/Makefile actually export's it, but it is wrong.)
> 
> 
> Precisely speaking, HOST_EXTRACFLAGS is immediately expanded
> if it is set by :=, whereas it is lazily expanded if it is
> set by +=.  But, there is no effective difference in this case.
> 
> 

