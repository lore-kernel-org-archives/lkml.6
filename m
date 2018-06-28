Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C2CC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B132426F3B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itMqOnw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B132426F3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753465AbeF1Fm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 01:42:29 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42493 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751525AbeF1FmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 01:42:25 -0400
Received: by mail-qt0-f193.google.com with SMTP id y31-v6so3736041qty.9;
        Wed, 27 Jun 2018 22:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wM3VxFZKwRDD9WlsyKowGnluQOxmuCRsOKHVPyKf3u0=;
        b=itMqOnw+RWKnji9TWwEsLuYV/4eAmNglgkKOe5vUiYTYpyGLkVgthnV/tuZuVVWp7P
         s/AIst9M9B/qmyfWpCH6C6YFs8negP2SbOAyafCKJI5lqaeH9ejzLO9wyuRE2U4ilyex
         cDvkRSkgYoI7HZ87wBMcRbCCq9YHlWoVJzQLFqNfv+zwIlxXOw3qKOf0EKRJfAiDh/WL
         KWW6W3zok9BETVcz8FlooH2YqE+0DB4xplA4V+a3Cechv+egYDqmzAiq25Z/gsbtdiXW
         9INmHx5bdxlW6DHaeYOcE74Ma4wTf3H673W/iS8iiJtjLG/W7rJkCknGLmhWjD/CedOg
         Movw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wM3VxFZKwRDD9WlsyKowGnluQOxmuCRsOKHVPyKf3u0=;
        b=Aw8goSNf+7XPBGFCwEha5J+qKnFz/CVNdVeDMyC+R+3zHaovH4VmL0aDX72JuANYrN
         ci+HWebrFQnFmUG/EpZc8TBwuBRmFYURNuuDxeCjz1FzqQk4m9Foke2VVrJsWgV73ldL
         HP6y2Fi+RIqLv/MbrAvbCVF9l6AGnkPqnNN85eKJqVi8kOtzHYE1Ipzu9whyMDvK7oI4
         9HGtiV2O5ksqWmmmCo4mMT2tsIGAFuQYB95tTEAljfUJtF9hEzXeHRxmkhDAqZTZzmiS
         6riNxhxcLxjZ57LBiF3witXiIW2mqBAu7ent2qtWohes4NQhjeGRVUaO0/QhBAQP/2kO
         u6ng==
X-Gm-Message-State: APt69E12DkyBl+AuSgH0dj/VBWoZfxxAJ04egBGRx2nj1XhPV2TKmIHl
        tOuXeSBXucqNlwMB5/uml90=
X-Google-Smtp-Source: AAOMgpcAZMy/PyD1RZ1snXWW81DpNyhctXJl+KQX0CJ+d5or2we1PmxY/5ZhvaQwqoFOl65S4jGJ4g==
X-Received: by 2002:ac8:7158:: with SMTP id h24-v6mr724772qtp.309.1530164544573;
        Wed, 27 Jun 2018 22:42:24 -0700 (PDT)
Received: from localhost.localdomain (186-106-135-170.baf.movistar.cl. [186.106.135.170])
        by smtp.gmail.com with ESMTPSA id u40-v6sm3410281qth.24.2018.06.27.22.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 22:42:24 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Araneda <luaraneda@gmail.com>
Subject: [RFC PATCH 1/5] arm: dts: zynq: Set correct manufacturer for ZedBoard and MicroZed boards
Date:   Thu, 28 Jun 2018 01:42:01 -0400
Message-Id: <20180628054205.17737-2-luaraneda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180628054205.17737-1-luaraneda@gmail.com>
References: <20180628054205.17737-1-luaraneda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both boards are made by Avnet, Inc.

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---
 arch/arm/boot/dts/zynq-microzed.dts | 2 +-
 arch/arm/boot/dts/zynq-zed.dts      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-microzed.dts b/arch/arm/boot/dts/zynq-microzed.dts
index aa4a0b6de..e40f40a7f 100644
--- a/arch/arm/boot/dts/zynq-microzed.dts
+++ b/arch/arm/boot/dts/zynq-microzed.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "Zynq MicroZED Development Board";
-	compatible = "xlnx,zynq-microzed", "xlnx,zynq-7000";
+	compatible = "avnet,zynq-microzed", "xlnx,zynq-7000";
 
 	aliases {
 		ethernet0 = &gem0;
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index 53c6883ce..98381cc85 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "Zynq Zed Development Board";
-	compatible = "xlnx,zynq-zed", "xlnx,zynq-7000";
+	compatible = "avnet,zynq-zed", "xlnx,zynq-7000";
 
 	aliases {
 		ethernet0 = &gem0;
-- 
2.18.0

