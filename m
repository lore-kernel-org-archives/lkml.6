Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BC8C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD9420989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfA3GAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 01:00:09 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:26605 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725823AbfA3GAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 01:00:09 -0500
X-IronPort-AV: E=Sophos;i="5.56,539,1539619200"; 
   d="scan'208";a="53183023"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Jan 2019 14:00:07 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 726B34C4BB85;
        Wed, 30 Jan 2019 14:00:06 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 30 Jan 2019 14:00:12 +0800
Date:   Wed, 30 Jan 2019 13:58:47 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <kasong@redhat.com>
Subject: Re: [PATCH v16 0/7] Parse ACPI table and limit KASLR to choosing
 immovable memory
Message-ID: <20190130055847.GA17551@localhost.localdomain>
References: <20190123110850.12433-1-fanc.fnst@cn.fujitsu.com>
 <20190128175132.GE20487@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190128175132.GE20487@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 726B34C4BB85.AD534
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 06:51:32PM +0100, Borislav Petkov wrote:
>On Wed, Jan 23, 2019 at 07:08:43PM +0800, Chao Fan wrote:
>> PATCH 1/7 Copy kstrtoull() to boot/string.c to instead of using
>>           old simple_strtoull()
>> PATCH 2/7 Introduce get_acpi_rsdp() to parse RSDP in cmdline from KEXEC
>> PATCH 3/6 Introduce efi_get_rsdp_addr() to find RSDP from EFI table when
>>           booting from EFI.
>> PATCH 4/7 Introduce bios_get_rsdp_addr() to search RSDP in memory when
>>           booting from BIOS
>> PATCH 5/7 Parse RSDP and fill in boot_params->acpi_rsdp_addr before
>>           KASLR.
>> PATCH 6/7 Compute SRAT from RSDP and walk SRAT to store the immovable
>>           memory regions and store the immovable memory regions.
>> PATCH 7/7 Calculate the intersection between memory regions from e820/efi
>>           memory table and immovable memory regions. Limit KASLR to
>>           choosing these regions for randomization.

Hi Boris,

Sorry for delay.
>
>Ok, I've massaged the whole pile and fixed a couple of things that
>sprang at me, see each commit message for details.

Thanks for your fix, your change looks good.
>
>Please run it and check whether I haven't broken anything:
>
>https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-boot

I clone your branch and test some cases. Except the build issue of
cmdline_find_option(), PATCHSET works well.
Build in x86_64 and i386.
Tested EFI/BIOS environment in x86_64 and BIOS environment in i386.
Tested the 'acpi_rsdp=' and 'boot_params->acpi_rsdp_addr' issue, all
work well.

Thanks,
Chao Fan

>
>Thx.
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


