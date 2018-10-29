Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FE2C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2C020664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo00bgwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2C020664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbeJ2VdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:33:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34744 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729201AbeJ2VdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:33:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id z2-v6so8969711qts.1;
        Mon, 29 Oct 2018 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sziKq0il3NFOwAM2f9rq0k5k1PO4wVPX0CbzTuWdJxM=;
        b=Mo00bgwbkXwyMDDsSZOjLiF3EBXQmC4RzG/U7iubh+3ON87BZWRX9G/Oc444snD2xM
         CYG/jmJ/yOAD7p0EaOi1iJu+95+TTm0vDrZuLsPgHCSSKGGipDeQZGG1Jq6aCWPCxfrX
         aa/1hGT9OnnE+hpzGRBe79nfDz7t+GdFUNmeeqjxo6l7arynHkdUkY/ZhqQ1oi/Fe/Sv
         jv7qIfkutLfWwe8GzOX/Cji6wOMTbB7Ftv2dTXagqzryDCE3NlZ7wqT6qKp7wR+VGMJZ
         dM7f3UcFWeKENcZfluXucqaznF8BkuEs5zVkfLef7+oJgdLbTBKSCLUKoMk/xjJKmBHO
         /3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sziKq0il3NFOwAM2f9rq0k5k1PO4wVPX0CbzTuWdJxM=;
        b=VVWCBwXiJkgAluX7tQHlw823o8a28FMLU3hHQDRfHeAZHyL0QSJ1rk+rxT4QsMb9tl
         wEDqAb1bQu9Oahx6v+ATgoiPlv8D1jOHdyP3UOyJtGbRxCj/g6mL2JJBm+irr8DchKUZ
         7+bh0dMTojoz3+P+fGxFHLDIRdDFf2WhGFwdldCCg45keDMukIKAE41YgqW/RWQbJG/L
         QfSKMcxo4QGzPlF8oFBLnEZV4bPqWY7pmUre6HGh2+RViz5Qdm9OAIl7T7DtLwvZY5Lr
         bHNg8eJA04L3B6WqXIDygmEzSLz0ppoZ78obmjYxVWcg5VMtU0mV/Sh1R6p3QT1QPkiD
         vY3w==
X-Gm-Message-State: AGRZ1gJOhVT+ifWe94hYQvsvYF3/Gz89lRYT1KJzz+YvGhE/0/iu2Cd6
        EJGzibQK5j7iedG4laqs4ptzzeKCDCd66F1Lj66N
X-Google-Smtp-Source: AJdET5e8kzgPp/HP07z/jWKzQFsUg00d2zMNYJwCfgcgsWKXxWoUTIBtiTVOWOKPmsWIc4QLHuackYeitt6BpHvboDY=
X-Received: by 2002:ac8:2d1d:: with SMTP id n29-v6mr12199301qta.38.1540817083783;
 Mon, 29 Oct 2018 05:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_JsqJKkPiHBbJWMF5=JzxZyO+UTN0qLFLnjvd9txkUQPdznw@mail.gmail.com>
 <CAOesGMh=iJ-LE25ooVmoSVD7Rw9AzrJhXbP2X4+OeeUwmV5HnQ@mail.gmail.com>
In-Reply-To: <CAOesGMh=iJ-LE25ooVmoSVD7Rw9AzrJhXbP2X4+OeeUwmV5HnQ@mail.gmail.com>
From:   Rob Herring <robherring2@gmail.com>
Date:   Mon, 29 Oct 2018 07:44:31 -0500
Message-ID: <CAL_JsqLgbGDHPFp2kW2tRT3iQwV9dU+NRVB4YzoS-7p+9GZHnQ@mail.gmail.com>
Subject: Re: [GIT PULL] Devicetree updates for 4.20
To:     Olof Johansson <olof@lixom.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 12:25 AM Olof Johansson <olof@lixom.net> wrote:
>
> Hi Rob,
>
> On Fri, Oct 26, 2018 at 9:07 AM Rob Herring <robherring2@gmail.com> wrote:
> >
> > Linus,
> >
> > Please pull DT updates for 4.20. A bit bigger than normal as I've been
> > busy this cycle. There's a few things with dependencies and a few
> > things subsystem maintainers didn't pick up, so I'm taking them thru
> > my tree. The fixes from Johan didn't get into linux-next, but they've
> > been waiting for some time now and they are what's left of what
> > subsystem maintainers didn't pick up. There's no conflicts yet with
> > your tree, but there are 2 conflicts I'm aware of. One is with the c6x
> > tree and the other is in drivers/soc/qcom/apr.c. The correct
> > resolutions are in linux-next.
> >
> [...]
>
> >       scripts/dtc: Update to upstream version v1.4.7-14-gc86da84d30e4
>
> This update made dtc spit out a large number of warnings on a regular
> build, due to a new requirement that a SPI node is named "spi". Seems
> like an arbitrary restriction, but either way can the warning please
> be disabled by default until them cleaned up so we don't have a bunch
> of noise in the logs?

All the fixes are sitting in your tree. :)

Rob
