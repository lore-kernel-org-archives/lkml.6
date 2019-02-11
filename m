Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F7BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A646204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895699;
	bh=gZvFUfBT3fji8JLZAa4RPDnUG+favXQuLJ4bBEAbZqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CWm4fRoex8CH+QTUKxLWNC6nAE/2hmevP19hq66EnWnkGUofFNL73MA998pGnua4H
	 LyolL4B2AE0vJlKyBuvPtIq6uMFFmLhe+tsSEC6vsOVvi9u3Xp64Y4SH88cW2+qH8P
	 uwv0TxUg0a+b2vewTvH0WYHDkGwRn2apeR0g91uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbfBKOe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:34:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730739AbfBKOex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:34:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 000012081B;
        Mon, 11 Feb 2019 14:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895692;
        bh=gZvFUfBT3fji8JLZAa4RPDnUG+favXQuLJ4bBEAbZqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wdDswNwfR6Vblh4KcU5+EINq8rATLxrI4CWofwqqGuE3UM54H4Fpv8ogSIa5cQJaH
         NHSrDvdreDxOkZegtivcOtHQoGf9XFzljEcb58REW3EwDXdJdQlUADkTY3F67AyB6u
         8oy9B/3CSiQQMnp/biXtnIC9vjblNZOQy8qavYsU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 4.20 291/352] thermal: hwmon: inline helpers when CONFIG_THERMAL_HWMON is not set
Date:   Mon, 11 Feb 2019 15:18:38 +0100
Message-Id: <20190211141905.417853882@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -19,13 +19,13 @@
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


