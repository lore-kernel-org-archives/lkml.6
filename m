Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7DDC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E2A2083D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xz5SW4jo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E2A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754190AbeFTBNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 21:13:10 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:46422 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753917AbeFTBMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 21:12:25 -0400
Received: by mail-ua0-f201.google.com with SMTP id m1-v6so509183uao.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 18:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=3Y+QluKJwrqjzjy8KY30yUXxcpwjF/AHZBdPidFilXs=;
        b=Xz5SW4joaesf7pBEyzVH/YP4nCqavwPvyLywEK/aCntTgxLyVyPjT+xCWxIoxhsLA+
         HPzVndo30GImyXLbqBCmtLK8sO3NDO7lJOrI+UT+hMuuMuKKZVT66yOZPXvdkSOsolc2
         vpixwsEy1T0ipVpf+JJOYap6Ag+QZzAlf7OLMHT14HKbYIp76nOPau1d6xLY373EcqwB
         lOCs77Lr2JoFt/S9IQ/pnyPOf94YdJmhUVR0OdUZOJOBv1UYXURtiyzHBYodx7g9xJHJ
         xChd42wqzxaUszOx/16/6sjVeIP+KltMbxfdAcvl88ODaLKu84jKdaLCEzOH9rPHKG7r
         +r+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=3Y+QluKJwrqjzjy8KY30yUXxcpwjF/AHZBdPidFilXs=;
        b=Ostya0y3vCZ8y9fAXFKM9PyXY0Wx2Pt8EoXp2htad5daBNfzf1qVE7NDtxAzjTwjQ0
         AVYeqbr2tVXeA92e+86NCI94k7EXwWquuTdfSw0qDVx76mG1r/12AU+VGfF06BeL/gKR
         IH7TptD0RaFzJtVrCs8KOYtte2/krc+rECKrzbLv547tMpmd9tpeie8l7A+wTSvw8xMR
         196T2fWCDwfALFtB2fVptIqJh4ON2/gdBCZ3mxw5NQG5uUv86eMNGAhEIECe9d2xE4K4
         tkjes03hiPfRgn0OyzqyOQrc4E3kMVFqQ/aHrMQ5QqpITXvHYs0zPAUxV+dN6vhdLxAV
         K7dw==
X-Gm-Message-State: APt69E2aJQNpClRQuwoAA4HTx1zGO+ZV+3i8rlJjar+6e49llEPQZFDF
        /a+g+KqFqUpxF3RplF1qGu7umohc9RES
X-Google-Smtp-Source: ADUXVKJp5SzZsDSEnCjKx04NWG0HrK86s+Go7SZxaj4r1ed+jutdar4xXWwzk2T5p5udOip69b21A6Hofo0E
MIME-Version: 1.0
X-Received: by 2002:a9f:21b4:: with SMTP id 49-v6mr8325832uac.16.1529457144592;
 Tue, 19 Jun 2018 18:12:24 -0700 (PDT)
Date:   Tue, 19 Jun 2018 18:12:08 -0700
In-Reply-To: <20180620011210.254601-1-rajatja@google.com>
Message-Id: <20180620011210.254601-3-rajatja@google.com>
References: <20180619221651.GH33049@bhelgaas-glaptop.roam.corp.google.com> <20180620011210.254601-1-rajatja@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v3 3/5] PCI/AER: Add sysfs attributes to provide breakdown of AERs
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
Cc:     Rajat Jain <rajatja@google.com>, Rajat Jain <rajatj@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysfs attributes to provide breakdown of the AERs seen,
into different type of correctable or uncorrectable errors:

dev_breakdown_correctable
dev_breakdown_uncorrectable

Signed-off-by: Rajat Jain <rajatj@google.com>
---
v3: Merge everything in aer.c, use "%llu" in place of "%llx"

 drivers/pci/pcie/aer.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ce0d675d7bd3..876f03799810 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -587,10 +587,38 @@ aer_stats_aggregate_attr(dev_total_cor_errs);
 aer_stats_aggregate_attr(dev_total_fatal_errs);
 aer_stats_aggregate_attr(dev_total_nonfatal_errs);
 
+#define aer_stats_breakdown_attr(field, stats_array, strings_array)	\
+	static ssize_t							\
+	field##_show(struct device *dev, struct device_attribute *attr,	\
+		     char *buf)						\
+{									\
+	unsigned int i;							\
+	char *str = buf;						\
+	struct pci_dev *pdev = to_pci_dev(dev);				\
+	u64 *stats = pdev->aer_stats->stats_array;			\
+	for (i = 0; i < ARRAY_SIZE(strings_array); i++) {		\
+		if (strings_array[i])					\
+			str += sprintf(str, "%s = 0x%llx\n",		\
+				       strings_array[i], stats[i]);	\
+		else if (stats[i])					\
+			str += sprintf(str, #stats_array "bit[%d] = 0x%llx\n",\
+				       i, stats[i]);			\
+	}								\
+	return str-buf;							\
+}									\
+static DEVICE_ATTR_RO(field)
+
+aer_stats_breakdown_attr(dev_breakdown_correctable, dev_cor_errs,
+			 aer_correctable_error_string);
+aer_stats_breakdown_attr(dev_breakdown_uncorrectable, dev_uncor_errs,
+			 aer_uncorrectable_error_string);
+
 static struct attribute *aer_stats_attrs[] __ro_after_init = {
 	&dev_attr_dev_total_cor_errs.attr,
 	&dev_attr_dev_total_fatal_errs.attr,
 	&dev_attr_dev_total_nonfatal_errs.attr,
+	&dev_attr_dev_breakdown_correctable.attr,
+	&dev_attr_dev_breakdown_uncorrectable.attr,
 	NULL
 };
 
-- 
2.18.0.rc1.244.gcf134e6275-goog

