Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161F2C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE262083D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GVlpTrUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE262083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754129AbeFTBMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 21:12:39 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:54564 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754059AbeFTBM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 21:12:28 -0400
Received: by mail-qt0-f202.google.com with SMTP id d7-v6so1357665qth.21
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 18:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=HlTc28E61d65R5d0sZkjpqMVdo5h7toibfzgBcFrCFM=;
        b=GVlpTrUY7EtkAykVRfkw8+KjsXLvPk6AqW7IfZIJ95v+rOgr8yRY0zVW3N3vfH27o4
         C65luU18doATp9aPqiLpJi7rCzTgRwx85/wXAtKcVfaxZOAFREbTW0BRWsTsy518e8KQ
         DLn0velDCNShOvWMtrA3IAqIGlP6lneUNFJlkVHV3aP3MbJT55XB3slb8oq5olejpD1J
         G4AdZbAlSNQldYjZcAyJhsBpLZW/jlSF3sPjt4YMKDNVwj7ejBAR+OWC4/rdTvP5pKWT
         w0hZQKmipf9in+MyggXzNt8HCDsJ5+9Po3yqptQ6eXABHelZSxYBVqbmkmDRUGS3xXir
         euXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=HlTc28E61d65R5d0sZkjpqMVdo5h7toibfzgBcFrCFM=;
        b=I81tUetwww6NIFfICKq/Z+J74kfmqOzq8p4mWetTNsJVNlw+6qhY/MkPAYMcZ4PYfz
         G0uV212q0/RLNFy83pcqwmcz0fW2f+4VDem59rlQCAzr5LgayQGzrOA+Sip6xyloG8jM
         eVgfFoUv2QqLk1QRvlb+msOmyN0lDJTAVg6pZCm1itbpX6gksJ2azloU6GOrhgLNWBCI
         nmqaCO6aBB5igW7/WiiAOPj3tTtEalGuLkMRnlD/rk5Ji07/BCRPKbtq6La/d/b0nFRE
         0OP2paN0Kdt3anLwsq1j91vTqzUf/lPxcoCgBBv4tFk69dtHdVpx0jheI5vr1bQ5iWzq
         IlIw==
X-Gm-Message-State: APt69E2M3vDNONw0500PSpq5KIZR2TIK1+6AxctEHnX/Rr+US6MHEEZJ
        cxdAQB4Vi5oQMtqBeE7cT6h/n3SbTI+/
X-Google-Smtp-Source: ADUXVKJExyd0FLCeGrFTVI6nhdfUHX51gCgqVlGm7eFskB1aZ0pHMjB2ajCVF2OsZd29o1Hj6sPT5GmkF9Sw
MIME-Version: 1.0
X-Received: by 2002:a0c:8a9d:: with SMTP id 29-v6mr10672638qvv.29.1529457148082;
 Tue, 19 Jun 2018 18:12:28 -0700 (PDT)
Date:   Tue, 19 Jun 2018 18:12:09 -0700
In-Reply-To: <20180620011210.254601-1-rajatja@google.com>
Message-Id: <20180620011210.254601-4-rajatja@google.com>
References: <20180619221651.GH33049@bhelgaas-glaptop.roam.corp.google.com> <20180620011210.254601-1-rajatja@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v3 4/5] PCI/AER: Add sysfs attributes for rootport cumulative stats
From:   Rajat Jain <rajatja@google.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com,
        helgaas@kernel.org
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysfs attributes for rootport statistics (that are cumulative
of all the ERR_* messages seen on this PCI hierarchy).

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v3: Merge everything in aer.c, use "%llu" in place of "%llx"

 drivers/pci/pcie/aer.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 876f03799810..b6d0a0b56d65 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -586,6 +586,9 @@ static DEVICE_ATTR_RO(field)
 aer_stats_aggregate_attr(dev_total_cor_errs);
 aer_stats_aggregate_attr(dev_total_fatal_errs);
 aer_stats_aggregate_attr(dev_total_nonfatal_errs);
+aer_stats_aggregate_attr(rootport_total_cor_errs);
+aer_stats_aggregate_attr(rootport_total_fatal_errs);
+aer_stats_aggregate_attr(rootport_total_nonfatal_errs);
 
 #define aer_stats_breakdown_attr(field, stats_array, strings_array)	\
 	static ssize_t							\
@@ -598,10 +601,10 @@ aer_stats_aggregate_attr(dev_total_nonfatal_errs);
 	u64 *stats = pdev->aer_stats->stats_array;			\
 	for (i = 0; i < ARRAY_SIZE(strings_array); i++) {		\
 		if (strings_array[i])					\
-			str += sprintf(str, "%s = 0x%llx\n",		\
+			str += sprintf(str, "%s = %llu\n",		\
 				       strings_array[i], stats[i]);	\
 		else if (stats[i])					\
-			str += sprintf(str, #stats_array "bit[%d] = 0x%llx\n",\
+			str += sprintf(str, #stats_array "bit[%d] = %llu\n",\
 				       i, stats[i]);			\
 	}								\
 	return str-buf;							\
@@ -619,6 +622,9 @@ static struct attribute *aer_stats_attrs[] __ro_after_init = {
 	&dev_attr_dev_total_nonfatal_errs.attr,
 	&dev_attr_dev_breakdown_correctable.attr,
 	&dev_attr_dev_breakdown_uncorrectable.attr,
+	&dev_attr_rootport_total_cor_errs.attr,
+	&dev_attr_rootport_total_fatal_errs.attr,
+	&dev_attr_rootport_total_nonfatal_errs.attr,
 	NULL
 };
 
@@ -631,6 +637,12 @@ static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
 	if (!pdev->aer_stats)
 		return 0;
 
+	if ((a == &dev_attr_rootport_total_cor_errs.attr ||
+	     a == &dev_attr_rootport_total_fatal_errs.attr ||
+	     a == &dev_attr_rootport_total_nonfatal_errs.attr) &&
+	    pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
+		return 0;
+
 	return a->mode;
 }
 
@@ -674,6 +686,25 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
 			counter[i]++;
 }
 
+void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
+				 struct aer_err_source *e_src)
+{
+	struct aer_stats *aer_stats = pdev->aer_stats;
+
+	if (!aer_stats)
+		return;
+
+	if (e_src->status & PCI_ERR_ROOT_COR_RCV)
+		aer_stats->rootport_total_cor_errs++;
+
+	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
+		if (e_src->status & PCI_ERR_ROOT_FATAL_RCV)
+			aer_stats->rootport_total_fatal_errs++;
+		else
+			aer_stats->rootport_total_nonfatal_errs++;
+	}
+}
+
 static void __print_tlp_header(struct pci_dev *dev,
 			       struct aer_header_log_regs *t)
 {
@@ -1124,6 +1155,8 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 	struct pci_dev *pdev = rpc->rpd;
 	struct aer_err_info *e_info = &rpc->e_info;
 
+	pci_rootport_aer_stats_incr(pdev, e_src);
+
 	/*
 	 * There is a possibility that both correctable error and
 	 * uncorrectable error being logged. Report correctable error first.
-- 
2.18.0.rc1.244.gcf134e6275-goog

