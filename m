Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E395C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E28020896
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjUwiyRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391104AbfAOXHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:07:09 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37157 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390789AbfAOXHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:07:06 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so3971479edb.4;
        Tue, 15 Jan 2019 15:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UQAA3Ut6YFsPVuhZBWfqe7hEeAposMkejlSNoa7Mf8Y=;
        b=qjUwiyRLUKf7WfKrydQV0xFV8R5Bsu8dKuVOrpv39WO7/4CRbceXcNS/Gp/rwQ+Bfw
         h7Lz+RtGPyfoXuENkFkKBsa5YUXa6PsDWo7WzbKd/c/b5HT1GGJZaXqjh3JlCHR/X28C
         0e/DkmhKpVHjoMJFydH9g1Q1neGh3BdbEsvnFbOAJiltmdIwVztTvXhbVNYvcGrU4DMD
         7OPY5bUILzOHqejROQjt0UCDXmePBN58P2lXjbdJ//0q+uG5piipWajsA1yKOl5NOGzD
         qsSkxFfND7+tUD5ksqMzF1aRA7r9q1lDhfoGHptSmYdi06++KqBKj2DdEm434Lm/pBlc
         xNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UQAA3Ut6YFsPVuhZBWfqe7hEeAposMkejlSNoa7Mf8Y=;
        b=dlDkKe3zRmEqgT5jjcgvZ1rh8mU56YsZ0MIjVPygYMO+V9D2ToaY8m/OD5kcu/jw2l
         ppjFxZalLgD/v8TCI0Zb5wQoXPNcRxMXUuFH8/CEqFNOMSssRftPWCPctwteq5fVypF2
         uOwyqAT7C1wUK2fMDhO3iWAh4Zl+j/YVqRE9yir9EKyZTfkY1eqHVvj+zX7CC90Eiqia
         pGlSfjY3mhT9+ri05+iMNoJE8p7eGiy1Ds9xD6nL/obgdXLtmvpsZWa42tOXLDUQHnAe
         XnxweJ8Y/YFSQmxVFHmvltUqryM5wz+2n04suXb3ipT5+UY0rN0A5sVGlcRA/0VcQJNC
         o0rQ==
X-Gm-Message-State: AJcUuke3hUepZsoDw35l7sIogd3fHxKmyRhNvM22ihgMJi2Gj4xi6Xso
        JLuJdOQR0PJ3/b7V/lMp1mbArfOG
X-Google-Smtp-Source: ALg8bN7JnPCJuM1bTRgiyzGJV7bkmRHW/IHDYioKHPv318RLtooeaRQ2eBn6StjntxQiGISiklJurQ==
X-Received: by 2002:aa7:d35a:: with SMTP id m26mr5008869edr.244.1547593624494;
        Tue, 15 Jan 2019 15:07:04 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v14sm4872324edq.74.2019.01.15.15.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 15:07:03 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Marvell
        Dove/MV78xx0/Orion SOC support)
Subject: [PATCH net-next 3/3] net: dsa: Include platform_data header file
Date:   Tue, 15 Jan 2019 15:06:13 -0800
Message-Id: <20190115230613.28334-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115230613.28334-1-f.fainelli@gmail.com>
References: <20190115230613.28334-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

b53 and mv88e6xxx support passing platform_data, and now that we have
split the platform_data portion from the main net/dsa.h header file,
include only the relevant parts.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/linux/platform_data/b53.h       | 2 +-
 include/linux/platform_data/mv88e6xxx.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/platform_data/b53.h b/include/linux/platform_data/b53.h
index 8eaef2f2b691..c3b61ead41f2 100644
--- a/include/linux/platform_data/b53.h
+++ b/include/linux/platform_data/b53.h
@@ -20,7 +20,7 @@
 #define __B53_H
 
 #include <linux/kernel.h>
-#include <net/dsa.h>
+#include <linux/platform_data/dsa.h>
 
 struct b53_platform_data {
 	/* Must be first such that dsa_register_switch() can access it */
diff --git a/include/linux/platform_data/mv88e6xxx.h b/include/linux/platform_data/mv88e6xxx.h
index f63af2955ea0..963730b44aea 100644
--- a/include/linux/platform_data/mv88e6xxx.h
+++ b/include/linux/platform_data/mv88e6xxx.h
@@ -2,7 +2,7 @@
 #ifndef __DSA_MV88E6XXX_H
 #define __DSA_MV88E6XXX_H
 
-#include <net/dsa.h>
+#include <linux/platform_data/dsa.h>
 
 struct dsa_mv88e6xxx_pdata {
 	/* Must be first, such that dsa_register_switch() can access this
-- 
2.17.1

