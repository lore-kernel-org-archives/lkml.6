Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123C7C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB3D21720
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZTaNA6xV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbeLXSHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 13:07:14 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39404 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeLXSHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 13:07:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id n18so8573351lfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 10:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aT+M3236CMHB5HnAd5kTF4BkirkHMafpMOCxqPrEBqk=;
        b=ZTaNA6xV4eGO9IPhZFoakDxxxo/+QApPQQyneaRaodXiJledDOSMIohlxq3PnPOXlt
         08ijA2cPH2Fop1nFavEWq87xd+sCqc0/jhqE4OuFK6B7h5dFQuKiTo3zCGN/zAkMNIQv
         QgUJoj5sUXb918xHraD/CpnEC4m4JyW2PrMNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aT+M3236CMHB5HnAd5kTF4BkirkHMafpMOCxqPrEBqk=;
        b=YvttyMwn8NSlaSvoKvruRvv1TwGeM03i+iZQfrXxatuWJrJQWssS87hRog6aQ2vqVb
         IH3+LLcI5rlhYaqUt/06wtBjzmhNLBtmNsj8xJgZfI2867vNQKGIPoZ4dtpl0Hnx3zO5
         mpqcpCEBtuKdtlLNita/+qbYSbHJa6bOOvhzYxA0QQ4LpF87i1yfGBRlH6/9N3pw1lhm
         cG4aXFdFaXilDm3iIFLJe8ADwO+ad/w+i0tt4aMg+SIS67C0EccHUFLwKp6hcLs9Hc65
         3f0euknV1SfivtlFy+pSudjdlJP1e+SJyEcU8kLo6yfxalFNocyvpMI5aq8Wo46RooGu
         4urw==
X-Gm-Message-State: AA+aEWacWlgY62usBnwVB5xbMXQ1LGRm1OxwqeunMm/5zaal9Im4mIo2
        dAWwcIEOnNs9OxKpGK8nfsG6Wjjuy2g=
X-Google-Smtp-Source: AFSGD/WGPPwb52yO3IQfbN5Wt9D7DisMOx7dUtS+pgKwJiVfeKucpQhzEzakmaLmPpfjiBniF/CqxQ==
X-Received: by 2002:a19:c70a:: with SMTP id x10mr6853085lff.88.1545674831652;
        Mon, 24 Dec 2018 10:07:11 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id c2-v6sm6526831ljj.41.2018.12.24.10.07.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 10:07:10 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id e26so8594340lfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 10:07:10 -0800 (PST)
X-Received: by 2002:a19:4287:: with SMTP id p129mr7292786lfa.135.1545674830225;
 Mon, 24 Dec 2018 10:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20181223164954.hib4lbchftspidsd@suse.de> <20181223171703.s7jm6fkyosnsf33z@brauner.io>
 <20181223180609.GA102606@dtor-ws> <CAEJqkgjSX8PW-NXa8CoMzx=2P5LOiDz0MCHoZ03zE7wZ=n2dKg@mail.gmail.com>
 <20181224091703.GB26796@kroah.com> <CAEJqkgj2EjQq_aaspRs7uyTL4LxC9dRUTheN25H+QhjkLjjpjQ@mail.gmail.com>
 <20181224105407.GA29719@kroah.com> <20181224173427.GA254245@dtor-ws>
In-Reply-To: <20181224173427.GA254245@dtor-ws>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Dec 2018 10:06:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiTE+k8WkHoDLzxX2Qz8ko7W+BsXOhirS_j0FZaBMxDdA@mail.gmail.com>
Message-ID: <CAHk-=wiTE+k8WkHoDLzxX2Qz8ko7W+BsXOhirS_j0FZaBMxDdA@mail.gmail.com>
Subject: Re: FYI: Userland breakage caused by udev bind commit
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Gabriel C <nix.or.die@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Marcus Meissner <christian.brauner@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 9:34 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Well, it appears that we can no longer extend uevent interface with new
> types of uevents, at least not until we go and fix up all
> udev-derivatives and give some time for things to settle.

How about having the users "opt in" for new events some way?

Do all the legacy events by default, but then if some user wants a
"bind" event (or some other new event) add a model for the uevent
interface to actually enable it.

Not using kernel versioning (nothing should *ever* look at the kernel
version, since that makes things like backports a huge and
insurmountable pain), but simply using some specific control channel.

> I guess reverting is the right solution here. I wish folks would yell
> earlier though...

So nobody is actually using the new "bind" event, I take it? It's
about a year and a half, and it's in 4.14 which is widely used, so
reverting it has a risk too.

Which is why I too would hope people would be much more vocal about
"that broke my setup".

But reverting does sound like the right thing to do if nobody is using
it. It sounds like systemd udev does not, and if eudev is actively
broken by this then how many other cases might there be?

I assume any locally modified udev rules would still be ok with the
revert (since presumably any udev rule modification people did was to
just ignore the bind/unbind events that no longer would be sent).

                Linus
