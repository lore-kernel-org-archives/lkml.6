Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-584447-1524655988-2-1654786964159509238
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES endafr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524655988; b=v0aIT/36g8Lumn5nCsw70VSgfWqaRrfQmAac5RRuz5CK+VchRq
    18vBaIU0/mrrWGHqepDzJxFp4c45P8S7IsvnA8x+nG789+/AK0AU4W7EN9e68/4c
    +dhLFL00WR5xsIOChkVmXXwuRR3fmFgSexayPGxEwmbKAtjcimc/lLLQpcoYgsQQ
    kscEAt6/9jsAokc1jsY5OzjjghSChMHMoCnEuDRMI+YdSlETWLhvqGGCqiQYpGbU
    bm4XAC+aSQhpxXUNADaC+62B1cGqeS8sLfjRXza+xI7dqvI7AlS+zxZPSO3QczCN
    dLUt8AMlUkCSbMKfaKTdTQCAfRe9IH+7T42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524655988; bh=6T0igkkuRGX655TtkJaraG5OR0DTCL
    PGXY5EnZAv/Cg=; b=oPnsAU5R4vl+hYaxASY858rLjXbcffr1GG3R2WsbkGRFyX
    H1vINdIyVJ+V44SOmqvl65tSCk+SZ/oVqdxu6ZCG+Oy/7Yjz3usqSJMSITymMSZk
    1yWTCtdURIFkYyPbfH8p1ed01Btq7vtSoAbPC9XhTSNuGKchMdoxxiaevsMDrtr3
    nnR10Yon+JR7CzJ2TSbcBpFhf3gBIgG/IFA9vIo1IePwU6uL3AC7v3zmmeThflH1
    djK5zp/XqfrANHvFX/GpgQ1RcwzGrGb/u1e7LIx2m1hiocT+Q7m6HWicqZ7h9O4I
    /joUDvoJUbfZLjnW26Q7ClQcka1KM+B74EHFSouw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJzvlwA0h2Ls8gL8pltgb2AV8t3dtsqettEM3bog3ogPVogfO0q6EVW0wpV7ug5IPBSWkquHUMCQPDL3njdRUUt4tcQM46ohJL7ERWyUodLkPYPwoD8B
    qx+r4wNxPo+qnVKc15Fylo0kT1GtqUiNaNSQvUWl7CItfEsoO8+DtgtUdVN1tzotJvKZXL0mDKeL2a2ByRXwLuUNBnmnMeAPHs5jBS8TGBzNEqcIXP82saOm
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=_ua-DJzVAAAA:8 a=sozttTNsAAAA:8 a=ag1SF4gXAAAA:8 a=yQeiEY-BaBPr3-hvJPsA:9
    a=QEXdDO2ut3YA:10 a=Rns7OpQVW6Hshu8udh8j:22 a=aeg5Gbbo78KNqacMgKqU:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753232AbeDYKhS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:37:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51076 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752928AbeDYKhQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:37:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>,
        Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.14 014/183] usb: musb: Fix external abort in musb_remove on omap2430
Date: Wed, 25 Apr 2018 12:33:54 +0200
Message-Id: <20180425103243.184020258@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Merlijn Wajer <merlijn@wizzup.org>

commit 94e46a4f2d5eb14059e42f313c098d4854847376 upstream.

This fixes an oops on unbind / module unload (on the musb omap2430
platform).

musb_remove function now calls musb_platform_exit before disabling
runtime pm.

Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2498,11 +2498,11 @@ static int musb_remove(struct platform_d
 	musb_disable_interrupts(musb);
 	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
 	spin_unlock_irqrestore(&musb->lock, flags);
+	musb_platform_exit(musb);
 
 	pm_runtime_dont_use_autosuspend(musb->controller);
 	pm_runtime_put_sync(musb->controller);
 	pm_runtime_disable(musb->controller);
-	musb_platform_exit(musb);
 	musb_phy_callback = NULL;
 	if (musb->dma_controller)
 		musb_dma_controller_destroy(musb->dma_controller);
