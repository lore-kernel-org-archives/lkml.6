Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B66C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6E32083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niWbmHPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6E32083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeHaXiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:38:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35319 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeHaXiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:38:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so5961103pfh.2;
        Fri, 31 Aug 2018 12:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v7e8BnItS0oHKhQ58Td6x0aV5qhOBdmhW7/lG3E8LuU=;
        b=niWbmHPTvGW8gWGKyxCtwhVA55GffHeSZxIBlX/Fg/26FsHs/efM3+j4uU4DuiOdAG
         Hh5FONC6zzGsPTwORMIjrtSy0tgS0VMQ3jIwPeYRcqeHfapJCasYKgXhjeQcZh3x0j9/
         p0MBXpuBqlhm+lcOee/rlCzrWvGTvQBB872ci+Hrwp742mPFUwZI3yxwegWtpk97e8Au
         HxiiBmeAuPR6ZGx863HRiAZv0iFw88eJnKPmvkKqYMl26PPQXAR70q8FDdkUuvvkyiuJ
         ScsjwOkth+bH3YCBjYcva1sjdgvD+O8nN9F7eNV1dvMf4EhALf14lEr/PIlSP4h86L7j
         MQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v7e8BnItS0oHKhQ58Td6x0aV5qhOBdmhW7/lG3E8LuU=;
        b=V/hvGqTh/7WfBdHjliszKpfZkc78qISAlvjmAiDLXdUpGFdgvnywHnH5cnE9FhP28E
         cdVDPDJR90qvZ+01yC9N++GSnJw2GjSDwfaFZI6E3v7b54obcCs9MbCWgJ5oSP85bCy1
         ZvrUnknM3eKI75BtQfBn/QxiQ2FoZ5zVoSHkPWwUgsVLXrPbdH3BGOLSeefbHskyUXhP
         hKPL2PRptgdMlS0GuQNx0zIogQG0RdiovvL0ORJGDVkyaVQVmjEICrZ02xhUPTAywYgB
         pcwxF2MCMNHQoXBoMlGdC6R1IUM8wU2VJzpfMONxdDmRHDUQ1XsIRek8wXikG+5eg1pt
         ymng==
X-Gm-Message-State: APzg51AgGi8FGEbeN+X+XORCAYasBqoH6FGszoFC7g6j/V6CIMxzPnVI
        OnhqESHUhM6JVgC+8U+3B5qzAPUV
X-Google-Smtp-Source: ANB0VdaSzlIc4AKT8YCQDFyVPmfOlN4CJjMI6lCih6Kdq8dDqvDqLFVLVSHZfXz18U7ynNYoApbZ7Q==
X-Received: by 2002:a65:6143:: with SMTP id o3-v6mr16128653pgv.52.1535743795520;
        Fri, 31 Aug 2018 12:29:55 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id y4-v6sm14452519pfm.137.2018.08.31.12.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 12:29:54 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: dsa: b53: Provide sensible defaults
Date:   Fri, 31 Aug 2018 12:29:49 -0700
Message-Id: <20180831192949.13195-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SRAB driver is the default way to communicate with the integrated
switch on iProc platforms and the MMAP driver is the way to communicate
with the integrated switch on DSL BCM63xx and CM BCM33xx.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/b53/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/b53/Kconfig b/drivers/net/dsa/b53/Kconfig
index 2f988216dab9..37745f4bf4f6 100644
--- a/drivers/net/dsa/b53/Kconfig
+++ b/drivers/net/dsa/b53/Kconfig
@@ -23,6 +23,7 @@ config B53_MDIO_DRIVER
 config B53_MMAP_DRIVER
 	tristate "B53 MMAP connected switch driver"
 	depends on B53 && HAS_IOMEM
+	default BCM63XX || BMIPS_GENERIC
 	help
 	  Select to enable support for memory-mapped switches like the BCM63XX
 	  integrated switches.
@@ -30,6 +31,7 @@ config B53_MMAP_DRIVER
 config B53_SRAB_DRIVER
 	tristate "B53 SRAB connected switch driver"
 	depends on B53 && HAS_IOMEM
+	default ARCH_BCM_IPROC
 	help
 	  Select to enable support for memory-mapped Switch Register Access
 	  Bridge Registers (SRAB) like it is found on the BCM53010
-- 
2.17.1

