Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2910789-1525994897-2-7064612525457518283
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Attached: add-set_memory_block_size-param
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525994897; b=O+mhOHtdDvp01LLrfPiHRaBr9e6cnSH/E4XC5pxkOpr7ET3XXE
    6uIoNUELDnIAE50sDFGCMj9kTWqt5fajMch4WL0wuUQjKkh2fo2m9S+A2cDW2x6g
    UpD6Bq/kaFrtnSVrOSVqA9FuBiR1xkghFJBW4/OfdiQyjPylulanCzhjJiE1Ih0s
    x7cvRVnsk5JdvXf0DC9lWK74Df6r4gyUYStnwxLulxkjC+/RF9MXM2iD3Koo8xFm
    W/3GBcQMG0m37EGNMU65J5at3dIHo8Gb71+pw6mmO366jsAsVUmrWxJ66a5Dp0fg
    cFrQeF5MssDN/4jUPZgrg2ia9nbxjwoF3iuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:references:date:from:to:cc
    :subject:sender:list-id; s=fm2; t=1525994897; bh=TLFcrwZzhH16wRh
    LNHIVzwn0K+IxZu/ume/GfPtuync=; b=VcAQjKaMP5bvVQ1lwrtrvDI1GhnEABg
    zePnc3HAhNjBwYEiWxptE1PzjXsG5rD/0uO3VLeH+8W410JBKbS6qFF/hv6ASnjl
    XUn+KsIYVHW99WggNUqRficXnQwkKwFEjlj/lcTy3/a7ynbqPBLA+ItmpF4ms2T4
    GWnqquBXD6tRldvd2Lnb6EkdUjrkQCYNu9SRqXzAuNhKq04l506Otl8I/skHzz5Z
    58zw8B3fPOWjdIMJ976UBDv107CAEvSD+Eo8tH9ys+S8WYHL0uNKNU+TsctpYvsd
    8rqv6ebIWuVXdHyL3UOddXMaiz0ihrRl7EpJPKJcwHKvEXNgrz9cwUw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHlpTIbO2I4D/YmA1tAwvmwj0CTfP9HW26znXv6mclSU/DIS76ajlzPp1GAOv+hDS5mZmFfeWuauxrhTGEqU5iOwvFAjorUozgW8a5mN882A1gpKwiEd
    GQNaDQ6oCJ6GYp5brZx5KibjV4qYluU0AgzhUztQwjLEBJ6ykROWXBCC7uSBQrvCVBsudtjBi/R8raLZAisTm7AZg8Q+361nRqkylKPmopit2CUcwRJF8jUy
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=MvuuwTCpAAAA:8
    a=SjrjeNCRGmZ7eYBPIeoA:9 a=dVHiktpip_riXrfdqayU:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750722AbeEJX2O (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 19:28:14 -0400
Received: from relay3.sgi.com ([192.48.152.1]:42529 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750710AbeEJX2O (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 10 May 2018 19:28:14 -0400
Message-Id: <20180510231832.439202532@stormcage.americas.sgi.com>
References: <20180510231832.035433756@stormcage.americas.sgi.com>
User-Agent: quilt/0.46-1
Date: Thu, 10 May 2018 18:18:35 -0500
From: <mike.travis@hpe.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Andrew Banman <andrew.banman@hpe.com>, jgross@suse.com,
        dan.j.williams@intel.com, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 3/3] x86/platform/UV: Add kernel parameter to set memory block size
Content-Disposition: inline; filename=add-set_memory_block_size-param
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a kernel parameter that allows setting UV memory block size.  This
is to provide an adjustment for new forms of PMEM and other DIMM memory
that might require alignment restrictions other than scanning the global
address table for the required minimum alignment.  The value set will be
further adjusted by both the GAM range table scan as well as restrictions
imposed by set_memory_block_size_order().

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Andrew Banman <andrew.banman@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c
+++ linux/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -396,6 +396,17 @@ EXPORT_SYMBOL(uv_hub_info_version);
 /* Default UV memory block size is 2GB */
 static unsigned long mem_block_size = (2UL << 30);
 
+/* Kernel parameter to specify UV mem block size */
+static int parse_mem_block_size(char *ptr)
+{
+	unsigned long size = memparse(ptr, NULL);
+
+	/* Size will be rounded down by set_block_size() below */
+	mem_block_size = size;
+	return 0;
+}
+early_param("uv_memblksize", parse_mem_block_size);
+
 static __init int adj_blksize(u32 lgre)
 {
 	unsigned long base = (unsigned long)lgre << UV_GAM_RANGE_SHFT;

-- 
