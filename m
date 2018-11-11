Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EFDC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D36206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkWJ1hc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D36206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404046AbeKLIXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:23:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:54772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404018AbeKLIW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:59 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77BDF2241B;
        Sun, 11 Nov 2018 22:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975582;
        bh=pprReBp+h0AlROTN9kPzpFKNz5sH9HmiA8x4V8EknY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IkWJ1hc5mdJ5gophawZ7knO5hNaOXDhgxsySrla2wSQMXUg8y8ywb1/kyOuVwanrO
         nHn/cVBaWH7pkZ/6cuB+CJmtOLoLelMwRhyaK54X32akZ79nlxmwtK8/NQNx2CpyOR
         K+uqpfsYCFAYVqUzg8kbYBbeSkrtXQF0pb+KcfjI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Jin <mikhail.jin@gmail.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.14 142/222] EDAC, amd64: Add Family 17h, models 10h-2fh support
Date:   Sun, 11 Nov 2018 14:23:59 -0800
Message-Id: <20181111221700.201959496@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Jin <mikhail.jin@gmail.com>

commit 8960de4a5ca7980ed1e19e7ca5a774d3b7a55c38 upstream.

Add new device IDs for family 17h, models 10h-2fh.

This is required by amd64_edac_mod in order to properly detect PCI
device functions 0 and 6.

Signed-off-by: Michael Jin <mikhail.jin@gmail.com>
Reviewed-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180816192840.31166-1-mikhail.jin@gmail.com
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/edac/amd64_edac.c |   14 ++++++++++++++
 drivers/edac/amd64_edac.h |    3 +++
 2 files changed, 17 insertions(+)

--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2200,6 +2200,15 @@ static struct amd64_family_type family_t
 			.dbam_to_cs		= f17_base_addr_to_cs_size,
 		}
 	},
+	[F17_M10H_CPUS] = {
+		.ctl_name = "F17h_M10h",
+		.f0_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F0,
+		.f6_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F6,
+		.ops = {
+			.early_channel_count	= f17_early_channel_count,
+			.dbam_to_cs		= f17_base_addr_to_cs_size,
+		}
+	},
 };
 
 /*
@@ -3188,6 +3197,11 @@ static struct amd64_family_type *per_fam
 		break;
 
 	case 0x17:
+		if (pvt->model >= 0x10 && pvt->model <= 0x2f) {
+			fam_type = &family_types[F17_M10H_CPUS];
+			pvt->ops = &family_types[F17_M10H_CPUS].ops;
+			break;
+		}
 		fam_type	= &family_types[F17_CPUS];
 		pvt->ops	= &family_types[F17_CPUS].ops;
 		break;
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -115,6 +115,8 @@
 #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F2 0x1582
 #define PCI_DEVICE_ID_AMD_17H_DF_F0	0x1460
 #define PCI_DEVICE_ID_AMD_17H_DF_F6	0x1466
+#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F0 0x15e8
+#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F6 0x15ee
 
 /*
  * Function 1 - Address Map
@@ -281,6 +283,7 @@ enum amd_families {
 	F16_CPUS,
 	F16_M30H_CPUS,
 	F17_CPUS,
+	F17_M10H_CPUS,
 	NUM_FAMILIES,
 };
 


