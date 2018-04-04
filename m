Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3353251-1522820269-2-2213928562294338651
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522820268; b=dBxx7VpZAX8UgOA+6X+DX/9awu1/aFFkxQOGWBf6r3RxtqbBmb
    Si2smBlVaTqaJVkZ4ERRreyp161TsCIUxrdRdaOvk7QqMkcs7CPHltfg68GwXfcX
    P7rqJ/JId5UYDf/qf94ti33zwcZcipPzF2eRAgEl/GE2TaBEuA6AcacWGBH3uLaR
    L51TL/Cw5KBpI2VO8tuUicjTGyTgDC/gGoOrVZVi8Z8g5fC2qxvJQvUXwiZ7klyd
    xe/y8/ykdoe/dNFsWsR4AIW1dva9Yz7MkEdaokUIaWPy7M/hU+Y6AUFuSowI6F9X
    A9aNyzAxk5syKxFFrdvoAwywbAFBttb+3LUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    fm2; t=1522820268; bh=Id5EREiqBeTqw4RK0BIM0MukVTXCDr3FQOFAf22oiA
    g=; b=bisU37ChLbrjIhyqwIB6Iztj+Yj5MPa5KxqQ9Px9Axm1+EN7nU0yhHZX7s
    jaOT3uKHX6yo2yt5zX66uZzRzA3B2qzHEh0n+iI46e0yRy+72Khn2UAm96VstGcw
    TAG4UXGUrUim8N8IiYf9LYNhsdQCzWudSm/jie3YCau3Q09rZy0SWKCD9adepIZ+
    Rj/+RSf2usZCUYzq0CYoUB3QyQqhjH50K6o992FvQpM1ZKEP4jBqzxF5ui/I/Ssd
    1A3+bk9NE/d2wayDfsBtdKQwjiJIYOPxLEdPnvLIcHIRhS+I0IIniX4kjnfaW+7r
    OO3p3VN2Lo5tFV3BRWJAN+cI9fYA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKpQnhHTY2xO7jPlV+48HP8EmzfkqmBsatsqIENgELTMe+6v6uFp7kTgFVn/Cypw7C3FSv31t5OIcnt6BUAVYxpjf7a1OYWdjuieAj4cSrJv9jubqd8Y
    ckpTl0HwqMTSW/yOSooi91l6yIEmQpQt+AdekXqb7EeLzDYlwzM7B14WOxv+dfqlaDPhFGUrWxC5I6XYmxdTPFEn2rJj6aPCvAR2MCZTmR7nauDdHPOEU8Nz
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=c-n4J4-pAAAA:8
    a=VwQbUJbxAAAA:8 a=lDX7PoB9dAscIC7BdaIA:9 a=_5dwtH9pHpwgQwRM:21
    a=2BFRO-o08BN2bJ9h:21 a=x8gzFH9gYPwA:10 a=L0NDqeB7ZLmQzAogN4cw:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbeDDFhg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 01:37:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:48658 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751117AbeDDFhe (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 4 Apr 2018 01:37:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,405,1517904000";
   d="scan'208";a="217469378"
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-usb@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multiple generic PHY instances for DWC3 USB IP
In-Reply-To: <CAK7LNATkS6pFQ9Gexm1uiG8e-3x6QXh-GYs3ABVEQzBnFK5gqw@mail.gmail.com>
References: <CAK7LNATkS6pFQ9Gexm1uiG8e-3x6QXh-GYs3ABVEQzBnFK5gqw@mail.gmail.com>
Date: Wed, 04 Apr 2018 08:36:53 +0300
Message-ID: <87vad7cz2i.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Hi,

Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> Currently, DWC3 core IP (drivers/usb/dwc3/core.c)
> can take only one PHY phandle for each of SS, HS.
> (phy-names DT property is "usb2-phy" and "usb3-phy" for each)

We never had any other requirements :-)

> The DWC3 core IP is provided by Synopsys,
> but some SoC-dependent parts (a.k.a glue-layer)
> are implemented by SoC venders.
>
> The number of connected PHY instances are SoC-dependent.
>
> If you look at generic drivers such as
>   drivers/usb/host/ehci-platform.c
> the driver can handle arbitrary number of PHY instances.
>
> However, as mentioned above, DWC3 core allows only one PHY phandle
> for each SS/HS.
> This can result in a strange DT structure.
>
> For example, Socionext PXs3 SoC is integrated with 2 instances of DWC3.
>
> The instance 0 of DWC3 is connected with 2 super-speed PHYs.

why 2 super-speed phys? Is this a two-port host-only implementation?

> The instance 1 of DWC3 is connected with 1 super-speed PHY.

Are both of these instances incapable of high/full/low-speed
communication?

> According to the feed-back from Felipe Balbe,
> (https://patchwork.kernel.org/patch/10180167/)
> Socionext is trying to split the glue layer into small chunks.
>
>
> The following is the DT under internal review of Socionext.
> The full DT is super long, so
> here is only snippet for the SS PHY parts.
>
>
>         [ instance 0  (with 2 SS PHYs) ]
>
>         dwc3@65a00000 {
>                 compatible = "snps,dwc3";
>                 reg = <0x65a00000 0xcd00>;
>                 interrupt-names = "host", "peripheral";
>                 interrupts = <0 134 4>, <0 135 4>;
>                 phy-names = "usb2-phy", "usb3-phy";
>                 phys = <&usb0_hsphy>, <&usb0_ssphy>;
>                 dr_mode = "host";
>         };
>
>         usb0_ssphy: ss-phy {
>                 compatible = "socionext,uniphier-pxs3-usb3-ssphy";
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 #phy-cells = <0>;
>                 clock-names = "phy-clk0", "phy-clk1";
>                 clocks = <&sys_clk 17>, <&sys_clk 18>;
>                 reset-names = "phy-rst0", "phy-rst1";
>                 resets = <&sys_rst 17>, <&sys_rst 18>;
>                 port0-supply = <&usb0_vbus0>;
>                 port1-supply = <&usb0_vbus1>;
>
>                 port@0 {
>                         reg = <0>;
>                 };
>                 port@1 {
>                         reg = <1>;
>                 };
>         };
>
>         [ instance 1 (with 1 SS PHY) ]
>
>         dwc3@65c00000 {
>                 compatible = "snps,dwc3";
>                 reg = <0x65c00000 0xcd00>;
>                 interrupt-names = "host", "peripheral";
>                 interrupts = <0 137 4>, <0 138 4>;
>                 phy-names = "usb2-phy", "usb3-phy";
>                 phys = <&usb1_hsphy>, <&usb1_ssphy>;
>                 dr_mode = "host";
>         };
>
>         usb1_ssphy: ss-phy {
>                 compatible = "socionext,uniphier-pxs3-usb3-ssphy";
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 #phy-cells = <0>;
>                 clock-names = "phy-clk0";
>                 clocks = <&sys_clk 21>;
>                 reset-names = "phy-rst0";
>                 resets = <&sys_rst 21>;
>                 port0-supply = <&usb1_vbus0>;
>
>                 port@0 {
>                          reg = <0>;
>                 };
>         };
>
>
> I think this is strange, but the PHY driver
> counts the number of sub-nodes ("port@0", "port@1" ...)
> and iterate the port settings.
>
>
>
>
>
> In my opinion, the structure like follows
> will be more natural.
> (flattening homogeneous PHY nodes)
>
>
>         [ instance 0 (with 2 SS PHYs)]
>
>         dwc3@65a00000 {
>                 compatible = "snps,dwc3";
>                 reg = <0x65a00000 0xcd00>;
>                 interrupt-names = "host", "peripheral";
>                 interrupts = <0 134 4>, <0 135 4>;
>                 phys = <&usb0_hsphy>, <&usb0_ssphy0>, <&usb0_ssphy1>;
>                 dr_mode = "host";
>         };
>
>         usb0_ssphy0: ss-phy0@65b00300 {
>                 compatible = "socionext,uniphier-dwc3-ssphy";
>                 reg = <0x65b00300 0x10>;
>                 #phy-cells = <0>;
>                 clocks = <&sys_clk 17>;
>                 resets = <&sys_rst 17>;
>                 port-supply = <&usb0_vbus0>;
>         };
>
>         usb0_ssphy1: ss-phy1@65b00310 {
>                 compatible = "socionext,uniphier-dwc3-ssphy";
>                 reg = <0x65b00310 0x10>;
>                 #phy-cells = <0>;
>                 clocks = <&sys_clk 18>;
>                 resets = <&sys_rst 18>;
>                 port-supply = <&usb0_vbus1>;
>         };
>
>
>
>
>         [ instance 1 (with 1 SS PHY) ]
>
>         usb0: dwc3@65c00000 {
>                 compatible = "snps,dwc3";
>                 reg = <0x65c00000 0xcd00>;
>                 interrupt-names = "host", "peripheral";
>                 interrupts = <0 137 4>, <0 138 4>;
>                 phys = <&usb1_hsphy>, <&usb1_ssphy>;
>                 dr_mode = "host";
>         };
>
>         usb1_ssphy: ss-phy@65d00300 {
>                 compatible = "socionext,uniphier-dwc3-ssphy";
>                 reg = <0x65d00300 0x10>;
>                 #phy-cells = <0>;
>                 clocks = <&sys_clk 21>;
>                 resets = <&sys_rst 21>;
>                 port0-supply = <&usb1_vbus0>;
>         };
>
>
> To achieve this, I need driver changes.
>
>
> My proposal is to support arbitrary number of PHY instances
> like ehci-platform.c does.
>
>
>
> @@ -894,8 +894,8 @@ struct dwc3 {
>         struct usb_phy          *usb2_phy;
>         struct usb_phy          *usb3_phy;
>
> -       struct phy              *usb2_generic_phy;
> -       struct phy              *usb3_generic_phy;
> +       unsigned int            num_phys;
> +       struct phy              **phys;
>
>         bool                    phys_ready;
>
>
>
> Is this OK?

I don't know, I need a bit more details about your integration :-)

-- 
balbi
