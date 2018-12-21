Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD57BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1AF21903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="BCw1TAhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbeLUGW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 01:22:57 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:47786 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730440AbeLUGW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 01:22:57 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 71E83CEC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 06:22:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I6X28qb-0ZbR for <linux-kernel@vger.kernel.org>;
        Fri, 21 Dec 2018 00:22:55 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 2C082CDB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 00:22:55 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id t143so4018656itc.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 22:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wGtZfNJasqrg+h0S2KJmuayyWsNcKxQ9qHuxBYyew9s=;
        b=BCw1TAhiYQCRzhxlPu7862fBH2qDLta3arUn8XZ26kKxv6f283NZWa/9mKT4pNnyxE
         G2JpiaIl6Qee/Mzln8R53gnksnX1lE9Z4kIw1GF5vVZO/aIXJPoe5Xf4h9M5Fo8UmNcn
         f71fzt5MgUSoOPZJ6NYIpAd7pBpxrX4LYXRxBzfDNqYPi9QKd7GkrTHSls0FNsBluDJW
         NRcfayaMmpzevNr/MH+hIGT4z07HU7gdKn2fGiBwFgfZC+ct1Tz9y5vNsUs7G79Rqs3w
         2NSUCTEMAsNXvtFIYvd0je+CjMtm9SWmK77TunmofHofPth/Enjp7FBDKB+RRhvvc9xA
         O2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wGtZfNJasqrg+h0S2KJmuayyWsNcKxQ9qHuxBYyew9s=;
        b=Qwgt2OukaSfwQhGRLQkF30odzrkJdpAG222/B4pNNBDImlZzygt4T22+C/PxUJ9NdL
         RqAQ3W88xZhX3Ns6KOm7E9z7tyU+VT+YFuT9Syg7SzDrhlJ4ZQPeeN3zGqZUm11W32NO
         yQr3M7cd3hse0x9EBoX4AKOGLTsZPoaY9s0e2Ix2du4E02n6yCgLInZso3S9p9BXQpU2
         rS02sYGXEdoqMnwrRo6juhY+TTcbaHOvGTdlUXzvzvjUCiRcAPZ8J+prZNbps2qfqNPx
         JXeVuSAklhJ35MtnDl9ON2SalnZ6op4YTAhLlRVpxIehgcPsdoEfJ5437sQFUV26eVpy
         7oHQ==
X-Gm-Message-State: AJcUukeSqgnp5OfrmVRgw1IFBI1flYm81xB1ShKKLm3CCVD29udG7WJ+
        0VuVJoVQIL1oU6bp34XPw4JUmILMaE1SrF9yTtiOKLBy0h0QKjQKYYMxVICNVK1CEAVXgwEZY6P
        5h9zXLj0quTVgqu+xNLJidjpGM6OC
X-Received: by 2002:a5d:8d94:: with SMTP id b20mr727008ioj.180.1545373374794;
        Thu, 20 Dec 2018 22:22:54 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5ABZB75WkazL/NIVsGh5hy+bj/14usQUsikk4V5UNQI+D39RRCqQ65DG2OsIC0VRmV/6/RAw==
X-Received: by 2002:a5d:8d94:: with SMTP id b20mr727003ioj.180.1545373374538;
        Thu, 20 Dec 2018 22:22:54 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-23.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.23])
        by smtp.gmail.com with ESMTPSA id 81sm8481153itz.15.2018.12.20.22.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 22:22:53 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Manish Chopra <manish.chopra@cavium.com>,
        Rahul Verma <rahul.verma@cavium.com>,
        Dept-GELinuxNICDev@cavium.com,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: netxen: fix a missing check and an uninitialized use
Date:   Fri, 21 Dec 2018 00:22:32 -0600
Message-Id: <20181221062232.59789-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When netxen_rom_fast_read() fails, "bios" is left uninitialized and may
contain random value, thus should not be used.

The fix ensures that if netxen_rom_fast_read() fails, we return "-EIO".

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
index 0ea141ece19e..6547a9dd5935 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
@@ -1125,7 +1125,8 @@ netxen_validate_firmware(struct netxen_adapter *adapter)
 		return -EINVAL;
 	}
 	val = nx_get_bios_version(adapter);
-	netxen_rom_fast_read(adapter, NX_BIOS_VERSION_OFFSET, (int *)&bios);
+	if (netxen_rom_fast_read(adapter, NX_BIOS_VERSION_OFFSET, (int *)&bios))
+		return -EIO;
 	if ((__force u32)val != bios) {
 		dev_err(&pdev->dev, "%s: firmware bios is incompatible\n",
 				fw_name[fw_type]);
-- 
2.17.2 (Apple Git-113)

