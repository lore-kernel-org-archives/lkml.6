Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8ADC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4385C20855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543596;
	bh=KkvIJmoIBGnv4CC/rUvjXtrRgjvvc6xu8LGEAarP084=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=syOyLW9owWA/D4CKNig1beqHGCBXMnj22/fzzVdno80Mjz0mOe158NWSKRgHyYnNe
	 J19i2Ehp64rxOJ8r5i/OQ5gqLqvqc/46L2BLyHOaLwTKRX8Pfie9ZI+7Xxg3VEPrW5
	 RONLispJUMgOFjcycvExwQrDqq78otVrAytUxL+4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4385C20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbeLKPxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:53:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbeLKPxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:53:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 175AD20855;
        Tue, 11 Dec 2018 15:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543591;
        bh=KkvIJmoIBGnv4CC/rUvjXtrRgjvvc6xu8LGEAarP084=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LM1sOj6OrkqaWEYnU9mpsujcZjIcS7dJoU8GpTW2Oe533tybvklG6XOGDvhw8ZyH9
         k32jfPDFh6MBHuVZ0Y6JwrvucfwoeHjR+xc5lotP3byisonhn2qhDN638M15VLtjgB
         4PicuU5/3sezKzI0viWJJ6wYXqJpWWs5AfEbS0QU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junwei Zhang <Jerry.Zhang@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 56/67] drm/amdgpu: update mc firmware image for polaris12 variants
Date:   Tue, 11 Dec 2018 16:41:56 +0100
Message-Id: <20181211151633.213649585@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junwei Zhang <Jerry.Zhang@amd.com>

commit d7fd67653f847327e545bdb198b901ee124afd7c upstream.

Some new variants require updated firmware.

Signed-off-by: Junwei Zhang <Jerry.Zhang@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -52,6 +52,7 @@ MODULE_FIRMWARE("amdgpu/tonga_mc.bin");
 MODULE_FIRMWARE("amdgpu/polaris11_mc.bin");
 MODULE_FIRMWARE("amdgpu/polaris10_mc.bin");
 MODULE_FIRMWARE("amdgpu/polaris12_mc.bin");
+MODULE_FIRMWARE("amdgpu/polaris12_k_mc.bin");
 
 static const u32 golden_settings_tonga_a11[] =
 {
@@ -226,6 +227,15 @@ static int gmc_v8_0_init_microcode(struc
 		break;
 	case CHIP_POLARIS12:
 		chip_name = "polaris12";
+		if (((adev->pdev->device == 0x6987) &&
+		     ((adev->pdev->revision == 0xc0) ||
+		      (adev->pdev->revision == 0xc3))) ||
+		    ((adev->pdev->device == 0x6981) &&
+		     ((adev->pdev->revision == 0x00) ||
+		      (adev->pdev->revision == 0x01) ||
+		      (adev->pdev->revision == 0x10)))) {
+			chip_name = "polaris12_k";
+		}
 		break;
 	case CHIP_FIJI:
 	case CHIP_CARRIZO:


