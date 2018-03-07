Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3903547-1520447432-2-13477903344961356270
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  RCVD_IN_SBL_CSS 3.335, RCVD_IN_SORBS_WEB 1.5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520447432; b=WDxk14A0se1k5hhmM7G4PbdXnv1nbzF1P31SAJHPHMRWwbu
    c/OfNn3qFR9zDGJRUpJ1bFGdwPYC5QBNfJMblQEpp6hIjZWEmJaG/U13YHMco11K
    uLQdZDhYDzq0Zk6opTr66EA5rPrFpMEF9k0HRKL7soMXTNcQRZpVTnJ1sL+zf1TH
    z0GwyRmQ/Kbe3xwPs8ABv4UnumabHccML/u3BSkqMhW92ZBUlF6c1AAj5NVqX0qI
    ijYBsb8fbmo1UEspuxjR/aAJJmflPWGoBUyP1c+k4747i0lLwtdp8yOlDLNTKOCe
    OXEfQZFM/J2jPwzEK5I9UF/Rh9kog8hZjjipfhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520447432; bh=Fki70N72I3iTpWWhPeOJjf+q7L
    cPNMHalYoLi4Zl1m0=; b=Gjw+ZkEaKgZ63v9TrT4fMSSVSEZNKXIa26laOZcAL8
    hC+l9dzV/vz2UzkYB0iD9Id4v+TW2DxtHskFmaz+gMgG/KECkj62JeyMBtmKo5CA
    QDHJSpDXGXmEujby46fHLoxH/QZhRxM3F+2xMb+CaWgxiqegl0xS80T2Z27D40hZ
    ItvlSzqXqZKXUshSfG0qriGVjOyIHJIJpVqnYlArGQ7kMQq6qvtoIIr11y4RooWK
    ttNGulozWbvHlq3DdO6LJruNKmodCugBBNpcIba2rTzyzG+tLaSaPCbZE4V17bFY
    AO9OlUfFdUWjaJ/lt5aE9DXEgQJgxdBHMvAvzexKq2gQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UDbWps+p x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jG42+pvE;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UDbWps+p x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jG42+pvE;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754613AbeCGSa3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 13:30:29 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41699 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754388AbeCGSa0 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 7 Mar 2018 13:30:26 -0500
X-Google-Smtp-Source: AG47ELuaHYvxSBtFWQkxhWK1nyta/ViK7YAa2cl1/eQbRJrOUA/R6OcRjCPK1gLeLDniJrdFOlK8UA==
Date: Thu, 8 Mar 2018 00:00:19 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: isp1760: Use kasprintf
Message-ID: <20180307183019.GA12917@himanshu-Vostro-3559>
References: <1520446082-12264-1-git-send-email-himanshujha199640@gmail.com>
 <CAHp75VfEvKfQ2pp6wG5BXjB38egr_ocQ_dwSXifmj5MwAyNSAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfEvKfQ2pp6wG5BXjB38egr_ocQ_dwSXifmj5MwAyNSAA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 08:20:54PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 7, 2018 at 8:08 PM, Himanshu Jha
> <himanshujha199640@gmail.com> wrote:
> > Use kasprintf instead of combination of kmalloc and sprintf and
> > therefore avoid unnecessary computation of string length.
> 
> >         devname = dev_name(isp->dev);
> 
> Do you still need this temporary variable?

No.

> > -       udc->irqname = kmalloc(strlen(devname) + 7, GFP_KERNEL);
> > +       udc->irqname = kasprintf(GFP_KERNEL, "%s (udc)", devname);
> 
> Perhaps
> 
> devname -> dev_name(isp->dev)
> 
> ?

Oh, yes!
Thanks for pointing that out.
I will send v2 with the update!

-- 
Thanks
Himanshu Jha
