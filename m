Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D64BECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FD820843
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="VHoZMWGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FD820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbeJ2LvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:51:21 -0400
Received: from nag.0l.de ([207.154.252.120]:44438 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbeJ2LvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:51:20 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FZMmOT8W3hDnwoys+4u03hGY1lZ0jB/w8ZWdNYUX1IA=;
        b=VHoZMWGiRwtBBgIcU1O6ds+OuMwlomWnBSAZHTe1nnW0EYvNE/a5Y4H+FBIR5lMaVrvdl7
        Tm/HglULr7N0/+EKyvpNFsOmnbtvHfxDRcqrEpJbZ5x89iTOT+IZnQBJCTPTS3AuQfHZV+
        g85x4/EaChcdPkNtTa0wiYA0fkYN8y/3k5gFw5QCLF7Wsq/9Xhewy2PkG4pOTpdxANR7NU
        M+8sMRGjJMXeYNRqoQuYRjaPn0GI1za6H8Kv5ak1qcwLzWFD8DKT32cTIdh0dpC/HGwBzj
        2b1Go+rjbR3rliUabYtGoOsvzsHX8AZ/T2soqGfFNULY3Mx8fLP5ROlNbZtEQg==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, Joe Perches <joe@perches.com>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH v2 07/12] w1: use __func__ for logging the function name
Date:   Mon, 29 Oct 2018 04:03:37 +0100
Message-Id: <406b71b62bab0b8899b756c8992c95c4b2836ee0.1540782140.git.post@steffenvogel.de>
In-Reply-To: <cover.1540782140.git.post@steffenvogel.de>
References: <cover.1540782140.git.post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FZMmOT8W3hDnwoys+4u03hGY1lZ0jB/w8ZWdNYUX1IA=;
        b=XL8XcpeuU7gqiTbuoIvgCBhFNqCe7hD+9l3z89UXXZ2aTEM7AzfaGuZxT6WHjjDMGzd+Kn
        PzTW5GF55e/TCB4ah1gOCW6sEEXv1FkCkbng5YIZW8s/JFR6r/vOOytw0rw5ziDJf0Aufd
        Bxh764gc+PPeiOj2JOnNspnULFO4c2DKVdAWRil6Lv9I44TBpcCQJ5R97mcc+/5I9V58ab
        MefEetdRebYcmx6SKP7wA4vBCgtmypVsMqvcRw93PA2ec898Xx6BGie2OTG+RsvrG3gTEU
        PJlyTnBa+086l4zLnTRGGyQwF+UPO1ARbwXLMI/ntwfu9xIGRVVFNcfg3mFZSQ==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540782275; a=rsa-sha256;
        cv=none;
        b=X0R1rFBVCjTark9eo8VKrH64OCUqeLgOhwvbCzB3V8iLLDBIcPfBHbmbEo73XDJNA3Kct3UYOAHopEixCeZAk3+NF4ns1noO/zVN/IWUJS8a45QqADQMXRqaofhN3ZDOrEd+c/z9/Nq78x+KpzoqlbmBJkldrBKfGZfNLlMxcQArfacXCQ7gPWbCOsDVTnBYmbIPXoSacHajG4/P2+dp8quBBgYFhUc7zMLmTzq+TTXqtgaL67aL952hWRZQ+6e7N4WNYdn0/pj94OWBgmiBVH1snZR63JDU0xsH3H09rJi/MHrThEych4blI/GX8/fWXmJ6RPZ+twHGLa/qkHVjdw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a warning raised by the checkpatch tool.

Signed-off-by: Steffen Vogel <post@steffenvogel.de>
---
 drivers/w1/w1.c     | 5 +++--
 drivers/w1/w1_int.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index cbfc3f7012de..4cbe1849fbfc 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -1066,7 +1066,8 @@ void w1_search(struct w1_master *dev, u8 search_type,
 
 			if (test_bit(W1_ABORT_SEARCH, &dev->flags)) {
 				mutex_unlock(&dev->bus_mutex);
-				dev_dbg(&dev->dev, "Abort w1_search\n");
+				dev_dbg(&dev->dev, "Abort %s\n", __func__);
+
 				return;
 			}
 		}
@@ -1094,7 +1095,7 @@ void w1_search(struct w1_master *dev, u8 search_type,
 			 * bus).
 			 */
 			dev_info(&dev->dev, "%s: max_slave_count %d reached, will continue next search.\n",
-				__func__, dev->max_slave_count);
+				 __func__, dev->max_slave_count);
 			set_bit(W1_WARN_MAX_COUNT, &dev->flags);
 		}
 	}
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index a6c011e57c90..a5230c0d49e3 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -98,7 +98,7 @@ int w1_add_master_device(struct w1_bus_master *master)
 	if (!(master->touch_bit && master->reset_bus) &&
 	    !(master->write_bit && master->read_bit) &&
 	    !(master->write_byte && master->read_byte && master->reset_bus)) {
-		pr_err("w1_add_master_device: invalid function set\n");
+		pr_err("%s: invalid function set\n", __func__);
 		return(-EINVAL);
 	}
 
-- 
2.11.0

