Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9EAECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 06:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A83E20824
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 06:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irejrCuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A83E20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeJ1Oup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 10:50:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42337 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbeJ1Oup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 10:50:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id f26-v6so2440205pfn.9;
        Sat, 27 Oct 2018 23:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GsAq7xNf+bkdex0pSug1EkyY6fyBIT+YzZtQzWaglxI=;
        b=irejrCucbotLNOhehMN7qEI8tE8f6HKqHMYpCaQBN2WB+8BO5gMbv+/7N8gU5WaBpl
         vlGF8+6yB+9XQoTI47bwp4M+552I7/LaL/+ZH0viDogVSCb72eeLMpxuoAx/IYz1KwEc
         sRFgAlgpiMUUJ8FezkjxsPamNLmKXGXMMnrWkkNBkhZYdTQ5aa+lB01RChW9TCty0wX9
         445mIAVNqsD6AlnoSTVa1xZ9M0wqF1tu1mXR0l4VNIOJh/1Z7nrl6ZGqFpsEd+gbppMi
         JwJ/QAfOxEOrV+nf6Yy+mgcCA2ZEj2+9xTjaahqw88GUR2gFL2QqSSOBo4YeBJtHpCVz
         6/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GsAq7xNf+bkdex0pSug1EkyY6fyBIT+YzZtQzWaglxI=;
        b=Opi1J0xVKpbYflBFKmwDFF97baeum4g/VISGpSoFxI12ZWSCS1M035eW/d+f1qK8TQ
         8okgDpUnzJ+1LEUVEAqFTc9UYd3KB1X+qhGTncqxPEHM6nsDokKMWp1GuhvgjZFOUZQK
         T86/Sv0jQ486qWr7d8QwxwSMxYoJGG6OZjb6wWwrk/3LOhbloHX9v3TxzVkspK8hAVJb
         MpnPT1TWHTTvGW5gfEZgZPzEtlkNevaROZHvzN5mtu6BRq3BTZk1tac3vtn9mZG7JTfO
         r5+FzQHbwUa64DtVlgLJHK3gvMU/7yGgtU+EEvoDbR9p4TZ7Iw3+Sh5PT5X7oCYFOtrA
         +frA==
X-Gm-Message-State: AGRZ1gJgJOM6fTWwEU4M7xzEpxV3FLy9Y82YynIaDyyHtKtmLqCVDjHG
        TOM0MoDWIizOu5eT2mzJZ2U=
X-Google-Smtp-Source: AJdET5fbB3M28oLHNxFO2sPAro4Y4Brf+UAbaSWfX841rKRQKpcTtElcfCgl/ahoMjBJN238486qPA==
X-Received: by 2002:a62:1c1:: with SMTP id 184-v6mr10139358pfb.242.1540706828200;
        Sat, 27 Oct 2018 23:07:08 -0700 (PDT)
Received: from localhost.localdomain ([2409:4071:210a:547b:a60f:5e67:90:ea3f])
        by smtp.gmail.com with ESMTPSA id m25-v6sm8482793pgb.67.2018.10.27.23.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Oct 2018 23:07:07 -0700 (PDT)
From:   Bhumika Goyal <bhumirks@gmail.com>
To:     dvhart@infradead.org, andy@infradead.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     julia.lawall@lip6.fr, Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] platform/x86: wmi: declare device_type structure as constant
Date:   Sun, 28 Oct 2018 11:37:00 +0530
Message-Id: <20181028060700.22110-1-bhumirks@gmail.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of device_type structure is getting stored as
a reference in the type field of device structure. This type
field is declared const. Therefore, the device_type structure
can never be modified and can be declared as const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/platform/x86/wmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 04791ea5d97b..bea35be68706 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -987,19 +987,19 @@ static struct bus_type wmi_bus_type = {
 	.remove = wmi_dev_remove,
 };
 
-static struct device_type wmi_type_event = {
+static const struct device_type wmi_type_event = {
 	.name = "event",
 	.groups = wmi_event_groups,
 	.release = wmi_dev_release,
 };
 
-static struct device_type wmi_type_method = {
+static const struct device_type wmi_type_method = {
 	.name = "method",
 	.groups = wmi_method_groups,
 	.release = wmi_dev_release,
 };
 
-static struct device_type wmi_type_data = {
+static const struct device_type wmi_type_data = {
 	.name = "data",
 	.groups = wmi_data_groups,
 	.release = wmi_dev_release,
-- 
2.14.5

