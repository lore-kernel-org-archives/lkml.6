Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED50C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D63A206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsypQY8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D63A206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeIERra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:47:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbeIERra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:47:30 -0400
Received: from mail-qt0-f177.google.com (mail-qt0-f177.google.com [209.85.216.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCA0A20857;
        Wed,  5 Sep 2018 13:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536153436;
        bh=0NfRnczHstBzu2zQGG6fiTvWTr3xVh3I88upSulxTn8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nsypQY8YpOyCRJLqwgBjlOTeI94d+HBGdesNCuTfTjnjKN/8UlKlmpomTcEnR4z2q
         4kZBY+TBoLpYLcFkgk/X6XbfjdgRDei+Ik7rmYSA32b85V6aCNKCF7g/vU2/TLxyQU
         JZ1Q6wngE6QLrBkxo/vWjHVm/pbnL5ABmPHx6Rlc=
Received: by mail-qt0-f177.google.com with SMTP id x7-v6so7952224qtk.5;
        Wed, 05 Sep 2018 06:17:15 -0700 (PDT)
X-Gm-Message-State: APzg51CnjfhrpBMWEQZ5oj9Yi7VUg80AfcYF9bWA5a9HJgIq8GTcjIMZ
        ZLGRNEZue5c4vrRSCVYJw1afIMcfIWxG+g/5WA==
X-Google-Smtp-Source: ANB0Vda9tcEBdhtk38GIObhfwL+A4HrBPkw6uNyZ42cojBqTNN4vwoG5B9hTYQLIL6drQApwvDRTkdSPXaqazC3MVxI=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr34688271qtd.101.1536153435031;
 Wed, 05 Sep 2018 06:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180830185229.20393-1-robh@kernel.org> <4253073f-5ddf-a01c-4d3e-5c6a13068903@gmail.com>
In-Reply-To: <4253073f-5ddf-a01c-4d3e-5c6a13068903@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 5 Sep 2018 08:17:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJn5ksPsRzs=zYMwPv+WkNtjuAcvycOKJtvFP1BCxF7+A@mail.gmail.com>
Message-ID: <CAL_JsqJn5ksPsRzs=zYMwPv+WkNtjuAcvycOKJtvFP1BCxF7+A@mail.gmail.com>
Subject: Re: [PATCH] of: Add device_type access helper functions
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 10:55 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 08/30/18 11:52, Rob Herring wrote:
> > In preparation to remove direct access to device_node.type, add
> > of_node_is_type() and of_node_get_device_type() helpers to check and
> > retrieve the device type.
> >
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  include/linux/of.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/include/linux/of.h b/include/linux/of.h
> > index a40f63a36afa..506beca9588d 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -980,6 +980,18 @@ static inline struct device_node *of_find_matching_node(
> >       return of_find_matching_node_and_match(from, matches, NULL);
> >  }
> >
> > +static inline const char *of_node_get_device_type(const struct device_node *np)
> > +{
> > +     return of_get_property(np, "type", NULL);
>
> I'm a little confused.  The patch comment says "remove direct access to device_node.type.
> device_node.type is set to the value of the property "device_type" in populate_node(),
> but of_node_get_device_type() is looking for property "type".

Crap. That should be device_type.

>
> > +}> +
> > +static inline bool of_node_is_type(const struct device_node *np, const char *type)
> > +{
> > +     const char *match = of_node_get_device_type(np);
> > +
> > +     return np && match && type && !of_prop_cmp(match, type);
> > +}
> > +
> >  /**
> >   * of_property_count_u8_elems - Count the number of u8 elements in a property
> >   *
> >
>
> I'd like to see one or two examples of how you plan to use of_node_get_device_type()
> (outside of of_node_is_type()) and examples of planned use of of_node_is_type() so
> I can better understand anticipated usage.  Complete, clean patches not needed for
> the examples, just enough text for me to see the resulting code change where the
> helpers are used.

See my dt/testing branch. Most cases are of_node_is_type which
replaces strcmp's of node->type. I'll be sending out the patches soon.

Rob
