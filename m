Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2651967-1524406674-2-7702482545764149405
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406674; b=YJMVjwQKaRve/agWBIcvEzqAwvo8/Y5h17kjp3CN1NLmsVD4OG
    RY3+ug15Z/SrGvE9PQ/ifofsDNd0dv/Rx/9Q4oNkDq7z9eHrR7KaRPFtroPbrYLV
    fZx46/Clt9y7TnEAcEWb0bc9WSJYnk7n49rB/FAuEdBVqRlZ8XgXIXnlHO1+A+eI
    3u0KcmKo1AH6l51wLxjeUNNi9fQV7LxGsLTNSPjFZztajLmOwCiOLGCNplafKIQN
    T2RzWWK/eJVogHcE+qDRMyx8jrRGt+orEKV2YFVcCl63Ee4PfLHcydvE5y0+xVdR
    LldEk9ltxGTJLSLAul5J+lIFPJWiojN/5exw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406674; bh=KOxgwiUMcn+Mq8BSEvB9wHJhMubzRT
    bnHNoiOJlofYo=; b=BChS8g8uHf38/et+UGsIujpnpFe0QIPWoVELpvK12S1gDK
    lrUKYmPdPHfxXPC1/ETI35K6Cd51fq1oZKORokULZUkzvYFKUPoLS9ZHxLKX0sdL
    pXkNlt64yR3qI6ywcy5iZVLVPH4XvzexpaQofm5jA1P+EhoGrjgdPO6sTOjDJrHR
    jc89vmu9IgsEJz5fcPpnm11BaPliHXKlLIhP9q282h/TWVGw3sNb3nphHyScVDp3
    d0lSBMv7l9wd8R1fSaWn7ODBmiYSL1tTVEgAVOGGuR6e81WutnEip43HmiRevSD4
    aJy7tk6v/UZMFcWxosfPHWLij3focYqkY+S6vMpA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfDtvOKmuiG4d7YgT1IMYXBGlwd3zFy5Sv7TAHp1ZF9izrMcvIyPGqN7tZKhj44HNAPhHEo4KAVG7X4E771z3bAPdyk4xstDSP+Vs5rJK/FSJ+R+Em1pi
    9O2fNm302N/mGlD1vd2XjVs1IbydO+YEI23CHuaZGJ3XUusFnsNSF5Fj75+6GLIyTAVxZa+SBNtKn1liKO1RWCu9j7DMJKV22aFi6eJYfvkhtMTJRfcjIyJ0
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=r_1tXGB3AAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=xNf9USuDAAAA:8
    a=KKAkSRfTAAAA:8 a=ag1SF4gXAAAA:8 a=OHLDRJQjkurJtFC0YhsA:9 a=QEXdDO2ut3YA:10
    a=t8nPyN_e6usw4ciXM-Pk:22 a=AjGcO6oz07-iQ99wixmX:22 a=SEwjQc04WA-l_NiBhQ7s:22
    a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756891AbeDVORu (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:17:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58550 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757127AbeDVORs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:17:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathieu Malaterre <malat@debian.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.4 59/97] mmc: jz4740: Fix race condition in IRQ mask update
Date: Sun, 22 Apr 2018 15:53:37 +0200
Message-Id: <20180422135308.547074648@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Smith <alex.smith@imgtec.com>

commit a04f0017c22453613d5f423326b190c61e3b4f98 upstream.

A spinlock is held while updating the internal copy of the IRQ mask,
but not while writing it to the actual IMASK register. After the lock
is released, an IRQ can occur before the IMASK register is written.
If handling this IRQ causes the mask to be changed, when the handler
returns back to the middle of the first mask update, a stale value
will be written to the mask register.

If this causes an IRQ to become unmasked that cannot have its status
cleared by writing a 1 to it in the IREG register, e.g. the SDIO IRQ,
then we can end up stuck with the same IRQ repeatedly being fired but
not handled. Normally the MMC IRQ handler attempts to clear any
unexpected IRQs by writing IREG, but for those that cannot be cleared
in this way then the IRQ will just repeatedly fire.

This was resulting in lockups after a while of using Wi-Fi on the
CI20 (GitHub issue #19).

Resolve by holding the spinlock until after the IMASK register has
been updated.

Cc: stable@vger.kernel.org
Link: https://github.com/MIPS/CI20_linux/issues/19
Fixes: 61bfbdb85687 ("MMC: Add support for the controller on JZ4740 SoCs.")
Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Alex Smith <alex.smith@imgtec.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/jz4740_mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -368,9 +368,9 @@ static void jz4740_mmc_set_irq_enabled(s
 		host->irq_mask &= ~irq;
 	else
 		host->irq_mask |= irq;
-	spin_unlock_irqrestore(&host->lock, flags);
 
 	writew(host->irq_mask, host->base + JZ_REG_MMC_IMASK);
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static void jz4740_mmc_clock_enable(struct jz4740_mmc_host *host,
