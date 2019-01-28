Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B974FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC7620881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697398;
	bh=qVUGKLn1oZlGkSYc7fAkk1MSkxd/5KT9j5a6K6ebgIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ELuUW6J3fsBYnq4BJ0OGmVk/L3+PaLVed02xGB2pqNZmsuoJOFPoaR6M88+BP0b8J
	 Q1Z2+S2gdXt+G/y4X3Kd2ggVEW6sHaIaHh8A53oRjHzZAE7GvElOyvZZWsG8LM1lt+
	 QfrPXFuJ8795GriF8HJapa+ZJK4EHwPJXuYNaJFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfA1RnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:43:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727291AbfA1Pt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:49:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B53C92147A;
        Mon, 28 Jan 2019 15:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690597;
        bh=qVUGKLn1oZlGkSYc7fAkk1MSkxd/5KT9j5a6K6ebgIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iv8BpbWjslkEoD5jBVgU2bfvXPFmOBogQiwTabYdYwhnb6GWK9sAz0YLYKl/YG4Kx
         uGVaUrTY+qHh/D3g/xKCR5txqcXEboAxtZv8DB6E2jYhFa9Wrs7dj69J5QtWNLuETb
         +kQk9DUKOnblIQ3QNzQ3Kyo+cADDM2xCaqx6Bjt4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 135/304] usb: dwc3: trace: add missing break statement to make compiler happy
Date:   Mon, 28 Jan 2019 10:40:52 -0500
Message-Id: <20190128154341.47195-135-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 54d48183d21e03f780053d7129312049cb5dd591 ]

The missed break statement in the outer switch makes the code fall through
always and thus always same value will be printed.

Besides that, compiler warns about missed fall through marker:

drivers/usb/dwc3/./trace.h: In function ‘trace_raw_output_dwc3_log_trb’:
drivers/usb/dwc3/./trace.h:246:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
    switch (pcm) {
    ^~~~~~

Add the missing break statement to work correctly without compilation
warnings.

Fixes: fa8d965d736b ("usb: dwc3: trace: pretty print high-bandwidth transfers too")
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/trace.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/trace.h b/drivers/usb/dwc3/trace.h
index f22714cce070..f27c5cbe285c 100644
--- a/drivers/usb/dwc3/trace.h
+++ b/drivers/usb/dwc3/trace.h
@@ -251,9 +251,11 @@ DECLARE_EVENT_CLASS(dwc3_log_trb,
 				s = "2x ";
 				break;
 			case 3:
+			default:
 				s = "3x ";
 				break;
 			}
+			break;
 		default:
 			s = "";
 		} s; }),
-- 
2.19.1

