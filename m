Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-757256-1521007747-2-16579754953916912679
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521007746; b=OKqLxrOZzfXPy2yJ3TlTsyQGIzesmT3IU/uirgA3KSHk5E4
    Ai4ln9ywPvWRZdm1oqLoH+TsotkiDmv4YLjf8C8Cx7xadkJejWoPd9FFzZRWoeo6
    eJaByHGxBpHhK+5Na2eJMISb0jDYuosPx2d9cSnlKe3gSyskIdWBnVe+Xgf6nymZ
    FReXNg0Z3z+bE/fmhlKwrCUubNbspOmz3ipkUUfJ634lW+EgCCiIdaLmq0eS5xff
    6MKruIANVkEIYYRtVaOS9v8VHFKshB8Wd9xpvBWiKTo2tfwF5CcTuuaCBGgk+5Ie
    MyrsiMbz/yk/Y7UGJ7ZgYAxzWgcm4nInrOtsRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521007746; bh=NHD4LX
    LvTOhDph7gplJ/PO8vV8EpyxG5HH5Ht/qYGv8=; b=a1XMG2vtuIGzbn+JYIE3CK
    3IuWKGG5gB0uS4X6tbL14H1fDUv1/9mHSW4ooKsK+WeCYR/VsTnfVBpcpfptFGDN
    fCEWug3iaDPOT0RJUyDjv2AggKeFPlHi8AhScwESIVFnCXWhgTf39Z1pJOR792Ms
    uwtq3jjsWZP6TTis3K78k+ueWpV2pGVmnduGsRLIwk+LA+5B2j0v/CPhNlEtZFI1
    ENv7hcPmiGiqjRy7r3YqbhTlGtqID0XZU91AEf+RD9nanMH2LvmDRIeV5JJcXWQn
    VT1p8f6OjbcZWHI3k8bwX3mN7p+SbHCKBXTCXypfknksm+Ir5OE+D378Zgrp0yFg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753293AbeCNGIw (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 02:08:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45098 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751426AbeCNGIu (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Mar 2018 02:08:50 -0400
X-UUID: 3c6772111ddc4c5d9b9fca2728f54373-20180314
Message-ID: <1521007723.3717.16.camel@mhfsdcap03>
Subject: Re: [PATCH v2 2/3] phy: phy-mtk-tphy: add configurable parameters
 for slew rate calibrate
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Date: Wed, 14 Mar 2018 14:08:43 +0800
In-Reply-To: <9abfde61-f81e-1a17-7ff9-85a7017f649b@gmail.com>
References: <c9679bc6e969ebf0f97a01c6d1aff3bbc0e8e4f7.1520832210.git.chunfeng.yun@mediatek.com>
         <123d1a24659be168d0b040de4a67612acacf66f1.1520832210.git.chunfeng.yun@mediatek.com>
         <9abfde61-f81e-1a17-7ff9-85a7017f649b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23718.005
X-TM-AS-Result: No-14.579000-8.000000-10
X-TMASE-MatchedRID: O/y65JfDwwsOwH4pD14DsPHkpkyUphL9dfsypiTqGpue9toQ6h6LEzIl
        dYjRB7C5yJgT4LTwzDJRUMNmkmV6cHBe8qvb907d5gCHftmwEMJMkOX0UoduuQqiCYa6w8tvGSv
        JVdW3xMma8V8pK2dHWjxEtja9Tw8PUBXVAm5W8RCeAiCmPx4NwLTrdaH1ZWqC1kTfEkyaZdz6C0
        ePs7A07YFInLyeDAoZGgERAt+9nZ6yi1Q6VPsFN4QkqEFWKnpPcRS7s5VhxmzM78CqMVoihQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.579000-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23718.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-03-14 at 00:21 +0100, Matthias Brugger wrote:
> 
> On 03/12/2018 06:25 AM, Chunfeng Yun wrote:
> > There are two parameters, ref_clk and coefficient, for U2 slew rate
> > calibrate which may vary on different SoCs, here allow them to be
> > configurable
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
Thanks
> 
> > ---
> >  drivers/phy/mediatek/phy-mtk-tphy.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
> > index 6073c25..38c281b 100644
> > --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> > +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> > @@ -306,6 +306,8 @@ struct mtk_tphy {
> >  	const struct mtk_phy_pdata *pdata;
> >  	struct mtk_phy_instance **phys;
> >  	int nphys;
> > +	int src_ref_clk; /* MHZ, reference clock for slew rate calibrate */
> > +	int src_coef; /* coefficient for slew rate calibrate */
> >  };
> >  
> >  static void hs_slew_rate_calibrate(struct mtk_tphy *tphy,
> > @@ -360,16 +362,17 @@ static void hs_slew_rate_calibrate(struct mtk_tphy *tphy,
> >  	writel(tmp, fmreg + U3P_U2FREQ_FMMONR1);
> >  
> >  	if (fm_out) {
> > -		/* ( 1024 / FM_OUT ) x reference clock frequency x 0.028 */
> > -		tmp = U3P_FM_DET_CYCLE_CNT * U3P_REF_CLK * U3P_SLEW_RATE_COEF;
> > -		tmp /= fm_out;
> > +		/* ( 1024 / FM_OUT ) x reference clock frequency x coef */
> > +		tmp = tphy->src_ref_clk * tphy->src_coef;
> > +		tmp = (tmp * U3P_FM_DET_CYCLE_CNT) / fm_out;
> >  		calibration_val = DIV_ROUND_CLOSEST(tmp, U3P_SR_COEF_DIVISOR);
> >  	} else {
> >  		/* if FM detection fail, set default value */
> >  		calibration_val = 4;
> >  	}
> > -	dev_dbg(tphy->dev, "phy:%d, fm_out:%d, calib:%d\n",
> > -		instance->index, fm_out, calibration_val);
> > +	dev_dbg(tphy->dev, "phy:%d, fm_out:%d, calib:%d (clk:%d, coef:%d)\n",
> > +		instance->index, fm_out, calibration_val,
> > +		tphy->src_ref_clk, tphy->src_coef);
> >  
> >  	/* set HS slew rate */
> >  	tmp = readl(com + U3P_USBPHYACR5);
> > @@ -1041,6 +1044,13 @@ static int mtk_tphy_probe(struct platform_device *pdev)
> >  		tphy->u3phya_ref = NULL;
> >  	}
> >  
> > +	tphy->src_ref_clk = U3P_REF_CLK;
> > +	tphy->src_coef = U3P_SLEW_RATE_COEF;
> > +	/* update parameters of slew rate calibrate if exist */
> > +	device_property_read_u32(dev, "mediatek,src-ref-clk-mhz",
> > +		&tphy->src_ref_clk);
> > +	device_property_read_u32(dev, "mediatek,src-coef", &tphy->src_coef);
> > +
> >  	port = 0;
> >  	for_each_child_of_node(np, child_np) {
> >  		struct mtk_phy_instance *instance;
> > 


