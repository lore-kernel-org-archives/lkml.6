Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2352240-1526373593-2-3221887134812158114
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
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526373592; b=MCgpbN2+N0DzXCD3JiNRIiWrdZwjIaBSjggLcKqwUMOh0YWiFc
    TvZBM5W3Hxo8b0X+4JzHizYVajLTCIDhC3VPJ6A92y8OZvev1eZV2/gw8CfcgUll
    /3KeywipmkB9cmPsyaROl4mO89HFIRcIAFRov5fNAp0wSIrpQ361kIN5qgBpkDHh
    hDURZKhYGfjpEvJD5RSdLozVPX1BzjGJcA9EBA32SJ8AlX5tE0Cjr0itbZNKtdH7
    DthJiDKwiV4mORVbg2QkhHw0qpE3MdmJ8az0BkYinRfRnuu/YCEDuR/Yded05wtE
    YJLovQaaibcRYI7Gw91SIGbJMJzzY7qOjycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526373592;
    bh=6M5Ypij7Sk6rRPSuOsxfZx2Dmk6SJePkePza+xYtW5w=; b=YViEeVu6KrOk
    44Mu342N6cFMSLceeqck5bvBccaNKx7Gc3HpmQySZwUnuQdhW06VE/oU5X9Y5WXm
    pmNItln1/TQBJk3kuIJRtB4rAqZ2t4QQ9AdDY9crf6vuzij8wn12rezg1Zl2A0EQ
    cSywyBbd6Hzk0Up8DEnYFvEiiy57a7JT4fG+K5FZjhbuTpkVSoRxAVrE28uJH66w
    fb5v6LsSZGJVhBJ6gHZgWbrgHrV0UQ5IfgvIc2wpn3S2ZTRsI9KyJBKBHnab81Ao
    mKRMaKsqP8REhkoTnRQ6F5OfQMTrpcSAIbU9pGAqGZkshLNuERNzHBFY6cGx7wHu
    eBnyyg0mlg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mediatek.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
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
X-CM-Envelope: MS4wfMyE6iJuEccYh14A35VViUpYrme53NR6Fbndc2J9IcIA4icgY2IeMM8Vy5u/SOrMMyp5AK7w1lgI9A0QsjqKzbJEL2bRndgBBvSMa3icg2p8Ar/N3awl
    7bWNRl+WxWckYLFL4IIcy0HzHXPDj86erEejsoAfEdijPBVD3EuVqJtLdCGqK5asVl9nT7rMc6fBaG61RNCwNMJcertBImfPc160Jgo6LyX944v6Prmg0306
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=mpaa-ttXAAAA:8 a=VwQbUJbxAAAA:8 a=rPFsBPrGOvww9quNL9wA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeEOIji (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 04:39:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:7090 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752054AbeEOIjh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 May 2018 04:39:37 -0400
X-UUID: ef886386cd1d483eabbac8d6d6b477e0-20180515
Message-ID: <1526373571.3345.3.camel@mtksdaap41>
Subject: Re: [PATCH v2 4/4] arm64: dts: Add Mediatek SoC MT8183 and
 evaluation board dts and Makefile
From: Erin Lo <erin.lo@mediatek.com>
To: Marc Zyngier <marc.zyngier@arm.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <yingjoe.chen@mediatek.com>, <mars.cheng@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Hailong Fan <Hailong.Fan@mediatek.com>
Date: Tue, 15 May 2018 16:39:31 +0800
In-Reply-To: <efa91778-e81f-9ba4-22a6-43ff0f94af4f@arm.com>
References: <1526293351-32794-1-git-send-email-erin.lo@mediatek.com>
         <1526293351-32794-5-git-send-email-erin.lo@mediatek.com>
         <efa91778-e81f-9ba4-22a6-43ff0f94af4f@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-05-14 at 11:35 +0100, Marc Zyngier wrote:
> On 14/05/18 11:22, Erin Lo wrote:
> > From: Ben Ho <Ben.Ho@mediatek.com>
> > 
> > Add basic chip support for Mediatek 8183
> > 
> > Signed-off-by: Ben Ho <Ben.Ho@mediatek.com>
> > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/Makefile       |   1 +
> >  arch/arm64/boot/dts/mediatek/mt8183-evb.dts |  31 +++++
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 178 ++++++++++++++++++++++++++++
> >  3 files changed, 210 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > 
> 
> [...]
> 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > new file mode 100644
> > index 0000000..8564a26
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> 
> [...]
> 
> > +	gic: interrupt-controller@0c000000 {
> > +		compatible = "arm,gic-v3";
> > +		#interrupt-cells = <3>;
> > +		interrupt-parent = <&gic>;
> > +		interrupt-controller;
> > +		reg = <0 0x0c000000 0 0x40000>,  // CID
> > +		      <0 0x0c100000 0 0x200000>; // CIR
> 
> You're missing the GICV and GICH regions that are present on both A53
> and A73 at an offset from PERIPHBASE.
> 
> > +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +	};
> 
> Thanks,
> 
> 	M.

I will fill out the GICV and GICH in next round.
Thanks.

Regards,
Erin


