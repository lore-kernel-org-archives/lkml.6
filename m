Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-700495-1526494890-2-3981273493388780320
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526494890; b=fInyqn71q0rzmk/7FH7cbhhHz6YvcdU7bgVTYiQ/+sh4nA5mBD
    ngv/BP3Z78uXcpaWhsgI4ZZCWyb2PXTx7VZsB5EG0OshcgFJJYHZU70La7ArLffm
    wxYL+Nk7mBmg2MJArdJYG81NppOMpeDMEX0zg3d5OzcMPRAK5uHmGC+8EVDMvHUO
    QePP3f3Px37NnyQXrHPz6dYJFDxFi0O6tyKfLlz2WAjrO1DmhBHgOaJv4XDSEJ/r
    cZJI0u3H2H3UowSAi8YHUKbodnQNYV6wS+DOKhAB8unUPjlv+omu/c2RnVRCjwn7
    7JOo4mlokes0zePLktkFRlXm1BsXkzxJNHUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526494890;
    bh=ka/mfFK2ieh/4MPbi6hrvYqOL0TtC4lKgk4xfeO0Zmc=; b=kg0qHm3N47CL
    FM4l2YNomCx4tJzmS7KqebD5L65UuEJxB0QGMpOD6Z2VkD8Vaz29qVZ/oXcluG1f
    Gg+mVLPcDca1sDpM4nXdwZXYRzZxLpIVKfefGQelzt/n4VQ3vvQ4A/hZN4pIAida
    l6L18Y9qkNArCY4bUTKumIgfyrlDdEFbwkZxMZbGGEjcC+AY6y2rK/Xp6MZB5esZ
    maLLMCj7x2LXuNCzvbeLS4/qpauZw9oxpZV4oDk+XfYMPqtbF0VkPUUJoyU3xFza
    NpwJ9HElj1QUx2iqgnhprzZN+c5PANnx4IUhPX2FBHR4+v60uOxzHg9LnL6CBUzX
    L/7vFuKRaQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=davemloft.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=davemloft.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKA7+r7sFNem7MxDlOrqcPOyuwZT6i+tdlpd7KbNzKBfrPTTB2PdEBCROPpZgROss8gV3tpmOW27AantGh998B2K4JTErbN+beeRK/cH78WbofNa41dh
    nFwgD7hUwlU+dxeLLvcA8aNnM42LY4F6h0aoYnuTtM3Y6NIHJrKe0weZa9H9LABuj2sxtaYuzUCSWjaj+/4Tb2zK5dlsBZENCbLVHlENXJblagkn5WRUe6XO
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=LJZA-xJskGbPPdVJK7AA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeEPSVJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 14:21:09 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:43526 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbeEPSVH (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 16 May 2018 14:21:07 -0400
Date: Wed, 16 May 2018 14:21:02 -0400 (EDT)
Message-Id: <20180516.142102.1650229402143291732.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, nicolas.ferre@microchip.com,
        fugang.duan@nxp.com, sergei.shtylyov@cogentembedded.com,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, grygorii.strashko@ti.com,
        woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        robh+dt@kernel.org, frowand.list@gmail.com,
        antoine.tenart@free-electrons.com, Tobias.Jordan@elektrobit.com,
        rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        thomas.petazzoni@free-electrons.com,
        niklas.soderlund+renesas@ragnatech.se, horms+renesas@verge.net.au,
        muvarov@gmail.com, nsekhar@ti.com, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] of: mdio: Fall back to
 mdiobus_register() with NULL device_node
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180515235619.27773-1-f.fainelli@gmail.com>
References: <20180515235619.27773-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 15 May 2018 16:56:17 -0700

> This patch series updates of_mdiobus_register() such that when the device_node
> argument is NULL, it calls mdiobus_register() directly. This is consistent with
> the behavior of of_mdiobus_register() when CONFIG_OF=n.
> 
> I only converted the most obvious drivers, there are others that have a much
> less obvious behavior and specifically attempt to deal with CONFIG_ACPI.
> 
> Changes in v2:
> 
> - fixed build error in davincin_mdio.c (Grygorii)
> - reworked first patch a bit: commit message, subject and removed useless
>   code comment

Based upon Andrew's response to Geert's feedback, I'm applying this series.

Thanks.
