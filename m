Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-654-1526460906-2-17897314435659499677
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526460905; b=mbrM5Em0gvH1bQK3pVmdHcJfwmXmh0OH3eo+YBJtTMFQN6b7iC
    4JxRoD/OMIkmz/S7RS5/xZuFpm1yRa5bikPQ5VBml9WB0Y4PB2HBD1pVb7AxmMzr
    TBOyqdm13zYNgU8kdHNWvND3/tTx8KIKCcXuDPIwJgnPd+jE0s7J2SvCGJJnx6jj
    uEbDsjdhQYMDX/5N562FRQolH/FS6VHp3HFYVbt3UCmNIE/27+4jGQiu1oyvGUGy
    5JcqE1+SG06FDaRFoQKxwSREqQqTw0vWLwIriSh4MHIKxOahTbQaVxnTUllo3mAC
    h3XTUOK5SrctHH1hclj6JXEhLD62Rt9cCj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526460905; bh=5gbB0dDHbccT1BcLIrm0hTuTCxIiln85/L2lJEF4U6
    s=; b=Xu73MqNXJMM0Xne5y6X4fhbOIjQ1WgKydF9iS8T9XJXvAcuX5MIk6veLl7
    xWUd5t3sIVn3mJMnacNmF2oy/OC4Ly4DUXwSEjl48USPWI40rb6vhiB9a7gVqHOg
    hZukco6i4NmrBwKE7hHLTP2912TeU1pgQyrgviK0QNl564Rsx091cHDVQry5lehy
    ZDBfnAvVXmlWgh1izFJHH6x/MgS4DeHUgdkMVctkxvaXM6he8sG55RkepKaVWGxt
    FWRFVjLrceZXj/bKPhR4Pn3wft5C5gm+QWIPhN9V5dq8re1KLwRVXlM1p5gckuyb
    RXmBAFhr2ezcUV86vIytksVa/Pyg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=HWesZABA x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=tZ399nOs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-m68k.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=HWesZABA x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=tZ399nOs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-m68k.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDjYRd/CO7zT8wbWLF5wDfgsv+1jWxHugtREacHfWXQ1ruI/SZB6A/FLq7Q82jtIYBKO0jRxvd5c9+xD0BTSvunCSBkz1+yR5cvBkM9hN7Y1uFSADLb9
    Kyg6CvtVB6h8buCylBonTOroPy8FGpG4aLr99s/ApxHBC2BXhoSp+PL6rLSriDELC3B1jTCdiNUvryKUoSfu2cQThgM3ZGF3ZG5t6uxXjx+XzR1S7itz61k+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=tBb2bbeoAAAA:8 a=VwQbUJbxAAAA:8 a=g2K_Cyq5vwUnV-CKteIA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=Oj-tNtZlA1e06AYgeCfH:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeEPIyS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:54:18 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44192 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbeEPIyO (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 16 May 2018 04:54:14 -0400
X-Google-Smtp-Source: AB8JxZqm8h2OWa2wEF6hdGRyrnTEQmRJzn/03DxU8cnM/kPsX8xqemPUc0bCHdygo6f69iAP1wzwEzaoZlE9ClqbwHQ=
MIME-Version: 1.0
In-Reply-To: <20180515235619.27773-1-f.fainelli@gmail.com>
References: <20180515235619.27773-1-f.fainelli@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 May 2018 10:54:12 +0200
X-Google-Sender-Auth: wroO3N2xP07oxKT7CGZYHtsU1xQ
Message-ID: <CAMuHMdXfOOgADe1my9Y3s3b9_OsXPjbqq1PPFR9izZWhtPuaFg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] of: mdio: Fall back to mdiobus_register()
 with NULL device_node
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>,
        Simon Horman <horms+renesas@verge.net.au>,
        Maxim Uvarov <muvarov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:RENESAS ETHERNET DRIVERS"
        <linux-renesas-soc@vger.kernel.org>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)"
        <linux-omap@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Florian,

Thanks for your series!
I like the effect on simplifying drivers.

On Wed, May 16, 2018 at 1:56 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> This patch series updates of_mdiobus_register() such that when the device_node
> argument is NULL, it calls mdiobus_register() directly. This is consistent with
> the behavior of of_mdiobus_register() when CONFIG_OF=n.

IMHO the CONFIG_OF=n behavior of of_mdiobus_register() (which I wasn't
aware of) is inconsistent with the behavior of other of_*() functions,
which are just empty stubs.

So I'm wondering if you should do it the other way around, and let
mdiobus_register() call of_mdiobus_register() if dev->of_node exists?

This does mean mdiobus_register() should gain a struct device * parameter,
and thus changes to many more drivers are needed.

> I only converted the most obvious drivers, there are others that have a much
> less obvious behavior and specifically attempt to deal with CONFIG_ACPI.

I haven't looked at the ACPI handling, but perhaps this can be moved
inside mdiobus_register() as well?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
