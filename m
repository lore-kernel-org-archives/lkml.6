Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470EEC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EA52084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfAUJwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:52:31 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35961 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726133AbfAUJwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:52:31 -0500
X-IronPort-AV: E=Sophos;i="5.56,502,1539619200"; 
   d="scan'208";a="52488180"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 21 Jan 2019 17:52:29 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 34F484C47E9A;
        Mon, 21 Jan 2019 17:52:29 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Jan 2019 17:52:33 +0800
Date:   Mon, 21 Jan 2019 17:51:23 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v15 5/6] x86/boot: Parse SRAT address from RSDP and store
 immovable memory
Message-ID: <20190121095123.GD15754@localhost.localdomain>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-6-fanc.fnst@cn.fujitsu.com>
 <20190116110158.GC15409@zn.tnic>
 <20190121093348.GB15754@localhost.localdomain>
 <20190121094214.GC15754@localhost.localdomain>
 <20190121094524.GD29166@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190121094524.GD29166@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 34F484C47E9A.AC07A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:45:24AM +0100, Borislav Petkov wrote:
>On Mon, Jan 21, 2019 at 05:42:14PM +0800, Chao Fan wrote:
>> Or I clear this function as:
>> static acpi_physical_address get_rsdp_addr(void)
>> {
>>         acpi_physical_address pa;
>> 
>>         pa = get_acpi_rsdp();
>> 
>>         if (!pa)
>>                 pa = boot_params->acpi_rsdp_addr;
>> 
>>         if (!pa)
>>                 pa = efi_get_rsdp_addr();
>> 
>>         if (!pa)
>>                 pa = bios_get_rsdp_addr();
>> 
>>         if (pa && !boot_params->acpi_rsdp_addr)
>>                 boot_params->acpi_rsdp_addr = pa;
>
>Or simply:
>
>	if (pa)
>		boot_params->acpi_rsdp_addr = pa;
>

Make sense. If pa is not zero, boot_params->acpi_rsdp_addr is zero or
the same as pa, so will change it.

Thanks,
Chao Fan

>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


