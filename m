Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2379892-1522653557-2-11516051251622722863
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522653556; b=pUKGGNClogiDtKBHeXLPALzkcJAhL2jcmWSQpl4cZXTIFmJphn
    aqfXHR0rBq9XIwFQIjSuZ2SsnPGOyEu25RsSYORi+VqRxrWqmL4moIDz6Aa5RVWm
    zjMybs9tgfznX7557naYNyVIGtHFco2JDcCgJwRG3H+yON2J8U0JWs5bYvk6S5Pt
    2dFqJNTciyvIB0E2irdV2xHUKsHfbjP4TOqqMyHG/yp4fiILwMiPYXXXzMc++G3b
    J72IJBAG9bu6hl3iBUjiZ6lDCpN77fedNtWQsHr7cURP7NIadQhEeLam3NaxrGS5
    y4QSYMQYFyvSqJGeb52oB3NBBG2gRcDNve4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:from:date:message-id:subject
    :to:cc:content-type:sender:list-id; s=fm2; t=1522653556; bh=66Ve
    4x5dpHznFT5h9nD+NuzbaS4vxZi5HnjzppkxtlE=; b=YQLocGyJmDPcVRO+1ARf
    tbxA1oN8QbNEsnKKINJfIhM8EPt+aUdVhh9uMBtTvonbul5jRrEz5iTTmXd0Clir
    wb6jMqj8fU12XwaXex3qTz86Qf/q0ebAUfU4WV096rOmDwoVV3BeyuLg3wIY/xHt
    i441PcTr/ZEOQ7f1PPoVOGq/Q6CpBXa0/7qD8qdQkKtla3YxbHRa7gjkBj+jNYZ8
    KWapNhw7EPdoSfa5PFb8X49/xvQPWOyaP7QZsm18CziwZPF2Zlok4WodjSUtSU3b
    JStLz9fMKgS7L4mbVAbLv8igi5S47iMsA/OCcPSwZsvoGxx/l5KQ9fopPOKybW2N
    lw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=HN+Psi3R x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=HN+Psi3R x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfANvzkDK9iM4JfG/JLrGizEWzP5eG99Q4bPel15okIcV1tIlqBVE0wmS6XRkOHz8WPIJfvCwMmfPYP7wYmSmRd4P+XgVhDX5ggxX3pZtY356kUqs0EmF
    po1W0seo0SoXjCfllHJN9GcQ36FiUZZFeDY5RrAeg3oKvODqWtQYt0RnRodoSKM6Hp3YRFkGmkJvES4QTaQzm5ifdWkACWy9Wny1GFx1C/25fWRvL/Plx62o
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=Pl4L9XA9c3JwL1hc02EA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754213AbeDBHTB (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 03:19:01 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:21916 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751930AbeDBHTA (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 2 Apr 2018 03:19:00 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w327Idti007446
X-Nifty-SrcIP: [209.85.213.41]
X-Google-Smtp-Source: AIpwx4+ohQ3PZv+dzoo4iGXzqNDzGc1wgOI+TdvEvreDTlouLH6ONfZV8U8HuxI2N/4uewCergUUZlPWVVcDnOZZUso=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 2 Apr 2018 16:17:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNARFWDMgmWsCjUmVrm4ZeYOcKCbizijxmDXob618ABjNWg@mail.gmail.com>
Message-ID: <CAK7LNARFWDMgmWsCjUmVrm4ZeYOcKCbizijxmDXob618ABjNWg@mail.gmail.com>
Subject: [Question] MFD driver that handles clocks/resets and populates child nodes
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi.


Some MFD drivers populate child nodes
after some basic hardware setups.


My question is, is it acceptable to upstream
a MFD driver that handles only clocks/resets,
then calls of_platform_populate.


The probe function will look like follows:


static int uniphier_usb3_glue_probe(struct platform_device *pdev)
{
        [get some clocks];

        [get some resets];

        [enable some clocks];

        [deassert some resets];

        return devm_of_platform_populate(dev);
}


With this driver, the child devices do not need
to handle clocks/resets.
But, I am not sure if it is the right thing to do.



Background of this question
---------------------------

Socionext is trying to upstream
the glue layer for DWC3 USB IP.

The original patch is this.
https://patchwork.kernel.org/patch/10180167/

This driver enables clocks, deassert resets,
and sets up some more registers,
then populates the DWC3 core node.

The maintainer of DWC3, Felipe Balbi, requested to
split the glue layer driver into small parts such as
reset, regulator, phy, etc.

So, the node will look like follows:

   usb-glue {
           reset {
                   ...
           };

           regulator {
                   ...
           };

           hs-phy {
                   ...
           };

           ss-phy {
                   ...
           };
   }

Here, one question popped up.
Where should the hardware resources be described?
The register, clocks, resets are shared among the sub-nodes.
This is the obvious result since it is a single hardware block
in the first place, and we are splitting it into small chunks.


If the MFD driver approach is acceptable,
clocks, resets will be handles in the parent node.
(Such a driver looks stupid, though)


   usb-glue {
           compatible = "socionext,uniphier-ld20-usb3-glue",
                        "syscon";
           reg = <0x65b00000 0x1000>;
           clocks = <sys_clk 14>;
           resets = <sys_clk 14>;

           reset {
                   ...
           };

           regulator {
                   ...
           };

           hs-phy {
                   ...
           };

           ss-phy {
                   ...
           };
   }


Of course, it is possible to use "simple-mfd"
and each driver can repeat the same clock/reset like follows.
(this also looks a bit clumsy...)

   usb-glue {
           compatible = "socionext,uniphier-ld20-usb3-glue",
                        "simple-mfd", "syscon";
           reg = <0x65b00000 0x1000>;

           reset {
                   clocks = <sys_clk 14>;
                   resets = <sys_clk 14>;
                   ...
           };

           regulator {
                   clocks = <sys_clk 14>;
                   resets = <sys_clk 14>;
                   ...
           };

           hs-phy {
                   clocks = <sys_clk 14>;
                   resets = <sys_clk 14>;
                   ...
           };

           ss-phy {
                   clocks = <sys_clk 14>;
                   resets = <sys_clk 14>;
                   ...
           };
   }


Which is better?
Or any other good idea?

Thanks.


-- 
Best Regards
Masahiro Yamada
