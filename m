Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEE1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9843E214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xdJw3pXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9843E214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbeKTDJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:09:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387628AbeKTDJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:09:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 724E12148E;
        Mon, 19 Nov 2018 16:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645917;
        bh=Qy+sJty1wG1ws/xDtwjNW0OPtX3sOmFKDeeKVAQiHNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xdJw3pXFiXn7EzgAUaIGBrIaPwELyTKgzRCPnkQEim/lAinN0Pak1/G/9KxEima9I
         zSh1u9nydaqEFRIhy5oBfXmbAOpEplNKPrV89SM2m/kCNpZ/mnaFsV73vILJVGmPzO
         aPXIt5LJkE3FVj+udyuyQLnJH0lUMY8XKawCvKmk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diego Viola <diego.viola@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.18 138/171] libata: blacklist SAMSUNG MZ7TD256HAFV-000L9 SSD
Date:   Mon, 19 Nov 2018 17:28:54 +0100
Message-Id: <20181119162638.622380000@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Diego Viola <diego.viola@gmail.com>

commit 410b5c7b48368317af95f0113692561d01d8144e upstream.

med_power_with_dipm still causes freezes after updating the firmware to
the latest version (DXT04L5Q).

Set model_rev to NULL and blacklist the device.

Cc: stable@vger.kernel.org
Signed-off-by: Diego Viola <diego.viola@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4552,7 +4552,7 @@ static const struct ata_blacklist_entry
 	/* These specific Samsung models/firmware-revs do not handle LPM well */
 	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
 	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
-	{ "SAMSUNG MZ7TD256HAFV-000L9", "DXT02L5Q", ATA_HORKAGE_NOLPM, },
+	{ "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_HORKAGE_NOLPM, },
 
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |


