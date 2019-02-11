Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0927C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18B321B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UC/FN7nY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387773AbfBKTKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:10:37 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40386 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732529AbfBKTKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:10:35 -0500
Received: by mail-pf1-f195.google.com with SMTP id h1so2891453pfo.7;
        Mon, 11 Feb 2019 11:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2TQc99j/xHrKOFnE+nfQwNzSxZGkG/IjAxlRWq4f6Ew=;
        b=UC/FN7nYUt5SLhrVGm+dMaAZddTvHcQDwacXtOw9g9xBib3psxbYw1TYGAzg/p6EHM
         bNLZzaL1SNVlowFmGRjaEgfpO/qJa0i7SpIiFHlVdaibhTPTf0hQhNuH6LM2u9pa4azD
         FLALeGlCJ5f64onaBXMphCeJA8BDC3C2sg8q57g7aYEODj72+LsyLjevWhrOl1lv9CZA
         z/OStEDk6smZyJprJUGk1fPRW6LfL0W207QWuBmgz43GdZsKw/2rVMpWp/fqmkfK2hf4
         2sBmzxGnZNAO7e3jOZR6qX4xPabXrZE86twMMUrtekLGostZkHztBCFXD0XkazVc4tJR
         2Qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2TQc99j/xHrKOFnE+nfQwNzSxZGkG/IjAxlRWq4f6Ew=;
        b=NtZapNiwJbsx1noFVjNPFxmcnbrpA3ev9Kwh5YkaagNXrDg0igZwPRHWuZXEEgYHPo
         6eT0Rgd62F9vintR3FcZllBtPehBx0ubXwtpmvZX5pure3ltHKoY+qxZ1KeY1ne8nA+z
         EEK3vZ3enhREAZkt3d5BpWS8asbCZm+du/aWtDxJd32iE4T+PFepJwVkG83uAO3WShfd
         DndTjNJdAz1fnDUVo+UpmTf7Nl5GrxjMA2cK6xgjc08aGH2GvqqcNeOVrEhIugGjKiZa
         Rni9Tu/PlbRBiF+745QgpaBNZVAGfu8EzqcxUqJ6wVB1Bu6Vc63uZwINcuIDmQBb6hSu
         VPBw==
X-Gm-Message-State: AHQUAubyRtjxn3xIoF90a6wfSQiTXSPYZLTe+tEYKSrFwtMATPqyDJdw
        rZN/6GUF74oyJhwFasLH7afghaVe
X-Google-Smtp-Source: AHgI3IbdoZFkJrjjZqJA6ku3KFTYjK+9ZG5mbsiP6k/Z1tiEFuEq3QX8qyOfCxfpm7HydkWiJMjiOg==
X-Received: by 2002:a63:534c:: with SMTP id t12mr18925680pgl.205.1549912234461;
        Mon, 11 Feb 2019 11:10:34 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i24sm2167206pgg.14.2019.02.11.11.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:10:33 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v4 2/9] switchdev: Add SWITCHDEV_PORT_ATTR_SET, SWITCHDEV_PORT_ATTR_GET
Date:   Mon, 11 Feb 2019 11:09:54 -0800
Message-Id: <20190211191001.8623-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211191001.8623-1-f.fainelli@gmail.com>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for allowing switchdev enabled drivers to veto specific
attribute settings from within the context of the caller, introduce a
new switchdev notifier type for port attributes.

Suggested-by: Ido Schimmel <idosch@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/switchdev.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 5e87b54c5dc5..b8becabbef38 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -143,6 +143,9 @@ enum switchdev_notifier_type {
 	SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
 	SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE,
 	SWITCHDEV_VXLAN_FDB_OFFLOADED,
+
+	SWITCHDEV_PORT_ATTR_SET, /* Blocking. */
+	SWITCHDEV_PORT_ATTR_GET, /* Blocking. */
 };
 
 struct switchdev_notifier_info {
@@ -165,6 +168,13 @@ struct switchdev_notifier_port_obj_info {
 	bool handled;
 };
 
+struct switchdev_notifier_port_attr_info {
+	struct switchdev_notifier_info info; /* must be first */
+	struct switchdev_attr *attr;
+	struct switchdev_trans *trans;
+	bool handled;
+};
+
 static inline struct net_device *
 switchdev_notifier_info_to_dev(const struct switchdev_notifier_info *info)
 {
-- 
2.17.1

