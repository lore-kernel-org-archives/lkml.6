Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-196919-1522174208-2-2782874230084695507
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522174207; b=dy/zFlSg1NKnnRIRi1nS/+pfWp+5r+CaqUCDT4zNvmCmNxo
    bSR/W++nn/3Vsj2xGHsDXlG3RZO1l8xU0ZXetjVUX+FGEktKNCmQ0ZG3E8mOw1Mp
    OOTvQnKIDuNtfEIGufytCLKj/9JuTy3KLsAmEhElcni6oR5eCmF4LIYPWOMuEmHS
    UKKhnNwloH/q7BVfOL+FdXM0mWLr26QN2K+etFaIaBfXo+6HcDbudh2pVUVFOGVR
    9J6YZaoJJV1/ozNjexbwkg9nXB9+hAq7bTZb+9GJRJhiH+MBMoJD+8OuvmTz4ald
    Ui/VrFIJNM0ccVMtvEjNNwOEOO1ju/NFf3bfB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522174207; bh=Fs97jmfD2jTghTzT1oZZDUYpge
    WPyIF+lfiR0AhGXaI=; b=Shhp+VJoKaNhfwdxUXTZ138UbEIddZF9LwrBs0mUnN
    Blm1dLm67YKartiLDr+BB07U/Y82Ji9SqG2kvbcKdwm+/ajV7qPpAcVA+p6qel8p
    CQl+AZphOipELyDfkKLEPqB9m2w/UibrNr4thG9byHZvMEOnUAfNrlo9pF3hfJ48
    D1LZI+01Iu4DM3XBVXDFx6ssh8tbaPjSNNU/YCEtse1W+n1QkvzTTKDHiUBfu5mA
    TNbRwqVUBfXlEgQQ8sFddi7wXjbkrmfmdZDVsjPrRN/t1yWvGxEliF61GYbVyyCn
    3ikUpraVBtLAF3drqQMW1ywePEHAImSFPvTV6DNvaRwg==
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
X-CM-Envelope: MS4wfCYTiotU++IxySI8qAjxQZlX36/SvyakEDQTke+7ZIvkFotSm07Q1IRYkmrdBNP+5V0tBqY/X4IC6nD192wf1e82ZfoteosJVtNpv2kNDsP7K4Glz0aE
    acCyRdJ9f3yJ4w+eRgmChM+ro8xNIhNW/qbSg2xWl6I8iRS2EUHti3+U0CkoCQniVkOFXmSbhmqc9feKHvnImP/MDtQJkt7EAVn6pKRnB5e1m6ISSpLcJkTW
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=jIQo8A4GAAAA:8 a=OLL_FvSJAAAA:8 a=hD80L64hAAAA:8 a=KKAkSRfTAAAA:8
    a=pGLkceISAAAA:8 a=swAopTDVAAAA:8 a=s8YR1HE3AAAA:8 a=JfrnYn6hAAAA:8
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=tx-7FU9CT9x96Qptg_YA:9 a=QEXdDO2ut3YA:10
    a=0KMOXkhEblYA:10 a=9XRSPK5MnBQA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
    a=oIrB72frpwYPwTMnlWqB:22 a=cvBusfyB2V15izCimMoJ:22 a=7aPqbiTMDNvH6kBvy-t8:22
    a=jGH_LyMDp9YhSvY-UuyI:22 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbeC0SKG (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 14:10:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41014 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeC0Q2z (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:28:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evgeniy Didin <Evgeniy.Didin@synopsys.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH 4.4 07/43] mmc: dw_mmc: fix falling from idmac to PIO mode when dw_mci_reset occurs
Date: Tue, 27 Mar 2018 18:27:11 +0200
Message-Id: <20180327162716.785119151@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
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

From: Evgeniy Didin <Evgeniy.Didin@synopsys.com>

commit 47b7de2f6c18f75d1f2716efe752cba43f32a626 upstream.

It was found that in IDMAC mode after soft-reset driver switches
to PIO mode.

That's what happens in case of DTO timeout overflow calculation failure:
1. soft-reset is called
2. driver restarts dma
3. descriptors states are checked, one of descriptor is owned by the IDMAC.
4. driver can't use DMA and then switches to PIO mode.

Failure was already fixed in:
https://www.spinics.net/lists/linux-mmc/msg48125.html.

Behaviour while soft-reset is not something we except or
even want to happen. So we switch from dw_mci_idmac_reset
to dw_mci_idmac_init, so descriptors are cleaned before starting dma.

And while at it explicitly zero des0 which otherwise might
contain garbage as being allocated by dmam_alloc_coherent().

Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: <stable@vger.kernel.org> # 4.4+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/dw_mmc.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -619,6 +619,7 @@ static int dw_mci_idmac_init(struct dw_m
 					(sizeof(struct idmac_desc_64addr) *
 							(i + 1))) >> 32;
 			/* Initialize reserved and buffer size fields to "0" */
+			p->des0 = 0;
 			p->des1 = 0;
 			p->des2 = 0;
 			p->des3 = 0;
@@ -640,6 +641,7 @@ static int dw_mci_idmac_init(struct dw_m
 		     i++, p++) {
 			p->des3 = cpu_to_le32(host->sg_dma +
 					(sizeof(struct idmac_desc) * (i + 1)));
+			p->des0 = 0;
 			p->des1 = 0;
 		}
 
@@ -2807,8 +2809,8 @@ static bool dw_mci_reset(struct dw_mci *
 	}
 
 	if (host->use_dma == TRANS_MODE_IDMAC)
-		/* It is also recommended that we reset and reprogram idmac */
-		dw_mci_idmac_reset(host);
+		/* It is also required that we reinit idmac */
+		dw_mci_idmac_init(host);
 
 	ret = true;
 
