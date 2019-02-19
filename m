Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B43BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F85217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGWoiJrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfBSFiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 00:38:21 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52839 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBSFiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 00:38:20 -0500
Received: by mail-it1-f195.google.com with SMTP id r11so3420970itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 21:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ilYZg60tYK0PECjdORWVcIr1d8PImYmY8jAy7jBal6Y=;
        b=pGWoiJrVPeVK+SNlwyIhC4nX1BDcdy+m4Y2saPpCrIry0ZmKpZRczlkXm07rcGRly4
         0yVZwVirglObDOclnIg6gQC7Al1p7+Df89N4LsknO4OX72wDxwkntb9E/fmEbEQTDfSs
         UUYWlbB8d1CQc4CAxGHT+zIw9Ov7LlU6g36UPamVnlWEWCfAs9vm5jLmIGgSnFDQfkEV
         gJWJ7SAQEG2NZkuydmxZ4UuQdJCtZnWh0qAVhrAlBFB1SKjvbpiL9zMnL08ypVLmT8u3
         sSAevHzm243f6PSWdF7NdWNoAn+qBnaHBNhrdjspMl7bKpwGGqF0hApKoLaQ1i+0/LC8
         eUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ilYZg60tYK0PECjdORWVcIr1d8PImYmY8jAy7jBal6Y=;
        b=XEOMxCMVVtmhOawH6oFWmQrtYmEh6/k+Kuq1Ohrnlbcw094LzZOfGqINpJF6x4MVDf
         woEKmRz2ucRNPOV5ZnzHLwMXk9uRKfLli1J/uflxdZoyQOc+86dd7guBl2vnyCtnBCjA
         ruCBo0KVDfgSZnQs7/XAO4OSYqeqlwyiqzdqXXEFpsdOsp1JnGl2Li5lHgn386NoIunp
         +mGL/v3uMK3Szymyn5T/DjbL3/kUVp2vJH8OvbW0Q5OhFqqOjQlk/P1qSqvks4UUPmsb
         0toAGE4YAo/5MWGNLco7o5Eiz7IMPpVkD7G1qGnT2t2amWpV1cgZ7cFAJep0PQBiMkma
         OFmw==
X-Gm-Message-State: AHQUAuZ0Nd6cUUD3A15b3ZQnBCtPMS68O+nqxbV+SknChSDL6EDlVvOH
        g7MAJm0kqlvGoZwu1lzlPRM=
X-Google-Smtp-Source: AHgI3IZ4K0Z5fP3gd/e5HzylG2/fvuj6RIuCmAgWgDLPGd/jtJv6nh9Ek6PbYuJ3d3sMjas5Ody+Pg==
X-Received: by 2002:a5e:8d13:: with SMTP id m19mr14540346ioj.43.1550554699418;
        Mon, 18 Feb 2019 21:38:19 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id y190sm745946itb.26.2019.02.18.21.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 21:38:18 -0800 (PST)
Date:   Tue, 19 Feb 2019 00:38:16 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Drivers: hv: vmbus: Return -EINVAL if
 monitor_allocated not set
Message-ID: <7481d15f52427917a5f620e29308c1aa5c63f3eb.1550554279.git.kimbrownkd@gmail.com>
References: <cover.1549619051.git.kimbrownkd@gmail.com>
 <cover.1550554279.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550554279.git.kimbrownkd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two methods for signaling the host: the monitor page mechanism
and hypercalls. The monitor page mechanism is used by performance
critical channels (storage, networking, etc.) because it provides
improved throughput. However, latency is increased. Monitor pages are
allocated to these channels.

Monitor pages are not allocated to channels that do not use the monitor
page mechanism. Therefore, these channels do not have a valid monitor id
or valid monitor page data. In these cases, some of the "_show"
functions return incorrect data. They return an invalid monitor id and
data that is beyond the bounds of the hv_monitor_page array fields.

The "channel->offermsg.monitor_allocated" value can be used to determine
whether monitor pages have been allocated to a channel. In the affected
"_show" functions, verify that "channel->offermsg.monitor_allocated" is
set before accessing the monitor id or the monitor page data. If
"channel->offermsg.monitor_allocated" is not set, return -EINVAL.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---
 Documentation/ABI/stable/sysfs-bus-vmbus | 15 ++++++++--
 drivers/hv/vmbus_drv.c                   | 37 ++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
index 3fed8fdb873d..9e8a7a29b3ff 100644
--- a/Documentation/ABI/stable/sysfs-bus-vmbus
+++ b/Documentation/ABI/stable/sysfs-bus-vmbus
@@ -81,7 +81,10 @@ What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/latency
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
-Description:	Channel signaling latency
+Description:	Channel signaling latency. The monitor page mechanism is used
+		for performance critical channels (storage, network, etc.).
+		Channels that do not use the monitor page mechanism will return
+		EINVAL.
 Users:		Debugging tools
 
 What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/out_mask
@@ -95,7 +98,10 @@ What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/pending
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
-Description:	Channel interrupt pending state
+Description:	Channel interrupt pending state. The monitor page mechanism is
+		used for performance critical channels (storage, network,
+		etc.). Channels that do not use the monitor page mechanism will
+		return EINVAL.
 Users:		Debugging tools
 
 What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/read_avail
@@ -137,7 +143,10 @@ What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/monitor_id
 Date:		January. 2018
 KernelVersion:	4.16
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
-Description:	Monitor bit associated with channel
+Description:	Monitor bit associated with channel. The monitor page mechanism
+		is used for performance critical channels (storage, network,
+		etc.). Channels that do not use the monitor page mechanism will
+		return EINVAL.
 Users:		Debugging tools and userspace drivers
 
 What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/ring
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index f2a79f5129d7..0ff9a09a3f71 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -171,6 +171,10 @@ static ssize_t monitor_id_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+
+	if (!hv_dev->channel->offermsg.monitor_allocated)
+		return -EINVAL;
+
 	return sprintf(buf, "%d\n", hv_dev->channel->offermsg.monitorid);
 }
 static DEVICE_ATTR_RO(monitor_id);
@@ -232,6 +236,10 @@ static ssize_t server_monitor_pending_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+
+	if (!hv_dev->channel->offermsg.monitor_allocated)
+		return -EINVAL;
+
 	return sprintf(buf, "%d\n",
 		       channel_pending(hv_dev->channel,
 				       vmbus_connection.monitor_pages[0]));
@@ -246,6 +254,10 @@ static ssize_t client_monitor_pending_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+
+	if (!hv_dev->channel->offermsg.monitor_allocated)
+		return -EINVAL;
+
 	return sprintf(buf, "%d\n",
 		       channel_pending(hv_dev->channel,
 				       vmbus_connection.monitor_pages[1]));
@@ -260,6 +272,10 @@ static ssize_t server_monitor_latency_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+
+	if (!hv_dev->channel->offermsg.monitor_allocated)
+		return -EINVAL;
+
 	return sprintf(buf, "%d\n",
 		       channel_latency(hv_dev->channel,
 				       vmbus_connection.monitor_pages[0]));
@@ -274,6 +290,10 @@ static ssize_t client_monitor_latency_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+
+	if (!hv_dev->channel->offermsg.monitor_allocated)
+		return -EINVAL;
+
 	return sprintf(buf, "%d\n",
 		       channel_latency(hv_dev->channel,
 				       vmbus_connection.monitor_pages[1]));
@@ -288,6 +308,10 @@ static ssize_t server_monitor_conn_id_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+
+	if (!hv_dev->channel->offermsg.monitor_allocated)
+		return -EINVAL;
+
 	return sprintf(buf, "%d\n",
 		       channel_conn_id(hv_dev->channel,
 				       vmbus_connection.monitor_pages[0]));
@@ -302,6 +326,10 @@ static ssize_t client_monitor_conn_id_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+
+	if (!hv_dev->channel->offermsg.monitor_allocated)
+		return -EINVAL;
+
 	return sprintf(buf, "%d\n",
 		       channel_conn_id(hv_dev->channel,
 				       vmbus_connection.monitor_pages[1]));
@@ -1469,6 +1497,9 @@ static VMBUS_CHAN_ATTR(cpu, S_IRUGO, show_target_cpu, NULL);
 static ssize_t channel_pending_show(const struct vmbus_channel *channel,
 				    char *buf)
 {
+	if (!channel->offermsg.monitor_allocated)
+		return -EINVAL;
+
 	return sprintf(buf, "%d\n",
 		       channel_pending(channel,
 				       vmbus_connection.monitor_pages[1]));
@@ -1478,6 +1509,9 @@ static VMBUS_CHAN_ATTR(pending, S_IRUGO, channel_pending_show, NULL);
 static ssize_t channel_latency_show(const struct vmbus_channel *channel,
 				    char *buf)
 {
+	if (!channel->offermsg.monitor_allocated)
+		return -EINVAL;
+
 	return sprintf(buf, "%d\n",
 		       channel_latency(channel,
 				       vmbus_connection.monitor_pages[1]));
@@ -1499,6 +1533,9 @@ static VMBUS_CHAN_ATTR(events, S_IRUGO, channel_events_show, NULL);
 static ssize_t subchannel_monitor_id_show(const struct vmbus_channel *channel,
 					  char *buf)
 {
+	if (!channel->offermsg.monitor_allocated)
+		return -EINVAL;
+
 	return sprintf(buf, "%u\n", channel->offermsg.monitorid);
 }
 static VMBUS_CHAN_ATTR(monitor_id, S_IRUGO, subchannel_monitor_id_show, NULL);
-- 
2.17.1

