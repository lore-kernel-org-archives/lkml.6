Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-219018-1520855066-2-10743346135883640890
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='utf-8', cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520855066; b=XOCMy5UHyBFCAVZY8dwhnqNg+VOKakNS7qEKIEH1lb7UC2U
    dKpL2HwSFwgMGBGm1QkaEtujVWjz2ENtZ3cqtDmBXVSCDvGBpkQObezQo/t2reRZ
    EhPS88j1pVW2T/UBozarIeZLEOeVZoxCn1lJxSFB5AV9uxqCONBvHyFQ4pQZjxct
    M2h91+O71JomtvpmLnU0U1nfTCvmQXoPtoWPNvTSxVfH/hjmsdGRGASD9RBwLKfo
    l82VFpkTCuvwofOi2oinUrXI5pn2AMxmbcycTgQAhLyeivZ1EzzVqkg1V9ywxFtv
    UiCcqPPpphrwG+uM4EdGXPWAiIveZFlCmQiXDuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1520855066; bh=jVGD3Za
    nUkK0Uvvg0vauTbaND1DQxJP2I8YpvJSIxD4=; b=TG0Jv15sTeGmA+NnXaPVhJQ
    GLzHGUiLkBW+XstdJveclmWsrVNuCMUtTkkXVP6SEWyJTj2LfzZyIql6IB5OUPGY
    X9WGYfAyWGgj7vpz7BHuwycSTIsBBU1mIwMqfAI0okXFT2KjNrlSqV+lxI4sLK+7
    FTkl2z6A7T+YBAqQtY526ZXoIQuk6S7OWBKXi+wlp9lFFYrf//X+vernc+h5GNFn
    Qi5FUNweXnS00tqVn6Ms0/RzDGdnuElrzE1J1MTGCPCi6dmrfJJLALBwGwSqbexQ
    6//nA8GYgFf5z3pAg0mAWfMlIUpD7HGDAAOWNh3tO6I8Rg/mGVJ9zasl/SBVqvw=
    =
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=JV3rdsiz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=JV3rdsiz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbeCLLn5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 07:43:57 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52343 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751260AbeCLLn4 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 12 Mar 2018 07:43:56 -0400
X-ME-Sender: <xms:_GemWr4SAIGop5m-7vylZzzeMbhmh80kJpThpSqWlObrdyq5zxt7cQ>
Date: Mon, 12 Mar 2018 12:43:58 +0100
From: Greg KH <greg@kroah.com>
To: =?utf-8?B?5p2O5pu45biG?= <leechu729@gmail.com>
Cc: heikki.krogerus@linux.intel.com,
        Guenter Roeck <linux@roeck-us.net>,
        =?utf-8?B?c2h1ZmFuX2xlZSjmnY7mm7jluIYp?= <shufan_lee@richtek.com>,
        =?utf-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>,
        Jun Li <jun.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] Fixes: 8f9439022648("staging: typec: modify parameter of
 tcpci_irq")
Message-ID: <20180312114358.GA1910@kroah.com>
References: <1520848002-3801-1-git-send-email-leechu729@gmail.com>
 <20180312110722.GB10444@kroah.com>
 <CAFaeLdSSqDok6_jaa4wwxuo+71qkv7ha5Rs81B7LvEAsRZDfYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFaeLdSSqDok6_jaa4wwxuo+71qkv7ha5Rs81B7LvEAsRZDfYg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 07:26:07PM +0800, 李書帆 wrote:
> Hi Greg,
> 
> 2018-03-12 19:07 GMT+08:00 Greg KH <greg@kroah.com>:
> > On Mon, Mar 12, 2018 at 05:46:42PM +0800, ShuFan Lee wrote:
> >> From: ShuFan Lee <shufan_lee@richtek.com>
> >
> > Your subject is odd, that line should be below, in the signed-off-by:
> > area, not as the subject of the patch :(
> >
> > Can you fix this up and resend?
> Yes.
> If I understand correctly, the title should be like
> staging: typec: modify parameter of tcpci_irq
> and the "Fixes" tag should be put in the signed-off-by area.

Correct.

> Should it be in the beginning of the area:
> Fixes: 8f9439022648("staging: typec: handle vendor defined part and
> modify drp toggling flow")
> Signed-off-by: xxx
> 
> or the end of the area?
> Signed-off-by: xxx
> Fixes: 8f9439022648("staging: typec: handle vendor defined part and
> modify drp toggling flow")

Either is acceptable, but usually you see the first example here.

thanks,

greg k-h
