Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3037658-1527019833-2-315683067048642114
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527019832; b=RT5ybp6JmP2XGL0NAIfU8w4zhSkeeQA5OZSOh/prIiUydX+hQN
    cjMns8LaNkgKkh3U+wrmEaCblUFEeFJYrzASe06PgjU9ZRmuWR1rj+RgtEIdl7/2
    t+wGDmiIQnuV5oJQCOZhLN5BcpoURevfnGcPwap0usdY4IHOQIsCCezJxhI9irmV
    s19ydG917OTl9TqAwMOEPWucAtgLBvI3ScSxF2Htjmd2BNgN5QQr8iYL1Tv68VPR
    OIvctP4K6Ck3ZbkqDa4tkneZM0vTui53PSQWC20T7CLMn7e0zEvDIfJ+tHj8ssH8
    wnAuTKiUBSzoURIp8u15J8j862ZUPyI/8xTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527019832; bh=tysl920Vgq6epq2Nga61mdlGn3BGG+
    qE0GCjsw+l6Wo=; b=FyynUZF213C6q4lQvAfQpr0EuDQwJO++12tTQ/lNrR8szc
    f3sGWkU8vW5UDV9VMzWX/Pr9hGDyZS4fo6ZVx0aRPT3JKRQw+BhU+6RKDYGZRuFk
    p/NEMqqZ+e7ZjKRuWn9vSUsTvm6BjX1tz4pNog7xnrvmT4PrkWiuFgJlgzg5vwsv
    X4zWEH3o4yuv0tKGfcHHWO+WqhhQYeqLxUDCIj6Tw69w8inRoJLKpB9oNVXBXh/p
    EwGDWw2W/R8l0/nWLxbGga2wmx/T1TRVqkELGJ7rU5VCe1Uj4Gxgz0hG61WZH/v0
    jf1WywGcQptme4MAxU89CU9arclF+k6TTVXfTsYw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=O4zRj4n2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=O4zRj4n2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEoF2+glRj7fXRBPr/ZIg6EZC6tCIIrC+YQTfIFfK7SNyOfMOFRCMJ4SpKSV8dqNYbylmglIPmYlsMAHJ8lmzmp7t9976cqeK+TtUOg9k1AmB8rg7Uzu
    Z96SY2sORPNHJm6Fz8F+G3GOvwb8Xe9FIn6x1Zx9rsJeXKsB+4j1niYwq7I70Yb2z4A8Sgim+I150oa0CKaL1a3ElJpiMMvuePZ5Qank8gopXO3A0DxXwfJl
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=P_f_G489XJIInv-DWEIA:9 a=2ayFvhugXVFJHztI:21
    a=Lz1SJswj44vKbByN:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751586AbeEVUKE (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 16:10:04 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:36539 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeEVUKD (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 22 May 2018 16:10:03 -0400
X-Google-Smtp-Source: AB8JxZrPdYbCKd4XSA1hDbE+zL25SasPVPwns8dABB3xede8BC+uElhhCcPD/e7JeAlXQj9o63LBIg==
Date: Tue, 22 May 2018 15:09:50 -0500
From: Rob Herring <robh@kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Icenowy Zheng <icenowy@aosc.io>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 4/5] arm64: allwinner: h6: add USB3 device nodes
Message-ID: <20180522200950.GA16392@rob-hp-laptop>
References: <20180507151817.55663-1-icenowy@aosc.io>
 <20180507151817.55663-5-icenowy@aosc.io>
 <9a25a561-b643-a77b-3287-8082780fce60@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a25a561-b643-a77b-3287-8082780fce60@cogentembedded.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 11:31:27AM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 5/7/2018 6:18 PM, Icenowy Zheng wrote:
> 
> > Allwinner H6 SoC features USB3 functionality, with a DWC3 controller and
> > a custom PHY.
> > 
> > Add device tree nodes for them.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> >   arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 38 ++++++++++++++++++++
> >   1 file changed, 38 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > index c72da8cd9ef5..9564c938717c 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -174,6 +174,44 @@
> >   			status = "disabled";
> >   		};
> > +		usb3: usb@5200000 {
> 
>    I don't think <unit-address> is allowed for a node having no "reg" prop...

Right. One way to fix is fill out ranges property because the unit 
address can come from either.

However, there's work to deprecate doing DWC3 binding with a child node 
like this. See the series "usb: dwc3: support clocks and resets for DWC3 
core". Please follow that.

Rob
