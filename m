Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4101065-1525230237-2-8809251732435211174
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525230236; b=aLvdod8UzBG23drYLOHlpaB2Pt/Guvgro7gGxFiZejptFt9Nk8
    9chetDZHnTRC50371HBoNpQfE7XJrVYGwtkDaNTHSDJJH+qyAUkTwrH+KKck/8MY
    F++WZB2LQDzKKkiKIOv/vwiHahxHZ3eelJNXxoWa1lYyAI/+5afDyTvdSrp1KTzA
    dgv2ZrBU44EAwlY+NrqI5f7lEqNB80Z7dbTfFjlMFKiM8MTSsK2RVwMdhu+7RHsw
    GhJLNNcxa/1lf5ddeiWtm5y31V9rpzS60KmnOcDj3453Gn8V1tcDlEgIMSIB7CJO
    9re8nU4JkQjnvZ3UNo9MeK0fy6bw3M08FeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230236; bh=
    xwwkTQp9HvFKdoFrCN37l9vWV505tmhfOj2IIXfgy6o=; b=FGn+WcmEwoWn7w9m
    ha5pQCs0G/QMeSTzemnOlV1t2FV5PwBvloDHRzpRblOrFvvhyUa7mNbn/vV7KIKV
    rNWP1EBeMlDON3PweFgP6cz+mff7ax0LrzCWBG9nNRnT5jjYuJIIUFG66i+m8xIr
    i/Eby+Knzfsxc7NvZeJdQ+p9l7iRNwhitDNI+vdNpfWENZTFU1CZ7CrhDz4QtA/Y
    +eqtoJ97toxfPDCWla18hYPa6JkKz8/UeuR9Kssz4ZvRpc88/OZHNp34ESo31HkI
    0fOXvtdIZFniSjuLWGu2brjSA8VYMlES9qLBYA0N71Flyo9r9wYeIZRqzG1W3tho
    7z8NGg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFAN197hcI7aswvXylFWDmlpzqtSMcwnU8teki27ku+hpT5EE76TlnV1PS+TLECK/micR9BgJWhRBelU5LEjWHxSDsoR44BzWS+7EC1Ag0X7QjA5kf5f
    9c2XDAI/7KtPiZwrNwuw5Z1b1NkuCG/UVY094u5ok9Kh7R/YXRPCvpdIWqwoh+uOJp9PRm/UTyLhIXCQXcqD7j4ib+lXeviA/rSejsvLtHMSKqo2chGazPe+
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=EVljZpUPVAt7uyRfC8AA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbeEBDDy (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:03:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:63852 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751645AbeEBDCv (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:02:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058632"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: [PATCH v5 26/28] fpga: dfl: afu: add DFL_FPGA_GET_API_VERSION/CHECK_EXTENSION ioctls support
Date: Wed,  2 May 2018 10:50:29 +0800
Message-Id: <1525229431-3087-27-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DFL_FPGA_GET_API_VERSION and DFL_FPGA_CHECK_EXTENSION ioctls are common
ones which need to be supported by all feature devices drivers including
FME and AFU. This patch implements above 2 ioctls in FPGA Accelerated
Function Unit (AFU) driver.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v2: rebased
v3: rebased as driver renamed to fpga-dfl-afu
    fix one checkpatch issue
v4: add Acked-by from Alan and Moritz.
v5: rebase, and add DFL_ prefix to APIs.
---
 drivers/fpga/dfl-afu-main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 6f846b7..57bb726 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -236,6 +236,13 @@ static int afu_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static long afu_ioctl_check_extension(struct dfl_feature_platform_data *pdata,
+				      unsigned long arg)
+{
+	/* No extension support for now */
+	return 0;
+}
+
 static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct platform_device *pdev = filp->private_data;
@@ -248,6 +255,10 @@ static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	pdata = dev_get_platdata(&pdev->dev);
 
 	switch (cmd) {
+	case DFL_FPGA_GET_API_VERSION:
+		return DFL_FPGA_API_VERSION;
+	case DFL_FPGA_CHECK_EXTENSION:
+		return afu_ioctl_check_extension(pdata, arg);
 	default:
 		/*
 		 * Let sub-feature's ioctl function to handle the cmd
-- 
1.8.3.1

