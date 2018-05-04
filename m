Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-450558-1525456124-2-2786769977270761857
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525456124; b=nxTlxWORfXH+kt5xUNcqVzd439uCS4JRpTkklfrWzBcmKgob0v
    hgVhrF5zXADZGSBsx+jhgAEQ0EN4cTHvBOq6DAKM3ESg34UywVckbA1tR6sqRq91
    04bytNZJ6ZSK2QUGS1OIlR5peeffm80ZZ/Ws4iyqGd5Dej4BTZCthEZXj4rJUSRw
    yptS8TFk7iz1yv/bZsMJxO0DTszCGZTuzdM8gLK/85+YHu0Zr9NmllHriWIGBmCG
    0ECKKey20vrWzQGFzJHgraToRPd+d61krkAUK0+k0hTKeMwktdrtgzOkNevgcYPS
    hTk7N3LbQcWYMy4WHQnUb4jCTvc/q1o0kvVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525456124; bh=QwyZKcgkoPnFyOAlH2O8eXL8Xt1lKx
    fVlaEY4zUyfdw=; b=PN+rZSmRlxvrfyiPIxUj4lZCZI2tjCzCOUNVbXpnz4Da+z
    8Nqour0OhKrAYmlEmCLp0NqAXhAx5EPxJaDgyF219QFOaHVOJUfgXzYqOsn/TknB
    Zqxz2Xc3dNuhsTvZ/cJMGBJ0D4k7NNenlYdHtlk9LGyu/PElSv/gYA5ffC+qeCAw
    PxVcstkZaV3Kv83H9sglrMZLWo/lT9UK9jbg9VsjBRHUkvdW9tLfr+bys0E5t+ys
    u0v/fWLGHCg6/Vmh5oy8ou1tgGHHBWfRwnjCX28yJc8FMQuYPgpnQxBov9aqAHYb
    X5F7QlEIObBFH5/oBqN9XDduwPpCxmgsLwAQgM1g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linutronix.de header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linutronix.de header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBncl7ahMqSWKWlQyCOpT1nfCJo+fcJXsRVL/+JzIhzG55m05rZAy8EtJ5B2duSc7zu11xKH4m+6r68SDABdxp48NHFmMOTS16tjtkdmBizhgLD5UZYT
    9DXoK3k/ZMG7F3B0PA9sPM2mdNbQQ8oJVxtzxs1rlmIQeUD1l0uSurrp/Prx13KdYarLlnsUM1FZhpFh7CTfZJ2SGECxVS0mfUNfFdO8FfvmJ1R3VBpo0C8x
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=_3iAN5dmJPxjh_Nw_akA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbeEDRsb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 13:48:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42332 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeEDRsa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 May 2018 13:48:30 -0400
Date: Fri, 4 May 2018 19:48:26 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Hurley <peter@hurleysoftware.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vignesh R <vigneshr@ti.com>, linux-serial@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>,
        Matthijs van Duin <matthijsvanduin@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2] serial: 8250: omap: Fix idling of clocks for unused
 uarts
Message-ID: <20180504174826.b7hls2c6v7gukdgl@linutronix.de>
References: <20180504173103.73881-1-tony@atomide.com>
 <20180504173931.GD98604@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180504173931.GD98604@atomide.com>
User-Agent: NeoMutt/20180323
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-05-04 10:39:31 [-0700], Tony Lindgren wrote:
> Uhh sorry I managed to commit also a patch I was testing while
> updating patch comments.. Will send out v3 shortly, this can be
> ignored.

I assumed you were helping out to sneak a patch in.

> Regards,
> 
> Tony

Sebastian
