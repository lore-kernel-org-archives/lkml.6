Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473F4C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1778E222A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897331;
	bh=XUXOFEFxw8PB3eGBQDwT6b1C0nPxCElX0MUAEqsxUBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=etBjvuMidDNXSqWePE+Lp9p1dEfPw1y7MWq1ii4eHqcBY68rKGu68jf5Du2nXKUJv
	 RNE+IhPg4LyDjeGRmov76BOxfnqjFOIwb8cO/VcidJLEhMFxdwnfR5sYdFXBIKBvSF
	 v/dE2/MFOqvMUmW4JvdWBTkG9jLhZ2X6vPMOhO2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390349AbfBKPCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:02:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390334AbfBKPCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:02:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC26F222B4;
        Mon, 11 Feb 2019 15:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897325;
        bh=XUXOFEFxw8PB3eGBQDwT6b1C0nPxCElX0MUAEqsxUBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nQJcUVRHnzIkaeXtvCWJCO/ZVlgA16po/KnGIao0ddVL6L5uranq5z23jPD9nCtFH
         aXRVf1ecqiZTmCfCY8KOQVMLbB+OqhPuhixf1yQ+MsXgzIvNVM9Rjyni2zBmDE9NtE
         n4lfFhFKeowSCiRYWBqSuK+sHFIpAS9lfaORMhSg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 4.14 165/205] thermal: hwmon: inline helpers when CONFIG_THERMAL_HWMON is not set
Date:   Mon, 11 Feb 2019 15:19:23 +0100
Message-Id: <20190211141839.140379691@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

From: Eduardo Valentin <edubezval@gmail.com>

commit 03334ba8b425b2ad275c8f390cf83c7b081c3095 upstream.

Avoid warnings like this:
thermal_hwmon.h:29:1: warning: ‘thermal_remove_hwmon_sysfs’ defined but not used [-Wunused-function]
 thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)

Fixes: 0dd88793aacd ("thermal: hwmon: move hwmon support to single file")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thermal/thermal_hwmon.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/thermal/thermal_hwmon.h
+++ b/drivers/thermal/thermal_hwmon.h
@@ -34,13 +34,13 @@
 int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz);
 void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz);
 #else
-static int
+static inline int
 thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 {
 	return 0;
 }
 
-static void
+static inline void
 thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 {
 }


