Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B64ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EAF2150E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJVKb7Gn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EAF2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388460AbeIUCbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:31:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46972 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeIUCbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:31:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so9629856ljj.13;
        Thu, 20 Sep 2018 13:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VLIItdANeR2HXKjAG9ooHkEQ/2j2hSQ7yUwph6rZVTY=;
        b=sJVKb7GnxRPtd57abFhTfa4+FwN93PPqVDdFEobTRTpkt1Y77Iqno7qQX7yMrz0DCk
         A2z2nHgV7zJwsjCHt5C29azHNmRvvEnFPk7XZ+GUksTlPhTkGPAr/YqUkNqXQOQQcVnS
         yAXXNGwO+bc6dmwNprarufLUkGdRUbIQwds+v7qR4F+K6pT2uhep+0T9uTByeTQmdlbx
         SlcGDkq4nY5ooQwhHpf1XMnC8VhWPX43bu0onS81Bxw4I+xUxk2+dGBkbS57k3x5JqWX
         8lli1mCzhrVCkl+sXZLinp9c/GALiipToiuwH9eEj9J1QCCv3OdNe1CeXa522TSmteaS
         LkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VLIItdANeR2HXKjAG9ooHkEQ/2j2hSQ7yUwph6rZVTY=;
        b=igY3fEMK4vBcJWSpkG7Qkwm7kQWN7kjAsg1imyAFgNcbqHAkhQDAnw8wXyR6knx5X8
         KNwv+ZlsfCC1PQtSQvS+WLmsTcbQc5dR7NadkfauqoRXLjKtARwFvDP3YiNomRfkrCAa
         3q4Nhcfq60AJU+EF9Sn6U0ZWYt3s2QDZsIc0rF9mQlDWg9aQeJDJKpZeLF1iJkJtn7v+
         V7MrTis1Urb1hsLDnS8eawGJ5yIt3HoXIiCqFLymMeRQ+3eMV3RgQtc6jYziRs6Vq0V2
         4R2oosPrVvRRV/O14iYWUKXGzzYp/WJUJClPirc6Wa1Te3WeSqCiutRO0YlkzvR7TbAu
         A3NQ==
X-Gm-Message-State: APzg51DiCWQdJ8qASOYlywbWS8YlIImpuDhh+NS7zoMhbLa13C+OrCT8
        I/e9mX5Qz/0gGels1gWicxc=
X-Google-Smtp-Source: ANB0VdbYRnpfCP4IrogeE+C1saL7En+g+S4gmGuqjelmU/1n0GY5b/5BqH4bWdpTHM+6RNAi8v4EDw==
X-Received: by 2002:a2e:5614:: with SMTP id k20-v6mr28859557ljb.48.1537476347254;
        Thu, 20 Sep 2018 13:45:47 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id r23-v6sm4470355ljc.15.2018.09.20.13.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:45:46 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: [[PATCH v3] 2/6] [media] ad5820: DT new optional field enable-gpios
Date:   Thu, 20 Sep 2018 22:45:36 +0200
Message-Id: <20180920204540.28832-2-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920204540.28832-1-ricardo.ribalda@gmail.com>
References: <20180920204540.28832-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new enable-gpio field. It can be used to disable the part
without turning down its regulator.

Cc: devicetree@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 Documentation/devicetree/bindings/media/i2c/ad5820.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/ad5820.txt b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
index 5940ca11c021..9ccd96d3d5f0 100644
--- a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
+++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
@@ -8,6 +8,12 @@ Required Properties:
 
   - VANA-supply: supply of voltage for VANA pin
 
+Optional properties:
+
+   - enable-gpios : GPIO spec for the XSHUTDOWN pin. Note that the polarity of
+the enable GPIO is the opposite of the XSHUTDOWN pin (asserting the enable
+GPIO deasserts the XSHUTDOWN signal and vice versa).
+
 Example:
 
        ad5820: coil@c {
@@ -15,5 +21,6 @@ Example:
                reg = <0x0c>;
 
                VANA-supply = <&vaux4>;
+               enable-gpios = <&msmgpio 26 GPIO_ACTIVE_HIGH>;
        };
 
-- 
2.18.0

