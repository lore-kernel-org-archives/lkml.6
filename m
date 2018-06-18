Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EF9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDFE208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="abvWTwWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDFE208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754561AbeFRMe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:34:27 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38297 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754315AbeFRMeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:34:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so15245845wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 05:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vx8TlFkg5GYV7lFQXfNT+lRC4bhizL4OBcbu8QAXzh4=;
        b=abvWTwWXzTxST3/NnXfsa/MmUSDa25WbwGyx8fGbv7Dj1D6kKx+0vdPgUI8mFWOc4c
         tQGK2wnm1EGle5HRdeS++DhXchUkFtOpdsi7Z7zM+97fvHafCWguuWInWFtcVR4CrHKC
         mSVgnUJMKwhVSU7LD9OqGc4LK1me9NZG7P5OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vx8TlFkg5GYV7lFQXfNT+lRC4bhizL4OBcbu8QAXzh4=;
        b=XmKJaTN3Q3b2eyOtDoQ/CbnHZXoKos0rWn4AAZIdXpe8QseiI360DwLndkgRHJMDnt
         1IHekxpnl+NppytHdnqZVJVYNujPqZgW7K7Q14GLq95wf96ieE75ptOAuJT9aR62F+J5
         XioN4J6pUW8CSmdq7NatoQN8N9KRyfQU9LIuIb1+vL9Ly30s4nsLn5nT1iB9aryOmGEh
         924TDKcp8U03xBU9/Rr+zRj5ry0ncgzYLUrnlYE/X9sMPi4XjfovUrife6+UEolRJjrX
         k2YCYJySSe05oaRocOXhDdn0QyUw0d6o0BJ2qXxn61L+4UPovMvNxVxDG8edayI9XxCx
         oKAw==
X-Gm-Message-State: APt69E2QdrDEHBOwApQIZWhsvTl4xNfoHnsTguQAvZyE/TPVPGP1mX6I
        L51QYfoxouPnjHRPRqRgwJL5LA==
X-Google-Smtp-Source: ADUXVKIuea6gwuBUJovq6AnEahbmJIZRzmTqHXTihYiGimVbxKf/9VrnLfXJyP1dW8MMpOwhEAMnbQ==
X-Received: by 2002:a1c:e0c6:: with SMTP id x189-v6mr9088535wmg.52.1529325248046;
        Mon, 18 Jun 2018 05:34:08 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id r10-v6sm24291318wrm.66.2018.06.18.05.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jun 2018 05:34:07 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] rpmsg: smd: fix kerneldoc warnings
Date:   Mon, 18 Jun 2018 13:33:39 +0100
Message-Id: <20180618123339.24115-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180618123339.24115-1-srinivas.kandagatla@linaro.org>
References: <20180618123339.24115-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below kerneldoc warnings

qcom_smd.c:141: warning: Function parameter or member 'dev' not described in 'qcom_smd_edge'
qcom_smd.c:141: warning: Function parameter or member 'name' not described in 'qcom_smd_edge'
qcom_smd.c:141: warning: Function parameter or member 'new_channel_event' not described in 'qcom_smd_edge'
qcom_smd.c:222: warning: Function parameter or member 'qsept' not described in 'qcom_smd_channel'
qcom_smd.c:222: warning: Function parameter or member 'registered' not described in 'qcom_smd_channel'
qcom_smd.c:222: warning: Function parameter or member 'state_change_event' not described in 'qcom_smd_channel'
qcom_smd.c:222: warning: Function parameter or member 'drvdata' not described in 'qcom_smd_channel'
qcom_smd.c:737: warning: Function parameter or member 'wait' not described in '__qcom_smd_send'

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

qcom_smd.c
---
 drivers/rpmsg/qcom_smd.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 6437bbeebc91..8c6a142050f8 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -93,6 +93,8 @@ static const struct {
 
 /**
  * struct qcom_smd_edge - representing a remote processor
+ * @dev:		device associated with this edge
+ * @name:		name of this edge
  * @of_node:		of_node handle for information related to this edge
  * @edge_id:		identifier of this edge
  * @remote_pid:		identifier of remote processor
@@ -106,6 +108,7 @@ static const struct {
  * @channels_lock:	guard for modifications of @channels
  * @allocated:		array of bitmaps representing already allocated channels
  * @smem_available:	last available amount of smem triggering a channel scan
+ * @new_channel_event:	wait queue for new channel events
  * @scan_work:		work item for discovering new channels
  * @state_work:		work item for edge state changes
  */
@@ -172,10 +175,12 @@ struct qcom_smd_endpoint {
 /**
  * struct qcom_smd_channel - smd channel struct
  * @edge:		qcom_smd_edge this channel is living on
- * @qsdev:		reference to a associated smd client device
+ * @qsept:		reference to a associated smd endpoint
+ * @registered:		flag to indicate if the channel is registered
  * @name:		name of the channel
  * @state:		local state of the channel
  * @remote_state:	remote state of the channel
+ * @state_change_event:	state change event
  * @info:		byte aligned outgoing/incoming channel info
  * @info_word:		word aligned outgoing/incoming channel info
  * @tx_lock:		lock to make writes to the channel mutually exclusive
@@ -187,6 +192,7 @@ struct qcom_smd_endpoint {
  * @cb:			callback function registered for this channel
  * @recv_lock:		guard for rx info modifications and cb pointer
  * @pkt_size:		size of the currently handled packet
+ * @drvdata:		driver private data
  * @list:		lite entry for @channels in qcom_smd_edge
  */
 struct qcom_smd_channel {
@@ -726,6 +732,7 @@ static int qcom_smd_write_fifo(struct qcom_smd_channel *channel,
  * @channel:	channel handle
  * @data:	buffer of data to write
  * @len:	number of bytes to write
+ * @wait:	flag to indicate if write has ca wait
  *
  * This is a blocking write of len bytes into the channel's tx ring buffer and
  * signal the remote end. It will sleep until there is enough space available
-- 
2.16.2

