Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339B4C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25A9223A2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O2q0SimQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25A9223A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeHJCEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 22:04:44 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39137 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeHJCEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 22:04:44 -0400
Received: by mail-ua1-f65.google.com with SMTP id g18-v6so185933uam.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 16:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1hC3589ieDdOVwFecZnz7CZquloTCqkLCsVOYNAHUI=;
        b=O2q0SimQDrUfJgCNKwyZ0WjgY64j9Q7BYtGVQojHJhByWcKpe6Zedgcf6oHSl5qcB3
         D6m1oeEkYg9YGOxSF8u/ffLUOMrOF28D2LedMU/fF3ScT6jLiIFhGH4s9inAXxagE5yW
         iF3i0KoabxPuEVmVzovHjtmYBEmPPXaxl+6ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1hC3589ieDdOVwFecZnz7CZquloTCqkLCsVOYNAHUI=;
        b=RJT9OOgSJSSWKQNUdUSx/+fjvAUaKm22SmR0oPOnv014c6U2JUOptvO+0KGxLd40u/
         n3tDxF3HrthtLShWz7rGmAMVHBz9Q2pNmmB057MlPQreEzqdjX6e5qL7Vy2ooK+nC9he
         HeyaCZYWI5IBNKvCDV1UHewa/lmZquB8i6oDJY6aidCVPC1ILjofroVzC9juHtH3a95X
         544+3QIsW/MABCDcF1bsmNoRlIPMg/miQqvzFTGDl1Bz+iE4Wy76UEkfkKTaQqk+d4yh
         cQRtk/+aQDm7AalmhcQukOVF0KDnR5cF9PUY4XQmEqGr+DggzFWypf8Bh5M7cYeqjiCQ
         C6XQ==
X-Gm-Message-State: AOUpUlFSpW2LBE5fm9fGd+RcvpOqIT2Pn+zrgBI10sLU6Rgs3Cn82Szt
        nn+/oI85qRMrf2vBVp7uISeq1OLO0tksgP9P5B5LUQ==
X-Google-Smtp-Source: AA+uWPyJLse65XJuYTeT5cBPztoJ2uuaVFFSY8XMJFv+M6U66bn/ZsG7A5WBEmuCSMNjlknYnaEIKN0nn+H4WoxNjeI=
X-Received: by 2002:ab0:4987:: with SMTP id e7-v6mr2874472uad.198.1533857854026;
 Thu, 09 Aug 2018 16:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180809171722.144325-1-swboyd@chromium.org> <20180809171722.144325-8-swboyd@chromium.org>
 <CAODwPW8eg2WOh9-Raeb8Q65E-5D7RDheDU8e+H68FHGa0MS37A@mail.gmail.com> <153385579866.220756.16086660810932774163@swboyd.mtv.corp.google.com>
In-Reply-To: <153385579866.220756.16086660810932774163@swboyd.mtv.corp.google.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Thu, 9 Aug 2018 16:37:20 -0700
Message-ID: <CAODwPW84FYK3k5=n4gQ4EPJExhQ59LCEi31ZYi2Bq2y9FH_E_A@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] firmware: coreboot: Request table region for
 exclusive access
To:     swboyd@chromium.org
Cc:     Julius Werner <jwerner@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Brian Norris <briannorris@chromium.org>, samuel@sholland.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Furthermore, I see that my system RAM excludes this coreboot table so it
> doesn't fall into the bucket that CONFIG_STRICT_DEVMEM would find.

Yes, that is intentional. We don't want the kernel to try to use that
memory for anything else (since we want those tables to survive), so
we mark them as reserved in the e820 map.

> > (I guess an alternative would be to rewrite 'cbmem' to use
> > /sys/bus/coreboot/devices if available to get its coreboot table
> > information. But we'd still need to maintain the old path for
> > backwards compatibility anyway, so that would really just make it more
> > complicated.)
>
> This sounds like a good idea. Userspace reaching into /dev/mem is not
> good from a kernel hardening perspective. That's why those strict devmem
> configs exist. Can cbmem be updated to query information from device
> drivers instead, so that we can enable CONFIG_IO_STRICT_DEVMEM as well?

Well... problem is that cbmem doesn't just access the coreboot tables,
it accesses more stuff. There is actually a larger memory region
called CBMEM (that's what the utility is named after) which contains
all sorts of random memory allocations that coreboot wanted to survive
for the lifetime of the system. The coreboot table is one section in
there, and it sort of serves as a directory for some of the others
(although there's also just a general CBMEM directory... there's some
redundancy there). But cbmem can also print some of the other CBMEM
sections which it finds by querying the coreboot table, such as the
firmware log or the boot timestamps.

So the question is how we can get to that content if /dev/mem isn't
available anymore. One option would be to just write separate kernel
drivers to completely replace the cbmem utility (we already have one
for the log, for example), but I think Linux generally doesn't want to
have too much logic and parsing and stuff in kernel drivers. Another
option is to add a driver that just exposes a sysfs file through which
you could read (we don't need to write) the CBMEM area... but then
we'd essentially want that to take absolute addresses because that's
what the coreboot table pointers contain, so we would've just built
/dev/mem by another name (for a restricted range).

The nicest thing, really, would be if there was a way for a kernel
driver to mark specific regions as "allowed" by /dev/mem. I don't
suppose we'd be willing to introduce a mechanism like that?
