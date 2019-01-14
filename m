Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2B8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CC520656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfANB1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 20:27:43 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:33186 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726657AbfANB1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 20:27:43 -0500
X-IronPort-AV: E=Sophos;i="5.56,475,1539619200"; 
   d="scan'208";a="51945019"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Jan 2019 09:27:42 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 556A44BAD7B1;
        Mon, 14 Jan 2019 09:27:36 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 14 Jan 2019 09:27:41 +0800
Date:   Mon, 14 Jan 2019 09:26:42 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v15 3/6] x86/boot: Introduce efi_get_rsdp_addr() to find
 RSDP from EFI table
Message-ID: <20190114012641.GA30900@localhost.localdomain>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-4-fanc.fnst@cn.fujitsu.com>
 <20190110211523.GG17621@zn.tnic>
 <20190111012353.GD2216@localhost.localdomain>
 <20190111103225.GA4729@zn.tnic>
 <20190113094704.GC13263@localhost.localdomain>
 <20190113110544.GA7398@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190113110544.GA7398@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 556A44BAD7B1.ABD09
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 12:05:45PM +0100, Borislav Petkov wrote:
>On Sun, Jan 13, 2019 at 05:47:04PM +0800, Chao Fan wrote:
>> 'acpi_physical_address' could be define as u64 or u32.
>
>And when can acpi_physical_address be a u32?
>

According to the code, I saw:
#ifdef ACPI_ASL_COMPILER
#define ACPI_32BIT_PHYSICAL_ADDRESS
#endif

and then
#ifdef ACPI_32BIT_PHYSICAL_ADDRESS
typedef u32 acpi_physical_address;

As for ACPI_ASL_COMPILER, I saw iASL in documention, but can't find more
information in the code. If I miss something, please let me know.

Thanks,
Chao Fan

>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


