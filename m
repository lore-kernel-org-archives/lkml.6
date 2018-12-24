Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F777C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B02F2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IuZOc3bC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbeLXS2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 13:28:41 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34272 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXS2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 13:28:40 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so8626202lfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 10:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xgmSfOK3OwL6/VE5gy4FID60SPzBz09Za/qtHP8bT/Q=;
        b=IuZOc3bCvduvI7QBfSeSKfdDS6FTc71KAPOd4DGFhuoFtdn4chfNnVGErnorex4AfX
         knivzRMHjpiT3g5gBqpY8JNZwf3HQyxo1SQZuEO9XFxEiKnXymC/LRYztQMo+IIt/hwa
         jlkVMxO+Ad9RyEOQa8Vzu1LDC9VRDYQiX7epo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgmSfOK3OwL6/VE5gy4FID60SPzBz09Za/qtHP8bT/Q=;
        b=sh7t/UbIw181Z1AFuECFVstQ0MZpmtmdoUinIUbslyGOrSomRfPtzjTk4bSjZLu4zC
         N1XQQCLU6RhGL63wO9FyQNK/OIqOtPEsMI943C/RaY7jkYc6iLKyjfBt24B6zujLwUsJ
         TQezEpw38f6YY+CaJxDNVWFJVg1xYky3QM5n2HJpcsZLyNZrJMa2KqUOLTrKx70Zvzt0
         reZM8fu/tEHHo4ylVReAGBRBY+R3XpGXUnr9JfE54CC1l/ncT1ynleXn6wJ3MRRO4ToV
         ITQBHLnZWrq6fMyvSH1bYixqScQMLsdSh1UiErJgJP6UulS0rIioryjgecdqzd4xje2e
         39jw==
X-Gm-Message-State: AA+aEWaHytJanLu71U7UpTKaEymmPSX6LHCZ/rWP4Uao/m+2EmxYvZ2L
        W2V2d+pcn0/iiE1bczmOY51F+GFtyUc=
X-Google-Smtp-Source: AFSGD/V2FaKYyjDPUyzg0V95fhfof+wZdN7dlJeVLFv6mL3SBrgGW26lRcTbnY9+w7QTtiv5gdqf9Q==
X-Received: by 2002:a19:5a05:: with SMTP id o5mr7361873lfb.140.1545676118154;
        Mon, 24 Dec 2018 10:28:38 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id p10-v6sm6632210ljg.19.2018.12.24.10.28.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 10:28:37 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id e26so8617428lfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 10:28:36 -0800 (PST)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr6612218lfa.106.1545676116326;
 Mon, 24 Dec 2018 10:28:36 -0800 (PST)
MIME-Version: 1.0
References: <20181223164954.hib4lbchftspidsd@suse.de> <20181223171703.s7jm6fkyosnsf33z@brauner.io>
 <20181223180609.GA102606@dtor-ws> <CAEJqkgjSX8PW-NXa8CoMzx=2P5LOiDz0MCHoZ03zE7wZ=n2dKg@mail.gmail.com>
 <20181224091703.GB26796@kroah.com> <CAEJqkgj2EjQq_aaspRs7uyTL4LxC9dRUTheN25H+QhjkLjjpjQ@mail.gmail.com>
 <20181224105407.GA29719@kroah.com> <20181224173427.GA254245@dtor-ws>
 <CAHk-=wiTE+k8WkHoDLzxX2Qz8ko7W+BsXOhirS_j0FZaBMxDdA@mail.gmail.com> <20181224181322.n7n6d2y63gwnv7cb@brauner.io>
In-Reply-To: <20181224181322.n7n6d2y63gwnv7cb@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Dec 2018 10:28:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh1mdr+zFK+-PW-inaky+sn-M63VKuUAaYrz+D5PxpjpQ@mail.gmail.com>
Message-ID: <CAHk-=wh1mdr+zFK+-PW-inaky+sn-M63VKuUAaYrz+D5PxpjpQ@mail.gmail.com>
Subject: Re: FYI: Userland breakage caused by udev bind commit
To:     Christian Brauner <christian@brauner.io>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Gabriel C <nix.or.die@gmail.com>,
        Marcus Meissner <christian.brauner@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 10:13 AM Christian Brauner <christian@brauner.io> wrote:
>
> So one possibility is to add a socket option for lib/kobject_uevent.c
> that can be set via setsockopt. We did something like this in netlink
> for strict property and header checking without breaking backwards
> compatibility.

I'd actually prefer for it to be some /sys interface or other. Maybe
it could even be per-device or class, and you could do something like

   echo "enable bind" > /sys/bus/serio/uevent

the uevent code already supports a per-node "filter" function, maybe
that notion could be extended to also have a filter for uevent types.

But I'm just handwaving. Maybe it's better per uevent socket or something.

              Linus
