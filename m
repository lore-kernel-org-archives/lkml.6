Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-540544-1520347034-2-11967870269569037521
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520347033; b=k82qloC3zeqAK+AuPxfZQz+Lb+W7qqMoY1muQ9liMJUk5RB
    bqHNTlMCW+n4cjv6WBeqUfsXSWy+JN/QZLe5inWWZkdSYKCQWEct39wf9jgZuAW6
    uFLkPkLurRerknsemn+Q/rmc9159kEg2B2R3rhruN8+5UizM77GfDMPHjn3sg6Sj
    VX/gMotN34Ur/Jt9NCpgK8k+8etInFAqKroC3+q1azVbuVgnzgFtHD5gJUn95YJ4
    xl1F9P1NWXI/IIqT1RGKnvzywUcadQHqtsBBa8Yge5sKPbbGBvVxO2IPxuhZ4JXM
    i6IrsicK+7nUPEFnLCa+jfqwYgaGifDQ8IqDjmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520347033; bh=023zm5iX1JrmERNS3rzdroJup6
    dwDkQ9snGluYx6HJ4=; b=ITM7x6okztIyHfo4GAzEfJJfW90gsJV8MZBTLghWmt
    FQil7kvrFaB1fxIm5js/ma0c1GywXaIxeo6GL1aXSGxt0yZJQHNvho/wcZo2wzU3
    PgZJcpFiIKWC+pHDsesbVdet351nrSRXuxkpMwanww35R/5NKtSKpp9T8fpR5G42
    aHslj4BPhJN8i1YCZej5hZWkE2o+t31Tf8WbJalTpGZ3IcE4VwhjTiVt7TXWfTTl
    bn3KB/WCWXjo+An2ekLN7ks0ojl+5A483ftbvKfKi69qCTkjzvDeEWQA25rwhkbL
    HQoSsmHhKS0XyjCFFHw9QSGVlkrgvgxbWj2m1jwT2nxQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=egoBdYmH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=egoBdYmH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753308AbeCFOhD (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 09:37:03 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:59986 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeCFOhB (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 6 Mar 2018 09:37:01 -0500
Date: Tue, 6 Mar 2018 08:36:59 -0600
From: Bin Liu <b-liu@ti.com>
To: Merlijn Wajer <merlijn@wizzup.org>
CC: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        <linux-omap@vger.kernel.org>
Subject: Re: usb: musb: "(null)" in sysfs mode file after disabling a gadget
 (and at other times, system hangs)
Message-ID: <20180306143659.GG14921@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-omap@vger.kernel.org
References: <f7a8cfac-e70b-046a-b465-7b37630d5d86@wizzup.org>
 <20180302152712.GA22262@uda0271908>
 <d2ade131-d6d1-72f9-f2df-78e2bef82ca3@wizzup.org>
 <20180302165439.62xw4slhhupy4vy5@pali>
 <20180305192844.GE14921@uda0271908>
 <54fc4244-2584-f63d-23be-9e0413bcbee4@wizzup.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <54fc4244-2584-f63d-23be-9e0413bcbee4@wizzup.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 08:44:40PM +0100, Merlijn Wajer wrote:
> Hi Bin,
> 
> On 05/03/18 20:28, Bin Liu wrote:
> 
> > The musb udc driver sets the state to b_idle without checking a
> > gadget driver, this should be cleaned up. I have add this in my backlog.
> > But if this issue doesn't bother you much right now, I will make the
> > action low priority and address it later whenever I got time. (likely
> > not very soon, I have a hand full of musb driver bugs to fix...)
> 
> I can try to fix it this (or next) week. Do you have a pointer for me?

Quickly looking at the code, musb->xceiv->otg->state is set to OTG_STATE_B_IDLE
in musb_init_controller(), musb_gadget_setup(), musb_gadget_start(), and
musb_g_disconnect(). I am not sure if there is redundancy, and gadget
driver should be checked in some of them.

Regards,
-Bin.
