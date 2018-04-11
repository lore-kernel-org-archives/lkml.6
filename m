Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523472359-2-7605080457973594053
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523472359; b=ulJEcpUftOWKRAikU4rR8Jc5BheNq1iBYUFc0wIvhkDNO5Ad8o
    OvKCSr89YLCPzp6gemNGjh4zPIOxqoBj7s2wQOY008DlXJ2Bll+ueQ9mzqAYOK/X
    QL+NjwDtUFUv4RC2E00WIZAkSpD8Ps+u30lFhwFZJnxaLoYNCfq8I27jlziVnhpr
    0KRzRRPEDJD0qecmwDLD41C2ObnEMRQ1m6eEund9zbCxX1wF8mztSbOVvN9jTB0n
    40mBNvpWq/3SVHUHbDAzISraYFCEiMMD5ww3h6cVLHyTRlvk9YGAT6V490jAH6s4
    Qce+oPq2i1VbDUC15akfjMT+dzZ3i2j9sXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523472359;
    bh=UEtncWk7bc6I5KjVr4IXMBTD6DxPw6rf1rY0SzdhQgU=; b=PFgUXJyFEUkp
    BOjyzQ1cUDtWs1ZEpGSFV1dER0RUWLgmm611+n8cW41IvWVaRG9awzvsxvzAberp
    QxR8zaCEwwIgh+cSKkw+BU5pJdOTD5/9B2sn33B3cqQBXF749mndZBdJLsRhXAO9
    povjADIs7IKbhq9yhDnBFXyhREwU53tY9sIGbdQPmFcXDAgIy4aHs16IGQ5hWjcQ
    wVFbHjUj154TO9U3YSoU+oOtTy+VAx4mMhGdw/phu4lqv+6iDZS9GzRb4GRC21Wk
    xvPy/Y5WAZi9Dve7NCWahPK32kgBeEQGiiRTrUMF1lQDpi6HlTXDby/gHOsKboz7
    8linkwbnZA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIbqzAvvR24D3x9i9KpCfSifWZfYoRBOQUYSxadXXpF2C7cbfFal39fvWiUhWMMjX3FXTAJa61hhFKSwHOe1Jqyoh0h/J9P6u+Tp08oOO7gQufbhGqSl
    hH4pkKvmeFLYZmcixJveATBaWe17HEVeT8r9l8yEjs7rQigGuVsww3lmuEQJEdxVkd0uP6lgS0lho86uveFOJZDeBifGjaVkuZplbJcs6fRQIR9H6z0beSuu
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=VwQbUJbxAAAA:8 a=HEac0uoKSkRBOK1l5XYA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755615AbeDKSpv (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:45:51 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:44518 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755606AbeDKSpt (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 11 Apr 2018 14:45:49 -0400
Date: Wed, 11 Apr 2018 14:45:45 -0400 (EDT)
Message-Id: <20180411.144545.61566209668287626.davem@davemloft.net>
To: phil@raspberrypi.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        agraf@suse.de, tbogendoerfer@suse.de, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lan78xx: Don't reset the interface on open
From: David Miller <davem@davemloft.net>
In-Reply-To: <1523362705-30032-1-git-send-email-phil@raspberrypi.org>
References: <1523362705-30032-1-git-send-email-phil@raspberrypi.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Phil Elwell <phil@raspberrypi.org>
Date: Tue, 10 Apr 2018 13:18:25 +0100

> Commit 92571a1aae40 ("lan78xx: Connect phy early") moves the PHY
> initialisation into lan78xx_probe, but lan78xx_open subsequently calls
> lan78xx_reset. As well as forcing a second round of link negotiation,
> this reset frequently prevents the phy interrupt from being generated
> (even though the link is up), rendering the interface unusable.
> 
> Fix this issue by removing the lan78xx_reset call from lan78xx_open.
> 
> Fixes: 92571a1aae40 ("lan78xx: Connect phy early")
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>

Applied and queued up for -stable, thanks.
