Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAE7C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD01023D80
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1q0o3rJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD01023D80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbeGEFjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:39:22 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:56678 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753198AbeGEFjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:39:17 -0400
Received: from mail-ua0-f171.google.com (mail-ua0-f171.google.com [209.85.217.171]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w655d39j013370;
        Thu, 5 Jul 2018 14:39:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w655d39j013370
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530769144;
        bh=XKtfsWJjVxqeFEwh0LffU16cvd3q/cKAxWupUskQo8s=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=1q0o3rJ0kzr9FEMupT0CZ0dMH0cNM8IkQQtZnrGU+oBR6glV3W20MPpxdJl9CJcn1
         TgfD/ETE2TWy36/xaugoYN5lJtDu8G8fPo0TZzvfF0jo+/ZJc2ETftwPyHfw1R8LtI
         eCRXXtS7rT0ZDOCkrZ+83ue/gw5vpjOWg5PlHZTfDgEL0T7/L1u+HgWeaEQZw/npDA
         LBJjr7S1WTi6bpQveILWU7cuAhcQ4cOoImAYy/AlgtLM5RaDZ4owBZS5EOkljLnNI1
         HzFfSq0YU/Lu/q+6sT+RErvD0R1mCQPz7OeN3FJP0vYyqxyRKiMU8hKIHrL6IX3JoU
         ZRqicLwhKVZDg==
X-Nifty-SrcIP: [209.85.217.171]
Received: by mail-ua0-f171.google.com with SMTP id u8-v6so4670753uao.4;
        Wed, 04 Jul 2018 22:39:04 -0700 (PDT)
X-Gm-Message-State: APt69E2VHB7vtze4hrSzUpze6TPyM59nxzlb84NcVJkg7iFpDyPAYg2d
        TqZWQ8+1xZkgKQQLLr+9D9486jCIc7A0uUqrHYU=
X-Google-Smtp-Source: AAOMgpdVrGWBaTmzhXpfAfIxmXsSgK+ELj4Hn8XRjUqn8csZrU8Wc2tqpMtz0zNIyQw4wN4O7M2i9wf4BnkRhTxHwYY=
X-Received: by 2002:ab0:e3:: with SMTP id 90-v6mr2526024uaj.52.1530769142994;
 Wed, 04 Jul 2018 22:39:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 22:38:22 -0700 (PDT)
In-Reply-To: <e230cffa-b3ea-d5c2-3d2c-5f822c9c2e7d@infradead.org>
References: <20180702144711.22111-1-hch@lst.de> <20180702144711.22111-2-hch@lst.de>
 <5c090e3f-ced0-62c5-c511-f4c66804ed32@infradead.org> <4dfba139-43a2-5949-3221-39cae3191ae7@infradead.org>
 <20180703133616.GB15589@lst.de> <e230cffa-b3ea-d5c2-3d2c-5f822c9c2e7d@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 5 Jul 2018 14:38:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQJ+J_d6FbcHZ5+SM6mS3MjyGq_Q3x4_BxWzXzVZvMRkQ@mail.gmail.com>
Message-ID: <CAK7LNAQJ+J_d6FbcHZ5+SM6mS3MjyGq_Q3x4_BxWzXzVZvMRkQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] kconfig: include common Kconfig files from top-level Kconfig
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-04 1:11 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> On 07/03/18 06:36, Christoph Hellwig wrote:
>> On Mon, Jul 02, 2018 at 01:08:16PM -0700, Randy Dunlap wrote:
>>>> I would prefer to have init/Kconfig before arch/$(SRCARCH)/Kconfig.
>>>
>>> Ugh, that won't get this set correctly on x86_64:
>>> CONFIG_PGTABLE_LEVELS=2
>>
>> Did you try it?  As far as I can tell modern kconfig isn't really
>> order sensitive any more.
>> --
>
> Yes, it was wrong. :(
>
> Once the symbol has a default value, it won't be assigned a different
> default value (at least that's how it looks; I haven't read the kconfig
> source code).
>

The order does matter.

The 'default' properties are accumulated
as they appear.


If arch/Kconfig were parsed before arch/x86/Kconfig,
it would end up with this:



config PGTABLE_LEVELS
    int
    default 2                    <- from arch/Kconfig
    default 5 if X86_5LEVEL      <- from arch/x86/Kconfig
    default 4 if X86_64          <- from arch/x86/Kconfig
    default 3 if X86_PAE         <- from arch/x86/Kconfig
    default 2                    <- from arch/x86/Kconfig

So, PGTABLE_LEVELS would be always 2.
The last four lines are dead code.





The correct order is arch/x86/Kconfig, arch/Kconfig
then we can get this:

config PGTABLE_LEVELS
    int
    default 5 if X86_5LEVEL      <- from arch/x86/Kconfig
    default 4 if X86_64          <- from arch/x86/Kconfig
    default 3 if X86_PAE         <- from arch/x86/Kconfig
    default 2                    <- from arch/x86/Kconfig
    default 2                    <- from arch/Kconfig


-- 
Best Regards
Masahiro Yamada
