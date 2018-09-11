Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58439C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070CB20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070CB20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeIKNyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:54:08 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35140 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726476AbeIKNyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:54:08 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="44771282"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Sep 2018 16:55:46 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id F31644B6AE13;
        Tue, 11 Sep 2018 16:55:47 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 11 Sep 2018 16:55:52 +0800
Date:   Tue, 11 Sep 2018 16:55:25 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     kbuild test robot <fengguang.wu@intel.com>
CC:     <kbuild-all@01.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, <bhe@redhat.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <douly.fnst@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/boot: get_acpi_srat_table() can be static
Message-ID: <20180911085525.GF8519@localhost.localdomain>
References: <20180910124015.18073-2-fanc.fnst@cn.fujitsu.com>
 <20180911085226.GA25670@athens>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180911085226.GA25670@athens>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: F31644B6AE13.ABDAD
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 04:52:26PM +0800, kbuild test robot wrote:
>
>Fixes: cc1a4e2a5474 ("x86/boot: Add acpitb.c to parse acpi tables")
>Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
>---
> acpitb.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/x86/boot/compressed/acpitb.c b/arch/x86/boot/compressed/acpitb.c
>index 66c5154..4ddd732 100644
>--- a/arch/x86/boot/compressed/acpitb.c
>+++ b/arch/x86/boot/compressed/acpitb.c
>@@ -279,7 +279,7 @@ static acpi_physical_address get_rsdp_addr(void)
> 	return pa;
> }
> 
>-struct acpi_table_header *get_acpi_srat_table(void)
>+static struct acpi_table_header *get_acpi_srat_table(void)

Good catch, will add it.

Thanks,
Chao Fan

> {
> 	char *args = (char *)get_cmd_line_ptr();
> 	acpi_physical_address acpi_table;
>
>


