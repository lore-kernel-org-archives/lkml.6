Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523478900-2-17134142508362000698
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES ensvda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523478899; b=ubJMGCCjML7AO1KRniUbWeW9jRB5hcbp22tai8nwnEPjM25HrU
    nSu5qt7zc9NuEyUjxSPgYoMOgnufMdbeVyVQIV+awYScwqzweIx1xf4cuIZGvo6K
    Xx3nenGgbleQtgXVK/dWx+wUV7C3v/u2czDK5ZO9jk+a8NKllKFOQ2V1UTd3ilor
    m2y128ZR7TKz4ZyqersZVyKgP9bfkkguif7PZYTzXp+oXBOcCtc3DjsQWENYd5Gs
    3Pw0x/loY3OyFguIqIe1CTs4p/dM7EMPtjuRG7d2DeVnkopQCNsXiqyiUkcQH8Jh
    eNIbh04XRg3I1MJTnxsm7iOEILYFaWnvigIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523478899; bh=UVaoRVMsuGBfRH7zxjWUEnEUKsuehL
    sst2OXfk6X6K8=; b=WHq2QP2XAXgUbli6fXJYosI+lCaI27eta2fQn1w7n4Pp0P
    qxIRl+bjo4369aiQ/e6oevqu2b9F/k+liTsa1HujzL6gRN5w/uMcrzoXpJpyanU5
    NPXP3wQRDj09qQS6JdSMkr/kzHKNVoTLepBKzUTR3OqKg6RdJf0STyk1px5PJX6s
    U/OZAL3oJWTxmN4uRZIQxdO3KTXdMZDEih0S7loXDeXEYfUOiTc36jjB0PMtt+bx
    1Wd6wXXcnaeq3BctRkyArOCcrGUV1nU/Ib1mmI+yK1fiwp3X2Unz9dlKogiW+2Yr
    5rt9czFUSMaDxO9MhARXbRi61aMDzmdY47Rj/AOA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNvtlb2vd80fGL5DXvG/Kgoi71G/icaJyxi51Gl9KueE0DnaRhfe2PkWTsuvCIsAk4eBJdh1rvpXMGCjgj6oSzswR8IW3R6etR/pqL7c8ox8spD1ZDuF
    3S7/6jmR3QGKpUeMAWonfmh05eKgAsnFp+QajBw6x8KFPycRej5Sqy3rCJ698K04xDT4I7CndHfBpFqjYXAgDvNHGPPaV9zKuqZakv0TZ9/kEaKuz3NDVrFl
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=CbDCq_QkAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=9b6gyfl56b_c0TpKxoUA:9 a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932234AbeDKSsy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:48:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59880 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754583AbeDKSsw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:48:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Shamay <idos@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 120/190] net/mlx4: Check if Granular QoS per VF has been enabled before updating QP qos_vport
Date: Wed, 11 Apr 2018 20:36:06 +0200
Message-Id: <20180411183558.476496673@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Shamay <idos@mellanox.com>


[ Upstream commit 269f9883fe254d109afdfc657875c456d6fabb08 ]

The Granular QoS per VF feature must be enabled in FW before it can be
used.

Thus, the driver cannot modify a QP's qos_vport value (via the UPDATE_QP FW
command) if the feature has not been enabled -- the FW returns an error if
this is attempted.

Fixes: 08068cd5683f ("net/mlx4: Added qos_vport QP configuration in VST mode")
Signed-off-by: Ido Shamay <idos@mellanox.com>
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/qp.c               |    6 ++++++
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |   16 +++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx4/qp.c
+++ b/drivers/net/ethernet/mellanox/mlx4/qp.c
@@ -481,6 +481,12 @@ int mlx4_update_qp(struct mlx4_dev *dev,
 	}
 
 	if (attr & MLX4_UPDATE_QP_QOS_VPORT) {
+		if (!(dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_QOS_VPP)) {
+			mlx4_warn(dev, "Granular QoS per VF is not enabled\n");
+			err = -EOPNOTSUPP;
+			goto out;
+		}
+
 		qp_mask |= 1ULL << MLX4_UPD_QP_MASK_QOS_VPP;
 		cmd->qp_context.qos_vport = params->qos_vport;
 	}
--- a/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
+++ b/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
@@ -5040,6 +5040,13 @@ void mlx4_delete_all_resources_for_slave
 	mutex_unlock(&priv->mfunc.master.res_tracker.slave_list[slave].mutex);
 }
 
+static void update_qos_vpp(struct mlx4_update_qp_context *ctx,
+			   struct mlx4_vf_immed_vlan_work *work)
+{
+	ctx->qp_mask |= cpu_to_be64(1ULL << MLX4_UPD_QP_MASK_QOS_VPP);
+	ctx->qp_context.qos_vport = work->qos_vport;
+}
+
 void mlx4_vf_immed_vlan_work_handler(struct work_struct *_work)
 {
 	struct mlx4_vf_immed_vlan_work *work =
@@ -5144,11 +5151,10 @@ void mlx4_vf_immed_vlan_work_handler(str
 					qp->sched_queue & 0xC7;
 				upd_context->qp_context.pri_path.sched_queue |=
 					((work->qos & 0x7) << 3);
-				upd_context->qp_mask |=
-					cpu_to_be64(1ULL <<
-						    MLX4_UPD_QP_MASK_QOS_VPP);
-				upd_context->qp_context.qos_vport =
-					work->qos_vport;
+
+				if (dev->caps.flags2 &
+				    MLX4_DEV_CAP_FLAG2_QOS_VPP)
+					update_qos_vpp(upd_context, work);
 			}
 
 			err = mlx4_cmd(dev, mailbox->dma,
