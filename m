Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2628BECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78648214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awtUqv0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78648214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeJIXrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:47:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42095 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeJIXrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:47:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id g15-v6so2510460wru.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/9TF+lSsilpXyNK9ARv2puZf8dejtekxSaCyIJy20e0=;
        b=awtUqv0ePZzr69azTbZ0ex7pQzIDgetf18tIE3oEwKD2jdsqg946SEq08F+jEZmgQE
         8tQMKQ3V335qroO/yp74VLO+cTYQRZ37qRYScStaYSE7HL6SWKcRrvb5sfuvQw25SYCM
         LxpqBGtySoYt4E6Fxul7TuqKaeoIvRvvixzuhnVxHeolp4sBt74ZKjheY/cza1nUnnO+
         WG7td4MOy3nxCRyps9beDFasxs6jp11+N+r2W5tOEhkDRExExuq/Y7/EBRol30tmJxmh
         MRrgnskTje2iGylTZ1glflz2218HaWft4tjS61On1iuvggKZRq0OhS63W/ozMack2eE1
         sfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/9TF+lSsilpXyNK9ARv2puZf8dejtekxSaCyIJy20e0=;
        b=ejNvDaMh77GgcMurCS9iy3mXZxYQhfHc4RmSjz5PfP6/Ogseu2n8cJfvKTRTdj6q2b
         L7Gdyu6yf5jRkO03ZZQZKbNe15Kbn11sDXiEF+4CkAZEhMePO3nd1EMa76cNiQL1AJS/
         7RaCtrmhcXyn5EHYHRAtJ/8aLqZMGGkVvTA7mMTivRG4DiDhVBH1aoFmE1Cm/h5/ynvU
         VqeZfpZYISOnAw+YrhYiQp4BpMglgWbLaXCwjlSPdKGh0UzgqPdv4mU3DHxchXRhTSPo
         wQIl7urjK3bVrmJ+jg/1frZN2c7uu88o0ni7iFbhlmfXVJ92Gu3G3H/BFi+Asqe+k4eH
         t6Kg==
X-Gm-Message-State: ABuFfohwwxKlWrIUM3j4eqnbvJdBOdwhR3rgUsTHJ1ATNQOoFsZgpZ3f
        VBVrPTZ6cxT+nZMDmiNU2Zw=
X-Google-Smtp-Source: ACcGV63VnVBJKKetuaS6eL2wwjuXFk1bnP8Hv3iwo3GHrOs4/eAFf3ZbKzvP93ZXOGwzreumJ/CQfA==
X-Received: by 2002:adf:e512:: with SMTP id j18-v6mr20025003wrm.111.1539102547659;
        Tue, 09 Oct 2018 09:29:07 -0700 (PDT)
Received: from kheib-workstation.mynet (bzq-109-64-21-122.red.bezeqint.net. [109.64.21.122])
        by smtp.gmail.com with ESMTPSA id h18-v6sm18082694wrb.82.2018.10.09.09.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:29:07 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kamalheib1@gmail.com
Subject: [PATCH rdma-next 18/18] RDMA: Start use ib_device_ops
Date:   Tue,  9 Oct 2018 19:28:17 +0300
Message-Id: <20181009162817.4635-19-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181009162817.4635-1-kamalheib1@gmail.com>
References: <20181009162817.4635-1-kamalheib1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change makes all the required change to start use the ib_device_ops
structure.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/core/cache.c                    |  12 +-
 drivers/infiniband/core/core_priv.h                |  12 +-
 drivers/infiniband/core/cq.c                       |   6 +-
 drivers/infiniband/core/device.c                   |  38 +--
 drivers/infiniband/core/fmr_pool.c                 |   4 +-
 drivers/infiniband/core/mad.c                      |  24 +-
 drivers/infiniband/core/nldev.c                    |   4 +-
 drivers/infiniband/core/opa_smi.h                  |   4 +-
 drivers/infiniband/core/rdma_core.c                |   6 +-
 drivers/infiniband/core/security.c                 |   8 +-
 drivers/infiniband/core/smi.h                      |   4 +-
 drivers/infiniband/core/sysfs.c                    |  26 +-
 drivers/infiniband/core/uverbs_cmd.c               |  64 ++---
 drivers/infiniband/core/uverbs_main.c              |  14 +-
 drivers/infiniband/core/uverbs_std_types.c         |   2 +-
 .../infiniband/core/uverbs_std_types_counters.c    |  10 +-
 drivers/infiniband/core/uverbs_std_types_cq.c      |   4 +-
 drivers/infiniband/core/uverbs_std_types_dm.c      |   6 +-
 .../infiniband/core/uverbs_std_types_flow_action.c |  14 +-
 drivers/infiniband/core/uverbs_std_types_mr.c      |   4 +-
 drivers/infiniband/core/verbs.c                    | 149 ++++++-----
 drivers/infiniband/hw/bnxt_re/main.c               |  52 ----
 drivers/infiniband/hw/cxgb3/iwch_provider.c        |  30 ---
 drivers/infiniband/hw/cxgb4/provider.c             |  35 ---
 drivers/infiniband/hw/hfi1/verbs.c                 |   8 -
 drivers/infiniband/hw/hns/hns_roce_main.c          |  49 ----
 drivers/infiniband/hw/i40iw/i40iw_cm.c             |   2 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c          |  31 ---
 drivers/infiniband/hw/mlx4/alias_GUID.c            |   2 +-
 drivers/infiniband/hw/mlx4/main.c                  |  72 +----
 drivers/infiniband/hw/mlx5/main.c                  | 104 +-------
 drivers/infiniband/hw/mthca/mthca_provider.c       |  64 +----
 drivers/infiniband/hw/nes/nes_cm.c                 |   2 +-
 drivers/infiniband/hw/nes/nes_verbs.c              |  32 ---
 drivers/infiniband/hw/ocrdma/ocrdma_main.c         |  47 ----
 drivers/infiniband/hw/qedr/main.c                  |  53 ----
 drivers/infiniband/hw/qib/qib_verbs.c              |   2 -
 drivers/infiniband/hw/usnic/usnic_ib_main.c        |  29 --
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c     |  38 ---
 drivers/infiniband/sw/rdmavt/vt.c                  |  90 +++----
 drivers/infiniband/sw/rxe/rxe_verbs.c              |  44 ---
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |  12 +-
 drivers/infiniband/ulp/iser/iser_memory.c          |   4 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c  |   8 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |   6 +-
 include/rdma/ib_verbs.h                            | 297 +--------------------
 net/sunrpc/xprtrdma/fmr_ops.c                      |   2 +-
 47 files changed, 304 insertions(+), 1226 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index ebc64418d809..c46af5d8a658 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -217,7 +217,7 @@ static void free_gid_entry_locked(struct ib_gid_table_entry *entry)
 
 	if (rdma_cap_roce_gid_table(device, port_num) &&
 	    entry->state != GID_TABLE_ENTRY_INVALID)
-		device->del_gid(&entry->attr, &entry->context);
+		device->ops.del_gid(&entry->attr, &entry->context);
 
 	write_lock_irq(&table->rwlock);
 
@@ -324,7 +324,7 @@ static int add_roce_gid(struct ib_gid_table_entry *entry)
 		return -EINVAL;
 	}
 	if (rdma_cap_roce_gid_table(attr->device, attr->port_num)) {
-		ret = attr->device->add_gid(attr, &entry->context);
+		ret = attr->device->ops.add_gid(attr, &entry->context);
 		if (ret) {
 			dev_err(&attr->device->dev,
 				"%s GID add failed port=%d index=%d\n",
@@ -548,8 +548,8 @@ int ib_cache_gid_add(struct ib_device *ib_dev, u8 port,
 	unsigned long mask;
 	int ret;
 
-	if (ib_dev->get_netdev) {
-		idev = ib_dev->get_netdev(ib_dev, port);
+	if (ib_dev->ops.get_netdev) {
+		idev = ib_dev->ops.get_netdev(ib_dev, port);
 		if (idev && attr->ndev != idev) {
 			union ib_gid default_gid;
 
@@ -1296,9 +1296,9 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 
 	mutex_lock(&table->lock);
 	for (i = 0; i < gid_tbl_len; ++i) {
-		if (!device->query_gid)
+		if (!device->ops.query_gid)
 			continue;
-		ret = device->query_gid(device, port, i, &gid_attr.gid);
+		ret = device->ops.query_gid(device, port, i, &gid_attr.gid);
 		if (ret) {
 			dev_warn(&device->dev,
 				 "query_gid failed (%d) for index %d\n", ret,
diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index d7399d5b1cb6..d4e84f8b2c79 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -243,10 +243,10 @@ static inline int ib_security_modify_qp(struct ib_qp *qp,
 					int qp_attr_mask,
 					struct ib_udata *udata)
 {
-	return qp->device->modify_qp(qp->real_qp,
-				     qp_attr,
-				     qp_attr_mask,
-				     udata);
+	return qp->device->ops.modify_qp(qp->real_qp,
+					 qp_attr,
+					 qp_attr_mask,
+					 udata);
 }
 
 static inline int ib_create_qp_security(struct ib_qp *qp,
@@ -307,10 +307,10 @@ static inline struct ib_qp *_ib_create_qp(struct ib_device *dev,
 {
 	struct ib_qp *qp;
 
-	if (!dev->create_qp)
+	if (!dev->ops.create_qp)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	qp = dev->create_qp(pd, attr, udata);
+	qp = dev->ops.create_qp(pd, attr, udata);
 	if (IS_ERR(qp))
 		return qp;
 
diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index b1e5365ddafa..7fb4f64ae933 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -145,7 +145,7 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private,
 	struct ib_cq *cq;
 	int ret = -ENOMEM;
 
-	cq = dev->create_cq(dev, &cq_attr, NULL, NULL);
+	cq = dev->ops.create_cq(dev, &cq_attr, NULL, NULL);
 	if (IS_ERR(cq))
 		return cq;
 
@@ -193,7 +193,7 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private,
 	kfree(cq->wc);
 	rdma_restrack_del(&cq->res);
 out_destroy_cq:
-	cq->device->destroy_cq(cq);
+	cq->device->ops.destroy_cq(cq);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(__ib_alloc_cq);
@@ -225,7 +225,7 @@ void ib_free_cq(struct ib_cq *cq)
 
 	kfree(cq->wc);
 	rdma_restrack_del(&cq->res);
-	ret = cq->device->destroy_cq(cq);
+	ret = cq->device->ops.destroy_cq(cq);
 	WARN_ON_ONCE(ret);
 }
 EXPORT_SYMBOL(ib_free_cq);
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 8839ba876def..f7ffb53172a2 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -96,7 +96,7 @@ static struct notifier_block ibdev_lsm_nb = {
 
 static int ib_device_check_mandatory(struct ib_device *device)
 {
-#define IB_MANDATORY_FUNC(x) { offsetof(struct ib_device, x), #x }
+#define IB_MANDATORY_FUNC(x) { offsetof(struct ib_device_ops, x), #x }
 	static const struct {
 		size_t offset;
 		char  *name;
@@ -122,7 +122,8 @@ static int ib_device_check_mandatory(struct ib_device *device)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(mandatory_table); ++i) {
-		if (!*(void **) ((void *) device + mandatory_table[i].offset)) {
+		if (!*(void **) ((void *) &device->ops +
+				 mandatory_table[i].offset)) {
 			dev_warn(&device->dev,
 				 "Device is missing mandatory function %s\n",
 				 mandatory_table[i].name);
@@ -337,8 +338,8 @@ static int read_port_immutable(struct ib_device *device)
 		return -ENOMEM;
 
 	for (port = start_port; port <= end_port; ++port) {
-		ret = device->get_port_immutable(device, port,
-						 &device->port_immutable[port]);
+		ret = device->ops.get_port_immutable(device, port,
+						     &device->port_immutable[port]);
 		if (ret)
 			return ret;
 
@@ -350,8 +351,8 @@ static int read_port_immutable(struct ib_device *device)
 
 void ib_get_device_fw_str(struct ib_device *dev, char *str)
 {
-	if (dev->get_dev_fw_str)
-		dev->get_dev_fw_str(dev, str);
+	if (dev->ops.get_dev_fw_str)
+		dev->ops.get_dev_fw_str(dev, str);
 	else
 		str[0] = '\0';
 }
@@ -540,7 +541,7 @@ int ib_register_device(struct ib_device *device, const char *name,
 	}
 
 	memset(&device->attrs, 0, sizeof(device->attrs));
-	ret = device->query_device(device, &device->attrs, &uhw);
+	ret = device->ops.query_device(device, &device->attrs, &uhw);
 	if (ret) {
 		dev_warn(&device->dev,
 			 "Couldn't query the device attributes\n");
@@ -854,14 +855,14 @@ int ib_query_port(struct ib_device *device,
 		return -EINVAL;
 
 	memset(port_attr, 0, sizeof(*port_attr));
-	err = device->query_port(device, port_num, port_attr);
+	err = device->ops.query_port(device, port_num, port_attr);
 	if (err || port_attr->subnet_prefix)
 		return err;
 
 	if (rdma_port_get_link_layer(device, port_num) != IB_LINK_LAYER_INFINIBAND)
 		return 0;
 
-	err = device->query_gid(device, port_num, 0, &gid);
+	err = device->ops.query_gid(device, port_num, 0, &gid);
 	if (err)
 		return err;
 
@@ -895,8 +896,8 @@ void ib_enum_roce_netdev(struct ib_device *ib_dev,
 		if (rdma_protocol_roce(ib_dev, port)) {
 			struct net_device *idev = NULL;
 
-			if (ib_dev->get_netdev)
-				idev = ib_dev->get_netdev(ib_dev, port);
+			if (ib_dev->ops.get_netdev)
+				idev = ib_dev->ops.get_netdev(ib_dev, port);
 
 			if (idev &&
 			    idev->reg_state >= NETREG_UNREGISTERED) {
@@ -973,7 +974,7 @@ int ib_enum_all_devs(nldev_callback nldev_cb, struct sk_buff *skb,
 int ib_query_pkey(struct ib_device *device,
 		  u8 port_num, u16 index, u16 *pkey)
 {
-	return device->query_pkey(device, port_num, index, pkey);
+	return device->ops.query_pkey(device, port_num, index, pkey);
 }
 EXPORT_SYMBOL(ib_query_pkey);
 
@@ -990,11 +991,11 @@ int ib_modify_device(struct ib_device *device,
 		     int device_modify_mask,
 		     struct ib_device_modify *device_modify)
 {
-	if (!device->modify_device)
+	if (!device->ops.modify_device)
 		return -ENOSYS;
 
-	return device->modify_device(device, device_modify_mask,
-				     device_modify);
+	return device->ops.modify_device(device, device_modify_mask,
+					 device_modify);
 }
 EXPORT_SYMBOL(ib_modify_device);
 
@@ -1018,9 +1019,10 @@ int ib_modify_port(struct ib_device *device,
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;
 
-	if (device->modify_port)
-		rc = device->modify_port(device, port_num, port_modify_mask,
-					   port_modify);
+	if (device->ops.modify_port)
+		rc = device->ops.modify_port(device, port_num,
+					     port_modify_mask,
+					     port_modify);
 	else
 		rc = rdma_protocol_roce(device, port_num) ? 0 : -ENOSYS;
 	return rc;
diff --git a/drivers/infiniband/core/fmr_pool.c b/drivers/infiniband/core/fmr_pool.c
index 83ba0068e8bb..001045f58a50 100644
--- a/drivers/infiniband/core/fmr_pool.c
+++ b/drivers/infiniband/core/fmr_pool.c
@@ -211,8 +211,8 @@ struct ib_fmr_pool *ib_create_fmr_pool(struct ib_pd             *pd,
 		return ERR_PTR(-EINVAL);
 
 	device = pd->device;
-	if (!device->alloc_fmr    || !device->dealloc_fmr  ||
-	    !device->map_phys_fmr || !device->unmap_fmr) {
+	if (!device->ops.alloc_fmr    || !device->ops.dealloc_fmr  ||
+	    !device->ops.map_phys_fmr || !device->ops.unmap_fmr) {
 		dev_info(&device->dev, "Device does not support FMRs\n");
 		return ERR_PTR(-ENOSYS);
 	}
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index c355379e7534..8996b4caea68 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -888,10 +888,10 @@ static int handle_outgoing_dr_smp(struct ib_mad_agent_private *mad_agent_priv,
 	}
 
 	/* No GRH for DR SMP */
-	ret = device->process_mad(device, 0, port_num, &mad_wc, NULL,
-				  (const struct ib_mad_hdr *)smp, mad_size,
-				  (struct ib_mad_hdr *)mad_priv->mad,
-				  &mad_size, &out_mad_pkey_index);
+	ret = device->ops.process_mad(device, 0, port_num, &mad_wc, NULL,
+				      (const struct ib_mad_hdr *)smp, mad_size,
+				      (struct ib_mad_hdr *)mad_priv->mad,
+				      &mad_size, &out_mad_pkey_index);
 	switch (ret)
 	{
 	case IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY:
@@ -2305,14 +2305,14 @@ static void ib_mad_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	}
 
 	/* Give driver "right of first refusal" on incoming MAD */
-	if (port_priv->device->process_mad) {
-		ret = port_priv->device->process_mad(port_priv->device, 0,
-						     port_priv->port_num,
-						     wc, &recv->grh,
-						     (const struct ib_mad_hdr *)recv->mad,
-						     recv->mad_size,
-						     (struct ib_mad_hdr *)response->mad,
-						     &mad_size, &resp_mad_pkey_index);
+	if (port_priv->device->ops.process_mad) {
+		ret = port_priv->device->ops.process_mad(port_priv->device, 0,
+							 port_priv->port_num,
+							 wc, &recv->grh,
+							 (const struct ib_mad_hdr *)recv->mad,
+							 recv->mad_size,
+							 (struct ib_mad_hdr *)response->mad,
+							 &mad_size, &resp_mad_pkey_index);
 
 		if (opa)
 			wc->pkey_index = resp_mad_pkey_index;
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index ba5403fbcd88..f40c06bf8040 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -259,8 +259,8 @@ static int fill_port_info(struct sk_buff *msg,
 	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_PORT_PHYS_STATE, attr.phys_state))
 		return -EMSGSIZE;
 
-	if (device->get_netdev)
-		netdev = device->get_netdev(device, port);
+	if (device->ops.get_netdev)
+		netdev = device->ops.get_netdev(device, port);
 
 	if (netdev && net_eq(dev_net(netdev), net)) {
 		ret = nla_put_u32(msg,
diff --git a/drivers/infiniband/core/opa_smi.h b/drivers/infiniband/core/opa_smi.h
index 3bfab3505a29..af4879bdf3d6 100644
--- a/drivers/infiniband/core/opa_smi.h
+++ b/drivers/infiniband/core/opa_smi.h
@@ -55,7 +55,7 @@ static inline enum smi_action opa_smi_check_local_smp(struct opa_smp *smp,
 {
 	/* C14-9:3 -- We're at the end of the DR segment of path */
 	/* C14-9:4 -- Hop Pointer = Hop Count + 1 -> give to SMA/SM */
-	return (device->process_mad &&
+	return (device->ops.process_mad &&
 		!opa_get_smp_direction(smp) &&
 		(smp->hop_ptr == smp->hop_cnt + 1)) ?
 		IB_SMI_HANDLE : IB_SMI_DISCARD;
@@ -70,7 +70,7 @@ static inline enum smi_action opa_smi_check_local_returning_smp(struct opa_smp *
 {
 	/* C14-13:3 -- We're at the end of the DR segment of path */
 	/* C14-13:4 -- Hop Pointer == 0 -> give to SM */
-	return (device->process_mad &&
+	return (device->ops.process_mad &&
 		opa_get_smp_direction(smp) &&
 		!smp->hop_ptr) ? IB_SMI_HANDLE : IB_SMI_DISCARD;
 }
diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 752a55c6bdce..717b04ccb95a 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -812,8 +812,8 @@ static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
 	 */
 	if (reason == RDMA_REMOVE_DRIVER_REMOVE) {
 		uverbs_user_mmap_disassociate(ufile);
-		if (ib_dev->disassociate_ucontext)
-			ib_dev->disassociate_ucontext(ucontext);
+		if (ib_dev->ops.disassociate_ucontext)
+			ib_dev->ops.disassociate_ucontext(ucontext);
 	}
 
 	ib_rdmacg_uncharge(&ucontext->cg_obj, ib_dev,
@@ -823,7 +823,7 @@ static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
 	 * FIXME: Drivers are not permitted to fail dealloc_ucontext, remove
 	 * the error return.
 	 */
-	ret = ib_dev->dealloc_ucontext(ucontext);
+	ret = ib_dev->ops.dealloc_ucontext(ucontext);
 	WARN_ON(ret);
 
 	ufile->ucontext = NULL;
diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index 1143c0448666..1efadbccf394 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -626,10 +626,10 @@ int ib_security_modify_qp(struct ib_qp *qp,
 	}
 
 	if (!ret)
-		ret = real_qp->device->modify_qp(real_qp,
-						 qp_attr,
-						 qp_attr_mask,
-						 udata);
+		ret = real_qp->device->ops.modify_qp(real_qp,
+						     qp_attr,
+						     qp_attr_mask,
+						     udata);
 
 	if (new_pps) {
 		/* Clean up the lists and free the appropriate
diff --git a/drivers/infiniband/core/smi.h b/drivers/infiniband/core/smi.h
index 33c91c8a16e9..91d9b353ab85 100644
--- a/drivers/infiniband/core/smi.h
+++ b/drivers/infiniband/core/smi.h
@@ -67,7 +67,7 @@ static inline enum smi_action smi_check_local_smp(struct ib_smp *smp,
 {
 	/* C14-9:3 -- We're at the end of the DR segment of path */
 	/* C14-9:4 -- Hop Pointer = Hop Count + 1 -> give to SMA/SM */
-	return ((device->process_mad &&
+	return ((device->ops.process_mad &&
 		!ib_get_smp_direction(smp) &&
 		(smp->hop_ptr == smp->hop_cnt + 1)) ?
 		IB_SMI_HANDLE : IB_SMI_DISCARD);
@@ -82,7 +82,7 @@ static inline enum smi_action smi_check_local_returning_smp(struct ib_smp *smp,
 {
 	/* C14-13:3 -- We're at the end of the DR segment of path */
 	/* C14-13:4 -- Hop Pointer == 0 -> give to SM */
-	return ((device->process_mad &&
+	return ((device->ops.process_mad &&
 		ib_get_smp_direction(smp) &&
 		!smp->hop_ptr) ? IB_SMI_HANDLE : IB_SMI_DISCARD);
 }
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index bc947a863b34..2e55687fd9e1 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -462,7 +462,7 @@ static int get_perf_mad(struct ib_device *dev, int port_num, __be16 attr,
 	u16 out_mad_pkey_index = 0;
 	ssize_t ret;
 
-	if (!dev->process_mad)
+	if (!dev->ops.process_mad)
 		return -ENOSYS;
 
 	in_mad  = kzalloc(sizeof *in_mad, GFP_KERNEL);
@@ -481,11 +481,11 @@ static int get_perf_mad(struct ib_device *dev, int port_num, __be16 attr,
 	if (attr != IB_PMA_CLASS_PORT_INFO)
 		in_mad->data[41] = port_num;	/* PortSelect field */
 
-	if ((dev->process_mad(dev, IB_MAD_IGNORE_MKEY,
-		 port_num, NULL, NULL,
-		 (const struct ib_mad_hdr *)in_mad, mad_size,
-		 (struct ib_mad_hdr *)out_mad, &mad_size,
-		 &out_mad_pkey_index) &
+	if ((dev->ops.process_mad(dev, IB_MAD_IGNORE_MKEY,
+				  port_num, NULL, NULL,
+				  (const struct ib_mad_hdr *)in_mad, mad_size,
+				  (struct ib_mad_hdr *)out_mad, &mad_size,
+				  &out_mad_pkey_index) &
 	     (IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY)) !=
 	    (IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY)) {
 		ret = -EINVAL;
@@ -786,7 +786,7 @@ static int update_hw_stats(struct ib_device *dev, struct rdma_hw_stats *stats,
 
 	if (time_is_after_eq_jiffies(stats->timestamp + stats->lifespan))
 		return 0;
-	ret = dev->get_hw_stats(dev, stats, port_num, index);
+	ret = dev->ops.get_hw_stats(dev, stats, port_num, index);
 	if (ret < 0)
 		return ret;
 	if (ret == stats->num_counters)
@@ -946,7 +946,7 @@ static void setup_hw_stats(struct ib_device *device, struct ib_port *port,
 	struct rdma_hw_stats *stats;
 	int i, ret;
 
-	stats = device->alloc_hw_stats(device, port_num);
+	stats = device->ops.alloc_hw_stats(device, port_num);
 
 	if (!stats)
 		return;
@@ -964,8 +964,8 @@ static void setup_hw_stats(struct ib_device *device, struct ib_port *port,
 	if (!hsag)
 		goto err_free_stats;
 
-	ret = device->get_hw_stats(device, stats, port_num,
-				   stats->num_counters);
+	ret = device->ops.get_hw_stats(device, stats, port_num,
+				       stats->num_counters);
 	if (ret != stats->num_counters)
 		goto err_free_hsag;
 
@@ -1122,7 +1122,7 @@ static int add_port(struct ib_device *device, int port_num,
 	 * device, not this port device, should be the holder of the
 	 * hw_counters
 	 */
-	if (device->alloc_hw_stats && port_num)
+	if (device->ops.alloc_hw_stats && port_num)
 		setup_hw_stats(device, p, port_num);
 
 	list_add_tail(&p->kobj.entry, &device->port_list);
@@ -1242,7 +1242,7 @@ static ssize_t node_desc_store(struct device *device,
 	struct ib_device_modify desc = {};
 	int ret;
 
-	if (!dev->modify_device)
+	if (!dev->ops.modify_device)
 		return -EIO;
 
 	memcpy(desc.node_desc, buf, min_t(int, count, IB_DEVICE_NODE_DESC_MAX));
@@ -1337,7 +1337,7 @@ int ib_device_register_sysfs(struct ib_device *device,
 		}
 	}
 
-	if (device->alloc_hw_stats)
+	if (device->ops.alloc_hw_stats)
 		setup_hw_stats(device, NULL, 0);
 
 	return 0;
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 91d3e4029cd5..c1c5fa413d4b 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -106,7 +106,7 @@ ssize_t ib_uverbs_get_context(struct ib_uverbs_file *file,
 	if (ret)
 		goto err;
 
-	ucontext = ib_dev->alloc_ucontext(ib_dev, &udata);
+	ucontext = ib_dev->ops.alloc_ucontext(ib_dev, &udata);
 	if (IS_ERR(ucontext)) {
 		ret = PTR_ERR(ucontext);
 		goto err_alloc;
@@ -166,7 +166,7 @@ ssize_t ib_uverbs_get_context(struct ib_uverbs_file *file,
 	put_unused_fd(resp.async_fd);
 
 err_free:
-	ib_dev->dealloc_ucontext(ucontext);
+	ib_dev->ops.dealloc_ucontext(ucontext);
 
 err_alloc:
 	ib_rdmacg_uncharge(&cg_obj, ib_dev, RDMACG_RESOURCE_HCA_HANDLE);
@@ -364,7 +364,7 @@ ssize_t ib_uverbs_alloc_pd(struct ib_uverbs_file *file,
 	if (IS_ERR(uobj))
 		return PTR_ERR(uobj);
 
-	pd = ib_dev->alloc_pd(ib_dev, uobj->context, &udata);
+	pd = ib_dev->ops.alloc_pd(ib_dev, uobj->context, &udata);
 	if (IS_ERR(pd)) {
 		ret = PTR_ERR(pd);
 		goto err;
@@ -552,7 +552,8 @@ ssize_t ib_uverbs_open_xrcd(struct ib_uverbs_file *file,
 	}
 
 	if (!xrcd) {
-		xrcd = ib_dev->alloc_xrcd(ib_dev, obj->uobject.context, &udata);
+		xrcd = ib_dev->ops.alloc_xrcd(ib_dev, obj->uobject.context,
+					      &udata);
 		if (IS_ERR(xrcd)) {
 			ret = PTR_ERR(xrcd);
 			goto err;
@@ -703,8 +704,8 @@ ssize_t ib_uverbs_reg_mr(struct ib_uverbs_file *file,
 		}
 	}
 
-	mr = pd->device->reg_user_mr(pd, cmd.start, cmd.length, cmd.hca_va,
-				     cmd.access_flags, &udata);
+	mr = pd->device->ops.reg_user_mr(pd, cmd.start, cmd.length, cmd.hca_va,
+					 cmd.access_flags, &udata);
 	if (IS_ERR(mr)) {
 		ret = PTR_ERR(mr);
 		goto err_put;
@@ -804,9 +805,9 @@ ssize_t ib_uverbs_rereg_mr(struct ib_uverbs_file *file,
 	}
 
 	old_pd = mr->pd;
-	ret = mr->device->rereg_user_mr(mr, cmd.flags, cmd.start,
-					cmd.length, cmd.hca_va,
-					cmd.access_flags, pd, &udata);
+	ret = mr->device->ops.rereg_user_mr(mr, cmd.flags, cmd.start,
+					    cmd.length, cmd.hca_va,
+					    cmd.access_flags, pd, &udata);
 	if (!ret) {
 		if (cmd.flags & IB_MR_REREG_PD) {
 			atomic_inc(&pd->usecnt);
@@ -883,7 +884,7 @@ ssize_t ib_uverbs_alloc_mw(struct ib_uverbs_file *file,
 		   in_len - sizeof(cmd) - sizeof(struct ib_uverbs_cmd_hdr),
 		   out_len - sizeof(resp));
 
-	mw = pd->device->alloc_mw(pd, cmd.mw_type, &udata);
+	mw = pd->device->ops.alloc_mw(pd, cmd.mw_type, &udata);
 	if (IS_ERR(mw)) {
 		ret = PTR_ERR(mw);
 		goto err_put;
@@ -992,7 +993,7 @@ static struct ib_ucq_object *create_cq(struct ib_uverbs_file *file,
 	if (IS_ERR(obj))
 		return obj;
 
-	if (!ib_dev->create_cq) {
+	if (!ib_dev->ops.create_cq) {
 		ret = -EOPNOTSUPP;
 		goto err;
 	}
@@ -1017,7 +1018,7 @@ static struct ib_ucq_object *create_cq(struct ib_uverbs_file *file,
 	if (cmd_sz > offsetof(typeof(*cmd), flags) + sizeof(cmd->flags))
 		attr.flags = cmd->flags;
 
-	cq = ib_dev->create_cq(ib_dev, &attr, obj->uobject.context, uhw);
+	cq = ib_dev->ops.create_cq(ib_dev, &attr, obj->uobject.context, uhw);
 	if (IS_ERR(cq)) {
 		ret = PTR_ERR(cq);
 		goto err_file;
@@ -1182,7 +1183,7 @@ ssize_t ib_uverbs_resize_cq(struct ib_uverbs_file *file,
 	if (!cq)
 		return -EINVAL;
 
-	ret = cq->device->resize_cq(cq, cmd.cqe, &udata);
+	ret = cq->device->ops.resize_cq(cq, cmd.cqe, &udata);
 	if (ret)
 		goto out;
 
@@ -2328,7 +2329,7 @@ ssize_t ib_uverbs_post_send(struct ib_uverbs_file *file,
 	}
 
 	resp.bad_wr = 0;
-	ret = qp->device->post_send(qp->real_qp, wr, &bad_wr);
+	ret = qp->device->ops.post_send(qp->real_qp, wr, &bad_wr);
 	if (ret)
 		for (next = wr; next; next = next->next) {
 			++resp.bad_wr;
@@ -2473,7 +2474,7 @@ ssize_t ib_uverbs_post_recv(struct ib_uverbs_file *file,
 		goto out;
 
 	resp.bad_wr = 0;
-	ret = qp->device->post_recv(qp->real_qp, wr, &bad_wr);
+	ret = qp->device->ops.post_recv(qp->real_qp, wr, &bad_wr);
 
 	uobj_put_obj_read(qp);
 	if (ret) {
@@ -2522,8 +2523,8 @@ ssize_t ib_uverbs_post_srq_recv(struct ib_uverbs_file *file,
 		goto out;
 
 	resp.bad_wr = 0;
-	ret = srq->device->post_srq_recv ?
-		srq->device->post_srq_recv(srq, wr, &bad_wr) : -EOPNOTSUPP;
+	ret = srq->device->ops.post_srq_recv ?
+		srq->device->ops.post_srq_recv(srq, wr, &bad_wr) : -EOPNOTSUPP;
 
 	uobj_put_obj_read(srq);
 
@@ -3125,11 +3126,11 @@ int ib_uverbs_ex_create_wq(struct ib_uverbs_file *file,
 	obj->uevent.events_reported = 0;
 	INIT_LIST_HEAD(&obj->uevent.event_list);
 
-	if (!pd->device->create_wq) {
+	if (!pd->device->ops.create_wq) {
 		err = -EOPNOTSUPP;
 		goto err_put_cq;
 	}
-	wq = pd->device->create_wq(pd, &wq_init_attr, uhw);
+	wq = pd->device->ops.create_wq(pd, &wq_init_attr, uhw);
 	if (IS_ERR(wq)) {
 		err = PTR_ERR(wq);
 		goto err_put_cq;
@@ -3260,11 +3261,11 @@ int ib_uverbs_ex_modify_wq(struct ib_uverbs_file *file,
 		wq_attr.flags = cmd.flags;
 		wq_attr.flags_mask = cmd.flags_mask;
 	}
-	if (!wq->device->modify_wq) {
+	if (!wq->device->ops.modify_wq) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
-	ret = wq->device->modify_wq(wq, &wq_attr, cmd.attr_mask, uhw);
+	ret = wq->device->ops.modify_wq(wq, &wq_attr, cmd.attr_mask, uhw);
 out:
 	uobj_put_obj_read(wq);
 	return ret;
@@ -3363,11 +3364,12 @@ int ib_uverbs_ex_create_rwq_ind_table(struct ib_uverbs_file *file,
 	init_attr.log_ind_tbl_size = cmd.log_ind_tbl_size;
 	init_attr.ind_tbl = wqs;
 
-	if (!ib_dev->create_rwq_ind_table) {
+	if (!ib_dev->ops.create_rwq_ind_table) {
 		err = -EOPNOTSUPP;
 		goto err_uobj;
 	}
-	rwq_ind_tbl = ib_dev->create_rwq_ind_table(ib_dev, &init_attr, uhw);
+	rwq_ind_tbl = ib_dev->ops.create_rwq_ind_table(ib_dev,
+						       &init_attr, uhw);
 
 	if (IS_ERR(rwq_ind_tbl)) {
 		err = PTR_ERR(rwq_ind_tbl);
@@ -3531,7 +3533,7 @@ int ib_uverbs_ex_create_flow(struct ib_uverbs_file *file,
 		goto err_put;
 	}
 
-	if (!qp->device->create_flow) {
+	if (!qp->device->ops.create_flow) {
 		err = -EOPNOTSUPP;
 		goto err_put;
 	}
@@ -3580,8 +3582,8 @@ int ib_uverbs_ex_create_flow(struct ib_uverbs_file *file,
 		goto err_free;
 	}
 
-	flow_id = qp->device->create_flow(qp, flow_attr,
-					  IB_FLOW_DOMAIN_USER, uhw);
+	flow_id = qp->device->ops.create_flow(qp, flow_attr,
+					      IB_FLOW_DOMAIN_USER, uhw);
 
 	if (IS_ERR(flow_id)) {
 		err = PTR_ERR(flow_id);
@@ -3604,7 +3606,7 @@ int ib_uverbs_ex_create_flow(struct ib_uverbs_file *file,
 		kfree(kern_flow_attr);
 	return uobj_alloc_commit(uobj, 0);
 err_copy:
-	if (!qp->device->destroy_flow(flow_id))
+	if (!qp->device->ops.destroy_flow(flow_id))
 		atomic_dec(&qp->usecnt);
 err_free:
 	ib_uverbs_flow_resources_free(uflow_res);
@@ -3705,7 +3707,7 @@ static int __uverbs_create_xsrq(struct ib_uverbs_file *file,
 	obj->uevent.events_reported = 0;
 	INIT_LIST_HEAD(&obj->uevent.event_list);
 
-	srq = pd->device->create_srq(pd, &attr, udata);
+	srq = pd->device->ops.create_srq(pd, &attr, udata);
 	if (IS_ERR(srq)) {
 		ret = PTR_ERR(srq);
 		goto err_put;
@@ -3863,7 +3865,7 @@ ssize_t ib_uverbs_modify_srq(struct ib_uverbs_file *file,
 	attr.max_wr    = cmd.max_wr;
 	attr.srq_limit = cmd.srq_limit;
 
-	ret = srq->device->modify_srq(srq, &attr, cmd.attr_mask, &udata);
+	ret = srq->device->ops.modify_srq(srq, &attr, cmd.attr_mask, &udata);
 
 	uobj_put_obj_read(srq);
 
@@ -3953,7 +3955,7 @@ int ib_uverbs_ex_query_device(struct ib_uverbs_file *file,
 		return PTR_ERR(ucontext);
 	ib_dev = ucontext->device;
 
-	if (!ib_dev->query_device)
+	if (!ib_dev->ops.query_device)
 		return -EOPNOTSUPP;
 
 	if (ucore->inlen < sizeof(cmd))
@@ -3974,7 +3976,7 @@ int ib_uverbs_ex_query_device(struct ib_uverbs_file *file,
 	if (ucore->outlen < resp.response_length)
 		return -ENOSPC;
 
-	err = ib_dev->query_device(ib_dev, &attr, uhw);
+	err = ib_dev->ops.query_device(ib_dev, &attr, uhw);
 	if (err)
 		return err;
 
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 12d8f8097574..3971bf86807d 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -164,7 +164,7 @@ int uverbs_dealloc_mw(struct ib_mw *mw)
 	struct ib_pd *pd = mw->pd;
 	int ret;
 
-	ret = mw->device->dealloc_mw(mw);
+	ret = mw->device->ops.dealloc_mw(mw);
 	if (!ret)
 		atomic_dec(&pd->usecnt);
 	return ret;
@@ -255,7 +255,7 @@ void ib_uverbs_release_file(struct kref *ref)
 	srcu_key = srcu_read_lock(&file->device->disassociate_srcu);
 	ib_dev = srcu_dereference(file->device->ib_dev,
 				  &file->device->disassociate_srcu);
-	if (ib_dev && !ib_dev->disassociate_ucontext)
+	if (ib_dev && !ib_dev->ops.disassociate_ucontext)
 		module_put(ib_dev->owner);
 	srcu_read_unlock(&file->device->disassociate_srcu, srcu_key);
 
@@ -806,7 +806,7 @@ static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma)
 		goto out;
 	}
 
-	ret = ucontext->device->mmap(ucontext, vma);
+	ret = ucontext->device->ops.mmap(ucontext, vma);
 out:
 	srcu_read_unlock(&file->device->disassociate_srcu, srcu_key);
 	return ret;
@@ -1068,7 +1068,7 @@ static int ib_uverbs_open(struct inode *inode, struct file *filp)
 	/* In case IB device supports disassociate ucontext, there is no hard
 	 * dependency between uverbs device and its low level device.
 	 */
-	module_dependent = !(ib_dev->disassociate_ucontext);
+	module_dependent = !(ib_dev->ops.disassociate_ucontext);
 
 	if (module_dependent) {
 		if (!try_module_get(ib_dev->owner)) {
@@ -1238,7 +1238,7 @@ static void ib_uverbs_add_one(struct ib_device *device)
 	struct ib_uverbs_device *uverbs_dev;
 	int ret;
 
-	if (!device->alloc_ucontext)
+	if (!device->ops.alloc_ucontext)
 		return;
 
 	uverbs_dev = kzalloc(sizeof(*uverbs_dev), GFP_KERNEL);
@@ -1284,7 +1284,7 @@ static void ib_uverbs_add_one(struct ib_device *device)
 	dev_set_name(&uverbs_dev->dev, "uverbs%d", uverbs_dev->devnum);
 
 	cdev_init(&uverbs_dev->cdev,
-		  device->mmap ? &uverbs_mmap_fops : &uverbs_fops);
+		  device->ops.mmap ? &uverbs_mmap_fops : &uverbs_fops);
 	uverbs_dev->cdev.owner = THIS_MODULE;
 
 	ret = cdev_device_add(&uverbs_dev->cdev, &uverbs_dev->dev);
@@ -1372,7 +1372,7 @@ static void ib_uverbs_remove_one(struct ib_device *device, void *client_data)
 	cdev_device_del(&uverbs_dev->cdev, &uverbs_dev->dev);
 	clear_bit(uverbs_dev->devnum, dev_map);
 
-	if (device->disassociate_ucontext) {
+	if (device->ops.disassociate_ucontext) {
 		/* We disassociate HW resources and immediately return.
 		 * Userspace will see a EIO errno for all future access.
 		 * Upon returning, ib_device may be freed internally and is not
diff --git a/drivers/infiniband/core/uverbs_std_types.c b/drivers/infiniband/core/uverbs_std_types.c
index 203cc96ac6f5..dd433387907e 100644
--- a/drivers/infiniband/core/uverbs_std_types.c
+++ b/drivers/infiniband/core/uverbs_std_types.c
@@ -54,7 +54,7 @@ static int uverbs_free_flow(struct ib_uobject *uobject,
 	struct ib_qp *qp = flow->qp;
 	int ret;
 
-	ret = flow->device->destroy_flow(flow);
+	ret = flow->device->ops.destroy_flow(flow);
 	if (!ret) {
 		if (qp)
 			atomic_dec(&qp->usecnt);
diff --git a/drivers/infiniband/core/uverbs_std_types_counters.c b/drivers/infiniband/core/uverbs_std_types_counters.c
index a0ffdcf9a51c..11c15712fb8c 100644
--- a/drivers/infiniband/core/uverbs_std_types_counters.c
+++ b/drivers/infiniband/core/uverbs_std_types_counters.c
@@ -44,7 +44,7 @@ static int uverbs_free_counters(struct ib_uobject *uobject,
 	if (ret)
 		return ret;
 
-	return counters->device->destroy_counters(counters);
+	return counters->device->ops.destroy_counters(counters);
 }
 
 static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_CREATE)(
@@ -61,10 +61,10 @@ static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_CREATE)(
 	 * have the ability to remove methods from parse tree once
 	 * such condition is met.
 	 */
-	if (!ib_dev->create_counters)
+	if (!ib_dev->ops.create_counters)
 		return -EOPNOTSUPP;
 
-	counters = ib_dev->create_counters(ib_dev, attrs);
+	counters = ib_dev->ops.create_counters(ib_dev, attrs);
 	if (IS_ERR(counters)) {
 		ret = PTR_ERR(counters);
 		goto err_create_counters;
@@ -90,7 +90,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_READ)(
 		uverbs_attr_get_obj(attrs, UVERBS_ATTR_READ_COUNTERS_HANDLE);
 	int ret;
 
-	if (!counters->device->read_counters)
+	if (!counters->device->ops.read_counters)
 		return -EOPNOTSUPP;
 
 	if (!atomic_read(&counters->usecnt))
@@ -109,7 +109,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_READ)(
 	if (IS_ERR(read_attr.counters_buff))
 		return PTR_ERR(read_attr.counters_buff);
 
-	ret = counters->device->read_counters(counters, &read_attr, attrs);
+	ret = counters->device->ops.read_counters(counters, &read_attr, attrs);
 	if (ret)
 		return ret;
 
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 5b5f2052cd52..5e396bae9649 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -72,7 +72,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	struct ib_uverbs_completion_event_file    *ev_file = NULL;
 	struct ib_uobject *ev_file_uobj;
 
-	if (!ib_dev->create_cq || !ib_dev->destroy_cq)
+	if (!ib_dev->ops.create_cq || !ib_dev->ops.destroy_cq)
 		return -EOPNOTSUPP;
 
 	ret = uverbs_copy_from(&attr.comp_vector, attrs,
@@ -114,7 +114,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	/* Temporary, only until drivers get the new uverbs_attr_bundle */
 	create_udata(attrs, &uhw);
 
-	cq = ib_dev->create_cq(ib_dev, &attr, obj->uobject.context, &uhw);
+	cq = ib_dev->ops.create_cq(ib_dev, &attr, obj->uobject.context, &uhw);
 	if (IS_ERR(cq)) {
 		ret = PTR_ERR(cq);
 		goto err_event_file;
diff --git a/drivers/infiniband/core/uverbs_std_types_dm.c b/drivers/infiniband/core/uverbs_std_types_dm.c
index edc3ff7733d4..73747943cdab 100644
--- a/drivers/infiniband/core/uverbs_std_types_dm.c
+++ b/drivers/infiniband/core/uverbs_std_types_dm.c
@@ -43,7 +43,7 @@ static int uverbs_free_dm(struct ib_uobject *uobject,
 	if (ret)
 		return ret;
 
-	return dm->device->dealloc_dm(dm);
+	return dm->device->ops.dealloc_dm(dm);
 }
 
 static int
@@ -58,7 +58,7 @@ UVERBS_HANDLER(UVERBS_METHOD_DM_ALLOC)(struct ib_uverbs_file *file,
 	struct ib_dm *dm;
 	int ret;
 
-	if (!ib_dev->alloc_dm)
+	if (!ib_dev->ops.alloc_dm)
 		return -EOPNOTSUPP;
 
 	ret = uverbs_copy_from(&attr.length, attrs,
@@ -71,7 +71,7 @@ UVERBS_HANDLER(UVERBS_METHOD_DM_ALLOC)(struct ib_uverbs_file *file,
 	if (ret)
 		return ret;
 
-	dm = ib_dev->alloc_dm(ib_dev, uobj->context, &attr, attrs);
+	dm = ib_dev->ops.alloc_dm(ib_dev, uobj->context, &attr, attrs);
 	if (IS_ERR(dm))
 		return PTR_ERR(dm);
 
diff --git a/drivers/infiniband/core/uverbs_std_types_flow_action.c b/drivers/infiniband/core/uverbs_std_types_flow_action.c
index cb9486ad5c67..99d49153b621 100644
--- a/drivers/infiniband/core/uverbs_std_types_flow_action.c
+++ b/drivers/infiniband/core/uverbs_std_types_flow_action.c
@@ -43,7 +43,7 @@ static int uverbs_free_flow_action(struct ib_uobject *uobject,
 	if (ret)
 		return ret;
 
-	return action->device->destroy_flow_action(action);
+	return action->device->ops.destroy_flow_action(action);
 }
 
 static u64 esp_flags_uverbs_to_verbs(struct uverbs_attr_bundle *attrs,
@@ -314,7 +314,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_FLOW_ACTION_ESP_CREATE)(
 	struct ib_flow_action		  *action;
 	struct ib_flow_action_esp_attr	  esp_attr = {};
 
-	if (!ib_dev->create_flow_action_esp)
+	if (!ib_dev->ops.create_flow_action_esp)
 		return -EOPNOTSUPP;
 
 	ret = parse_flow_action_esp(ib_dev, file, attrs, &esp_attr, false);
@@ -322,7 +322,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_FLOW_ACTION_ESP_CREATE)(
 		return ret;
 
 	/* No need to check as this attribute is marked as MANDATORY */
-	action = ib_dev->create_flow_action_esp(ib_dev, &esp_attr.hdr, attrs);
+	action = ib_dev->ops.create_flow_action_esp(ib_dev, &esp_attr.hdr,
+						    attrs);
 	if (IS_ERR(action))
 		return PTR_ERR(action);
 
@@ -341,7 +342,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_FLOW_ACTION_ESP_MODIFY)(
 	int				  ret;
 	struct ib_flow_action_esp_attr	  esp_attr = {};
 
-	if (!action->device->modify_flow_action_esp)
+	if (!action->device->ops.modify_flow_action_esp)
 		return -EOPNOTSUPP;
 
 	ret = parse_flow_action_esp(action->device, file, attrs, &esp_attr,
@@ -352,8 +353,9 @@ static int UVERBS_HANDLER(UVERBS_METHOD_FLOW_ACTION_ESP_MODIFY)(
 	if (action->type != IB_FLOW_ACTION_ESP)
 		return -EINVAL;
 
-	return action->device->modify_flow_action_esp(action, &esp_attr.hdr,
-						      attrs);
+	return action->device->ops.modify_flow_action_esp(action,
+							  &esp_attr.hdr,
+							  attrs);
 }
 
 static const struct uverbs_attr_spec uverbs_flow_action_esp_keymat[] = {
diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index cf02e774303e..8b06da9c9edb 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -54,7 +54,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
 	struct ib_mr *mr;
 	int ret;
 
-	if (!ib_dev->reg_dm_mr)
+	if (!ib_dev->ops.reg_dm_mr)
 		return -EOPNOTSUPP;
 
 	ret = uverbs_copy_from(&attr.offset, attrs, UVERBS_ATTR_REG_DM_MR_OFFSET);
@@ -83,7 +83,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
 	    attr.length > dm->length - attr.offset)
 		return -EINVAL;
 
-	mr = pd->device->reg_dm_mr(pd, dm, &attr, attrs);
+	mr = pd->device->ops.reg_dm_mr(pd, dm, &attr, attrs);
 	if (IS_ERR(mr))
 		return PTR_ERR(mr);
 
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 65a7e0b44ad7..85d475a6d388 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -214,8 +214,8 @@ EXPORT_SYMBOL(rdma_node_get_transport);
 enum rdma_link_layer rdma_port_get_link_layer(struct ib_device *device, u8 port_num)
 {
 	enum rdma_transport_type lt;
-	if (device->get_link_layer)
-		return device->get_link_layer(device, port_num);
+	if (device->ops.get_link_layer)
+		return device->ops.get_link_layer(device, port_num);
 
 	lt = rdma_node_get_transport(device->node_type);
 	if (lt == RDMA_TRANSPORT_IB)
@@ -243,7 +243,7 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
 	struct ib_pd *pd;
 	int mr_access_flags = 0;
 
-	pd = device->alloc_pd(device, NULL, NULL);
+	pd = device->ops.alloc_pd(device, NULL, NULL);
 	if (IS_ERR(pd))
 		return pd;
 
@@ -270,7 +270,7 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
 	if (mr_access_flags) {
 		struct ib_mr *mr;
 
-		mr = pd->device->get_dma_mr(pd, mr_access_flags);
+		mr = pd->device->ops.get_dma_mr(pd, mr_access_flags);
 		if (IS_ERR(mr)) {
 			ib_dealloc_pd(pd);
 			return ERR_CAST(mr);
@@ -307,7 +307,7 @@ void ib_dealloc_pd(struct ib_pd *pd)
 	int ret;
 
 	if (pd->__internal_mr) {
-		ret = pd->device->dereg_mr(pd->__internal_mr);
+		ret = pd->device->ops.dereg_mr(pd->__internal_mr);
 		WARN_ON(ret);
 		pd->__internal_mr = NULL;
 	}
@@ -319,7 +319,7 @@ void ib_dealloc_pd(struct ib_pd *pd)
 	rdma_restrack_del(&pd->res);
 	/* Making delalloc_pd a void return is a WIP, no driver should return
 	   an error here. */
-	ret = pd->device->dealloc_pd(pd);
+	ret = pd->device->ops.dealloc_pd(pd);
 	WARN_ONCE(ret, "Infiniband HW driver failed dealloc_pd");
 }
 EXPORT_SYMBOL(ib_dealloc_pd);
@@ -479,10 +479,10 @@ static struct ib_ah *_rdma_create_ah(struct ib_pd *pd,
 {
 	struct ib_ah *ah;
 
-	if (!pd->device->create_ah)
+	if (!pd->device->ops.create_ah)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	ah = pd->device->create_ah(pd, ah_attr, udata);
+	ah = pd->device->ops.create_ah(pd, ah_attr, udata);
 
 	if (!IS_ERR(ah)) {
 		ah->device  = pd->device;
@@ -888,8 +888,8 @@ int rdma_modify_ah(struct ib_ah *ah, struct rdma_ah_attr *ah_attr)
 	if (ret)
 		return ret;
 
-	ret = ah->device->modify_ah ?
-		ah->device->modify_ah(ah, ah_attr) :
+	ret = ah->device->ops.modify_ah ?
+		ah->device->ops.modify_ah(ah, ah_attr) :
 		-EOPNOTSUPP;
 
 	ah->sgid_attr = rdma_update_sgid_attr(ah_attr, ah->sgid_attr);
@@ -902,8 +902,8 @@ int rdma_query_ah(struct ib_ah *ah, struct rdma_ah_attr *ah_attr)
 {
 	ah_attr->grh.sgid_attr = NULL;
 
-	return ah->device->query_ah ?
-		ah->device->query_ah(ah, ah_attr) :
+	return ah->device->ops.query_ah ?
+		ah->device->ops.query_ah(ah, ah_attr) :
 		-EOPNOTSUPP;
 }
 EXPORT_SYMBOL(rdma_query_ah);
@@ -915,7 +915,7 @@ int rdma_destroy_ah(struct ib_ah *ah)
 	int ret;
 
 	pd = ah->pd;
-	ret = ah->device->destroy_ah(ah);
+	ret = ah->device->ops.destroy_ah(ah);
 	if (!ret) {
 		atomic_dec(&pd->usecnt);
 		if (sgid_attr)
@@ -933,10 +933,10 @@ struct ib_srq *ib_create_srq(struct ib_pd *pd,
 {
 	struct ib_srq *srq;
 
-	if (!pd->device->create_srq)
+	if (!pd->device->ops.create_srq)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	srq = pd->device->create_srq(pd, srq_init_attr, NULL);
+	srq = pd->device->ops.create_srq(pd, srq_init_attr, NULL);
 
 	if (!IS_ERR(srq)) {
 		srq->device    	   = pd->device;
@@ -965,17 +965,17 @@ int ib_modify_srq(struct ib_srq *srq,
 		  struct ib_srq_attr *srq_attr,
 		  enum ib_srq_attr_mask srq_attr_mask)
 {
-	return srq->device->modify_srq ?
-		srq->device->modify_srq(srq, srq_attr, srq_attr_mask, NULL) :
-		-EOPNOTSUPP;
+	return srq->device->ops.modify_srq ?
+		srq->device->ops.modify_srq(srq, srq_attr, srq_attr_mask,
+					    NULL) : -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(ib_modify_srq);
 
 int ib_query_srq(struct ib_srq *srq,
 		 struct ib_srq_attr *srq_attr)
 {
-	return srq->device->query_srq ?
-		srq->device->query_srq(srq, srq_attr) : -EOPNOTSUPP;
+	return srq->device->ops.query_srq ?
+		srq->device->ops.query_srq(srq, srq_attr) : -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(ib_query_srq);
 
@@ -997,7 +997,7 @@ int ib_destroy_srq(struct ib_srq *srq)
 	if (srq_type == IB_SRQT_XRC)
 		xrcd = srq->ext.xrc.xrcd;
 
-	ret = srq->device->destroy_srq(srq);
+	ret = srq->device->ops.destroy_srq(srq);
 	if (!ret) {
 		atomic_dec(&pd->usecnt);
 		if (srq_type == IB_SRQT_XRC)
@@ -1106,7 +1106,7 @@ static struct ib_qp *ib_create_xrc_qp(struct ib_qp *qp,
 	if (!IS_ERR(qp))
 		__ib_insert_xrcd_qp(qp_init_attr->xrcd, real_qp);
 	else
-		real_qp->device->destroy_qp(real_qp);
+		real_qp->device->ops.destroy_qp(real_qp);
 	return qp;
 }
 
@@ -1692,10 +1692,10 @@ int ib_get_eth_speed(struct ib_device *dev, u8 port_num, u8 *speed, u8 *width)
 	if (rdma_port_get_link_layer(dev, port_num) != IB_LINK_LAYER_ETHERNET)
 		return -EINVAL;
 
-	if (!dev->get_netdev)
+	if (!dev->ops.get_netdev)
 		return -EOPNOTSUPP;
 
-	netdev = dev->get_netdev(dev, port_num);
+	netdev = dev->ops.get_netdev(dev, port_num);
 	if (!netdev)
 		return -ENODEV;
 
@@ -1753,9 +1753,9 @@ int ib_query_qp(struct ib_qp *qp,
 	qp_attr->ah_attr.grh.sgid_attr = NULL;
 	qp_attr->alt_ah_attr.grh.sgid_attr = NULL;
 
-	return qp->device->query_qp ?
-		qp->device->query_qp(qp->real_qp, qp_attr, qp_attr_mask, qp_init_attr) :
-		-EOPNOTSUPP;
+	return qp->device->ops.query_qp ?
+		qp->device->ops.query_qp(qp->real_qp, qp_attr, qp_attr_mask,
+					 qp_init_attr) : -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(ib_query_qp);
 
@@ -1841,7 +1841,7 @@ int ib_destroy_qp(struct ib_qp *qp)
 		rdma_rw_cleanup_mrs(qp);
 
 	rdma_restrack_del(&qp->res);
-	ret = qp->device->destroy_qp(qp);
+	ret = qp->device->ops.destroy_qp(qp);
 	if (!ret) {
 		if (alt_path_sgid_attr)
 			rdma_put_gid_attr(alt_path_sgid_attr);
@@ -1879,7 +1879,7 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 {
 	struct ib_cq *cq;
 
-	cq = device->create_cq(device, cq_attr, NULL, NULL);
+	cq = device->ops.create_cq(device, cq_attr, NULL, NULL);
 
 	if (!IS_ERR(cq)) {
 		cq->device        = device;
@@ -1899,8 +1899,9 @@ EXPORT_SYMBOL(__ib_create_cq);
 
 int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period)
 {
-	return cq->device->modify_cq ?
-		cq->device->modify_cq(cq, cq_count, cq_period) : -EOPNOTSUPP;
+	return cq->device->ops.modify_cq ?
+		cq->device->ops.modify_cq(cq, cq_count,
+					  cq_period) : -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(rdma_set_cq_moderation);
 
@@ -1910,14 +1911,14 @@ int ib_destroy_cq(struct ib_cq *cq)
 		return -EBUSY;
 
 	rdma_restrack_del(&cq->res);
-	return cq->device->destroy_cq(cq);
+	return cq->device->ops.destroy_cq(cq);
 }
 EXPORT_SYMBOL(ib_destroy_cq);
 
 int ib_resize_cq(struct ib_cq *cq, int cqe)
 {
-	return cq->device->resize_cq ?
-		cq->device->resize_cq(cq, cqe, NULL) : -EOPNOTSUPP;
+	return cq->device->ops.resize_cq ?
+		cq->device->ops.resize_cq(cq, cqe, NULL) : -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(ib_resize_cq);
 
@@ -1930,7 +1931,7 @@ int ib_dereg_mr(struct ib_mr *mr)
 	int ret;
 
 	rdma_restrack_del(&mr->res);
-	ret = mr->device->dereg_mr(mr);
+	ret = mr->device->ops.dereg_mr(mr);
 	if (!ret) {
 		atomic_dec(&pd->usecnt);
 		if (dm)
@@ -1959,10 +1960,10 @@ struct ib_mr *ib_alloc_mr(struct ib_pd *pd,
 {
 	struct ib_mr *mr;
 
-	if (!pd->device->alloc_mr)
+	if (!pd->device->ops.alloc_mr)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	mr = pd->device->alloc_mr(pd, mr_type, max_num_sg);
+	mr = pd->device->ops.alloc_mr(pd, mr_type, max_num_sg);
 	if (!IS_ERR(mr)) {
 		mr->device  = pd->device;
 		mr->pd      = pd;
@@ -1986,10 +1987,10 @@ struct ib_fmr *ib_alloc_fmr(struct ib_pd *pd,
 {
 	struct ib_fmr *fmr;
 
-	if (!pd->device->alloc_fmr)
+	if (!pd->device->ops.alloc_fmr)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	fmr = pd->device->alloc_fmr(pd, mr_access_flags, fmr_attr);
+	fmr = pd->device->ops.alloc_fmr(pd, mr_access_flags, fmr_attr);
 	if (!IS_ERR(fmr)) {
 		fmr->device = pd->device;
 		fmr->pd     = pd;
@@ -2008,7 +2009,7 @@ int ib_unmap_fmr(struct list_head *fmr_list)
 		return 0;
 
 	fmr = list_entry(fmr_list->next, struct ib_fmr, list);
-	return fmr->device->unmap_fmr(fmr_list);
+	return fmr->device->ops.unmap_fmr(fmr_list);
 }
 EXPORT_SYMBOL(ib_unmap_fmr);
 
@@ -2018,7 +2019,7 @@ int ib_dealloc_fmr(struct ib_fmr *fmr)
 	int ret;
 
 	pd = fmr->pd;
-	ret = fmr->device->dealloc_fmr(fmr);
+	ret = fmr->device->ops.dealloc_fmr(fmr);
 	if (!ret)
 		atomic_dec(&pd->usecnt);
 
@@ -2070,14 +2071,14 @@ int ib_attach_mcast(struct ib_qp *qp, union ib_gid *gid, u16 lid)
 {
 	int ret;
 
-	if (!qp->device->attach_mcast)
+	if (!qp->device->ops.attach_mcast)
 		return -EOPNOTSUPP;
 
 	if (!rdma_is_multicast_addr((struct in6_addr *)gid->raw) ||
 	    qp->qp_type != IB_QPT_UD || !is_valid_mcast_lid(qp, lid))
 		return -EINVAL;
 
-	ret = qp->device->attach_mcast(qp, gid, lid);
+	ret = qp->device->ops.attach_mcast(qp, gid, lid);
 	if (!ret)
 		atomic_inc(&qp->usecnt);
 	return ret;
@@ -2088,14 +2089,14 @@ int ib_detach_mcast(struct ib_qp *qp, union ib_gid *gid, u16 lid)
 {
 	int ret;
 
-	if (!qp->device->detach_mcast)
+	if (!qp->device->ops.detach_mcast)
 		return -EOPNOTSUPP;
 
 	if (!rdma_is_multicast_addr((struct in6_addr *)gid->raw) ||
 	    qp->qp_type != IB_QPT_UD || !is_valid_mcast_lid(qp, lid))
 		return -EINVAL;
 
-	ret = qp->device->detach_mcast(qp, gid, lid);
+	ret = qp->device->ops.detach_mcast(qp, gid, lid);
 	if (!ret)
 		atomic_dec(&qp->usecnt);
 	return ret;
@@ -2106,10 +2107,10 @@ struct ib_xrcd *__ib_alloc_xrcd(struct ib_device *device, const char *caller)
 {
 	struct ib_xrcd *xrcd;
 
-	if (!device->alloc_xrcd)
+	if (!device->ops.alloc_xrcd)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	xrcd = device->alloc_xrcd(device, NULL, NULL);
+	xrcd = device->ops.alloc_xrcd(device, NULL, NULL);
 	if (!IS_ERR(xrcd)) {
 		xrcd->device = device;
 		xrcd->inode = NULL;
@@ -2137,7 +2138,7 @@ int ib_dealloc_xrcd(struct ib_xrcd *xrcd)
 			return ret;
 	}
 
-	return xrcd->device->dealloc_xrcd(xrcd);
+	return xrcd->device->ops.dealloc_xrcd(xrcd);
 }
 EXPORT_SYMBOL(ib_dealloc_xrcd);
 
@@ -2160,10 +2161,10 @@ struct ib_wq *ib_create_wq(struct ib_pd *pd,
 {
 	struct ib_wq *wq;
 
-	if (!pd->device->create_wq)
+	if (!pd->device->ops.create_wq)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	wq = pd->device->create_wq(pd, wq_attr, NULL);
+	wq = pd->device->ops.create_wq(pd, wq_attr, NULL);
 	if (!IS_ERR(wq)) {
 		wq->event_handler = wq_attr->event_handler;
 		wq->wq_context = wq_attr->wq_context;
@@ -2193,7 +2194,7 @@ int ib_destroy_wq(struct ib_wq *wq)
 	if (atomic_read(&wq->usecnt))
 		return -EBUSY;
 
-	err = wq->device->destroy_wq(wq);
+	err = wq->device->ops.destroy_wq(wq);
 	if (!err) {
 		atomic_dec(&pd->usecnt);
 		atomic_dec(&cq->usecnt);
@@ -2215,10 +2216,10 @@ int ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
 {
 	int err;
 
-	if (!wq->device->modify_wq)
+	if (!wq->device->ops.modify_wq)
 		return -EOPNOTSUPP;
 
-	err = wq->device->modify_wq(wq, wq_attr, wq_attr_mask, NULL);
+	err = wq->device->ops.modify_wq(wq, wq_attr, wq_attr_mask, NULL);
 	return err;
 }
 EXPORT_SYMBOL(ib_modify_wq);
@@ -2240,12 +2241,12 @@ struct ib_rwq_ind_table *ib_create_rwq_ind_table(struct ib_device *device,
 	int i;
 	u32 table_size;
 
-	if (!device->create_rwq_ind_table)
+	if (!device->ops.create_rwq_ind_table)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	table_size = (1 << init_attr->log_ind_tbl_size);
-	rwq_ind_table = device->create_rwq_ind_table(device,
-				init_attr, NULL);
+	rwq_ind_table = device->ops.create_rwq_ind_table(device,
+							 init_attr, NULL);
 	if (IS_ERR(rwq_ind_table))
 		return rwq_ind_table;
 
@@ -2275,7 +2276,7 @@ int ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *rwq_ind_table)
 	if (atomic_read(&rwq_ind_table->usecnt))
 		return -EBUSY;
 
-	err = rwq_ind_table->device->destroy_rwq_ind_table(rwq_ind_table);
+	err = rwq_ind_table->device->ops.destroy_rwq_ind_table(rwq_ind_table);
 	if (!err) {
 		for (i = 0; i < table_size; i++)
 			atomic_dec(&ind_tbl[i]->usecnt);
@@ -2288,48 +2289,50 @@ EXPORT_SYMBOL(ib_destroy_rwq_ind_table);
 int ib_check_mr_status(struct ib_mr *mr, u32 check_mask,
 		       struct ib_mr_status *mr_status)
 {
-	return mr->device->check_mr_status ?
-		mr->device->check_mr_status(mr, check_mask, mr_status) : -EOPNOTSUPP;
+	if (!mr->device->ops.check_mr_status)
+		return -EOPNOTSUPP;
+
+	return mr->device->ops.check_mr_status(mr, check_mask, mr_status);
 }
 EXPORT_SYMBOL(ib_check_mr_status);
 
 int ib_set_vf_link_state(struct ib_device *device, int vf, u8 port,
 			 int state)
 {
-	if (!device->set_vf_link_state)
+	if (!device->ops.set_vf_link_state)
 		return -EOPNOTSUPP;
 
-	return device->set_vf_link_state(device, vf, port, state);
+	return device->ops.set_vf_link_state(device, vf, port, state);
 }
 EXPORT_SYMBOL(ib_set_vf_link_state);
 
 int ib_get_vf_config(struct ib_device *device, int vf, u8 port,
 		     struct ifla_vf_info *info)
 {
-	if (!device->get_vf_config)
+	if (!device->ops.get_vf_config)
 		return -EOPNOTSUPP;
 
-	return device->get_vf_config(device, vf, port, info);
+	return device->ops.get_vf_config(device, vf, port, info);
 }
 EXPORT_SYMBOL(ib_get_vf_config);
 
 int ib_get_vf_stats(struct ib_device *device, int vf, u8 port,
 		    struct ifla_vf_stats *stats)
 {
-	if (!device->get_vf_stats)
+	if (!device->ops.get_vf_stats)
 		return -EOPNOTSUPP;
 
-	return device->get_vf_stats(device, vf, port, stats);
+	return device->ops.get_vf_stats(device, vf, port, stats);
 }
 EXPORT_SYMBOL(ib_get_vf_stats);
 
 int ib_set_vf_guid(struct ib_device *device, int vf, u8 port, u64 guid,
 		   int type)
 {
-	if (!device->set_vf_guid)
+	if (!device->ops.set_vf_guid)
 		return -EOPNOTSUPP;
 
-	return device->set_vf_guid(device, vf, port, guid, type);
+	return device->ops.set_vf_guid(device, vf, port, guid, type);
 }
 EXPORT_SYMBOL(ib_set_vf_guid);
 
@@ -2361,12 +2364,12 @@ EXPORT_SYMBOL(ib_set_vf_guid);
 int ib_map_mr_sg(struct ib_mr *mr, struct scatterlist *sg, int sg_nents,
 		 unsigned int *sg_offset, unsigned int page_size)
 {
-	if (unlikely(!mr->device->map_mr_sg))
+	if (unlikely(!mr->device->ops.map_mr_sg))
 		return -EOPNOTSUPP;
 
 	mr->page_size = page_size;
 
-	return mr->device->map_mr_sg(mr, sg, sg_nents, sg_offset);
+	return mr->device->ops.map_mr_sg(mr, sg, sg_nents, sg_offset);
 }
 EXPORT_SYMBOL(ib_map_mr_sg);
 
@@ -2565,8 +2568,8 @@ static void __ib_drain_rq(struct ib_qp *qp)
  */
 void ib_drain_sq(struct ib_qp *qp)
 {
-	if (qp->device->drain_sq)
-		qp->device->drain_sq(qp);
+	if (qp->device->ops.drain_sq)
+		qp->device->ops.drain_sq(qp);
 	else
 		__ib_drain_sq(qp);
 }
@@ -2593,8 +2596,8 @@ EXPORT_SYMBOL(ib_drain_sq);
  */
 void ib_drain_rq(struct ib_qp *qp)
 {
-	if (qp->device->drain_rq)
-		qp->device->drain_rq(qp);
+	if (qp->device->ops.drain_rq)
+		qp->device->ops.drain_rq(qp);
 	else
 		__ib_drain_rq(qp);
 }
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 14cd92bd300f..6d3dba198c89 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -662,58 +662,6 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 			(1ull << IB_USER_VERBS_CMD_DESTROY_AH);
 	/* POLL_CQ and REQ_NOTIFY_CQ is directly handled in libbnxt_re */
 
-	/* Kernel verbs */
-	ibdev->query_device		= bnxt_re_query_device;
-	ibdev->modify_device		= bnxt_re_modify_device;
-
-	ibdev->query_port		= bnxt_re_query_port;
-	ibdev->get_port_immutable	= bnxt_re_get_port_immutable;
-	ibdev->get_dev_fw_str           = bnxt_re_query_fw_str;
-	ibdev->query_pkey		= bnxt_re_query_pkey;
-	ibdev->get_netdev		= bnxt_re_get_netdev;
-	ibdev->add_gid			= bnxt_re_add_gid;
-	ibdev->del_gid			= bnxt_re_del_gid;
-	ibdev->get_link_layer		= bnxt_re_get_link_layer;
-
-	ibdev->alloc_pd			= bnxt_re_alloc_pd;
-	ibdev->dealloc_pd		= bnxt_re_dealloc_pd;
-
-	ibdev->create_ah		= bnxt_re_create_ah;
-	ibdev->modify_ah		= bnxt_re_modify_ah;
-	ibdev->query_ah			= bnxt_re_query_ah;
-	ibdev->destroy_ah		= bnxt_re_destroy_ah;
-
-	ibdev->create_srq		= bnxt_re_create_srq;
-	ibdev->modify_srq		= bnxt_re_modify_srq;
-	ibdev->query_srq		= bnxt_re_query_srq;
-	ibdev->destroy_srq		= bnxt_re_destroy_srq;
-	ibdev->post_srq_recv		= bnxt_re_post_srq_recv;
-
-	ibdev->create_qp		= bnxt_re_create_qp;
-	ibdev->modify_qp		= bnxt_re_modify_qp;
-	ibdev->query_qp			= bnxt_re_query_qp;
-	ibdev->destroy_qp		= bnxt_re_destroy_qp;
-
-	ibdev->post_send		= bnxt_re_post_send;
-	ibdev->post_recv		= bnxt_re_post_recv;
-
-	ibdev->create_cq		= bnxt_re_create_cq;
-	ibdev->destroy_cq		= bnxt_re_destroy_cq;
-	ibdev->poll_cq			= bnxt_re_poll_cq;
-	ibdev->req_notify_cq		= bnxt_re_req_notify_cq;
-
-	ibdev->get_dma_mr		= bnxt_re_get_dma_mr;
-	ibdev->dereg_mr			= bnxt_re_dereg_mr;
-	ibdev->alloc_mr			= bnxt_re_alloc_mr;
-	ibdev->map_mr_sg		= bnxt_re_map_mr_sg;
-
-	ibdev->reg_user_mr		= bnxt_re_reg_user_mr;
-	ibdev->alloc_ucontext		= bnxt_re_alloc_ucontext;
-	ibdev->dealloc_ucontext		= bnxt_re_dealloc_ucontext;
-	ibdev->mmap			= bnxt_re_mmap;
-	ibdev->get_hw_stats             = bnxt_re_ib_get_hw_stats;
-	ibdev->alloc_hw_stats           = bnxt_re_ib_alloc_hw_stats;
-
 	ibdev->driver_id = RDMA_DRIVER_BNXT_RE;
 	ib_set_device_ops(ibdev, &bnxt_re_dev_ops);
 	return ib_register_device(ibdev, "bnxt_re%d", NULL);
diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
index 4fe13dd1ef7d..4533d50ce6b6 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
@@ -1386,37 +1386,7 @@ int iwch_register_device(struct iwch_dev *dev)
 	dev->ibdev.phys_port_cnt = dev->rdev.port_info.nports;
 	dev->ibdev.num_comp_vectors = 1;
 	dev->ibdev.dev.parent = &dev->rdev.rnic_info.pdev->dev;
-	dev->ibdev.query_device = iwch_query_device;
-	dev->ibdev.query_port = iwch_query_port;
-	dev->ibdev.query_pkey = iwch_query_pkey;
-	dev->ibdev.query_gid = iwch_query_gid;
-	dev->ibdev.alloc_ucontext = iwch_alloc_ucontext;
-	dev->ibdev.dealloc_ucontext = iwch_dealloc_ucontext;
-	dev->ibdev.mmap = iwch_mmap;
-	dev->ibdev.alloc_pd = iwch_allocate_pd;
-	dev->ibdev.dealloc_pd = iwch_deallocate_pd;
-	dev->ibdev.create_qp = iwch_create_qp;
-	dev->ibdev.modify_qp = iwch_ib_modify_qp;
-	dev->ibdev.destroy_qp = iwch_destroy_qp;
-	dev->ibdev.create_cq = iwch_create_cq;
-	dev->ibdev.destroy_cq = iwch_destroy_cq;
-	dev->ibdev.resize_cq = iwch_resize_cq;
-	dev->ibdev.poll_cq = iwch_poll_cq;
-	dev->ibdev.get_dma_mr = iwch_get_dma_mr;
-	dev->ibdev.reg_user_mr = iwch_reg_user_mr;
-	dev->ibdev.dereg_mr = iwch_dereg_mr;
-	dev->ibdev.alloc_mw = iwch_alloc_mw;
-	dev->ibdev.dealloc_mw = iwch_dealloc_mw;
-	dev->ibdev.alloc_mr = iwch_alloc_mr;
-	dev->ibdev.map_mr_sg = iwch_map_mr_sg;
-	dev->ibdev.req_notify_cq = iwch_arm_cq;
-	dev->ibdev.post_send = iwch_post_send;
-	dev->ibdev.post_recv = iwch_post_receive;
-	dev->ibdev.alloc_hw_stats = iwch_alloc_stats;
-	dev->ibdev.get_hw_stats = iwch_get_mib;
 	dev->ibdev.uverbs_abi_ver = IWCH_UVERBS_ABI_VERSION;
-	dev->ibdev.get_port_immutable = iwch_port_immutable;
-	dev->ibdev.get_dev_fw_str = get_dev_fw_ver_str;
 
 	dev->ibdev.iwcm = kmalloc(sizeof(struct iw_cm_verbs), GFP_KERNEL);
 	if (!dev->ibdev.iwcm)
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 66bf1aae4021..601924967136 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -608,42 +608,7 @@ void c4iw_register_device(struct work_struct *work)
 	dev->ibdev.phys_port_cnt = dev->rdev.lldi.nports;
 	dev->ibdev.num_comp_vectors =  dev->rdev.lldi.nciq;
 	dev->ibdev.dev.parent = &dev->rdev.lldi.pdev->dev;
-	dev->ibdev.query_device = c4iw_query_device;
-	dev->ibdev.query_port = c4iw_query_port;
-	dev->ibdev.query_pkey = c4iw_query_pkey;
-	dev->ibdev.query_gid = c4iw_query_gid;
-	dev->ibdev.alloc_ucontext = c4iw_alloc_ucontext;
-	dev->ibdev.dealloc_ucontext = c4iw_dealloc_ucontext;
-	dev->ibdev.mmap = c4iw_mmap;
-	dev->ibdev.alloc_pd = c4iw_allocate_pd;
-	dev->ibdev.dealloc_pd = c4iw_deallocate_pd;
-	dev->ibdev.create_qp = c4iw_create_qp;
-	dev->ibdev.modify_qp = c4iw_ib_modify_qp;
-	dev->ibdev.query_qp = c4iw_ib_query_qp;
-	dev->ibdev.destroy_qp = c4iw_destroy_qp;
-	dev->ibdev.create_srq = c4iw_create_srq;
-	dev->ibdev.modify_srq = c4iw_modify_srq;
-	dev->ibdev.destroy_srq = c4iw_destroy_srq;
-	dev->ibdev.create_cq = c4iw_create_cq;
-	dev->ibdev.destroy_cq = c4iw_destroy_cq;
-	dev->ibdev.poll_cq = c4iw_poll_cq;
-	dev->ibdev.get_dma_mr = c4iw_get_dma_mr;
-	dev->ibdev.reg_user_mr = c4iw_reg_user_mr;
-	dev->ibdev.dereg_mr = c4iw_dereg_mr;
-	dev->ibdev.alloc_mw = c4iw_alloc_mw;
-	dev->ibdev.dealloc_mw = c4iw_dealloc_mw;
-	dev->ibdev.alloc_mr = c4iw_alloc_mr;
-	dev->ibdev.map_mr_sg = c4iw_map_mr_sg;
-	dev->ibdev.req_notify_cq = c4iw_arm_cq;
-	dev->ibdev.post_send = c4iw_post_send;
-	dev->ibdev.post_recv = c4iw_post_receive;
-	dev->ibdev.post_srq_recv = c4iw_post_srq_recv;
-	dev->ibdev.alloc_hw_stats = c4iw_alloc_stats;
-	dev->ibdev.get_hw_stats = c4iw_get_mib;
 	dev->ibdev.uverbs_abi_ver = C4IW_UVERBS_ABI_VERSION;
-	dev->ibdev.get_port_immutable = c4iw_port_immutable;
-	dev->ibdev.get_dev_fw_str = get_dev_fw_str;
-	dev->ibdev.get_netdev = get_netdev;
 
 	dev->ibdev.iwcm = kmalloc(sizeof(struct iw_cm_verbs), GFP_KERNEL);
 	if (!dev->ibdev.iwcm) {
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index c63f331dbf7a..0df5aba107b2 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1662,14 +1662,6 @@ int hfi1_register_ib_device(struct hfi1_devdata *dd)
 	ibdev->owner = THIS_MODULE;
 	ibdev->phys_port_cnt = dd->num_pports;
 	ibdev->dev.parent = &dd->pcidev->dev;
-	ibdev->modify_device = modify_device;
-	ibdev->alloc_hw_stats = alloc_hw_stats;
-	ibdev->get_hw_stats = get_hw_stats;
-	ibdev->alloc_rdma_netdev = hfi1_vnic_alloc_rn;
-
-	/* keep process mad in the driver */
-	ibdev->process_mad = hfi1_process_mad;
-	ibdev->get_dev_fw_str = hfi1_get_dev_fw_str;
 
 	ib_set_device_ops(ibdev, &hfi1_dev_ops);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 725678f138df..4cf0dffce137 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -517,68 +517,19 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 	ib_dev->uverbs_ex_cmd_mask |=
 		(1ULL << IB_USER_VERBS_EX_CMD_MODIFY_CQ);
 
-	/* HCA||device||port */
-	ib_dev->modify_device		= hns_roce_modify_device;
-	ib_dev->query_device		= hns_roce_query_device;
-	ib_dev->query_port		= hns_roce_query_port;
-	ib_dev->modify_port		= hns_roce_modify_port;
-	ib_dev->get_link_layer		= hns_roce_get_link_layer;
-	ib_dev->get_netdev		= hns_roce_get_netdev;
-	ib_dev->add_gid			= hns_roce_add_gid;
-	ib_dev->del_gid			= hns_roce_del_gid;
-	ib_dev->query_pkey		= hns_roce_query_pkey;
-	ib_dev->alloc_ucontext		= hns_roce_alloc_ucontext;
-	ib_dev->dealloc_ucontext	= hns_roce_dealloc_ucontext;
-	ib_dev->mmap			= hns_roce_mmap;
-
-	/* PD */
-	ib_dev->alloc_pd		= hns_roce_alloc_pd;
-	ib_dev->dealloc_pd		= hns_roce_dealloc_pd;
-
-	/* AH */
-	ib_dev->create_ah		= hns_roce_create_ah;
-	ib_dev->query_ah		= hns_roce_query_ah;
-	ib_dev->destroy_ah		= hns_roce_destroy_ah;
-
-	/* QP */
-	ib_dev->create_qp		= hns_roce_create_qp;
-	ib_dev->modify_qp		= hns_roce_modify_qp;
-	ib_dev->query_qp		= hr_dev->hw->query_qp;
-	ib_dev->destroy_qp		= hr_dev->hw->destroy_qp;
-	ib_dev->post_send		= hr_dev->hw->post_send;
-	ib_dev->post_recv		= hr_dev->hw->post_recv;
-
-	/* CQ */
-	ib_dev->create_cq		= hns_roce_ib_create_cq;
-	ib_dev->modify_cq		= hr_dev->hw->modify_cq;
-	ib_dev->destroy_cq		= hns_roce_ib_destroy_cq;
-	ib_dev->req_notify_cq		= hr_dev->hw->req_notify_cq;
-	ib_dev->poll_cq			= hr_dev->hw->poll_cq;
-
-	/* MR */
-	ib_dev->get_dma_mr		= hns_roce_get_dma_mr;
-	ib_dev->reg_user_mr		= hns_roce_reg_user_mr;
-	ib_dev->dereg_mr		= hns_roce_dereg_mr;
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_REREG_MR) {
-		ib_dev->rereg_user_mr	= hns_roce_rereg_user_mr;
 		ib_dev->uverbs_cmd_mask |= (1ULL << IB_USER_VERBS_CMD_REREG_MR);
 		ib_set_device_ops(ib_dev, &hns_roce_dev_mr_ops);
 	}
 
 	/* MW */
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_MW) {
-		ib_dev->alloc_mw = hns_roce_alloc_mw;
-		ib_dev->dealloc_mw = hns_roce_dealloc_mw;
 		ib_dev->uverbs_cmd_mask |=
 					(1ULL << IB_USER_VERBS_CMD_ALLOC_MW) |
 					(1ULL << IB_USER_VERBS_CMD_DEALLOC_MW);
 		ib_set_device_ops(ib_dev, &hns_roce_dev_mw_ops);
 	}
 
-	/* OTHERS */
-	ib_dev->get_port_immutable	= hns_roce_port_immutable;
-	ib_dev->disassociate_ucontext	= hns_roce_disassociate_ucontext;
-
 	ib_dev->driver_id = RDMA_DRIVER_HNS;
 	ib_set_device_ops(ib_dev, hr_dev->hw->hns_roce_dev_ops);
 	ib_set_device_ops(ib_dev, &hns_roce_dev_ops);
diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index 771eb6bd0785..ef137c40205c 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -3478,7 +3478,7 @@ static void i40iw_qp_disconnect(struct i40iw_qp *iwqp)
 		/* Need to free the Last Streaming Mode Message */
 		if (iwqp->ietf_mem.va) {
 			if (iwqp->lsmm_mr)
-				iwibdev->ibdev.dereg_mr(iwqp->lsmm_mr);
+				iwibdev->ibdev.ops.dereg_mr(iwqp->lsmm_mr);
 			i40iw_free_dma_mem(iwdev->sc_dev.hw, &iwqp->ietf_mem);
 		}
 	}
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 7841e609d81a..51ec89915efe 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -2817,30 +2817,6 @@ static struct i40iw_ib_device *i40iw_init_rdma_device(struct i40iw_device *iwdev
 	iwibdev->ibdev.phys_port_cnt = 1;
 	iwibdev->ibdev.num_comp_vectors = iwdev->ceqs_count;
 	iwibdev->ibdev.dev.parent = &pcidev->dev;
-	iwibdev->ibdev.query_port = i40iw_query_port;
-	iwibdev->ibdev.query_pkey = i40iw_query_pkey;
-	iwibdev->ibdev.query_gid = i40iw_query_gid;
-	iwibdev->ibdev.alloc_ucontext = i40iw_alloc_ucontext;
-	iwibdev->ibdev.dealloc_ucontext = i40iw_dealloc_ucontext;
-	iwibdev->ibdev.mmap = i40iw_mmap;
-	iwibdev->ibdev.alloc_pd = i40iw_alloc_pd;
-	iwibdev->ibdev.dealloc_pd = i40iw_dealloc_pd;
-	iwibdev->ibdev.create_qp = i40iw_create_qp;
-	iwibdev->ibdev.modify_qp = i40iw_modify_qp;
-	iwibdev->ibdev.query_qp = i40iw_query_qp;
-	iwibdev->ibdev.destroy_qp = i40iw_destroy_qp;
-	iwibdev->ibdev.create_cq = i40iw_create_cq;
-	iwibdev->ibdev.destroy_cq = i40iw_destroy_cq;
-	iwibdev->ibdev.get_dma_mr = i40iw_get_dma_mr;
-	iwibdev->ibdev.reg_user_mr = i40iw_reg_user_mr;
-	iwibdev->ibdev.dereg_mr = i40iw_dereg_mr;
-	iwibdev->ibdev.alloc_hw_stats = i40iw_alloc_hw_stats;
-	iwibdev->ibdev.get_hw_stats = i40iw_get_hw_stats;
-	iwibdev->ibdev.query_device = i40iw_query_device;
-	iwibdev->ibdev.drain_sq = i40iw_drain_sq;
-	iwibdev->ibdev.drain_rq = i40iw_drain_rq;
-	iwibdev->ibdev.alloc_mr = i40iw_alloc_mr;
-	iwibdev->ibdev.map_mr_sg = i40iw_map_mr_sg;
 	iwibdev->ibdev.iwcm = kzalloc(sizeof(*iwibdev->ibdev.iwcm), GFP_KERNEL);
 	if (!iwibdev->ibdev.iwcm) {
 		ib_dealloc_device(&iwibdev->ibdev);
@@ -2857,13 +2833,6 @@ static struct i40iw_ib_device *i40iw_init_rdma_device(struct i40iw_device *iwdev
 	iwibdev->ibdev.iwcm->destroy_listen = i40iw_destroy_listen;
 	memcpy(iwibdev->ibdev.iwcm->ifname, netdev->name,
 	       sizeof(iwibdev->ibdev.iwcm->ifname));
-	iwibdev->ibdev.get_port_immutable   = i40iw_port_immutable;
-	iwibdev->ibdev.get_dev_fw_str       = i40iw_get_dev_fw_str;
-	iwibdev->ibdev.poll_cq = i40iw_poll_cq;
-	iwibdev->ibdev.req_notify_cq = i40iw_req_notify_cq;
-	iwibdev->ibdev.post_send = i40iw_post_send;
-	iwibdev->ibdev.post_recv = i40iw_post_recv;
-	iwibdev->ibdev.get_vector_affinity = i40iw_get_vector_affinity;
 	ib_set_device_ops(&iwibdev->ibdev, &i40iw_dev_ops);
 
 	return iwibdev;
diff --git a/drivers/infiniband/hw/mlx4/alias_GUID.c b/drivers/infiniband/hw/mlx4/alias_GUID.c
index 155b4dfc0ae8..e44d817d7d87 100644
--- a/drivers/infiniband/hw/mlx4/alias_GUID.c
+++ b/drivers/infiniband/hw/mlx4/alias_GUID.c
@@ -849,7 +849,7 @@ int mlx4_ib_init_alias_guid_service(struct mlx4_ib_dev *dev)
 	spin_lock_init(&dev->sriov.alias_guid.ag_work_lock);
 
 	for (i = 1; i <= dev->num_ports; ++i) {
-		if (dev->ib_dev.query_gid(&dev->ib_dev , i, 0, &gid)) {
+		if (dev->ib_dev.ops.query_gid(&dev->ib_dev , i, 0, &gid)) {
 			ret = -EFAULT;
 			goto err_unregister;
 		}
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 2c189f90261c..1d11bf46fb75 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2245,8 +2245,6 @@ static int mlx4_ib_alloc_diag_counters(struct mlx4_ib_dev *ibdev)
 					   diag[i].offset, i);
 	}
 
-	ibdev->ib_dev.get_hw_stats	= mlx4_ib_get_hw_stats;
-	ibdev->ib_dev.alloc_hw_stats	= mlx4_ib_alloc_hw_stats;
 	ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_hw_stats_ops);
 
 	return 0;
@@ -2636,9 +2634,6 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 						1 : ibdev->num_ports;
 	ibdev->ib_dev.num_comp_vectors	= dev->caps.num_comp_vectors;
 	ibdev->ib_dev.dev.parent	= &dev->persist->pdev->dev;
-	ibdev->ib_dev.get_netdev	= mlx4_ib_get_netdev;
-	ibdev->ib_dev.add_gid		= mlx4_ib_add_gid;
-	ibdev->ib_dev.del_gid		= mlx4_ib_del_gid;
 
 	if (dev->caps.userspace_caps)
 		ibdev->ib_dev.uverbs_abi_ver = MLX4_IB_UVERBS_ABI_VERSION;
@@ -2671,53 +2666,6 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 		(1ull << IB_USER_VERBS_CMD_CREATE_XSRQ)		|
 		(1ull << IB_USER_VERBS_CMD_OPEN_QP);
 
-	ibdev->ib_dev.query_device	= mlx4_ib_query_device;
-	ibdev->ib_dev.query_port	= mlx4_ib_query_port;
-	ibdev->ib_dev.get_link_layer	= mlx4_ib_port_link_layer;
-	ibdev->ib_dev.query_gid		= mlx4_ib_query_gid;
-	ibdev->ib_dev.query_pkey	= mlx4_ib_query_pkey;
-	ibdev->ib_dev.modify_device	= mlx4_ib_modify_device;
-	ibdev->ib_dev.modify_port	= mlx4_ib_modify_port;
-	ibdev->ib_dev.alloc_ucontext	= mlx4_ib_alloc_ucontext;
-	ibdev->ib_dev.dealloc_ucontext	= mlx4_ib_dealloc_ucontext;
-	ibdev->ib_dev.mmap		= mlx4_ib_mmap;
-	ibdev->ib_dev.alloc_pd		= mlx4_ib_alloc_pd;
-	ibdev->ib_dev.dealloc_pd	= mlx4_ib_dealloc_pd;
-	ibdev->ib_dev.create_ah		= mlx4_ib_create_ah;
-	ibdev->ib_dev.query_ah		= mlx4_ib_query_ah;
-	ibdev->ib_dev.destroy_ah	= mlx4_ib_destroy_ah;
-	ibdev->ib_dev.create_srq	= mlx4_ib_create_srq;
-	ibdev->ib_dev.modify_srq	= mlx4_ib_modify_srq;
-	ibdev->ib_dev.query_srq		= mlx4_ib_query_srq;
-	ibdev->ib_dev.destroy_srq	= mlx4_ib_destroy_srq;
-	ibdev->ib_dev.post_srq_recv	= mlx4_ib_post_srq_recv;
-	ibdev->ib_dev.create_qp		= mlx4_ib_create_qp;
-	ibdev->ib_dev.modify_qp		= mlx4_ib_modify_qp;
-	ibdev->ib_dev.query_qp		= mlx4_ib_query_qp;
-	ibdev->ib_dev.destroy_qp	= mlx4_ib_destroy_qp;
-	ibdev->ib_dev.drain_sq		= mlx4_ib_drain_sq;
-	ibdev->ib_dev.drain_rq		= mlx4_ib_drain_rq;
-	ibdev->ib_dev.post_send		= mlx4_ib_post_send;
-	ibdev->ib_dev.post_recv		= mlx4_ib_post_recv;
-	ibdev->ib_dev.create_cq		= mlx4_ib_create_cq;
-	ibdev->ib_dev.modify_cq		= mlx4_ib_modify_cq;
-	ibdev->ib_dev.resize_cq		= mlx4_ib_resize_cq;
-	ibdev->ib_dev.destroy_cq	= mlx4_ib_destroy_cq;
-	ibdev->ib_dev.poll_cq		= mlx4_ib_poll_cq;
-	ibdev->ib_dev.req_notify_cq	= mlx4_ib_arm_cq;
-	ibdev->ib_dev.get_dma_mr	= mlx4_ib_get_dma_mr;
-	ibdev->ib_dev.reg_user_mr	= mlx4_ib_reg_user_mr;
-	ibdev->ib_dev.rereg_user_mr	= mlx4_ib_rereg_user_mr;
-	ibdev->ib_dev.dereg_mr		= mlx4_ib_dereg_mr;
-	ibdev->ib_dev.alloc_mr		= mlx4_ib_alloc_mr;
-	ibdev->ib_dev.map_mr_sg		= mlx4_ib_map_mr_sg;
-	ibdev->ib_dev.attach_mcast	= mlx4_ib_mcg_attach;
-	ibdev->ib_dev.detach_mcast	= mlx4_ib_mcg_detach;
-	ibdev->ib_dev.process_mad	= mlx4_ib_process_mad;
-	ibdev->ib_dev.get_port_immutable = mlx4_port_immutable;
-	ibdev->ib_dev.get_dev_fw_str    = get_fw_ver_str;
-	ibdev->ib_dev.disassociate_ucontext = mlx4_ib_disassociate_ucontext;
-
 	ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_ops);
 	ibdev->ib_dev.uverbs_ex_cmd_mask |=
 		(1ull << IB_USER_VERBS_EX_CMD_MODIFY_CQ);
@@ -2727,13 +2675,6 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	    IB_LINK_LAYER_ETHERNET) ||
 	    (mlx4_ib_port_link_layer(&ibdev->ib_dev, 2) ==
 	    IB_LINK_LAYER_ETHERNET))) {
-		ibdev->ib_dev.create_wq		= mlx4_ib_create_wq;
-		ibdev->ib_dev.modify_wq		= mlx4_ib_modify_wq;
-		ibdev->ib_dev.destroy_wq	= mlx4_ib_destroy_wq;
-		ibdev->ib_dev.create_rwq_ind_table  =
-			mlx4_ib_create_rwq_ind_table;
-		ibdev->ib_dev.destroy_rwq_ind_table =
-			mlx4_ib_destroy_rwq_ind_table;
 		ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_wq_ops);
 		ibdev->ib_dev.uverbs_ex_cmd_mask |=
 			(1ull << IB_USER_VERBS_EX_CMD_CREATE_WQ)	  |
@@ -2743,18 +2684,11 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL);
 	}
 
-	if (!mlx4_is_slave(ibdev->dev)) {
-		ibdev->ib_dev.alloc_fmr		= mlx4_ib_fmr_alloc;
-		ibdev->ib_dev.map_phys_fmr	= mlx4_ib_map_phys_fmr;
-		ibdev->ib_dev.unmap_fmr		= mlx4_ib_unmap_fmr;
-		ibdev->ib_dev.dealloc_fmr	= mlx4_ib_fmr_dealloc;
+	if (!mlx4_is_slave(ibdev->dev))
 		ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_fmr_ops);
-	}
 
 	if (dev->caps.flags & MLX4_DEV_CAP_FLAG_MEM_WINDOW ||
 	    dev->caps.bmme_flags & MLX4_BMME_FLAG_TYPE_2_WIN) {
-		ibdev->ib_dev.alloc_mw = mlx4_ib_alloc_mw;
-		ibdev->ib_dev.dealloc_mw = mlx4_ib_dealloc_mw;
 		ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_mw_ops);
 
 		ibdev->ib_dev.uverbs_cmd_mask |=
@@ -2763,8 +2697,6 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	}
 
 	if (dev->caps.flags & MLX4_DEV_CAP_FLAG_XRC) {
-		ibdev->ib_dev.alloc_xrcd = mlx4_ib_alloc_xrcd;
-		ibdev->ib_dev.dealloc_xrcd = mlx4_ib_dealloc_xrcd;
 		ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_xrc_ops);
 		ibdev->ib_dev.uverbs_cmd_mask |=
 			(1ull << IB_USER_VERBS_CMD_OPEN_XRCD) |
@@ -2773,8 +2705,6 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 
 	if (check_flow_steering_support(dev)) {
 		ibdev->steering_support = MLX4_STEERING_MODE_DEVICE_MANAGED;
-		ibdev->ib_dev.create_flow	= mlx4_ib_create_flow;
-		ibdev->ib_dev.destroy_flow	= mlx4_ib_destroy_flow;
 		ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_fs_ops);
 
 		ibdev->ib_dev.uverbs_ex_cmd_mask	|=
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 1d2b8f4b2904..1f8f99982d95 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -146,7 +146,7 @@ static int get_port_state(struct ib_device *ibdev,
 	int ret;
 
 	memset(&attr, 0, sizeof(attr));
-	ret = ibdev->query_port(ibdev, port_num, &attr);
+	ret = ibdev->ops.query_port(ibdev, port_num, &attr);
 	if (!ret)
 		*state = attr.state;
 	return ret;
@@ -5884,76 +5884,20 @@ int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_CQ)	|
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_QP)	|
 		(1ull << IB_USER_VERBS_EX_CMD_MODIFY_QP)	|
-		(1ull << IB_USER_VERBS_EX_CMD_MODIFY_CQ);
-
-	dev->ib_dev.query_device	= mlx5_ib_query_device;
-	dev->ib_dev.get_link_layer	= mlx5_ib_port_link_layer;
-	dev->ib_dev.query_gid		= mlx5_ib_query_gid;
-	dev->ib_dev.add_gid		= mlx5_ib_add_gid;
-	dev->ib_dev.del_gid		= mlx5_ib_del_gid;
-	dev->ib_dev.query_pkey		= mlx5_ib_query_pkey;
-	dev->ib_dev.modify_device	= mlx5_ib_modify_device;
-	dev->ib_dev.modify_port		= mlx5_ib_modify_port;
-	dev->ib_dev.alloc_ucontext	= mlx5_ib_alloc_ucontext;
-	dev->ib_dev.dealloc_ucontext	= mlx5_ib_dealloc_ucontext;
-	dev->ib_dev.mmap		= mlx5_ib_mmap;
-	dev->ib_dev.alloc_pd		= mlx5_ib_alloc_pd;
-	dev->ib_dev.dealloc_pd		= mlx5_ib_dealloc_pd;
-	dev->ib_dev.create_ah		= mlx5_ib_create_ah;
-	dev->ib_dev.query_ah		= mlx5_ib_query_ah;
-	dev->ib_dev.destroy_ah		= mlx5_ib_destroy_ah;
-	dev->ib_dev.create_srq		= mlx5_ib_create_srq;
-	dev->ib_dev.modify_srq		= mlx5_ib_modify_srq;
-	dev->ib_dev.query_srq		= mlx5_ib_query_srq;
-	dev->ib_dev.destroy_srq		= mlx5_ib_destroy_srq;
-	dev->ib_dev.post_srq_recv	= mlx5_ib_post_srq_recv;
-	dev->ib_dev.create_qp		= mlx5_ib_create_qp;
-	dev->ib_dev.modify_qp		= mlx5_ib_modify_qp;
-	dev->ib_dev.query_qp		= mlx5_ib_query_qp;
-	dev->ib_dev.destroy_qp		= mlx5_ib_destroy_qp;
-	dev->ib_dev.drain_sq		= mlx5_ib_drain_sq;
-	dev->ib_dev.drain_rq		= mlx5_ib_drain_rq;
-	dev->ib_dev.post_send		= mlx5_ib_post_send;
-	dev->ib_dev.post_recv		= mlx5_ib_post_recv;
-	dev->ib_dev.create_cq		= mlx5_ib_create_cq;
-	dev->ib_dev.modify_cq		= mlx5_ib_modify_cq;
-	dev->ib_dev.resize_cq		= mlx5_ib_resize_cq;
-	dev->ib_dev.destroy_cq		= mlx5_ib_destroy_cq;
-	dev->ib_dev.poll_cq		= mlx5_ib_poll_cq;
-	dev->ib_dev.req_notify_cq	= mlx5_ib_arm_cq;
-	dev->ib_dev.get_dma_mr		= mlx5_ib_get_dma_mr;
-	dev->ib_dev.reg_user_mr		= mlx5_ib_reg_user_mr;
-	dev->ib_dev.rereg_user_mr	= mlx5_ib_rereg_user_mr;
-	dev->ib_dev.dereg_mr		= mlx5_ib_dereg_mr;
-	dev->ib_dev.attach_mcast	= mlx5_ib_mcg_attach;
-	dev->ib_dev.detach_mcast	= mlx5_ib_mcg_detach;
-	dev->ib_dev.process_mad		= mlx5_ib_process_mad;
-	dev->ib_dev.alloc_mr		= mlx5_ib_alloc_mr;
-	dev->ib_dev.map_mr_sg		= mlx5_ib_map_mr_sg;
-	dev->ib_dev.check_mr_status	= mlx5_ib_check_mr_status;
-	dev->ib_dev.get_dev_fw_str      = get_dev_fw_str;
-	dev->ib_dev.get_vector_affinity	= mlx5_ib_get_vector_affinity;
-	if (MLX5_CAP_GEN(mdev, ipoib_enhanced_offloads)) {
-		dev->ib_dev.alloc_rdma_netdev	= mlx5_ib_alloc_rdma_netdev;
+		(1ull << IB_USER_VERBS_EX_CMD_MODIFY_CQ)	|
+		(1ull << IB_USER_VERBS_EX_CMD_CREATE_FLOW)	|
+		(1ull << IB_USER_VERBS_EX_CMD_DESTROY_FLOW);
+
+	if (MLX5_CAP_GEN(mdev, ipoib_enhanced_offloads))
 		ib_set_device_ops(&dev->ib_dev,
 				  &mlx5_ib_dev_ipoib_enhanced_ops);
-	}
 
-	if (mlx5_core_is_pf(mdev)) {
-		dev->ib_dev.get_vf_config	= mlx5_ib_get_vf_config;
-		dev->ib_dev.set_vf_link_state	= mlx5_ib_set_vf_link_state;
-		dev->ib_dev.get_vf_stats	= mlx5_ib_get_vf_stats;
-		dev->ib_dev.set_vf_guid		= mlx5_ib_set_vf_guid;
+	if (mlx5_core_is_pf(mdev))
 		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_sriov_ops);
-	}
-
-	dev->ib_dev.disassociate_ucontext = mlx5_ib_disassociate_ucontext;
 
 	dev->umr_fence = mlx5_get_umr_fence(MLX5_CAP_GEN(mdev, umr_fence));
 
 	if (MLX5_CAP_GEN(mdev, imaicl)) {
-		dev->ib_dev.alloc_mw		= mlx5_ib_alloc_mw;
-		dev->ib_dev.dealloc_mw		= mlx5_ib_dealloc_mw;
 		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_mw_ops);
 		dev->ib_dev.uverbs_cmd_mask |=
 			(1ull << IB_USER_VERBS_CMD_ALLOC_MW)	|
@@ -5961,33 +5905,16 @@ int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 	}
 
 	if (MLX5_CAP_GEN(mdev, xrc)) {
-		dev->ib_dev.alloc_xrcd = mlx5_ib_alloc_xrcd;
-		dev->ib_dev.dealloc_xrcd = mlx5_ib_dealloc_xrcd;
 		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_xrc_ops);
 		dev->ib_dev.uverbs_cmd_mask |=
 			(1ull << IB_USER_VERBS_CMD_OPEN_XRCD) |
 			(1ull << IB_USER_VERBS_CMD_CLOSE_XRCD);
 	}
 
-	if (MLX5_CAP_DEV_MEM(mdev, memic)) {
-		dev->ib_dev.alloc_dm = mlx5_ib_alloc_dm;
-		dev->ib_dev.dealloc_dm = mlx5_ib_dealloc_dm;
-		dev->ib_dev.reg_dm_mr = mlx5_ib_reg_dm_mr;
+	if (MLX5_CAP_DEV_MEM(mdev, memic))
 		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_dm_ops);
-	}
 
-	dev->ib_dev.create_flow	= mlx5_ib_create_flow;
-	dev->ib_dev.destroy_flow = mlx5_ib_destroy_flow;
-	dev->ib_dev.uverbs_ex_cmd_mask |=
-			(1ull << IB_USER_VERBS_EX_CMD_CREATE_FLOW) |
-			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_FLOW);
-	dev->ib_dev.create_flow_action_esp = mlx5_ib_create_flow_action_esp;
-	dev->ib_dev.destroy_flow_action = mlx5_ib_destroy_flow_action;
-	dev->ib_dev.modify_flow_action_esp = mlx5_ib_modify_flow_action_esp;
 	dev->ib_dev.driver_id = RDMA_DRIVER_MLX5;
-	dev->ib_dev.create_counters = mlx5_ib_create_counters;
-	dev->ib_dev.destroy_counters = mlx5_ib_destroy_counters;
-	dev->ib_dev.read_counters = mlx5_ib_read_counters;
 	ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_ops);
 
 	err = init_node_data(dev);
@@ -6009,9 +5936,6 @@ static struct ib_device_ops mlx5_ib_dev_port_ops = {
 
 static int mlx5_ib_stage_non_default_cb(struct mlx5_ib_dev *dev)
 {
-	dev->ib_dev.get_port_immutable  = mlx5_port_immutable;
-	dev->ib_dev.query_port		= mlx5_ib_query_port;
-
 	ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_port_ops);
 
 	return 0;
@@ -6024,9 +5948,6 @@ static struct ib_device_ops mlx5_ib_dev_port_rep_ops = {
 
 int mlx5_ib_stage_rep_non_default_cb(struct mlx5_ib_dev *dev)
 {
-	dev->ib_dev.get_port_immutable  = mlx5_port_rep_immutable;
-	dev->ib_dev.query_port		= mlx5_ib_rep_query_port;
-
 	ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_port_rep_ops);
 
 	return 0;
@@ -6052,13 +5973,6 @@ static int mlx5_ib_stage_common_roce_init(struct mlx5_ib_dev *dev)
 		dev->roce[i].last_port_state = IB_PORT_DOWN;
 	}
 
-	dev->ib_dev.get_netdev	= mlx5_ib_get_netdev;
-	dev->ib_dev.create_wq	 = mlx5_ib_create_wq;
-	dev->ib_dev.modify_wq	 = mlx5_ib_modify_wq;
-	dev->ib_dev.destroy_wq	 = mlx5_ib_destroy_wq;
-	dev->ib_dev.create_rwq_ind_table = mlx5_ib_create_rwq_ind_table;
-	dev->ib_dev.destroy_rwq_ind_table = mlx5_ib_destroy_rwq_ind_table;
-
 	ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_common_roce_ops);
 	dev->ib_dev.uverbs_ex_cmd_mask |=
 			(1ull << IB_USER_VERBS_EX_CMD_CREATE_WQ) |
@@ -6167,8 +6081,6 @@ static struct ib_device_ops mlx5_ib_dev_hw_stats_ops = {
 int mlx5_ib_stage_counters_init(struct mlx5_ib_dev *dev)
 {
 	if (MLX5_CAP_GEN(dev->mdev, max_qp_cnt)) {
-		dev->ib_dev.get_hw_stats	= mlx5_ib_get_hw_stats;
-		dev->ib_dev.alloc_hw_stats	= mlx5_ib_alloc_hw_stats;
 		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_hw_stats_ops);
 
 		return mlx5_ib_alloc_counters(dev);
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 540d55dd75bc..cfe9d4ba76c2 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -1298,89 +1298,37 @@ int mthca_register_device(struct mthca_dev *dev)
 	dev->ib_dev.phys_port_cnt        = dev->limits.num_ports;
 	dev->ib_dev.num_comp_vectors     = 1;
 	dev->ib_dev.dev.parent           = &dev->pdev->dev;
-	dev->ib_dev.query_device         = mthca_query_device;
-	dev->ib_dev.query_port           = mthca_query_port;
-	dev->ib_dev.modify_device        = mthca_modify_device;
-	dev->ib_dev.modify_port          = mthca_modify_port;
-	dev->ib_dev.query_pkey           = mthca_query_pkey;
-	dev->ib_dev.query_gid            = mthca_query_gid;
-	dev->ib_dev.alloc_ucontext       = mthca_alloc_ucontext;
-	dev->ib_dev.dealloc_ucontext     = mthca_dealloc_ucontext;
-	dev->ib_dev.mmap                 = mthca_mmap_uar;
-	dev->ib_dev.alloc_pd             = mthca_alloc_pd;
-	dev->ib_dev.dealloc_pd           = mthca_dealloc_pd;
-	dev->ib_dev.create_ah            = mthca_ah_create;
-	dev->ib_dev.query_ah             = mthca_ah_query;
-	dev->ib_dev.destroy_ah           = mthca_ah_destroy;
 
 	if (dev->mthca_flags & MTHCA_FLAG_SRQ) {
-		dev->ib_dev.create_srq           = mthca_create_srq;
-		dev->ib_dev.modify_srq           = mthca_modify_srq;
-		dev->ib_dev.query_srq            = mthca_query_srq;
-		dev->ib_dev.destroy_srq          = mthca_destroy_srq;
 		dev->ib_dev.uverbs_cmd_mask	|=
 			(1ull << IB_USER_VERBS_CMD_CREATE_SRQ)		|
 			(1ull << IB_USER_VERBS_CMD_MODIFY_SRQ)		|
 			(1ull << IB_USER_VERBS_CMD_QUERY_SRQ)		|
 			(1ull << IB_USER_VERBS_CMD_DESTROY_SRQ);
 
-		if (mthca_is_memfree(dev)) {
-			dev->ib_dev.post_srq_recv = mthca_arbel_post_srq_recv;
+		if (mthca_is_memfree(dev))
 			ib_set_device_ops(&dev->ib_dev,
 					  &mthca_dev_arbel_srq_ops);
-		} else {
-			dev->ib_dev.post_srq_recv = mthca_tavor_post_srq_recv;
+		else
 			ib_set_device_ops(&dev->ib_dev,
 					  &mthca_dev_tavor_srq_ops);
-		}
 	}
 
-	dev->ib_dev.create_qp            = mthca_create_qp;
-	dev->ib_dev.modify_qp            = mthca_modify_qp;
-	dev->ib_dev.query_qp             = mthca_query_qp;
-	dev->ib_dev.destroy_qp           = mthca_destroy_qp;
-	dev->ib_dev.create_cq            = mthca_create_cq;
-	dev->ib_dev.resize_cq            = mthca_resize_cq;
-	dev->ib_dev.destroy_cq           = mthca_destroy_cq;
-	dev->ib_dev.poll_cq              = mthca_poll_cq;
-	dev->ib_dev.get_dma_mr           = mthca_get_dma_mr;
-	dev->ib_dev.reg_user_mr          = mthca_reg_user_mr;
-	dev->ib_dev.dereg_mr             = mthca_dereg_mr;
-	dev->ib_dev.get_port_immutable   = mthca_port_immutable;
-	dev->ib_dev.get_dev_fw_str       = get_dev_fw_str;
-
 	if (dev->mthca_flags & MTHCA_FLAG_FMR) {
-		dev->ib_dev.alloc_fmr            = mthca_alloc_fmr;
-		dev->ib_dev.unmap_fmr            = mthca_unmap_fmr;
-		dev->ib_dev.dealloc_fmr          = mthca_dealloc_fmr;
-		if (mthca_is_memfree(dev)) {
-			dev->ib_dev.map_phys_fmr = mthca_arbel_map_phys_fmr;
+		if (mthca_is_memfree(dev))
 			ib_set_device_ops(&dev->ib_dev,
 					  &mthca_dev_arbel_fmr_ops);
-		} else {
-			dev->ib_dev.map_phys_fmr = mthca_tavor_map_phys_fmr;
+		else
 			ib_set_device_ops(&dev->ib_dev,
 					  &mthca_dev_tavor_fmr_ops);
-		}
 	}
 
-	dev->ib_dev.attach_mcast         = mthca_multicast_attach;
-	dev->ib_dev.detach_mcast         = mthca_multicast_detach;
-	dev->ib_dev.process_mad          = mthca_process_mad;
-
 	ib_set_device_ops(&dev->ib_dev, &mthca_dev_ops);
 
-	if (mthca_is_memfree(dev)) {
-		dev->ib_dev.req_notify_cq = mthca_arbel_arm_cq;
-		dev->ib_dev.post_send     = mthca_arbel_post_send;
-		dev->ib_dev.post_recv     = mthca_arbel_post_receive;
+	if (mthca_is_memfree(dev))
 		ib_set_device_ops(&dev->ib_dev, &mthca_dev_arbel_ops);
-	} else {
-		dev->ib_dev.req_notify_cq = mthca_tavor_arm_cq;
-		dev->ib_dev.post_send     = mthca_tavor_post_send;
-		dev->ib_dev.post_recv     = mthca_tavor_post_receive;
+	else
 		ib_set_device_ops(&dev->ib_dev, &mthca_dev_tavor_ops);
-	}
 
 	mutex_init(&dev->cap_mask_mutex);
 
diff --git a/drivers/infiniband/hw/nes/nes_cm.c b/drivers/infiniband/hw/nes/nes_cm.c
index 2b67ace5b614..032883180f65 100644
--- a/drivers/infiniband/hw/nes/nes_cm.c
+++ b/drivers/infiniband/hw/nes/nes_cm.c
@@ -3033,7 +3033,7 @@ static int nes_disconnect(struct nes_qp *nesqp, int abrupt)
 		/* Need to free the Last Streaming Mode Message */
 		if (nesqp->ietf_frame) {
 			if (nesqp->lsmm_mr)
-				nesibdev->ibdev.dereg_mr(nesqp->lsmm_mr);
+				nesibdev->ibdev.ops.dereg_mr(nesqp->lsmm_mr);
 			pci_free_consistent(nesdev->pcidev,
 					    nesqp->private_data_len + nesqp->ietf_frame_size,
 					    nesqp->ietf_frame, nesqp->ietf_frame_pbase);
diff --git a/drivers/infiniband/hw/nes/nes_verbs.c b/drivers/infiniband/hw/nes/nes_verbs.c
index a305bb8115e9..dee8b0a4fc79 100644
--- a/drivers/infiniband/hw/nes/nes_verbs.c
+++ b/drivers/infiniband/hw/nes/nes_verbs.c
@@ -3706,36 +3706,6 @@ struct nes_ib_device *nes_init_ofa_device(struct net_device *netdev)
 	nesibdev->ibdev.phys_port_cnt = 1;
 	nesibdev->ibdev.num_comp_vectors = 1;
 	nesibdev->ibdev.dev.parent = &nesdev->pcidev->dev;
-	nesibdev->ibdev.query_device = nes_query_device;
-	nesibdev->ibdev.query_port = nes_query_port;
-	nesibdev->ibdev.query_pkey = nes_query_pkey;
-	nesibdev->ibdev.query_gid = nes_query_gid;
-	nesibdev->ibdev.alloc_ucontext = nes_alloc_ucontext;
-	nesibdev->ibdev.dealloc_ucontext = nes_dealloc_ucontext;
-	nesibdev->ibdev.mmap = nes_mmap;
-	nesibdev->ibdev.alloc_pd = nes_alloc_pd;
-	nesibdev->ibdev.dealloc_pd = nes_dealloc_pd;
-	nesibdev->ibdev.create_qp = nes_create_qp;
-	nesibdev->ibdev.modify_qp = nes_modify_qp;
-	nesibdev->ibdev.query_qp = nes_query_qp;
-	nesibdev->ibdev.destroy_qp = nes_destroy_qp;
-	nesibdev->ibdev.create_cq = nes_create_cq;
-	nesibdev->ibdev.destroy_cq = nes_destroy_cq;
-	nesibdev->ibdev.poll_cq = nes_poll_cq;
-	nesibdev->ibdev.get_dma_mr = nes_get_dma_mr;
-	nesibdev->ibdev.reg_user_mr = nes_reg_user_mr;
-	nesibdev->ibdev.dereg_mr = nes_dereg_mr;
-	nesibdev->ibdev.alloc_mw = nes_alloc_mw;
-	nesibdev->ibdev.dealloc_mw = nes_dealloc_mw;
-
-	nesibdev->ibdev.alloc_mr = nes_alloc_mr;
-	nesibdev->ibdev.map_mr_sg = nes_map_mr_sg;
-
-	nesibdev->ibdev.req_notify_cq = nes_req_notify_cq;
-	nesibdev->ibdev.post_send = nes_post_send;
-	nesibdev->ibdev.post_recv = nes_post_recv;
-	nesibdev->ibdev.drain_sq = nes_drain_sq;
-	nesibdev->ibdev.drain_rq = nes_drain_rq;
 
 	nesibdev->ibdev.iwcm = kzalloc(sizeof(*nesibdev->ibdev.iwcm), GFP_KERNEL);
 	if (nesibdev->ibdev.iwcm == NULL) {
@@ -3750,8 +3720,6 @@ struct nes_ib_device *nes_init_ofa_device(struct net_device *netdev)
 	nesibdev->ibdev.iwcm->reject = nes_reject;
 	nesibdev->ibdev.iwcm->create_listen = nes_create_listen;
 	nesibdev->ibdev.iwcm->destroy_listen = nes_destroy_listen;
-	nesibdev->ibdev.get_port_immutable   = nes_port_immutable;
-	nesibdev->ibdev.get_dev_fw_str   = get_dev_fw_str;
 	ib_set_device_ops(&nesibdev->ibdev, &nes_dev_ops);
 	memcpy(nesibdev->ibdev.iwcm->ifname, netdev->name,
 	       sizeof(nesibdev->ibdev.iwcm->ifname));
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
index 1ad1c4110bf8..74356a2f16a0 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -197,51 +197,9 @@ static int ocrdma_register_device(struct ocrdma_dev *dev)
 	dev->ibdev.phys_port_cnt = 1;
 	dev->ibdev.num_comp_vectors = dev->eq_cnt;
 
-	/* mandatory verbs. */
-	dev->ibdev.query_device = ocrdma_query_device;
-	dev->ibdev.query_port = ocrdma_query_port;
-	dev->ibdev.modify_port = ocrdma_modify_port;
-	dev->ibdev.get_netdev = ocrdma_get_netdev;
-	dev->ibdev.get_link_layer = ocrdma_link_layer;
-	dev->ibdev.alloc_pd = ocrdma_alloc_pd;
-	dev->ibdev.dealloc_pd = ocrdma_dealloc_pd;
-
-	dev->ibdev.create_cq = ocrdma_create_cq;
-	dev->ibdev.destroy_cq = ocrdma_destroy_cq;
-	dev->ibdev.resize_cq = ocrdma_resize_cq;
-
-	dev->ibdev.create_qp = ocrdma_create_qp;
-	dev->ibdev.modify_qp = ocrdma_modify_qp;
-	dev->ibdev.query_qp = ocrdma_query_qp;
-	dev->ibdev.destroy_qp = ocrdma_destroy_qp;
-
-	dev->ibdev.query_pkey = ocrdma_query_pkey;
-	dev->ibdev.create_ah = ocrdma_create_ah;
-	dev->ibdev.destroy_ah = ocrdma_destroy_ah;
-	dev->ibdev.query_ah = ocrdma_query_ah;
-
-	dev->ibdev.poll_cq = ocrdma_poll_cq;
-	dev->ibdev.post_send = ocrdma_post_send;
-	dev->ibdev.post_recv = ocrdma_post_recv;
-	dev->ibdev.req_notify_cq = ocrdma_arm_cq;
-
-	dev->ibdev.get_dma_mr = ocrdma_get_dma_mr;
-	dev->ibdev.dereg_mr = ocrdma_dereg_mr;
-	dev->ibdev.reg_user_mr = ocrdma_reg_user_mr;
-
-	dev->ibdev.alloc_mr = ocrdma_alloc_mr;
-	dev->ibdev.map_mr_sg = ocrdma_map_mr_sg;
-
 	/* mandatory to support user space verbs consumer. */
-	dev->ibdev.alloc_ucontext = ocrdma_alloc_ucontext;
-	dev->ibdev.dealloc_ucontext = ocrdma_dealloc_ucontext;
-	dev->ibdev.mmap = ocrdma_mmap;
 	dev->ibdev.dev.parent = &dev->nic_info.pdev->dev;
 
-	dev->ibdev.process_mad = ocrdma_process_mad;
-	dev->ibdev.get_port_immutable = ocrdma_port_immutable;
-	dev->ibdev.get_dev_fw_str     = get_dev_fw_str;
-
 	ib_set_device_ops(&dev->ibdev, &ocrdma_dev_ops);
 
 	if (ocrdma_get_asic_type(dev) == OCRDMA_ASIC_GEN_SKH_R) {
@@ -252,11 +210,6 @@ static int ocrdma_register_device(struct ocrdma_dev *dev)
 		     OCRDMA_UVERBS(DESTROY_SRQ) |
 		     OCRDMA_UVERBS(POST_SRQ_RECV);
 
-		dev->ibdev.create_srq = ocrdma_create_srq;
-		dev->ibdev.modify_srq = ocrdma_modify_srq;
-		dev->ibdev.query_srq = ocrdma_query_srq;
-		dev->ibdev.destroy_srq = ocrdma_destroy_srq;
-		dev->ibdev.post_srq_recv = ocrdma_post_srq_recv;
 		ib_set_device_ops(&dev->ibdev, &ocrdma_dev_srq_ops);
 	}
 	dev->ibdev.driver_id = RDMA_DRIVER_OCRDMA;
diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index ae7b28e4a475..43c1e56ea606 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -141,9 +141,7 @@ static struct ib_device_ops qedr_iw_dev_ops = {
 static int qedr_iw_register_device(struct qedr_dev *dev)
 {
 	dev->ibdev.node_type = RDMA_NODE_RNIC;
-	dev->ibdev.query_gid = qedr_iw_query_gid;
 
-	dev->ibdev.get_port_immutable = qedr_iw_port_immutable;
 	ib_set_device_ops(&dev->ibdev, &qedr_iw_dev_ops);
 
 	dev->ibdev.iwcm = kzalloc(sizeof(*dev->ibdev.iwcm), GFP_KERNEL);
@@ -173,7 +171,6 @@ static void qedr_roce_register_device(struct qedr_dev *dev)
 {
 	dev->ibdev.node_type = RDMA_NODE_IB_CA;
 
-	dev->ibdev.get_port_immutable = qedr_roce_port_immutable;
 	ib_set_device_ops(&dev->ibdev, &qedr_roce_dev_ops);
 }
 
@@ -260,57 +257,7 @@ static int qedr_register_device(struct qedr_dev *dev)
 
 	dev->ibdev.phys_port_cnt = 1;
 	dev->ibdev.num_comp_vectors = dev->num_cnq;
-
-	dev->ibdev.query_device = qedr_query_device;
-	dev->ibdev.query_port = qedr_query_port;
-	dev->ibdev.modify_port = qedr_modify_port;
-
-	dev->ibdev.alloc_ucontext = qedr_alloc_ucontext;
-	dev->ibdev.dealloc_ucontext = qedr_dealloc_ucontext;
-	dev->ibdev.mmap = qedr_mmap;
-
-	dev->ibdev.alloc_pd = qedr_alloc_pd;
-	dev->ibdev.dealloc_pd = qedr_dealloc_pd;
-
-	dev->ibdev.create_cq = qedr_create_cq;
-	dev->ibdev.destroy_cq = qedr_destroy_cq;
-	dev->ibdev.resize_cq = qedr_resize_cq;
-	dev->ibdev.req_notify_cq = qedr_arm_cq;
-
-	dev->ibdev.create_qp = qedr_create_qp;
-	dev->ibdev.modify_qp = qedr_modify_qp;
-	dev->ibdev.query_qp = qedr_query_qp;
-	dev->ibdev.destroy_qp = qedr_destroy_qp;
-
-	dev->ibdev.create_srq = qedr_create_srq;
-	dev->ibdev.destroy_srq = qedr_destroy_srq;
-	dev->ibdev.modify_srq = qedr_modify_srq;
-	dev->ibdev.query_srq = qedr_query_srq;
-	dev->ibdev.post_srq_recv = qedr_post_srq_recv;
-	dev->ibdev.query_pkey = qedr_query_pkey;
-
-	dev->ibdev.create_ah = qedr_create_ah;
-	dev->ibdev.destroy_ah = qedr_destroy_ah;
-
-	dev->ibdev.get_dma_mr = qedr_get_dma_mr;
-	dev->ibdev.dereg_mr = qedr_dereg_mr;
-	dev->ibdev.reg_user_mr = qedr_reg_user_mr;
-	dev->ibdev.alloc_mr = qedr_alloc_mr;
-	dev->ibdev.map_mr_sg = qedr_map_mr_sg;
-
-	dev->ibdev.poll_cq = qedr_poll_cq;
-	dev->ibdev.post_send = qedr_post_send;
-	dev->ibdev.post_recv = qedr_post_recv;
-
-	dev->ibdev.process_mad = qedr_process_mad;
-
-	dev->ibdev.get_netdev = qedr_get_netdev;
-
 	dev->ibdev.dev.parent = &dev->pdev->dev;
-
-	dev->ibdev.get_link_layer = qedr_link_layer;
-	dev->ibdev.get_dev_fw_str = qedr_get_dev_fw_str;
-
 	ib_set_device_ops(&dev->ibdev, &qedr_dev_ops);
 
 	dev->ibdev.driver_id = RDMA_DRIVER_QEDR;
diff --git a/drivers/infiniband/hw/qib/qib_verbs.c b/drivers/infiniband/hw/qib/qib_verbs.c
index 8fe2519e34d9..58a265e04805 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -1563,8 +1563,6 @@ int qib_register_ib_device(struct qib_devdata *dd)
 	ibdev->node_guid = ppd->guid;
 	ibdev->phys_port_cnt = dd->num_pports;
 	ibdev->dev.parent = &dd->pcidev->dev;
-	ibdev->modify_device = qib_modify_device;
-	ibdev->process_mad = qib_process_mad;
 
 	snprintf(ibdev->node_desc, sizeof(ibdev->node_desc),
 		 "Intel Infiniband HCA %s", init_utsname()->nodename);
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index e327f5ec818e..61d152cc7946 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -417,35 +417,6 @@ static void *usnic_ib_device_add(struct pci_dev *dev)
 		(1ull << IB_USER_VERBS_CMD_DETACH_MCAST) |
 		(1ull << IB_USER_VERBS_CMD_OPEN_QP);
 
-	us_ibdev->ib_dev.query_device = usnic_ib_query_device;
-	us_ibdev->ib_dev.query_port = usnic_ib_query_port;
-	us_ibdev->ib_dev.query_pkey = usnic_ib_query_pkey;
-	us_ibdev->ib_dev.query_gid = usnic_ib_query_gid;
-	us_ibdev->ib_dev.get_netdev = usnic_get_netdev;
-	us_ibdev->ib_dev.get_link_layer = usnic_ib_port_link_layer;
-	us_ibdev->ib_dev.alloc_pd = usnic_ib_alloc_pd;
-	us_ibdev->ib_dev.dealloc_pd = usnic_ib_dealloc_pd;
-	us_ibdev->ib_dev.create_qp = usnic_ib_create_qp;
-	us_ibdev->ib_dev.modify_qp = usnic_ib_modify_qp;
-	us_ibdev->ib_dev.query_qp = usnic_ib_query_qp;
-	us_ibdev->ib_dev.destroy_qp = usnic_ib_destroy_qp;
-	us_ibdev->ib_dev.create_cq = usnic_ib_create_cq;
-	us_ibdev->ib_dev.destroy_cq = usnic_ib_destroy_cq;
-	us_ibdev->ib_dev.reg_user_mr = usnic_ib_reg_mr;
-	us_ibdev->ib_dev.dereg_mr = usnic_ib_dereg_mr;
-	us_ibdev->ib_dev.alloc_ucontext = usnic_ib_alloc_ucontext;
-	us_ibdev->ib_dev.dealloc_ucontext = usnic_ib_dealloc_ucontext;
-	us_ibdev->ib_dev.mmap = usnic_ib_mmap;
-	us_ibdev->ib_dev.create_ah = usnic_ib_create_ah;
-	us_ibdev->ib_dev.destroy_ah = usnic_ib_destroy_ah;
-	us_ibdev->ib_dev.post_send = usnic_ib_post_send;
-	us_ibdev->ib_dev.post_recv = usnic_ib_post_recv;
-	us_ibdev->ib_dev.poll_cq = usnic_ib_poll_cq;
-	us_ibdev->ib_dev.req_notify_cq = usnic_ib_req_notify_cq;
-	us_ibdev->ib_dev.get_dma_mr = usnic_ib_get_dma_mr;
-	us_ibdev->ib_dev.get_port_immutable = usnic_port_immutable;
-	us_ibdev->ib_dev.get_dev_fw_str     = usnic_get_dev_fw_str;
-
 	ib_set_device_ops(&us_ibdev->ib_dev, &usnic_dev_ops);
 
 	us_ibdev->ib_dev.driver_id = RDMA_DRIVER_USNIC;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index 25d494ce2d7d..536d0be7686a 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -237,40 +237,6 @@ static int pvrdma_register_device(struct pvrdma_dev *dev)
 	dev->ib_dev.node_type = RDMA_NODE_IB_CA;
 	dev->ib_dev.phys_port_cnt = dev->dsr->caps.phys_port_cnt;
 
-	dev->ib_dev.query_device = pvrdma_query_device;
-	dev->ib_dev.query_port = pvrdma_query_port;
-	dev->ib_dev.query_gid = pvrdma_query_gid;
-	dev->ib_dev.query_pkey = pvrdma_query_pkey;
-	dev->ib_dev.modify_port	= pvrdma_modify_port;
-	dev->ib_dev.alloc_ucontext = pvrdma_alloc_ucontext;
-	dev->ib_dev.dealloc_ucontext = pvrdma_dealloc_ucontext;
-	dev->ib_dev.mmap = pvrdma_mmap;
-	dev->ib_dev.alloc_pd = pvrdma_alloc_pd;
-	dev->ib_dev.dealloc_pd = pvrdma_dealloc_pd;
-	dev->ib_dev.create_ah = pvrdma_create_ah;
-	dev->ib_dev.destroy_ah = pvrdma_destroy_ah;
-	dev->ib_dev.create_qp = pvrdma_create_qp;
-	dev->ib_dev.modify_qp = pvrdma_modify_qp;
-	dev->ib_dev.query_qp = pvrdma_query_qp;
-	dev->ib_dev.destroy_qp = pvrdma_destroy_qp;
-	dev->ib_dev.post_send = pvrdma_post_send;
-	dev->ib_dev.post_recv = pvrdma_post_recv;
-	dev->ib_dev.create_cq = pvrdma_create_cq;
-	dev->ib_dev.destroy_cq = pvrdma_destroy_cq;
-	dev->ib_dev.poll_cq = pvrdma_poll_cq;
-	dev->ib_dev.req_notify_cq = pvrdma_req_notify_cq;
-	dev->ib_dev.get_dma_mr = pvrdma_get_dma_mr;
-	dev->ib_dev.reg_user_mr	= pvrdma_reg_user_mr;
-	dev->ib_dev.dereg_mr = pvrdma_dereg_mr;
-	dev->ib_dev.alloc_mr = pvrdma_alloc_mr;
-	dev->ib_dev.map_mr_sg = pvrdma_map_mr_sg;
-	dev->ib_dev.add_gid = pvrdma_add_gid;
-	dev->ib_dev.del_gid = pvrdma_del_gid;
-	dev->ib_dev.get_netdev = pvrdma_get_netdev;
-	dev->ib_dev.get_port_immutable = pvrdma_port_immutable;
-	dev->ib_dev.get_link_layer = pvrdma_port_link_layer;
-	dev->ib_dev.get_dev_fw_str = pvrdma_get_fw_ver_str;
-
 	ib_set_device_ops(&dev->ib_dev, &pvrdma_dev_ops);
 
 	mutex_init(&dev->port_mutex);
@@ -297,10 +263,6 @@ static int pvrdma_register_device(struct pvrdma_dev *dev)
 			(1ull << IB_USER_VERBS_CMD_DESTROY_SRQ)	|
 			(1ull << IB_USER_VERBS_CMD_POST_SRQ_RECV);
 
-		dev->ib_dev.create_srq = pvrdma_create_srq;
-		dev->ib_dev.modify_srq = pvrdma_modify_srq;
-		dev->ib_dev.query_srq = pvrdma_query_srq;
-		dev->ib_dev.destroy_srq = pvrdma_destroy_srq;
 		ib_set_device_ops(&dev->ib_dev, &pvrdma_dev_srq_ops);
 
 		dev->srq_tbl = kcalloc(dev->dsr->caps.max_srq,
diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index 723d3daf2eba..7c79e5ce8c39 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -395,8 +395,8 @@ enum {
 static inline int check_driver_override(struct rvt_dev_info *rdi,
 					size_t offset, void *func)
 {
-	if (!*(void **)((void *)&rdi->ibdev + offset)) {
-		*(void **)((void *)&rdi->ibdev + offset) = func;
+	if (!*(void **)((void *)&rdi->ibdev.ops + offset)) {
+		*(void **)((void *)&rdi->ibdev.ops + offset) = func;
 		return 0;
 	}
 
@@ -417,7 +417,7 @@ static noinline int check_support(struct rvt_dev_info *rdi, int verb)
 		break;
 
 	case QUERY_DEVICE:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    query_device),
 						    rvt_query_device);
 		break;
@@ -427,14 +427,14 @@ static noinline int check_support(struct rvt_dev_info *rdi, int verb)
 		 * rdmavt does not support modify device currently drivers must
 		 * provide.
 		 */
-		if (!check_driver_override(rdi, offsetof(struct ib_device,
+		if (!check_driver_override(rdi, offsetof(struct ib_device_ops,
 							 modify_device),
 					   rvt_modify_device))
 			return -EOPNOTSUPP;
 		break;
 
 	case QUERY_PORT:
-		if (!check_driver_override(rdi, offsetof(struct ib_device,
+		if (!check_driver_override(rdi, offsetof(struct ib_device_ops,
 							 query_port),
 					   rvt_query_port))
 			if (!rdi->driver_f.query_port_state)
@@ -442,7 +442,7 @@ static noinline int check_support(struct rvt_dev_info *rdi, int verb)
 		break;
 
 	case MODIFY_PORT:
-		if (!check_driver_override(rdi, offsetof(struct ib_device,
+		if (!check_driver_override(rdi, offsetof(struct ib_device_ops,
 							 modify_port),
 					   rvt_modify_port))
 			if (!rdi->driver_f.cap_mask_chg ||
@@ -451,13 +451,13 @@ static noinline int check_support(struct rvt_dev_info *rdi, int verb)
 		break;
 
 	case QUERY_PKEY:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    query_pkey),
 				      rvt_query_pkey);
 		break;
 
 	case QUERY_GID:
-		if (!check_driver_override(rdi, offsetof(struct ib_device,
+		if (!check_driver_override(rdi, offsetof(struct ib_device_ops,
 							 query_gid),
 					   rvt_query_gid))
 			if (!rdi->driver_f.get_guid_be)
@@ -465,25 +465,25 @@ static noinline int check_support(struct rvt_dev_info *rdi, int verb)
 		break;
 
 	case ALLOC_UCONTEXT:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    alloc_ucontext),
 				      rvt_alloc_ucontext);
 		break;
 
 	case DEALLOC_UCONTEXT:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    dealloc_ucontext),
 				      rvt_dealloc_ucontext);
 		break;
 
 	case GET_PORT_IMMUTABLE:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    get_port_immutable),
 				      rvt_get_port_immutable);
 		break;
 
 	case CREATE_QP:
-		if (!check_driver_override(rdi, offsetof(struct ib_device,
+		if (!check_driver_override(rdi, offsetof(struct ib_device_ops,
 							 create_qp),
 					   rvt_create_qp))
 			if (!rdi->driver_f.qp_priv_alloc ||
@@ -496,7 +496,7 @@ static noinline int check_support(struct rvt_dev_info *rdi, int verb)
 		break;
 
 	case MODIFY_QP:
-		if (!check_driver_override(rdi, offsetof(struct ib_device,
+		if (!check_driver_override(rdi, offsetof(struct ib_device_ops,
 							 modify_qp),
 					   rvt_modify_qp))
 			if (!rdi->driver_f.notify_qp_reset ||
@@ -512,7 +512,7 @@ static noinline int check_support(struct rvt_dev_info *rdi, int verb)
 		break;
 
 	case DESTROY_QP:
-		if (!check_driver_override(rdi, offsetof(struct ib_device,
+		if (!check_driver_override(rdi, offsetof(struct ib_device_ops,
 							 destroy_qp),
 					   rvt_destroy_qp))
 			if (!rdi->driver_f.qp_priv_free ||
@@ -524,13 +524,13 @@ static noinline int check_support(struct rvt_dev_info *rdi, int verb)
 		break;
 
 	case QUERY_QP:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    query_qp),
 						    rvt_query_qp);
 		break;
 
 	case POST_SEND:
-		if (!check_driver_override(rdi, offsetof(struct ib_device,
+		if (!check_driver_override(rdi, offsetof(struct ib_device_ops,
 							 post_send),
 					   rvt_post_send))
 			if (!rdi->driver_f.schedule_send ||
@@ -540,174 +540,174 @@ static noinline int check_support(struct rvt_dev_info *rdi, int verb)
 		break;
 
 	case POST_RECV:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    post_recv),
 				      rvt_post_recv);
 		break;
 	case POST_SRQ_RECV:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    post_srq_recv),
 				      rvt_post_srq_recv);
 		break;
 
 	case CREATE_AH:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    create_ah),
 				      rvt_create_ah);
 		break;
 
 	case DESTROY_AH:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    destroy_ah),
 				      rvt_destroy_ah);
 		break;
 
 	case MODIFY_AH:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    modify_ah),
 				      rvt_modify_ah);
 		break;
 
 	case QUERY_AH:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    query_ah),
 				      rvt_query_ah);
 		break;
 
 	case CREATE_SRQ:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    create_srq),
 				      rvt_create_srq);
 		break;
 
 	case MODIFY_SRQ:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    modify_srq),
 				      rvt_modify_srq);
 		break;
 
 	case DESTROY_SRQ:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    destroy_srq),
 				      rvt_destroy_srq);
 		break;
 
 	case QUERY_SRQ:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    query_srq),
 				      rvt_query_srq);
 		break;
 
 	case ATTACH_MCAST:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    attach_mcast),
 				      rvt_attach_mcast);
 		break;
 
 	case DETACH_MCAST:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    detach_mcast),
 				      rvt_detach_mcast);
 		break;
 
 	case GET_DMA_MR:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    get_dma_mr),
 				      rvt_get_dma_mr);
 		break;
 
 	case REG_USER_MR:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    reg_user_mr),
 				      rvt_reg_user_mr);
 		break;
 
 	case DEREG_MR:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    dereg_mr),
 				      rvt_dereg_mr);
 		break;
 
 	case ALLOC_FMR:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    alloc_fmr),
 				      rvt_alloc_fmr);
 		break;
 
 	case ALLOC_MR:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    alloc_mr),
 				      rvt_alloc_mr);
 		break;
 
 	case MAP_MR_SG:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    map_mr_sg),
 				      rvt_map_mr_sg);
 		break;
 
 	case MAP_PHYS_FMR:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    map_phys_fmr),
 				      rvt_map_phys_fmr);
 		break;
 
 	case UNMAP_FMR:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    unmap_fmr),
 				      rvt_unmap_fmr);
 		break;
 
 	case DEALLOC_FMR:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    dealloc_fmr),
 				      rvt_dealloc_fmr);
 		break;
 
 	case MMAP:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    mmap),
 				      rvt_mmap);
 		break;
 
 	case CREATE_CQ:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    create_cq),
 				      rvt_create_cq);
 		break;
 
 	case DESTROY_CQ:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    destroy_cq),
 				      rvt_destroy_cq);
 		break;
 
 	case POLL_CQ:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    poll_cq),
 				      rvt_poll_cq);
 		break;
 
 	case REQ_NOTFIY_CQ:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    req_notify_cq),
 				      rvt_req_notify_cq);
 		break;
 
 	case RESIZE_CQ:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    resize_cq),
 				      rvt_resize_cq);
 		break;
 
 	case ALLOC_PD:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    alloc_pd),
 				      rvt_alloc_pd);
 		break;
 
 	case DEALLOC_PD:
-		check_driver_override(rdi, offsetof(struct ib_device,
+		check_driver_override(rdi, offsetof(struct ib_device_ops,
 						    dealloc_pd),
 				      rvt_dealloc_pd);
 		break;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 4f28f71b7746..cacb42bf5495 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1253,50 +1253,6 @@ int rxe_register_device(struct rxe_dev *rxe)
 	    | BIT_ULL(IB_USER_VERBS_CMD_DETACH_MCAST)
 	    ;
 
-	dev->query_device = rxe_query_device;
-	dev->modify_device = rxe_modify_device;
-	dev->query_port = rxe_query_port;
-	dev->modify_port = rxe_modify_port;
-	dev->get_link_layer = rxe_get_link_layer;
-	dev->get_netdev = rxe_get_netdev;
-	dev->query_pkey = rxe_query_pkey;
-	dev->alloc_ucontext = rxe_alloc_ucontext;
-	dev->dealloc_ucontext = rxe_dealloc_ucontext;
-	dev->mmap = rxe_mmap;
-	dev->get_port_immutable = rxe_port_immutable;
-	dev->alloc_pd = rxe_alloc_pd;
-	dev->dealloc_pd = rxe_dealloc_pd;
-	dev->create_ah = rxe_create_ah;
-	dev->modify_ah = rxe_modify_ah;
-	dev->query_ah = rxe_query_ah;
-	dev->destroy_ah = rxe_destroy_ah;
-	dev->create_srq = rxe_create_srq;
-	dev->modify_srq = rxe_modify_srq;
-	dev->query_srq = rxe_query_srq;
-	dev->destroy_srq = rxe_destroy_srq;
-	dev->post_srq_recv = rxe_post_srq_recv;
-	dev->create_qp = rxe_create_qp;
-	dev->modify_qp = rxe_modify_qp;
-	dev->query_qp = rxe_query_qp;
-	dev->destroy_qp = rxe_destroy_qp;
-	dev->post_send = rxe_post_send;
-	dev->post_recv = rxe_post_recv;
-	dev->create_cq = rxe_create_cq;
-	dev->destroy_cq = rxe_destroy_cq;
-	dev->resize_cq = rxe_resize_cq;
-	dev->poll_cq = rxe_poll_cq;
-	dev->peek_cq = rxe_peek_cq;
-	dev->req_notify_cq = rxe_req_notify_cq;
-	dev->get_dma_mr = rxe_get_dma_mr;
-	dev->reg_user_mr = rxe_reg_user_mr;
-	dev->dereg_mr = rxe_dereg_mr;
-	dev->alloc_mr = rxe_alloc_mr;
-	dev->map_mr_sg = rxe_map_mr_sg;
-	dev->attach_mcast = rxe_attach_mcast;
-	dev->detach_mcast = rxe_detach_mcast;
-	dev->get_hw_stats = rxe_ib_get_hw_stats;
-	dev->alloc_hw_stats = rxe_ib_alloc_hw_stats;
-
 	ib_set_device_ops(dev, &rxe_dev_ops);
 
 	tfm = crypto_alloc_shash("crc32", 0, 0);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 1df90f0d9e64..c4c07ab42c62 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -2149,16 +2149,16 @@ static struct net_device *ipoib_get_netdev(struct ib_device *hca, u8 port,
 {
 	struct net_device *dev;
 
-	if (hca->alloc_rdma_netdev) {
-		dev = hca->alloc_rdma_netdev(hca, port,
-					     RDMA_NETDEV_IPOIB, name,
-					     NET_NAME_UNKNOWN,
-					     ipoib_setup_common);
+	if (hca->ops.alloc_rdma_netdev) {
+		dev = hca->ops.alloc_rdma_netdev(hca, port,
+						 RDMA_NETDEV_IPOIB, name,
+						 NET_NAME_UNKNOWN,
+						 ipoib_setup_common);
 		if (IS_ERR_OR_NULL(dev) && PTR_ERR(dev) != -EOPNOTSUPP)
 			return NULL;
 	}
 
-	if (!hca->alloc_rdma_netdev || PTR_ERR(dev) == -EOPNOTSUPP)
+	if (!hca->ops.alloc_rdma_netdev || PTR_ERR(dev) == -EOPNOTSUPP)
 		dev = ipoib_create_netdev_default(hca, name, NET_NAME_UNKNOWN,
 						  ipoib_setup_common);
 
diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
index 009be8889d71..86669bb06572 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -77,8 +77,8 @@ int iser_assign_reg_ops(struct iser_device *device)
 	struct ib_device *ib_dev = device->ib_device;
 
 	/* Assign function handles  - based on FMR support */
-	if (ib_dev->alloc_fmr && ib_dev->dealloc_fmr &&
-	    ib_dev->map_phys_fmr && ib_dev->unmap_fmr) {
+	if (ib_dev->ops.alloc_fmr && ib_dev->ops.dealloc_fmr &&
+	    ib_dev->ops.map_phys_fmr && ib_dev->ops.unmap_fmr) {
 		iser_info("FMR supported, using FMR for registration\n");
 		device->reg_ops = &fmr_ops;
 	} else if (ib_dev->attrs.device_cap_flags & IB_DEVICE_MEM_MGT_EXTENSIONS) {
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c
index 61558788b3fa..ae70cd18903e 100644
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c
@@ -330,10 +330,10 @@ struct opa_vnic_adapter *opa_vnic_add_netdev(struct ib_device *ibdev,
 	struct rdma_netdev *rn;
 	int rc;
 
-	netdev = ibdev->alloc_rdma_netdev(ibdev, port_num,
-					  RDMA_NETDEV_OPA_VNIC,
-					  "veth%d", NET_NAME_UNKNOWN,
-					  ether_setup);
+	netdev = ibdev->ops.alloc_rdma_netdev(ibdev, port_num,
+					      RDMA_NETDEV_OPA_VNIC,
+					      "veth%d", NET_NAME_UNKNOWN,
+					      ether_setup);
 	if (!netdev)
 		return ERR_PTR(-ENOMEM);
 	else if (IS_ERR(netdev))
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index e2ad7c5ea296..a74d24f2d267 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -4072,8 +4072,10 @@ static void srp_add_one(struct ib_device *device)
 	srp_dev->max_pages_per_mr = min_t(u64, SRP_MAX_PAGES_PER_MR,
 					  max_pages_per_mr);
 
-	srp_dev->has_fmr = (device->alloc_fmr && device->dealloc_fmr &&
-			    device->map_phys_fmr && device->unmap_fmr);
+	srp_dev->has_fmr = (device->ops.alloc_fmr &&
+			    device->ops.dealloc_fmr &&
+			    device->ops.map_phys_fmr &&
+			    device->ops.unmap_fmr);
 	srp_dev->has_fr = (attr->device_cap_flags &
 			   IB_DEVICE_MEM_MGT_EXTENSIONS);
 	if (!never_register && !srp_dev->has_fmr && !srp_dev->has_fr) {
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 664b957e7855..7196d0835423 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2496,269 +2496,6 @@ struct ib_device {
 
 	struct iw_cm_verbs	     *iwcm;
 
-	/**
-	 * alloc_hw_stats - Allocate a struct rdma_hw_stats and fill in the
-	 *   driver initialized data.  The struct is kfree()'ed by the sysfs
-	 *   core when the device is removed.  A lifespan of -1 in the return
-	 *   struct tells the core to set a default lifespan.
-	 */
-	struct rdma_hw_stats      *(*alloc_hw_stats)(struct ib_device *device,
-						     u8 port_num);
-	/**
-	 * get_hw_stats - Fill in the counter value(s) in the stats struct.
-	 * @index - The index in the value array we wish to have updated, or
-	 *   num_counters if we want all stats updated
-	 * Return codes -
-	 *   < 0 - Error, no counters updated
-	 *   index - Updated the single counter pointed to by index
-	 *   num_counters - Updated all counters (will reset the timestamp
-	 *     and prevent further calls for lifespan milliseconds)
-	 * Drivers are allowed to update all counters in leiu of just the
-	 *   one given in index at their option
-	 */
-	int		           (*get_hw_stats)(struct ib_device *device,
-						   struct rdma_hw_stats *stats,
-						   u8 port, int index);
-	int		           (*query_device)(struct ib_device *device,
-						   struct ib_device_attr *device_attr,
-						   struct ib_udata *udata);
-	int		           (*query_port)(struct ib_device *device,
-						 u8 port_num,
-						 struct ib_port_attr *port_attr);
-	enum rdma_link_layer	   (*get_link_layer)(struct ib_device *device,
-						     u8 port_num);
-	/* When calling get_netdev, the HW vendor's driver should return the
-	 * net device of device @device at port @port_num or NULL if such
-	 * a net device doesn't exist. The vendor driver should call dev_hold
-	 * on this net device. The HW vendor's device driver must guarantee
-	 * that this function returns NULL before the net device has finished
-	 * NETDEV_UNREGISTER state.
-	 */
-	struct net_device	  *(*get_netdev)(struct ib_device *device,
-						 u8 port_num);
-	/* query_gid should be return GID value for @device, when @port_num
-	 * link layer is either IB or iWarp. It is no-op if @port_num port
-	 * is RoCE link layer.
-	 */
-	int		           (*query_gid)(struct ib_device *device,
-						u8 port_num, int index,
-						union ib_gid *gid);
-	/* When calling add_gid, the HW vendor's driver should add the gid
-	 * of device of port at gid index available at @attr. Meta-info of
-	 * that gid (for example, the network device related to this gid) is
-	 * available at @attr. @context allows the HW vendor driver to store
-	 * extra information together with a GID entry. The HW vendor driver may
-	 * allocate memory to contain this information and store it in @context
-	 * when a new GID entry is written to. Params are consistent until the
-	 * next call of add_gid or delete_gid. The function should return 0 on
-	 * success or error otherwise. The function could be called
-	 * concurrently for different ports. This function is only called when
-	 * roce_gid_table is used.
-	 */
-	int		           (*add_gid)(const struct ib_gid_attr *attr,
-					      void **context);
-	/* When calling del_gid, the HW vendor's driver should delete the
-	 * gid of device @device at gid index gid_index of port port_num
-	 * available in @attr.
-	 * Upon the deletion of a GID entry, the HW vendor must free any
-	 * allocated memory. The caller will clear @context afterwards.
-	 * This function is only called when roce_gid_table is used.
-	 */
-	int		           (*del_gid)(const struct ib_gid_attr *attr,
-					      void **context);
-	int		           (*query_pkey)(struct ib_device *device,
-						 u8 port_num, u16 index, u16 *pkey);
-	int		           (*modify_device)(struct ib_device *device,
-						    int device_modify_mask,
-						    struct ib_device_modify *device_modify);
-	int		           (*modify_port)(struct ib_device *device,
-						  u8 port_num, int port_modify_mask,
-						  struct ib_port_modify *port_modify);
-	struct ib_ucontext *       (*alloc_ucontext)(struct ib_device *device,
-						     struct ib_udata *udata);
-	int                        (*dealloc_ucontext)(struct ib_ucontext *context);
-	int                        (*mmap)(struct ib_ucontext *context,
-					   struct vm_area_struct *vma);
-	struct ib_pd *             (*alloc_pd)(struct ib_device *device,
-					       struct ib_ucontext *context,
-					       struct ib_udata *udata);
-	int                        (*dealloc_pd)(struct ib_pd *pd);
-	struct ib_ah *             (*create_ah)(struct ib_pd *pd,
-						struct rdma_ah_attr *ah_attr,
-						struct ib_udata *udata);
-	int                        (*modify_ah)(struct ib_ah *ah,
-						struct rdma_ah_attr *ah_attr);
-	int                        (*query_ah)(struct ib_ah *ah,
-					       struct rdma_ah_attr *ah_attr);
-	int                        (*destroy_ah)(struct ib_ah *ah);
-	struct ib_srq *            (*create_srq)(struct ib_pd *pd,
-						 struct ib_srq_init_attr *srq_init_attr,
-						 struct ib_udata *udata);
-	int                        (*modify_srq)(struct ib_srq *srq,
-						 struct ib_srq_attr *srq_attr,
-						 enum ib_srq_attr_mask srq_attr_mask,
-						 struct ib_udata *udata);
-	int                        (*query_srq)(struct ib_srq *srq,
-						struct ib_srq_attr *srq_attr);
-	int                        (*destroy_srq)(struct ib_srq *srq);
-	int                        (*post_srq_recv)(struct ib_srq *srq,
-						    const struct ib_recv_wr *recv_wr,
-						    const struct ib_recv_wr **bad_recv_wr);
-	struct ib_qp *             (*create_qp)(struct ib_pd *pd,
-						struct ib_qp_init_attr *qp_init_attr,
-						struct ib_udata *udata);
-	int                        (*modify_qp)(struct ib_qp *qp,
-						struct ib_qp_attr *qp_attr,
-						int qp_attr_mask,
-						struct ib_udata *udata);
-	int                        (*query_qp)(struct ib_qp *qp,
-					       struct ib_qp_attr *qp_attr,
-					       int qp_attr_mask,
-					       struct ib_qp_init_attr *qp_init_attr);
-	int                        (*destroy_qp)(struct ib_qp *qp);
-	int                        (*post_send)(struct ib_qp *qp,
-						const struct ib_send_wr *send_wr,
-						const struct ib_send_wr **bad_send_wr);
-	int                        (*post_recv)(struct ib_qp *qp,
-						const struct ib_recv_wr *recv_wr,
-						const struct ib_recv_wr **bad_recv_wr);
-	struct ib_cq *             (*create_cq)(struct ib_device *device,
-						const struct ib_cq_init_attr *attr,
-						struct ib_ucontext *context,
-						struct ib_udata *udata);
-	int                        (*modify_cq)(struct ib_cq *cq, u16 cq_count,
-						u16 cq_period);
-	int                        (*destroy_cq)(struct ib_cq *cq);
-	int                        (*resize_cq)(struct ib_cq *cq, int cqe,
-						struct ib_udata *udata);
-	int                        (*poll_cq)(struct ib_cq *cq, int num_entries,
-					      struct ib_wc *wc);
-	int                        (*peek_cq)(struct ib_cq *cq, int wc_cnt);
-	int                        (*req_notify_cq)(struct ib_cq *cq,
-						    enum ib_cq_notify_flags flags);
-	int                        (*req_ncomp_notif)(struct ib_cq *cq,
-						      int wc_cnt);
-	struct ib_mr *             (*get_dma_mr)(struct ib_pd *pd,
-						 int mr_access_flags);
-	struct ib_mr *             (*reg_user_mr)(struct ib_pd *pd,
-						  u64 start, u64 length,
-						  u64 virt_addr,
-						  int mr_access_flags,
-						  struct ib_udata *udata);
-	int			   (*rereg_user_mr)(struct ib_mr *mr,
-						    int flags,
-						    u64 start, u64 length,
-						    u64 virt_addr,
-						    int mr_access_flags,
-						    struct ib_pd *pd,
-						    struct ib_udata *udata);
-	int                        (*dereg_mr)(struct ib_mr *mr);
-	struct ib_mr *		   (*alloc_mr)(struct ib_pd *pd,
-					       enum ib_mr_type mr_type,
-					       u32 max_num_sg);
-	int                        (*map_mr_sg)(struct ib_mr *mr,
-						struct scatterlist *sg,
-						int sg_nents,
-						unsigned int *sg_offset);
-	struct ib_mw *             (*alloc_mw)(struct ib_pd *pd,
-					       enum ib_mw_type type,
-					       struct ib_udata *udata);
-	int                        (*dealloc_mw)(struct ib_mw *mw);
-	struct ib_fmr *	           (*alloc_fmr)(struct ib_pd *pd,
-						int mr_access_flags,
-						struct ib_fmr_attr *fmr_attr);
-	int		           (*map_phys_fmr)(struct ib_fmr *fmr,
-						   u64 *page_list, int list_len,
-						   u64 iova);
-	int		           (*unmap_fmr)(struct list_head *fmr_list);
-	int		           (*dealloc_fmr)(struct ib_fmr *fmr);
-	int                        (*attach_mcast)(struct ib_qp *qp,
-						   union ib_gid *gid,
-						   u16 lid);
-	int                        (*detach_mcast)(struct ib_qp *qp,
-						   union ib_gid *gid,
-						   u16 lid);
-	int                        (*process_mad)(struct ib_device *device,
-						  int process_mad_flags,
-						  u8 port_num,
-						  const struct ib_wc *in_wc,
-						  const struct ib_grh *in_grh,
-						  const struct ib_mad_hdr *in_mad,
-						  size_t in_mad_size,
-						  struct ib_mad_hdr *out_mad,
-						  size_t *out_mad_size,
-						  u16 *out_mad_pkey_index);
-	struct ib_xrcd *	   (*alloc_xrcd)(struct ib_device *device,
-						 struct ib_ucontext *ucontext,
-						 struct ib_udata *udata);
-	int			   (*dealloc_xrcd)(struct ib_xrcd *xrcd);
-	struct ib_flow *	   (*create_flow)(struct ib_qp *qp,
-						  struct ib_flow_attr
-						  *flow_attr,
-						  int domain,
-						  struct ib_udata *udata);
-	int			   (*destroy_flow)(struct ib_flow *flow_id);
-	int			   (*check_mr_status)(struct ib_mr *mr, u32 check_mask,
-						      struct ib_mr_status *mr_status);
-	void			   (*disassociate_ucontext)(struct ib_ucontext *ibcontext);
-	void			   (*drain_rq)(struct ib_qp *qp);
-	void			   (*drain_sq)(struct ib_qp *qp);
-	int			   (*set_vf_link_state)(struct ib_device *device, int vf, u8 port,
-							int state);
-	int			   (*get_vf_config)(struct ib_device *device, int vf, u8 port,
-						   struct ifla_vf_info *ivf);
-	int			   (*get_vf_stats)(struct ib_device *device, int vf, u8 port,
-						   struct ifla_vf_stats *stats);
-	int			   (*set_vf_guid)(struct ib_device *device, int vf, u8 port, u64 guid,
-						  int type);
-	struct ib_wq *		   (*create_wq)(struct ib_pd *pd,
-						struct ib_wq_init_attr *init_attr,
-						struct ib_udata *udata);
-	int			   (*destroy_wq)(struct ib_wq *wq);
-	int			   (*modify_wq)(struct ib_wq *wq,
-						struct ib_wq_attr *attr,
-						u32 wq_attr_mask,
-						struct ib_udata *udata);
-	struct ib_rwq_ind_table *  (*create_rwq_ind_table)(struct ib_device *device,
-							   struct ib_rwq_ind_table_init_attr *init_attr,
-							   struct ib_udata *udata);
-	int                        (*destroy_rwq_ind_table)(struct ib_rwq_ind_table *wq_ind_table);
-	struct ib_flow_action *	   (*create_flow_action_esp)(struct ib_device *device,
-							     const struct ib_flow_action_attrs_esp *attr,
-							     struct uverbs_attr_bundle *attrs);
-	int			   (*destroy_flow_action)(struct ib_flow_action *action);
-	int			   (*modify_flow_action_esp)(struct ib_flow_action *action,
-							     const struct ib_flow_action_attrs_esp *attr,
-							     struct uverbs_attr_bundle *attrs);
-	struct ib_dm *             (*alloc_dm)(struct ib_device *device,
-					       struct ib_ucontext *context,
-					       struct ib_dm_alloc_attr *attr,
-					       struct uverbs_attr_bundle *attrs);
-	int                        (*dealloc_dm)(struct ib_dm *dm);
-	struct ib_mr *             (*reg_dm_mr)(struct ib_pd *pd, struct ib_dm *dm,
-						struct ib_dm_mr_attr *attr,
-						struct uverbs_attr_bundle *attrs);
-	struct ib_counters *	(*create_counters)(struct ib_device *device,
-						   struct uverbs_attr_bundle *attrs);
-	int	(*destroy_counters)(struct ib_counters	*counters);
-	int	(*read_counters)(struct ib_counters *counters,
-				 struct ib_counters_read_attr *counters_read_attr,
-				 struct uverbs_attr_bundle *attrs);
-
-	/**
-	 * rdma netdev operation
-	 *
-	 * Driver implementing alloc_rdma_netdev must return -EOPNOTSUPP if it
-	 * doesn't support the specified rdma netdev type.
-	 */
-	struct net_device *(*alloc_rdma_netdev)(
-					struct ib_device *device,
-					u8 port_num,
-					enum rdma_netdev_t type,
-					const char *name,
-					unsigned char name_assign_type,
-					void (*setup)(struct net_device *));
-
 	struct module               *owner;
 	struct device                dev;
 	/* First group for device attributes, NULL terminated array */
@@ -2797,17 +2534,6 @@ struct ib_device {
 	 */
 	struct rdma_restrack_root     res;
 
-	/**
-	 * The following mandatory functions are used only at device
-	 * registration.  Keep functions such as these at the end of this
-	 * structure to avoid cache line misses when accessing struct ib_device
-	 * in fast paths.
-	 */
-	int (*get_port_immutable)(struct ib_device *, u8, struct ib_port_immutable *);
-	void (*get_dev_fw_str)(struct ib_device *, char *str);
-	const struct cpumask *(*get_vector_affinity)(struct ib_device *ibdev,
-						     int comp_vector);
-
 	const struct uverbs_object_tree_def *const *driver_specs;
 	enum rdma_driver_id		driver_id;
 };
@@ -3315,7 +3041,7 @@ static inline bool rdma_cap_roce_gid_table(const struct ib_device *device,
 					   u8 port_num)
 {
 	return rdma_protocol_roce(device, port_num) &&
-		device->add_gid && device->del_gid;
+		device->ops.add_gid && device->ops.del_gid;
 }
 
 /*
@@ -3539,7 +3265,8 @@ static inline int ib_post_srq_recv(struct ib_srq *srq,
 {
 	const struct ib_recv_wr *dummy;
 
-	return srq->device->post_srq_recv(srq, recv_wr, bad_recv_wr ? : &dummy);
+	return srq->device->ops.post_srq_recv(srq, recv_wr,
+					      bad_recv_wr ? : &dummy);
 }
 
 /**
@@ -3642,7 +3369,7 @@ static inline int ib_post_send(struct ib_qp *qp,
 {
 	const struct ib_send_wr *dummy;
 
-	return qp->device->post_send(qp, send_wr, bad_send_wr ? : &dummy);
+	return qp->device->ops.post_send(qp, send_wr, bad_send_wr ? : &dummy);
 }
 
 /**
@@ -3659,7 +3386,7 @@ static inline int ib_post_recv(struct ib_qp *qp,
 {
 	const struct ib_recv_wr *dummy;
 
-	return qp->device->post_recv(qp, recv_wr, bad_recv_wr ? : &dummy);
+	return qp->device->ops.post_recv(qp, recv_wr, bad_recv_wr ? : &dummy);
 }
 
 struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private,
@@ -3732,7 +3459,7 @@ int ib_destroy_cq(struct ib_cq *cq);
 static inline int ib_poll_cq(struct ib_cq *cq, int num_entries,
 			     struct ib_wc *wc)
 {
-	return cq->device->poll_cq(cq, num_entries, wc);
+	return cq->device->ops.poll_cq(cq, num_entries, wc);
 }
 
 /**
@@ -3765,7 +3492,7 @@ static inline int ib_poll_cq(struct ib_cq *cq, int num_entries,
 static inline int ib_req_notify_cq(struct ib_cq *cq,
 				   enum ib_cq_notify_flags flags)
 {
-	return cq->device->req_notify_cq(cq, flags);
+	return cq->device->ops.req_notify_cq(cq, flags);
 }
 
 /**
@@ -3777,8 +3504,8 @@ static inline int ib_req_notify_cq(struct ib_cq *cq,
  */
 static inline int ib_req_ncomp_notif(struct ib_cq *cq, int wc_cnt)
 {
-	return cq->device->req_ncomp_notif ?
-		cq->device->req_ncomp_notif(cq, wc_cnt) :
+	return cq->device->ops.req_ncomp_notif ?
+		cq->device->ops.req_ncomp_notif(cq, wc_cnt) :
 		-ENOSYS;
 }
 
@@ -4042,7 +3769,7 @@ static inline int ib_map_phys_fmr(struct ib_fmr *fmr,
 				  u64 *page_list, int list_len,
 				  u64 iova)
 {
-	return fmr->device->map_phys_fmr(fmr, page_list, list_len, iova);
+	return fmr->device->ops.map_phys_fmr(fmr, page_list, list_len, iova);
 }
 
 /**
@@ -4395,10 +4122,10 @@ static inline const struct cpumask *
 ib_get_vector_affinity(struct ib_device *device, int comp_vector)
 {
 	if (comp_vector < 0 || comp_vector >= device->num_comp_vectors ||
-	    !device->get_vector_affinity)
+	    !device->ops.get_vector_affinity)
 		return NULL;
 
-	return device->get_vector_affinity(device, comp_vector);
+	return device->ops.get_vector_affinity(device, comp_vector);
 
 }
 
diff --git a/net/sunrpc/xprtrdma/fmr_ops.c b/net/sunrpc/xprtrdma/fmr_ops.c
index 0f7c465d9a5a..ba1bd4bdc29f 100644
--- a/net/sunrpc/xprtrdma/fmr_ops.c
+++ b/net/sunrpc/xprtrdma/fmr_ops.c
@@ -41,7 +41,7 @@ enum {
 bool
 fmr_is_supported(struct rpcrdma_ia *ia)
 {
-	if (!ia->ri_device->alloc_fmr) {
+	if (!ia->ri_device->ops.alloc_fmr) {
 		pr_info("rpcrdma: 'fmr' mode is not supported by device %s\n",
 			ia->ri_device->name);
 		return false;
-- 
2.14.4

