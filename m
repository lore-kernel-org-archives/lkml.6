Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F373C6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C70524011
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XhKfPq1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C70524011
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753560AbeGFBDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 21:03:55 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:48009 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753439AbeGFBDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 21:03:53 -0400
Received: from mail-vk0-f50.google.com (mail-vk0-f50.google.com [209.85.213.50]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w6613hXe031192;
        Fri, 6 Jul 2018 10:03:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w6613hXe031192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530839024;
        bh=R5c90YfCQMczlMP9xaOIiRTrPi8IcXDYvR9IRGv3GQA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=XhKfPq1sQSIENaPV8GID4dwcM3gAnwLp2Z3uHhCw9LzdpPllugbj27KRwYJmUdsFv
         23BvvT55sNxGUm3/ExeRLP+w6sp6OZB6CTDe4FsIWImLVU2SBf4tFg5RqSeSCD5nYe
         4D5YbIMPWBVCZ5CUYoiyEmDX9ozuuWX1HcTzVXWE0RW91s2Ut4Lr6MKi9dFR9Gd5Np
         0Hdnb4997HTKSQAHYl0UziBMkKqgvsdi6AfS7gBXS4kC53Gy+GpIsY0gRzv3+LJbCX
         ybJVX7scxgVW+ROuaccXdovQio88OrniuwNbyHd1qxUIpRBHOmV0DxNnsVcuFxFATT
         nRodx2EDugk1Q==
X-Nifty-SrcIP: [209.85.213.50]
Received: by mail-vk0-f50.google.com with SMTP id e139-v6so4461333vkf.6;
        Thu, 05 Jul 2018 18:03:43 -0700 (PDT)
X-Gm-Message-State: APt69E2hN4sBfGBP61qVWEO/YKmtrkUlf+piH/EqjojJDASqi4MyTb8F
        MkCC7iQZCZNPCziyA98P5QzW3Hx89SJc7iE/1/s=
X-Google-Smtp-Source: AAOMgpcJwcEIp8HPNEc2VUWbVcMrdwOjBsm50WKEoIM3g56o5aWW9GC+p6SSkcCufL3Jvfeh8uYZ3nyDeKXQIORmaT0=
X-Received: by 2002:a1f:8c4a:: with SMTP id o71-v6mr2689610vkd.11.1530839022761;
 Thu, 05 Jul 2018 18:03:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 18:03:02 -0700 (PDT)
In-Reply-To: <43f37d95-89cc-fd42-46c3-533f85f014e8@infradead.org>
References: <6477e1be-6686-582b-35b5-72e9f677619f@infradead.org>
 <CAK7LNATj1ibX=GMJ92fpX45Ba2WJKKb=h7_ZR9DeZcyBGcMHbQ@mail.gmail.com> <43f37d95-89cc-fd42-46c3-533f85f014e8@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 6 Jul 2018 10:03:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3CWRDDqb4F8vfG2-YNCZMKC0PmF64bPvm=XMV8Hz8mQ@mail.gmail.com>
Message-ID: <CAK7LNAT3CWRDDqb4F8vfG2-YNCZMKC0PmF64bPvm=XMV8Hz8mQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: delete INSTALL_FW_PATH from kbuild documentation
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-05 11:22 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> On 07/04/18 18:49, Masahiro Yamada wrote:
>> 2018-07-05 4:59 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>
>>> Removed Kbuild documentation for INSTALL_FW_PATH.
>>>
>>> The kbuild symbol INSTALL_FW_PATH was removed from Kbuild tools in
>>> September 2014 (for 4.14) but the symbol was not deleted from
>>
>> I think 'September 2017'
>> although I can fix up the log locally.
>
> Right you are.  and thanks.
>
>>
>>
>>
>>> the kbuild documentation, so do that now.
>>>
>>> Fixes: 5620a0d1aac ("firmware: delete in-kernel firmware")
>>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: stable@vger.kernel.org # 4.14 and later
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> ---
>>>  Documentation/kbuild/kbuild.txt |    9 ---------
>>>  1 file changed, 9 deletions(-)
>>>
>>> --- linux-next-20180704.orig/Documentation/kbuild/kbuild.txt
>>> +++ linux-next-20180704/Documentation/kbuild/kbuild.txt
>>> @@ -149,15 +149,6 @@ stripped after they are installed.  If I
>>>  the default option --strip-debug will be used.  Otherwise,
>>>  INSTALL_MOD_STRIP value will be used as the options to the strip command.
>>>
>>> -INSTALL_FW_PATH
>>> ---------------------------------------------------
>>> -INSTALL_FW_PATH specifies where to install the firmware blobs.
>>> -The default value is:
>>> -
>>> -    $(INSTALL_MOD_PATH)/lib/firmware
>>> -
>>> -The value can be overridden in which case the default value is ignored.
>>> -
>>>  INSTALL_HDR_PATH
>>>  --------------------------------------------------
>>>  INSTALL_HDR_PATH specifies where to install user space headers when
>>>
>>>
>>> --
>
>

Applied to linux-kbuild. Thanks!


-- 
Best Regards
Masahiro Yamada
