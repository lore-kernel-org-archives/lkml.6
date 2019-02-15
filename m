Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAB6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDC721B1C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CIdR9t/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfBOA4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:56:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44645 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfBOA4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:56:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id g1so13823420otj.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 16:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MyM751NwMFtU1TXOfkeWSlPL++zlDJtqG4gn7hY55fU=;
        b=CIdR9t/qUO6pKfNH5RPv025oSe2aWVZMiqmRxxrwiU7IgHtyFE46n0jZKTxOd5vXho
         2SMfSOmiO05oAeGiynmK7U7bMebpaAQ+vnaCrja0WKWbdQuDDQ8XApB1J3v5MCW3YwxN
         gEFpS2kVJkwaYz4K+Et4V1p6S2adYvugKyCEWggb14v5nakj7fW08U9zKn/0txWpQG5S
         RoFexJJb7I37QAvYkavNulgSF4Kw1o2OR0wLAojaL3h8nFjd3SrU3gO5hNs72BesmRIw
         8JRKitGw3ziApD/WBwOKWXAase7etM8d9mO2RzvCcusw8rjGamQ1zdk2NfM8NrAemIf8
         /huQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MyM751NwMFtU1TXOfkeWSlPL++zlDJtqG4gn7hY55fU=;
        b=t7caC2Sw2BhHuuZbd+dgnOCr6+tsIKXv2ROPE+5oNKrcJTanA9t9ZSp0kSw+49w/ot
         cxuDgWJ3AeTdJ2816uTnhaNfg+zgVmowyXPcboDPeXO/LUcHGleVvimJQQ2qM2t2mxV8
         3Zi34qhOJv3sa2Xsz9jIo+Mp63f+zif7DFS4OyooRMxH60iB3gY/pyB7TLm+8FJS43uq
         f9mZsLUe24tBa9wLzI4vT0cYSvslKeqo6cqdEUNEV5BslZ5soinAudsOkf7B6x/Uq56J
         TRfCXuYnW4794JJzjwXlhMc51L8nnYT1RiWRqShFo4g+5In3axfHLwGipwD6tE3uTF1i
         yw1w==
X-Gm-Message-State: AHQUAua6hFak7+AZ/RDGOOYu6xCUU7432UKLufZcICkIn8p7KAd3zNht
        cL5mEa3FzuPt5RFth8tX8js7sD2xCMze82HFva0QwQ==
X-Google-Smtp-Source: AHgI3IZOuPVG3HrJgoDqVlI6kdBpeoosTYOCZka/ezmJ+76QuokI50wGjqqIKz6e5kMXYf9up+AmH2E5xdy495M7uMM=
X-Received: by 2002:a9d:7597:: with SMTP id s23mr4134141otk.25.1550192206364;
 Thu, 14 Feb 2019 16:56:46 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-19-brendanhiggins@google.com> <990bfc7d-dc5e-d8d3-c151-9b321ff2ac10@gmail.com>
 <CAFd5g45tOGgf_sKGYRC=fpnTBKGaG=8frbQdgZ3ZTkQFyTfP5A@mail.gmail.com> <88fe0546-7850-5bb4-9673-b1aef2dccb3e@gmail.com>
In-Reply-To: <88fe0546-7850-5bb4-9673-b1aef2dccb3e@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Feb 2019 16:56:34 -0800
Message-ID: <CAFd5g444f-FBq4x3U7BL-EY+bFxP0rsJhJ14=mjOi89PhMkURg@mail.gmail.com>
Subject: Re: [RFC v3 18/19] of: unittest: split out a couple of test cases
 from unittest
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 3:57 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 12/5/18 3:54 PM, Brendan Higgins wrote:
> > On Tue, Dec 4, 2018 at 2:58 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> Hi Brendan,
> >>
> >> On 11/28/18 11:36 AM, Brendan Higgins wrote:
> >>> Split out a couple of test cases that these features in base.c from the
> >>> unittest.c monolith. The intention is that we will eventually split out
> >>> all test cases and group them together based on what portion of device
> >>> tree they test.
> >>
> >> Why does splitting this file apart improve the implementation?
> >
> > This is in preparation for patch 19/19 and other hypothetical future
> > patches where test cases are split up and grouped together by what
> > portion of DT they test (for example the parsing tests and the
> > platform/device tests would probably go separate files as well). This
> > patch by itself does not do anything useful, but I figured it made
> > patch 19/19 (and, if you like what I am doing, subsequent patches)
> > easier to review.
>
> I do not see any value in splitting the devicetree tests into
> multiple files.
>
> Please help me understand what the benefits of such a split are.

Sorry, I thought it made sense in context of what I am doing in the
following patch. All I am trying to do is to provide an effective way
of grouping test cases. To be clear, the idea, assuming you agree, is
that we would follow up with several other patches like this one and
the subsequent patch, one which would pull out a couple test
functions, as I have done here, and another that splits those
functions up into a bunch of proper test cases.

I thought that having that many unrelated test cases in a single file
would just be a pain to sort through deal with, review, whatever.

This is not something I feel particularly strongly about, it is just
pretty atypical from my experience to have so many unrelated test
cases in a single file.

Maybe you would prefer that I break up the test cases first, and then
we split up the file as appropriate?

I just assumed that we would agree it would be way too much stuff for
a single file, so I went ahead and broke it up first, because I
thought it would make it easier to review in that order rather than
the other way around.

Cheers
