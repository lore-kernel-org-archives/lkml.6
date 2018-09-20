Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5799ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE3621531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uDTpu5M3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE3621531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbeITWDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:03:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39114 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeITWDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:03:35 -0400
Received: by mail-ed1-f65.google.com with SMTP id h4-v6so8353435edi.6;
        Thu, 20 Sep 2018 09:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ss5zDbLVVTieLcNOaPlahFyyALIdwzonzBdsnOHzuL4=;
        b=uDTpu5M3khv84mZ9i/0+iUa0iLQIStswIeuYmSJdv1KLDXrABsLNPjM8SmnMUZ4R70
         uOktf47tKmT8TxSiLBMioCuN/qaFpOjTKUZ/MDRQ6IhP/k8qM4GzIl5TttEaWuFLvqSh
         nw5TVNtX0dj3iw/zjQstD/FmvTWE09quBh5lrJHWP1xoOf0N3REEFmRln+AotDEUX8kF
         7sKpijA47l05akqsFApj0N1gTQJJ/87hDjJIFi/Ccqo7pJyPLv6G66zIggL57bip5IAS
         eF2dDFMqsHhJDtTCpe3PLDsixHn5H79gjqw598TgQafhhFvQ50k0Q+w0rIWR66vKqYJ/
         5zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ss5zDbLVVTieLcNOaPlahFyyALIdwzonzBdsnOHzuL4=;
        b=ZnuIynbcXVbdQeqIZP4+mv8bOgIqinn7gZeZMG0EnVIhjkJYGHGANjMtbeatGa6tlc
         RMv2aw5HSQSXBye6XUY6wm92e546EcobJaaAlexuMCjiz0ExiLDTxK79k4F8LCc5Ab8v
         kLeGbJ1Q62dYjGTowA6cjzQieUwBLv3PB7nKr9I7iswzK7pe8RzjaRe/pFMPLEDXGea/
         lnk12IU0+iffjdnxVaoUeKdxzjmCYUyHiMMgWDgTzPaBCp6+UUHt73rAy6Bras9TvJ07
         IX1S0ZMH3ypJF8k7tvlrJxQEUVm4wcRPsGXfPhll2GOsrMLq7kVnPTtERkbGG0jvpXYs
         MfPQ==
X-Gm-Message-State: APzg51Ck8SrH1VK1x3ho6cCYR+3QX5Sgvwlt/5bgpB3zsZBktuTaS389
        LER3mtIUzIVBVsB4mJQ2xVw=
X-Google-Smtp-Source: ANB0VdYNpPtb3R9tC0IbiOhQFNC6xXSV5UIMD9O9nboizYNCGvfblIULjF58+oGAFjLRUfxP/LnrGQ==
X-Received: by 2002:aa7:d141:: with SMTP id r1-v6mr5509240edo.83.1537460360179;
        Thu, 20 Sep 2018 09:19:20 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h40-v6sm958144edh.88.2018.09.20.09.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 09:19:18 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 3/4] [media] ad5820: DT new optional field enable-gpios
Date:   Thu, 20 Sep 2018 18:19:11 +0200
Message-Id: <20180920161912.17063-3-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920161912.17063-1-ricardo.ribalda@gmail.com>
References: <20180920161912.17063-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new enable-gpio field. It can be used to disable the part
without turning down its regulator.

Cc: devicetree@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 Documentation/devicetree/bindings/media/i2c/ad5820.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/ad5820.txt b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
index 5940ca11c021..07d577bb37f7 100644
--- a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
+++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
@@ -8,6 +8,11 @@ Required Properties:
 
   - VANA-supply: supply of voltage for VANA pin
 
+Optional properties:
+
+   - enable-gpios : GPIO spec for the XSHUTDOWN pin. If specified, it will be
+     asserted when VANA-supply is enabled.
+
 Example:
 
        ad5820: coil@c {
@@ -15,5 +20,6 @@ Example:
                reg = <0x0c>;
 
                VANA-supply = <&vaux4>;
+               enable-gpios = <&msmgpio 26 GPIO_ACTIVE_HIGH>;
        };
 
-- 
2.18.0

