Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-757256-1521007808-2-5041987824075660097
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521007807; b=Oo4CLrvSRbuecLHy/ttOz0LaGxXpAIjZemELszWcU2eJEca
    OmaJL00HWPv+bRbC1rGYuUL8gFz6RrUgD5NDn1ois32MW+Qc/q1/psbuO34a7UoO
    ZvWBz6/+62VK5ZMm1Mwq2zESZ/DgKE5hkyyR1/HY5MwgHgPE0pDUJy6l4kGU+hgN
    lm4VC4Uhv9aF1JPgohJcul24m7uPMgpHdezjJao+S6/WEe8H/0EYBY/xLrOmFihI
    S4ExNKzsyUd+4zQ22Yp3EHjiexo33wNJFzEbfCF+qlia6YrUfnqb71bsVZIKnoi3
    TIedYgohWMvdZQwYPNd+6N53UA1i2WgGKIchhGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521007807; bh=RhGvHt
    Uca5IwmBZl8GYrypF7VcjrHoTHEyJLSWdhsrs=; b=SP1nHUxwhaVzD7e3qZWuMg
    j6kEQxjc0R2AMwTIi+sBK0wKcckEBSyKFmW/kDh5FCCBn6VJAOET3TGutRH+HPZg
    3L5u1QC7ZJvWkKfUU7ky3VtRIEc4l+jung/o6YM731IFopNL3f9tTLFBJjZDI3lE
    q14XekPN25ipVK062Lbsecb5zxNH0SkRhIVbkfsPChh3UB70KwIoafPoG5mEz8yG
    4rbdP9yHOSWwvBcpuTvfuj3hgEmAi3hS9Bs8GS2VUCnHt9HkwpWWvVni89OleDps
    wofg4vNflR/QZGq8CpxbZ9VMyWRYWdFxfkThy7tb04iNB7E0X0MtcwDkyDMUmASw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
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
        id S1753457AbeCNGJ5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 02:09:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48746 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751426AbeCNGJz (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Mar 2018 02:09:55 -0400
X-UUID: 4fe3b627bebc4ac0aa8c5be6f89e7bce-20180314
Message-ID: <1521007784.3717.17.camel@mhfsdcap03>
Subject: Re: [PATCH v2 3/3] dt-bindings: phy-mtk-tphy: add properties for U2
 slew rate calibrate
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
Date: Wed, 14 Mar 2018 14:09:44 +0800
In-Reply-To: <6810b7b4-3023-2e76-5fbf-7e442067cbc4@gmail.com>
References: <c9679bc6e969ebf0f97a01c6d1aff3bbc0e8e4f7.1520832210.git.chunfeng.yun@mediatek.com>
         <94a7d3b1240297cd0cac82df52954d0a53d50d36.1520832210.git.chunfeng.yun@mediatek.com>
         <6810b7b4-3023-2e76-5fbf-7e442067cbc4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23718.005
X-TM-AS-Result: No-11.509200-8.000000-10
X-TMASE-MatchedRID: +c13yJDs900OwH4pD14DsPHkpkyUphL9dfsypiTqGpue9toQ6h6LE8et
        ivb6XlQxVLAL3FuHjSBXU7bEYKDEo6aTtydHAivJA9lly13c/gF6zDxGcFEbCkdmDSBYfnJR+qd
        Y5YSwCQKshiSAqXrY5dJHai6GfGFVTX7PJ/OU3vKDGx/OQ1GV8t0H8LFZNFG73Yq8RVaZivVMni
        QJDyIcZcm8Azq5bikSpfu1p3Hgw8CKr+GLbB+ln3bLSUfGiV5f
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.509200-8.000000
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
> > Add two properties of ref_clk and coefficient used by U2 slew rate
> > calibrate which may vary on different SoCs
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
Thanks again

> > ---
> >  Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> > index 41e09ed..0d34b2b 100644
> > --- a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> > +++ b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> > @@ -27,6 +27,10 @@ Optional properties (controller (parent) node):
> >   - reg		: offset and length of register shared by multiple ports,
> >  		  exclude port's private register. It is needed on mt2701
> >  		  and mt8173, but not on mt2712.
> > + - mediatek,src-ref-clk-mhz	: frequency of reference clock for slew rate
> > +		  calibrate
> > + - mediatek,src-coef	: coefficient for slew rate calibrate, depends on
> > +		  SoC process
> >  
> >  Required properties (port (child) node):
> >  - reg		: address and length of the register set for the port.
> > 


