Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE02C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E552147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAyMlVTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388538AbfA1Qz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:55:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46668 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387770AbfA1QRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:17:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so7389378pgp.13;
        Mon, 28 Jan 2019 08:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFq7c3/4Ae1FkBXRLNEvCM/rgxthjk54VQVYBvhaLYg=;
        b=OAyMlVTHbIBfsab2+KAVlv9PUgI+FLhw20NUjQRI6SqQhxm6yVuMOY1P6aDHWA4rRl
         3j5412HQUfnn/CgTKGmGiglXFwkou8vQJTIeINkGWk6bSMmZigJqsI6Jdzjupex9wzBG
         5wLk9MsZDSlnwMXNBpT2ybbkawwIeWBKOVuYYR8fSkkf0HzICvRUkqgKvKWKp4UGyqtE
         3dzku7Hrcox5AS11StNAzttXJqA5Ac7etzmAz0I/fznINZqiJY91kKhpez0n8ygJkSwM
         v6cklryC6/v+ngvlRD+73uJTKMLNn7tEzKOsg9jZTXAh+mv3Mtv9S/x1006+h81TDVA2
         wTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFq7c3/4Ae1FkBXRLNEvCM/rgxthjk54VQVYBvhaLYg=;
        b=shKdZOmpjDtbdz7QUk4Iui4EqxlTGzvJJPWSwzGvhL271A6N61zcOErO6HBQRCuaFi
         jUJae8arg1MRNdm9MbE7q9kpUcYLGUz/sOlI7qfV4/yMC9+zPN7Ost9E+wfcrFTwbY/a
         w0zYfsXgmzEmtV339/5T8V5H4VIDF0QQRna/vM6qlvubc0DH0K/HLFBTx+t90TYOr6Q2
         B8irgDRkApfvtqlOamH8g473pVqPxWub0mcd8+DQ4N6igx8RkacWoE2fdH9CjDlSzyX9
         pOrz13Zazb0zzWllefSwuVSLEvlNyqeF9RuOA9+qGrb/7/XdgiZmPtRafz0qpOqriyjw
         a6pQ==
X-Gm-Message-State: AJcUukcwJZuM1BU6xO5xf4HKYDc7YXmJENJLWl+Jc3pMm8GIaQhmynEw
        JbU0Vs+D/YZtZaktrYzX6/Ic5iCX3KEyt10cJWMLrvHgd2M=
X-Google-Smtp-Source: ALg8bN7Bz2NxYto4EzeEAte+1pb/01Uo4g0T8AtP2dqjYis725xQzOBJMM7c9B1ES5AynuuOXxBAlJmTZei343jDaec=
X-Received: by 2002:a62:34c6:: with SMTP id b189mr23019084pfa.229.1548692255654;
 Mon, 28 Jan 2019 08:17:35 -0800 (PST)
MIME-Version: 1.0
References: <20190125131519.88416-1-heikki.krogerus@linux.intel.com>
 <20190125131519.88416-5-heikki.krogerus@linux.intel.com> <CAHp75VfG9LDOfz9K0jYvGOK=j1uDmyg=eeRMur7hnw2rF9qx+Q@mail.gmail.com>
 <20190128154618.GI7262@kuha.fi.intel.com>
In-Reply-To: <20190128154618.GI7262@kuha.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Jan 2019 18:17:24 +0200
Message-ID: <CAHp75Vc8cwsrErkDvXptUE40AqpOiJt-U48UdRmKcsW3dZPkOA@mail.gmail.com>
Subject: Re: [PATCH 4/8] usb: typec: mux: Find the muxes by also matching
 against the device node
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 5:46 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> On Mon, Jan 28, 2019 at 11:53:54AM +0200, Andy Shevchenko wrote:
> > On Fri, Jan 25, 2019 at 3:17 PM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:

> > > +       bool match = !con->id;
> >
> > I don't see how this assignment is used.
>
> That definitely deserves a comment at least.
>
> This series adds support for the "device graph" to the device
> connection API, but it is also possible to describe connections with
> normal references (fwnode_property_get_reference_args()). With normal
> references we don't need to do any extra identification like we do
> with device graph.
>
> The idea is to supply the connection id only if it has not been
> "consumed" already (device graph case). If it has been "consumed", we
> know there is no need for any extra connection identification (normal
> references), and we can jump straight to the next stage -> find the
> mux..
>

> > > +       if (!con->fwnode) {
> > > +               list_for_each_entry(mux, &mux_list, entry)
> > > +                       if (!strcmp(con->endpoint[ep], dev_name(mux->dev)))
> > > +                               return mux;
> > > +               return ERR_PTR(-EPROBE_DEFER);
> > > +       }
> > > +
> > > +       if (match)
> > > +               goto find_mux;
>
> ..here.
>
> I'll change this so that the match variable is introduced without
> setting default value. Instead, how about this:
>
>         /*
>          * Check has the identifier already been "consumed". If it
>          * has, no need to do any extra connection identification.
>          */
>         match = !con->id;
>         if (match)
>                 goto find_mux;

Cool, thanks!


-- 
With Best Regards,
Andy Shevchenko
