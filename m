Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DA6C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDB621738
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q67pAojh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDB621738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753388AbeF1EY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:24:57 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42824 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbeF1EYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:24:54 -0400
Received: by mail-pl0-f68.google.com with SMTP id y15-v6so230964pll.9;
        Wed, 27 Jun 2018 21:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4aA5gkPawph4ihVsUyuleYwkutE5XG84TkOJ1EXe07k=;
        b=q67pAojhLs80/Wx18niJh2bCqa94q7Cty4wnEqGLMgIt8gEeV4icR/cXhWQauaLXdt
         WT4gRbpeImobKgiWIsk6O+R0opJ8i304zr+5Iu+GYKQKEe0E29HVMYJ1m4HquyreFE6j
         EJz21U11jG0t7u+pq6mtd822yREcoSUIF9Y1C6xaZiSwrheNX8phVX6GDr2GEBN302eE
         ZyOgf1+E2wgYP6cbHTw0eKaYZP3bO3G+moc5Rr1EHsOAk9O2xPgvtCT3sg8qGm6y8xeO
         KLuEyWElov3DdWsx4WyZSYtRHH/wXkgdBFqqgGbfAjVS11FnHC6weHehsS0/Tk4fvxbk
         w6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4aA5gkPawph4ihVsUyuleYwkutE5XG84TkOJ1EXe07k=;
        b=oKDWsid/UaBmnzN/ZNW92cp2Wt4Cj/fJmJDf6vYwCm4ke7Pf447T0qvj5lMKE3LePA
         Yfbg+UoQM0kO6sb6sr4ssIrd9G6QghUvlw8IO1g1NJflPKh1RW4mFXb/5uAMlCLZpJx7
         97rFN5V2mqLuoiDii4GAlDmjXkZhYo8MV5oGsuRXb2LSEz27dVA6cMj7RZjEo3hsJvpT
         giHZdO4xHwlPaJYKpYmBIb4DoYW7r6t6hQlTYKNs0qeZdbPtOMhTskBmNpPd8JrhPXmZ
         FnhZpAn10ONs3af68xEV7lFtv68zRQxfOvL7jSTBeJZ/kruweuH0yha9AM1TEgsogQc0
         W7AA==
X-Gm-Message-State: APt69E1pXGgSvncbwSbkREEqytz9avQL7QSsRTkjJWDjoc470P/5UsQ6
        XDzo2CpZZO+6mLy5zsWb//0=
X-Google-Smtp-Source: ADUXVKJ6TSCv6gEEBIxwY1XGk/GDwZdaIe/PNdLSgeeowQXAhnsNq+wrFqx4A8HPeBXMMRqEOveCqA==
X-Received: by 2002:a17:902:28ea:: with SMTP id f97-v6mr8613078plb.55.1530159893368;
        Wed, 27 Jun 2018 21:24:53 -0700 (PDT)
Received: from localhost.localdomain (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t19-v6sm12328577pfj.169.2018.06.27.21.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 21:24:52 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>, cphealy@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ARM: dts: imx6qdl-zii-rdu2: Populate RAVE SP power button node
Date:   Wed, 27 Jun 2018 21:24:24 -0700
Message-Id: <20180628042424.12664-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628042424.12664-1-andrew.smirnov@gmail.com>
References: <20180628042424.12664-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RAVE SP found on RDU2 implements power button control compatible with
the rave-sp-pwrbutton driver. Add a node to make it availible.

Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: cphealy@gmail.com
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 48da4b15da09..869dfd8431a1 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -331,6 +331,10 @@
 			compatible = "zii,rave-sp-backlight";
 		};
 
+		pwrbutton {
+			compatible = "zii,rave-sp-pwrbutton";
+		};
+
 		eeprom@a3 {
 			compatible = "zii,rave-sp-eeprom";
 			reg = <0xa3 0x4000>;
-- 
2.17.1

