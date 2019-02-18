Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EA5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0282421901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499621;
	bh=i+YysaGLcTqhLArrBrlzFq4PKpn19KfPQ2432w50jvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PXGSAC2f8JB2mQcZ6E9ipENeNjAxn2nRwbC/Alglldw78eG1K+wwK3K63CL+L0UeX
	 HlOKhXeO6RStqnvr7Uor/gEfteBYELZ6yl36Rq11pSwqgNUuYBLtJ8gsYx/EqZ5/Q2
	 USyJX3d7HLo6gXOZjQ7ZG55eKz9ztBAbeL+v9uMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390709AbfBROHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:07:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390598AbfBROHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:07:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A8F021902;
        Mon, 18 Feb 2019 14:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498851;
        bh=i+YysaGLcTqhLArrBrlzFq4PKpn19KfPQ2432w50jvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GH9XNxbMEHzgLuQfhrkqeRSgg1Sgwg3wMM4t1uIYyN2LMUncdIGbHr3ca3/avEaqE
         RA2aZIfxpwSAhixSz5Tki0KFs/E67QC2JkRpyPTUeC2+OAxr4ZfyHUleQ1I+Rk83qF
         urk96ImuqOVzwgtKczXfcvoS7nBTlhdSxMgBcOIs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Youn <johnyoun@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.4 142/143] usb: dwc2: Remove unnecessary kfree
Date:   Mon, 18 Feb 2019 14:44:30 +0100
Message-Id: <20190218133534.157549788@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Youn <johnyoun@synopsys.com>

commit cd4b1e34655d46950c065d9284b596cd8d7b28cd upstream.

This shouldn't be freed by the HCD as it is owned by the core and
allocated with devm_kzalloc.

Signed-off-by: John Youn <johnyoun@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc2/hcd.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -3164,7 +3164,6 @@ error3:
 error2:
 	usb_put_hcd(hcd);
 error1:
-	kfree(hsotg->core_params);
 
 #ifdef CONFIG_USB_DWC2_TRACK_MISSED_SOFS
 	kfree(hsotg->last_frame_num_array);


