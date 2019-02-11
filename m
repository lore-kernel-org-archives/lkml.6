Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7BFC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE15222AB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897044;
	bh=2HTqHx6/4/EwNmBOhntyGBsMWFvHGVKkVSQxnHS4iJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rHx8ugVZVA/PjuZgZls14r6l9XfyRnuB9CJdWEUfWCKYYB1CWCNuhRBpHgciuz23c
	 KT35Y8XO++OqGNVZs+w3YuSPGvnbOF7g/YlGtuTWeQwdD8+DzL+4cok5IQ9nQFxQlg
	 7ZIitTJJQp3fk0iyGX8AqKRdw/pru3qqly2cTo6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389345AbfBKO5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:57:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389334AbfBKO5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:57:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13A80222A8;
        Mon, 11 Feb 2019 14:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897038;
        bh=2HTqHx6/4/EwNmBOhntyGBsMWFvHGVKkVSQxnHS4iJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kz33wj+R/w9suPMINKEWSEUG2P3YuD0UUz/BL5e2JgUty64JiyBs18ebgjMbBf5P1
         xinmTlgg+shLJKeSEjUMI6xNYx5m6Vp9VNhHZ3TCzAaw+LsoAVbeJziTCRNQAXMt2s
         sqUVnIGUP0Ip/2TUMGfnS/qG/P5FsvPZmPoot0TQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 070/205] usb: dwc3: trace: add missing break statement to make compiler happy
Date:   Mon, 11 Feb 2019 15:17:48 +0100
Message-Id: <20190211141833.320506250@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 6504b116da04..62ec20a26013 100644
--- a/drivers/usb/dwc3/trace.h
+++ b/drivers/usb/dwc3/trace.h
@@ -262,9 +262,11 @@ DECLARE_EVENT_CLASS(dwc3_log_trb,
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



