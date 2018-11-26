Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1EDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4291420672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBO6Y4In"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4291420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbeKZV7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:59:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730303AbeKZV7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:59:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92D7F2146F;
        Mon, 26 Nov 2018 11:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230334;
        bh=N3bGNCITPaJfJRcAr88hMCQMVdHi/SVfbGHQn3UHgmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FBO6Y4InrkKvViyjXzvXNBymhLrf72b1ViTDKKfL+aqXuM8CIZ+TW4XezYgmPvA+3
         aPwYg9jTNGM3RaFj49Mvp6QG7hAZRhY5r5CvD/ryPQTcoleqtt5kcmmOc12jwZ4/Tt
         w9Ka9MDpUMhoi8cB8kSXgVaZCcTFpFo9WxCaryAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.19 096/118] MIPS: OCTEON: cavium_octeon_defconfig: re-enable OCTEON USB driver
Date:   Mon, 26 Nov 2018 11:51:30 +0100
Message-Id: <20181126105105.550994668@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaro Koskinen <aaro.koskinen@iki.fi>

commit 82fba2df7f7c019627f24c5036dc99f41731d770 upstream.

Re-enable OCTEON USB driver which is needed on older hardware
(e.g. EdgeRouter Lite) for mass storage etc. This got accidentally
deleted when config options were changed for OCTEON2/3 USB.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: f922bc0ad08b ("MIPS: Octeon: cavium_octeon_defconfig: Enable more drivers")
Patchwork: https://patchwork.linux-mips.org/patch/21077/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # 4.14+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/configs/cavium_octeon_defconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -140,6 +140,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_STAGING=y
 CONFIG_OCTEON_ETHERNET=y
+CONFIG_OCTEON_USB=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_RAS=y
 CONFIG_EXT4_FS=y


