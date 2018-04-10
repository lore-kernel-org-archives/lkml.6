Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713601-1523400114-2-3329990105852071602
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523400114; b=P2it5MiVIqUhpLi96AwET6eTdeN3QirDqovB9NwxIj9dA3J6lO
    spTp+lSnM23DRZ5ls0qJmMF8RmaOQbQHgJSiiiBEmMxlNNu0AnE/A1wPrVXZloxc
    V9uC+BR57i/1dt3z+FE19W3IUT9OobBCHOrQtzBsFeIlblK+yweAeXr3wMzHIPiL
    oConTi1a0r1QdOS4Om2W6vd6vqTxz8uAdcx56e2pxsMyqVt03+ao22o8WeGeaybT
    UwLgR6IkIA6aJnXO5JeFdPQ7isO016gG/Opggjs/S/LnFfUyioQFSoZnn/jKVcck
    gMFEazVgTPRy68sepcakhVXORo55HPPkZb8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523400114; bh=2wiQMuaMUd6G6RJzYtPgZ1wU6my895
    qDM3GteMsKXWo=; b=aZGfU4rXNMYPrgWrDcLeto3gpYd8l77h9hbdzwX/axVPhG
    slnqCUW4blWUCyaijqaNYDN7hucWEup2YkdTHbDMDW4iZkon7JsHGoAiJOdp7UZ+
    tE6fsVEUXq0iAsrCWir1W4wjks2+HV/5KpY8D5UXcFECc39ul8Z6aokeT1xZ57vH
    2CE7PweufDDvZCNsXyPInOWARkFyvK6Y4DL5JhJXpikccVcVHaz6JODQ6j0p2dqe
    jkLQx4qhcM1N/KH6X0Bz8CdlFwhHBNduCQSVdoIz3R4X1SJaLTQQ7gNVTnD8g/iF
    CHRBb/YNk20HTZ7+JG6kZW+Zi42DquBw7KuRobxw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfBmyqN9IO/lsDxN/M9NkMj7lKJCaYVyIenrWw6GCKaA6Ar2xmwgL8G/Q6e+CntDXWtHhzDfHo32BHrXsFd2j4sdpiBh2mvovz7zZ172/0nepzjCNKp0h
    1AAZ9FULXbB2p1Nh7dneuNnnmzooX8e01NtBxz8w8+R4i5S0vPYK2cgloa7PpHj14yB7WMnf+U39kzz/Eh7Ce53nA7E/7OipFjlBpnqR2dv1Td3SAWMmeF2T
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=CbDCq_QkAAAA:8 a=ag1SF4gXAAAA:8 a=RcruGUQ270hi0HJNYm4A:9 a=QEXdDO2ut3YA:10
    a=1qrBK16LubpBFNPVNq2M:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbeDJWli (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:41:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46696 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932131AbeDJWkS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:40:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roi Dayan <roid@mellanox.com>,
        Paul Blakey <paulb@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.14 133/138] net/mlx5e: Fix traffic being dropped on VF representor
Date: Wed, 11 Apr 2018 00:25:23 +0200
Message-Id: <20180410212917.702855218@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roi Dayan <roid@mellanox.com>


[ Upstream commit 4246f698dd58e3c6246fa919ef0b0a1d29a57e4a ]

Increase representor netdev RQ size to avoid dropped packets.
The current size (two) is just too small to keep up with
conventional slow path traffic patterns.
Also match the SQ size to the RQ size.

Fixes: cb67b832921c ("net/mlx5e: Introduce SRIOV VF representors")
Signed-off-by: Roi Dayan <roid@mellanox.com>
Reviewed-by: Paul Blakey <paulb@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -43,6 +43,11 @@
 #include "en_tc.h"
 #include "fs_core.h"
 
+#define MLX5E_REP_PARAMS_LOG_SQ_SIZE \
+	max(0x6, MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE)
+#define MLX5E_REP_PARAMS_LOG_RQ_SIZE \
+	max(0x6, MLX5E_PARAMS_MINIMUM_LOG_RQ_SIZE)
+
 static const char mlx5e_rep_driver_name[] = "mlx5e_rep";
 
 static void mlx5e_rep_get_drvinfo(struct net_device *dev,
@@ -798,9 +803,9 @@ static void mlx5e_build_rep_params(struc
 					 MLX5_CQ_PERIOD_MODE_START_FROM_CQE :
 					 MLX5_CQ_PERIOD_MODE_START_FROM_EQE;
 
-	params->log_sq_size = MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE;
+	params->log_sq_size = MLX5E_REP_PARAMS_LOG_SQ_SIZE;
 	params->rq_wq_type  = MLX5_WQ_TYPE_LINKED_LIST;
-	params->log_rq_size = MLX5E_PARAMS_MINIMUM_LOG_RQ_SIZE;
+	params->log_rq_size = MLX5E_REP_PARAMS_LOG_RQ_SIZE;
 
 	params->rx_am_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
 	mlx5e_set_rx_cq_mode_params(params, cq_period_mode);
