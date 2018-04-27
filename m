Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-288473-1524837779-2-14244915772456846640
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
    1524837778; b=UHXP7MA8C+7t8fAdq9ujmrIECPGyxtHgxWTMmr0WXAyCu2CDN0
    0BVPQ1bFwCFOscZNIIcRUYBPAjHJRiHdLtfw9JPz8l8O5tCS8Pfm/WLHa5cRaERc
    1qBbnDnd0MQS5+qMBdlg7bSCtC8pT4piNsrfvQUqsK7CkeQf6byCGhGmH5Pz1OoY
    87mkVDhLxO3M1FbUCGbhHMVz/+4Ik1+QGsbgFl4JCLy+nppaH32uCiHt6LSgqUvH
    N9zW8hdthr3AtCcVCIm7LpjS70xK4Q2H4McuM3p2n3zOolg0kvNB0vVUkMXrSTjI
    J9Mt/oYELK/d2Kz2abQn1vOJGGYEK5y5aj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524837778; bh=RprM/Er2wF/r0lb1jXOSt7G4qaLLJi
    cf7BKeXi9W3FA=; b=hUo9pIQwubvCWygQIyZ2Lano9GbsmxMtt2Rpv+M9lJ1EZb
    NbyKC7HfZ7m/1Io6nqlNbmc+eHUXPDlOm14Bt1OPRaMRDXeJBkF3BBq6zYVrUdRz
    EM007WJt5k+CiAsofSO9PRPr+DlFzk4mDzMSwJ03g3BnlgSBFW3CdxiIfLMFGkgs
    5f6X/KKkT7i5aRbCMllmE+VmwcABiQMg/5+Sm9EzvRj9StFNnG2/atA04jB/xjN1
    9kr31j8vgnsb6tPuf6buhQ+wMz7N5ChdUTjmnKzMfRiRmi98v2g1ufomvI57VsQS
    +9yxEGeQSDJ7hXf/kS6iN2qDIaGC4jLfmpueRt5g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfEPVebJPU5nNb59CEVcVDv1/UjK9+IGpR6FBwGYI8xuJBdv4QC5imvgYuob87pAA6maUifn6PsGtA09P7XQ9j8tg75gR+r0w5LyUCFAeejllYfgkCubh
    dtw5wEQfELv+1uyhuMR8vN2mCWNjhB078jhJUbm9PaJL6OMiedg0rBWbguZXrBrDswCUt8WxbTdlNyU5xaqshf7k2h4kIlia/0axWy3SmLl5GDxzi0vqReBk
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=_ua-DJzVAAAA:8 a=sozttTNsAAAA:8 a=ag1SF4gXAAAA:8 a=yQeiEY-BaBPr3-hvJPsA:9
    a=QEXdDO2ut3YA:10 a=Rns7OpQVW6Hshu8udh8j:22 a=aeg5Gbbo78KNqacMgKqU:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933415AbeD0OCw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933411AbeD0OCu (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:02:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A7A218A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>,
        Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.9 10/74] usb: musb: Fix external abort in musb_remove on omap2430
Date: Fri, 27 Apr 2018 15:58:00 +0200
Message-Id: <20180427135710.330667834@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
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
 drivers/usb/musb/musb_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2485,10 +2485,11 @@ static int musb_remove(struct platform_d
 	musb_generic_disable(musb);
 	spin_unlock_irqrestore(&musb->lock, flags);
 	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
+	musb_platform_exit(musb);
+
 	pm_runtime_dont_use_autosuspend(musb->controller);
 	pm_runtime_put_sync(musb->controller);
 	pm_runtime_disable(musb->controller);
-	musb_platform_exit(musb);
 	musb_phy_callback = NULL;
 	if (musb->dma_controller)
 		musb_dma_controller_destroy(musb->dma_controller);
