Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4163049-1525230544-3-18288359883900703331
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
    1525230544; b=mQLTx3fvWkOWQY6MLRQcJohu+/aWYBkLRDgTUWTTvpPg3DP8QL
    HwNUaF0zGSuv28VioBUoLLxL95zUY3Wpamus/ZcRHUW4zPdTUbe4o4NLeczjmGlj
    Xyioocb9JQtnLUJvlP/0ubi+Bk5SgZMnIf5yh82G39MmRAf9xNffmKuSPZevdCQr
    lWvyJGwZj6GWEt6LTLLPrPFeQc2230R3cjDT1KIRHY970oYIF+tsIq50ROgf2nq+
    yPOH7PIq3+2xBO9TB5hH8m/8aWX7ea5hMF8eQqC4wGlbsck+2ptY1XaeWOLac+UE
    SdAAIShBYfPMuEmLsi0EoVHskh7Z/da4zhOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230544; bh=
    QDWR9/DTrF1SoOqCPb8pC95+4MYgNOxTXFGwJCZ607s=; b=bqj09erTKiS68WOj
    GgJkLktb92VHTunooACliuloLW3J6npyM8z/T9fXb6VN7/QG6RyGo+nNtb3xLsyo
    iIVYZXfbbQ5LFKWcMRT2UbgmerqniNQQxt9nQiAHioBtT9OkR6p341Qp6UYHQCZI
    Q+w4JHDTHBd8q/8+D1Lk4aTIks5Nbu6E0e8TVdvLE2KT+LrdFCjwpXpzEspxwvVq
    SltHshsQgoYWxOiIN/XfMMqXjgijSRMnJls5vasGymJPdSobjhKM7hW9EtXNwZ66
    R72pyL9jgwQHSv80eIAeBn9/qO1aTMr51r0z/p2kGWb9hw4QDF0gJkDB/SU7F8+g
    bt7bsg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO+KtuErjW5MI3c7+zZLXyY1gFNYJx4xrsbbX2IhngDQ96vkUhSNN8vOw0DYHI7YKHPkaKequYYV+GbYmK4qO0YnvyxX+/tJt4K+dFzbqA6Jo6FODhsT
    VhKQQrIAHX76p9DdRS+Y8UuHzcZU/EiZ9mhvZhgOCMBGbcOUliyqU08lMUI86Ifo8QlXHlQUDgBsHNSvACXtqyGMWdx1o/Qj8Esw1q9KMSJ60q7aKMeW6MMa
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=UFHwFH4Q79-SC2nR084A:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbeEBDJB (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:09:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:63823 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbeEBDBu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:01:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058244"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v5 04/28] fpga: mgr: add compat_id support
Date: Wed,  2 May 2018 10:50:07 +0800
Message-Id: <1525229431-3087-5-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch introduces compat_id support to fpga manager, it adds
a fpga_compat_id pointer to fpga manager data structure to allow
fpga manager drivers to save the compatibility id. This compat_id
could be used for compatibility checking before doing partial
reconfiguration to associated fpga regions.

Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 include/linux/fpga/fpga-mgr.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 802eac8..f163f22 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -147,11 +147,23 @@ struct fpga_manager_ops {
 #define FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR	BIT(4)
 
 /**
+ * struct fpga_compat_id - id for compatibility check
+ *
+ * @id_h: high 64bit of the compat_id
+ * @id_l: low 64bit of the compat_id
+ */
+struct fpga_compat_id {
+	u64 id_h;
+	u64 id_l;
+};
+
+/**
  * struct fpga_manager - fpga manager structure
  * @name: name of low level fpga manager
  * @dev: fpga manager device
  * @ref_mutex: only allows one reference to fpga manager
  * @state: state of fpga manager
+ * @compat_id: FPGA manager id for compatibility check.
  * @mops: pointer to struct of fpga manager ops
  * @priv: low level driver private date
  */
@@ -160,6 +172,7 @@ struct fpga_manager {
 	struct device dev;
 	struct mutex ref_mutex;
 	enum fpga_mgr_states state;
+	struct fpga_compat_id *compat_id;
 	const struct fpga_manager_ops *mops;
 	void *priv;
 };
-- 
1.8.3.1

