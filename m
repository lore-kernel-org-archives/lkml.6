Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34474C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C262064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOjCz3vo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C262064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeH2Uux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:50:53 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45641 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeH2Uux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:50:53 -0400
Received: by mail-qt0-f196.google.com with SMTP id g44-v6so6487865qtb.12;
        Wed, 29 Aug 2018 09:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sg8laCrFDqy3AYErb0BN6Xm/+lKIjgyvXK747RSkRqY=;
        b=iOjCz3vofsvvxVncXE136T9C3p/s+05SnXfx59dHJffYNIidl6E8YyFg+a/DgpIzeI
         qO7rUrZfgVPlPfPgnVSoyjB3dkMa09+A2yEdhWIhcfq6FF8Lp1dtRGfboUG46/wMfzxM
         vg7hG09ZcpU2hQ1I6JWcqlm4gfblyQPw0V47lsc8G4PCCGvQlVyBTOBzEX/0kXJY2V/L
         vE6nDA2xIYZUe2r6Bx96nJT3tmhJAo1emve1plUuzO6Y3FaRbdNGfEtSp12zni5/wQiK
         CqkzakE8ktHU+N0hTDXZROh1dNoau0YPtTqSSz0csQEzAtzDhF9ycw/IzBBzgU6VzcyX
         PLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sg8laCrFDqy3AYErb0BN6Xm/+lKIjgyvXK747RSkRqY=;
        b=b+78ndn3n9ea3y2sl651RKnIdGFzfiqs/s/DMxZ3nLRMiTRrz994oo8g+y0zxBp3Pc
         bxJZFvT+521TFjZct+uEj+KYALxDEb09GrrTawoOPeFawRJHDwPnHiGJrk55CCXQiqhz
         kzzOKeQBSQgxppQjNuU3bP5XkXICucKtSfki3/0Xf54P9nGgi6cfZAY6WVgERwgxJKEV
         HVDUzb7XXRox7Bym/raEy/95sJiLp0hvGIJSEOFTI+Fna1T1YpgDARxpWoavO3yBXrXC
         L6FuSjghLd3AvjzX++MC6777c1r9MbWsykSEME5o6AaPMetycaj72aQsdtamG8bNB1YC
         3I+g==
X-Gm-Message-State: APzg51D7dXyRgF20ZYR+HxLIspNbz8yaULA0xWw1KmdRqvg6avy+Yje9
        2GKQO4xpC/5s6CwKs/SlZk/QF7fD0yzpjDydwzQ=
X-Google-Smtp-Source: ANB0VdajqL7N/rb5aOGWg43zirkihEnbPmrYswFYjxf+GEuvjyp7Qcv4htvn4+JEFukxwDmsG1Caz0n6RtVGZvebJJ0=
X-Received: by 2002:a0c:c13c:: with SMTP id f57-v6mr7486521qvh.7.1535561585204;
 Wed, 29 Aug 2018 09:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180829150955.GB7459@smile.fi.intel.com> <20180829151501.GE27808@sirena.org.uk>
In-Reply-To: <20180829151501.GE27808@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Aug 2018 19:52:54 +0300
Message-ID: <CAHp75VeUF7ww7cNy0qHqFSp7bA65Ln3qj_U9AC0UNCX4FRrutg@mail.gmail.com>
Subject: Re: [andriy.shevchenko@linux.intel.com: Re: [PATCH] spi: dw-mmio: add
 MSCC Jaguar2 support]
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        allan.nielsen@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 6:16 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Aug 29, 2018 at 06:09:55PM +0300, Andy Shevchenko wrote:
> > ----- Forwarded message from Andy Shevchenko <andriy.shevchenko@linux.intel.com> -----
> >
> > Date: Wed, 29 Aug 2018 18:08:31 +0300
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > To: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Subject: Re: [PATCH] spi: dw-mmio: add MSCC Jaguar2 support
> > User-Agent: Mutt/1.10.1 (2018-07-13)
> >
> > On Wed, Aug 29, 2018 at 02:45:48PM +0200, Alexandre Belloni wrote:
> > > Unfortunately, the Jaguar2 CPU_SYSTEM_CTRL register set has a different
> > > layout than the Ocelot one. Handle that while keeping most of the code
> > > common.
> >
> > > -#define OCELOT_IF_SI_OWNER_MASK                    GENMASK(5, 4)
> >
> > > +                      0x3 << if_si_owner_offset,
> >
> > Perhaps,
> >
> > #define MSCC_IF_SI_OWNER_MASK         GENMASK(1, 0)
>
> Oops, sorry - that seems to have been eaten somewhere.  :(

Nothing to sorry about, I'm in a process on move to mutt, so, I
mispushed 'r' (Reply) instead of 'g' (Group Reply).
I just forwarded the first one.

-- 
With Best Regards,
Andy Shevchenko
