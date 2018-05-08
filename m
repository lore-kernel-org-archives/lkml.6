Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1902174-1525741410-2-13776822114788017193
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525741410; b=SpBMpgZh6HfqZ1KKZkCfcC+AMjLG3ENPzZRKaQlsne2NUZ8CHQ
    1LS0LQ58PibL9QIe3IKqRJmYqrW09CafMwLbO/nwxBo94QaMTS2lTufTu4YAvLkk
    KKq64xngTKusqZQ7ESk0onEqUV7dXGpbDg1qEAJDT23S5qvckDpq+NlMRoEjTpPo
    tAurmWx9Ou6nYQhWaUwsqtbPL4WTQCjI5QMlJWBkHXzxhQlVXgphvbDPQbcdWN9Q
    txGqGhDox7/ixyPQI+1rZBFb9yNs+NxbgKJrsEZq6csjjX7HHtIbyagU9O0uX3KY
    5dy5BerSv5rXayuZdu3mmJ8ylhdsvvwCVaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1525741410; bh=7q3Ir2vEcI
    LKBF2n9MPtFVXMjYwHbSDgZfJydR50Ems=; b=e0BaijrBTuTzB5pN3dlviIg327
    noX0w76CTJJwL1wmUG28pV0DCyCxmLuI2nfr4gNmD98h0iNmLQQLwMqwNgXZCvIq
    yW3OLTRL90Ksn+wMtNGUxspbJzjs8J0DYYakVlTxZdwiv/Men9ld5Ytq/OKpbjiM
    DillyHhjBChwP8udoPykdOrQF7+QAeo+XlAbqKOYUL5yTnh0L4GGZZE0Xx91xUAS
    pISx1isbOJSTHT1XNd8b/Tn43HXcRVITNBqiGUIA6AotIBSvCVSW4ee3XyC5xlFp
    2w1bMj8XbA8BpR0hu9s/KwCp2z3gyD4X3lAa3tWVKPsNT3BegbWE5lK6SU0w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mediatek.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mediatek.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHo1znM1tkLeodA1dlaFMyLpwYCDn9WQZRtKbEOfJqFBs8eQjOCk8LYVX0HyLbYu6CiHk5V8Bp1owmKhzEWjlJb82+1I1kmnMJuIYMTDIMxI48Z520TF
    fZznBdkYS5C97e7LCmLo3l/vYIGMQXVglYoCEodLUwNEotkxG9Q2Dh0z+5PIYqvPdebQY7LNsFfS1fx8Znmvx3FG+SxgDhvyQfmc9zzLu7/xQ3RClV5dfPuv
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=mpaa-ttXAAAA:8 a=VwQbUJbxAAAA:8 a=EVuLViqO8ugqqSZJ_JgA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753496AbeEHBDR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 21:03:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:61114 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752954AbeEHBDQ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 7 May 2018 21:03:16 -0400
X-UUID: e0d89202f1fc48d594a392cd3a343711-20180508
Message-ID: <1525741389.25162.37.camel@mhfsdcap03>
Subject: Re: [PATCH v2 1/2] dt-bindings: add MediaTek XS-PHY binding
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
Date: Tue, 8 May 2018 09:03:09 +0800
In-Reply-To: <20180507170435.GA14540@rob-hp-laptop>
References: <1525486506-19301-1-git-send-email-chunfeng.yun@mediatek.com>
         <1525486506-19301-2-git-send-email-chunfeng.yun@mediatek.com>
         <20180507170435.GA14540@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-05-07 at 12:04 -0500, Rob Herring wrote:
> On Sat, May 05, 2018 at 10:15:05AM +0800, Chunfeng Yun wrote:
> > Add a DT binding documentation of XS-PHY for MediaTek SoCs
> > with USB3.1 GEN2 controller
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  .../devicetree/bindings/phy/phy-mtk-xsphy.txt      |  110 ++++++++++++++++++++
> >  1 file changed, 110 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
> > new file mode 100644
> > index 0000000..9a95fab
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
> > @@ -0,0 +1,110 @@
> > +MediaTek XS-PHY binding
> > +--------------------------
> > +
> > +The XS-PHY controller supports physical layer functionality for USB3.1
> > +GEN2 controller on MediaTek SoCs.
> > +
> > +Required properties (controller (parent) node):
> > + - compatible	: should be "mediatek,<soc-model>-xsphy", "mediatek,xsphy",
> > + 		  soc-model is the name of SoC, such as mt2712 etc;
> > +		  when using "mediatek,xsphy" compatible string, you need SoC specific
> > +		  ones in addition, one of:
> > +		  - "mediatek,mt3611-xsphy"
> 
> What about mt2712 you mention above?
Sorry, forgot to modify it



