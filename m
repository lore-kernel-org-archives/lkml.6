Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2605989-1518864836-2-16162203876766187415
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518864835; b=gEP1AwOGytbUz5GYzbmPZO3dTs0hHASfR3hbivJm+Eo2ppl
    SLz+OidCZUt5sdN4TpT/GGVWSKvQfQhAnoz2fqiPwS2BUdkNohFeRcrLRY5udf1T
    qRoJNN1RxX4m50XaQvcksXzcxd2q6Ay9srX7izjk2FWGUtxWZFe9m9LaYu3mh7tc
    MRlKQ07DoOenkeQrb45QRaJQXpAwzWi/EtjWTL9APQI64wSWuruiL/bEpqXDuOZA
    J/QsUNcgAObdCrTFE3k7EfHTHhR0GozZZPHveMsuXQ2EBNU1bm0lTUZKUkphsTQH
    IwBHqDVe+6PPvwfOujO1ooscRi8y5U3RI49T70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=arctest; t=1518864835; bh=gAP1yRNu7f9wqLON4Vj9eKRH2XF8+Oq0OtJ
    XaqEQIyM=; b=sCfYsHkyC+yIk+ZoSJYmjGA98WAMisuhTKgMs3MUtJb2PjT/4VV
    hP7NSzoRNm2GgfdrOftdtICIUOCqGipJbK/qir95PA/fYYwJpX7rcyPtbYSbTOty
    x/Od+yDiPpmhHZG/YomcO6TKwyunK32UkcJWz1hIBEDEyqxkcb+JUnmDsGdxEnfi
    2UlPmaONogejtlWBhoqtQZTmKcjsz5NE36XC30Ec7ikDIgmsDBoR92dPAqfg/D3M
    i1jwuWjsbSTuRuVLqAI0PzISR6xOoSoGhU785xPfm0DN5wMijCgydE4A6v6xD8ZX
    EkUN9Zi/GRdrLBFLOlFi3uid6FNK4XG9qlg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=googlemail.com header.i=@googlemail.com header.b=fBVQXxVM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=googlemail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LaFvWhwy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=googlemail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=googlemail.com header.i=@googlemail.com header.b=fBVQXxVM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=googlemail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LaFvWhwy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=googlemail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbeBQKxk (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Feb 2018 05:53:40 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:51971 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeBQKxj (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sat, 17 Feb 2018 05:53:39 -0500
X-Google-Smtp-Source: AH8x227xnoYeLCylt8Kpc9mjKf+waHmW2Nq1gFCXJjU4XfuWcAw8pIqQYZyB3KuDgBHdnP8A6PMunQ==
Date: Sat, 17 Feb 2018 11:50:16 +0100 (CET)
From: Hans Ulli Kroll <ulli.kroll@googlemail.com>
X-X-Sender: elektroman@T420s
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/4] usb: gadget: fotg210-udc: Fixes and cleanup
In-Reply-To: <p5sksu$4pc$1@blaine.gmane.org>
Message-ID: <alpine.LNX.2.00.1802171142240.10047@T420s>
References: <cover.1515791144.git.christophe.jaillet@wanadoo.fr> <871shqbnln.fsf@linux.intel.com> <p5sksu$4pc$1@blaine.gmane.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1598662189-1518864616=:10047"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1598662189-1518864616=:10047
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Christophe

On Mon, 12 Feb 2018, Christophe Jaillet wrote:

> Le 12/02/2018 =C3=A0 09:48, Felipe Balbi a =C3=A9crit=C2=A0:
> >=20
[..]

> > way around :-) First fixes, then cleanups. The reason is that fixes can
> > get accepted during -rc cycle, but cleanups must wait until the next
> > merge window.
> >=20
> > Please fix up your patches, otherwise I'll have to apply the entire
> > series for v4.17
> >=20
>=20
> I agree with you. I will be more careful in the future.
> However, I will not re-send an updated version. Development on this drive=
r
> does not seem to be very active.

=2E.. not quite right.
This driver and the fotg210-hcd is *currently* under my observation, I=20
want to add a phy/otg driber on top of these.
Feel free to CC me if you want to resend these patches.

With "not very active" makes me happy, so I don't break not much.
And if anyone ask, I have some devices to test, of cource ;-)

Greetings
Hans Ulli Kroll

--8323329-1598662189-1518864616=:10047--
