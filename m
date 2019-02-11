Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB1AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0742081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896210;
	bh=SAeLAm5PeH+1GWPaYXR9abfCDUr9SJaSc6jDaRoPQ6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vO63LUpo+n6QMl/6QAPK7pc0zhg8c6LfBf2Kr61Kyij1RVleulM18P47pk2tnoR6F
	 LvTSWTgAAl7/n9WDjxhEMsX8L0s+T7gBlnchnUaxxSXMG7R//dQ32nrr2qrS0K9vnt
	 wBA+TqSjgWr90yYunccN4+8+lH1HojnBAqAarh2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732641AbfBKOn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:43:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731692AbfBKOn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:43:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D47320700;
        Mon, 11 Feb 2019 14:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896206;
        bh=SAeLAm5PeH+1GWPaYXR9abfCDUr9SJaSc6jDaRoPQ6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZPyPNGcQmUknp8+hGp9ZhcpfS1s/y9p7qZX18D1wfgHVeRDa2Q3T+E06s2c3/aqa
         M2tKESOnETAZ2yxpbiV0uTLk218a2JjeY3a+QskAiJ83oNpctkRv8PZxR6RAeknEz6
         NpvykxVpUPDHCtKPEBYqz64qxwEmHxMRfP6H1IIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 107/313] usb: dwc3: trace: add missing break statement to make compiler happy
Date:   Mon, 11 Feb 2019 15:16:27 +0100
Message-Id: <20190211141901.009094132@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



