Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F64C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEAF22562
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ff0QMO8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEAF22562
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933991AbeFUXtE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:49:04 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:34124 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933916AbeFUXtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:49:00 -0400
Received: by mail-yw0-f202.google.com with SMTP id w7-v6so3053734ywf.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 16:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Nq37HysZ1vvXx0wFP/o0OSN07VjaNCQuf71xUDLtiLo=;
        b=ff0QMO8VshjtlIg6g1BifJFMh6beEoafJUW+gzrMTz87wBWVYTHMl4ygH80aORMw6a
         TvBjW3CXtpcgnoKIg7toXX0IJh67eczvwzpoiggSWgryCkmOKSv/00GOzFcV6b9UXtZs
         14LsPG20b8HOvp88V0LQz5f3ev742VLmbwNtpdVDmXmRKpTP0mJO9503wer/kpDGMkLA
         qBfPWFVSvuFmX5pXnF8eNM3+L0NkFO8TjBTqk5XKzBbMgOmAoU+PhChD5QU2MBLLPx0+
         si18G1XcFFJYornZ/rWqYwYh8ITfZ6grjIdZb8T7ajnT1DEBSpT/khNvjRA/fLj6v14C
         oLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Nq37HysZ1vvXx0wFP/o0OSN07VjaNCQuf71xUDLtiLo=;
        b=WiYG9HFmUKhr0MnjMehW5zcOo9jL2r5u1mDAjMuGUZ11jTavWSQ7zPSPGOTZtWyJAb
         PA+PiyfWndbwXdWZQd40EEoRuDYCdpGsbxB0UgXAd98h3dkuZcwKbx+eHYxVP5unZYL4
         8ZCzgnEBgIZANkBsqI0rrEkpx2ukLQ5txTT1hskLOjLW8tPjcHxZm73jTvQJBRpgWJEp
         Dn504nIf7aDW+bUkbXwPItFYI54YkJiOL0Qt6u9SsWEd0Su0sik71i+Jq5jhEff/X57F
         mkasNpdLISRenWxWBylGQpGm4nNQmRckmBGVww2hO8/dnDAukkiEnmEqb63YFpHEM/88
         mflg==
X-Gm-Message-State: APt69E3XyMrXXN2Yw1rBe0viaZf9hpn1Ol/DRi1PYmqwSIlrcj5rLoEi
        +cA+HViSN88xClMZUqKX1A5GPtiLHy0T
X-Google-Smtp-Source: ADUXVKJkV/B+3611SEwqsvgg3vmI3qDVjRTNIKtScpsZHLpveogW6QwgHEmMTn153SHHZUp+sqIhUlRVP1GG
MIME-Version: 1.0
X-Received: by 2002:a81:3545:: with SMTP id c66-v6mr225829ywa.164.1529624939425;
 Thu, 21 Jun 2018 16:48:59 -0700 (PDT)
Date:   Thu, 21 Jun 2018 16:48:28 -0700
In-Reply-To: <20180621234829.224566-1-rajatja@google.com>
Message-Id: <20180621234829.224566-4-rajatja@google.com>
References: <20180621234829.224566-1-rajatja@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH 3/4] PCI/AER: Add sysfs attributes to provide AER stats and breakdown
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

Add sysfs attributes to provide total and breakdown of the AERs seen,
into different type of correctable, fatal and nonfatal errors:

/sys/bus/pci/devices/<dev>/aer_dev_correctable
/sys/bus/pci/devices/<dev>/aer_dev_fatal
/sys/bus/pci/devices/<dev>/aer_dev_nonfatal

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 .../testing/sysfs-bus-pci-devices-aer_stats   | 94 +++++++++++++++++++
 Documentation/PCI/pcieaer-howto.txt           |  5 +
 drivers/pci/pci-sysfs.c                       |  3 +
 drivers/pci/pci.h                             |  1 +
 drivers/pci/pcie/aer.c                        | 94 +++++++++++++++++++
 5 files changed, 197 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
new file mode 100644
index 000000000000..7dd54bdf910b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
@@ -0,0 +1,94 @@
+==========================
+PCIe Device AER statistics
+==========================
+These attributes show up under all the devices that are AER capable. These
+statistical counters indicate the errors "as seen/reported by the device".
+Note that this may mean that if an end point is causing problems, the AER
+counters may increment at its link partner (e.g. root port) because the
+errors may be "seen" / reported by the link partner and not the the
+problematic end point itself (which may report all counters as 0 as it never
+saw any problems).
+
+Where:		/sys/bus/pci/devices/<dev>/aer_dev_correctable
+Date:		July 2018
+Kernel Version: 4.19.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	List of correctable errors seen and reported by this
+		PCI device using ERR_COR. Note that since multiple errors may
+		be reported using a single ERR_COR message, thus
+		TOTAL_ERR_COR at the end of the file  may not match the actual
+		total of all the errors in the file. Sample output:
+-------------------------------------------------------------------------
+localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat aer_dev_correctable
+Receiver Error 2
+Bad TLP 0
+Bad DLLP 0
+RELAY_NUM Rollover 0
+Replay Timer Timeout 0
+Advisory Non-Fatal 0
+Corrected Internal Error 0
+Header Log Overflow 0
+TOTAL_ERR_COR 2
+-------------------------------------------------------------------------
+
+Where:		/sys/bus/pci/devices/<dev>/aer_dev_fatal
+Date:		July 2018
+Kernel Version: 4.19.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	List of uncorrectable fatal errors seen and reported by this
+		PCI device using ERR_FATAL. Note that since multiple errors may
+		be reported using a single ERR_FATAL message, thus
+		TOTAL_ERR_FATAL at the end of the file may not match the actual
+		total of all the errors in the file. Sample output:
+-------------------------------------------------------------------------
+localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat aer_dev_fatal
+Undefined 0
+Data Link Protocol 0
+Surprise Down Error 0
+Poisoned TLP 0
+Flow Control Protocol 0
+Completion Timeout 0
+Completer Abort 0
+Unexpected Completion 0
+Receiver Overflow 0
+Malformed TLP 0
+ECRC 0
+Unsupported Request 0
+ACS Violation 0
+Uncorrectable Internal Error 0
+MC Blocked TLP 0
+AtomicOp Egress Blocked 0
+TLP Prefix Blocked Error 0
+TOTAL_ERR_FATAL 0
+-------------------------------------------------------------------------
+
+Where:		/sys/bus/pci/devices/<dev>/aer_dev_nonfatal
+Date:		July 2018
+Kernel Version: 4.19.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	List of uncorrectable nonfatal errors seen and reported by this
+		PCI device using ERR_NONFATAL. Note that since multiple errors
+		may be reported using a single ERR_FATAL message, thus
+		TOTAL_ERR_NONFATAL at the end of the file may not match the
+		actual total of all the errors in the file. Sample output:
+-------------------------------------------------------------------------
+localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat aer_dev_nonfatal
+Undefined 0
+Data Link Protocol 0
+Surprise Down Error 0
+Poisoned TLP 0
+Flow Control Protocol 0
+Completion Timeout 0
+Completer Abort 0
+Unexpected Completion 0
+Receiver Overflow 0
+Malformed TLP 0
+ECRC 0
+Unsupported Request 0
+ACS Violation 0
+Uncorrectable Internal Error 0
+MC Blocked TLP 0
+AtomicOp Egress Blocked 0
+TLP Prefix Blocked Error 0
+TOTAL_ERR_NONFATAL 0
+-------------------------------------------------------------------------
diff --git a/Documentation/PCI/pcieaer-howto.txt b/Documentation/PCI/pcieaer-howto.txt
index acd0dddd6bb8..91b6e677cb8c 100644
--- a/Documentation/PCI/pcieaer-howto.txt
+++ b/Documentation/PCI/pcieaer-howto.txt
@@ -73,6 +73,11 @@ In the example, 'Requester ID' means the ID of the device who sends
 the error message to root port. Pls. refer to pci express specs for
 other fields.
 
+2.4 AER Statistics / Counters
+
+When PCIe AER errors are captured, the counters / statistics are also exposed
+in form of sysfs attributes which are documented at
+Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
 
 3. Developer Guide
 
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 0c4653c1d2ce..9f1cb9051d7d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1746,6 +1746,9 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
 #endif
 	&pci_bridge_attr_group,
 	&pcie_dev_attr_group,
+#ifdef CONFIG_PCIEAER
+	&aer_stats_attr_group,
+#endif
 	NULL,
 };
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0759a7be9ef2..679f1edb73e6 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -456,6 +456,7 @@ static inline int devm_of_pci_get_host_bridge_resources(struct device *dev,
 void pci_no_aer(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
+extern const struct attribute_group aer_stats_attr_group;
 #else
 static inline void pci_no_aer(void) { }
 static inline int pci_aer_init(struct pci_dev *d) { return -ENODEV; }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 6aa5284d5805..15c6ae4b9754 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -562,6 +562,99 @@ static const char *aer_agent_string[] = {
 	"Transmitter ID"
 };
 
+#define aer_stats_dev_attr(name, stats_array, strings_array,		\
+			   total_string, total_field)			\
+	static ssize_t							\
+	name##_show(struct device *dev, struct device_attribute *attr,	\
+		     char *buf)						\
+{									\
+	unsigned int i;							\
+	char *str = buf;						\
+	struct pci_dev *pdev = to_pci_dev(dev);				\
+	u64 *stats = pdev->aer_stats->stats_array;			\
+									\
+	for (i = 0; i < ARRAY_SIZE(strings_array); i++) {		\
+		if (strings_array[i])					\
+			str += sprintf(str, "%s %llu\n",		\
+				       strings_array[i], stats[i]);	\
+		else if (stats[i])					\
+			str += sprintf(str, #stats_array "_bit[%d] %llu\n",\
+				       i, stats[i]);			\
+	}								\
+	str += sprintf(str, "TOTAL_%s %llu\n", total_string,		\
+		       pdev->aer_stats->total_field);			\
+	return str-buf;							\
+}									\
+static DEVICE_ATTR_RO(name)
+
+aer_stats_dev_attr(aer_dev_correctable, dev_cor_errs,
+		   aer_correctable_error_string, "ERR_COR",
+		   dev_total_cor_errs);
+aer_stats_dev_attr(aer_dev_fatal, dev_fatal_errs,
+		   aer_uncorrectable_error_string, "ERR_FATAL",
+		   dev_total_fatal_errs);
+aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfatal_errs,
+		   aer_uncorrectable_error_string, "ERR_NONFATAL",
+		   dev_total_nonfatal_errs);
+
+static struct attribute *aer_stats_attrs[] __ro_after_init = {
+	&dev_attr_aer_dev_correctable.attr,
+	&dev_attr_aer_dev_fatal.attr,
+	&dev_attr_aer_dev_nonfatal.attr,
+	NULL
+};
+
+static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
+					   struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (!pdev->aer_stats)
+		return 0;
+
+	return a->mode;
+}
+
+const struct attribute_group aer_stats_attr_group = {
+	.attrs  = aer_stats_attrs,
+	.is_visible = aer_stats_attrs_are_visible,
+};
+
+static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
+				   struct aer_err_info *info)
+{
+	int status, i, max = -1;
+	u64 *counter = NULL;
+	struct aer_stats *aer_stats = pdev->aer_stats;
+
+	if (!aer_stats)
+		return;
+
+	switch (info->severity) {
+	case AER_CORRECTABLE:
+		aer_stats->dev_total_cor_errs++;
+		counter = &aer_stats->dev_cor_errs[0];
+		max = AER_MAX_TYPEOF_COR_ERRS;
+		break;
+	case AER_NONFATAL:
+		aer_stats->dev_total_nonfatal_errs++;
+		counter = &aer_stats->dev_nonfatal_errs[0];
+		max = AER_MAX_TYPEOF_UNCOR_ERRS;
+		break;
+	case AER_FATAL:
+		aer_stats->dev_total_fatal_errs++;
+		counter = &aer_stats->dev_fatal_errs[0];
+		max = AER_MAX_TYPEOF_UNCOR_ERRS;
+		break;
+	}
+
+	status = (info->status & ~info->mask);
+	for (i = 0; i < max; i++)
+		if (status & (1 << i))
+			counter[i]++;
+}
+
 static void __print_tlp_header(struct pci_dev *dev,
 			       struct aer_header_log_regs *t)
 {
@@ -594,6 +687,7 @@ static void __aer_print_error(struct pci_dev *dev,
 			pci_err(dev, "   [%2d] Unknown Error Bit%s\n",
 				i, info->first_error == i ? " (First)" : "");
 	}
+	pci_dev_aer_stats_incr(dev, info);
 }
 
 static void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
-- 
2.18.0.rc2.346.g013aa6912e-goog

