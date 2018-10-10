Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244E6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC39D2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lkEGITLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC39D2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeJJPvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:51:22 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:54169 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbeJJPvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:51:21 -0400
Received: by mail-pl1-f202.google.com with SMTP id c4-v6so3247045plz.20
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 01:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8+1a8ZZqihK2vHlZpIte4kuE5OiT/BuRq57jfMWPqNs=;
        b=lkEGITLv2iUlKRRCxhinIj7MQ9Sq4c0NOC+gfkSr3wDX+znHPDelWQbBcN6NhqYdu4
         /qMEhTsf7dTuhz1PcditwWu7t1VnlhVupI7y92q20uoKDc7ENJZ9sHnwtwRtDaWP4aUP
         +DIN+7Jo4KZNHYWwurolAlOa26lov27qDu7HrkbWXCTFai84keKX/DRB4vLn+M3qvT8A
         Q9PK4GGYnDzFhF2Ei4XMqgqH0Pg1ueRBXNfa4Hul8i61xnfFo32Rv2XcUzFTFt05MR6B
         lAvavMphK7L/UbYZFQOS3QYHjs2swlOxtCRSEwDQru4yvLfxSGo0KcB63HXiok0jWunk
         WUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8+1a8ZZqihK2vHlZpIte4kuE5OiT/BuRq57jfMWPqNs=;
        b=r3SWqv6J71Z9LDSKTcHNpdHBCRMvRnhPSt2YO8edC2VSDleXleKbTeuwSYW2rBOdlK
         2QkeidPimZONYKij/WDRuVJ0PlKovHxhQ3pj3bYmKpSaCvpBtUGbK3K+hKTtjlnaGHuJ
         QlBirgovZe7vxNMpo7blJtUahfenIiEuSWyX3DzwaGn5iL4NihqTOh9gBeFiNlrKOret
         KFFyzyvIzyE115hmKhotTa4EA3PN2bBA3UdffwW9QZGaGmSjms/u1vMEtH8a5WIzsipu
         DGhORrKTVRuU1ndeQkj2RBpNycCleJ+nJi5wiyg+YhtYE0gE3fB8Wdq2Db0HTkxfwEf7
         j4yw==
X-Gm-Message-State: ABuFfoiyaAquBEWTdlol8Rjg6VI9WAIuEz3qK3X9qeVOzpRtTvHCyPrG
        ocoiOSw7qLjEDTlniATHQHueCx7aKkRLWZSpAR0vFKClDQUVAtIB7TpN5zkr4QE7gq2pJFtZXCn
        WGCfrWYOGQke0uIeXzGV4Zr7i2yTOeSDBcWPS3TUaOo3XdSIwP6uBCV4MvCqNWrLLqHETiZK+mK
        rsT263f7lPymXi3bA=
X-Google-Smtp-Source: ACcGV61/0pUgZc4dTE50+iqNzcH1/ePCNH8CqS88jp8LUOzo54siihJSReFkrAqpk2dAaquURmbHp2lvwXtDaHQD33F/Pw==
X-Received: by 2002:a62:5716:: with SMTP id l22-v6mr14500536pfb.40.1539160215837;
 Wed, 10 Oct 2018 01:30:15 -0700 (PDT)
Date:   Wed, 10 Oct 2018 01:30:06 -0700
In-Reply-To: <20181010083007.239938-1-matthewgarrett@google.com>
Message-Id: <20181010083007.239938-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20181010083007.239938-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 1/2] thermal/int340x_thermal: Add additional UUIDs
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Nisha Aram <nisha.aram@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platforms support more DPTF policies than the driver currently exposes.
Add them. This effectively reverts
31908f45a583e8f21db37f402b6e8d5739945afd which removed several UUIDs
without explaining why.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Nisha Aram <nisha.aram@intel.com>
---
 drivers/thermal/int340x_thermal/int3400_thermal.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index e26b01c05e82..51c9097eaf7a 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -22,6 +22,13 @@ enum int3400_thermal_uuid {
 	INT3400_THERMAL_PASSIVE_1,
 	INT3400_THERMAL_ACTIVE,
 	INT3400_THERMAL_CRITICAL,
+	INT3400_THERMAL_ADAPTIVE_PERFORMANCE,
+	INT3400_THERMAL_EMERGENCY_CALL_MODE,
+	INT3400_THERMAL_PASSIVE_2,
+	INT3400_THERMAL_POWER_BOSS,
+	INT3400_THERMAL_VIRTUAL_SENSOR,
+	INT3400_THERMAL_COOLING_MODE,
+	INT3400_THERMAL_HARDWARE_DUTY_CYCLING,
 	INT3400_THERMAL_MAXIMUM_UUID,
 };
 
@@ -29,6 +36,13 @@ static char *int3400_thermal_uuids[INT3400_THERMAL_MAXIMUM_UUID] = {
 	"42A441D6-AE6A-462b-A84B-4A8CE79027D3",
 	"3A95C389-E4B8-4629-A526-C52C88626BAE",
 	"97C68AE7-15FA-499c-B8C9-5DA81D606E0A",
+	"63BE270F-1C11-48FD-A6F7-3AF253FF3E2D",
+	"5349962F-71E6-431D-9AE8-0A635B710AEE",
+	"9E04115A-AE87-4D1C-9500-0F3E340BFE75",
+	"F5A35014-C209-46A4-993A-EB56DE7530A1",
+	"6ED722A7-9240-48A5-B479-31EEF723D7CF",
+	"16CAF1B7-DD38-40ED-B1C1-1B8A1913D531",
+	"BE84BABF-C4D4-403D-B495-3128FD44dAC1",
 };
 
 struct int3400_thermal_priv {
-- 
2.19.0.605.g01d371f741-goog

