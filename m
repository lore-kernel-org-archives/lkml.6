Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1088053-1520237319-2-6586096903630297994
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520237319; b=WC0z3ias3W4Gou4KkcCHDOdmsbhEPE01YUBi8o536yujrfM
    2JWBppEwZnpFTmGsRtXThVmzpgdEq4sJaE7JCUlobgL74+CSd7T6jz96lMWICIpJ
    BhQav/YQ8pOKtkm+GH01VTDxJr36LM4E3sa4AFCL5ECE5iNWdqbtbrVGLSpOu6AA
    8Nna1P8GPOp8+MqtWEhVJD+EIWLIVe5S287cSfooOuHlPhWCMV4zc2V5sh8wAAqq
    TA4fwgBXh09G6wLsVTbCO9Ltn+gzm9QD3GfMw8MSmyY4thoIeac/KfJ210cYOo74
    UMdJSgPk0wkkQ5Njt5ZeKwKub8gmAZ50HGLwiLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520237319; bh=h6e0sIUEA6DUJxJvZDj1jWudpHkv8MCLtg3CW2
    uzyR8=; b=MUjf6/w3MvwCb6XsG8WDAAEnn0bjwUiTS5QUrUO054MhEKrpTnC++6
    9flujQbQcO5FouYkZzJwWOYHwG2uBttev315PnTMRIlClc3vOD2hQQAhEGOYDExZ
    G3l7Yfcw5Wk7Oo0C3NeddH4osURDzIYefkaHjvkpBZAbhF7tDP+7reVrSJiMxTP3
    w3ILq7i4C6ca/n/2YWc6frhY3sx5nATv+y7R2ZzW7xt65fAvPkcA7p5ThBJ2IbRp
    qzg63TIYqimcnev0++e4aRGbtrF1wJkg1R7IFYgz9D+7cVKXyqhfWeJ8b19F4hQb
    aOGarfxzm8hDhyJFscyO4sJUGvIbLN3g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=YSpoQ9XC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Yy0Mkz1X;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=YSpoQ9XC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Yy0Mkz1X;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeCEIIe (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 03:08:34 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42266 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752274AbeCEIId (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 03:08:33 -0500
X-Google-Smtp-Source: AG47ELusdwIpgBLvHxAN4vkz0iDGZUqCKSu68JTzDBjIKS9IHqqmf3OqG+NSgOvdpcqGZxR2+Lld64IyuEfklD2ousU=
MIME-Version: 1.0
In-Reply-To: <CAD0t5oMGrJu_9D_8wvLoQPPs-fJ7Qot4W-P_qYE7ikJQGKRSOA@mail.gmail.com>
References: <1516375450-30575-1-git-send-email-geert+renesas@glider.be>
 <1516375450-30575-3-git-send-email-geert+renesas@glider.be> <CAD0t5oMGrJu_9D_8wvLoQPPs-fJ7Qot4W-P_qYE7ikJQGKRSOA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Mar 2018 09:08:32 +0100
X-Google-Sender-Auth: XqZr_x1pkcoWMtOklbzpD5hnILU
Message-ID: <CAMuHMdXqANJGm-vZjwMF0TYwWQcUe9F0v5aNSv_YQNoRZJzXmw@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: amba: Fix race condition with driver_override
To: Todd Kjos <tkjos@android.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>,
        Antonios Motakis <a.motakis@virtualopensystems.com>,
        Adrian Salido <salidoa@google.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Todd,

On Fri, Mar 2, 2018 at 7:23 PM, Todd Kjos <tkjos@android.com> wrote:
> +stable
>
> what is the status of this patch? We'd like to get it into the android
> common branches to fix possible double free.

Thanks for your interest!

So far this patch (and the 3 others in the series) haven't received any
comments. If someone sends a Acked-by or Reviewed-by, I can submit them
to RMK's patch system.

Thanks!

> On Fri, Jan 19, 2018 at 7:24 AM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> The driver_override implementation is susceptible to a race condition
>> when different threads are reading vs storing a different driver
>> override.  Add locking to avoid this race condition.
>>
>> Cfr. commits 6265539776a0810b ("driver core: platform: fix race
>> condition with driver_override") and 9561475db680f714 ("PCI: Fix race
>> condition with driver_override").
>>
>> Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
