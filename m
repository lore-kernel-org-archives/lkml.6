Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BF3C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4918620685
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryhQdEbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4918620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbeHAMJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:09:49 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34898 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733104AbeHAMJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:09:48 -0400
Received: by mail-qt0-f196.google.com with SMTP id a5-v6so19240092qtp.2;
        Wed, 01 Aug 2018 03:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=piwRiBrlXnGjrvilcFSkQAwmzN80l4dk6ZkRgbRdEXE=;
        b=ryhQdEbhn3OBX1bGc1+A7FEP4jobhcI4GqStUvd2POmPR49xBpRhXu0DGmCz1hT1JX
         1A9RISpbNRWFLoj8HS1ac1aS5/UTqjbKN7qdgGdZ6WoNnlfAt9MWx2ARZ6NEybX7B8j1
         VJ3ylqNVvnVRNrytoHiZO+AIj3Q3PvLpMAlflGNTM6+eK+rEmC2wD8zjIcr6BFrOx6xS
         RdB5burYwgKAQdstIY2ctrY3X14MBpY0eNkYibwVRHUoe4iV3juhSZ+ema8vRxjJ9ENZ
         PLF9fcf+Ua2aSKycT8OvvwriEucSu8LkbgyCSDyVf+XNyfIEo/JJxitq8jX2dzvgx/IO
         Sc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=piwRiBrlXnGjrvilcFSkQAwmzN80l4dk6ZkRgbRdEXE=;
        b=E6XAu+PtKDjR3EYkz3kZfMthCRPBRs9tBBKWuBBFn2C6ekLpzrnUP0suTmcBteGmux
         ygLTnCAaY5dLSR0+zRdJgV4BJ7GDQhTIhbTE8yFHNndMmwyvquYN98N0MVL0f/jhq0c5
         JZf8sZncIoTGsWqsQtOznjWp/xZo77lZEvsEAYi0gzp9cIHPR8Oz1mH29bHjN8nek+Nj
         P50YXb5pgU/Ceo+yUmRVIp0t8zXjVmZjpOPPD73fXHSOn7dJX/LjRzg/aApMq5Eo8bbr
         EVMGmru9gCR6FQCZHMiRMN5EbU1XzLVKE/cJTCJF7qO17RmH2LgHdTV581U7YhudA0Wh
         1CPw==
X-Gm-Message-State: AOUpUlGrm8+IdFhdR7jjjdMzBUNtNlMIfmkIsbdJQSQ3CE2M0Q/JIwHW
        3N54PtDuw3mB0bfQw3iKeOg=
X-Google-Smtp-Source: AAOMgpceEejsnzlsfUmGPpAYmLweVr65M1gm95cFjmnrx/8OV3rU1COTG7fisighCmMb7wNnZCQQMw==
X-Received: by 2002:a0c:81ae:: with SMTP id 43-v6mr22885424qvd.129.1533119082140;
        Wed, 01 Aug 2018 03:24:42 -0700 (PDT)
Received: from localhost.localdomain ([104.237.86.144])
        by smtp.gmail.com with ESMTPSA id s19-v6sm11176890qtj.61.2018.08.01.03.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 03:24:41 -0700 (PDT)
From:   Kenneth Lee <nek.in.cn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Hao Fang <fanghao11@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Cc:     linuxarm@huawei.com
Subject: [RFC PATCH 6/7] crypto: add spimdev support to Hisilicon QM
Date:   Wed,  1 Aug 2018 18:22:20 +0800
Message-Id: <20180801102221.5308-7-nek.in.cn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801102221.5308-1-nek.in.cn@gmail.com>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kenneth Lee <liguozhu@hisilicon.com>

The commit add spimdev support to the Hislicon QM driver, any
accelerator that use QM can share its queues to the user space.

Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Hao Fang <fanghao11@huawei.com>
Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 150 ++++++++++++++++++++++++++++++++++
 drivers/crypto/hisilicon/qm.h |  12 +++
 2 files changed, 162 insertions(+)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index e779bc661500..06da8387dc58 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -667,6 +667,146 @@ int hisi_qp_send(struct hisi_qp *qp, void *msg)
 }
 EXPORT_SYMBOL_GPL(hisi_qp_send);
 
+#ifdef CONFIG_CRYPTO_DEV_HISI_SPIMDEV
+/* mdev->supported_type_groups */
+static struct attribute *hisi_qm_type_attrs[] = {
+	VFIO_SPIMDEV_DEFAULT_MDEV_TYPE_ATTRS,
+	NULL,
+};
+static struct attribute_group hisi_qm_type_group = {
+	.attrs = hisi_qm_type_attrs,
+};
+static struct attribute_group *mdev_type_groups[] = {
+	&hisi_qm_type_group,
+	NULL,
+};
+
+static void qm_qp_event_notifier(struct hisi_qp *qp)
+{
+	vfio_spimdev_wake_up(qp->spimdev_q);
+}
+
+static int hisi_qm_get_queue(struct vfio_spimdev *spimdev, unsigned long arg,
+			  struct vfio_spimdev_queue **q)
+{
+	struct qm_info *qm = spimdev->priv;
+	struct hisi_qp *qp = NULL;
+	struct vfio_spimdev_queue *wd_q;
+	u8 alg_type = 0; /* fix me here */
+	int ret;
+	int pasid = arg;
+
+	qp = hisi_qm_create_qp(qm, alg_type);
+	if (IS_ERR(qp))
+		return PTR_ERR(qp);
+
+	wd_q = kzalloc(sizeof(struct vfio_spimdev_queue), GFP_KERNEL);
+	if (!wd_q) {
+		ret = -ENOMEM;
+		goto err_with_qp;
+	}
+
+	wd_q->priv = qp;
+	wd_q->spimdev = spimdev;
+	wd_q->qid = (u16)ret;
+	*q = wd_q;
+	qp->spimdev_q = wd_q;
+	qp->event_cb = qm_qp_event_notifier;
+
+	ret = hisi_qm_start_qp(qp, arg);
+	if (ret < 0)
+		goto err_with_wd_q;
+
+	return ret;
+
+err_with_wd_q:
+	kfree(wd_q);
+err_with_qp:
+	hisi_qm_release_qp(qp);
+	return ret;
+}
+
+static int hisi_qm_put_queue(struct vfio_spimdev_queue *q)
+{
+	struct hisi_qp *qp = q->priv;
+
+	/* need to stop hardware, but can not support in v1 */
+	hisi_qm_release_qp(qp);
+	kfree(q);
+	return 0;
+}
+
+/* map sq/cq/doorbell to user space */
+static int hisi_qm_mmap(struct vfio_spimdev_queue *q,
+			struct vm_area_struct *vma)
+{
+	struct hisi_qp *qp = (struct hisi_qp *)q->priv;
+	struct qm_info *qm = qp->qm;
+	struct device *dev = &qm->pdev->dev;
+	size_t sz = vma->vm_end - vma->vm_start;
+	u8 region;
+
+	vma->vm_flags |= (VM_IO | VM_LOCKED | VM_DONTEXPAND | VM_DONTDUMP);
+	region = _VFIO_SPIMDEV_REGION(vma->vm_pgoff);
+
+	switch (region) {
+	case 0:
+		if (sz > PAGE_SIZE)
+			return -EINVAL;
+		/*
+		 * Warning: This is not safe as multiple queues use the same
+		 * doorbell, v1 hardware interface problem. v2 will fix it
+		 */
+		return remap_pfn_range(vma, vma->vm_start,
+				       qm->phys_base >> PAGE_SHIFT,
+				       sz, pgprot_noncached(vma->vm_page_prot));
+	case 1:
+		vma->vm_pgoff = 0;
+		if (sz > qp->scqe.size)
+			return -EINVAL;
+
+		return dma_mmap_coherent(dev, vma, qp->scqe.addr, qp->scqe.dma,
+				sz);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct vfio_spimdev_ops qm_ops = {
+	.get_queue = hisi_qm_get_queue,
+	.put_queue = hisi_qm_put_queue,
+	.mmap = hisi_qm_mmap,
+};
+
+static int qm_register_spimdev(struct qm_info *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	struct vfio_spimdev *spimdev = &qm->spimdev;
+
+	spimdev->iommu_type = VFIO_TYPE1_IOMMU;
+#ifdef CONFIG_IOMMU_SVA
+	spimdev->dma_flag = VFIO_SPIMDEV_DMA_MULTI_PROC_MAP;
+#else
+	spimdev->dma_flag = VFIO_SPIMDEV_DMA_SINGLE_PROC_MAP;
+#endif
+	spimdev->owner = THIS_MODULE;
+	spimdev->name = qm->dev_name;
+	spimdev->dev = &pdev->dev;
+	spimdev->is_vf = pdev->is_virtfn;
+	spimdev->priv = qm;
+	spimdev->api_ver = "hisi_qm_v1";
+	spimdev->flags = 0;
+
+	spimdev->mdev_fops.mdev_attr_groups = qm->mdev_dev_groups;
+	hisi_qm_type_group.name = qm->dev_name;
+	spimdev->mdev_fops.supported_type_groups = mdev_type_groups;
+	spimdev->ops = &qm_ops;
+
+	return vfio_spimdev_register(spimdev);
+}
+#endif
+
 int hisi_qm_init(const char *dev_name, struct qm_info *qm)
 {
 	int ret;
@@ -804,6 +944,12 @@ int hisi_qm_start(struct qm_info *qm)
 	if (ret)
 		goto err_with_cqc;
 
+#ifdef CONFIG_CRYPTO_DEV_HISI_SPIMDEV
+	ret = qm_register_spimdev(qm);
+	if (ret)
+		goto err_with_irq;
+#endif
+
 	writel(0x0, QM_ADDR(qm, QM_VF_EQ_INT_MASK));
 
 	return 0;
@@ -830,6 +976,10 @@ void hisi_qm_stop(struct qm_info *qm)
 	struct pci_dev *pdev = qm->pdev;
 	struct device *dev = &pdev->dev;
 
+#ifdef CONFIG_CRYPTO_DEV_HISI_SPIMDEV
+	vfio_spimdev_unregister(&qm->spimdev);
+#endif
+
 	free_irq(pci_irq_vector(pdev, 0), qm);
 	qm_uninit_q_buffer(dev, &qm->cqc);
 	kfree(qm->qp_array);
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index b3c5c34a0d13..f73c08098b82 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -8,6 +8,10 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 
+#ifdef CONFIG_CRYPTO_DEV_HISI_SPIMDEV
+#include <linux/vfio_spimdev.h>
+#endif
+
 #define QM_CQE_SIZE			16
 /* default queue depth for sq/cq/eq */
 #define QM_Q_DEPTH			1024
@@ -59,6 +63,10 @@ struct qm_info {
 
 	struct hisi_acc_qm_hw_ops *ops;
 
+#ifdef CONFIG_CRYPTO_DEV_HISI_SPIMDEV
+	struct vfio_spimdev spimdev;
+	const struct attribute_group **mdev_dev_groups;
+#endif
 };
 #define QM_ADDR(qm, off) ((qm)->io_base + off)
 
@@ -90,6 +98,10 @@ struct hisi_qp {
 
 	struct qm_info *qm;
 
+#ifdef CONFIG_CRYPTO_DEV_HISI_SPIMDEV
+	struct vfio_spimdev_queue *spimdev_q;
+#endif
+
 	/* for crypto sync API */
 	struct completion completion;
 
-- 
2.17.1

