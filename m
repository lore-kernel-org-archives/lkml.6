Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4025272-1520451719-2-9726573372133391388
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520451719; b=bLOufVYnM6OmJ2cFTrED0BtfWDedE8Mf+vNOvtBjY5aDO9q
    wlZ9gtOUp192ycD3bdH7Dl2fwckrJmF/Lsp9rDpQHF+diBDWqxyP37ODPCO4Xt5W
    OcFya90idQ9znVDPvwgR2J+bRYtJdUPqNrXniLggSdqrwXnyRjRTSp8HP5JP4rEa
    KIw68O3sgbuJGrlwSOEJwrYajez/GAvGoALN90Mash4mlxoRfMJyczCxLPqEsFN5
    qvZt0smWe8UKdx59Cj2HUmdaIorwrSWBaG/AZI7NMN5OiX3MaQ88SWvKvk7bq2Sm
    dZeYs9f7LDic6iXBt0JSiom0UOfCMuM78odxptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520451719; bh=qPorU9eifrSUAvxYieLiE9FsEz
    8K6zYVEKZRS5Nz3A0=; b=NB2Pp19Noi5OFqgqTg3QD7zXurluqcyPcpDq+8rx5/
    w8g6wYNrZxlQn59xBcG9k1KhcgD7tQpXg4mDlf2XkzyQUcUkZmFcrVLwdLKVHTt5
    zyMMdcy/5jt/ps8xBK+QBkoGjjvoJaWAv0hpVS9guQ5QY61YW9pSDSQnlaPoX/ZQ
    mjh+KFVQtH272F0emiPzMQP1om13vdA+d+6TrgsOJIXfns4rG2vvpV2n0cAKE8G0
    yNbnPydpWsgcBK9C9o0j+5kiVJacfC5iz+4CfedpcSQMVQwDJ0aSUjaW6WrBiH7E
    vLTfQy0qOvMfLFA+UOItbLOFkm3w9ra5zZKukrOLQtrw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754829AbeCGTl4 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:41:56 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41426 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754826AbeCGTly (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:41:54 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 065/122] mlxsw: spectrum_router: Fix error path in mlxsw_sp_vr_create
Date: Wed,  7 Mar 2018 11:37:57 -0800
Message-Id: <20180307191738.752433368@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Pirko <jiri@mellanox.com>


[ Upstream commit 0f2d2b2736b08dafa3bde31d048750fbc8df3a31 ]

Since mlxsw_sp_fib_create() and mlxsw_sp_mr_table_create()
use ERR_PTR macro to propagate int err through return of a pointer,
the return value is not NULL in case of failure. So if one
of the calls fails, one of vr->fib4, vr->fib6 or vr->mr4_table
is not NULL and mlxsw_sp_vr_is_used wrongly assumes
that vr is in use which leads to crash like following one:

[ 1293.949291] BUG: unable to handle kernel NULL pointer dereference at 00000000000006c9
[ 1293.952729] IP: mlxsw_sp_mr_table_flush+0x15/0x70 [mlxsw_spectrum]

Fix this by using local variables to hold the pointers and set vr->*
only in case everything went fine.

Fixes: 76610ebbde18 ("mlxsw: spectrum_router: Refactor virtual router handling")
Fixes: a3d9bc506d64 ("mlxsw: spectrum_router: Extend virtual routers with IPv6 support")
Fixes: d42b0965b1d4 ("mlxsw: spectrum_router: Add multicast routes notification handling functionality")
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c |   32 ++++++++++--------
 1 file changed, 18 insertions(+), 14 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -737,6 +737,9 @@ static struct mlxsw_sp_vr *mlxsw_sp_vr_c
 					      u32 tb_id,
 					      struct netlink_ext_ack *extack)
 {
+	struct mlxsw_sp_mr_table *mr4_table;
+	struct mlxsw_sp_fib *fib4;
+	struct mlxsw_sp_fib *fib6;
 	struct mlxsw_sp_vr *vr;
 	int err;
 
@@ -745,29 +748,30 @@ static struct mlxsw_sp_vr *mlxsw_sp_vr_c
 		NL_SET_ERR_MSG(extack, "spectrum: Exceeded number of supported virtual routers");
 		return ERR_PTR(-EBUSY);
 	}
-	vr->fib4 = mlxsw_sp_fib_create(vr, MLXSW_SP_L3_PROTO_IPV4);
-	if (IS_ERR(vr->fib4))
-		return ERR_CAST(vr->fib4);
-	vr->fib6 = mlxsw_sp_fib_create(vr, MLXSW_SP_L3_PROTO_IPV6);
-	if (IS_ERR(vr->fib6)) {
-		err = PTR_ERR(vr->fib6);
+	fib4 = mlxsw_sp_fib_create(vr, MLXSW_SP_L3_PROTO_IPV4);
+	if (IS_ERR(fib4))
+		return ERR_CAST(fib4);
+	fib6 = mlxsw_sp_fib_create(vr, MLXSW_SP_L3_PROTO_IPV6);
+	if (IS_ERR(fib6)) {
+		err = PTR_ERR(fib6);
 		goto err_fib6_create;
 	}
-	vr->mr4_table = mlxsw_sp_mr_table_create(mlxsw_sp, vr->id,
-						 MLXSW_SP_L3_PROTO_IPV4);
-	if (IS_ERR(vr->mr4_table)) {
-		err = PTR_ERR(vr->mr4_table);
+	mr4_table = mlxsw_sp_mr_table_create(mlxsw_sp, vr->id,
+					     MLXSW_SP_L3_PROTO_IPV4);
+	if (IS_ERR(mr4_table)) {
+		err = PTR_ERR(mr4_table);
 		goto err_mr_table_create;
 	}
+	vr->fib4 = fib4;
+	vr->fib6 = fib6;
+	vr->mr4_table = mr4_table;
 	vr->tb_id = tb_id;
 	return vr;
 
 err_mr_table_create:
-	mlxsw_sp_fib_destroy(vr->fib6);
-	vr->fib6 = NULL;
+	mlxsw_sp_fib_destroy(fib6);
 err_fib6_create:
-	mlxsw_sp_fib_destroy(vr->fib4);
-	vr->fib4 = NULL;
+	mlxsw_sp_fib_destroy(fib4);
 	return ERR_PTR(err);
 }
 
