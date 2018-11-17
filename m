Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0691C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 12:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3A320868
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 12:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZGPjinC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3A320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbeKQWbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 17:31:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39924 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbeKQWbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 17:31:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id u13-v6so1024178wmc.4;
        Sat, 17 Nov 2018 04:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f7+ys9CKOlgM83dy+2cdL8YJYjTGsxzQ/7CZyEvAiMU=;
        b=GZGPjinCwCDF/y5J5sIXv6zsxBijG18PkOOs+keGvdnSWiUiLQTHdqtLk4VcTrOoI6
         1Hsf3TRRPiVflbtLQThI5jZqbC9GvgfrTWBfCxKc32QNSo5GWgEwKeDc75IUB1wPA3Ao
         VbaWiqoGLmnf3ZoM04YotiOmzTBIuiqU8dXDOlcFqzg+qHjJ/7Ucx4/zxqeIfV3DbdUr
         SIi6lQeE6k8eXDkwTm42rPwD4LHwOSsMXZdqLog3wzRjaTdwp6qoAhU4mp7/vnCFOvoN
         vOqtF/2k8ZjZKvyQp4NFQxV1VeOlQPp0hYv+c9R20HZnBl7b72CFiCt4A+3X4hR4UONj
         jiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f7+ys9CKOlgM83dy+2cdL8YJYjTGsxzQ/7CZyEvAiMU=;
        b=VO9CMV9CtOUaiDGUm13c4KB/ES9nC+s1X/oTqWQefEX9CkGG5OudhAg9geI/xHmj7+
         +EDBt3hy3fMgg2dKkPAl8HGDn6/Li79fyh1NigvOggv5tcz0R+rSna7joql+wCQDONNV
         a5QL/tGi++E1Sdx2g1zT4on5FmcDXZdSdnZEbceYaVbAHkFDcKaBWHomie4bmvIAhK1N
         gF4BwMf1RDYUw3+QOteOgrtyFKWiUetCJF2M+FN+CZoUfWxYXkwpyoNTH0un/f3x9r0q
         8FdPLC6W7S6uznhBCdzWGpmIYKSiK+/0RrwPSxbfYSYtZPXIup0mmT+5q+gHSsZ3x1+p
         FQ9w==
X-Gm-Message-State: AA+aEWZCK3geEySUhiZjceAeLQKpZJIbB4XvygUcl/O6TmFWvWsbV+6K
        VvhRwjltJHQniFJ45end97E=
X-Google-Smtp-Source: AFSGD/W+cSfVQmntFV9jEub0gpKem11LGjn8YCqYnNrHkNUkzzElntq4N/DnMPvbBtKBt2LENeaRyA==
X-Received: by 2002:a1c:84cb:: with SMTP id g194-v6mr1454499wmd.24.1542456901411;
        Sat, 17 Nov 2018 04:15:01 -0800 (PST)
Received: from localhost.localdomain (cha92-1-81-57-17-130.fbx.proxad.net. [81.57.17.130])
        by smtp.gmail.com with ESMTPSA id u14-v6sm42132213wrs.27.2018.11.17.04.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 04:15:00 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH] MAINTAINERS: add ASoC maintainers for sound dt-bindings
Date:   Sat, 17 Nov 2018 13:14:52 +0100
Message-Id: <20181117121452.6101-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sound dt-bindings are applied by ASoC maintainers and should be
submit to ASoC list in addition to the devicetree list.

Hence, add this information into the MAINTAINERS file.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0abecc528dac..62701e0135af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13930,6 +13930,7 @@ S:	Supported
 F:	Documentation/devicetree/bindings/sound/
 F:	Documentation/sound/soc/
 F:	sound/soc/
+F:	include/dt-bindings/sound/
 F:	include/sound/soc*
 
 SOUNDWIRE SUBSYSTEM
-- 
2.19.1

