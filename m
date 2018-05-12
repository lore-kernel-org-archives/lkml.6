Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-883518-1526102917-2-14866218376435622464
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526102916; b=NbwkS56uCwshopfVzoPFINJ9rL0IvkCcwEjnQOD8lDQdML0v+1
    d13TNgZUqIKvjt3cKSYwzNjApZQzAIfLFCdP5qE/f+BsYU+XefXW/zRXuLxEhan/
    CPsesHU1v9004NyIjpcz+9jqvHzKGJYKBm1E/hAS/kmdNwPr9wT4KlhuyLDzHRQ/
    H9lJ6izfXNCNlrJp9obtgpUoIehwh229eEKzyawjHEojp0HTRZL6UuVewTRfs/1M
    nLEjjsshcuENCi80nf8CUoyA5gTKrYI0CDPHRQz6TJmkkw2OtrI0rG5O3FbidYzM
    pR2RhYvxf5ZsZnreF476DA7Ehbo7P3+B8LYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1526102916; bh=LijYrHavUO
    ulVaUCTWN6VLB958UEatAjpefP3kRstWo=; b=VXHNC6+pIyalz1PGp5QvAMi8zO
    WAlzVpE0o/4NW1nym2A+pbpwBC0sIbOEVn3x/yUJwL+mRoQZp3ZcaV/NTDumN3Hg
    DLkVKHKW3ChfXYyAziPbMa/bkKZ7RqrMoa7QvSClMb7h7AVhju565sXJzAn9wICo
    6Kc6Z15URdWGyhT556V6TEvaykloWX/7X61zGVYFxv18Ma542qEK6e9SISswZEn3
    9DKLeAj4SR5uUVXqk3QV7jehFoyRTMoIl2E7nB+Kz8QMObSpzt2YWrOx1tfmz/QW
    5azVQb6ZuYRU5RgyUD9ZSBm1kiJ4MVF92VOaiDb9IeHMhMHwLTCWHOn6YBWw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mediatek.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mediatek.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPbxMd66r63Ai6M/3gfnpQ7VSPQZmTmF2nHwYb+hea3bXJYeMo3b1rWLgwgJwJvIojPUq15C8VvoSpGQUXgltIyeyxo6/pP2Hsl6hjIErXO0tHQGDe+2
    n9bfzjB2Dsggmg1MAeA7yrEXisHbuhcElwQxL/jtmG8wz1DPg59OfORMtgVUObpSzsaCbvicjbSPQzfa5gXyQ0PWCiND3Gq/Y/eqMN4vRQTyIYNNHLpoo5Ri
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=mpaa-ttXAAAA:8 a=VwQbUJbxAAAA:8 a=A5IyIl87D9e4Fvp3gY8A:9
    a=2sZMl7KEFDbnwnXk:21 a=bi9ZWk-vAxsCepgi:21 a=QEXdDO2ut3YA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750735AbeELF2c (ORCPT <rfc822;greg@kroah.com>);
        Sat, 12 May 2018 01:28:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53765 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750722AbeELF2b (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 May 2018 01:28:31 -0400
X-UUID: 0e62b9a22dd84c5fad6758f09bb4a92e-20180512
Message-ID: <1526102906.18877.42.camel@mtkswgap22>
Subject: Re: [PATCH v2 03/12] arm: dts: mt7623: fix invalid memory node
 being generated
From: Sean Wang <sean.wang@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Date: Sat, 12 May 2018 13:28:26 +0800
In-Reply-To: <4dcb0435-1f98-0753-0feb-d17ad02077ae@gmail.com>
References: <cover.1523434757.git.sean.wang@mediatek.com>
         <d887b72e1839c7e476179e384cfc712216096f20.1523434758.git.sean.wang@mediatek.com>
         <4dcb0435-1f98-0753-0feb-d17ad02077ae@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-05-11 at 17:03 +0200, Matthias Brugger wrote:
> 
> On 04/11/2018 10:53 AM, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Below two wrong nodes in existing DTS files would cause a fail boot since
> > in fact the address 0 is not the correct place the memory device locates
> > at.
> > 
> > memory {
> >         device_type = "memory";
> >         reg = <0x0 0x0 0x0 0x0>;
> > };
> > 
> > memory@80000000 {
> >         reg = <0x0 0x80000000 0x0 0x40000000>;
> > };
> > 
> > In order to avoid having a memory node starting at address 0, we can't
> > include file skeleton64.dtsi and instead need to explicitly manually
> > define a few of properties the DTS relies on such as #address-cells
> > and #size-cells in root node and device_type in the node memory@80000000.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 31ac0d69a1d4 ("ARM: dts: mediatek: add MT7623 basic support")
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > ---
> >  arch/arm/boot/dts/mt7623.dtsi                 | 3 ++-
> >  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 1 +
> >  arch/arm/boot/dts/mt7623n-rfb.dtsi            | 1 +
> >  3 files changed, 4 insertions(+), 1 deletion(-)
> > 
> 
> merged. We would need this at least for mt2701 as well, correct?
> Would you mind to provide a patch.
> 
> Regards,
> Matthias
> 

Thanks! I totally think the same problem could happen on mt2701, so I'm 
happy to come up with a patch for that.

	Sean

> > diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> > index fec4715..406a9f3 100644
> > --- a/arch/arm/boot/dts/mt7623.dtsi
> > +++ b/arch/arm/boot/dts/mt7623.dtsi
> > @@ -15,11 +15,12 @@
> >  #include <dt-bindings/phy/phy.h>
> >  #include <dt-bindings/reset/mt2701-resets.h>
> >  #include <dt-bindings/thermal/thermal.h>
> > -#include "skeleton64.dtsi"
> >  
> >  / {
> >  	compatible = "mediatek,mt7623";
> >  	interrupt-parent = <&sysirq>;
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> >  
> >  	cpu_opp_table: opp-table {
> >  		compatible = "operating-points-v2";
> > diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> > index bbf56f8..5938e4c 100644
> > --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> > +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> > @@ -109,6 +109,7 @@
> >  	};
> >  
> >  	memory@80000000 {
> > +		device_type = "memory";
> >  		reg = <0 0x80000000 0 0x40000000>;
> >  	};
> >  };
> > diff --git a/arch/arm/boot/dts/mt7623n-rfb.dtsi b/arch/arm/boot/dts/mt7623n-rfb.dtsi
> > index a199ae7..343e8ef 100644
> > --- a/arch/arm/boot/dts/mt7623n-rfb.dtsi
> > +++ b/arch/arm/boot/dts/mt7623n-rfb.dtsi
> > @@ -40,6 +40,7 @@
> >  	};
> >  
> >  	memory@80000000 {
> > +		device_type = "memory";
> >  		reg = <0 0x80000000 0 0x40000000>;
> >  	};
> >  
> > 
