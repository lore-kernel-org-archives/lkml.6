Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B85C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D10F20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5E4+keX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D10F20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbeIDHJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:09:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35192 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeIDHJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:09:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id 7-v6so898844pgf.2;
        Mon, 03 Sep 2018 19:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oYYQC2lkr9IQJTqeFD66xCNBcnWgOnsYuLXK//u2PDE=;
        b=i5E4+keXmQBCY2tQQzXatN2SdOHTlREsIC2+XC3mh7qBzlx2WNNYNE0ijaHVZFriGl
         88IRFrIVlEnSux5+Mv5/5qPauDnpX0snK9IXMtVXPruvoRDXOmSI7A3u2//m6KrAmc+G
         CTa1NBlfR1of5pEi57kQcdEalChJGL//o8ka4X+7sh0RdNWrNhi2++Trmp0jDYrr/CgZ
         NkCKhgr2M/5Ec/n/10/ThXf0vIpkSHtsXVOB4oObVNNfAujltW+5vbvG/UreNjb4uGRa
         YvIMOQegFuZlBA59IKqnuJisn/u2nWiEKUHLcqGNye2/jpRawhFV6Mhv41E/55XdW98F
         FkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oYYQC2lkr9IQJTqeFD66xCNBcnWgOnsYuLXK//u2PDE=;
        b=Au7lVRxoWtImfDBNSfhFSffb4EtLMJZh/32gOHSzhINUebKfZ3F6SPxXppplnriKLn
         Kk6JcVifXmLy0nlsxNKNwdQYPuuFkTQDxz3vuX/4TAwsHxEE+qdXAIAxoi6mV/EqxWC1
         oTJEadjef0E7rEBREOPVtQVQ/oUgzvAioQ4EdG63bSPCwSgnVoDYOj3Dlpw3L0sbynII
         hYKKAllCaSpRPpPC0FRkCKpSGiUkHgPEXpH+jFX0R8nlL6E0bCEMlabPA5yLMoFKycND
         /IkoO2LLhhwVnOau+jkgtqnm3YFVZLg7KKAe3KVkPdb87Qw0jnJUdU8MTdiWqXW5SBOt
         C19g==
X-Gm-Message-State: APzg51DjOS9rNUtMDAnVsxvSoglM8arqcYSv8js5kAsavC3Q6LO9+K8f
        Okd3GcOG5DehQmlKMmyg5GOYEHWy
X-Google-Smtp-Source: ANB0VdaNzGMOvVi3szbnsElEHKQPH9pVeEOdXYDACzRxdD45PWZHuufItLDCgqLmRipNRGy8vt2iog==
X-Received: by 2002:a63:df4e:: with SMTP id h14-v6mr29246819pgj.300.1536029186942;
        Mon, 03 Sep 2018 19:46:26 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:46:26 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 19/25] staging: fwserial: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:45 +0900
Message-Id: <1536029091-4426-20-git-send-email-climbbb.kim@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since tty_standard_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/staging/fwserial/fwserial.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index fa0dd42..5134019 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -1064,27 +1064,21 @@ static void fwtty_cleanup(struct tty_struct *tty)
 static int fwtty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct fwtty_port *port = fwtty_port_get(tty->index);
-	int err;
 
-	err = tty_standard_install(driver, tty);
-	if (!err)
-		tty->driver_data = port;
-	else
-		fwtty_port_put(port);
-	return err;
+	tty_standard_install(driver, tty);
+	tty->driver_data = port;
+
+	return 0;
 }
 
 static int fwloop_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct fwtty_port *port = fwtty_port_get(table_idx(tty->index));
-	int err;
 
-	err = tty_standard_install(driver, tty);
-	if (!err)
-		tty->driver_data = port;
-	else
-		fwtty_port_put(port);
-	return err;
+	tty_standard_install(driver, tty);
+	tty->driver_data = port;
+
+	return 0;
 }
 
 static int fwtty_write(struct tty_struct *tty, const unsigned char *buf, int c)
-- 
2.7.4

