Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD53BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0F52184B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216084;
	bh=D28Gxzh+3/f0vNptvD9ENwoeO/HLQDCMcNx83HJmidI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gyNnCuhiTqru5lCH/SGVvz6sWj87/vnTzrn0DOzJ54n5oDgNwhbA2nPs4VoPi6ggZ
	 4Q9e1PBiICFgWIYZ+HwSTzW3jgHGDJSEwIjFzlXDni/npl0FUsm/WaBWcoBIEz8Exm
	 OaCCjE4prfQhLcAVzMKEnJACFGXYpZf1z05ZPGi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733124AbfAKOOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:14:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732147AbfAKOOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:14:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 980DC2177B;
        Fri, 11 Jan 2019 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216081;
        bh=D28Gxzh+3/f0vNptvD9ENwoeO/HLQDCMcNx83HJmidI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sTYrr9uFAUcdCnyDxNZEyDkWNgz8EeE+DeW6c4GK2Y8yi9q21EIyMU/LvgkCBlG0v
         Nl2qf0DqKpqnN6WcOjHB/uWIQTUrt26vRLC2r4bloRgTyvWdq88o/2ciVvPFl1Q5V2
         uO1kKSCqMAdtIlpErTzjqg/KAFIsPbgdlGwT+hRw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 06/47] Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened channels
Date:   Fri, 11 Jan 2019 15:07:51 +0100
Message-Id: <20190111130956.960900276@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111130956.170952125@linuxfoundation.org>
References: <20190111130956.170952125@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

commit fc96df16a1ce80cbb3c316ab7d4dc8cd5c2852ce upstream.

Before 98f4c651762c, we returned zeros for unopened channels.
With 98f4c651762c, we started to return random on-stack values.

We'd better return -EINVAL instead.

Fixes: 98f4c651762c ("hv: move ringbuffer bus attributes to dev_groups")
Cc: stable@vger.kernel.org
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hv/vmbus_drv.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -258,6 +258,8 @@ static ssize_t out_intr_mask_show(struct
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.current_interrupt_mask);
 }
@@ -271,6 +273,8 @@ static ssize_t out_read_index_show(struc
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.current_read_index);
 }
@@ -285,6 +289,8 @@ static ssize_t out_write_index_show(stru
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.current_write_index);
 }
@@ -299,6 +305,8 @@ static ssize_t out_read_bytes_avail_show
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.bytes_avail_toread);
 }
@@ -313,6 +321,8 @@ static ssize_t out_write_bytes_avail_sho
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.bytes_avail_towrite);
 }
@@ -326,6 +336,8 @@ static ssize_t in_intr_mask_show(struct
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.current_interrupt_mask);
 }
@@ -339,6 +351,8 @@ static ssize_t in_read_index_show(struct
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.current_read_index);
 }
@@ -352,6 +366,8 @@ static ssize_t in_write_index_show(struc
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.current_write_index);
 }
@@ -366,6 +382,8 @@ static ssize_t in_read_bytes_avail_show(
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.bytes_avail_toread);
 }
@@ -380,6 +398,8 @@ static ssize_t in_write_bytes_avail_show
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.bytes_avail_towrite);
 }


