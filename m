Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2B9ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F0920671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rV6MwIhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F0920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbeGSRZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:25:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41606 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732015AbeGSRZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:25:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id z8-v6so4254493pgu.8;
        Thu, 19 Jul 2018 09:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=u3WSY+Dqmk901NKq74jQymBXziam1bu9mqo+Om8oHEw=;
        b=rV6MwIhcUKtkJFqTwbdq3aYhBWQMyE9S8R6g/sJELh/Q0skfw2xom1jIU1QvR8xArB
         WybVBT5G3gpxoEKQniWlXbMcWORIBy/GU72opKRuu/hTgpPlYq3NWNyy3c4cGKEXahOp
         XEG3ZtBA36Tjvsa0bESuGchFFM8Sx/WAfHATbTxpIbGd9nU++ufhY0OgTPVmbJOWmjxP
         wuiZdaBjzoSRVNS+NrSv9KqpBcBDvuehQB93B265yvaetShouHniq0JHu8un8SHqDNzu
         yyqMA0ebcJceDupvjb9xVnOycLQnConlqh4bZpfQUQGi4jp9EVwI+XHNjwngLrvQ1BVC
         0lsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=u3WSY+Dqmk901NKq74jQymBXziam1bu9mqo+Om8oHEw=;
        b=l5+Kn3jRAW0vT/py1M3iebYKa48EbtEL5Uw0+8PzO+usA3JMp+52j7e6/lZIyCWIZS
         jxqERZMMX6V9M2hAoAu+MbT92NfuD7tZfO0BfMtt3+crN++pmABFBC/c9/B1pspLjHdu
         siVZO2M29IgxQldWnAD3twqP8RnE5Si9W8XRTzJXpkGfqRQo01/bM0tBOvhkb8prjyAc
         SJoQZhnFw+5KucUEtBYYudDZwAsms5owyQqVdzvn/jY0EYMD100hAZgxEKGXdh7JGtbd
         lpvERzUITMkBFo65ywAXDFw4NY7XcVWxExFm1YIEU5roDeOHnB6BOFobjhMFTBuOIobC
         WZFg==
X-Gm-Message-State: AOUpUlFWXHo5VnUxf6WP/XoO0X4GYsHzAwsemqOiYUIeOWT3KzR0OBSK
        iiJW1CfX35ty7SbVO63yYaH4r7oI
X-Google-Smtp-Source: AAOMgpc7vL8xvoHGgOlEeX8ATFXoSJ8ntm55WUZCX+8y4HclSBbgrJefzFPxOAm4R6yLTG8hXk/bGg==
X-Received: by 2002:a65:6143:: with SMTP id o3-v6mr11032577pgv.52.1532018505355;
        Thu, 19 Jul 2018 09:41:45 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 86-v6sm17682473pfh.0.2018.07.19.09.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 09:41:44 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] net: phy: sfp: Do not use "imply HWMON"
Date:   Thu, 19 Jul 2018 09:41:39 -0700
Message-Id: <1532018499-16490-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"imply HWMON" was supposed to ensure that the SFP phy code can be built
with HWMON enabled or disabled while at the same time ensuring that
HWMON is not built as module if SFP is built into the kernel.
Unfortunately, that does not work as intended. With "allmodconfig", it
results in several unrelated HWMON drivers to be disabled instead of
being built as module as expected.

Let's use the old "depends on HWMON || HWMON=n" instead. This is slightly
different (it enforces SFP to be built as module if HWMON is built as
module), but it is better than the alternative of using "IS_REACHABLE()"
in the driver since that would disable sensor support if HWMON is built
as module and SFP is built into the kernel.

Fixes: 1323061a018a ("net: phy: sfp: Add HWMON support for module sensors")
Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/net/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index b7ff0af419b4..82070792edbb 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -214,8 +214,8 @@ comment "MII PHY device drivers"
 config SFP
 	tristate "SFP cage support"
 	depends on I2C && PHYLINK
+	depends on HWMON || HWMON=n
 	select MDIO_I2C
-	imply HWMON
 
 config AMD_PHY
 	tristate "AMD PHYs"
-- 
2.7.4

