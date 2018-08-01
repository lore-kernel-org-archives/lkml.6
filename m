Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52154C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DD0208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I12dzvwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DD0208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389641AbeHAQyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:54:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44174 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389461AbeHAQyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:54:55 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so17163415ljq.11;
        Wed, 01 Aug 2018 08:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GNK3eXIdRTNNvMEG9F1yQVWzPlIPhqiqOLRVnXsREfY=;
        b=I12dzvwiaexQIPDdOdL/ESkaVE+HZ5uZ3gN11KobL0EZDPIR7daoocKAY70OABZWxq
         xOQT/9As0+yy1aTbyZv/8ZL7wHxo5VWnxni/QFg/u+BCskxbkHaqgoTdInficTwwZYMI
         aOWrnUVHCxXIEDkqZTqrCsfT65fLyVLYoiaFilISpQlRmb36/TfbEWrQqqc8/rz9YfpH
         SqKTiBO0u8bCowPqJjtTv4EcdpUlmosh3BVhJ3c5pZ3mqFlP9YUbcJ33iXCV9HD5DIzX
         acZ9Bxcyiq1PEvJDgDR3TaF1xdcVY8BxIZFf1nPspJXTJPJ8OMhZFUaE28lxAXldoMW7
         5I5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GNK3eXIdRTNNvMEG9F1yQVWzPlIPhqiqOLRVnXsREfY=;
        b=M+eLItF8p7BNUiQF6BEpE+4kwnV0niTpH4QNFMFlrvqxl2pq60Ykglt5Ky3E2bk+Qq
         bmaRP//C0YtTA78mcaXFcQepTmOtDUysB0+7FaHvQNKMHPKzA3QbG7cQgE2iMho+ms7u
         i6FphAf48x/VTP81Da9KQbwWaeFODH/JKw+ke9beKaZSTXA2jt9z3ozu99i0xt1HK75o
         XJRhI/BsIW0Vz08Mhq723LnCrNyYD7QfnhidX9gY1FhDiGyMCUXCYcUDXlUWV4hbD8P7
         qNXous0v6SeSOCfRip2NTBqdzHdImP37gpUdB7p1VCr5ZS1B2z+tbha6vlsnzFhYOM5n
         KLaQ==
X-Gm-Message-State: AOUpUlHbiqL9TcU/07Pmw4Th9iMi1jZm8qr8Nn4tiQyudsD5XydRrZ7h
        ZDyU8pyNysJwQ11ZNW8N6dk=
X-Google-Smtp-Source: AAOMgpfJDNyL2Kb+Bp9uk4vyVnBL5sEhMP7i7C50gUps7M+el31dxacuhor3bTbRwclVJsq9JUKWMw==
X-Received: by 2002:a2e:6d0a:: with SMTP id i10-v6mr20875832ljc.145.1533136125147;
        Wed, 01 Aug 2018 08:08:45 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id g12-v6sm1004814ljf.5.2018.08.01.08.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 08:08:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Kyle Evans <kvans32@gmail.com>
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] gpu: host1x: Ignore clients initialization failure
Date:   Wed,  1 Aug 2018 18:08:07 +0300
Message-Id: <20180801150807.15926-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From time to time new bugs are popping up, causing some host1x client to
fail its initialization. Currently a single clients initialization failure
causes whole host1x device registration to fail, as a result a single DRM
sub-device initialization failure makes whole DRM initialization to fail.
Let's ignore clients initialization failure, as a result display panel
lights up even if some DRM clients (say GR2D or VIC) fail to initialize.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/host1x/bus.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 815bdb42e3f0..145019e105e4 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -199,34 +199,30 @@ static void host1x_subdev_unregister(struct host1x_device *device,
  */
 int host1x_device_init(struct host1x_device *device)
 {
-	struct host1x_client *client;
+	struct host1x_client *client, *cl;
 	int err;
 
+	mutex_lock(&clients_lock);
 	mutex_lock(&device->clients_lock);
 
-	list_for_each_entry(client, &device->clients, list) {
+	list_for_each_entry_safe(client, cl, &device->clients, list) {
 		if (client->ops && client->ops->init) {
 			err = client->ops->init(client);
 			if (err < 0) {
 				dev_err(&device->dev,
 					"failed to initialize %s: %d\n",
 					dev_name(client->dev), err);
-				goto teardown;
+
+				/* add the client to the list of idle clients */
+				list_add_tail(&client->list, &clients);
 			}
 		}
 	}
 
 	mutex_unlock(&device->clients_lock);
+	mutex_unlock(&clients_lock);
 
 	return 0;
-
-teardown:
-	list_for_each_entry_continue_reverse(client, &device->clients, list)
-		if (client->ops->exit)
-			client->ops->exit(client);
-
-	mutex_unlock(&device->clients_lock);
-	return err;
 }
 EXPORT_SYMBOL(host1x_device_init);
 
-- 
2.18.0

