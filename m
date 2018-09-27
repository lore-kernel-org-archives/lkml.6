Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01D4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D54C21566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REJBySRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D54C21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeI0LbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:31:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39267 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbeI0LbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:31:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id s14-v6so1074750wrw.6;
        Wed, 26 Sep 2018 22:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qLkTiUn1JH5jWsSxtXtnjyX1UNRWQAxctcHfU5wdJ4c=;
        b=REJBySRfvh+fLQcddAuTux5/y15OCi2bwywwHpQ9zlknwXeOI+fZAYvlv0xuTRPrMh
         eqbxW+E3+d2zVhAmssPm5AqXqI2RtuTEagqyF9hs7sKZtFprNOqrEEtx1qaUEDGSlHxh
         b8EBNxcCkyMZ9MpbC4gJKVfzivj6lB7SiMiLxcpIzMhZEPVCveIRHFgWPpZCsNqTG/GH
         aE7OXwroaE8Y60uNmvDFh7iNfW7/mUbVsdOa4f7BJmfIy4sanveJbrpSi6BBNkTJgj9B
         xB/+p3Z6gAwyKGiMTyEwlxqoaEkuYGDKTfXIMaBd+GaZiV4U1GEuJMQLyn1KwDJbJCBZ
         lNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qLkTiUn1JH5jWsSxtXtnjyX1UNRWQAxctcHfU5wdJ4c=;
        b=ciHX2S3JxLXk4ho3hx/O0u1394/MUYbihbkoH5MDrkMUOyEwDtSpRVrdXI67pzj3FT
         i5bd54CkWI4kg5sxrDhTOmGbdIgDuSVE1pZxELQJoO/ck7ElM5MF0kBXGILiZ69FzhE+
         FfNYOfGxkkmL+s0taYLq7+gNriEjAnU+1Qa5c6RFCbaed0PnhdzfWNKLOBpr78O+qcPS
         ikdeNa9zgghH87HLKvBP1Anh2StqD2dYGl9Ni3HBnhz8DDqEkQb5/dESALegFI3X2sA4
         J6CMYYefxI2AjTG577Qjt8zjKhNBg0BJFOMitsPmUfP4/qFc9DLI6vxJnKlTqncZ31XY
         W2FA==
X-Gm-Message-State: ABuFfogsWy3B110PB1j14/dxXbw133ca3k+VoZ7v2i7e16Z3eXs/3XgG
        iOgLvjYBiQ5pW+ZJJlK3BLY=
X-Google-Smtp-Source: ACcGV6073kVi6WiLyYk1VAsvND/J8OysZ5nJzXtGAIELBtSkIbbf5B13/RHBFrf2Fs1J2g0oztIlUw==
X-Received: by 2002:adf:8bc5:: with SMTP id w5-v6mr6763077wra.110.1538025281747;
        Wed, 26 Sep 2018 22:14:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id r30-v6sm1321269wrc.90.2018.09.26.22.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 22:14:41 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v3] IB/rxe: Remove unnecessary enum values
Date:   Wed, 26 Sep 2018 22:12:23 -0700
Message-Id: <20180927051222.23084-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927050156.20023-1-natechancellor@gmail.com>
References: <20180927050156.20023-1-natechancellor@gmail.com>
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
conversion needs to happen then remove the unneeded definitions.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Don't cast, just use the expecting enumerated value directly, per
  Jason's request

v2 -> v3:

* Convert two spots from RXE_PORT_MAX_MTU to IB_MTU_4096 then remove
  value definitions.

 drivers/infiniband/sw/rxe/rxe.c       | 13 ++++++-------
 drivers/infiniband/sw/rxe/rxe_loc.h   |  2 +-
 drivers/infiniband/sw/rxe/rxe_param.h |  4 ----
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 10999fa69281..383e65c7bbc0 100644
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
@@ -300,7 +299,7 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
 	mtu = eth_mtu_int_to_enum(ndev_mtu);
 
 	/* Make sure that new MTU in range */
-	mtu = mtu ? min_t(enum ib_mtu, mtu, RXE_PORT_MAX_MTU) : IB_MTU_256;
+	mtu = mtu ? min_t(enum ib_mtu, mtu, IB_MTU_4096) : IB_MTU_256;
 
 	port->attr.active_mtu = mtu;
 	port->mtu_cap = ib_mtu_enum_to_int(mtu);
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 8e305422adbb..afd53f57a62b 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -195,7 +195,7 @@ static inline int qp_mtu(struct rxe_qp *qp)
 	if (qp->ibqp.qp_type == IB_QPT_RC || qp->ibqp.qp_type == IB_QPT_UC)
 		return qp->attr.path_mtu;
 	else
-		return RXE_PORT_MAX_MTU;
+		return IB_MTU_4096;
 }
 
 static inline int rcv_wqe_size(int max_sge)
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 4555510d86c4..bdea899a58ac 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -90,7 +90,6 @@ enum rxe_device_param {
 	RXE_MAX_RES_RD_ATOM		= 0x3f000,
 	RXE_MAX_QP_INIT_RD_ATOM		= 128,
 	RXE_MAX_EE_INIT_RD_ATOM		= 0,
-	RXE_ATOMIC_CAP			= 1,
 	RXE_MAX_EE			= 0,
 	RXE_MAX_RDD			= 0,
 	RXE_MAX_MW			= 0,
@@ -139,9 +138,6 @@ enum rxe_device_param {
 
 /* default/initial rxe port parameters */
 enum rxe_port_param {
-	RXE_PORT_STATE			= IB_PORT_DOWN,
-	RXE_PORT_MAX_MTU		= IB_MTU_4096,
-	RXE_PORT_ACTIVE_MTU		= IB_MTU_256,
 	RXE_PORT_GID_TBL_LEN		= 1024,
 	RXE_PORT_PORT_CAP_FLAGS		= RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP,
 	RXE_PORT_MAX_MSG_SZ		= 0x800000,
-- 
2.19.0

