Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9A6ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9809E214DD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4yPBHum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9809E214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeJIXqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:46:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37300 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeJIXqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:46:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id y11-v6so2520381wrd.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bTJ7BqP3qi3asZMzYzhJwaoF2oWts3Zoc7WcSNIs1kU=;
        b=U4yPBHumvFrJAwtPRV1p5OS+9eTDPFytn56gbJDeV5uPuy98G++QkZHGTukjA0mUtg
         zw/b3fP0PDuuTwymC6BEe2pWH71aPNayPhlbir0+THxrxlIjdR/+776CPXODtpIRKJJ0
         CWxLRKx5nihme0bGtRTrXOP2LxEWJlZ8BUZq+9bQ2hFj4eCivwTg3YaWhbo+lgP94CI8
         koRww3GLrl1KwRY7Z0I/d/kThOsC6hvMsCK0meWeu7BohY05io4bJwCXx0vBER9/OFNv
         L9pqFxUonRbBW4aVkdrWb6+pXcRVW6snYMIx+YKacyHko0w327y1NV2qnfPCovUMOb4V
         eCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bTJ7BqP3qi3asZMzYzhJwaoF2oWts3Zoc7WcSNIs1kU=;
        b=J3EnjVLHbiwUVB4flyEjvv5tWIz0FO5hlCSDmfjxu09xK9UmWB0P6Cxe7MGa0L+/wY
         mU4fnJs+gZbCnx/z809exF4A19Ns8zHkrXJUgk9MkZEo/WicTEsxyGv16LUcMB+0Y5Ww
         vF7KdVjINktm2gyUoXfNYNh7BmTiGIE0nG+1Zpc8DPbZxAkBpVvg5wbEAar4DwTS2HDB
         BX5yBmLA0GelNrF4gxdi+nDz0jdLWdnejXXBo8DrQYFiIKikG6uCZMcxqnP6rOgf6l8M
         6DDOndZe+3TvgSvulxy7128Yy1YmZx/6rl+XuOkxyOuK/4VoXR+5SJfBzcoSfIwoBIkV
         9JAg==
X-Gm-Message-State: ABuFfoiDHdQibL9ME4Cq0s4rTSwnxKbcmHS++GMtB2/XwqFuXgcAt1UV
        ihM/92l2PGZZujjwZOq8eTI=
X-Google-Smtp-Source: ACcGV604U8pDY+RrvyTqlZNYK+PFtqpkFUkgGJKWDJUokE5o2G4GMczLjx+AJINBC6pDBCAUlS4HFQ==
X-Received: by 2002:adf:92a6:: with SMTP id 35-v6mr17952360wrn.137.1539102523890;
        Tue, 09 Oct 2018 09:28:43 -0700 (PDT)
Received: from kheib-workstation.mynet (bzq-109-64-21-122.red.bezeqint.net. [109.64.21.122])
        by smtp.gmail.com with ESMTPSA id h18-v6sm18082694wrb.82.2018.10.09.09.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:28:43 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kamalheib1@gmail.com
Subject: [PATCH rdma-next 01/18] RDMA/core: Introduce ib_device_ops
Date:   Tue,  9 Oct 2018 19:28:00 +0300
Message-Id: <20181009162817.4635-2-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181009162817.4635-1-kamalheib1@gmail.com>
References: <20181009162817.4635-1-kamalheib1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change introduce the ib_device_ops structure that defines all the
InfiniBand device operations, providers will need to define the
supported operations and assigning them using ib_set_device_ops().

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/core/device.c |  98 +++++++++++++++++
 include/rdma/ib_verbs.h          | 223 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 321 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index d105b9b2d118..8839ba876def 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1147,6 +1147,104 @@ struct net_device *ib_get_net_dev_by_params(struct ib_device *dev,
 }
 EXPORT_SYMBOL(ib_get_net_dev_by_params);
 
+void ib_set_device_ops(struct ib_device *dev, struct ib_device_ops *ops)
+{
+	struct ib_device_ops *dev_ops = &dev->ops;
+
+#define SET_DEVICE_OP(ptr, name)					\
+	do {								\
+		if (ops->name)						\
+			(ptr)->name = ops->name;			\
+	} while (0)
+
+	SET_DEVICE_OP(dev_ops, query_device);
+	SET_DEVICE_OP(dev_ops, modify_device);
+	SET_DEVICE_OP(dev_ops, get_dev_fw_str);
+	SET_DEVICE_OP(dev_ops, get_vector_affinity);
+	SET_DEVICE_OP(dev_ops, query_port);
+	SET_DEVICE_OP(dev_ops, modify_port);
+	SET_DEVICE_OP(dev_ops, get_port_immutable);
+	SET_DEVICE_OP(dev_ops, get_link_layer);
+	SET_DEVICE_OP(dev_ops, get_netdev);
+	SET_DEVICE_OP(dev_ops, alloc_rdma_netdev);
+	SET_DEVICE_OP(dev_ops, query_gid);
+	SET_DEVICE_OP(dev_ops, add_gid);
+	SET_DEVICE_OP(dev_ops, del_gid);
+	SET_DEVICE_OP(dev_ops, query_pkey);
+	SET_DEVICE_OP(dev_ops, alloc_ucontext);
+	SET_DEVICE_OP(dev_ops, dealloc_ucontext);
+	SET_DEVICE_OP(dev_ops, mmap);
+	SET_DEVICE_OP(dev_ops, alloc_pd);
+	SET_DEVICE_OP(dev_ops, dealloc_pd);
+	SET_DEVICE_OP(dev_ops, create_ah);
+	SET_DEVICE_OP(dev_ops, modify_ah);
+	SET_DEVICE_OP(dev_ops, query_ah);
+	SET_DEVICE_OP(dev_ops, destroy_ah);
+	SET_DEVICE_OP(dev_ops, create_srq);
+	SET_DEVICE_OP(dev_ops, modify_srq);
+	SET_DEVICE_OP(dev_ops, query_srq);
+	SET_DEVICE_OP(dev_ops, destroy_srq);
+	SET_DEVICE_OP(dev_ops, post_srq_recv);
+	SET_DEVICE_OP(dev_ops, create_qp);
+	SET_DEVICE_OP(dev_ops, modify_qp);
+	SET_DEVICE_OP(dev_ops, query_qp);
+	SET_DEVICE_OP(dev_ops, destroy_qp);
+	SET_DEVICE_OP(dev_ops, post_send);
+	SET_DEVICE_OP(dev_ops, post_recv);
+	SET_DEVICE_OP(dev_ops, create_cq);
+	SET_DEVICE_OP(dev_ops, modify_cq);
+	SET_DEVICE_OP(dev_ops, destroy_cq);
+	SET_DEVICE_OP(dev_ops, resize_cq);
+	SET_DEVICE_OP(dev_ops, poll_cq);
+	SET_DEVICE_OP(dev_ops, peek_cq);
+	SET_DEVICE_OP(dev_ops, req_notify_cq);
+	SET_DEVICE_OP(dev_ops, req_ncomp_notif);
+	SET_DEVICE_OP(dev_ops, get_dma_mr);
+	SET_DEVICE_OP(dev_ops, reg_user_mr);
+	SET_DEVICE_OP(dev_ops, rereg_user_mr);
+	SET_DEVICE_OP(dev_ops, dereg_mr);
+	SET_DEVICE_OP(dev_ops, alloc_mr);
+	SET_DEVICE_OP(dev_ops, map_mr_sg);
+	SET_DEVICE_OP(dev_ops, alloc_mw);
+	SET_DEVICE_OP(dev_ops, dealloc_mw);
+	SET_DEVICE_OP(dev_ops, alloc_fmr);
+	SET_DEVICE_OP(dev_ops, map_phys_fmr);
+	SET_DEVICE_OP(dev_ops, unmap_fmr);
+	SET_DEVICE_OP(dev_ops, dealloc_fmr);
+	SET_DEVICE_OP(dev_ops, attach_mcast);
+	SET_DEVICE_OP(dev_ops, detach_mcast);
+	SET_DEVICE_OP(dev_ops, process_mad);
+	SET_DEVICE_OP(dev_ops, alloc_xrcd);
+	SET_DEVICE_OP(dev_ops, dealloc_xrcd);
+	SET_DEVICE_OP(dev_ops, create_flow);
+	SET_DEVICE_OP(dev_ops, destroy_flow);
+	SET_DEVICE_OP(dev_ops, check_mr_status);
+	SET_DEVICE_OP(dev_ops, disassociate_ucontext);
+	SET_DEVICE_OP(dev_ops, drain_rq);
+	SET_DEVICE_OP(dev_ops, drain_sq);
+	SET_DEVICE_OP(dev_ops, set_vf_link_state);
+	SET_DEVICE_OP(dev_ops, get_vf_config);
+	SET_DEVICE_OP(dev_ops, get_vf_stats);
+	SET_DEVICE_OP(dev_ops, set_vf_guid);
+	SET_DEVICE_OP(dev_ops, create_wq);
+	SET_DEVICE_OP(dev_ops, destroy_wq);
+	SET_DEVICE_OP(dev_ops, modify_wq);
+	SET_DEVICE_OP(dev_ops, create_rwq_ind_table);
+	SET_DEVICE_OP(dev_ops, destroy_rwq_ind_table);
+	SET_DEVICE_OP(dev_ops, create_flow_action_esp);
+	SET_DEVICE_OP(dev_ops, destroy_flow_action);
+	SET_DEVICE_OP(dev_ops, modify_flow_action_esp);
+	SET_DEVICE_OP(dev_ops, alloc_dm);
+	SET_DEVICE_OP(dev_ops, dealloc_dm);
+	SET_DEVICE_OP(dev_ops, reg_dm_mr);
+	SET_DEVICE_OP(dev_ops, create_counters);
+	SET_DEVICE_OP(dev_ops, destroy_counters);
+	SET_DEVICE_OP(dev_ops, read_counters);
+	SET_DEVICE_OP(dev_ops, alloc_hw_stats);
+	SET_DEVICE_OP(dev_ops, get_hw_stats);
+}
+EXPORT_SYMBOL(ib_set_device_ops);
+
 static const struct rdma_nl_cbs ibnl_ls_cb_table[RDMA_NL_LS_NUM_OPS] = {
 	[RDMA_NL_LS_OP_RESOLVE] = {
 		.doit = ib_nl_handle_resolve_resp,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 7ce617d77f8f..664b957e7855 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2246,10 +2246,232 @@ struct ib_counters_read_attr {
 
 struct uverbs_attr_bundle;
 
+/**
+ * struct ib_device_ops - InfiniBand device operations
+ * This structure defines all the InfiniBand device operations, providers will
+ * need to define the supported operations, otherwise they will be set to null.
+ */
+struct ib_device_ops {
+	int		           (*query_device)(struct ib_device *device,
+						   struct ib_device_attr *device_attr,
+						   struct ib_udata *udata);
+	int		           (*modify_device)(struct ib_device *device,
+						    int device_modify_mask,
+						    struct ib_device_modify *device_modify);
+	void			   (*get_dev_fw_str)(struct ib_device *, char *str);
+	const struct cpumask *	   (*get_vector_affinity)(struct ib_device *ibdev,
+							  int comp_vector);
+	int		           (*query_port)(struct ib_device *device,
+						 u8 port_num,
+						 struct ib_port_attr *port_attr);
+	int		           (*modify_port)(struct ib_device *device,
+						  u8 port_num, int port_modify_mask,
+						  struct ib_port_modify *port_modify);
+	int			   (*get_port_immutable)(struct ib_device *, u8,
+							 struct ib_port_immutable *);
+	enum rdma_link_layer	   (*get_link_layer)(struct ib_device *device,
+						     u8 port_num);
+	struct net_device *	   (*get_netdev)(struct ib_device *device,
+						 u8 port_num);
+	struct net_device *	   (*alloc_rdma_netdev)(struct ib_device *device,
+							u8 port_num,
+							enum rdma_netdev_t type,
+							const char *name,
+							unsigned char name_assign_type,
+							void (*setup)(struct net_device *));
+	int		           (*query_gid)(struct ib_device *device,
+						u8 port_num, int index,
+						union ib_gid *gid);
+	int		           (*add_gid)(const struct ib_gid_attr *attr,
+					      void **context);
+	int		           (*del_gid)(const struct ib_gid_attr *attr,
+					      void **context);
+	int		           (*query_pkey)(struct ib_device *device,
+						 u8 port_num, u16 index, u16 *pkey);
+	struct ib_ucontext *       (*alloc_ucontext)(struct ib_device *device,
+						     struct ib_udata *udata);
+	int                        (*dealloc_ucontext)(struct ib_ucontext *context);
+	int                        (*mmap)(struct ib_ucontext *context,
+					   struct vm_area_struct *vma);
+	struct ib_pd *             (*alloc_pd)(struct ib_device *device,
+					       struct ib_ucontext *context,
+					       struct ib_udata *udata);
+	int                        (*dealloc_pd)(struct ib_pd *pd);
+	struct ib_ah *             (*create_ah)(struct ib_pd *pd,
+						struct rdma_ah_attr *ah_attr,
+						struct ib_udata *udata);
+	int                        (*modify_ah)(struct ib_ah *ah,
+						struct rdma_ah_attr *ah_attr);
+	int                        (*query_ah)(struct ib_ah *ah,
+					       struct rdma_ah_attr *ah_attr);
+	int                        (*destroy_ah)(struct ib_ah *ah);
+	struct ib_srq *            (*create_srq)(struct ib_pd *pd,
+						 struct ib_srq_init_attr *srq_init_attr,
+						 struct ib_udata *udata);
+	int                        (*modify_srq)(struct ib_srq *srq,
+						 struct ib_srq_attr *srq_attr,
+						 enum ib_srq_attr_mask srq_attr_mask,
+						 struct ib_udata *udata);
+	int                        (*query_srq)(struct ib_srq *srq,
+						struct ib_srq_attr *srq_attr);
+	int                        (*destroy_srq)(struct ib_srq *srq);
+	int                        (*post_srq_recv)(struct ib_srq *srq,
+						    const struct ib_recv_wr *recv_wr,
+						    const struct ib_recv_wr **bad_recv_wr);
+	struct ib_qp *             (*create_qp)(struct ib_pd *pd,
+						struct ib_qp_init_attr *qp_init_attr,
+						struct ib_udata *udata);
+	int                        (*modify_qp)(struct ib_qp *qp,
+						struct ib_qp_attr *qp_attr,
+						int qp_attr_mask,
+						struct ib_udata *udata);
+	int                        (*query_qp)(struct ib_qp *qp,
+					       struct ib_qp_attr *qp_attr,
+					       int qp_attr_mask,
+					       struct ib_qp_init_attr *qp_init_attr);
+	int                        (*destroy_qp)(struct ib_qp *qp);
+	int                        (*post_send)(struct ib_qp *qp,
+						const struct ib_send_wr *send_wr,
+						const struct ib_send_wr **bad_send_wr);
+	int                        (*post_recv)(struct ib_qp *qp,
+						const struct ib_recv_wr *recv_wr,
+						const struct ib_recv_wr **bad_recv_wr);
+	struct ib_cq *             (*create_cq)(struct ib_device *device,
+						const struct ib_cq_init_attr *attr,
+						struct ib_ucontext *context,
+						struct ib_udata *udata);
+	int                        (*modify_cq)(struct ib_cq *cq, u16 cq_count,
+						u16 cq_period);
+	int                        (*destroy_cq)(struct ib_cq *cq);
+	int                        (*resize_cq)(struct ib_cq *cq, int cqe,
+						struct ib_udata *udata);
+	int                        (*poll_cq)(struct ib_cq *cq, int num_entries,
+					      struct ib_wc *wc);
+	int                        (*peek_cq)(struct ib_cq *cq, int wc_cnt);
+	int                        (*req_notify_cq)(struct ib_cq *cq,
+						    enum ib_cq_notify_flags flags);
+	int                        (*req_ncomp_notif)(struct ib_cq *cq,
+						      int wc_cnt);
+	struct ib_mr *             (*get_dma_mr)(struct ib_pd *pd,
+						 int mr_access_flags);
+	struct ib_mr *             (*reg_user_mr)(struct ib_pd *pd,
+						  u64 start, u64 length,
+						  u64 virt_addr,
+						  int mr_access_flags,
+						  struct ib_udata *udata);
+	int			   (*rereg_user_mr)(struct ib_mr *mr,
+						    int flags,
+						    u64 start, u64 length,
+						    u64 virt_addr,
+						    int mr_access_flags,
+						    struct ib_pd *pd,
+						    struct ib_udata *udata);
+	int                        (*dereg_mr)(struct ib_mr *mr);
+	struct ib_mr *		   (*alloc_mr)(struct ib_pd *pd,
+					       enum ib_mr_type mr_type,
+					       u32 max_num_sg);
+	int                        (*map_mr_sg)(struct ib_mr *mr,
+						struct scatterlist *sg,
+						int sg_nents,
+						unsigned int *sg_offset);
+	struct ib_mw *             (*alloc_mw)(struct ib_pd *pd,
+					       enum ib_mw_type type,
+					       struct ib_udata *udata);
+	int                        (*dealloc_mw)(struct ib_mw *mw);
+	struct ib_fmr *	           (*alloc_fmr)(struct ib_pd *pd,
+						int mr_access_flags,
+						struct ib_fmr_attr *fmr_attr);
+	int		           (*map_phys_fmr)(struct ib_fmr *fmr,
+						   u64 *page_list, int list_len,
+						   u64 iova);
+	int		           (*unmap_fmr)(struct list_head *fmr_list);
+	int		           (*dealloc_fmr)(struct ib_fmr *fmr);
+	int                        (*attach_mcast)(struct ib_qp *qp,
+						   union ib_gid *gid,
+						   u16 lid);
+	int                        (*detach_mcast)(struct ib_qp *qp,
+						   union ib_gid *gid,
+						   u16 lid);
+	int                        (*process_mad)(struct ib_device *device,
+						  int process_mad_flags,
+						  u8 port_num,
+						  const struct ib_wc *in_wc,
+						  const struct ib_grh *in_grh,
+						  const struct ib_mad_hdr *in_mad,
+						  size_t in_mad_size,
+						  struct ib_mad_hdr *out_mad,
+						  size_t *out_mad_size,
+						  u16 *out_mad_pkey_index);
+	struct ib_xrcd *	   (*alloc_xrcd)(struct ib_device *device,
+						 struct ib_ucontext *ucontext,
+						 struct ib_udata *udata);
+	int			   (*dealloc_xrcd)(struct ib_xrcd *xrcd);
+	struct ib_flow *	   (*create_flow)(struct ib_qp *qp,
+						  struct ib_flow_attr
+						  *flow_attr,
+						  int domain,
+						  struct ib_udata *udata);
+	int			   (*destroy_flow)(struct ib_flow *flow_id);
+	int			   (*check_mr_status)(struct ib_mr *mr, u32 check_mask,
+						      struct ib_mr_status *mr_status);
+	void			   (*disassociate_ucontext)(struct ib_ucontext *ibcontext);
+	void			   (*drain_rq)(struct ib_qp *qp);
+	void			   (*drain_sq)(struct ib_qp *qp);
+	int			   (*set_vf_link_state)(struct ib_device *device, int vf, u8 port,
+							int state);
+	int			   (*get_vf_config)(struct ib_device *device, int vf, u8 port,
+						    struct ifla_vf_info *ivf);
+	int			   (*get_vf_stats)(struct ib_device *device, int vf, u8 port,
+						   struct ifla_vf_stats *stats);
+	int			   (*set_vf_guid)(struct ib_device *device, int vf, u8 port, u64 guid,
+						  int type);
+	struct ib_wq *		   (*create_wq)(struct ib_pd *pd,
+						struct ib_wq_init_attr *init_attr,
+						struct ib_udata *udata);
+	int			   (*destroy_wq)(struct ib_wq *wq);
+	int			   (*modify_wq)(struct ib_wq *wq,
+						struct ib_wq_attr *attr,
+						u32 wq_attr_mask,
+						struct ib_udata *udata);
+	struct ib_rwq_ind_table *  (*create_rwq_ind_table)(struct ib_device *device,
+							   struct ib_rwq_ind_table_init_attr *init_attr,
+							   struct ib_udata *udata);
+	int                        (*destroy_rwq_ind_table)(struct ib_rwq_ind_table *wq_ind_table);
+	struct ib_flow_action *	   (*create_flow_action_esp)(struct ib_device *device,
+							     const struct ib_flow_action_attrs_esp *attr,
+							     struct uverbs_attr_bundle *attrs);
+	int			   (*destroy_flow_action)(struct ib_flow_action *action);
+	int			   (*modify_flow_action_esp)(struct ib_flow_action *action,
+							     const struct ib_flow_action_attrs_esp *attr,
+							     struct uverbs_attr_bundle *attrs);
+	struct ib_dm *		   (*alloc_dm)(struct ib_device *device,
+					       struct ib_ucontext *context,
+					       struct ib_dm_alloc_attr *attr,
+					       struct uverbs_attr_bundle *attrs);
+	int			   (*dealloc_dm)(struct ib_dm *dm);
+	struct ib_mr *		   (*reg_dm_mr)(struct ib_pd *pd, struct ib_dm *dm,
+						struct ib_dm_mr_attr *attr,
+						struct uverbs_attr_bundle *attrs);
+	struct ib_counters *	   (*create_counters)(struct ib_device *device,
+						      struct uverbs_attr_bundle *attrs);
+	int			   (*destroy_counters)(struct ib_counters *counters);
+	int			   (*read_counters)(struct ib_counters *counters,
+						    struct ib_counters_read_attr *counters_read_attr,
+						    struct uverbs_attr_bundle *attrs);
+	struct rdma_hw_stats *	   (*alloc_hw_stats)(struct ib_device *device,
+						     u8 port_num);
+	int		           (*get_hw_stats)(struct ib_device *device,
+						   struct rdma_hw_stats *stats,
+						   u8 port, int index);
+};
+
 struct ib_device {
 	/* Do not access @dma_device directly from ULP nor from HW drivers. */
 	struct device                *dma_device;
 
+	struct ib_device_ops	     ops;
+
+
 	char                          name[IB_DEVICE_NAME_MAX];
 
 	struct list_head              event_handler_list;
@@ -2636,6 +2858,7 @@ void ib_unregister_client(struct ib_client *client);
 void *ib_get_client_data(struct ib_device *device, struct ib_client *client);
 void  ib_set_client_data(struct ib_device *device, struct ib_client *client,
 			 void *data);
+void ib_set_device_ops(struct ib_device *device, struct ib_device_ops *ops);
 
 #if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
-- 
2.14.4

