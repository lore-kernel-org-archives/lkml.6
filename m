Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F02CC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AEE20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o2+3gh5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AEE20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933282AbeFTXmP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:42:15 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:44218 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933219AbeFTXmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:42:11 -0400
Received: by mail-ua0-f201.google.com with SMTP id a11-v6so413078uak.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 16:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=kW/g+FWkJYWvtkgkIduENAfIL+FpZoPExCg7OlubknY=;
        b=o2+3gh5wQIUQXaRT6FFcQTU9zzbFimmoD6ku2Lf7CjXr1qD+1OmvBo+drVsLCenJr7
         Yfx3QTRDK8qmvBlyUo8fxOZhlcUgqym2LiB3Jr0vg00Idw5zIeuVjYVkMn3ycX9reOea
         x7MAMPi3LRSVfypYOML6BXQnjqTGhP0/wKp2SILXOAF1eodKYo1zWYWdxnxv/B6SUQFE
         B+liuUgHyqnXhyjEtFu+UOVzsADXSKddKbHyFJVdFbrlvT3XQgGDb3FNfdFzPCDWqH4y
         bQbsd8kAKFpmxf2wexqPdGe4HC8heii+tyfxJsooDHJSSDbY2+GHqpygdQHEb+aUbDRT
         G9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=kW/g+FWkJYWvtkgkIduENAfIL+FpZoPExCg7OlubknY=;
        b=tNNUTWcM3qXQdNhC/KXyXVhKJN4vYAn9tAOcqZ25GrKRKgt3td65es3pSZq6qlN/Dh
         Bw8u5Of1Fb6S8sJzHj6gMg9Mv2D9YbpBlf2gvZawKpaJ7zxyu3U1JRQCn10S3jvbwVQ8
         yEQfZaSO0NjQ9adImNQPSAwfmaL8J4YN7EgHK505UMTAcDiFn63QEdMInIDdLGaB2fAX
         Ssu68j29aOm832UjjvwXsNUHjVl1CHmPg334fdCeeX72irLFjVgDEIKGwqt+XIvkTpwn
         OtygTo2o+Lyxjbe/ROcdOBrZG/1UwRZ/ECG2Ti+9MnhBjvKaGeeAPtEjXF7Dwelf6ezG
         w85g==
X-Gm-Message-State: APt69E2oknhWaCO/7J3c3GIho+1navnmW9WabK1yxXnmuEUcXYJW04UK
        4+Jdk2L7yh2ni6Rx/sjUWBIgZ4O6tJoQ
X-Google-Smtp-Source: ADUXVKLWgIuEjcF1qEcwgyG2tNc+wtiJcO6wSKVOOB9BrqwVL3IxsM27ngHGxpR6/W64gmq0JcaOtjCSONJA
MIME-Version: 1.0
X-Received: by 2002:ab0:15a5:: with SMTP id i34-v6mr10232641uae.22.1529538130519;
 Wed, 20 Jun 2018 16:42:10 -0700 (PDT)
Date:   Wed, 20 Jun 2018 16:41:47 -0700
In-Reply-To: <20180620234147.48438-1-rajatja@google.com>
Message-Id: <20180620234147.48438-5-rajatja@google.com>
References: <20180522222805.80314-1-rajatja@google.com> <20180620234147.48438-1-rajatja@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v5 5/5] Documentation/ABI: Add details of PCI AER statistics
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

Add the PCI AER statistics details to
Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
and provide a pointer to it in
Documentation/PCI/pcieaer-howto.txt

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v5: Same as v4
v4: Same as v3
v3: Add some more details

 .../testing/sysfs-bus-pci-devices-aer_stats   | 111 ++++++++++++++++++
 Documentation/PCI/pcieaer-howto.txt           |   5 +
 2 files changed, 116 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
new file mode 100644
index 000000000000..3ed5a682be87
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
@@ -0,0 +1,111 @@
+==========================
+PCIe Device AER statistics
+==========================
+These attributes show up under all the devices that are AER capable. These
+statistical counters indicate the errors "as seen/reported by the device".
+Note that this may mean that if an end point is causing problems, the AER
+counters may increment at its link partner (e.g. root port) because the
+errors will be "seen" / reported by the link partner and not the the
+problematic end point itself (which may report all counters as 0 as it never
+saw any problems).
+
+Where:		/sys/bus/pci/devices/<dev>/aer_stats/dev_total_cor_errs
+Date:		May 2018
+Kernel Version: 4.17.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	Total number of correctable errors seen and reported by this
+		PCI device using ERR_COR.
+
+Where:		/sys/bus/pci/devices/<dev>/aer_stats/dev_total_fatal_errs
+Date:		May 2018
+Kernel Version: 4.17.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	Total number of uncorrectable fatal errors seen and reported
+		by this PCI device using ERR_FATAL.
+
+Where:		/sys/bus/pci/devices/<dev>/aer_stats/dev_total_nonfatal_errs
+Date:		May 2018
+Kernel Version: 4.17.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	Total number of uncorrectable non-fatal errors seen and reported
+		by this PCI device using ERR_NONFATAL.
+
+Where:		/sys/bus/pci/devices/<dev>/aer_stats/dev_breakdown_correctable
+Date:		May 2018
+Kernel Version: 4.17.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	Breakdown of correctable errors seen and reported by this
+		PCI device using ERR_COR. Note that the sum total of all errors
+		in dev_breakdown_correctable may exceed dev_total_cor_errs
+		because a device is allowed to merge multiple correctable and
+		send a single ERR_COR for them (which is what dev_total_cor_errs
+		counts). A sample output for this attribute looks like this:
+-----------------------------------------
+Receiver Error = 174
+Bad TLP = 19
+Bad DLLP = 3
+RELAY_NUM Rollover = 0
+Replay Timer Timeout = 1
+Advisory Non-Fatal = 0
+Corrected Internal Error = 0
+Header Log Overflow = 0
+-----------------------------------------
+
+Where:		/sys/bus/pci/devices/<dev>/aer_stats/dev_breakdown_uncorrectable
+Date:		May 2018
+Kernel Version: 4.17.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	Breakdown of of correctable errors seen and reported by this
+		PCI device using ERR_FATAL or ERR_NONFATAL. Note that the sum
+		total of all errors in dev_breakdown_uncorrectable may exceed
+		(dev_total_fatal_errs + dev_total_nonfatal_errs) because a
+		device is allowed to merge multiple errors at the same severity
+		and send a single ERR_FATAL/ERR_NON_FATAL for them.
+		A sample output for this attribute looks like this:
+-----------------------------------------
+Undefined = 0
+Data Link Protocol = 0
+Surprise Down Error = 0
+Poisoned TLP = 0
+Flow Control Protocol = 0
+Completion Timeout = 0
+Completer Abort = 0
+Unexpected Completion = 0
+Receiver Overflow = 0
+Malformed TLP = 0
+ECRC = 0
+Unsupported Request = 0
+ACS Violation = 0
+Uncorrectable Internal Error = 0
+MC Blocked TLP = 0
+AtomicOp Egress Blocked = 0
+TLP Prefix Blocked Error = 0
+-----------------------------------------
+
+============================
+PCIe Rootport AER statistics
+============================
+These attributes showup under only the rootports that are AER capable. These
+indicate the number of error messages as "reported to" the rootport. Please note
+that the rootports also transmit (internally) the ERR_* messages for errors seen
+by the internal rootport PCI device, so these counters includes them and are
+thus cumulative of all the error messages on the PCI hierarchy originating
+at that root port.
+
+Where:		/sys/bus/pci/devices/<dev>/aer_stats/rootport_total_cor_errs
+Date:		May 2018
+Kernel Version: 4.17.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	Total number of ERR_COR messages reported to rootport.
+
+Where:		/sys/bus/pci/devices/<dev>/aer_stats/rootport_total_fatal_errs
+Date:		May 2018
+Kernel Version: 4.17.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	Total number of ERR_FATAL messages reported to rootport.
+
+Where:	    /sys/bus/pci/devices/<dev>/aer_stats/rootport_total_nonfatal_errs
+Date:		May 2018
+Kernel Version: 4.17.0
+Contact:	linux-pci@vger.kernel.org, rajatja@google.com
+Description:	Total number of ERR_NONFATAL messages reported to rootport.
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
 
-- 
2.18.0.rc1.244.gcf134e6275-goog

