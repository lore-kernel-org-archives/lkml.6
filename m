Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61EBECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63043208D8
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTPus0Lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63043208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeGOK3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 06:29:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41850 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeGOK3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 06:29:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17-v6so22792916ljy.8;
        Sun, 15 Jul 2018 03:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+HyWBdjfqLBi1mepU7DJs/MW/qTthDhriv7Kw8BrwGI=;
        b=PTPus0LuFiKeYA4g7cLirU+b8PV2qtiqxOaYea8dyAk43pleZGMvwtftZPCjPSysDc
         9FBcsZjOKyuXwLXxZ4bDMFrJcMJXAylc+zgsrESFzX8o4CF0JCNZnsmMND2VENDv9Ax7
         Wd2cNmhj9KBzH/ERkTKGpFX9MmGGXmSRKhlq1IDZNNgXG7AuPv2LBkRs1sNNPrxu3M/L
         ba/BCxqfAfS6TZBWL/cZN/1zHOZClzICxqXPUcv+ylsK1ypYQMZJ6k/6bYo5XGYnCM/6
         Ri9D3n89wrsQA2qLG+Gt3Di4A5ohkXOPbdCm/GJC7DuvzCevTVMSeHeKa4H4bl+HVnFh
         /ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+HyWBdjfqLBi1mepU7DJs/MW/qTthDhriv7Kw8BrwGI=;
        b=UjjHGS/+SPBSOXoNBK2aQ954B/nEexHuTIFk3be1W2FI1QKxHX/Df9SGa0HXgD5C7e
         Q9l3udK3qZm03lnFdH/vmPLuLSZ9lJRAeDi+2P5QNOhCcynbJyBZ3xt8oKnDEavBwWKG
         0uBP8qqO9xnlLK6SA5AQpnHEB7KpvPrNzG/GYBQBGrbvAZapLw5xW6eQPkLPRaxeDUSv
         F18jHjGFxyDYd1+MAxr5E9BOButE8FY6k5sn1fs7ELzLh0QyWLu1krrewbcKTtD8glGZ
         aA8AFxXz7XVcV/MpyydwsxYNX8bJohBVXHxAMWveA9tGia+F0wUq7A07wfL0k0RZTk0S
         SyMA==
X-Gm-Message-State: AOUpUlGWbejZQg9zvvZO7ZTY9DBcqoMS/lUzdbLirsMfZueXRe8pk+Pi
        8ajiNTpFO4IJYYKVRWFSGA4t7rpsOYQuMi6PQWhJZg==
X-Google-Smtp-Source: AAOMgpcvlKdgDY5C9T2u1m2v/PNVlHEetkE8fJxYHj/spXE4hhuKSFKpBz57z/a60KeAnJsNL6MUF6TGE0ezyY2b3Rg=
X-Received: by 2002:a2e:9c0f:: with SMTP id s15-v6mr3487146lji.97.1531649204912;
 Sun, 15 Jul 2018 03:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <1531512477-31981-1-git-send-email-khoroshilov@ispras.ru>
 <20180714080920.GA15123@gmail.com> <20180714085109.mbhk6aybpjsbuq6l@penguin> <20180715074225.GB15123@gmail.com>
In-Reply-To: <20180715074225.GB15123@gmail.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Sun, 15 Jul 2018 13:06:32 +0300
Message-ID: <CAKdAkRS0NBOo7thkevZAQXBWt_ReppjdPz6a6PQ6LtJHbPYgVg@mail.gmail.com>
Subject: Re: [PATCH] Input: pxrc - fix leak of usb_device
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 10:42 AM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> On Sat, Jul 14, 2018 at 08:51:09AM +0000, Dmitry Torokhov wrote:
> > On Sat, Jul 14, 2018 at 10:09:20AM +0200, Marcus Folkesson wrote:
> > > Hi Alexey,
> > >
> > > Good catch!
> > >
> > > On Fri, Jul 13, 2018 at 11:07:57PM +0300, Alexey Khoroshilov wrote:
> > > > pxrc_probe() calls usb_get_dev(), but there is no usb_put_dev()
> > > > anywhere in the driver.
> > > >
> > > > The patch adds one to error handling code and to pxrc_disconnect().
> > > >
> > > > Found by Linux Driver Verification project (linuxtesting.org).
> > > >
> > > > Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> > >
> > > Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> >
> > Hmm, the biggest question however if we need to "take" the device, as I
> > do not think interface can outlive the device, and whether we actually
> > need to store it in pxrc, as we only need it during set up, as far as I
> > can see.
>
> Yep, the device is only used during setup.
> I interpret the comments for usb_get_dev() as you should take a
> reference count on the device even if you only use the interface, but I
> could be wrong.
>
> From usb_get_dev()::
>
>          * usb_get_dev - increments the reference count of the usb device structure
>          * @dev: the device being referenced
>          *
>          * Each live reference to a device should be refcounted.
>          *
>          * Drivers for USB interfaces should normally record such references in
>          * their probe() methods, when they bind to an interface, and release
>          * them by calling usb_put_dev(), in their disconnect() methods.

Hmm, usb device is a parent of usb interface so our driver model rules
ensure that usb device should not disappear while interface device is
still there. Greg, is this comment still valid?

>
> I can fix the driver to not take the device if that is what we want.
> If not Alexey want to fix it of course, it is his catch :-)

Yeah, I'd prefer doing this if possible.

Thanks.

-- 
Dmitry
