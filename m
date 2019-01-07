Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F267BC43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC03F2183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546905076;
	bh=DJXo8EwHxRi2342Lqz7RWmZz41C+4f0qNUh7ubuIEHE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aJQ+msFnlTHDFh4TBn9BkG9wqsulCaMG9dbRH+wsD2i0/FMKPMH+wwsWCrsgdVX1N
	 w2mnIGpaoVtvP1nWC/koQLdZkn+e9vXaYbOtxPZ5tu04oZGPnG4UYAOqF6G6dHdztK
	 TD+F9+3bvBcjHmsgKvTcmcG5l+Uu0Hsl6yF+GtBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfAGXvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:51:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfAGXvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:51:15 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83DC9218A3;
        Mon,  7 Jan 2019 23:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546905074;
        bh=DJXo8EwHxRi2342Lqz7RWmZz41C+4f0qNUh7ubuIEHE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Fu8Xy3+oe2+CWSbwbm/OUh3w0s/aRev1elhs6CKXWrVv8f0iIZ/n/0EktuhkviIGZ
         GE304WfDUbYncof2O72ABxo+4/a7eN6/7TApfpY/bFWfOnam+IeAgid77dogua9Gk/
         polotVlTJwgfCTO1zB5gdCmgF+mw98O2hkuVaxD4=
Received: by mail-qt1-f178.google.com with SMTP id l11so2574578qtp.0;
        Mon, 07 Jan 2019 15:51:14 -0800 (PST)
X-Gm-Message-State: AJcUukenD6YsPulz/e+WcyEimitaTZZi6APFKC9+NfU5qejCanZrjVsk
        Ls5nNshY3nh2U1iH5pR4k9ll6/YIsEQe7u5PrQ==
X-Google-Smtp-Source: ALg8bN4fWYWThNB2HwiQRiFXVnM9HnC+MW/bLrZx96/ak17zhXjqVl3WdAHiIUqqv2ZmQQufFo/fK/0W48pU3J9N57c=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr62852002qtf.26.1546905073693;
 Mon, 07 Jan 2019 15:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20190107173132.27316-1-robh@kernel.org> <CA+7wUswqMNc1js6hyszYKVOeXrVPVDYLxSmZ97Uaqqo7u0Z9vQ@mail.gmail.com>
 <CA+7wUsyw8PLc2-4jnFVwkNg_u8H=FgOHQtBspKR8haLT-5NSwQ@mail.gmail.com>
In-Reply-To: <CA+7wUsyw8PLc2-4jnFVwkNg_u8H=FgOHQtBspKR8haLT-5NSwQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 7 Jan 2019 17:51:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKfmzA6E0PEKA-69haaO163YrNhoF7+oauE5Xd3JDTKgw@mail.gmail.com>
Message-ID: <CAL_JsqKfmzA6E0PEKA-69haaO163YrNhoF7+oauE5Xd3JDTKgw@mail.gmail.com>
Subject: Re: [PATCH] fbdev: offb: Fix OF node name handling
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Elimar Riesebieter <riesebie@lxtec.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "# v4 . 11" <stable@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 2:36 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> Hi Rob,
>
> On Mon, Jan 7, 2019 at 9:11 PM Mathieu Malaterre <malat@debian.org> wrote:
> >
> > On Mon, Jan 7, 2019 at 6:31 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > Commit 5c63e407aaab ("fbdev: Convert to using %pOFn instead of
> > > device_node.name") changed how the OF FB driver handles the OF node
> > > name. This missed the case where the node name is passed to
> > > offb_init_palette_hacks(). This results in a NULL ptr dereference
> > > in strncmp and breaks any system except ones using bootx with no display
> > > node.
> > >
> > > Fix this by making offb_init_palette_hacks() use the OF node pointer and
> > > use of_node_name_prefix() helper function instead for node name
> > > comparisons. This helps in moving all OF node name accesses to helper
> > > functions in preparation to remove struct device_node.name pointer.
> > >
> > > Fixes: 5c63e407aaab ("fbdev: Convert to using %pOFn instead of device_node.name")
> >
> > Looks good to me:
> >
> > ...
> > [    0.000000] Linux version 5.0.0-rc1+ (malat@debian.org) (gcc
> > version 6.3.0 20170516 (Debian 6.3.0-18)) #21 Mon Jan 7 21:03:53 CET
> > 2019
> > ...
> >
> > So here is my :
> >
> > Tested-by: Mathieu Malaterre <malat@debian.org>
>
> Just for curiosity, why would you keep:
>
>      if (strcmp(dp->name, "valkyrie") == 0)

Mainly just because I already have another patch to do that which I
haven't sent out.

Rob
