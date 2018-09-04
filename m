Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3743C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEEF2086B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhfZggvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEEF2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbeIDHIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:08:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44034 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbeIDHIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:08:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so873202pgp.11;
        Mon, 03 Sep 2018 19:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dyMlBOGeR+D0F4OT1Om3Yr3zP9Ae/55Ycb8svx7U5Mg=;
        b=QhfZggvx83W0O89c3yAbEiVMTTX22/0zyGMRqaMmINsTlxO+cP0mDSJvTqhJWWs8Uc
         PgNeg0xfs8gRwIOvLy7yuiFv93VFaQhjvfqZjWv1dwM1zErUvPvlFN3Bbs1g2hjjXJAQ
         rDynjHDzeg32MCnqCx+yXuGdPnu5bQSQ+RfVAGyS+1q8KhF+gHg6lEQcJfUgW07HMeNI
         jReihwOr5iC432Htt06o1rVB4BgD6Kj0BPRlbZig+YBxuAjnWo3gwcF8J/J7nkNkamr+
         yPAia5tAa2lSHd6yLaYHwOYf9Lmr537UREYwR+wVU5WdfFdrEnN9Jpi7hJOAWOdlwJFQ
         XKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dyMlBOGeR+D0F4OT1Om3Yr3zP9Ae/55Ycb8svx7U5Mg=;
        b=ijACANGwfnyoiUy5ldReh9kV1CuMWPl/HkIcNrTDvn2y6yqZD3UP0SgcKHDoXvRoCb
         bOQ3YonLtwbQSFTNSvBjypyNYxcedjPq4Lz3axyrWtcgkNJeGtshGi6C7L23rhmO79Qo
         BA2nQHwi8h3x/5SJOOJoZBa9gx7DYJDpuUWdmMz7flrdwvYqaN2vP6DhASUDxmEB0oqF
         sZ/6MVxmmBqG6sApEXe9ue3qJegM1BeJNUDeQ1S3ESrYiFR/e5Ww/B9E9+3FbmfWOaYb
         1ivNkrQjU5J99KkYgsDZNAxm5uSRqlAJqcwpqYQmcypsF+D6+v2bGbEEil4XzQ9OmYKI
         Ci9w==
X-Gm-Message-State: APzg51AqbJwrZoZazbrgQSRuhJ0ZRlTCOX7lXbOnkKsrrzZ22VgQIflM
        5Yi6Epm5IqxveUnXd6AO7sk=
X-Google-Smtp-Source: ANB0VdbBB27REFELXmkSR3Ls51IBSoxSFVaXs34gzAubu6s7F3RUZ7R/r+859kfbcPLm7bwqyj9HKw==
X-Received: by 2002:a62:3545:: with SMTP id c66-v6mr32459487pfa.63.1536029141033;
        Mon, 03 Sep 2018 19:45:41 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:45:40 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 09/25] tty: serial: kgdb_nmi: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:35 +0900
Message-Id: <1536029091-4426-10-git-send-email-climbbb.kim@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since tty_port_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/tty/serial/kgdb_nmi.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index 4029272..ed8f806 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -234,7 +234,6 @@ static const struct tty_port_operations kgdb_nmi_tty_port_ops = {
 static int kgdb_nmi_tty_install(struct tty_driver *drv, struct tty_struct *tty)
 {
 	struct kgdb_nmi_tty_priv *priv;
-	int ret;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -245,17 +244,9 @@ static int kgdb_nmi_tty_install(struct tty_driver *drv, struct tty_struct *tty)
 	tty_port_init(&priv->port);
 	priv->port.ops = &kgdb_nmi_tty_port_ops;
 	tty->driver_data = priv;
+	tty_port_install(&priv->port, drv, tty);
 
-	ret = tty_port_install(&priv->port, drv, tty);
-	if (ret) {
-		pr_err("%s: can't install tty port: %d\n", __func__, ret);
-		goto err;
-	}
 	return 0;
-err:
-	tty_port_destroy(&priv->port);
-	kfree(priv);
-	return ret;
 }
 
 static void kgdb_nmi_tty_cleanup(struct tty_struct *tty)
-- 
2.7.4

