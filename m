Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713601-1523400048-2-14376874806494505325
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
    1523400048; b=MRBNjMLUTRqfv34D6tUkwAbihTv/+3t/OSi/shWrA0JqxEX8M4
    Nyjd/Q5brKTpEZFgOPCvbI29h791/KpIa1uSL0yF0wCPTfAEaq0G3L3LCxkQ4SJ5
    lRQEUiGRysYahGHYQ/62LLh1aqXmQsuDOvNAPARqJp3kwTRRYJfv+QNLqYPL4iDN
    EO73JilNewX7JnVNuJt584nsvlxmbv4PupbQ1d2G+4NkGmWNGJrOJhouyFwZ52XY
    V0NjJ1epn2FavuY1C2gLPYmB6h6Lctbnr8Z/lTWVJxsAa6WeI8uz20dmnL2gEhaZ
    3gR37O/qretrO0umjQiQXv72pf4uaV6DGQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523400048; bh=4ctmU7kQwfzg8fSXXcO+tODI0ATfgf
    srkhptShEzj+8=; b=Apol9yNR3FsrbSzExkjeZu7egeBWVxaB0jmUm+/9YcProy
    Y8SD4dshiWImDka7Q4avl58uuOxchmh5Nh0aeIRoO/TRcGr9oKdp+LH1LNs80+Fq
    pe6sIrOyGFYDGXWuVwWZMIr5WGJjdczRiDVALnHZ1IlQTvkqP0Gv2BC5+M+WtINd
    M/rqKIYMrpfscYfRtRNK8rgDH/tO84ibvJdRBLc8Xmm4PhrVDI1B41qI9isblV2t
    fqmoTBK8i+vVSzaGEMFRYCemJgWvP5klnlRUQ9QmbGg6LgWc3Z1UeasDSi4ck5R+
    mZszYWU3uCZL1pZsLF/UqII+urtdXRwRIhi2O3zw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfH+vanJTHhatE0ijxJowsduxFZGCqNC2XAxVHPIBYDT6X7tA1wtrdn8969a2rAqzJoUEAAmdk29FcyeQghTPA0Gx1Xs6YHcBq10cQ1swiB2yWZbk0chb
    CROyP9diGxDVMXiIW2n5UTWYkqIt71yKVpBtjKiJAPVA57a03Uu6R+ksAi+EkYVA/H3sxX//GGTrrnCTlDVLTqZjpK0P8b5OAv9xpVCu/ZQ7syQ8xLAJ4itb
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=CbDCq_QkAAAA:8 a=ag1SF4gXAAAA:8 a=aIfLtaEJsP_qc66f6msA:9 a=QEXdDO2ut3YA:10
    a=1qrBK16LubpBFNPVNq2M:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932785AbeDJWkd (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:40:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46800 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932779AbeDJWk3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:40:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianbo Liu <jianbol@mellanox.com>,
        Roi Dayan <roid@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.14 127/138] net/mlx5e: Dont override vport admin link state in switchdev mode
Date: Wed, 11 Apr 2018 00:25:17 +0200
Message-Id: <20180410212916.944498244@linuxfoundation.org>
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

From: Jianbo Liu <jianbol@mellanox.com>


The vport admin original link state will be re-applied after returning
back to legacy mode, it is not right to change the admin link state value
when in switchdev mode.

Use direct vport commands to alter logical vport state in netdev
representor open/close flows rather than the administrative eswitch API.

Fixes: 20a1ea674783 ('net/mlx5e: Support VF vport link state control for SRIOV switchdev mode')
Signed-off-by: Jianbo Liu <jianbol@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -610,7 +610,6 @@ static int mlx5e_rep_open(struct net_dev
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5e_rep_priv *rpriv = priv->ppriv;
 	struct mlx5_eswitch_rep *rep = rpriv->rep;
-	struct mlx5_eswitch *esw = priv->mdev->priv.eswitch;
 	int err;
 
 	mutex_lock(&priv->state_lock);
@@ -618,8 +617,9 @@ static int mlx5e_rep_open(struct net_dev
 	if (err)
 		goto unlock;
 
-	if (!mlx5_eswitch_set_vport_state(esw, rep->vport,
-					  MLX5_ESW_VPORT_ADMIN_STATE_UP))
+	if (!mlx5_modify_vport_admin_state(priv->mdev,
+			MLX5_QUERY_VPORT_STATE_IN_OP_MOD_ESW_VPORT,
+			rep->vport, MLX5_ESW_VPORT_ADMIN_STATE_UP))
 		netif_carrier_on(dev);
 
 unlock:
@@ -632,11 +632,12 @@ static int mlx5e_rep_close(struct net_de
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5e_rep_priv *rpriv = priv->ppriv;
 	struct mlx5_eswitch_rep *rep = rpriv->rep;
-	struct mlx5_eswitch *esw = priv->mdev->priv.eswitch;
 	int ret;
 
 	mutex_lock(&priv->state_lock);
-	(void)mlx5_eswitch_set_vport_state(esw, rep->vport, MLX5_ESW_VPORT_ADMIN_STATE_DOWN);
+	mlx5_modify_vport_admin_state(priv->mdev,
+			MLX5_QUERY_VPORT_STATE_IN_OP_MOD_ESW_VPORT,
+			rep->vport, MLX5_ESW_VPORT_ADMIN_STATE_DOWN);
 	ret = mlx5e_close_locked(dev);
 	mutex_unlock(&priv->state_lock);
 	return ret;
