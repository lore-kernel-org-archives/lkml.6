Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760E4C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1202177E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0uTrnEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfBDHNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 02:13:14 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52354 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfBDHNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 02:13:13 -0500
Received: by mail-it1-f196.google.com with SMTP id d11so18866290itf.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 23:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+135MwROH0BuMsa4R1WeRoPXpN4dPTuBwfd8vN+pINI=;
        b=r0uTrnEa35J25hosxBYueMjf2eebegzN5tQ1wwUZTEqCE/gzasOvTExFSxQqEkg7Lm
         hdyKaD+kZMpDXkkVDeqc3RvGokd17Wp2picIe1uvN0cyYItfXuqn1KMDgncjc0U/iq5w
         /ipty+Jyk1xHgwSxgbcGijllGCgZ3D9U4KjIlpxyUEnCW44Pqd0xkhC4TIfB7LipK28h
         29rJ3kYydui1OqnQMi0afTHRlcmy+8B2PAIzuU6lMCTNdqSGBWXVsNm8qfqjs6Z5A7bs
         s37lVVSI3mOJmH5izWUwTe+ERHiXE+AaDMr4KGik5I+j8zAC9dPPSieOt1NR8iFmNxtt
         8Whg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+135MwROH0BuMsa4R1WeRoPXpN4dPTuBwfd8vN+pINI=;
        b=DI9W+RcEzRibWmDNKBuEEUSmeHYDCdBjh4rEThb+yozy7EbGxYNMAMgo2FuovppzKF
         UVq9+JdV1eOW5tkxlMuDkrGxs6/zliRpmcAMSoPN1uIeX/4GzW6Ck4ydEAF5hXLlVflI
         DILl/fBFRtq5ldxgXgmATgBTsPeAucVcjwqsp0gHlRLNJGNLLz/YhIgs928ax3ywGOVc
         92nNRyBe0OMzw58xFRoFDwstQRlYOEs5UFQ51FfHxMrzuxpGrA4z+ASaYNEvUUzxGFBr
         9u3ajitWniB9bCA3q5De689eqovzz+CgAhL6sJ0hYOVB0n1ySp5HIR5gMHQC+NJeH4XT
         hCPg==
X-Gm-Message-State: AHQUAuYaf7MzJYwlXvqPj0BW0adGcKnoAoZ5wSAsfgpD2ck3jZtmHk3a
        wJhzHYH7eMl596PTG33nAvGHCKYyi8o=
X-Google-Smtp-Source: AHgI3IbW/4P7CWzrkj1II2AnlamU9zWJtdP15NsHfd7LH4tOA7nF1T+WJsR/vkivr/VK0b0xFksI4Q==
X-Received: by 2002:a5d:9812:: with SMTP id a18mr24379629iol.236.1549264392428;
        Sun, 03 Feb 2019 23:13:12 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id w17sm2793730iom.64.2019.02.03.23.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Feb 2019 23:13:11 -0800 (PST)
Date:   Mon, 4 Feb 2019 02:13:09 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] Drivers: hv: vmbus: Expose counters for interrupts and
 full conditions
Message-ID: <20190204071309.GA3470@ubu-Virtual-Machine>
References: <20190117043759.GA3395@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117043759.GA3395@ubu-Virtual-Machine>
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

Increment the outbound full condition counters in the
hv_ringbuffer_write() function because, for most drivers, a full
outbound ring buffer is detected in that function. Also increment the
outbound full condition counters in the set_channel_pending_send_size()
function. In the hv_sock driver, a full outbound ring buffer is detected
and set_channel_pending_send_size() is called before
hv_ringbuffer_write() is called.

I tested this patch by confirming that the sysfs files were created and
observing the counter values. The values seemed to increase by a
reasonable amount when the Hyper-v related drivers were in use.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---

Changes in v4:
 - In the commit message, added a paragraph describing why the full
   condition counters are incremented in two functions.

 - In the four new "_show" functions, added a cast to "(unsigned long
   long)" in the sprintf() calls. This problem was reported by S.
   Hemminger.

 - In the vmbus_channel struct definition, moved the three new fields
   pertaining to full ring buffers ("intr_in_full", "out_full_total",
   "out_full_first") to the bottom of the struct.  These fields should 
   not be used often because full ring buffers should not be encountered 
   often. This change addresses S. Hemminger's concern about the new 
   fields causing additional cache misses in the hot path.

 - In the set_channel_pending_send_size() function, moved the
   acquire/release of the spinlock to inside the if-statement. The
   spinlock needs to protect only the incrementing variables. Since full
   ring buffers should not be encountered often, the addition of this
   spinlock acquire/release should not affect performance. This change
   addresses S. Hemminger's concern that additional locking will affect
   performance.

 NOTE: S. Hemminger also requested that I consider placing the new bool
       field, "out_full_flag", in a bitfield. I chose not to make this 
       change because setting an individual bit in a bitfield is less 
       efficient than setting the value of a bool.

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


Documentation/ABI/stable/sysfs-bus-vmbus | 33 +++++++++++++++++
 drivers/hv/ring_buffer.c                 | 14 +++++++-
 drivers/hv/vmbus_drv.c                   | 36 +++++++++++++++++++
 include/linux/hyperv.h                   | 46 ++++++++++++++++++++++++
 4 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
index 3fed8fdb873d..826689dcc2e6 100644
--- a/Documentation/ABI/stable/sysfs-bus-vmbus
+++ b/Documentation/ABI/stable/sysfs-bus-vmbus
@@ -146,3 +146,36 @@ KernelVersion:	4.16
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Binary file created by uio_hv_generic for ring buffer
 Users:		Userspace drivers
+
+What:           /sys/bus/vmbus/devices/<UUID>/channels/<N>/intr_in_full
+Date:           February 2019
+KernelVersion:  5.0
+Contact:        Michael Kelley <mikelley@microsoft.com>
+Description:    Number of guest to host interrupts caused by the inbound ring
+		buffer transitioning from full to not full while a packet is
+		waiting for buffer space to become available
+Users:          Debugging tools
+
+What:           /sys/bus/vmbus/devices/<UUID>/channels/<N>/intr_out_empty
+Date:           February 2019
+KernelVersion:  5.0
+Contact:        Michael Kelley <mikelley@microsoft.com>
+Description:    Number of guest to host interrupts caused by the outbound ring
+		buffer transitioning from empty to not empty
+Users:          Debugging tools
+
+What:           /sys/bus/vmbus/devices/<UUID>/channels/<N>/out_full_first
+Date:           February 2019
+KernelVersion:  5.0
+Contact:        Michael Kelley <mikelley@microsoft.com>
+Description:    Number of write operations that were the first to encounter an
+		outbound ring buffer full condition
+Users:          Debugging tools
+
+What:           /sys/bus/vmbus/devices/<UUID>/channels/<N>/out_full_total
+Date:           February 2019
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
index 403fee01572c..b9fa30f0fc52 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1496,6 +1496,38 @@ static ssize_t channel_events_show(const struct vmbus_channel *channel, char *bu
 }
 static VMBUS_CHAN_ATTR(events, S_IRUGO, channel_events_show, NULL);
 
+static ssize_t channel_intr_in_full_show(const struct vmbus_channel *channel,
+					 char *buf)
+{
+	return sprintf(buf, "%llu\n",
+		       (unsigned long long)channel->intr_in_full);
+}
+static VMBUS_CHAN_ATTR(intr_in_full, 0444, channel_intr_in_full_show, NULL);
+
+static ssize_t channel_intr_out_empty_show(const struct vmbus_channel *channel,
+					   char *buf)
+{
+	return sprintf(buf, "%llu\n",
+		       (unsigned long long)channel->intr_out_empty);
+}
+static VMBUS_CHAN_ATTR(intr_out_empty, 0444, channel_intr_out_empty_show, NULL);
+
+static ssize_t channel_out_full_first_show(const struct vmbus_channel *channel,
+					   char *buf)
+{
+	return sprintf(buf, "%llu\n",
+		       (unsigned long long)channel->out_full_first);
+}
+static VMBUS_CHAN_ATTR(out_full_first, 0444, channel_out_full_first_show, NULL);
+
+static ssize_t channel_out_full_total_show(const struct vmbus_channel *channel,
+					   char *buf)
+{
+	return sprintf(buf, "%llu\n",
+		       (unsigned long long)channel->out_full_total);
+}
+static VMBUS_CHAN_ATTR(out_full_total, 0444, channel_out_full_total_show, NULL);
+
 static ssize_t subchannel_monitor_id_show(const struct vmbus_channel *channel,
 					  char *buf)
 {
@@ -1521,6 +1553,10 @@ static struct attribute *vmbus_chan_attrs[] = {
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
index dcb6977afce9..f1a2daece298 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -751,6 +751,19 @@ struct vmbus_channel {
 	u64	interrupts;	/* Host to Guest interrupts */
 	u64	sig_events;	/* Guest to Host events */
 
+	/*
+	 * Guest to host interrupts caused by the outbound ring buffer changing
+	 * from empty to not empty.
+	 */
+	u64 intr_out_empty;
+
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
@@ -903,6 +916,24 @@ struct vmbus_channel {
 	 * vmbus_connection.work_queue and hang: see vmbus_process_offer().
 	 */
 	struct work_struct add_channel_work;
+
+	/*
+	 * Guest to host interrupts caused by the inbound ring buffer changing
+	 * from full to not full while a packet is waiting.
+	 */
+	u64 intr_in_full;
+
+	/*
+	 * The total number of write operations that encountered a full
+	 * outbound ring buffer.
+	 */
+	u64 out_full_total;
+
+	/*
+	 * The number of write operations that were the first to encounter a
+	 * full outbound ring buffer.
+	 */
+	u64 out_full_first;
 };
 
 static inline bool is_hvsock_channel(const struct vmbus_channel *c)
@@ -936,6 +967,21 @@ static inline void *get_per_channel_state(struct vmbus_channel *c)
 static inline void set_channel_pending_send_size(struct vmbus_channel *c,
 						 u32 size)
 {
+	unsigned long flags;
+
+	if (size) {
+		spin_lock_irqsave(&c->outbound.ring_lock, flags);
+		++c->out_full_total;
+
+		if (!c->out_full_flag) {
+			++c->out_full_first;
+			c->out_full_flag = true;
+		}
+		spin_unlock_irqrestore(&c->outbound.ring_lock, flags);
+	} else {
+		c->out_full_flag = false;
+	}
+
 	c->outbound.ring_buffer->pending_send_sz = size;
 }
 
-- 
2.17.1

