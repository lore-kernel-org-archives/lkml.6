Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E6EC2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B51C2064C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="cLeaZ9GW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B51C2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeJ2HF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 03:05:58 -0400
Received: from nag.0l.de ([207.154.252.120]:33452 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbeJ2HF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 03:05:58 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540764601; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPlkdBE0X//3GHvuvtwUDg69Qnv6/aj8m9gf6/O+P44=;
        b=cLeaZ9GWRzIiC8BsI8UKd+BEQJJeeWyt+2PADTJKlKMwJsooYBfEc7yNIOineXFaFZs3Pc
        1G+zW5oWYJHJ4bBTDXvm4i9yihjyOQ/j1CjnJeW5hEu96THxLJnHLZVyga8QkGUgqEo57w
        5/0cs/1DlL4S+GkjfP+UywaxvyBVy+5BqKq+tqNQ5YqBi4u+ZvupEvtRytILT3dVPec4eM
        0M8I47GPpTynZFayL8FUjeDnzyTdQHjppfvU8Eq3mHdDolXMZth6GLqrQQy+tkduoVpie7
        O0IL9/pCd2mWD92HgXbrymsJve2jhCKg4U74/x8zhqtGnFSODFT+h8qpLaLxPg==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH 7/9] w1: use __func__ for logging the function name
Date:   Sun, 28 Oct 2018 23:09:26 +0100
Message-Id: <20181028220927.56227-8-post@steffenvogel.de>
In-Reply-To: <20181028220927.56227-1-post@steffenvogel.de>
References: <20181028220927.56227-1-post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540764601; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPlkdBE0X//3GHvuvtwUDg69Qnv6/aj8m9gf6/O+P44=;
        b=kj7eJU2zc3ivbVbC+yy/sTQfASOLmPoybHhmVJkUJt2hDrzyWzDDv50NaMc+oB/4drYhvi
        wQeAKiGWOAIigVE3g06N0UiDijUJONipCxLRahJWWF1C+stEH07C3oCdlRtJ4ZR8Q9cCIl
        klZ4NRfrjgzuk1c9L4NpIROiwZc3fzkIFwhKOSJlPYIemJJ5vas8UpfpYm50j+tyT6KpD0
        hNdfD0LuuBz11JV1aUarL9xTnNHMtEz0MuVMpVaJyX4Py8TrdnmuUvC5KB3/LpVHHPjTDA
        KzHfDWXLgH6bcI8TX8b+Q8to5hVj3/n/2Uwy2NtxObu4xDG8XmBvHvcW4D1r/g==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540764601; a=rsa-sha256;
        cv=none;
        b=C5g8k34gL3xCGlj23o2Nj5YLiAMc2ef2/0m2z/Xow3MccWsufs7P3NVuPa7p4PYttDqaO3NvcKVSN1lon+galARV79hfCbjWk5nYlf/fQ3ILo77jfl0wh5Yb3c0hJNz65d93YukfjkgYCl4n6ie5uxPPg4l8E9Ip4e9FpYt1neGNdJGAfiklzHKP/lIjypbF4En2bTlJwiY52BIQedSy7JrWQbm9sa+lPAuhgbmYEYcwxjjQssRvewMtEIPb6AWj8cprgRghuq/IwZn6orIcLbnEuYcD6dzotsA8Aaz2Gg64XShjlSq19NIFhVIit17cZ+mHBUzl6RlSxwCKxO0oQg==
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
 drivers/w1/w1.c     | 3 ++-
 drivers/w1/w1_int.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index e8ce97e066ec..c790c79352a0 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -1053,7 +1053,8 @@ void w1_search(struct w1_master *dev, u8 search_type,
 
 			if (test_bit(W1_ABORT_SEARCH, &dev->flags)) {
 				mutex_unlock(&dev->bus_mutex);
-				dev_dbg(&dev->dev, "Abort w1_search\n");
+				dev_dbg(&dev->dev, "Abort %s\n", __func__);
+
 				return;
 			}
 		}
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index dd34d6a33f50..694b61ca1f85 100644
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

