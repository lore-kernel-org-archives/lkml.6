Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A486BC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6100F20879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790143;
	bh=1WRiQa++7Mn1w5ae1EeV+gv1Mnnl3P6+Rw28IUGlZ5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1NLsHGmAfLk8+Zmo6wpiPvdBfZhUmB2x/vURqVNmHDScHpxdxth81J67JWpMG2KHR
	 Khw4PJENCADXz26xEA56o/jmrb4+vA7bwraRtvUxAaixMMFA1SDu0pYSx1LQgdyp0Q
	 TaAdiV67flpUsiRE5ARwNPAANT0XUcqf1Dvq1K+A=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6100F20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbeLNMWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:22:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732295AbeLNMOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:14:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 649592151B;
        Fri, 14 Dec 2018 12:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789653;
        bh=1WRiQa++7Mn1w5ae1EeV+gv1Mnnl3P6+Rw28IUGlZ5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z1jmb2Jb71JCPOUWxqwxMvD7aAlKiw2OBHwDfPHbyECnhMVG+AKzFs9dceIv9q9MT
         OOtgDd5TEd6Na7oS6WjUn/ntH5L9VCrPDIMHQjMEQjY1zvdON49QS/MV+jCzv25Fgy
         NEEUlr00h6byUGh3ygmKNSOSnggSuBtmzA18wwoQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 25/88] USB: omap_udc: fix USB gadget functionality on Palm Tungsten E
Date:   Fri, 14 Dec 2018 12:59:59 +0100
Message-Id: <20181214115704.183262004@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2c2322fbcab8102b8cadc09d66714700a2da42c2 ]

On Palm TE nothing happens when you try to use gadget drivers and plug
the USB cable. Fix by adding the board to the vbus sense quirk list.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/omap_udc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 653963459d78..d1ed92acafa3 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2037,6 +2037,7 @@ static inline int machine_without_vbus_sense(void)
 {
 	return machine_is_omap_innovator()
 		|| machine_is_omap_osk()
+		|| machine_is_omap_palmte()
 		|| machine_is_sx1()
 		/* No known omap7xx boards with vbus sense */
 		|| cpu_is_omap7xx();
-- 
2.19.1



