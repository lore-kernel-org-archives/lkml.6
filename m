Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57289C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6D2208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6D2208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeJPKhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:37:35 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:18012 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726927AbeJPKhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:37:35 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="46184056"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Oct 2018 10:49:27 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id D19764B69E01;
        Tue, 16 Oct 2018 10:49:26 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 16 Oct 2018 10:49:32 +0800
Date:   Tue, 16 Oct 2018 10:48:44 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <ard.biesheuvel@linaro.org>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v8 1/3] x86/boot: Add acpitb.c to parse acpi tables
Message-ID: <20181016024844.GA12871@localhost.localdomain>
References: <20181010084119.17539-1-fanc.fnst@cn.fujitsu.com>
 <20181010084119.17539-2-fanc.fnst@cn.fujitsu.com>
 <20181011105708.GB25435@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181011105708.GB25435@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: D19764B69E01.AC2C1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 12:57:08PM +0200, Borislav Petkov wrote:
>On Wed, Oct 10, 2018 at 04:41:17PM +0800, Chao Fan wrote:
[...]
>> +#ifdef CONFIG_KEXEC
>> +static bool get_acpi_rsdp(acpi_physical_address *rsdp_addr)
>> +{
>> +	char *args = (char *)get_cmd_line_ptr();
>> +	size_t len = strlen((char *)args);
>> +	char *tmp_cmdline, *param, *val;
>> +	unsigned long long addr = 0;
>> +	char *endptr;
>> +
>> +	if (!strstr(args, "acpi_rsdp="))
>> +		return false;
>> +
>> +	tmp_cmdline = malloc(len+1);
>> +	if (!tmp_cmdline)
>> +		error("Failed to allocate space for tmp_cmdline");
>
>Why do you even need to allocate a tmp cmdline?
>
>Ah, I see what you've done - you've copied handle_mem_options() in
>kaslr.c. Well no, not really.
>
>That functionality needs to get extracted into a separate facility. Oh
>look, there's arch/x86/boot/compressed/cmdline.c which is begging to get
>extended.
>
>:-)
>

Hi Boris,

Sorry for disturbing you again, I want to make sure this detail with you.
You mean that I need splite this as a function and put it to
cmdline.c, right?
If my understand is wrong, please let me know.

Thanks,
Chao Fan



