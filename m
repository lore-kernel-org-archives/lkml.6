Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EF5C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC8D20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC8D20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeIKNuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:50:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:40026 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbeIKNuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:50:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 01:52:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,359,1531810800"; 
   d="scan'208";a="79544443"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Sep 2018 01:52:30 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fzePO-00078c-A6; Tue, 11 Sep 2018 16:52:30 +0800
Date:   Tue, 11 Sep 2018 16:52:26 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     kbuild-all@01.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, bhe@redhat.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [RFC PATCH] x86/boot: get_acpi_srat_table() can be static
Message-ID: <20180911085226.GA25670@athens>
References: <20180910124015.18073-2-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910124015.18073-2-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: cc1a4e2a5474 ("x86/boot: Add acpitb.c to parse acpi tables")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 acpitb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/acpitb.c b/arch/x86/boot/compressed/acpitb.c
index 66c5154..4ddd732 100644
--- a/arch/x86/boot/compressed/acpitb.c
+++ b/arch/x86/boot/compressed/acpitb.c
@@ -279,7 +279,7 @@ static acpi_physical_address get_rsdp_addr(void)
 	return pa;
 }
 
-struct acpi_table_header *get_acpi_srat_table(void)
+static struct acpi_table_header *get_acpi_srat_table(void)
 {
 	char *args = (char *)get_cmd_line_ptr();
 	acpi_physical_address acpi_table;
