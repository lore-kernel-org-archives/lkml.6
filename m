Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74255C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275492086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1R8d4s4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275492086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeJHXM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:12:58 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38210 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJHXM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:12:58 -0400
Received: by mail-it1-f193.google.com with SMTP id i76-v6so12604423ita.3;
        Mon, 08 Oct 2018 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J4/246FRXaFoFIMZTarL+KPjoi5SLQOe+iJLr5jF/7I=;
        b=k1R8d4s4uSbkEox6wWNb6XBV1QlmUb2pU36boaBLIuO3xKBzGdwV8++RBH6oAdVpAm
         y0mL55vIf2BTgl1AUIRV/gthuK+6MiV7XRUpld3lSCflO0gS8OCdyuV3XdPSnD6aRqwh
         LWM4+SMhGFy91u1F+pVqCGdzJOS4kPsSLi4SKu0C/XhD6Pij1zy2JPhL1xdENKacxOgB
         AuCnQlwyWE08sJOt5uli554yx1Z7VZy6451ewIzYJZ+Apik17x5fZSz+GaQBVh7Zm/AI
         wdom+lVdbKynuSEsilrUVu7QQg8Rj7JKbPnHhIguaOG2S0zCja0e2msTJeFgGeQIPN3p
         J+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J4/246FRXaFoFIMZTarL+KPjoi5SLQOe+iJLr5jF/7I=;
        b=bnYY1Ymwa9QDC1y2lLEPvsIPY0vD75N+grEKB3sol3tKnmbzEK5V2P6AzP0+nIFwlS
         MdLlmZs/JDA77ILny29kqt5Y/UFeD7Z/TL7SmcV+QsJ0TqvE4MaHcn4Sq9JDK0MAbR6L
         gVnV4thMcVDHaqvle1BXq5mf1PPai4DHCOYAHNbeQRwK/VT3wwsHj8QAP8tqdtN+0wW0
         Bz1ebL4/bkoXyCS4TEHq1a9z+R/5nB36QKZuXoEEEY0oRI6xtScvKIxHA5G2FkstHSbL
         QFAGitsnKhIRYG/mqwQ8IwB2Hf1RXYULw7RpFXVLM1i61aGsxJJenMGK+q9C4vslnxkO
         uYPA==
X-Gm-Message-State: ABuFfojOSw4yMTeESWxnzhpHxHvq5Hb3wElHNdojZv17JISA6JCBVDxr
        04Z2JJdFhmkdRKxL04lHoiUk+L2KlYip9E1rcTg=
X-Google-Smtp-Source: ACcGV630eVBhuxCfm7V3hfWXH3wtGdXrD6EnOcX5lz5CM0wMDmwfk5TqiIcsGWrgaC8dlX8oTfm5AV3nWc1UO6hxdTA=
X-Received: by 2002:a24:cd02:: with SMTP id l2-v6mr15245017itg.70.1539014431298;
 Mon, 08 Oct 2018 09:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181005161845.959919-1-arnd@arndb.de> <CAOi1vP8Wy0DjEWBWh05iSx-RJS41hTc1rs2TXdz_1mcNpf68Dg@mail.gmail.com>
 <CAK8P3a0xpFdKC0AtBDC9UvMfwpx3HTbAdio4ApmYhrb2FakK9g@mail.gmail.com>
In-Reply-To: <CAK8P3a0xpFdKC0AtBDC9UvMfwpx3HTbAdio4ApmYhrb2FakK9g@mail.gmail.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 8 Oct 2018 18:00:19 +0200
Message-ID: <CAOi1vP-bQR6aEbmyxUGtxTQACUbT2iEXr5Ld3w0p04_NWWxXuQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: use an enum instead of 'static const' to define constants
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>, pombredanne@nexb.com,
        Luis Henriques <lhenriques@suse.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 5:37 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Oct 8, 2018 at 4:23 PM Ilya Dryomov <idryomov@gmail.com> wrote:
> > On Fri, Oct 5, 2018 at 6:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > @@ -71,7 +71,7 @@
> > >   * This ensures that no two versions who have different meanings for
> > >   * the bit ever speak to each other.
> > >   */
> > > -
> > > +enum ceph_features {
> > >  DEFINE_CEPH_FEATURE( 0, 1, UID)
> > >  DEFINE_CEPH_FEATURE( 1, 1, NOSRCADDR)
> > >  DEFINE_CEPH_FEATURE_RETIRED( 2, 1, MONCLOCKCHECK, JEWEL, LUMINOUS)
> > > @@ -170,13 +170,13 @@ DEFINE_CEPH_FEATURE(61, 1, CEPHX_V2)             // *do not share this bit*
> > >
> > >  DEFINE_CEPH_FEATURE(62, 1, RESERVED)           // do not use; used as a sentinal
> > >  DEFINE_CEPH_FEATURE_DEPRECATED(63, 1, RESERVED_BROKEN, LUMINOUS) // client-facing
> > > -
> > > +};
> >
> > I don't particularly like this because it looks like lower constants
> > are actually ints and the rest are unsigned longs, even though they all
> > have ULL suffixes.  The standard seems to require that enum constants
> > be representable as ints, is the non-pedantic behaviour documented
> > somewhere?
>
> I had not realized that this is a gcc extension, or that it behaves slightly
> differently from the standard C++ behavior that apparently adopted a
> saner variant (all values in an enum have the same type).
>
> How about we just add a __maybe_unused to DEFINE_CEPH_FEATURE
> then to shut up the warning?

Fine with me.

Thanks,

                Ilya
