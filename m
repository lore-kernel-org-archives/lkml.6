Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C99ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C72020877
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMc5Q5bY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C72020877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388251AbeIUCOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:14:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36702 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeIUCOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:14:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id j192-v6so885768wmj.1;
        Thu, 20 Sep 2018 13:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yNn4v0/RQJnn/jjCb6qmWqjFKUoVQPryB4wy16zI1hE=;
        b=lMc5Q5bYmdvcbjIxzI5usSe7HCpjVrJ7vMp3cwZFX/vVAlE18ReFWsz/th3A/leBor
         I2ubzIwTopWccAIPuXM6Lkg/QNYGz+DZDLpDD5xpET13wzjPfzPNEbsrDGZMRUwoMYHl
         1GfKMUTp+HtrUWRqYeQ+aS0UFwdYUXFfw3eQxAYjgskKnEDAdDXTazBOU6x4umBFlyyB
         DZQCh5sMq3PsZhCO2x274ukvn+jyCVATixdZDvoCxkIY7L9/O6ECAylq/ny8hLZtCWbC
         jukBr1O5U2bY7Ymvf3p6hAlDMWHSRQwMpAiHV+yup4zzvR+vxIcImdQN6vmMUMRCX6NO
         0FUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yNn4v0/RQJnn/jjCb6qmWqjFKUoVQPryB4wy16zI1hE=;
        b=h04JHOc0fqJj3Y7gE2f4aNHemYXP+tFyGrndNJZYZHNstPxCTwk2NaGbeTF6mdOdX7
         o9+xImQ8jrwdKbp5qFpzTTE1d2ZBymteg48zovMtKvbiHCmwR5c+0zlRWSAhfoi9tPfG
         mIAZNsactLkOLCgwnlQE2z851+VSA/F5JA5VdWcQwd+q12V4aKuP8EbF6IYXIbHscdiF
         WPcaj7/mNbGu/vJ31YU+CN+Ld0MhVRwJygRUIMCExCGlGpWQy+7uCHM1zNqx3JAzhF1a
         viZnCZb9QnTruf1PHbOjUMHpHDl7HPsXVjqfE1170seert1+vvgN2e8wXKSg5Kq7uUm2
         TIUA==
X-Gm-Message-State: APzg51CuDs/rdIMKb52enCFh+T8yINvuupyP8e4+Q+ofKnYGqwfTNuKK
        B9VCxLU7UywyAuO/5TwWQx4=
X-Google-Smtp-Source: ANB0VdZAOPGHzcemujCIrzDjMDJrpqEzhLzmlgFR6YwmcElFwxMrV5dpeaCMQ0qdu1LDAvmJUTnXUw==
X-Received: by 2002:a1c:8c0b:: with SMTP id o11-v6mr4480158wmd.11.1537475325568;
        Thu, 20 Sep 2018 13:28:45 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id r66-v6sm4007968wmb.37.2018.09.20.13.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:28:44 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] usb: gadget: udc: Remove unnecessary parentheses
Date:   Thu, 20 Sep 2018 13:28:13 -0700
Message-Id: <20180920202812.29158-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when multiple pairs of parentheses are used for a single
conditional statement.

drivers/usb/gadget/udc/mv_udc_core.c:188:33: warning: equality
comparison with extraneous parentheses [-Wparentheses-equality]
        while ((curr_dqh->curr_dtd_ptr == curr_dtd->td_dma)) {
                ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
drivers/usb/gadget/udc/mv_udc_core.c:188:33: note: remove extraneous
parentheses around the comparison to silence this warning
        while ((curr_dqh->curr_dtd_ptr == curr_dtd->td_dma)) {
               ~                       ^                  ~
drivers/usb/gadget/udc/mv_udc_core.c:188:33: note: use '=' to turn this
equality comparison into an assignment
        while ((curr_dqh->curr_dtd_ptr == curr_dtd->td_dma)) {
                                       ^~
                                       =
1 warning generated.

Link: https://github.com/ClangBuiltLinux/linux/issues/120
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/usb/gadget/udc/mv_udc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
index 95f52232493b..cafde053788b 100644
--- a/drivers/usb/gadget/udc/mv_udc_core.c
+++ b/drivers/usb/gadget/udc/mv_udc_core.c
@@ -185,7 +185,7 @@ static int process_ep_req(struct mv_udc *udc, int index,
 	else
 		bit_pos = 1 << (16 + curr_req->ep->ep_num);
 
-	while ((curr_dqh->curr_dtd_ptr == curr_dtd->td_dma)) {
+	while (curr_dqh->curr_dtd_ptr == curr_dtd->td_dma) {
 		if (curr_dtd->dtd_next == EP_QUEUE_HEAD_NEXT_TERMINATE) {
 			while (readl(&udc->op_regs->epstatus) & bit_pos)
 				udelay(1);
-- 
2.19.0

