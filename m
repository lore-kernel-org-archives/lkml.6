Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D6EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4642821536
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=progandy-de.20150623.gappssmtp.com header.i=@progandy-de.20150623.gappssmtp.com header.b="rt2hYKBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4642821536
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=progandy.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbeHQXVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 19:21:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38117 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeHQXVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 19:21:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id w11-v6so5463883wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 13:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=progandy-de.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IJ8EglotdUjsPKwO9B0Nmn/N9+EameltWUM77Dxy0M4=;
        b=rt2hYKBNvjEXfrvbOuPP6QJ+KtXVW+4g54jRTTyzuiFqqE60M9kSFwnVvQaTHRtoUq
         cH0uV9utBhoUsH2vVl0lUSUWZ/Hi/dPtBjIT3dbKIvIwbwb8lW73NpHbftVy9Y2G+aXc
         SDy6R8DnjfcWOEmXG02pBnEOivsUhrnjRGUnjiPbhJXRpxo5S85ZCBWjVQeRRDgyS/Hq
         xI/C8Kupmdlu8AnoQlSie1GoClanvZncA45wBGUcIje35FhwicTahs37ij4dOADrkdyC
         BtJsqLCXgdVnIsI7xKxthlW1dT6hTm6J5M5sMYyQlOcHeyk0LtWhLui0W6Ic3Mtup4cA
         C/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=IJ8EglotdUjsPKwO9B0Nmn/N9+EameltWUM77Dxy0M4=;
        b=h6Ycas5CAT8KdxpXTF9M2qHDQg2/S+Cif7y6pDW52Y8PPLcpi/13zkbTs0tlsPuueS
         O8b+jg08CYsftq4dZHJaimSL3i9bZSNXVXud3TpKWyV/ODz9Hi6L1WVOBMYoFxrXs0LV
         FrmeoEVDs3s9AJLfxCulPtu5izl6df16FiT/hyxxyHr25mgXhXin5febUfnsO69DWNnp
         c9/KmoJ7H1db6lTVv6CWauazT1M9q4fampOOKxi0bCofeZn5bIdEpqPgZN2RAa6V3KAh
         gV5r8frSQ9R08ZyCZuT+54U+fXLtT1JVQ6lcltIlwspRvax6Rm6dd7tnMxcQ/Nm8jYHv
         NV6g==
X-Gm-Message-State: AOUpUlGd1dON74Qh1h/cMVXb5XbJaz1LJAaWm81K/7JLzcN/LwV0CVQ+
        /4W12q+B5V+AGtiNo5Pj/FSmMA==
X-Google-Smtp-Source: AA+uWPytoFgGk+AfiVYYdyHHaj0W645JTX4kXrozV+emI3TVthEIgCXHU02g61rjPAf+BcuhfF6rUw==
X-Received: by 2002:adf:ed41:: with SMTP id u1-v6mr23695053wro.262.1534536997694;
        Fri, 17 Aug 2018 13:16:37 -0700 (PDT)
Received: from pamobile.localdomain (p54A175A0.dip0.t-ipconnect.de. [84.161.117.160])
        by smtp.gmail.com with ESMTPSA id u9-v6sm3124789wrc.43.2018.08.17.13.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 13:16:37 -0700 (PDT)
From:   Andreas Bosch <linux@progandy.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Even Xu <even.xu@intel.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HID: intel-ish-hid: Enable Sunrise Point-H ish driver
Date:   Fri, 17 Aug 2018 22:16:00 +0200
Message-Id: <20180817201614.11971-1-linux@progandy.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <23171b1a3740407eac5d5c22548ce107d8edde59.camel@linux.intel.com>
References: <23171b1a3740407eac5d5c22548ce107d8edde59.camel@linux.intel.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added PCI ID for Sunrise Point-H ISH.

Signed-off-by: Andreas Bosch <linux@progandy.de>
---
I hope this patch arrives correctly.
---
 drivers/hid/intel-ish-hid/ipc/hw-ish.h  | 1 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ipc/hw-ish.h b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
index 97869b7410eb..da133716bed0 100644
--- a/drivers/hid/intel-ish-hid/ipc/hw-ish.h
+++ b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
@@ -29,6 +29,7 @@
 #define CNL_Ax_DEVICE_ID	0x9DFC
 #define GLK_Ax_DEVICE_ID	0x31A2
 #define CNL_H_DEVICE_ID		0xA37C
+#define SPT_H_DEVICE_ID		0xA135
 
 #define	REVISION_ID_CHT_A0	0x6
 #define	REVISION_ID_CHT_Ax_SI	0x0
diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index a2c53ea3b5ed..c7b8eb32b1ea 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -38,6 +38,7 @@ static const struct pci_device_id ish_pci_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, CNL_Ax_DEVICE_ID)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, GLK_Ax_DEVICE_ID)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, CNL_H_DEVICE_ID)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, SPT_H_DEVICE_ID)},
 	{0, }
 };
 MODULE_DEVICE_TABLE(pci, ish_pci_tbl);
-- 
2.18.0

