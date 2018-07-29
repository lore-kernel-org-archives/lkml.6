Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E19FFF05E1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E987220893
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVDG5vKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E987220893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeG2NLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 09:11:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40021 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeG2NLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 09:11:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id y9-v6so10513836wma.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 04:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=nvsGOH7YmAFSXyaHcW7MA7hPN1IVfEbQcaeYIoY45Sw=;
        b=jVDG5vKQD67/qqzhN32r8qrwYIAx9wawt0n8u2L0Zwio8kxs3URuOXitKuRwqNHqIr
         +aINNt2drckpCx6xOfCsDeE8gqDrAf1we+v5nf0MJFpcaVllg8a40Zjo/UfMA6919CRX
         om72Ij9DWCHrzTw7hkIMWYD+p37R1k94zuWviKyjC59Uttn0lDKgKjvsBU6PuoC4SlpO
         /R6frw3r5aqrSxjPYz+aXS/5+CV6uNXZDvyGWlJhiNnCycGIJsmflMSbDMVdFtopaTa9
         08TUwRg157utY0iM9nReRVKeh2q5ec9lHTPvOLZtXGIBurVIF6PIf8ej5TS8fmkDhSRx
         /3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=nvsGOH7YmAFSXyaHcW7MA7hPN1IVfEbQcaeYIoY45Sw=;
        b=AN2xHaHXCrVDOZ3ofNvgYfi7sRds5sOjumRFoLdh3xnMgh9k2T/HMB+hLTtD7F1OjN
         FKkMSVcPatOyergwIARsh6/Pyb6CuuFS/OjKaKs/YvdJEy8/C+2IVvgl+QmW+qQTlddU
         WHNSmli6vf1fDCulWeOCITCbXzVkYK825fDh5i42BHMiwPwIk7G9P2YW846MR597qcwT
         OOzGE2n8zpHahfUTR7pAuGccgbWlXzC3ivTElIIioPRJ3tyOIwcvJtg2KGApkYNJerj1
         CLa6JEfvc53vC5dzVSpSIRk3zNzAQbUr3D9AGZNe78Fr2wiShlTsbmwZEB42ACfRc1a5
         T5Dw==
X-Gm-Message-State: AOUpUlFSyZUB+D9KFb5NWwDu1StLc77dNSVrMwLXLkVrl1gHLLwSNtDP
        Uj5Or2x/VCl02fawLERTvbQ=
X-Google-Smtp-Source: AAOMgpd8E+z9jWt8+p3ByZCsGYxttehvScuydx9lePx6y2xcY7jXtTyOIYDB2R65FOE2P8N4x7nlxA==
X-Received: by 2002:a1c:9755:: with SMTP id z82-v6mr11482548wmd.104.1532864451660;
        Sun, 29 Jul 2018 04:40:51 -0700 (PDT)
Received: from we.local (ppp-2-87-92-87.home.otenet.gr. [2.87.92.87])
        by smtp.gmail.com with ESMTPSA id x184-v6sm10227597wmg.24.2018.07.29.04.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 04:40:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id E18816403C9;
        Sun, 29 Jul 2018 14:40:49 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bo_cOY-e0j1p; Sun, 29 Jul 2018 14:40:48 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id A2FB66408D2; Sun, 29 Jul 2018 14:40:48 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] Staging: octeon-usb: Change multiple calling of CVMX_USBCX_GRSTCTL
Date:   Sun, 29 Jul 2018 14:40:34 +0300
Message-Id: <d2799c79835e21fd0421fc50189a6ea631fd7e15.1532864087.git.tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1532864087.git.tsotsos@gmail.com>
References: <cover.1532864087.git.tsotsos@gmail.com>
In-Reply-To: <cover.1532864087.git.tsotsos@gmail.com>
References: <20180727151527.GA2209@kroah.com> <cover.1532864087.git.tsotsos@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign to variable the result of CVMX_USBCX_GRSTCTL instead of multiple
calling a macro.

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index cff5e790b196..4615133292b5 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -598,6 +598,7 @@ static void cvmx_fifo_setup(struct octeon_hcd *usb)
 	union cvmx_usbcx_ghwcfg3 usbcx_ghwcfg3;
 	union cvmx_usbcx_gnptxfsiz npsiz;
 	union cvmx_usbcx_hptxfsiz psiz;
+	u64 address;
 
 	usbcx_ghwcfg3.u32 = cvmx_usb_read_csr32(usb,
 						CVMX_USBCX_GHWCFG3(usb->index));
@@ -629,17 +630,16 @@ static void cvmx_fifo_setup(struct octeon_hcd *usb)
 	psiz.s.ptxfstaddr = 3 * usbcx_ghwcfg3.s.dfifodepth / 4;
 	cvmx_usb_write_csr32(usb, CVMX_USBCX_HPTXFSIZ(usb->index), psiz.u32);
 
+	address = CVMX_USBCX_GRSTCTL(usb->index);
+
 	/* Flush all FIFOs */
-	USB_SET_FIELD32(CVMX_USBCX_GRSTCTL(usb->index),
-			cvmx_usbcx_grstctl, txfnum, 0x10);
-	USB_SET_FIELD32(CVMX_USBCX_GRSTCTL(usb->index),
-			cvmx_usbcx_grstctl, txfflsh, 1);
-	CVMX_WAIT_FOR_FIELD32(CVMX_USBCX_GRSTCTL(usb->index),
-			      cvmx_usbcx_grstctl, c.s.txfflsh == 0, 100);
-	USB_SET_FIELD32(CVMX_USBCX_GRSTCTL(usb->index),
-			cvmx_usbcx_grstctl, rxfflsh, 1);
-	CVMX_WAIT_FOR_FIELD32(CVMX_USBCX_GRSTCTL(usb->index),
-			      cvmx_usbcx_grstctl, c.s.rxfflsh == 0, 100);
+	USB_SET_FIELD32(address, cvmx_usbcx_grstctl, txfnum, 0x10);
+	USB_SET_FIELD32(address, cvmx_usbcx_grstctl, txfflsh, 1);
+	CVMX_WAIT_FOR_FIELD32(address, cvmx_usbcx_grstctl,
+			      c.s.txfflsh == 0, 100);
+	USB_SET_FIELD32(address, cvmx_usbcx_grstctl, rxfflsh, 1);
+	CVMX_WAIT_FOR_FIELD32(address, cvmx_usbcx_grstctl,
+			      c.s.rxfflsh == 0, 100);
 }
 
 /**
-- 
2.16.4

