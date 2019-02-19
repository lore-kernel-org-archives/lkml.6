Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36CCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17C120823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1QOqPHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfBSND3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:03:29 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43497 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfBSND2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:03:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id m35so12691936ede.10;
        Tue, 19 Feb 2019 05:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4otjqvATyvxwtVAjMO64Wyk2yKEX+nv7+hkGyQumr8Q=;
        b=h1QOqPHxb0dQS+i1scczue+yDCPTQWMTBzaoASbFniIE0ODG40vXqeIzi+Pq0rz1Pt
         A7YKhhJNlRDoAoz0sFPc4wkwIKSCmFMuojSewnexBiYUzm8MrqJlnukvjaifafdSRwlm
         qeIhew2m+wtB4chjLAYenrPbUUS9qgAGha76UnoB+fYUF4u1jBKvm6cmwnmcCx9tBUOE
         pmEPgCP+ecrqcUKj9Iy7wMY40Z6LyhlQlRtJPqIOscY/UuIUnw3hD/9CEZnHMhJzctRM
         PsaBC3lcxgrREHZ0p8hTnrfMOgPRPBRrYFo4G+nJU62jq0xyXbNtxBMGN3N3pGZ10uz2
         9sBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4otjqvATyvxwtVAjMO64Wyk2yKEX+nv7+hkGyQumr8Q=;
        b=g5PVx4CSAX5iv8lAZYy6PumcTDZVqvCOpnZybFT0YmIguJ5J9POA/jVrvYds65qcaJ
         f70ZAMRW7PE9biu8cZ1Zz4gFV4hjW1UqMQafkcJG/msJlk/YMu3XNjNCUBsO5z6Fzxt1
         Dw7f3YRt42e6Jo00EKEq/Td0w8ohupxsxSl9KcWcxd9qwqoTpKnHIhE+QAyncKOWfqXv
         gpS+9BGyhvv3jE3FtlyE9fbQtuG28AeppbUsvBa6Fpn5oXVtLTsPP1CTwlsAbQisYYxJ
         VuB5QU6OzGhTl0nlenK/Qp0hnhk88Aj7bNACUP0X4zwoNFkdZuHff1d/Bj42yO73eGnY
         jjDQ==
X-Gm-Message-State: AHQUAuZ0gHU1zCOKZ+Fd2XYiotLDEouyHxlxy4g9LnQUQ0esqTUm+gIS
        KYpn4z+YPVlbFiPPbt3mhMw=
X-Google-Smtp-Source: AHgI3IZtJFi/bzGmxFTbDze/yTGnMZmPq4B8GqNOp622LvTMvtcFMSOQKD/BXMh0fO8vkhrgX9M9xQ==
X-Received: by 2002:a17:906:68f:: with SMTP id u15mr19903730ejb.147.1550581406801;
        Tue, 19 Feb 2019 05:03:26 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q3sm3707505eja.40.2019.02.19.05.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 05:03:26 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: remove disable-wp from rv1108-elgin-r1 emmc node
Date:   Tue, 19 Feb 2019 14:03:17 +0100
Message-Id: <20190219130317.2817-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmc.txt didn't explicitly say disable-wp is for SD card slot only,
but that is what it was designed for in the first place.
Remove all disable-wp from emmc or sdio controllers.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rv1108-elgin-r1.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rv1108-elgin-r1.dts
index 1c4507b..b1db924 100644
--- a/arch/arm/boot/dts/rv1108-elgin-r1.dts
+++ b/arch/arm/boot/dts/rv1108-elgin-r1.dts
@@ -37,7 +37,6 @@
 &emmc {
 	bus-width = <8>;
 	cap-mmc-highspeed;
-	disable-wp;
 	no-sd;
 	no-sdio;
 	non-removable;
-- 
2.11.0

