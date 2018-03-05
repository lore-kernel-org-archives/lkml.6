Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2281721-1520276267-2-12780030406445485338
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520276266; b=sioJ2hDrX++gmqh/wZNlNcPUR+GuHhi4rmYuda2qYRjRa4L
    yNr/sOBbEf5CCqj1nUsDspTOtGgJrTq37QHEuPhq40N1SH9jK+NbIzMdHD/54on+
    yTFf0dzekvXF78yFe9Svjn7Lu6n8gdIXKfDentEULZDq8rW+a9PIQmzfKN9WtuZv
    7NznWXtI6n1j217OAOoj6fKkfNa/pGVavuthiMPy3c+Co2Q8wj6bYXiIjguPhz8e
    tPEoO163PzKTDq2XCyiW4S4L/UU4XDNsjR8ikToltIcfAi+SmIIaU1vSJFkWVvwp
    YUKRDBhLmJcTfSgtlZD4fVtM+JSBiIcZW+bu8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520276266; bh=xVqj88jnM/2k9oP4MG2pxE9zLl
    IPPAz0z2j+wArLOAQ=; b=PhmoOdAtE+mW2VWUAB8qW96mHuS69w4+/LyzhfsLQt
    YVDfYky96CR8YSWatrdHtdV6qW06clUFQIdWDGsLGOgL2d8FwzbQeqIorhyot+Pq
    vZuip+NaHItzEln3gnGWxfNGbCdpZVAiJNjxUoUe8qCwpnWLxUjRGqw8VYdYUn99
    YpfRX/SuRNsALUeo3NdhbKAT45mPazh8kL5TqTjOcoMHzK10QFoRQqR7PL4Hc12O
    IgVxo4VI0eQRN96uk2kBRg8RBbrsuv+b8I5sE7kklK2RInQSKV9m+cIUP+92fZyd
    CxyPcWmvlY9Zu3bo50+/jM8H4tJuV4x+rkI6xMislsVQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=O0N8Zbg4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=O0N8Zbg4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752756AbeCES5d (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 13:57:33 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:16505 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752586AbeCES5a (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 5 Mar 2018 13:57:30 -0500
Date: Mon, 5 Mar 2018 12:57:27 -0600
From: Bin Liu <b-liu@ti.com>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
CC: Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        <linux-omap@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] usb: musb: call pm_runtime_{get,put}_sync before
 reading vbus registers
Message-ID: <20180305185727.GC14921@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>, linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180227222740.2150-1-merlijn@wizzup.org>
 <20180227222740.2150-2-merlijn@wizzup.org>
 <20180228215943.GI5448@atomide.com>
 <20180305173802.GB14921@uda0271908>
 <6583654d-5250-a8a9-42e7-6b9990cd538c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6583654d-5250-a8a9-42e7-6b9990cd538c@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 08:35:10PM +0200, Ivaylo Dimitrov wrote:
> Hi,
> 
> On  5.03.2018 19:38, Bin Liu wrote:
> >On Wed, Feb 28, 2018 at 01:59:43PM -0800, Tony Lindgren wrote:
> >>* Merlijn Wajer <merlijn@wizzup.org> [180227 22:29]:
> >>>Without pm_runtime_{get,put}_sync calls in place, reading
> >>>vbus status via /sys causes the following error:
> >>>
> >>>Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0ab060
> >>>pgd = b333e822
> >>>[fa0ab060] *pgd=48011452(bad)
> >>>
> >>>[<c05261b0>] (musb_default_readb) from [<c0525bd0>] (musb_vbus_show+0x58/0xe4)
> >>>[<c0525bd0>] (musb_vbus_show) from [<c04c0148>] (dev_attr_show+0x20/0x44)
> >>>[<c04c0148>] (dev_attr_show) from [<c0259f74>] (sysfs_kf_seq_show+0x80/0xdc)
> >>>[<c0259f74>] (sysfs_kf_seq_show) from [<c0210bac>] (seq_read+0x250/0x448)
> >>>[<c0210bac>] (seq_read) from [<c01edb40>] (__vfs_read+0x1c/0x118)
> >>>[<c01edb40>] (__vfs_read) from [<c01edccc>] (vfs_read+0x90/0x144)
> >>>[<c01edccc>] (vfs_read) from [<c01ee1d0>] (SyS_read+0x3c/0x74)
> >>>[<c01ee1d0>] (SyS_read) from [<c0106fe0>] (ret_fast_syscall+0x0/0x54)
> >>>
> >>>Solution was suggested by Tony Lindgren <tony@atomide.com>.
> >>>
> >>>Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
> >>
> >>Thanks for fixing this. Assuming it passes Bin's tests:
> >>
> >>Acked-by: Tony Lindgren <tony@atomide.com>
> >
> >Applied and sent out. Thanks.
> >
> 
> What about stable kernels? Shouldn't this be fixed there as well?

Yes, it should, but I need to figure out which stables to send to and I
am busy in something at the moment. So I will send it @stable some time
later.

Regards,
-Bin.
