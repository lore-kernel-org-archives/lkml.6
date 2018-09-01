Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF92C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAC42083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZvLudJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CAC42083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeIAMga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:36:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33978 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeIAMg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:36:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id f6-v6so6495625plo.1;
        Sat, 01 Sep 2018 01:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sXqnVArd76Zgg0unGNLqHjvcOP53ZMNezD1eJsDUFA0=;
        b=ZZvLudJ4H57cdY/Uo2XUCN1vdke2mcsthqQV/+qFeH8ow/k4a813p3xSV2VQehYHtn
         NijB5roo0qhnqqqhbT9Ic06PjVIDSdaIwEEdZkQ9xd78/YjIEdO1puWavjl80U7FCtP0
         QPROKBoqsIwsRqY6KQedqDCEmodICzzBHSZbk3gywAbHXREpV/oV6pBueadUCNtJoeYD
         5FtoAihqhhx5JtPc4WqkGPyKxoOym/QFvgQX8/Yr0/nt8YfeOnGybsLor76zm/iHo178
         3JFUku0QgMsIOhftbFW3bzoNlJzNSFirxBb2gOUjLExVcVQkeO1vQDBCO/hrSekn3M0g
         mONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sXqnVArd76Zgg0unGNLqHjvcOP53ZMNezD1eJsDUFA0=;
        b=jG8BVwD2cD8HsVIpUli6/mKuWUP21jprCslkEDmh3Q9KKeUFGUyaYxazb3i1YxJVCk
         ZvBjnkFNKuGR0A/ckwSEZ8cWW9iDqSuivo7aw/dpTQCc+QzyqqpHIZoyVbKT+sz3buGA
         mbEKPHyHP5ooJ2mjfM1AR7BVFav60F0orfco6EjB5khGhYdzwWdf2jfhK5pFoEglXnNZ
         z3TDvCuv5N8y6adiTJF6kQ/kF6rFlgqReOE+woc1MyOYVysCecBt9xTAmEHHuaBYzoeZ
         nXRF/UDLaGxp8qZ0NqcwvNqs3MIhXVBHlW9paCLFiNydgnG1rVJGeyjhNvUaQbWLaMJY
         fnAQ==
X-Gm-Message-State: APzg51AqQrDO8taYTl7v3tdDVzWpBx/iYbgrrHNBwIJaGGF75XwBReD5
        4et/c8a7U2gXGcHKrh9VNHg=
X-Google-Smtp-Source: ANB0VdYi7EqNjHqFqKoHX5Nv1Ttrpy97qMD4JnOAnbuN1VjTys4FPUm3umObWElbChn+sI6nlAKeyw==
X-Received: by 2002:a17:902:4124:: with SMTP id e33-v6mr19261558pld.48.1535790317609;
        Sat, 01 Sep 2018 01:25:17 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:4130:91db:5d72:621b])
        by smtp.gmail.com with ESMTPSA id y69-v6sm22891422pfd.36.2018.09.01.01.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 01:25:17 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     gregkh@linuxfoundation.org, daniel@gimpelevich.san-francisco.ca.us,
        felipe.balbi@linux.intel.com, johan@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] usb: misc: uss720: Fix two sleep-in-atomic-context bugs
Date:   Sat,  1 Sep 2018 16:25:08 +0800
Message-Id: <20180901082508.16995-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

async_complete() in uss720.c is a completion handler function for the 
USB driver. So it should not sleep, but it is can sleep according to the
function call paths (from bottom to top) in Linux-4.16.

[FUNC] set_1284_register(GFP_KERNEL)
drivers/usb/misc/uss720.c, 372:
  set_1284_register in parport_uss720_frob_control
drivers/parport/ieee1284.c, 560:
  [FUNC_PTR]parport_uss720_frob_control in parport_ieee1284_ack_data_avail
drivers/parport/ieee1284.c, 577:
  parport_ieee1284_ack_data_avail in parport_ieee1284_interrupt
./include/linux/parport.h, 474:
  parport_ieee1284_interrupt in parport_generic_irq
drivers/usb/misc/uss720.c, 116:
  parport_generic_irq in async_complete

[FUNC] get_1284_register(GFP_KERNEL)
drivers/usb/misc/uss720.c, 382: 
  get_1284_register in parport_uss720_read_status
drivers/parport/ieee1284.c, 555: 
  [FUNC_PTR]parport_uss720_read_status in parport_ieee1284_ack_data_avail
drivers/parport/ieee1284.c, 577: 
  parport_ieee1284_ack_data_avail in parport_ieee1284_interrupt
./include/linux/parport.h, 474: 
  parport_ieee1284_interrupt in parport_generic_irq
drivers/usb/misc/uss720.c, 116: 
  parport_generic_irq in async_complete

Note that [FUNC_PTR] means a function pointer call is used.

To fix these bugs, GFP_KERNEL is replaced with GFP_ATOMIC.

These bugs are found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/usb/misc/uss720.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
index de9a502491c2..69822852888a 100644
--- a/drivers/usb/misc/uss720.c
+++ b/drivers/usb/misc/uss720.c
@@ -369,7 +369,7 @@ static unsigned char parport_uss720_frob_control(struct parport *pp, unsigned ch
 	mask &= 0x0f;
 	val &= 0x0f;
 	d = (priv->reg[1] & (~mask)) ^ val;
-	if (set_1284_register(pp, 2, d, GFP_KERNEL))
+	if (set_1284_register(pp, 2, d, GFP_ATOMIC))
 		return 0;
 	priv->reg[1] = d;
 	return d & 0xf;
@@ -379,7 +379,7 @@ static unsigned char parport_uss720_read_status(struct parport *pp)
 {
 	unsigned char ret;
 
-	if (get_1284_register(pp, 1, &ret, GFP_KERNEL))
+	if (get_1284_register(pp, 1, &ret, GFP_ATOMIC))
 		return 0;
 	return ret & 0xf8;
 }
-- 
2.17.0

