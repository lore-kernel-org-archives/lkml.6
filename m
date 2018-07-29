Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C06C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 14:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F71220873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 14:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g092kJLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F71220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbeG2QOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 12:14:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34074 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeG2QOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 12:14:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id c13-v6so9955401wrt.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Uy6gVihIWFflaCq2NaGuFSq3o/027m024flCb0MhFic=;
        b=g092kJLyuVmNC5NMgYA9DOXwd6Qbl2OiJCdKkXr9TT+vNeosI07uaRaTVLUfVOjAxq
         vqPLmPhF90CEb6zBukM2wXgvHnQ4st3Q6LhfyYzUxF9s5FkKvrVDFGpeErqLyYoHNm3B
         y69LjKuoYOKlHDWrTyn/agcN3FPgxNIE8qt3zSgR3ogxIxa+7ZuAJU4qpeBUHayDUSys
         KrVFUWoayyPvpa7m/FYxv3vCcr7sNFxrWkleE2D6MbKAN4WfwOLB9spI0TR9gylPGmbC
         RsG1DHUKMS7GZrzYFoRqSTww6fe1jrmU8gcTONCI8LHSNVHhxITAh1YmIHNM7839tTqo
         CJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Uy6gVihIWFflaCq2NaGuFSq3o/027m024flCb0MhFic=;
        b=MgiMWWOoZ/GqMb8WqYyGnNY4k0lnQ5pcbwvOo7LRXMtlFsvdgGy7XosQ7Wyq4YgyGA
         4PsFUlL32oggsbsAN9Xw+0Y//ZeDzMYyTLws1O3pC5wiAAWXKr98dEl4Bk/3lGqusL+e
         QodXJw5kg9ENUbmbhpK6nfWziwz+hUbGReOvYdNSQvm9HN55WpRTxMOjUYlCJq7JT7bf
         Zv5CCiRbSZbzfLodk5r2BsbhHinooXfKv3X9k0IrpAXDibFQPBG00LJEQF4WhlsZ08OO
         MGfmphA5JBxV7xOfAFSAwrQU++if5QpfQjHyJ0Hb0xZsbWOaRfv/B+c/xyF0SXVHw/cK
         ey2A==
X-Gm-Message-State: AOUpUlGfCHDoIexQwmpmv/7iLbSfbfJF0Sm3TpjWGm1qXDilQXjYre0j
        uU8CHHqWkbrzGKfrmkLFpZMp+IQM
X-Google-Smtp-Source: AAOMgpdNCnWC8cpBFyXV98pFu+vnPYSJLnLjpXR+HJGpDRKr8MXqeCHsGZTil2JO3FQyYgbmmyiwXw==
X-Received: by 2002:a5d:574d:: with SMTP id q13-v6mr13368249wrw.24.1532875443784;
        Sun, 29 Jul 2018 07:44:03 -0700 (PDT)
Received: from we.local (ppp-2-87-92-87.home.otenet.gr. [2.87.92.87])
        by smtp.gmail.com with ESMTPSA id u185-v6sm11513485wmg.25.2018.07.29.07.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 07:44:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id CEB3E6403C9;
        Sun, 29 Jul 2018 17:44:01 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5mBQi-Nd7m77; Sun, 29 Jul 2018 17:44:01 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id 222036408D2; Sun, 29 Jul 2018 17:44:01 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        John Smith <catalinnow@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: octeon: Fixing coding style for minor notices.
Date:   Sun, 29 Jul 2018 17:43:58 +0300
Message-Id: <20180729144358.3442-1-tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing coding style for a few lines that were reported to check from
checkpatch.pl in minor cases for alignment and ending with parenthesis.

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
 drivers/staging/octeon/ethernet.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 9b15c9ed844b..1e258deecacc 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -141,8 +141,8 @@ static void cvm_oct_periodic_worker(struct work_struct *work)
 	if (priv->poll)
 		priv->poll(cvm_oct_device[priv->port]);
 
-	cvm_oct_device[priv->port]->netdev_ops->ndo_get_stats(
-						cvm_oct_device[priv->port]);
+	cvm_oct_device[priv->port]->netdev_ops
+				->ndo_get_stats(cvm_oct_device[priv->port]);
 
 	if (!atomic_read(&cvm_oct_poll_queue_stopping))
 		schedule_delayed_work(&priv->port_periodic_work, HZ);
@@ -621,8 +621,8 @@ static const struct net_device_ops cvm_oct_pow_netdev_ops = {
 #endif
 };
 
-static struct device_node *cvm_oct_of_get_child(
-				const struct device_node *parent, int reg_val)
+static struct device_node *cvm_oct_of_get_child(const struct device_node *parent
+						, int reg_val)
 {
 	struct device_node *node = NULL;
 	int size;
@@ -818,7 +818,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
 			priv = netdev_priv(dev);
 			priv->netdev = dev;
 			priv->of_node = cvm_oct_node_for_port(pip, interface,
-								port_index);
+							      port_index);
 
 			INIT_DELAYED_WORK(&priv->port_periodic_work,
 					  cvm_oct_periodic_worker);
-- 
2.16.4

