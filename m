Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DE7C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFE42084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5uJ0khk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfBYSYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 13:24:52 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42755 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfBYSYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 13:24:51 -0500
Received: by mail-qk1-f194.google.com with SMTP id y140so5915247qkb.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 10:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSNydh/SzD0ECr3ghk0dl0BxfRCP0GglDYK2Rxuoy58=;
        b=F5uJ0khkyYNLVUDTT/R314Q34FrBKLjKulNbLJM/Ew5Z3emPFZL4biW/t1Cevigo7b
         3lFq6ra3mBtF/gIbM7ktu1z/BnPj7sMu7/mgiLiv1w7H2B5mOFXnTKG2er0YSIniB+FN
         3sepfNLjHdJzN6Q8+9LOnU6T1KRAL4iR+5LtB86KVRElWemDJp0PDc0LX32gey+N5eNL
         +AN5SlEaU7HWh1nS0mcz1DTpzv52djzYK98szytJ/QAJKO31N6I0hiqm3k6ELEbjXhqb
         0A9j3d1YvzO+bAzdb3OCNSSr2jjqc29G/TjPFjANwpAHUCgmzvjd14ULvo1zlcAI+R9v
         1s+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSNydh/SzD0ECr3ghk0dl0BxfRCP0GglDYK2Rxuoy58=;
        b=S9Ma2JEl2jkjtsEJ5AncUVeCaQEBoevV2rgTLpIuOM3/qtJo+sd6BY3sN7sYr9sh5J
         bSejNcwZMuQ/EN4UaNm2DiVdZUNmE9z+qH1qcy8s7IWrolKGKytUOjCqcMJhcy4UFEuh
         9L90xQNjSiaMDzr3gVhADbLRepjqd8Q9AAWufISacTksLGUVPSI+P5/jpPioJBms8uh5
         exlmcGhjZf44Y49yUwIBdTba1geusH2f87FDO94s7imJQMpCT4DKDQd9F7Rn7gQNT1Ua
         1ScM89pqlzijDChoiWuoA1ZP4HalPGyyANnpBCXv3LGDIQsFMnDUVMOO0E2VZ46Mx2gr
         sjsQ==
X-Gm-Message-State: AHQUAuYFa9VrR3hd4ZEkH6ZqVOjB5fYpQLVxW7O8YGC5sspxOxUw+K58
        y3M8elL8HlSE5vt5w01ASr5mB5ehbB+8VOGhWExGiQ==
X-Google-Smtp-Source: AHgI3IbjdHn/I5P50kibJVnHYdtyCOOfThPHbVzUyNw4/HrIm8bsLB7+wCukm57C6MSfo4AnKrCajqQPwARqRSDyB1E=
X-Received: by 2002:a37:9a13:: with SMTP id c19mr13977678qke.48.1551119090393;
 Mon, 25 Feb 2019 10:24:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550768574.git.hns@goldelico.com> <32025b2a8ccc97cc01f8115ee962529eb5990f00.1550768574.git.hns@goldelico.com>
 <20190225093222.40533238@lwn.net>
In-Reply-To: <20190225093222.40533238@lwn.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Feb 2019 19:24:36 +0100
Message-ID: <CACRpkdZn6pS7vBwKk8FNnuSigZjHHjYciQ3V8WR_Fdb=COTdTw@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] iio: document bindings for mounting matrices
To:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sebastian Reichel <sre@kernel.org>,
        Samu Onkalo <samu.onkalo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Mon, Feb 25, 2019 at 5:32 PM Jonathan Corbet <corbet@lwn.net> wrote:

> >  .../devicetree/bindings/iio/mount-matrix.txt  | 204 ++++++++++++++++++

So this is a device tree binding.

> So forgive me, but I have to ask: what are the chances of getting this
> file in RST format?  It's 99% of the way there now, finishing the job
> would allow it to be integrated into our docs tree.
>
> It should probably have an SPDX line too.

The recent direction of the Device Tree bindings are not in the RST
direction but in the direction of using another formal structure: YAML
schemas.

See e.g. Documentation/devicetree/bindings/example-schema.yaml

The YAML schema makes it possible to verify device trees and examples
inside the bindings to the specification using a context-free grammar.

If we can join the RST and YAML ambitions is a good question. RST
has nice typesetting properties, YAML has nice grammatic properties.

Yours,
Linus Walleij
