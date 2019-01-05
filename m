Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77971C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB4A20868
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EE3mT0qO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfAEEfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 23:35:23 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:34236 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfAEEfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 23:35:22 -0500
Received: by mail-it1-f195.google.com with SMTP id x124so2800035itd.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 20:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UdhWk2jCXjOswIH7xe6cmxrqB+fK1vn+RvO2k+Im3T8=;
        b=EE3mT0qOVF69TlTxvXx5NZ4Yejf5LYE3o4WRi6ChBcQkXAd53tjj9jLm7/bcrWOZmo
         iGlkHequWHVUtbT3CgPHL15fw/JOa/U8ZaOxhfE8JZGlfgve9sWFhGFBWCAKP2gTkh4N
         vmQzkdlxPGbr5mbgn3GxGQ/CMVG1SjXfS20JySoYlnfp3/3Aww8YrJp8jIbttgvENxCp
         mhHoNWCpiscob/9KNZqMHaBZEm93AXHKjFGeGGJRPFiwWTgwTxcFO0hYtMAi3KbnxKlb
         ZcErxEYsTIfqLwfDAzv+YKsjaxNJE1+55mXM5UMX/paA0Sw0TAPZT3stEoBfTkZojlAg
         qzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UdhWk2jCXjOswIH7xe6cmxrqB+fK1vn+RvO2k+Im3T8=;
        b=LLr9Y4dlH8nnBD5HyE9lTS3W3aJiAHFrFNKzwthkCE2YTn7eFe3bDyx++48dHC83xa
         RhnL8nqAMfVc86796VbUzdoFqkM843Iw1yQo00Ax8WjNAO0fRQqxkaYC9NAIp2wL+nng
         //V5/fu1/CNe5oyTka+LqVq0OsguvIAaCtreUp4FWQa/0tZwsx9oWVyMdSYB3oQCK26c
         ccqSyzodBSzMbMKbMCWZrGfHSQbj6L9rtm8NcSVbw1QB4solF4nU8VH3LhEqlEg2NCmS
         HJWbWpGKxLOL8xo0F8yKxQOVv0EMwiGapFpbS1zL5XzTF2fv/HE283vW1zDHPd21eVpw
         CwaQ==
X-Gm-Message-State: AA+aEWbMpt7LSTwaq1/LDJhxEUsEQ5Kbd/M8A0h1dD9RmYSDMfm1WPEL
        NMOGbjDdOo3Hbu58fbjurPk=
X-Google-Smtp-Source: AFSGD/WpzPSPrI/RQafvKUtmqkaKLSviqLREh9WQpp/D9q/VNLJ/D5Ej0FazFP7RAQn7DJRBC+mefg==
X-Received: by 2002:a02:94eb:: with SMTP id x98mr35432150jah.88.1546662921163;
        Fri, 04 Jan 2019 20:35:21 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id g21sm1471086itg.44.2019.01.04.20.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 20:35:20 -0800 (PST)
Date:   Fri, 4 Jan 2019 23:35:18 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Drivers: hv: vmbus: Expose counters for interrupts and
 full conditions
Message-ID: <20190105043518.GA4072@ubu-Virtual-Machine>
References: <0181213190901.GA3843@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0181213190901.GA3843@ubu-Virtual-Machine>
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
Changes in v2:
  - Added mailing lists to the cc list
  - Removed the host to guest interrupt counters proposed in v1 because
    they were not accurate
  - Added full condition counters for the channel's outbound ring buffer

 Documentation/ABI/stable/sysfs-bus-vmbus | 33 ++++++++++++++++++++++++
 drivers/hv/ring_buffer.c                 | 14 +++++++++-
 drivers/hv/vmbus_drv.c                   | 32 +++++++++++++++++++++++
 include/linux/hyperv.h                   | 32 +++++++++++++++++++++++
 4 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
index 3fed8fdb873d..31dc89989032 100644
--- a/Documentation/ABI/stable/sysfs-bus-vmbus
+++ b/Documentation/ABI/stable/sysfs-bus-vmbus
@@ -146,3 +146,36 @@ KernelVersion:	4.16
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Binary file created by uio_hv_generic for ring buffer
 Users:		Userspace drivers
+
+What:           /sys/bus/vmbus/devices/<UUID>/channels/<N>/intr_in_full
+Date:           January 2019
+KernelVersion:  4.21
+Contact:        Michael Kelley <mikelley@microsoft.com>
+Description:    Number of guest to host interrupts caused by the inbound ring
+		buffer transitioning from full to not full while a packet is
+		waiting for buffer space to become available
+Users:          Debugging tools
+
+What:           /sys/bus/vmbus/devices/<UUID>/channels/<N>/intr_out_empty
+Date:           January 2019
+KernelVersion:  4.21
+Contact:        Michael Kelley <mikelley@microsoft.com>
+Description:    Number of guest to host interrupts caused by the outbound ring
+		buffer transitioning from empty to not empty
+Users:          Debugging tools
+
+What:           /sys/bus/vmbus/devices/<UUID>/channels/<N>/out_full_first
+Date:           January 2019
+KernelVersion:  4.21
+Contact:        Michael Kelley <mikelley@microsoft.com>
+Description:    Number of write operations that were the first to encounter an
+		outbound ring buffer full condition
+Users:          Debugging tools
+
+What:           /sys/bus/vmbus/devices/<UUID>/channels/<N>/out_full_total
+Date:           January 2019
+KernelVersion:  4.21
+Contact:        Michael Kelley <mikelley@microsoft.com>
+Description:    Total number of write operations that encountered an outbound
+		ring buffer full condition
+Users:          Debugging tools
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 64d0c85d5161..be2cbd0bea7d 100644
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
@@ -273,10 +275,19 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
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
 
@@ -531,6 +542,7 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
 	if (curr_write_sz <= pending_sz)
 		return;
 
+	++channel->intr_in_full;
 	vmbus_setevent(channel);
 }
 EXPORT_SYMBOL_GPL(hv_pkt_iter_close);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 283d184280af..460b7f75251c 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1445,6 +1445,34 @@ static ssize_t channel_events_show(const struct vmbus_channel *channel, char *bu
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
@@ -1470,6 +1498,10 @@ static struct attribute *vmbus_chan_attrs[] = {
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
index b3e24368930a..673f58c4bb1d 100644
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
@@ -938,6 +959,17 @@ static inline void *get_per_channel_state(struct vmbus_channel *c)
 static inline void set_channel_pending_send_size(struct vmbus_channel *c,
 						 u32 size)
 {
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
 	c->outbound.ring_buffer->pending_send_sz = size;
 }
 
-- 
2.17.1

