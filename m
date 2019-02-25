Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE459C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDA120842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551123508;
	bh=KSmsmKN6qjX5vloDCqN5D0x044wPYCLAPrMJpTQyfd0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WrPqCm3tzUZyCpUFANanBqDrMrlM/74itJrRgQTj5Up2WXtK7/hnzDXyTjDJyzmKS
	 DikyS0unlMpbgH/5LGN1TfkvESlnrTh9iY3FSuj3NRLcHk/3vT5otIRLm2RpB3YRey
	 TU3/pR3IAgarwfbqf0NrXIqUmwuM7nB1RCtT7Zng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfBYTi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:38:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfBYTi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:38:26 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 914D92146F;
        Mon, 25 Feb 2019 19:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551123505;
        bh=KSmsmKN6qjX5vloDCqN5D0x044wPYCLAPrMJpTQyfd0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fiye4bGX6HhnKB/QoRXcUg3TXoLJ3aN1E3XSv3y4yVCKsIPLXUgKaWneGLOmInz/4
         bXdVj2kKSxQrIv/eHVlMSmX8TGmHE+l5vnXWr6QIqY0nMWSInT8BCZHw4YuXsfKWJO
         FajtrdKxh4WlhT+G7EmMzUd4VCzj7Yq3mSbCQT9c=
Received: by mail-qk1-f177.google.com with SMTP id v139so6057201qkb.12;
        Mon, 25 Feb 2019 11:38:25 -0800 (PST)
X-Gm-Message-State: AHQUAuYpzCTEU7ZbICCTb0E8IPZCjxv8ao9ScHdRap6diZJNxU3ExyM4
        OdPxRR1UzprDUHthPw5wWeJQLN74+l3ZXukkcA==
X-Google-Smtp-Source: AHgI3IZfSaFkbA/O2OlfukUtkZqmUAe+0Qnv6PKa6leIkb9xWJI3bOkebs1Z/B6EjKyG+1Wpp4cYXhb6fT7koFn7Ng0=
X-Received: by 2002:a37:4a84:: with SMTP id x126mr14099784qka.326.1551123504754;
 Mon, 25 Feb 2019 11:38:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550768574.git.hns@goldelico.com> <32025b2a8ccc97cc01f8115ee962529eb5990f00.1550768574.git.hns@goldelico.com>
 <20190225093222.40533238@lwn.net> <CACRpkdZn6pS7vBwKk8FNnuSigZjHHjYciQ3V8WR_Fdb=COTdTw@mail.gmail.com>
In-Reply-To: <CACRpkdZn6pS7vBwKk8FNnuSigZjHHjYciQ3V8WR_Fdb=COTdTw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 25 Feb 2019 13:38:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKZUoqonTcCFEaQeGpg1SxJ31cVu0=Bm5r_2TmjCYjG3Q@mail.gmail.com>
Message-ID: <CAL_JsqKZUoqonTcCFEaQeGpg1SxJ31cVu0=Bm5r_2TmjCYjG3Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] iio: document bindings for mounting matrices
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
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
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sebastian Reichel <sre@kernel.org>,
        Samu Onkalo <samu.onkalo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 12:24 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Jon,
>
> On Mon, Feb 25, 2019 at 5:32 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> > >  .../devicetree/bindings/iio/mount-matrix.txt  | 204 ++++++++++++++++++
>
> So this is a device tree binding.
>
> > So forgive me, but I have to ask: what are the chances of getting this
> > file in RST format?  It's 99% of the way there now, finishing the job
> > would allow it to be integrated into our docs tree.
> >
> > It should probably have an SPDX line too.
>
> The recent direction of the Device Tree bindings are not in the RST
> direction but in the direction of using another formal structure: YAML
> schemas.
>
> See e.g. Documentation/devicetree/bindings/example-schema.yaml
>
> The YAML schema makes it possible to verify device trees and examples
> inside the bindings to the specification using a context-free grammar.
>
> If we can join the RST and YAML ambitions is a good question. RST
> has nice typesetting properties, YAML has nice grammatic properties.

In fact there has been some experimentation there. The 'description'
portion of DT schema can be RST. And the rest being structured data
could be transformed to RST. Grant did some experiments there. The
idea being to generate the DT spec from schema (rather than integrate
into the kernel docs). But not much progress there and it's not
something I'm spending time on ATM.

Rob
