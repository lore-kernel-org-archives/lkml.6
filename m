Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C222C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379DD20844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQknJl3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfBHVIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:08:00 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54752 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfBHVIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:08:00 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so12261347ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 13:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=62nDTy6qKxNjZuFKmMcolNmapdGOF8KUclifVF9s4ss=;
        b=aQknJl3PxepEEfkh8lTxd9hVg7YrUVyaqBRDtWyANCNqe32/dTUYZMs/Zh/6Rfn7e+
         fJTXZKoMZJ4hsm3g47sDnI3EgsUdmVVRrWlDAstsPNK39d9TMZzehZch5P1vmAg/lJbp
         P1qR3Oa2DtYtZxAkirNFJYWQkmphkbTtW4Nf0KzaGEAMwQubf7YvGPPXPeY/tPhAf4eD
         6o0Jt+LaRr1QHS3KN4msTHTMl0lGRrWgRCTDFNnATw059Iav/SblvEHAzd9UYjtjsSnc
         Ul/4qKyIF0dkSrTzo8ueYnwHlqRvEobM3ydJMKNEVkF5A8pOKX236F83Lo5OFBNJjI4G
         B7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=62nDTy6qKxNjZuFKmMcolNmapdGOF8KUclifVF9s4ss=;
        b=WpbTHY8d6JfgCpaWwJrn8IP0NtvCBphuyfwcU397K3apsr7TSyIjReTk6mxULu3ixz
         JoCRNorgRO6ORQpSOrTFD6XLPFBROryM4Yb+kDOCjvlviFkAgongfE9p/c1htcRJ2imR
         xLxhb0H/e/mU/h43Uq1Te/K4mdYVcfoBSwJLvJd680+6H1sCvnPYeeZ9Y21bRUFn57/D
         eN8HZu3BCXcJ4QIuBem1b1sK1dDV87E5aAxLhwCBuqKvGok77wn9YDpwrAomPw1N5ppz
         Vmwkl1skqk9jVM4Za38h5qlOmE9YOHrTrbDaK8INBKPngBejZpdyTeA3UsgCuVGS+YkN
         fdgQ==
X-Gm-Message-State: AHQUAuZcwoJ+/XseK4MMofkjl1EKz5ZtKOlbnzlhbkNd5QYrREZErp/O
        uQtwUmZyR9C99IvTZY7W43OVwWnO1b8=
X-Google-Smtp-Source: AHgI3IYxru3ZrL2lNeqZf3WvyL1c52PiKiWmKcMEg/7GtPj/cOOYo3VANs5J7z2K7LnD/KVy1qP8Eg==
X-Received: by 2002:a05:660c:b43:: with SMTP id m3mr306993itl.126.1549660078733;
        Fri, 08 Feb 2019 13:07:58 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id s184sm1686900itb.44.2019.02.08.13.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 13:07:58 -0800 (PST)
Date:   Fri, 8 Feb 2019 05:01:12 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Drivers: hv: vmbus: Display nothing in sysfs if
 monitor_allocated not set
Message-ID: <52d58fe5805f2ba2405c9091b4c86033d434d2b9.1549619051.git.kimbrownkd@gmail.com>
References: <cover.1549619051.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549619051.git.kimbrownkd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If monitor pages are not allocated to a channel, the channel does not
have a valid monitor id or valid monitor page data. In these cases, some
of the "_show" functions display incorrect data. The "_show" functions
that display monitor page data access and display data that is beyond
the bounds of the hv_monitor_page array fields, which is obviously
incorrect. The "_show" functions that display the monitor id display an
invalid monitor id.

The "channel->offermsg.monitor_allocated" value can be used to determine
whether monitor pages have been allocated to a channel. In the affected
"_show" functions, verify that "channel->offermsg.monitor_allocated" is
set before accessing the monitor id or the monitor_page data. If
"channel->offermsg.monitor_allocated" is not set, display nothing.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---
 Documentation/ABI/stable/sysfs-bus-vmbus |  9 ++++--
 drivers/hv/vmbus_drv.c                   | 37 ++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
index 3fed8fdb873d..af52be4ffc5d 100644
--- a/Documentation/ABI/stable/sysfs-bus-vmbus
+++ b/Documentation/ABI/stable/sysfs-bus-vmbus
@@ -81,7 +81,8 @@ What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/latency
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
-Description:	Channel signaling latency
+Description:	Channel signaling latency. If monitor pages are not allocated
+		to the channel, nothing is displayed.
 Users:		Debugging tools
 
 What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/out_mask
@@ -95,7 +96,8 @@ What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/pending
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
-Description:	Channel interrupt pending state
+Description:	Channel interrupt pending state. If monitor pages are not
+		allocated to the channel, nothing is displayed.
 Users:		Debugging tools
 
 What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/read_avail
@@ -137,7 +139,8 @@ What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/monitor_id
 Date:		January. 2018
 KernelVersion:	4.16
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
-Description:	Monitor bit associated with channel
+Description:	Monitor bit associated with channel. If monitor pages are not
+		allocated to the channel, nothing is displayed.
 Users:		Debugging tools and userspace drivers
 
 What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/ring
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index f2a79f5129d7..c88a3623be56 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -171,6 +171,10 @@ static ssize_t monitor_id_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+
+	if (!hv_dev->channel->offermsg.monitor_allocated)
+		return sprintf(buf, "\n");
+
 	return sprintf(buf, "%d\n", hv_dev->channel->offermsg.monitorid);
 }
 static DEVICE_ATTR_RO(monitor_id);
@@ -232,6 +236,10 @@ static ssize_t server_monitor_pending_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+
+	if (!hv_dev->channel->offermsg.monitor_allocated)
+		return sprintf(buf, "\n");
+
 	return sprintf(buf, "%d\n",
 		       channel_pending(hv_dev->channel,
 				       vmbus_connection.monitor_pages[0]));
@@ -246,6 +254,10 @@ static ssize_t client_monitor_pending_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+
+	if (!hv_dev->channel->offermsg.monitor_allocated)
+		return sprintf(buf, "\n");
+
 	return sprintf(buf, "%d\n",
 		       channel_pending(hv_dev->channel,
 				       vmbus_connection.monitor_pages[1]));
@@ -260,6 +272,10 @@ static ssize_t server_monitor_latency_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+
+	if (!hv_dev->channel->offermsg.monitor_allocated)
+		return sprintf(buf, "\n");
+
 	return sprintf(buf, "%d\n",
 		       channel_latency(hv_dev->channel,
 				       vmbus_connection.monitor_pages[0]));
@@ -274,6 +290,10 @@ static ssize_t client_monitor_latency_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+
+	if (!hv_dev->channel->offermsg.monitor_allocated)
+		return sprintf(buf, "\n");
+
 	return sprintf(buf, "%d\n",
 		       channel_latency(hv_dev->channel,
 				       vmbus_connection.monitor_pages[1]));
@@ -288,6 +308,10 @@ static ssize_t server_monitor_conn_id_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+
+	if (!hv_dev->channel->offermsg.monitor_allocated)
+		return sprintf(buf, "\n");
+
 	return sprintf(buf, "%d\n",
 		       channel_conn_id(hv_dev->channel,
 				       vmbus_connection.monitor_pages[0]));
@@ -302,6 +326,10 @@ static ssize_t client_monitor_conn_id_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+
+	if (!hv_dev->channel->offermsg.monitor_allocated)
+		return sprintf(buf, "\n");
+
 	return sprintf(buf, "%d\n",
 		       channel_conn_id(hv_dev->channel,
 				       vmbus_connection.monitor_pages[1]));
@@ -1469,6 +1497,9 @@ static VMBUS_CHAN_ATTR(cpu, S_IRUGO, show_target_cpu, NULL);
 static ssize_t channel_pending_show(const struct vmbus_channel *channel,
 				    char *buf)
 {
+	if (!channel->offermsg.monitor_allocated)
+		return sprintf(buf, "\n");
+
 	return sprintf(buf, "%d\n",
 		       channel_pending(channel,
 				       vmbus_connection.monitor_pages[1]));
@@ -1478,6 +1509,9 @@ static VMBUS_CHAN_ATTR(pending, S_IRUGO, channel_pending_show, NULL);
 static ssize_t channel_latency_show(const struct vmbus_channel *channel,
 				    char *buf)
 {
+	if (!channel->offermsg.monitor_allocated)
+		return sprintf(buf, "\n");
+
 	return sprintf(buf, "%d\n",
 		       channel_latency(channel,
 				       vmbus_connection.monitor_pages[1]));
@@ -1499,6 +1533,9 @@ static VMBUS_CHAN_ATTR(events, S_IRUGO, channel_events_show, NULL);
 static ssize_t subchannel_monitor_id_show(const struct vmbus_channel *channel,
 					  char *buf)
 {
+	if (!channel->offermsg.monitor_allocated)
+		return sprintf(buf, "\n");
+
 	return sprintf(buf, "%u\n", channel->offermsg.monitorid);
 }
 static VMBUS_CHAN_ATTR(monitor_id, S_IRUGO, subchannel_monitor_id_show, NULL);
-- 
2.17.1

