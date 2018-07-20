Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91E7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B25020673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B25020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbeGTBov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:44:51 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:53489 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730266AbeGTBov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:44:51 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42451814"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 Jul 2018 08:59:08 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 060FC4B5CF67;
        Fri, 20 Jul 2018 08:59:07 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Fri, 20 Jul 2018 08:59:06 +0800
Date:   Fri, 20 Jul 2018 08:57:18 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <mingo@redhat.com>, <bhe@redhat.com>, <keescook@chromium.org>,
        <yasu.isimatu@gmail.com>, <indou.takao@jp.fujitsu.com>,
        <lcapitulino@redhat.com>, <caoj.fnst@cn.fujitsu.com>,
        <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v3 2/4] x86/boot: Add acpitb.c to parse acpi tables
Message-ID: <20180720005717.GA6914@localhost.localdomain>
References: <20180717100409.10547-1-fanc.fnst@cn.fujitsu.com>
 <20180717100409.10547-3-fanc.fnst@cn.fujitsu.com>
 <alpine.DEB.2.21.1807191720270.1693@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807191720270.1693@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 060FC4B5CF67.AB599
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 05:22:35PM +0200, Thomas Gleixner wrote:
>On Tue, 17 Jul 2018, Chao Fan wrote:
>> +
>> +/* Search efi table for rsdp table. */
>> +static bool efi_get_rsdp_addr(acpi_physical_address *rsdp_addr)
>> +{
>> +	efi_system_table_t *systab;
>> +	bool find_rsdp = false;
>> +	bool acpi_20 = false;
>> +	bool efi_64 = false;
>> +	void *config_tables;
>> +	struct efi_info *e;
>> +	char *sig;
>> +	int size;
>> +	int i;
>> +
>> +#ifndef CONFIG_EFI
>> +	return false;
>> +#endif
>
>Please no. Wrap the whole function into CONFIG_EFI annd have a stub for the
>non EFI case returning false.

Yes, you are right. Will change it in the next version.

Thanks,
Chao Fan

>
>Thanks,
>
>	tglx
>
>


