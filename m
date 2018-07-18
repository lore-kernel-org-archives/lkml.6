Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CA1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93D72084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="noQj7F/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93D72084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbeGSAWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 20:22:12 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:22961 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbeGSAWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 20:22:12 -0400
Received: from mail-ua0-f181.google.com (mail-ua0-f181.google.com [209.85.217.181]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w6INfjIG010320;
        Thu, 19 Jul 2018 08:41:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w6INfjIG010320
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531957306;
        bh=l+y37Td0FAMMYQuD3ffkprnlW+sekRcRkfBPxJEs4yI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=noQj7F/Lal+YVfzRuaovOo6w5LbIo5F6FQRRXHScPX+aU9dUkJc6Gfxmit3EBiuEx
         gVzQmP4u3iYN2oWjky5ewWSZhWa1y9jSwNjF8tcj9IwrYfV2nXsQ1wkpb2PR1XERbP
         eRXEuLMFF0qG81MPvB2ERzgowBlTMmU9uaGvMnUCqjPWaOVHEteotE0Y62qovDlPoL
         QQ4Hf7LdOZ20onjc7tPBq9OGMCqxkSDplhXuc4ViPh7OhajSsiJkeIvoKgXD2Lnf9W
         6fBcQeXGprzXA+mVz9pDXNeAHWURIckoIoFkEEkl4mLV1eVrjCRUHAQAYBRcwyes5C
         LKdFzGuNU7KjQ==
X-Nifty-SrcIP: [209.85.217.181]
Received: by mail-ua0-f181.google.com with SMTP id q12-v6so4044014ual.2;
        Wed, 18 Jul 2018 16:41:45 -0700 (PDT)
X-Gm-Message-State: AOUpUlEFXv5xV+NrTD5t6pLWhlgTb/rWbDVJVRlzNrTi2Mq9QEo9LdZR
        Akpo3+sG5C+apvGtA+09AfZkpgHESPCLI2Vsn3g=
X-Google-Smtp-Source: AAOMgpdULU+4phIeyPmnjPgwKVTV4HzZ4gnj90uWfGEEnuoS2lN21X3zwMMPkXUDcXRGDcr3598L2yPNycs9UX4BKoc=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr5225657uaf.199.1531957304657;
 Wed, 18 Jul 2018 16:41:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 16:41:04
 -0700 (PDT)
In-Reply-To: <20180712140539.4b5xdraq34i5dbii@kshutemo-mobl1>
References: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com> <20180712140539.4b5xdraq34i5dbii@kshutemo-mobl1>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 19 Jul 2018 08:41:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNAThEpLsFgD_pv4ZgLWfbXcNPBiPEU7qZ5ah_R=x8LQA0w@mail.gmail.com>
Message-ID: <CAK7LNAThEpLsFgD_pv4ZgLWfbXcNPBiPEU7qZ5ah_R=x8LQA0w@mail.gmail.com>
Subject: Re: [PATCH 0/6] kbuild: clean-up and rename LDFLAGS to KBUILD_LDFLAGS
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>, X86 ML <x86@kernel.org>,
        linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        openrisc@lists.librecores.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org, Jeff Dike <jdike@addtoit.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-12 23:05 GMT+09:00 Kirill A. Shutemov <kirill@shutemov.name>:
> On Thu, Jul 12, 2018 at 05:01:30PM +0900, Masahiro Yamada wrote:
>>
>> This series renames LDFLAGS to KBUILD_LDFLAGS
>> after some Makefile cleanups.
>>
>> Currently, the last patch does not apply to Linus' tree
>> due to missing pre-requisite patches.
>>
>> I will resolve conflicts as needed.
>>
>>
>>
>> Masahiro Yamada (6):
>>   um: remove redundant 'export LDFLAGS' in arch/x86/Makefile.um
>>   ARM: vfp: clean-up arch/arm/vfp/Makefile
>>   kbuild: remove redundant LDFLAGS clearing in arch/*/Makefile
>>   kbuild: replace $(LDFLAGS) $(ldflags-y) with $(ld_flags)
>>   kbuild: change ld_flags to contain LDFLAGS_$(@F)
>>   kbuild: rename LDFLAGS to KBUILD_LDFLAGS
>
> Thanks! Looks sane to me
>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>


Patch 1, 3, 4, 5 applied to linux-kbuild.



-- 
Best Regards
Masahiro Yamada
