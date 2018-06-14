Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0E9BAC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB97208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xsglwRtt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB97208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964837AbeFNOGi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936289AbeFNOG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:06:28 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CCEB208DD;
        Thu, 14 Jun 2018 14:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985187;
        bh=6gjjveWXJtC3eNR46/8lps/qRMsIcIxGh8JmtI0nvvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xsglwRttUyUs0zxSKRZ4XuBXAwXeY/7wXBXmb+Lo357Qn8Ul+g3UM2jySp6/HnG16
         7LVvozQt7vjljk17Fh9F1eDv7nEs5Hf10ePNLOjzo0PZ0Vmn//OeFdinBLIBuwngi1
         LylKrwLQpQjdY8dZ7+e8d29ufOH9yu9S3ODRnvwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 4.17 30/45] doc: fix sysfs ABI documentation
Date:   Thu, 14 Jun 2018 16:04:21 +0200
Message-Id: <20180614132128.438866343@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132126.797006529@linuxfoundation.org>
References: <20180614132126.797006529@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Hemminger <stephen@networkplumber.org>

commit f59acbc5e0f7f90452efd4c3318d5e5ec042c3e0 upstream.

In 4.9 kernel, the sysfs files for Hyper-V VMBus changed name but
the documentation files were not updated. The current sysfs file
names are /sys/bus/vmbus/devices/<UUID>/...

See commit 9a56e5d6a0ba ("Drivers: hv: make VMBus bus ids persistent")
and commit f6b2db084b65 ("vmbus: make sysfs names consistent with PCI")

Reported-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/ABI/stable/sysfs-bus-vmbus |   40 +++++++++++++++----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

--- a/Documentation/ABI/stable/sysfs-bus-vmbus
+++ b/Documentation/ABI/stable/sysfs-bus-vmbus
@@ -1,25 +1,25 @@
-What:		/sys/bus/vmbus/devices/vmbus_*/id
+What:		/sys/bus/vmbus/devices/<UUID>/id
 Date:		Jul 2009
 KernelVersion:	2.6.31
 Contact:	K. Y. Srinivasan <kys@microsoft.com>
 Description:	The VMBus child_relid of the device's primary channel
 Users:		tools/hv/lsvmbus
 
-What:		/sys/bus/vmbus/devices/vmbus_*/class_id
+What:		/sys/bus/vmbus/devices/<UUID>/class_id
 Date:		Jul 2009
 KernelVersion:	2.6.31
 Contact:	K. Y. Srinivasan <kys@microsoft.com>
 Description:	The VMBus interface type GUID of the device
 Users:		tools/hv/lsvmbus
 
-What:		/sys/bus/vmbus/devices/vmbus_*/device_id
+What:		/sys/bus/vmbus/devices/<UUID>/device_id
 Date:		Jul 2009
 KernelVersion:	2.6.31
 Contact:	K. Y. Srinivasan <kys@microsoft.com>
 Description:	The VMBus interface instance GUID of the device
 Users:		tools/hv/lsvmbus
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channel_vp_mapping
+What:		/sys/bus/vmbus/devices/<UUID>/channel_vp_mapping
 Date:		Jul 2015
 KernelVersion:	4.2.0
 Contact:	K. Y. Srinivasan <kys@microsoft.com>
@@ -28,112 +28,112 @@ Description:	The mapping of which primar
 		Format: <channel's child_relid:the bound cpu's number>
 Users:		tools/hv/lsvmbus
 
-What:		/sys/bus/vmbus/devices/vmbus_*/device
+What:		/sys/bus/vmbus/devices/<UUID>/device
 Date:		Dec. 2015
 KernelVersion:	4.5
 Contact:	K. Y. Srinivasan <kys@microsoft.com>
 Description:	The 16 bit device ID of the device
 Users:		tools/hv/lsvmbus and user level RDMA libraries
 
-What:		/sys/bus/vmbus/devices/vmbus_*/vendor
+What:		/sys/bus/vmbus/devices/<UUID>/vendor
 Date:		Dec. 2015
 KernelVersion:	4.5
 Contact:	K. Y. Srinivasan <kys@microsoft.com>
 Description:	The 16 bit vendor ID of the device
 Users:		tools/hv/lsvmbus and user level RDMA libraries
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Directory for per-channel information
 		NN is the VMBUS relid associtated with the channel.
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/cpu
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/cpu
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	VCPU (sub)channel is affinitized to
 Users:		tools/hv/lsvmbus and other debugging tools
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/cpu
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/cpu
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	VCPU (sub)channel is affinitized to
 Users:		tools/hv/lsvmbus and other debugging tools
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/in_mask
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/in_mask
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Host to guest channel interrupt mask
 Users:		Debugging tools
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/latency
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/latency
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Channel signaling latency
 Users:		Debugging tools
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/out_mask
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/out_mask
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Guest to host channel interrupt mask
 Users:		Debugging tools
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/pending
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/pending
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Channel interrupt pending state
 Users:		Debugging tools
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/read_avail
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/read_avail
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Bytes available to read
 Users:		Debugging tools
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/write_avail
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/write_avail
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Bytes available to write
 Users:		Debugging tools
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/events
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/events
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Number of times we have signaled the host
 Users:		Debugging tools
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/interrupts
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/interrupts
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Number of times we have taken an interrupt (incoming)
 Users:		Debugging tools
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/subchannel_id
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/subchannel_id
 Date:		January. 2018
 KernelVersion:	4.16
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Subchannel ID associated with VMBUS channel
 Users:		Debugging tools and userspace drivers
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/monitor_id
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/monitor_id
 Date:		January. 2018
 KernelVersion:	4.16
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Monitor bit associated with channel
 Users:		Debugging tools and userspace drivers
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/ring
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/ring
 Date:		January. 2018
 KernelVersion:	4.16
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>


