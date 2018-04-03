Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1580296-1522762394-2-12090993865733807576
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522762391; b=JuK037fvjQcjvfJS5/0esXZuFtD49sQRhexYJernyjEzBvZS9F
    eNot/PWqsiJ6pC1NI27Vt42KCjcn2VW1/+HeO0Jngln25yQI5thbvNh75ulUhRGy
    tK00X6indTNQ3QzXNUZ9QuxUABRsMqZHkEVGcDe7yTkHYsj064Jp902JEAA0y88O
    EB1W2q8bjv/dlaL58j7pxSyoUWpPBeKkWIhVsfPrlDyDoOghltOzjPAXf+QN/94C
    S9SdFQnCPHo36jbNXt0COVGjnMXE+gHJVUZDAXCUMTk7o+ANZ8Yo4Fgva045ZZr3
    mfH2NfKe0yhR+AhIAFaSjrH5jbBpFnjAdeyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:from:date:message-id:subject
    :to:cc:content-type:sender:list-id; s=fm2; t=1522762391; bh=Kqms
    Rd3JV8lAtYJLd+fJm4yt8mqcfbiquoyasoxImX4=; b=nCfAq76rA3Xx2N/qxKFf
    NNqddTvATDzXE7m9vy+4QtB47lQMDkDRBxW3od7oxOa5ATuSytv3qI51BX2eFXGb
    lLeVzbJERVFfzlhbGwS57uQIOlvBFK2B0YWLTrKerZfIeau1SplEs1ATBCcvUWD+
    JYcYOhHcibgDjEMDYMbfs0yAGSC6Ha+NbWQ0Z6Dtz8cXjl3XqkhT/wfLt5XxlZZ+
    mKZXcqMvUnSANnF4CdXU53ZAHJ17oLYxrslHcy0pnNLxRCxrSpojU91KcjpLPoKL
    caS9ah+GZcT4/bHjl2E2vSUteVKNRblK+kauD/jyTZ5lQejDDXs0YyRa10i/bo6G
    3g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=IKGbaknF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=IKGbaknF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJvtiPMXFgTXovJGEZhG/phike8nqd8aisxzAAu845ZINmoMDDBJyOjBsrhWkEpsUHw0m1cg5IJMTKxtwTJIlyjVIXCW1NODYfZT/qL5h1BqXj54ba+R
    B8O+BfPSdwFdz+zkc3Xa870sGAbvzncbxarH33in0vT+iLgZd7ts6AhyZLq1oPr4n9huvJgNZjK97oae6LaGonFyuUjU5AMS5nVU+Mz4O/wAyz27FfToltlA
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=0fG9nWE-xvPs4jodWjsA:9 a=T3uaP6pyJBE-ZIGO:21
    a=WeTjLsH-JBpcpaN5:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750855AbeDCNcz (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 09:32:55 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:50453 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeDCNct (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 3 Apr 2018 09:32:49 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w33DWLO0021231
X-Nifty-SrcIP: [209.85.217.181]
X-Google-Smtp-Source: AIpwx48bLXfPEV2GWFfOxJBc03TLZFCRseX7juelkjNM5uAomOWkbe/IZ+fMYQ7GEnLkLeqsATXJQjBDPNru3OsYock=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 3 Apr 2018 22:31:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNATkS6pFQ9Gexm1uiG8e-3x6QXh-GYs3ABVEQzBnFK5gqw@mail.gmail.com>
Message-ID: <CAK7LNATkS6pFQ9Gexm1uiG8e-3x6QXh-GYs3ABVEQzBnFK5gqw@mail.gmail.com>
Subject: Multiple generic PHY instances for DWC3 USB IP
To: Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi.


Currently, DWC3 core IP (drivers/usb/dwc3/core.c)
can take only one PHY phandle for each of SS, HS.
(phy-names DT property is "usb2-phy" and "usb3-phy" for each)

The DWC3 core IP is provided by Synopsys,
but some SoC-dependent parts (a.k.a glue-layer)
are implemented by SoC venders.

The number of connected PHY instances are SoC-dependent.

If you look at generic drivers such as
  drivers/usb/host/ehci-platform.c
the driver can handle arbitrary number of PHY instances.

However, as mentioned above, DWC3 core allows only one PHY phandle
for each SS/HS.
This can result in a strange DT structure.

For example, Socionext PXs3 SoC is integrated with 2 instances of DWC3.

The instance 0 of DWC3 is connected with 2 super-speed PHYs.
The instance 1 of DWC3 is connected with 1 super-speed PHY.


According to the feed-back from Felipe Balbe,
(https://patchwork.kernel.org/patch/10180167/)
Socionext is trying to split the glue layer into small chunks.


The following is the DT under internal review of Socionext.
The full DT is super long, so
here is only snippet for the SS PHY parts.


        [ instance 0  (with 2 SS PHYs) ]

        dwc3@65a00000 {
                compatible = "snps,dwc3";
                reg = <0x65a00000 0xcd00>;
                interrupt-names = "host", "peripheral";
                interrupts = <0 134 4>, <0 135 4>;
                phy-names = "usb2-phy", "usb3-phy";
                phys = <&usb0_hsphy>, <&usb0_ssphy>;
                dr_mode = "host";
        };

        usb0_ssphy: ss-phy {
                compatible = "socionext,uniphier-pxs3-usb3-ssphy";
                #address-cells = <1>;
                #size-cells = <0>;
                #phy-cells = <0>;
                clock-names = "phy-clk0", "phy-clk1";
                clocks = <&sys_clk 17>, <&sys_clk 18>;
                reset-names = "phy-rst0", "phy-rst1";
                resets = <&sys_rst 17>, <&sys_rst 18>;
                port0-supply = <&usb0_vbus0>;
                port1-supply = <&usb0_vbus1>;

                port@0 {
                        reg = <0>;
                };
                port@1 {
                        reg = <1>;
                };
        };

        [ instance 1 (with 1 SS PHY) ]

        dwc3@65c00000 {
                compatible = "snps,dwc3";
                reg = <0x65c00000 0xcd00>;
                interrupt-names = "host", "peripheral";
                interrupts = <0 137 4>, <0 138 4>;
                phy-names = "usb2-phy", "usb3-phy";
                phys = <&usb1_hsphy>, <&usb1_ssphy>;
                dr_mode = "host";
        };

        usb1_ssphy: ss-phy {
                compatible = "socionext,uniphier-pxs3-usb3-ssphy";
                #address-cells = <1>;
                #size-cells = <0>;
                #phy-cells = <0>;
                clock-names = "phy-clk0";
                clocks = <&sys_clk 21>;
                reset-names = "phy-rst0";
                resets = <&sys_rst 21>;
                port0-supply = <&usb1_vbus0>;

                port@0 {
                         reg = <0>;
                };
        };


I think this is strange, but the PHY driver
counts the number of sub-nodes ("port@0", "port@1" ...)
and iterate the port settings.





In my opinion, the structure like follows
will be more natural.
(flattening homogeneous PHY nodes)


        [ instance 0 (with 2 SS PHYs)]

        dwc3@65a00000 {
                compatible = "snps,dwc3";
                reg = <0x65a00000 0xcd00>;
                interrupt-names = "host", "peripheral";
                interrupts = <0 134 4>, <0 135 4>;
                phys = <&usb0_hsphy>, <&usb0_ssphy0>, <&usb0_ssphy1>;
                dr_mode = "host";
        };

        usb0_ssphy0: ss-phy0@65b00300 {
                compatible = "socionext,uniphier-dwc3-ssphy";
                reg = <0x65b00300 0x10>;
                #phy-cells = <0>;
                clocks = <&sys_clk 17>;
                resets = <&sys_rst 17>;
                port-supply = <&usb0_vbus0>;
        };

        usb0_ssphy1: ss-phy1@65b00310 {
                compatible = "socionext,uniphier-dwc3-ssphy";
                reg = <0x65b00310 0x10>;
                #phy-cells = <0>;
                clocks = <&sys_clk 18>;
                resets = <&sys_rst 18>;
                port-supply = <&usb0_vbus1>;
        };




        [ instance 1 (with 1 SS PHY) ]

        usb0: dwc3@65c00000 {
                compatible = "snps,dwc3";
                reg = <0x65c00000 0xcd00>;
                interrupt-names = "host", "peripheral";
                interrupts = <0 137 4>, <0 138 4>;
                phys = <&usb1_hsphy>, <&usb1_ssphy>;
                dr_mode = "host";
        };

        usb1_ssphy: ss-phy@65d00300 {
                compatible = "socionext,uniphier-dwc3-ssphy";
                reg = <0x65d00300 0x10>;
                #phy-cells = <0>;
                clocks = <&sys_clk 21>;
                resets = <&sys_rst 21>;
                port0-supply = <&usb1_vbus0>;
        };


To achieve this, I need driver changes.


My proposal is to support arbitrary number of PHY instances
like ehci-platform.c does.



@@ -894,8 +894,8 @@ struct dwc3 {
        struct usb_phy          *usb2_phy;
        struct usb_phy          *usb3_phy;

-       struct phy              *usb2_generic_phy;
-       struct phy              *usb3_generic_phy;
+       unsigned int            num_phys;
+       struct phy              **phys;

        bool                    phys_ready;



Is this OK?


-- 
Best Regards
Masahiro Yamada
