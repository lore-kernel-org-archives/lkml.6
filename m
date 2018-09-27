Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5F9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48A221537
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZ1YgMmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48A221537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeI0LTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:19:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34911 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbeI0LTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:19:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id o18-v6so4514506wmc.0;
        Wed, 26 Sep 2018 22:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+kVS+6qYjogIYGXD4Q4Bg0yX/XWWmvU+UJlJhxK1XV8=;
        b=iZ1YgMmhKR0P+Gj6Nw+2LrsHPevgTZxhXXVGhAYUFyEPCaAfOVoKgYVJhZRmEFgq4b
         EZCWA5bQBdTkAyBFAEH+tdw9AzHSyolmqclF8ndNUCVNAn3bUaifhmV+JnBBcoYB3xs/
         Lr8Rsqv48vl4yJl0aO5jAeGg+bDNxk02G1vDVMJu1/nd3Izn6bnyMUZLxU7Rntq+Q6cu
         1pAiklbJyIIFA7Rv+4s4Hl7yXc2ArWhjeCvtUmngi60xr9Ln/7cmZO8laY+guMhIoJ3f
         tuT3+M523HRuPyDk4Irsk/rBHMSk62haq4jaSuNIG/5ZBAzyjiKGt4H88jIxwGK+9gdC
         qcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+kVS+6qYjogIYGXD4Q4Bg0yX/XWWmvU+UJlJhxK1XV8=;
        b=XZOjdZ0xXIAIEk1Y8rlMjLTxr9phX1rbWqAo2L4sCI0t+6GzSHCnN8gLp/EiPN6j72
         zAR1U0LuXemsf5cBSD+34oo7lr455yoGxi7cxdKWMYk4o4N9nwZE6CWwSixePnhZN0NH
         l1SFVra0XnN3cXF7V6lvoB2gdej/uSOvCJAFa49WjPdpoG03RauxnEGKw8K6Zm4197JU
         8WdTw8BFLZM2HG7CKZckzIeJen0oox/0L3RDEI076rvhjaCXwtjVp1lu+iY2tlLug1oj
         4HbLyN+elHWBGrfb2EVI8wMpawxjW6Muh+/OVqInVGf3kuE6rcbw1qbuVrW+rwlT5Kjj
         9BjA==
X-Gm-Message-State: ABuFfog2PyAWh7bAaUz/czbh94FuZbRWysRZUKDi1xpaM9nmb970pBWY
        +R1VleTGmd43OSpNIhDAbQU=
X-Google-Smtp-Source: ACcGV61M6yN2o1BqhhsomDr7FyqyWJbDrAFjMHgjyfZjrKK9zhqDMsr47LYeI2HbBw+CrbcBgWJ/zA==
X-Received: by 2002:a1c:5801:: with SMTP id m1-v6mr6768556wmb.135.1538024610523;
        Wed, 26 Sep 2018 22:03:30 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id h73-v6sm3828071wma.11.2018.09.26.22.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 22:03:30 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] IB/rxe: Avoid implicit enum conversions in rxe_init functions
Date:   Wed, 26 Sep 2018 22:01:57 -0700
Message-Id: <20180927050156.20023-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927011010.8373-1-natechancellor@gmail.com>
References: <20180927011010.8373-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when an emumerated type is implicitly converted to another.

drivers/infiniband/sw/rxe/rxe.c:106:27: warning: implicit conversion
from enumeration type 'enum rxe_device_param' to different enumeration
type 'enum ib_atomic_cap' [-Wenum-conversion]
        rxe->attr.atomic_cap                    = RXE_ATOMIC_CAP;
                                                ~ ^~~~~~~~~~~~~~
drivers/infiniband/sw/rxe/rxe.c:131:22: warning: implicit conversion
from enumeration type 'enum rxe_port_param' to different enumeration
type 'enum ib_port_state' [-Wenum-conversion]
        port->attr.state                = RXE_PORT_STATE;
                                        ~ ^~~~~~~~~~~~~~
drivers/infiniband/sw/rxe/rxe.c:132:24: warning: implicit conversion
from enumeration type 'enum rxe_port_param' to different enumeration
type 'enum ib_mtu' [-Wenum-conversion]
        port->attr.max_mtu              = RXE_PORT_MAX_MTU;
                                        ~ ^~~~~~~~~~~~~~~~
drivers/infiniband/sw/rxe/rxe.c:133:27: warning: implicit conversion
from enumeration type 'enum rxe_port_param' to different enumeration
type 'enum ib_mtu' [-Wenum-conversion]
        port->attr.active_mtu           = RXE_PORT_ACTIVE_MTU;
                                        ~ ^~~~~~~~~~~~~~~~~~~
drivers/infiniband/sw/rxe/rxe.c:151:24: warning: implicit conversion
from enumeration type 'enum rxe_port_param' to different enumeration
type 'enum ib_mtu' [-Wenum-conversion]
                                ib_mtu_enum_to_int(RXE_PORT_ACTIVE_MTU);
                                ~~~~~~~~~~~~~~~~~~ ^~~~~~~~~~~~~~~~~~~
5 warnings generated.

Use the appropriate values from the expected enumerated type so no
conversion needs to happen.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Don't cast, just use the expecting enumerated value directly, per
  Jason's request

 drivers/infiniband/sw/rxe/rxe.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 10999fa69281..2f4e57886b89 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -103,7 +103,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 	rxe->attr.max_res_rd_atom		= RXE_MAX_RES_RD_ATOM;
 	rxe->attr.max_qp_init_rd_atom		= RXE_MAX_QP_INIT_RD_ATOM;
 	rxe->attr.max_ee_init_rd_atom		= RXE_MAX_EE_INIT_RD_ATOM;
-	rxe->attr.atomic_cap			= RXE_ATOMIC_CAP;
+	rxe->attr.atomic_cap			= IB_ATOMIC_HCA;
 	rxe->attr.max_ee			= RXE_MAX_EE;
 	rxe->attr.max_rdd			= RXE_MAX_RDD;
 	rxe->attr.max_mw			= RXE_MAX_MW;
@@ -128,9 +128,9 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 /* initialize port attributes */
 static int rxe_init_port_param(struct rxe_port *port)
 {
-	port->attr.state		= RXE_PORT_STATE;
-	port->attr.max_mtu		= RXE_PORT_MAX_MTU;
-	port->attr.active_mtu		= RXE_PORT_ACTIVE_MTU;
+	port->attr.state		= IB_PORT_DOWN;
+	port->attr.max_mtu		= IB_MTU_4096;
+	port->attr.active_mtu		= IB_MTU_256;
 	port->attr.gid_tbl_len		= RXE_PORT_GID_TBL_LEN;
 	port->attr.port_cap_flags	= RXE_PORT_PORT_CAP_FLAGS;
 	port->attr.max_msg_sz		= RXE_PORT_MAX_MSG_SZ;
@@ -147,8 +147,7 @@ static int rxe_init_port_param(struct rxe_port *port)
 	port->attr.active_width		= RXE_PORT_ACTIVE_WIDTH;
 	port->attr.active_speed		= RXE_PORT_ACTIVE_SPEED;
 	port->attr.phys_state		= RXE_PORT_PHYS_STATE;
-	port->mtu_cap			=
-				ib_mtu_enum_to_int(RXE_PORT_ACTIVE_MTU);
+	port->mtu_cap			= ib_mtu_enum_to_int(IB_MTU_256);
 	port->subnet_prefix		= cpu_to_be64(RXE_PORT_SUBNET_PREFIX);
 
 	return 0;
-- 
2.19.0

