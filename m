Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1BAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4922320700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNETImDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfBVLSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 06:18:41 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45413 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfBVLSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 06:18:41 -0500
Received: by mail-ed1-f68.google.com with SMTP id d9so1426218edh.12;
        Fri, 22 Feb 2019 03:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QvqKzash5I1ezbatEE2yfjdYXqvz3H/bSnhQ8AstsoA=;
        b=JNETImDqlcyvKVg82XNOucydxzDIHoq4v6/9Sy3p7oRejpLfVhwq3aQiGilM3jKcSA
         wMsPC6VTdJIqEUeq3aE4tb60QFFZBT1/aTYPFkSBOLcmPwonQjfkidtovHvxSDZtb5/n
         LZeTmd75/8h3cBsgjA1L0lAmPZgR28FIRyKXVrkgrtFVFpoC01sEfrLC/om3lnttHcG7
         TMk3IBnTVtnXiJbI3l0qw63ktfScbPxwRlp57HNbvyr+TauQuEBOW67Kdy7W13mv3m72
         JmAtN3v3EzhkEFbnD6/CZvDY9XmtP1jtxkgxTnezMkRL/iJ7HQSH3rPDpKWE+OcYjvhk
         0vSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QvqKzash5I1ezbatEE2yfjdYXqvz3H/bSnhQ8AstsoA=;
        b=P3R9V8AbOVdm8A+2O52P31Hjv6UBiZVgNM+x0mxHMBuKtTnq56FKDBVXgiAK3vQMKR
         W69rnRvrRdjP1f3EeiRbPACbbD2efMzkNuNGF9xy+rtsI7XIkbvs/bo7lHBcRUVhc/aG
         3GjOueTkhOfMDtvKenWuEeyCnJlQHRXELuejJhDXe1XlflqMm4Pwx5vtQH82lXJe9BWu
         mEXmMtJrvPks2vtDf2JokC4S9SwuAahWTdZJkw5oPq2kUpI8t1ChW70mPBrqkjBvefbH
         9X8yr/h4ECpUFOU8hG7Ary++dWgyc2M7aaeSqc5mL++EqJ8O3LEpc7m72GmFRtNZIwht
         5FcA==
X-Gm-Message-State: AHQUAuZrkgNX0v4+jOXYeYqyuIR9gZIPGycDsrSNORVs3QqLSpzphMXt
        zKF8gQldmd/SHgU4iBRVJGk=
X-Google-Smtp-Source: AHgI3IZHTHm1LI9gmFuo6Laiu2N9471mXfHXxRM8FcGu5Rs2g+k6Czr1YOCDEQ0rznzQvWke6GAUXA==
X-Received: by 2002:a17:906:688:: with SMTP id u8mr2565153ejb.144.1550834319258;
        Fri, 22 Feb 2019 03:18:39 -0800 (PST)
Received: from localhost.localdomain (mx.daiict.ac.in. [220.225.53.35])
        by smtp.googlemail.com with ESMTPSA id b1sm326811edc.28.2019.02.22.03.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 03:18:38 -0800 (PST)
From:   Himadri Pandya <himadri18.07@gmail.com>
To:     andrew@lunn.ch
Cc:     vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Himadri Pandya <himadri18.07@gmail.com>
Subject: [PATCH net-next] net: dsa: add missing of_node_put
Date:   Fri, 22 Feb 2019 16:48:18 +0530
Message-Id: <20190222111818.3888-1-himadri18.07@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decrement the reference count on port while returning out of the
loop. Issue identified by Coccinelle.

Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
---
 net/dsa/dsa2.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index a1917025e155..396e7433dd8f 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -624,19 +624,25 @@ static int dsa_switch_parse_ports_of(struct dsa_switch *ds,
 	for_each_available_child_of_node(ports, port) {
 		err = of_property_read_u32(port, "reg", &reg);
 		if (err)
-			return err;
+			goto put_port;
 
-		if (reg >= ds->num_ports)
-			return -EINVAL;
+		if (reg >= ds->num_ports) {
+			err = -EINVAL;
+			goto put_port;
+		}
 
 		dp = &ds->ports[reg];
 
 		err = dsa_port_parse_of(dp, port);
 		if (err)
-			return err;
+			goto put_port;
 	}
 
 	return 0;
+
+put_port:
+	of_node_put(port);
+	return err;
 }
 
 static int dsa_switch_parse_member_of(struct dsa_switch *ds,
-- 
2.17.1

