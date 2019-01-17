Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F522C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90E920657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSuMH/qK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfAQEiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 23:38:04 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52281 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbfAQEiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 23:38:03 -0500
Received: by mail-it1-f195.google.com with SMTP id g76so6835661itg.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 20:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3YOdaQ93UKKDbb4JUTjTEm3ipOX0IE9/tPFBRgq5k9g=;
        b=lSuMH/qKuQcySxWikePIP4XdCWVGehsBbsorUlUygTT1R0LYzeDOVXVSrhqDz51Wvw
         yYkx3JNOKbCTqRpXqDPPuDlDm7eXB+5j/M15cO8bWhqVN4gL7JanVAkQMuoo/1zBX1g1
         oLuWGAtQVNRAYVkvn+mcMlhZ0e/QJgT6MJByukOXhG76o+OOFrCjcmyyG0lYCHdSQfDu
         CV4TadM0t3SvzED4a8x+qNcyyocxPiJWSJ8LVNTPg8ufyDxp73O5GqC1d6mhMn+bqxkw
         0rmKmVtEXODK4dcDbiaW6ltmpM1iD0SCXlJa4EJ39xirJQDyIrgfZM2K6TlpphA+CY51
         iMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3YOdaQ93UKKDbb4JUTjTEm3ipOX0IE9/tPFBRgq5k9g=;
        b=if4OZPtvZtmA2NeIrnnce50kf+zKMy9DX7a+jKYolz1azZ4H+w4DkisjWI+N+RtnqF
         7QcqwMhPYtwdH3Dxnhzz4gVhJ3jfi0721S1ZdyNzg5965ASkBQqnl88faT66yn69MlXu
         2p900ylEiyoFkvx1fPWWOpZ7iF1NHJEU49opmJ6alSOOKG30cHd4Is50N4Pog7Nly6e8
         tvPb9DjcE7orZEu8supobkMBfX780ig7SLvfA7Xgu6ioOJ8+Ge7nTW9MIhGRf0b079KX
         57ALCO6yZwYeKOx4t0hK/oQ2/z5zXoLA6bFvW26G1rfmHnxfPxR2sspDCv5/ocodHFFH
         fy4g==
X-Gm-Message-State: AJcUukdxBS/QwcqLUjcEzIISS3ugkMpttftYy9QL5g/9yPwSO7MjggUc
        P0c4nGhkOCuwULWMyhYXm+I=
X-Google-Smtp-Source: ALg8bN5+KequEoeF+V9RkSfC7M7HkPnol9LxwLOXviMhxnmoBs5zofMnX2ecbQ+lAdOcadp/JCOF/g==
X-Received: by 2002:a02:9c53:: with SMTP id h19mr7385981jal.31.1547699882537;
        Wed, 16 Jan 2019 20:38:02 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id i201sm195022ioa.1.2019.01.16.20.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 20:38:01 -0800 (PST)
Date:   Wed, 16 Jan 2019 23:37:59 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] Drivers: hv: vmbus: Expose counters for interrupts and
 full conditions
Message-ID: <20190117043759.GA3395@ubu-Virtual-Machine>
References: <20190105043518.GA4072@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190105043518.GA4072@ubu-Virtual-Machine>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Counter values for per-channel interrupts and ring buffer full
conditions are useful for investigating performance.

Expose counters in sysfs for 2 types of guest to host interrupts:
1) Interrupts caused by the channel's outbound ring buffer transitioning
from empty to not empty
2) Interrupts caused by the channel's inbound ring buffer transitioning
from full to not full while a packet is waiting for enough buffer space to
become available

Expose 2 counters in sysfs for the number of times that write operations
encountered a full outbound ring buffer:
1) The total number of write operations that encountered a full
condition
2) The number of write operations that were the first to encounter a
full condition

I tested this patch by confirming that the sysfs files were created and
observing the counter values. The values seemed to increase by a
reasonable amount when the Hyper-v related drivers were in use.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---
Changes in v3:
 - Used the outbound ring buffer spinlock to protect the the full
   condition counters in set_channel_pending_send_size()
 - Corrected the KernelVersion values for the new entries in
   Documentation/ABI/stable/sysfs-bus-vmbus

Changes in v2:
 - Added mailing lists to the cc list
 - Removed the host to guest interrupt counters proposed in v1 because
   they were not accurate
 - Added full condition counters for the channel's outbound ring buffer

 Documentation/ABI/stable/sysfs-bus-vmbus | 33 ++++++++++++++++++++
 drivers/hv/ring_buffer.c                 | 14 ++++++++-
 drivers/hv/vmbus_drv.c                   | 32 ++++++++++++++++++++
 include/linux/hyperv.h                   | 38 ++++++++++++++++++++++++
 4 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
index 3fed8fdb873d..a0304c563467 100644
--- a/Documentation/ABI/stable/sysfs-bus-vmbus
+++ b/Documentation/ABI/stable/sysfs-bus-vmbus
@@ -146,3 +146,36 @@ KernelVersion:	4.16
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Binary file created by uio_hv_generic for ring buffer
 Users:		Userspace drivers
+
+What:           /sys/bus/vmbus/devices/<UUID>/channels/<N>/intr_in_full
+Date:           January 2019
+KernelVersion:  5.0
+Contact:        Michael Kelley <mikelley@microsoft.com>
+Description:    Number of guest to host interrupts caused by the inbound ring
+		buffer transitioning from full to not full while a packet is
+		waiting for buffer space to become available
+Users:          Debugging tools
+
+What:           /sys/bus/vmbus/devices/<UUID>/channels/<N>/intr_out_empty
+Date:           January 2019
+KernelVersion:  5.0
+Contact:        Michael Kelley <mikelley@microsoft.com>
+Description:    Number of guest to host interrupts caused by the outbound ring
+		buffer transitioning from empty to not empty
+Users:          Debugging tools
+
+What:           /sys/bus/vmbus/devices/<UUID>/channels/<N>/out_full_first
+Date:           January 2019
+KernelVersion:  5.0
+Contact:        Michael Kelley <mikelley@microsoft.com>
+Description:    Number of write operations that were the first to encounter an
+		outbound ring buffer full condition
+Users:          Debugging tools
+
+What:           /sys/bus/vmbus/devices/<UUID>/channels/<N>/out_full_total
+Date:           January 2019
+KernelVersion:  5.0
+Contact:        Michael Kelley <mikelley@microsoft.com>
+Description:    Total number of write operations that encountered an outbound
+		ring buffer full condition
+Users:          Debugging tools
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 1f1a55e07733..9e8b31ccc142 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -74,8 +74,10 @@ static void hv_signal_on_write(u32 old_write, struct vmbus_channel *channel)
 	 * This is the only case we need to signal when the
 	 * ring transitions from being empty to non-empty.
 	 */
-	if (old_write == READ_ONCE(rbi->ring_buffer->read_index))
+	if (old_write == READ_ONCE(rbi->ring_buffer->read_index)) {
+		++channel->intr_out_empty;
 		vmbus_setevent(channel);
+	}
 }
 
 /* Get the next write location for the specified ring buffer. */
@@ -272,10 +274,19 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 	 * is empty since the read index == write index.
 	 */
 	if (bytes_avail_towrite <= totalbytes_towrite) {
+		++channel->out_full_total;
+
+		if (!channel->out_full_flag) {
+			++channel->out_full_first;
+			channel->out_full_flag = true;
+		}
+
 		spin_unlock_irqrestore(&outring_info->ring_lock, flags);
 		return -EAGAIN;
 	}
 
+	channel->out_full_flag = false;
+
 	/* Write to the ring buffer */
 	next_write_location = hv_get_next_write_location(outring_info);
 
@@ -530,6 +541,7 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
 	if (curr_write_sz <= pending_sz)
 		return;
 
+	++channel->intr_in_full;
 	vmbus_setevent(channel);
 }
 EXPORT_SYMBOL_GPL(hv_pkt_iter_close);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 403fee01572c..e291a7d3180c 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1496,6 +1496,34 @@ static ssize_t channel_events_show(const struct vmbus_channel *channel, char *bu
 }
 static VMBUS_CHAN_ATTR(events, S_IRUGO, channel_events_show, NULL);
 
+static ssize_t channel_intr_in_full_show(const struct vmbus_channel *channel,
+					 char *buf)
+{
+	return sprintf(buf, "%llu\n", channel->intr_in_full);
+}
+static VMBUS_CHAN_ATTR(intr_in_full, 0444, channel_intr_in_full_show, NULL);
+
+static ssize_t channel_intr_out_empty_show(const struct vmbus_channel *channel,
+					   char *buf)
+{
+	return sprintf(buf, "%llu\n", channel->intr_out_empty);
+}
+static VMBUS_CHAN_ATTR(intr_out_empty, 0444, channel_intr_out_empty_show, NULL);
+
+static ssize_t channel_out_full_first_show(const struct vmbus_channel *channel,
+					   char *buf)
+{
+	return sprintf(buf, "%llu\n", channel->out_full_first);
+}
+static VMBUS_CHAN_ATTR(out_full_first, 0444, channel_out_full_first_show, NULL);
+
+static ssize_t channel_out_full_total_show(const struct vmbus_channel *channel,
+					   char *buf)
+{
+	return sprintf(buf, "%llu\n", channel->out_full_total);
+}
+static VMBUS_CHAN_ATTR(out_full_total, 0444, channel_out_full_total_show, NULL);
+
 static ssize_t subchannel_monitor_id_show(const struct vmbus_channel *channel,
 					  char *buf)
 {
@@ -1521,6 +1549,10 @@ static struct attribute *vmbus_chan_attrs[] = {
 	&chan_attr_latency.attr,
 	&chan_attr_interrupts.attr,
 	&chan_attr_events.attr,
+	&chan_attr_intr_in_full.attr,
+	&chan_attr_intr_out_empty.attr,
+	&chan_attr_out_full_first.attr,
+	&chan_attr_out_full_total.attr,
 	&chan_attr_monitor_id.attr,
 	&chan_attr_subchannel_id.attr,
 	NULL
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index dcb6977afce9..7e5239123276 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -751,6 +751,27 @@ struct vmbus_channel {
 	u64	interrupts;	/* Host to Guest interrupts */
 	u64	sig_events;	/* Guest to Host events */
 
+	/* Interrupt counts for 2 types of Guest to Host interrupts */
+	u64 intr_in_full;	/* in ring buffer, full to not full */
+	u64 intr_out_empty;	/* out ring buffer, empty to not empty */
+
+	/*
+	 * The total number of write operations that encountered a full
+	 * outbound ring buffer.
+	 */
+	u64 out_full_total;
+	/*
+	 * The number of write operations that were the first to encounter a
+	 * full outbound ring buffer.
+	 */
+	u64 out_full_first;
+	/*
+	 * Indicates that a full outbound ring buffer was encountered. The flag
+	 * is set to true when a full outbound ring buffer is encountered and
+	 * set to false when a write to the outbound ring buffer is completed.
+	 */
+	bool out_full_flag;
+
 	/* Channel callback's invoked in softirq context */
 	struct tasklet_struct callback_event;
 	void (*onchannel_callback)(void *context);
@@ -936,6 +957,23 @@ static inline void *get_per_channel_state(struct vmbus_channel *c)
 static inline void set_channel_pending_send_size(struct vmbus_channel *c,
 						 u32 size)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&c->outbound.ring_lock, flags);
+
+	if (size) {
+		++c->out_full_total;
+
+		if (!c->out_full_flag) {
+			++c->out_full_first;
+			c->out_full_flag = true;
+		}
+	} else {
+		c->out_full_flag = false;
+	}
+
+	spin_unlock_irqrestore(&c->outbound.ring_lock, flags);
+
 	c->outbound.ring_buffer->pending_send_sz = size;
 }
 
-- 
2.17.1

