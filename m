Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DF2C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F31223A6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DczlXIgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F31223A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeHJCMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 22:12:09 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41866 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeHJCMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 22:12:09 -0400
Received: by mail-ua1-f67.google.com with SMTP id h1-v6so192108uao.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 16:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wcyHnTtVqv5XHgoxMZgtnKMHTJyDCKkOyg+9HZyQlBU=;
        b=DczlXIgN0BikDzwcQN/3l6BU06tjCZBuSkefRiW+X/lmTdC47p6odFSYOQNS/BXGbO
         cJZpdKzLWDsmzz0RvV7SMf/+b1dBVJ/SMCVgZnSwsqIW/9qIsNmK+uWgSZPDyqbJCjxx
         XH1C9KUhSn/lnobbzV8ule56A1/XJNpONFU0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wcyHnTtVqv5XHgoxMZgtnKMHTJyDCKkOyg+9HZyQlBU=;
        b=e5jfKaLCpfB4H60X4b3mUXhXyX2clqwRJ01m8s0Yi69ByZkkbWKZH370NDenOLXj7C
         V1BrXM/9H7EV9PmlKY9WgTL+s8a9DKOtHIcBg1XPy2Xli+hmsrcYMsdN6r7wlANh96tN
         C/QVQIHCi9nJTjhdYqb1WlecNFxhu6wXb4WlH4r/j+23H9A+MpOza8lG9JOftm19hUEP
         l7+CGhHdNlAEwN3i45sp3r04EGhz1wf57eXf7rJO1zKMn1+zfMcYKnRrXFiRvTDik9C2
         +cgx53oKNqGKhf0sgaBmSEjW1GNAgQgxOC8+zflpoCF74z+rV+7UMwidAZknM2TzrYY+
         twXQ==
X-Gm-Message-State: AOUpUlFVPxtsz1LaIVvA42eFwnpU8aaEIQdp9JAmGmC6YHZjK5HLyPnb
        O318t6QhOEi34sdC7pPtlhQZ+4c93OhmpWl1X1BG7g==
X-Google-Smtp-Source: AA+uWPwzRqKLYhQPHlzg7S6TbwP+aJV1bOZrkws9+d/SYV4ta2Lm0WJQFLPUT2nkKou7bf1Mws8fHJW1ukBg7e6cvHY=
X-Received: by 2002:ab0:458f:: with SMTP id u15-v6mr2940247uau.202.1533858296678;
 Thu, 09 Aug 2018 16:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180809171722.144325-1-swboyd@chromium.org> <20180809171722.144325-8-swboyd@chromium.org>
 <CAODwPW8eg2WOh9-Raeb8Q65E-5D7RDheDU8e+H68FHGa0MS37A@mail.gmail.com>
 <153385579866.220756.16086660810932774163@swboyd.mtv.corp.google.com> <CAODwPW84FYK3k5=n4gQ4EPJExhQ59LCEi31ZYi2Bq2y9FH_E_A@mail.gmail.com>
In-Reply-To: <CAODwPW84FYK3k5=n4gQ4EPJExhQ59LCEi31ZYi2Bq2y9FH_E_A@mail.gmail.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Thu, 9 Aug 2018 16:44:43 -0700
Message-ID: <CAODwPW8+QSittJdNLWpWKU=JNJa5bssMHQ4ER4CfnUAWaL1JGA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] firmware: coreboot: Request table region for
 exclusive access
To:     Julius Werner <jwerner@chromium.org>
Cc:     swboyd@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Brian Norris <briannorris@chromium.org>, samuel@sholland.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, looking at what IO_STRICT_DEVMEM really does, would it
really prevent userspace accesses to these areas? Because it seems
that it only prevents accesses to areas marked as IORESOURCE_BUSY, and
while I can't fully follow how the kernel assigns that, comments
suggest that this is only set when "Driver has marked this resource
busy".

So after you make the change to the other patch where we immediately
unmap the coreboot table again at the end of the probe() function,
shouldn't it become available to userspace again even with
IO_STRICT_DEVMEM set?
On Thu, Aug 9, 2018 at 4:37 PM Julius Werner <jwerner@chromium.org> wrote:
>
> > Furthermore, I see that my system RAM excludes this coreboot table so it
> > doesn't fall into the bucket that CONFIG_STRICT_DEVMEM would find.
>
> Yes, that is intentional. We don't want the kernel to try to use that
> memory for anything else (since we want those tables to survive), so
> we mark them as reserved in the e820 map.
>
> > > (I guess an alternative would be to rewrite 'cbmem' to use
> > > /sys/bus/coreboot/devices if available to get its coreboot table
> > > information. But we'd still need to maintain the old path for
> > > backwards compatibility anyway, so that would really just make it more
> > > complicated.)
> >
> > This sounds like a good idea. Userspace reaching into /dev/mem is not
> > good from a kernel hardening perspective. That's why those strict devmem
> > configs exist. Can cbmem be updated to query information from device
> > drivers instead, so that we can enable CONFIG_IO_STRICT_DEVMEM as well?
>
> Well... problem is that cbmem doesn't just access the coreboot tables,
> it accesses more stuff. There is actually a larger memory region
> called CBMEM (that's what the utility is named after) which contains
> all sorts of random memory allocations that coreboot wanted to survive
> for the lifetime of the system. The coreboot table is one section in
> there, and it sort of serves as a directory for some of the others
> (although there's also just a general CBMEM directory... there's some
> redundancy there). But cbmem can also print some of the other CBMEM
> sections which it finds by querying the coreboot table, such as the
> firmware log or the boot timestamps.
>
> So the question is how we can get to that content if /dev/mem isn't
> available anymore. One option would be to just write separate kernel
> drivers to completely replace the cbmem utility (we already have one
> for the log, for example), but I think Linux generally doesn't want to
> have too much logic and parsing and stuff in kernel drivers. Another
> option is to add a driver that just exposes a sysfs file through which
> you could read (we don't need to write) the CBMEM area... but then
> we'd essentially want that to take absolute addresses because that's
> what the coreboot table pointers contain, so we would've just built
> /dev/mem by another name (for a restricted range).
>
> The nicest thing, really, would be if there was a way for a kernel
> driver to mark specific regions as "allowed" by /dev/mem. I don't
> suppose we'd be willing to introduce a mechanism like that?
