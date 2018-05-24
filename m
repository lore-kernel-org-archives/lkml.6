Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162144-2-7556446085600031978
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162143; b=Dp43raQ6S8/lUoYwsIgjMYUKCM2oSTpsnVgGNLeccquFkYBnG+
    hELG3+wXc6LrmAOoiGRsUfnXAEuqw2hwsYXXjsfEMSTvS5+zwdotY3AvWnItDvyV
    6iZznrOSmlpfH9QikJxEfmwfywag56CkCJAxvxsk0eMvmotWhoUQkO2hFvbBfFyF
    qTtjJja4wXN3OZzOdkSOTkAiuqQjlTaWSdkcB+2Q8s3+u3LPtprZA49yf7FfDxIG
    8bit3cmP5LHl4SvhkXns/gS/301poa07ki9FNImlKTuX4F1SMAHnCWvEW53IJG7q
    lOSHplzdNB0ctr36ydMFphu00F+AYN4ckgAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162143; bh=LysW+YbhwH/06qfDeCtRLOyKTOQERc
    jCUn2SvRyfPuY=; b=EggvNonzJyLE6YbfKjrrZlYet/215JA1R6ZIgUlEcA6HM3
    iIYNlz9vqA1S+qyqOFjB1g4UOPufhcGW0k0WCGsb1RDAzqNmBXt262Kxe2tF5OF+
    CzI5kxOY2lYts73b1HXyx3tGp2R901F35UGTo48ps1fFciRqscLHHb7/Ya2V9LGu
    /zFgRO7Snl1Ma1NfhPd5U0xQv2bkgDRSSQdZB2s2ZzPWxU9DxLfzDdhmtBqPhDE6
    2kjCrYiHLK63jZG8syKY9r+M9VCPThrBRtTTkECShu4XBN9OfLA98GlO6fkuTN5Q
    iTgkrK30dF0qnzgBngksWSkpGQBB0vN6Hlg9zSmQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Jj3tlE5o x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Jj3tlE5o x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBkSQ60vqMV7FIEGTh9u6Tc2hBrXkmmt9hPbHN1w6E9pow46SxVFiMtqMAnKLgDUcPqgGHlzyB3cQxNyrukhEzQo6a/ARpvX1vUCbw4mBV9QD/ldponz
    rnCt2ShWMllgY4H6WRROMHd5okccCIwvq+QLWhDsTOCNblissz3UrJUTkWTln/UGt/1GRWV2qI5SoqIJtsHt9hJGGxUUrQh+ldmVFIzspaoOrJG23JSbnt61
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jIQo8A4GAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=X51Z8Hf4FAapsldMHMkA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967011AbeEXLmU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967227AbeEXJs3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:48:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Youn <johnyoun@synopsys.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Grigor Tovmasyan <tovmasya@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 40/96] usb: dwc2: host: Fix transaction errors in host mode
Date: Thu, 24 May 2018 11:38:23 +0200
Message-Id: <20180524093607.844790745@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Minas Harutyunyan <hminas@synopsys.com>

[ Upstream commit 92a8dd26464e1f21f1d869ec53717bd2c1200d63 ]

Added missing GUSBCFG programming in host mode, which fixes
transaction errors issue on HiKey and Altera Cyclone V boards.

These field even if was programmed in device mode (in function
dwc2_hsotg_core_init_disconnected()) will be resetting to POR values
after core soft reset applied.
So, each time when switching to host mode required to set this field
to correct value.

Acked-by: John Youn <johnyoun@synopsys.com>
Signed-off-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Grigor Tovmasyan <tovmasya@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/hcd.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -2268,10 +2268,22 @@ static int dwc2_core_init(struct dwc2_hs
  */
 static void dwc2_core_host_init(struct dwc2_hsotg *hsotg)
 {
-	u32 hcfg, hfir, otgctl;
+	u32 hcfg, hfir, otgctl, usbcfg;
 
 	dev_dbg(hsotg->dev, "%s(%p)\n", __func__, hsotg);
 
+	/* Set HS/FS Timeout Calibration to 7 (max available value).
+	 * The number of PHY clocks that the application programs in
+	 * this field is added to the high/full speed interpacket timeout
+	 * duration in the core to account for any additional delays
+	 * introduced by the PHY. This can be required, because the delay
+	 * introduced by the PHY in generating the linestate condition
+	 * can vary from one PHY to another.
+	 */
+	usbcfg = dwc2_readl(hsotg->regs + GUSBCFG);
+	usbcfg |= GUSBCFG_TOUTCAL(7);
+	dwc2_writel(usbcfg, hsotg->regs + GUSBCFG);
+
 	/* Restart the Phy Clock */
 	dwc2_writel(0, hsotg->regs + PCGCTL);
 
