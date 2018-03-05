Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2389728-1520278137-2-2499075568283120169
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='iso-8859-1', plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520278136; b=s5N7EH5Dzzqe5pmkjYRcIes/0K5+HekhJYhXwVAOQ3Wx/hp
    QS1xb3cBxxzKCr5lHA9OcAevl3pcl8Gdy2xBiFQfCzghYDiy49JXTQJ/1nDYByj7
    iIv4F4Xz9GLyi05suu3VU59PrW6MXX4q0Izci8Nl6AFC9J+7LOUoX+c3DlWXGMVW
    ueisvQdLqGkGgK5/PoM/QIEOz6w5WWDGT9vVgKEjPQQ0Jpw1GiLNzPHO/WGgBwQn
    Medjoc7Ek8l2hyODviURZKsHNuOg8RutxNXYI9eNiVRLnhhD3tPAoaRuYXsGqm1e
    fXBPhsG9TYRbZpQS9eG1T+JIybKbcqFB6TTATqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1520278136; bh=L9ChD1w
    fd+XDyC0Ae7hc8K6Imn4v0tOeQoVAbxZKKIc=; b=YldSWL6FYQVByUevvXxJFQo
    GgHUAaOXOdkO6NNCA/X6L8bJTwj9v9rxc8R9tb9MpYWog6urlDHgxmBndfM8Xl9c
    LHbW2GaevVN33yt9eeLP5PD0wCRiIYEedTge4Rl/2UjOpYd97J0pvGjBxyremkk7
    PBNVTWSgcFhrs88tsRPHX2GHvKdOxO3h6w9GWZjiH9ku3yO35u559NbInCqeFc0H
    DGjTz8LFM4w+Lwv7SciEm7ZgiTG4t2tEFHX5bsYNoKDIYVm2ZoMYnR/2dfimxlIj
    AvO2YQ18u/L98Gy0l7K9CgLjLAzE+P++sGtSC4jRkflG+3s3rdf0WstWqliQ0CA=
    =
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=o+fDE0eZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=o+fDE0eZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeCET2r (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 14:28:47 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:26513 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbeCET2p (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 5 Mar 2018 14:28:45 -0500
Date: Mon, 5 Mar 2018 13:28:44 -0600
From: Bin Liu <b-liu@ti.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
CC: Merlijn Wajer <merlijn@wizzup.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        <linux-omap@vger.kernel.org>
Subject: Re: usb: musb: "(null)" in sysfs mode file after disabling a gadget
 (and at other times, system hangs)
Message-ID: <20180305192844.GE14921@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-omap@vger.kernel.org
References: <f7a8cfac-e70b-046a-b465-7b37630d5d86@wizzup.org>
 <20180302152712.GA22262@uda0271908>
 <d2ade131-d6d1-72f9-f2df-78e2bef82ca3@wizzup.org>
 <20180302165439.62xw4slhhupy4vy5@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180302165439.62xw4slhhupy4vy5@pali>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Merlijn,

On Fri, Mar 02, 2018 at 05:54:39PM +0100, Pali Rohár wrote:
> On Friday 02 March 2018 17:47:52 Merlijn Wajer wrote:
> > >> I would expect it to state "b_idle" instead of "(null)".
> > > 
> > > Actually, I'd like to see (null) whenever a gadget driver is not loaded,
> > > which indicates a gadget is not bound to the udc.
> > 
> > Hm... Sounds fine to me. I'm using this mode in combination with the usb
> > phy (vbus property) to detect if the phone is detect to a 'dumb' charger
> > of a PC, but I can just always have a gadget loaded -- same as before,
> > really.
> 
> For detection if wallcharger or pc usb charger is connected, there is
> isp1704_charger driver. It uses some standard ULPI interface. It reports
> current_max and type (DCP - dedicated, CDP or just usb).

The musb udc driver sets the state to b_idle without checking a
gadget driver, this should be cleaned up. I have add this in my backlog.
But if this issue doesn't bother you much right now, I will make the
action low priority and address it later whenever I got time. (likely
not very soon, I have a hand full of musb driver bugs to fix...)

Regards,
-Bin.
