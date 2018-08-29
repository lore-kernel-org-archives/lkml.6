Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EB3C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A32A2089B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZBkrsy4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A32A2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeH2L3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:29:51 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:49809 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbeH2L3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:29:50 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180829073415epoutp0270b6d43f31923021bddcbea1dae880fe~PSqGYx0kd2038220382epoutp02R;
        Wed, 29 Aug 2018 07:34:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180829073415epoutp0270b6d43f31923021bddcbea1dae880fe~PSqGYx0kd2038220382epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1535528055;
        bh=635gP+BjM4++yjvdqcqmYP8uJcOtG/IYv9qbPYGXfhs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ZBkrsy4SS7gH5ZSbA9F9FmJdL6iuvOB+UdQOuC8o2cK/Krp1gEEx8FXOcT3OMxaJU
         ij6mHuFl76o+1BN0zUCo1yuYNA1B2jXeeheSh9QsSSeHxzATgWXkuNoCFyL+BWxVpU
         yRVX0QP40oLE885arqvxfZTQ2Lu3pBsxAG+xpHfM=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.155]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180829073412epcas1p2b9ee6d2746efaf17d0335d00540bc955~PSqDhk-O81614116141epcas1p2Z;
        Wed, 29 Aug 2018 07:34:12 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.74.04305.37C468B5; Wed, 29 Aug 2018 16:34:11 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180829073410epcas1p2f314e6c4c29eacfe3ebd5fb4f7f2f122~PSqBrp9f11984519845epcas1p2M;
        Wed, 29 Aug 2018 07:34:10 +0000 (GMT)
X-AuditID: b6c32a38-5adff700000010d1-42-5b864c734c9d
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.F5.03702.27C468B5; Wed, 29 Aug 2018 16:34:10 +0900 (KST)
Received: from localhost.localdomain ([10.113.63.77]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PE7004LGP0XW270@mmp1.samsung.com>; Wed, 29 Aug 2018
        16:34:10 +0900 (KST)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com
Cc:     rafael.j.wysocki@intel.com, chanwoo@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] PM / devfreq: Add new name attribute for sysfs
Date:   Wed, 29 Aug 2018 16:34:06 +0900
Message-id: <1535528046-18835-1-git-send-email-cw00.choi@samsung.com>
X-Mailer: git-send-email 1.8.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7bCmvm6xT1u0wa8GIYuJN66wWFz/8pzV
        4mzTG3aLy7vmsFl87j3CaHG7cQWbxeMVb9ktFmx8xOjA4bF4z0smj02rOtk8+rasYvT4vEku
        gCUq1SYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6Awl
        hbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1StKGhkZ6hgbmekRGQNo61MjIFKklIzZhxYStL
        QYNwxbFd0xkbGF/xdzFyckgImEicfbSNtYuRi0NIYAejxMT/LcwQzndGiZ+9d5lhqqasOABV
        tZtR4uv+d0xwVR/W7WIHqWIT0JLY/+IGG4gtIhAg0bl2FVgRs0Abo8Tz51MYQRLCAvYSP4/N
        AWrg4GARUJX41K0HEuYVcJW4cfkmE8Q2OYkPex6xg/RKCHxlldjy8jw7RMJF4uDxZkYIW1ji
        1fEtYHMkBKQlLh21hahvZ5T48qKZFcKZAHTdqc1QU40lni3sArOZBfgk3n3tYYVo5pXoaBOC
        KPGQ6FrfCFYiJBAr0XdsCjvQhAWMDKsYxVILinPTU4sNC0z0ihNzi0vz0vWS83M3MYKTg5bF
        DsY953wOMQpwMCrx8HIEt0YLsSaWFVfmHmKU4GBWEuENMmiLFuJNSaysSi3Kjy8qzUktPsRo
        CgyCicxSosn5wMSVVxJvaGpkbGxsYWJoZmpoqCTOa+QXHC0kkJ5YkpqdmlqQWgTTx8TBKdXA
        uHPxI83E0ti8V5u1s/jXmJXLLDFU/frv391J/isttjz4v3zPnwuTNkofMjJ5fML/sPDM8htr
        Ppr1tPNZpU/uKD7nsFH4luO7lMltJZd4i9PVuXWtuzJ//97z2f6ybqp718sVQjvDyiRCm7fZ
        Sr7qPSQ2oXdv27bDz7vDtOfHNLboJWy3quA4oMRSnJFoqMVcVJwIAIJFg2gkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCJMWRmVeSWpSXmKPExsVy+t9jAd0in7Zog0XvdSwm3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsFo9XvGW3WLDxEaMDh8fiPS+ZPDat6mTz6NuyitHj8ya5
        AJYoLpuU1JzMstQifbsErowZF7ayFDQIVxzbNZ2xgfEVfxcjJ4eEgInElBUHWLsYuTiEBHYy
        Sqy+soEdwvnOKNG79g8jSBWbgJbE/hc32EBsEQE/ie3z1zOCFDELtDBKLG7pBUsIC9hL/Dw2
        B6ibg4NFQFXiU7ceSJhXwFXixuWbTBDb5CQ+7HnEPoGRawEjwypGydSC4tz03GKjAsO81HK9
        4sTc4tK8dL3k/NxNjMCw2HZYq28H4/0l8YcYBTgYlXh4OYJbo4VYE8uKK3MPMUpwMCuJ8AYZ
        tEUL8aYkVlalFuXHF5XmpBYfYpTmYFES572ddyxSSCA9sSQ1OzW1ILUIJsvEwSnVwBi1YPOR
        lcE/olnKDG7fyDHi32r1Wo9/fsvke4wmxyL/Z67VtvE93ClrnmD99bZQhM2SfJX15w5eN5Gq
        Vs9+U6bbcGeFYl32Nx2n0xelbu0xjt5et4o7exF/sfeK6i/tS5MCbF6UMi66sPLmP7Oq2yuv
        T7yVqZl9beX1y3Yz9/75bL/7d5x/lJwSS3FGoqEWc1FxIgBzsRRkBwIAAA==
X-CMS-MailID: 20180829073410epcas1p2f314e6c4c29eacfe3ebd5fb4f7f2f122
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180829073410epcas1p2f314e6c4c29eacfe3ebd5fb4f7f2f122
References: <CGME20180829073410epcas1p2f314e6c4c29eacfe3ebd5fb4f7f2f122@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4585fbcb5331 ("PM / devfreq: Modify the device name as devfreq(X) for
sysfs") changed the node name to devfreq(x). After this commit, it is not
possible to get the device name through /sys/class/devfreq/devfreq(X)/*.

Add new name attribute in order to get device name.

Cc: stable@vger.kernel.org
Fixes: 4585fbcb5331 ("PM / devfreq: Modify the device name as devfreq(X) for sysfs")
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 11 +++++++++++
 include/linux/devfreq.h   |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 4c49bb1330b5..2145563d5ee5 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -620,6 +620,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 	devfreq->max_freq = devfreq->scaling_max_freq;

+	devfreq->name = dev_name(devfreq->dev.parent);
+	if (IS_ERR_OR_NULL(devfreq->name))
+		return -EINVAL;
 	dev_set_name(&devfreq->dev, "devfreq%d",
 				atomic_inc_return(&devfreq_no));
 	err = device_register(&devfreq->dev);
@@ -1261,6 +1264,13 @@ static ssize_t trans_stat_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(trans_stat);

+static ssize_t name_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s\n", to_devfreq(dev)->name);
+}
+static DEVICE_ATTR_RO(name);
+
 static struct attribute *devfreq_attrs[] = {
 	&dev_attr_governor.attr,
 	&dev_attr_available_governors.attr,
@@ -1271,6 +1281,7 @@ static ssize_t trans_stat_show(struct device *dev,
 	&dev_attr_min_freq.attr,
 	&dev_attr_max_freq.attr,
 	&dev_attr_trans_stat.attr,
+	&dev_attr_name.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(devfreq);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 3aae5b3af87c..f79b5a666102 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -111,6 +111,7 @@ struct devfreq_dev_profile {

 /**
  * struct devfreq - Device devfreq structure
+ * @name:	name of the device
  * @node:	list node - contains the devices with devfreq that have been
  *		registered.
  * @lock:	a mutex to protect accessing devfreq.
@@ -146,6 +147,8 @@ struct devfreq_dev_profile {
  * to protect its own private data in void *data as well.
  */
 struct devfreq {
+	const char *name;
+
 	struct list_head node;

 	struct mutex lock;
--
1.9.1

