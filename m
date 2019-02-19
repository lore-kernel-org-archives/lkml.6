Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970F9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A32B217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2oVAUua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBSHbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:31:52 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36465 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfBSHbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:31:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id k2so651785plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 23:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=aeVLkZNBgesC+IRltdDGw/TLRa8vIRSPBiqLESkQCWY=;
        b=M2oVAUuaJNwf8FsOJV0QHgUTqac/OCdGhCpwf54UMDwBMVmR/UN+UlIyZrhmttlGS3
         uj4UTyEp/4YXow7f7s9A1fEaqigEQ5RFDfC6YWuuEVanTsRVnZBOT6VO1zgKUDblvNMM
         0mGm1ekTYL7FzLepaE27CyVmbbVHrUWGRXGk5bHC7XPkobGrbDSwLJXL1NhrcKnvAo63
         N/B6o6adlI8MrEvYE3GRcktwcF2fiiF6sCh4FHVvkXUfKLfCUMBIxo34Yep2Eg8ypbaH
         gJZSgDAn8rfCp9UOpAs7wTVhaSQo4iDSB8JfyzMDt9JvVY0PfIPIIVfDrRHkcwDpyDDA
         y8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=aeVLkZNBgesC+IRltdDGw/TLRa8vIRSPBiqLESkQCWY=;
        b=oN8o4AAsCtp7OFiEIAoh+jnezjtsyy8U04BvlxrbnyBL+tczWM07l49BmFFU+eio3K
         Y/4Vt2wXcKEyDTbCgCeCJPnQv41GeGJn5X/xV2Mn9mHxYMpzVmA/nvGE08LwZjcxcte+
         v+8vTlZETvWvZdCVTX7lv+5pVse8omWftzE+ns3y0SRJYtJnJsFwFs/46AH17gahDLty
         BpaleGLZFs4yclfERD3kPNrJ7iF1H31DrmWj63X1soUcYYyZOsx5gOtgtBLB5rUvLa19
         AsHzIvbcQRSom/dw+fqtbHxCW/FCOSBVHCa6zVxgHo1Ww66PDdLYK/ocANnbRBxHBc7s
         7+wg==
X-Gm-Message-State: AHQUAuaZ7ruERAmY0LmK16DQliZXKrnfJ271OFzk605xoleIJGQF9yJq
        LKRcItEeU+BVuEksOwth7Kx0DiYmGp2Rlg==
X-Google-Smtp-Source: AHgI3IaBL2lcnfFQ8dtKOGCz1CrYw/RzhF4Q59omUr8MD3OAuj5piPyxYDBrSNiHWjo9cvH1hVQrlA==
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr29536066pld.236.1550561511154;
        Mon, 18 Feb 2019 23:31:51 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id n27sm31556569pfb.8.2019.02.18.23.31.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Feb 2019 23:31:50 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org,
        mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     baolin.wang@linaro.org, broonie@kernel.org, lanqing.liu@unisoc.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/5] serial: sprd: Modify the baud rate calculation formula
Date:   Tue, 19 Feb 2019 15:31:11 +0800
Message-Id: <a816deaf850b3620457ab3d071345ec572c63477.1550560916.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1550560916.git.baolin.wang@linaro.org>
References: <cover.1550560916.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1550560916.git.baolin.wang@linaro.org>
References: <cover.1550560916.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lanqing Liu <lanqing.liu@unisoc.com>

When the source clock is not divisible by the expected baud rate and
the remainder is not less than half of the expected baud rate, the old
formular will round up the frequency division coefficient. This will
make the actual baud rate less than the expected value and can not meet
the external transmission requirements.

Thus this patch modifies the baud rate calculation formula to support
the serial controller output the maximum baud rate.

Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/tty/serial/sprd_serial.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 4287ca3..1891a45 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -371,7 +371,7 @@ static void sprd_set_termios(struct uart_port *port,
 	/* ask the core to calculate the divisor for us */
 	baud = uart_get_baud_rate(port, termios, old, 0, SPRD_BAUD_IO_LIMIT);
 
-	quot = (unsigned int)((port->uartclk + baud / 2) / baud);
+	quot = port->uartclk / baud;
 
 	/* set data length */
 	switch (termios->c_cflag & CSIZE) {
-- 
1.7.9.5

