Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2564C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A916206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Su3YQ6/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A916206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbeIHCjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:39:23 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41554 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeIHCjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:39:22 -0400
Received: by mail-yb1-f195.google.com with SMTP id u33-v6so5974666ybi.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 14:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2TfObS/QnF8SWZjeazWZ2ELxavgj9Eo9gEo+GsZvLE=;
        b=Su3YQ6/UkPVMqB6rGaOWTx4c1h63VAEPgvBiyKQZH/fhoxbz416ouIEyxLnIjKA4oI
         Ooj8CPNgzr5Ot3CB5CUp6BO4iTHnUeeYVjYtDwAP0oQuGDy5QrUwBzWsZ8/nfSRADIa1
         aKCXFdWKxgEu1npC/qjK/Ltzt6CLrsYy/4uPCMcf+wrMfULP5ug33xKV/TpDwXyXjGK7
         tc3SLmejDj1p9byQp3HqSbIv4sCx9TaidUAhgYWoNElLS68tyWYHX6f09gezv/qCR7ww
         FaS5Nku9O97kZM0h8jDNZ5+V5QAexrYADvdvNCeA+YLFAbqeDUqRzmvq38ZdAlDOYadV
         4wmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2TfObS/QnF8SWZjeazWZ2ELxavgj9Eo9gEo+GsZvLE=;
        b=dsxGOgiZGTXPLdu3U+PsMrfdN8Efi7oQCb57e08a+yPF7Un6GGnwAFAjPSKHw4WNiR
         dyf0sHgT0VBnriFnCxWsR1fa38KIR4XJXkRc6u7zsDuu4ZubpQ/FwVWNhPxADNHp0QFS
         7rHfCbZwgbB7IcG5GDvkI+mLJ5PkYWYLw9n4urrKaduQUR/T90w2MJo7SSadrwtzbvKl
         djXrqtStZ+aMz9OxmX8r+thV8hGg6hBPbUuf94MwmUesug9D5XqW2m0aCKPfmXGvJQJR
         vsdOoww/WP1m2PnJkRt42brmbWPXr/iaDRb3H5UD1DyHqWQkGtr9vSLYlN2c+oDTGVyz
         jXXQ==
X-Gm-Message-State: APzg51Dt3Olp3QXFOsE0ROkip2fdbq1IolEfFIvgH50eIiKRpaiK4vcv
        VUvcNjVXjpZlENZIrGjwfONfbwhHGIullqd0fSdcIQ==
X-Google-Smtp-Source: ANB0VdYZoF16gMS8KCX27mpfXK5eCdHI4277kaVmY/yrR5bAUz0diCWf+I1UcRZmIsFjL8y0Jd65cx5iicFlufwbl7A=
X-Received: by 2002:a25:3cf:: with SMTP id 198-v6mr5071305ybd.414.1536357382317;
 Fri, 07 Sep 2018 14:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180907211012.965501324@linuxfoundation.org> <20180907211013.141014795@linuxfoundation.org>
 <CABXOdTdnU51wjwy7g3oXK2+6dC9Qps_Zy8nN_zZevDXUvN8Y4A@mail.gmail.com>
In-Reply-To: <CABXOdTdnU51wjwy7g3oXK2+6dC9Qps_Zy8nN_zZevDXUvN8Y4A@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 7 Sep 2018 14:56:11 -0700
Message-ID: <CABXOdTdeVhhCPWUmbX0ZFq5Bb02=J9o9NLCPq71cwW3v5yGtKg@mail.gmail.com>
Subject: Re: [PATCH 4.9 03/63] 9p/net: Fix zero-copy path in the 9p virtio transport
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "# v4 . 10+" <stable@vger.kernel.org>,
        Chirantan Ekbote <chirantan@chromium.org>, groug@kaod.org,
        Dylan Reid <dgreid@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, dominique.martinet@cea.fr
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 2:54 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Fri, Sep 7, 2018 at 2:34 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> >
>
> Do your scripts have a bad hair day ? The subject says 4.18.
>
Hmm, I suspect it is the gmail UI messing with me. Sorry for the noise.

Guenter

> Guenter
>
> > ------------------
> >
> > From: Chirantan Ekbote <chirantan@chromium.org>
> >
> > commit d28c756caee6e414d9ba367d0b92da24145af2a8 upstream.
> >
> > The zero-copy optimization when reading or writing large chunks of data
> > is quite useful.  However, the 9p messages created through the zero-copy
> > write path have an incorrect message size: it should be the size of the
> > header + size of the data being written but instead it's just the size
> > of the header.
> >
> > This only works if the server ignores the size field of the message and
> > otherwise breaks the framing of the protocol. Fix this by re-writing the
> > message size field with the correct value.
> >
> > Tested by running `dd if=/dev/zero of=out bs=4k count=1` inside a
> > virtio-9p mount.
> >
> > Link: http://lkml.kernel.org/r/20180717003529.114368-1-chirantan@chromium.org
> > Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > Tested-by: Greg Kurz <groug@kaod.org>
> > Cc: Dylan Reid <dgreid@chromium.org>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > ---
> >  net/9p/trans_virtio.c |    7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > --- a/net/9p/trans_virtio.c
> > +++ b/net/9p/trans_virtio.c
> > @@ -406,6 +406,7 @@ p9_virtio_zc_request(struct p9_client *c
> >         p9_debug(P9_DEBUG_TRANS, "virtio request\n");
> >
> >         if (uodata) {
> > +               __le32 sz;
> >                 int n = p9_get_mapped_pages(chan, &out_pages, uodata,
> >                                             outlen, &offs, &need_drop);
> >                 if (n < 0)
> > @@ -416,6 +417,12 @@ p9_virtio_zc_request(struct p9_client *c
> >                         memcpy(&req->tc->sdata[req->tc->size - 4], &v, 4);
> >                         outlen = n;
> >                 }
> > +               /* The size field of the message must include the length of the
> > +                * header and the length of the data.  We didn't actually know
> > +                * the length of the data until this point so add it in now.
> > +                */
> > +               sz = cpu_to_le32(req->tc->size + outlen);
> > +               memcpy(&req->tc->sdata[0], &sz, sizeof(sz));
> >         } else if (uidata) {
> >                 int n = p9_get_mapped_pages(chan, &in_pages, uidata,
> >                                             inlen, &offs, &need_drop);
> >
> >
