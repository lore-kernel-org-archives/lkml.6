Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D98C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 04:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A21520896
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 04:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOsFzJ4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A21520896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754671AbeFPEaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 00:30:55 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37051 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeFPEax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 00:30:53 -0400
Received: by mail-pf0-f196.google.com with SMTP id y5-v6so5745794pfn.4;
        Fri, 15 Jun 2018 21:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hzPiEcQ1NbvlbikwYjjcH6PJt0AmS2AgOtFFi12qWPQ=;
        b=GOsFzJ4JNCbZTJfo0Lpmbw0gLh9Ma248kIX9A4pL2nLyd4884ykfW7R2H4ljAHGZXJ
         KpJAKh072dn1fF8+YlQsX2gn8B6fWOIZoKHYk8a0gEN/R4XuejArkCqVRrRPmMmkVL13
         qSMedSRKfCXyuR5NG9QWA2dLp/FKJuq/YqeokO2dIyWVxYwxtT2cYkkYfDkCWUYL6x7e
         0DyRxrHP3Sc6nCYOkPRKpwTM83ZcG5vI3sCoVuGzE+iAd3B3HM2jNelkBcgmuAeh7sMT
         73NIFwBlUJ/H718zAhOpE+yonBERRYCKdi/tp/TKXlX6d7okPmPpkISJzv3MvBxDYfZ1
         1VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hzPiEcQ1NbvlbikwYjjcH6PJt0AmS2AgOtFFi12qWPQ=;
        b=KMTpHOHA8HqtePs79lc/fT+QHyL0c2d03FXbA8/fV2P97YqtxrGKx+aurmOZNgzoPB
         pXc6DdYLyf5pyUl89nrON4c9dRG6TpCnTc+eNBhMtH2aSGB/dPtj1gRQ1CgCufJGGFV3
         8IGcmnCK/MiOxjfT38paSUt7CRI7JsBPNB1OL/sqPONWQjg2Vn+1rgGPFiRuQr6SO0cT
         bHJaq90Gpz7WQFemGF6eisRm4SZ7pE6EqtMkwZ9Fvxwf+3FiluYro+4eeXvNfRbS8mrl
         YJA257d8a7onMUDCEG+JMXxOwcPtS0/zGMUf1tBV6A75aqIMkeZ0+Z0O1gpkWZnpHQV/
         vXNw==
X-Gm-Message-State: APt69E0ItthsQSpA5Z0g4ETC8RDtPIp6ivVXwKCOLca6pyR7z2XRRMU+
        Vr3j3UKtmFAaUbUIcIE4CIs=
X-Google-Smtp-Source: ADUXVKL1cMFnV91UnBiFNBnfHmwqSwhln2cptZQ6tb1c9B0bX3K7KvnZz228xmk1R1K76ihs8kbKAQ==
X-Received: by 2002:aa7:81d3:: with SMTP id c19-v6mr4931160pfn.224.1529123453265;
        Fri, 15 Jun 2018 21:30:53 -0700 (PDT)
Received: from joonhwan-virtualbox.localnet ([220.149.255.57])
        by smtp.gmail.com with ESMTPSA id r30-v6sm16160334pgn.58.2018.06.15.21.30.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 21:30:52 -0700 (PDT)
From:   "JoonHwan.Kim" <spilit464@gmail.com>
To:     alan@linux.intel.com, sakari.ailus@linux.intel.com,
        mchehab@kernel.org
Cc:     gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        aishpant@gmail.com, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] media: staging: atomisp: add a blank line after declarations
Date:   Sat, 16 Jun 2018 13:30:48 +0900
Message-ID: <2750553.3y1WJKmnP5@joonhwan-virtualbox>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix checkpatch.pl warning:
  * Missing a blank line after declarations

Signed-off-by: Joonhwan Kim <spilit464@gmail.com>
---
 drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c
index 61bd550dafb9..4c8ff1c90f63 100644
--- a/drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c
@@ -1194,6 +1194,7 @@ static int atomisp_qbuf(struct file *file, void *fh, struct v4l2_buffer *buf)
 	 */
 	if (buf->memory == V4L2_MEMORY_USERPTR) {
 		struct hrt_userbuffer_attr attributes;
+
 		vb = pipe->capq.bufs[buf->index];
 		vm_mem = vb->priv;
 		if (!vm_mem) {
@@ -1557,6 +1558,7 @@ int atomisp_stream_on_master_slave_sensor(struct atomisp_device *isp,
 	 */
 	for (i = 0; i < isp->num_of_streams; i++) {
 		int sensor_index = isp->asd[i].input_curr;
+
 		if (isp->inputs[sensor_index].camera_caps->
 				sensor[isp->asd[i].sensor_curr].is_slave)
 			slave = sensor_index;
@@ -1643,6 +1645,7 @@ static void atomisp_pause_buffer_event(struct atomisp_device *isp)
 
 	for (i = 0; i < isp->num_of_streams; i++) {
 		int sensor_index = isp->asd[i].input_curr;
+
 		if (isp->inputs[sensor_index].camera_caps->
 				sensor[isp->asd[i].sensor_curr].is_slave) {
 			v4l2_event_queue(isp->asd[i].subdev.devnode, &event);
@@ -1656,6 +1659,7 @@ static void atomisp_pause_buffer_event(struct atomisp_device *isp)
 /* invalidate. SW workaround for this is to set burst length */
 /* manually to 128 in case of 13MPx snapshot and to 1 otherwise. */
 static void atomisp_dma_burst_len_cfg(struct atomisp_sub_device *asd)
+
 {
 
 	struct v4l2_mbus_framefmt *sink;
@@ -2138,6 +2142,7 @@ int __atomisp_streamoff(struct file *file, void *fh, enum v4l2_buf_type type)
 	if (isp->sw_contex.power_state == ATOM_ISP_POWER_UP) {
 		unsigned int i;
 		bool recreate_streams[MAX_STREAM_NUM] = {0};
+
 		if (isp->isp_timeout)
 			dev_err(isp->dev, "%s: Resetting with WA activated",
 				__func__);
-- 
2.17.1




