Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CD1C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230B92184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L8GygvYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfAWUg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:36:29 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33846 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfAWUg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:36:28 -0500
Received: by mail-ua1-f68.google.com with SMTP id c24so1206945uak.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 12:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFCkOF2gK3wr1UB995eD+/CTWS4iazBBfFIZUEffwxc=;
        b=L8GygvYwk5FYD+Ce0ML1TRQbDfEIv0oR+ZZMDgwVJntrdffAzAT1EMjtnCS4Vm7kGF
         9dyJBTPuJm07cjZsS/xzizI42KQnMArMr2N3CLtPSslUeR/3lApJBdvCmKdyWI0HKF0C
         Vq7eIyo8gjyd5kPrv1YhbaPvpYIMVU0STBBf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFCkOF2gK3wr1UB995eD+/CTWS4iazBBfFIZUEffwxc=;
        b=pdRAYogogA9o6OWZYm2xB10edMydWr6mys2X+SHVKSSey1v7pHxckxLuGGifyUIjvb
         4Etv4RzTLziSEUObRwlJIEs8LlP9EvT8u+gjx+2JvlApcfjA0Gtj9mwyuuaVYWgeWclq
         Evglt9jhmmWErDkoayciN0vw5kDImDDHqSMtB9cGpehMpPHAspOxcORoYcPfVGPLbyIT
         aaFzkGbWGL/uy6WYs5nSc4zFfOmizPt8lu/jgMTEks7qQwIaNkJyF0dXTmYPcldardQK
         k3pJhySixd9xLcSVtrki5mAH4/DtgK1l6e+dnb6FSRFDeGGcdkiWe8edpbLFKGtS8NR/
         etJg==
X-Gm-Message-State: AJcUukfSjwndX8CWmbHbAhwS4nTOmtVLTB0ryctW9p8UlDSv7ieN+IQ7
        hPvVb6KZapxZbcPPBh93biIBmsYmMcw=
X-Google-Smtp-Source: ALg8bN4wFgGXVC5CClGatElKWKCSXEtAgIs15Q30EJcXqE4d5STZgRMLi9lMpi/I1emTiZ4RWcGMvA==
X-Received: by 2002:a9f:300d:: with SMTP id h13mr1577506uab.80.1548275786904;
        Wed, 23 Jan 2019 12:36:26 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id s195sm23378139vks.28.2019.01.23.12.36.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:36:24 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id b74so2135200vsd.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 12:36:23 -0800 (PST)
X-Received: by 2002:a67:e199:: with SMTP id e25mr1560245vsl.188.1548275782895;
 Wed, 23 Jan 2019 12:36:22 -0800 (PST)
MIME-Version: 1.0
References: <20190123110349.35882-1-keescook@chromium.org> <20190123110349.35882-2-keescook@chromium.org>
 <20190123115829.GA31385@kroah.com> <874l9z31c5.fsf@intel.com> <20190123191802.GB15311@bombadil.infradead.org>
In-Reply-To: <20190123191802.GB15311@bombadil.infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 24 Jan 2019 09:36:11 +1300
X-Gmail-Original-Message-ID: <CAGXu5jLNvHVhbyr5Cbyoe8o0ARv52sU-NEpD+u2UYfESM3ofCw@mail.gmail.com>
Message-ID: <CAGXu5jLNvHVhbyr5Cbyoe8o0ARv52sU-NEpD+u2UYfESM3ofCw@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 1/3] treewide: Lift switch variables out of switches
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>, dev@openvswitch.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Network Development <netdev@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Linux-MM <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        intel-wired-lan@lists.osuosl.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Laura Abbott <labbott@redhat.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 8:18 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jan 23, 2019 at 04:17:30PM +0200, Jani Nikula wrote:
> > Can't have:
> >
> >       switch (i) {
> >               int j;
> >       case 0:
> >               /* ... */
> >       }
> >
> > because it can't be turned into:
> >
> >       switch (i) {
> >               int j = 0; /* not valid C */
> >       case 0:
> >               /* ... */
> >       }
> >
> > but can have e.g.:
> >
> >       switch (i) {
> >       case 0:
> >               {
> >                       int j = 0;
> >                       /* ... */
> >               }
> >       }
> >
> > I think Kees' approach of moving such variable declarations to the
> > enclosing block scope is better than adding another nesting block.
>
> Another nesting level would be bad, but I think this is OK:
>
>         switch (i) {
>         case 0: {
>                 int j = 0;
>                 /* ... */
>         }
>         case 1: {
>                 void *p = q;
>                 /* ... */
>         }
>         }
>
> I can imagine Kees' patch might have a bad effect on stack consumption,
> unless GCC can be relied on to be smart enough to notice the
> non-overlapping liveness of the vriables and use the same stack slots
> for both.

GCC is reasonable at this. The main issue, though, was most of these
places were using the variables in multiple case statements, so they
couldn't be limited to a single block (or they'd need to be manually
repeated in each block, which is even more ugly, IMO).

Whatever the consensus, I'm happy to tweak the patch.

Thanks!

-- 
Kees Cook
