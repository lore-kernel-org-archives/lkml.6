Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1717065-1521429723-2-3091932141471580422
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
    t=1521429723; b=cqiUUAsRmeSsJyAnArulXgiPpDn5fLpjuUMkHgy1mHDgBZK
    e2VE+ZrCHZ90FD9s92ZLaxjCeYuYlUb83bhEztAWkEX3qvDdqDhGvxQjnSF/Yo9q
    haPGM+33vuhrS1FaP6pskIckq5YDDr0hOe66SEdHYie+q7ZfO575qXX1E1PYfga8
    bV3KwVwerna9YD2XWMJFZkNbUzqMXoVEa5O2i/bGrDVCw0vPy1HYFc2Ta3UiO/gE
    9linjF4SGwbogqy3PJoHVju0unJULuD1rkT135S3c0X+Oe4mQPJ3/DnCeBZNKYTJ
    76E7AuR5NvzFc29qg72UXAzjkIoawfRB5oK0ZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521429723; bh=p61dPo
    /lSzbyERCYySHHMbf1qzkblTqW/x2PKnSDojg=; b=ZbgGnUgW+FNjVq47ldYj4e
    OaSlvVIwyT5sWxy4PG79uDBVyj5EiNmr8bjy5Tj43KHN6Fs2yBSt0312bm03M7Ll
    w8K4emr5JTiVCLGXGDaFC/AvTpng1gr4oIrAXOVBrqESfvbkMTOAhVrATl3TwFn0
    WAhkezFnCrr51Rb2/E1ksgyGy0aXDzNV/Gl309cSvrZ7Q9MVbK7d+/RyVEZZyJmr
    VxWkMK4y/r5v31nVuImbE1TcTEK63nuXDXnrkfRAWh30mCeZT35/iC3isTpKxEpr
    8FWOD2g4v7DZ3JL+Z7ss0pmaSefszU+NYsp6ci0QuXPf4zGJzGPxI1whsHuyC+uw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S1755127AbeCSDVq (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 23:21:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48049 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754923AbeCSDVp (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 18 Mar 2018 23:21:45 -0400
X-UUID: 3beadd9ebd274b16b3c7da121d22c7cf-20180319
Message-ID: <1521429700.3717.31.camel@mhfsdcap03>
Subject: Re: [PATCH v2 3/3] dt-bindings: phy-mtk-tphy: add properties for U2
 slew rate calibrate
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Rob Herring <robh@kernel.org>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Date: Mon, 19 Mar 2018 11:21:40 +0800
In-Reply-To: <20180318124838.ruakamqywz4jd6jz@rob-hp-laptop>
References: <c9679bc6e969ebf0f97a01c6d1aff3bbc0e8e4f7.1520832210.git.chunfeng.yun@mediatek.com>
         <94a7d3b1240297cd0cac82df52954d0a53d50d36.1520832210.git.chunfeng.yun@mediatek.com>
         <20180318124838.ruakamqywz4jd6jz@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23728.001
X-TM-AS-Result: No-16.330000-8.000000-10
X-TMASE-MatchedRID: nVQUmLJJeyYOwH4pD14DsPHkpkyUphL9GZjaqakC/Mbm+nS9146HM6Sx
        VUPqsOdUL74reM0F4+3khxtMKpECzLBAQLqGlKivk3ewifG2MNP54F/2i/DwjQoDY6gYCVOT77/
        yANhz5Pj2vjmPQvPnDtXbOJOB4P3AlyrPeDQDh/LmAId+2bAQwuU6QztVirNpmyiLZetSf8nJ4y
        0wP1A6AEl4W8WVUOR/joczmuoPCq2UTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.330000-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23728.001
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 2018-03-18 at 07:48 -0500, Rob Herring wrote:
> On Mon, Mar 12, 2018 at 01:25:40PM +0800, Chunfeng Yun wrote:
> > Add two properties of ref_clk and coefficient used by U2 slew rate
> > calibrate which may vary on different SoCs
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
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
> 
> What are valid values? This is one cell?
Yes, one cell, integer type. If need, I'll send a new patch

Thanks
> 
> >  
> >  Required properties (port (child) node):
> >  - reg		: address and length of the register set for the port.
> > -- 
> > 1.9.1
> > 


