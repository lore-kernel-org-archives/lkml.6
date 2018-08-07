Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC1EC46472
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB852147E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB852147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390955AbeHGVOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:14:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34856 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389783AbeHGVOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:14:20 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CDAE53EE;
        Tue,  7 Aug 2018 18:58:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 53/85] media: siano: get rid of __le32/__le16 cast warnings
Date:   Tue,  7 Aug 2018 20:51:55 +0200
Message-Id: <20180807172359.329225145@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

[ Upstream commit e1b7f11b37def5f3021c06e8c2b4953e099357aa ]

Those are all false-positives that appear with smatch when building for
arm:

  drivers/media/common/siano/smsendian.c:38:36: warning: cast to restricted __le32
  drivers/media/common/siano/smsendian.c:38:36: warning: cast to restricted __le32
  drivers/media/common/siano/smsendian.c:38:36: warning: cast to restricted __le32
  drivers/media/common/siano/smsendian.c:38:36: warning: cast to restricted __le32
  drivers/media/common/siano/smsendian.c:38:36: warning: cast to restricted __le32
  drivers/media/common/siano/smsendian.c:38:36: warning: cast to restricted __le32
  drivers/media/common/siano/smsendian.c:47:44: warning: cast to restricted __le32
  drivers/media/common/siano/smsendian.c:47:44: warning: cast to restricted __le32
  drivers/media/common/siano/smsendian.c:47:44: warning: cast to restricted __le32
  drivers/media/common/siano/smsendian.c:47:44: warning: cast to restricted __le32
  drivers/media/common/siano/smsendian.c:47:44: warning: cast to restricted __le32
  drivers/media/common/siano/smsendian.c:47:44: warning: cast to restricted __le32
  drivers/media/common/siano/smsendian.c:67:35: warning: cast to restricted __le16
  drivers/media/common/siano/smsendian.c:67:35: warning: cast to restricted __le16
  drivers/media/common/siano/smsendian.c:67:35: warning: cast to restricted __le16
  drivers/media/common/siano/smsendian.c:67:35: warning: cast to restricted __le16
  drivers/media/common/siano/smsendian.c:84:44: warning: cast to restricted __le32
  drivers/media/common/siano/smsendian.c:84:44: warning: cast to restricted __le32
  drivers/media/common/siano/smsendian.c:84:44: warning: cast to restricted __le32
  drivers/media/common/siano/smsendian.c:84:44: warning: cast to restricted __le32
  drivers/media/common/siano/smsendian.c:84:44: warning: cast to restricted __le32
  drivers/media/common/siano/smsendian.c:84:44: warning: cast to restricted __le32
  drivers/media/common/siano/smsendian.c:98:26: warning: cast to restricted __le16
  drivers/media/common/siano/smsendian.c:98:26: warning: cast to restricted __le16
  drivers/media/common/siano/smsendian.c:98:26: warning: cast to restricted __le16
  drivers/media/common/siano/smsendian.c:98:26: warning: cast to restricted __le16
  drivers/media/common/siano/smsendian.c:99:28: warning: cast to restricted __le16
  drivers/media/common/siano/smsendian.c:99:28: warning: cast to restricted __le16
  drivers/media/common/siano/smsendian.c:99:28: warning: cast to restricted __le16
  drivers/media/common/siano/smsendian.c:99:28: warning: cast to restricted __le16
  drivers/media/common/siano/smsendian.c:100:27: warning: cast to restricted __le16
  drivers/media/common/siano/smsendian.c:100:27: warning: cast to restricted __le16
  drivers/media/common/siano/smsendian.c:100:27: warning: cast to restricted __le16
  drivers/media/common/siano/smsendian.c:100:27: warning: cast to restricted __le16

Get rid of them by adding explicit forced casts.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/common/siano/smsendian.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/media/common/siano/smsendian.c
+++ b/drivers/media/common/siano/smsendian.c
@@ -35,7 +35,7 @@ void smsendian_handle_tx_message(void *b
 	switch (msg->x_msg_header.msg_type) {
 	case MSG_SMS_DATA_DOWNLOAD_REQ:
 	{
-		msg->msg_data[0] = le32_to_cpu(msg->msg_data[0]);
+		msg->msg_data[0] = le32_to_cpu((__force __le32)(msg->msg_data[0]));
 		break;
 	}
 
@@ -44,7 +44,7 @@ void smsendian_handle_tx_message(void *b
 				sizeof(struct sms_msg_hdr))/4;
 
 		for (i = 0; i < msg_words; i++)
-			msg->msg_data[i] = le32_to_cpu(msg->msg_data[i]);
+			msg->msg_data[i] = le32_to_cpu((__force __le32)msg->msg_data[i]);
 
 		break;
 	}
@@ -64,7 +64,7 @@ void smsendian_handle_rx_message(void *b
 	{
 		struct sms_version_res *ver =
 			(struct sms_version_res *) msg;
-		ver->chip_model = le16_to_cpu(ver->chip_model);
+		ver->chip_model = le16_to_cpu((__force __le16)ver->chip_model);
 		break;
 	}
 
@@ -81,7 +81,7 @@ void smsendian_handle_rx_message(void *b
 				sizeof(struct sms_msg_hdr))/4;
 
 		for (i = 0; i < msg_words; i++)
-			msg->msg_data[i] = le32_to_cpu(msg->msg_data[i]);
+			msg->msg_data[i] = le32_to_cpu((__force __le32)msg->msg_data[i]);
 
 		break;
 	}
@@ -95,9 +95,9 @@ void smsendian_handle_message_header(voi
 #ifdef __BIG_ENDIAN
 	struct sms_msg_hdr *phdr = (struct sms_msg_hdr *)msg;
 
-	phdr->msg_type = le16_to_cpu(phdr->msg_type);
-	phdr->msg_length = le16_to_cpu(phdr->msg_length);
-	phdr->msg_flags = le16_to_cpu(phdr->msg_flags);
+	phdr->msg_type = le16_to_cpu((__force __le16)phdr->msg_type);
+	phdr->msg_length = le16_to_cpu((__force __le16)phdr->msg_length);
+	phdr->msg_flags = le16_to_cpu((__force __le16)phdr->msg_flags);
 #endif /* __BIG_ENDIAN */
 }
 EXPORT_SYMBOL_GPL(smsendian_handle_message_header);


