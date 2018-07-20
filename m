Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD33ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C34A20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C34A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shmanahar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbeGTWmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:42:08 -0400
Received: from avasout06.plus.net ([212.159.14.18]:48150 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbeGTWmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:42:07 -0400
Received: from hairyalien ([80.229.148.18])
        by smtp with SMTP
        id gdJcfIgNrWLW2gdJdf5XEN; Fri, 20 Jul 2018 22:51:59 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=R9QF1RCXAYgA:10 a=V0UhwjhiAAAA:8 a=Sl30bxoMjtIrTcpY_UsA:9
 a=RUDhtNSIbZfff1Rf:21 a=NgfvWVyVL48Kq1Kh:21 a=_UVLBGXn8Au_dgoMdIS7:22
Received: by hairyalien (sSMTP sendmail emulation); Fri, 20 Jul 2018 22:51:56 +0100
From:   Nick Dyer <nick@shmanahar.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH v1 03/10] Input: atmel_mxt_ts - remove duplicate setup of ABS_MT_PRESSURE
Date:   Fri, 20 Jul 2018 22:51:15 +0100
Message-Id: <20180720215122.23558-3-nick@shmanahar.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720215122.23558-1-nick@shmanahar.org>
References: <20180720215122.23558-1-nick@shmanahar.org>
X-CMAE-Envelope: MS4wfJ1MMTKwftfEovGxbTU2aL2FsvGxwuxhLGvx9JiA0bMQtOa9Zlpo4xrypsmAc4oM/fnedNLtyRSknfy9mK6i0MUZUpZYM3VJdpdlBo2wN1UlzFUTZxC9
 MMWfejzdnA9kPzINfkfdmJE5UIyILKpkHd4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 9555947a2d46..dcafb812ee7e 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2055,12 +2055,6 @@ static int mxt_initialize_input_device(struct mxt_data *data)
 				     0, 255, 0, 0);
 	}
 
-	if (data->multitouch == MXT_TOUCH_MULTITOUCHSCREEN_T100 &&
-	    data->t100_aux_ampl) {
-		input_set_abs_params(input_dev, ABS_MT_PRESSURE,
-				     0, 255, 0, 0);
-	}
-
 	if (data->multitouch == MXT_TOUCH_MULTITOUCHSCREEN_T100 &&
 	    data->t100_aux_vect) {
 		input_set_abs_params(input_dev, ABS_MT_ORIENTATION,
-- 
2.17.1

