Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED27C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0149C20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfAOHWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 02:22:21 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:57806 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727273AbfAOHWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 02:22:21 -0500
X-IronPort-AV: E=Sophos;i="5.56,480,1539619200"; 
   d="scan'208";a="52044703"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Jan 2019 15:22:17 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id B10FB4BAD9C4;
        Tue, 15 Jan 2019 15:22:15 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 15 Jan 2019 15:22:21 +0800
Date:   Tue, 15 Jan 2019 15:21:21 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>, <lv.zheng@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v15 3/6] x86/boot: Introduce efi_get_rsdp_addr() to find
 RSDP from EFI table
Message-ID: <20190115072121.GB30900@localhost.localdomain>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-4-fanc.fnst@cn.fujitsu.com>
 <20190110211523.GG17621@zn.tnic>
 <20190111012353.GD2216@localhost.localdomain>
 <20190111103225.GA4729@zn.tnic>
 <20190113094704.GC13263@localhost.localdomain>
 <20190113110544.GA7398@zn.tnic>
 <20190114012641.GA30900@localhost.localdomain>
 <20190114090756.GA2773@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190114090756.GA2773@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: B10FB4BAD9C4.AF9A1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 10:07:56AM +0100, Borislav Petkov wrote:
>On Mon, Jan 14, 2019 at 09:26:42AM +0800, Chao Fan wrote:
>> According to the code, I saw:
>> #ifdef ACPI_ASL_COMPILER
>> #define ACPI_32BIT_PHYSICAL_ADDRESS
>> #endif
>> 
>> and then
>> #ifdef ACPI_32BIT_PHYSICAL_ADDRESS
>> typedef u32 acpi_physical_address;
>> 
>> As for ACPI_ASL_COMPILER, I saw iASL in documention, but can't find more
>> information in the code. If I miss something, please let me know.
>
>And, as a result, can acpi_physical_address ever be u32 in a kernel
>build?

In my understanding after looking into the commit message the comments.
I thinks yes. For 32-bit OS:
32-bit OS without PAE, it's u32.
32-bit OS with PAE in 64-bit machine, it's u64.

So I thinks there is some situations where it's u32.
'acpi_physical_address' was always u32 for 32-bit OS, and then to
solve some problems, "Zheng, Lv" add the commit. So I have added to Cc
"Zheng, Lv" , I am not sure whether "Zheng, Lv" can give some suggestion
about when acpi_physical_address is defined as u32.

Thanks,
Chao Fan

>
>git annotate is also very helpful when doing git archeology like, for
>example, finding the patch which added the ifdeffery and looking at its
>commit message for more hints.
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


