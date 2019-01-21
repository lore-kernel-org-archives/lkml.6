Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B323CC2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7647820861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byNaz58c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfAUO4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:56:39 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43036 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729559AbfAUO4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:56:38 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2-v6so17771927lji.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 06:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pUVu330HHtRB7Vk4e8H0GbnQbRSdfpHlfmZj3dwUfuc=;
        b=byNaz58cukXD3PmlZE6+eFMxD3dW/hxDvQ78f3dxaOnhjExSoZ9BHAePecqizA/SQi
         gswB0sTy7Ohf/ah2H4Vh0CocUv+/iK/jUPBqHG63u1hacu56mqcoqH9Bx1Ubxog3j2bk
         J0VtxDhgEay+FJluL/L6RhYSnYizI4AUHjfA2SKYRkRDHSXLy3wAYXxI2Eo/0h+HYc+R
         Zi6gB5XKb9tyMgb7A8bvgkyIw5+KCbqBsO59tkYH0siiJaLvIn0xii+1oOJHnJ6bSr9q
         hyMM/LZCLc6TdCM0UBlQoqGathI8u1ANNSPJumWRiahojfVhVROI6YZeHGPHmJfM1drb
         pNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUVu330HHtRB7Vk4e8H0GbnQbRSdfpHlfmZj3dwUfuc=;
        b=J8A6rsw/7V+KhnMEd/kyuyEmvOkM0qXpxcSJ0Mi5YRxNQx6MIzhvZ1cX5B3C8ZL6J1
         7o7L1Gp5gZhg0w0oi9nmmNpfPGlZQt4tQq22x77WVNlxXxwaExguyNqVg7xAvlXe8Q7r
         OfPhPGziGIU8VRIa5eGhSuyRpG0XjAhKEt6E0bKEj2azighTciCPriwKHAz0y7H8o0zC
         SvFg2yK58PcKZ7fr3VZkZLL4tvMNMvuPh8sHSkanO5amytokcmf+LXhOFN7ikqTyowUC
         bQSIfdj7nLRVuD/CuKd76GkRyLHge6qI+x561QzQv06S3/ivN14ikqG7/svHBiGZvR/c
         y3cg==
X-Gm-Message-State: AJcUukeICCxywKQ7wQs2gekB4iM1mUFAVDSveZh0I4xtk6OYtQTxxoXG
        R+BJSaWRV4ohv5QbekSnT11yyvx/jBP4zndUWNCoyPBl
X-Google-Smtp-Source: ALg8bN4Iuokbw2xYme8IrSRuTCAZlaQZ2NGW1OqikkjE+t2ITY5bxu19zIfl2iiU51onS3eqqwO6cIsFsvUjJiVxEcs=
X-Received: by 2002:a2e:310a:: with SMTP id x10-v6mr19542615ljx.6.1548082596262;
 Mon, 21 Jan 2019 06:56:36 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZs98K62OE6er2ysBSJ2MQC=1xWapCw_tw458Z_K4BjMDA@mail.gmail.com>
 <20190121144657.GA27366@kroah.com>
In-Reply-To: <20190121144657.GA27366@kroah.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 21 Jan 2019 15:56:24 +0100
Message-ID: <CAA85sZum33M+1NRcfWkua+66CBTxM8ope+hoGASv6mR8NrwPTg@mail.gmail.com>
Subject: Re: [PATCH 4.20 000/111] 4.20.4-stable review
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 3:47 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 21, 2019 at 03:44:24PM +0100, Ian Kumlien wrote:
> > Hi,
> >
> > IMHO you are missing: 41d1c8839e5f8cb781cc635f12791decee8271b7
> >
> > Which should be marked for stable, it fixes:
> > https://bugzilla.kernel.org/show_bug.cgi?id=202235
>
> The networking maintainer handles sending those patches to me.  It
> wasn't part of the last set of patches, so perhaps it will be in the
> next one?

I thought it would be in the next one after it's in the rc but perhaps not...

I suspected that it could have been a slip up, since:
https://marc.info/?l=linux-netdev&m=154726015506044&w=2

And i know that there are people waiting for it ;)

> Please see:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> thanks,
>
> greg k-h
