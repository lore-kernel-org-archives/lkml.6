Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67831C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DBA2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c574+VDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DBA2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeICOhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:37:41 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38370 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeICOhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:37:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so576391wmi.3;
        Mon, 03 Sep 2018 03:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UCW8TgwYNVmBSAc70saWnWD6T62aPhUzoic2d3dh/Ds=;
        b=c574+VDF/IkmbJ0eRtoqxyMGyiGuIv4iMVvFs1wdjakakaUz807Iz3bEYPz6ydSeJH
         1WXz7xkgArrLkb66NFvHwUEK1AF0VfEKs2nmF6AdBMrdnCT1616RdqaeLL9k9oglpJV4
         LPUU91TZYJPtN76/XlgXyyV5gP3U9cTgk/T7sNA1zVv0u+jlqDaUhO9bFj/xB2tZ4PcN
         BSQe/JoCn1rKl+BGLMtuUebWzqaTBDeNvTWWCf+dolg330XHmmaOYnaoT0ABMpE7IW4d
         yTE526nA7+eynVNI+Ed0uNNqkk2ynDzmz9j/3vxMpiuraHaa+CpZHElOc3f8dTkfuKYV
         lOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UCW8TgwYNVmBSAc70saWnWD6T62aPhUzoic2d3dh/Ds=;
        b=cLvR5rEpIXzcahIvkqXNkTbX4nH0+f4woWpPgA1xUrN+/Hk5c0su9SZW2miTsRKV9A
         wbJFiwIfsZyMpwlEC4Wq5QrxIbW/ruSxKP+Tv0/XDzYHMo8ZqPzfQ0PMEyct/G0pWOR+
         AtouNNSVFGuVLGV9bvC21RqaTfgIJ1DYJIl/iKFfLoQEwimenrqRRcLaAO5mjZ8FF67d
         tjDeXW12SxQYjVA4vpE/y6Dlip0LXgsIACNFb6UUDb2SLPdYnkECee3YFED35X9+89nt
         UXIbnkAJFXFly3bg7MjWXJw9mPXCkt1np6NXKlwruWLpqEEnFQqkeGEij5hMQU0nrnt5
         LYag==
X-Gm-Message-State: APzg51BYt200MlagkgFHMt0ygiU5L5EIABR0jbkubqHti2b2GMHIo9nV
        kpXKdqKBZqaoJoOnqCPaHjs=
X-Google-Smtp-Source: ANB0VdbUa+DdaWasubYIgKfnM+5uxYqXNB3lDIGO5ZdNPxSOcU0EyTx0ToHmXdvANW4RQFB0NVYH3g==
X-Received: by 2002:a1c:9dc3:: with SMTP id g186-v6mr4883035wme.26.1535969890295;
        Mon, 03 Sep 2018 03:18:10 -0700 (PDT)
Received: from localhost (pD9E51F49.dip0.t-ipconnect.de. [217.229.31.73])
        by smtp.gmail.com with ESMTPSA id p89-v6sm27835504wrc.97.2018.09.03.03.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 03:18:09 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: xhci: tegra: Firmware header is little endian
Date:   Mon,  3 Sep 2018 12:18:08 +0200
Message-Id: <20180903101808.31559-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The XUSB firmware header is in little endian byte order, so make the
fields __le32 and __le16 instead of u32 and u16 to avoid warnings from
sparse when the fields are used with the endian-aware __le32_to_cpu()
and __le16_to_cpu() accessors, respectively.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/usb/host/xhci-tegra.c | 52 +++++++++++++++++------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 4b463e5202a4..4ee510a51d64 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -107,35 +107,35 @@
 #define IMEM_BLOCK_SIZE				256
 
 struct tegra_xusb_fw_header {
-	u32 boot_loadaddr_in_imem;
-	u32 boot_codedfi_offset;
-	u32 boot_codetag;
-	u32 boot_codesize;
-	u32 phys_memaddr;
-	u16 reqphys_memsize;
-	u16 alloc_phys_memsize;
-	u32 rodata_img_offset;
-	u32 rodata_section_start;
-	u32 rodata_section_end;
-	u32 main_fnaddr;
-	u32 fwimg_cksum;
-	u32 fwimg_created_time;
-	u32 imem_resident_start;
-	u32 imem_resident_end;
-	u32 idirect_start;
-	u32 idirect_end;
-	u32 l2_imem_start;
-	u32 l2_imem_end;
-	u32 version_id;
+	__le32 boot_loadaddr_in_imem;
+	__le32 boot_codedfi_offset;
+	__le32 boot_codetag;
+	__le32 boot_codesize;
+	__le32 phys_memaddr;
+	__le16 reqphys_memsize;
+	__le16 alloc_phys_memsize;
+	__le32 rodata_img_offset;
+	__le32 rodata_section_start;
+	__le32 rodata_section_end;
+	__le32 main_fnaddr;
+	__le32 fwimg_cksum;
+	__le32 fwimg_created_time;
+	__le32 imem_resident_start;
+	__le32 imem_resident_end;
+	__le32 idirect_start;
+	__le32 idirect_end;
+	__le32 l2_imem_start;
+	__le32 l2_imem_end;
+	__le32 version_id;
 	u8 init_ddirect;
 	u8 reserved[3];
-	u32 phys_addr_log_buffer;
-	u32 total_log_entries;
-	u32 dequeue_ptr;
-	u32 dummy_var[2];
-	u32 fwimg_len;
+	__le32 phys_addr_log_buffer;
+	__le32 total_log_entries;
+	__le32 dequeue_ptr;
+	__le32 dummy_var[2];
+	__le32 fwimg_len;
 	u8 magic[8];
-	u32 ss_low_power_entry_timeout;
+	__le32 ss_low_power_entry_timeout;
 	u8 num_hsic_port;
 	u8 padding[139]; /* Pad to 256 bytes */
 };
-- 
2.18.0

