Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783D9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28034208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2DEpzXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28034208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754481AbeFRMeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:34:11 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46142 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754256AbeFRMeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:34:07 -0400
Received: by mail-wr0-f195.google.com with SMTP id v13-v6so16625409wrp.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8TKcrMuDrxFgkykv3aO6c7baToNKqSNkLMAlZ65S3dg=;
        b=c2DEpzXCmCl3RLYW3itIfh47FuEKZrbwebe9PTL9IKYEgCHkc3rmfHu0aLjnX1UZwe
         e5XzYov5r5WtmhtoVvKI8iCp+LEnCq0NPGdWgUhwGDPmV4qriYW+O/gHezBOdLlU1eAA
         WIGC7EZXRjeH3odc30vNyb4+ixcTJTP6SRpDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8TKcrMuDrxFgkykv3aO6c7baToNKqSNkLMAlZ65S3dg=;
        b=TDsJDERnInDiGSSzGoxtMoOol446JHAIxH65nFhSr6Peu3VdjAW3A4UpRIVb+Za8xO
         NamvqyMoCn1ABfegSDwwGxrfBlPiAh6a3jSKjTlKpwYrqZuOHCEe9ARlTJrWpiQ28zSL
         YnVfgj7p+hJrSASHFQLe/SJWn5mRTsNcclplC9ldO5r1uJqarxe+z9Nk9bIGfg/JINRx
         Iv6MXBoXxdFEKw+GDDB9HQTGwJ6wVuOPmXu+GG4Mo5VvV5GfjItelOG1z2biQysMaKFN
         o+gSbhM1s4xkzjVYGKej6jnRzTuNHsxrfVtfF/ajVpQgpKR8aNJEEGH7Wd5wP3e3oA+N
         0xwQ==
X-Gm-Message-State: APt69E1TmLcB5WI/TuiNr1AZe2PE3sEOpJpi/sf3JxPg1p+sgp1doxua
        G7yhFQ0O0BTL224tBUTgLDtGXA==
X-Google-Smtp-Source: ADUXVKJxbptleJ7FZyuvKWDKCisOTUBa9zWpX5+lHrA7iMyKl7n+bj0vn0R5ljzALr5UFHfE/0EBkg==
X-Received: by 2002:adf:afe3:: with SMTP id y35-v6mr11156570wrd.176.1529325246570;
        Mon, 18 Jun 2018 05:34:06 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id r10-v6sm24291318wrm.66.2018.06.18.05.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jun 2018 05:34:05 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] rpmsg: glink: Fix various kerneldoc warnings.
Date:   Mon, 18 Jun 2018 13:33:38 +0100
Message-Id: <20180618123339.24115-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180618123339.24115-1-srinivas.kandagatla@linaro.org>
References: <20180618123339.24115-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below kerneldoc warnings while building with W=1
qcom_glink_native.c:53: warning: Function parameter or member 'data' not described in 'glink_defer_cmd'
qcom_glink_native.c:75: warning: Function parameter or member 'data' not described in 'glink_core_rx_intent'
qcom_glink_native.c:75: warning: Function parameter or member 'id' not described in 'glink_core_rx_intent'
qcom_glink_native.c:75: warning: Function parameter or member 'size' not described in 'glink_core_rx_intent'
qcom_glink_native.c:75: warning: Function parameter or member 'reuse' not described in 'glink_core_rx_intent'
qcom_glink_native.c:75: warning: Function parameter or member 'in_use' not described in 'glink_core_rx_intent'
qcom_glink_native.c:75: warning: Function parameter or member 'offset' not described in 'glink_core_rx_intent'
qcom_glink_native.c:75: warning: Function parameter or member 'node' not described in 'glink_core_rx_intent'
qcom_glink_native.c:116: warning: Function parameter or member 'features' not described in 'qcom_glink'
qcom_glink_native.c:116: warning: Function parameter or member 'intentless' not described in 'qcom_glink'
qcom_glink_native.c:524: warning: Function parameter or member 'version' not described in 'qcom_glink_receive_version'
qcom_glink_native.c:524: warning: Function parameter or member 'features' not described in 'qcom_glink_receive_version'
qcom_glink_native.c:524: warning: Excess function parameter 'r_version' description in 'qcom_glink_receive_version'
qcom_glink_native.c:524: warning: Excess function parameter 'r_features' description in 'qcom_glink_receive_version'
qcom_glink_native.c:551: warning: Function parameter or member 'version' not described in 'qcom_glink_receive_version_ack'
qcom_glink_native.c:551: warning: Function parameter or member 'features' not described in 'qcom_glink_receive_version_ack'
qcom_glink_native.c:551: warning: Excess function parameter 'r_version' description in 'qcom_glink_receive_version_ack'
qcom_glink_native.c:551: warning: Excess function parameter 'r_features' description in 'qcom_glink_receive_version_ack'
qcom_glink_native.c:570: warning: bad line:                                       wire format and transmit
qcom_glink_native.c:604: warning: Function parameter or member 'intent' not described in 'qcom_glink_advertise_intent'
qcom_glink_native.c:604: warning: Excess function parameter 'size' description in 'qcom_glink_advertise_intent'
qcom_glink_native.c:710: warning: Function parameter or member 'glink' not described in 'qcom_glink_handle_intent_req'
qcom_glink_native.c:710: warning: Function parameter or member 'cid' not described in 'qcom_glink_handle_intent_req'
qcom_glink_native.c:710: warning: Function parameter or member 'size' not described in 'qcom_glink_handle_intent_req'

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/rpmsg/qcom_glink_native.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index e4eb5a1f417a..df1d923c0db5 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -40,7 +40,7 @@ struct glink_msg {
  * struct glink_defer_cmd - deferred incoming control message
  * @node:	list node
  * @msg:	message header
- * data:	payload of the message
+ * @data:	payload of the message
  *
  * Copy of a received control message, to be added to @rx_queue and processed
  * by @rx_work of @qcom_glink.
@@ -56,12 +56,13 @@ struct glink_defer_cmd {
  * struct glink_core_rx_intent - RX intent
  * RX intent
  *
- * data: pointer to the data (may be NULL for zero-copy)
- * id: remote or local intent ID
- * size: size of the original intent (do not modify)
- * reuse: To mark if the intent can be reused after first use
- * in_use: To mark if intent is already in use for the channel
- * offset: next write offset (initially 0)
+ * @data: pointer to the data (may be NULL for zero-copy)
+ * @id: remote or local intent ID
+ * @size: size of the original intent (do not modify)
+ * @reuse: To mark if the intent can be reused after first use
+ * @in_use: To mark if intent is already in use for the channel
+ * @offset: next write offset (initially 0)
+ * @node:	list node
  */
 struct glink_core_rx_intent {
 	void *data;
@@ -89,6 +90,8 @@ struct glink_core_rx_intent {
  * @idr_lock:	synchronizes @lcids and @rcids modifications
  * @lcids:	idr of all channels with a known local channel id
  * @rcids:	idr of all channels with a known remote channel id
+ * @features:	remote features
+ * @intentless:	flag to indicate that there is no intent
  */
 struct qcom_glink {
 	struct device *dev;
@@ -512,8 +515,8 @@ static void qcom_glink_rx_done(struct qcom_glink *glink,
  * qcom_glink_receive_version() - receive version/features from remote system
  *
  * @glink:	pointer to transport interface
- * @r_version:	remote version
- * @r_features:	remote features
+ * @version:	remote version
+ * @features:	remote features
  *
  * This function is called in response to a remote-initiated version/feature
  * negotiation sequence.
@@ -538,8 +541,8 @@ static void qcom_glink_receive_version(struct qcom_glink *glink,
  * qcom_glink_receive_version_ack() - receive negotiation ack from remote system
  *
  * @glink:	pointer to transport interface
- * @r_version:	remote version response
- * @r_features:	remote features response
+ * @version:	remote version response
+ * @features:	remote features response
  *
  * This function is called in response to a local-initiated version/feature
  * negotiation sequence and is the counter-offer from the remote side based
@@ -567,7 +570,7 @@ static void qcom_glink_receive_version_ack(struct qcom_glink *glink,
 
 /**
  * qcom_glink_send_intent_req_ack() - convert an rx intent request ack cmd to
-				      wire format and transmit
+ * 	wire format and transmit
  * @glink:	The transport to transmit on.
  * @channel:	The glink channel
  * @granted:	The request response to encode.
@@ -594,7 +597,7 @@ static int qcom_glink_send_intent_req_ack(struct qcom_glink *glink,
  *			   transmit
  * @glink:	The transport to transmit on.
  * @channel:	The local channel
- * @size:	The intent to pass on to remote.
+ * @intent:	The intent to pass on to remote.
  *
  * Return: 0 on success or standard Linux error code.
  */
@@ -698,9 +701,9 @@ static void qcom_glink_handle_rx_done(struct qcom_glink *glink,
 /**
  * qcom_glink_handle_intent_req() - Receive a request for rx_intent
  *					    from remote side
- * if_ptr:      Pointer to the transport interface
- * rcid:	Remote channel ID
- * size:	size of the intent
+ * @glink:      Pointer to the transport interface
+ * @cid:	Remote channel ID
+ * @size:	size of the intent
  *
  * The function searches for the local channel to which the request for
  * rx_intent has arrived and allocates and notifies the remote back
-- 
2.16.2

