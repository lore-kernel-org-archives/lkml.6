Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA14C65BB9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C293821473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yk9jyO1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C293821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbeJFBM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:12:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39721 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbeJFBMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:12:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id p1-v6so8546004ljg.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 11:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFsDYgBglL/1P1wMwgpHMxzXFsKg0WwG6VaGB2Fv/5A=;
        b=Yk9jyO1GxmeGuyd5jQ6z01V3ntVGNpvVy2bWwSF+a3EFZKqDkb0kA+ep7wCnvi/r+u
         OWP51a+El4W8Ruga7W5LTLw0dH6zQO5nTL0h8E+0CS090OYoYRw7SxsRMsB5m5TgUFgx
         YI3FJOJYhBR92SG73GQdGo5SMuZTtk6H9nCg0wdT+azkaSmdgI1eGHRA19/nYZE/dVkf
         smVnSw3SgVFa/tRsbYk0z7GphsYU3FD0AarYZwaeGjuJxd/xVickhTMtIUlXEregTs5X
         p+RmQBr9mCcdiH3rvSFtc7CQTndb5SlLpgUvJyKa70hTTC2xtKLiK4I/D7sSTyUpxF4n
         /6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFsDYgBglL/1P1wMwgpHMxzXFsKg0WwG6VaGB2Fv/5A=;
        b=MyA+UzZJM5RiWmJNH9GDxVYSHrRYIQRXxFB9jrsRbDnOlnjl2LIFWuDAwTvhXjt+31
         MKqO5bb8my41Sd/MNR2+SCd5mf+OOr7Zy2u34KuUZgZJJU2kYFiF2F9eBxfqqdYNbZXt
         H8qshvEjsYxvbRrnwROhLNqZlzAk34YPla9a5msQMGi+U+UpXM0m2hkQGKIhh2tF9zQZ
         9oxk4DfjNVXBGI2gAXjoLi9D79irRKHqMO6f0Y5OKbaqDQ7zJotM2yTlaBAAjGRLxZTn
         M/9A5MDAuq4NmGgqhiiGH8Ron9yNG4XWlhP5FqQZU4iJJo1PkAcXg2jpnsX8vywIWEp6
         AP6A==
X-Gm-Message-State: ABuFfohJSYc83yar6J+TwhIgNLCGrnIf3aPU8x9eGRZ6vjCZDt57YjFN
        AyCnXMtXMiGNwztMs0W7GBs20A9s4fV2MVcAbMM=
X-Google-Smtp-Source: ACcGV61QA4P8Odg2S/8sLKiLkr4EmLMZ4/lSZ+hMn0RCSeyOe+yKQDlF+oyT4MtWSekveYBJsKU92FzeQ9yIJ2OCt8I=
X-Received: by 2002:a2e:86ca:: with SMTP id n10-v6mr8941593ljj.90.1538763180242;
 Fri, 05 Oct 2018 11:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20181004142942.11887-1-ricardo.ribalda@gmail.com>
 <20181004142942.11887-2-ricardo.ribalda@gmail.com> <20181005002125.12fd229f@bbrezillon>
 <CAPybu_26HST5xGfhE6MoVTRZok_gfDqN=ZOAesuEMVskdrCpLA@mail.gmail.com>
 <20181005090811.6b7e9957@bbrezillon> <CAPybu_38xH2Cv+eONQmEJ1i6k=oiQM=WrcwOFR29LbtRvWfKXA@mail.gmail.com>
 <20181005103730.57d52e3c@bbrezillon> <CAPybu_1RMcro3xLNW5mbybYdObCTq=QwXgk+RT6hcmRGTh6s7A@mail.gmail.com>
 <20181005121235.7e64b64a@bbrezillon> <CAPybu_0TbeN+-F6zwN8XOMuY1EpgE6GRi=ExDx6O3Yun9kXjYQ@mail.gmail.com>
 <20181005141057.0f1b0a9b@bbrezillon> <CAPybu_0OZR==4k5nxVRZ-1NjPEXLQsun7QhnYds8dPndreUjcQ@mail.gmail.com>
 <20181005165234.468d2397@bbrezillon> <CAPybu_1cd9aJN9mC9m36Gd_fhU5UnfLH9EtU0h8BvJCZchOV_A@mail.gmail.com>
 <20181005182931.172b8f1c@bbrezillon>
In-Reply-To: <20181005182931.172b8f1c@bbrezillon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Fri, 5 Oct 2018 20:12:43 +0200
Message-ID: <CAPybu_01Bn5qmv91Pc-DExCAMheJyGYxiSvmGDUGiSxBA+S0DQ@mail.gmail.com>
Subject: Re: [PATCH v10 10/10] mtd: maps: gpio-addr-flash: Add support for
 device-tree devices
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris
On Fri, Oct 5, 2018 at 6:29 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Fri, 5 Oct 2018 17:40:44 +0200
> Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
>
> > Hi Boris
> > On Fri, Oct 5, 2018 at 4:52 PM Boris Brezillon
> > <boris.brezillon@bootlin.com> wrote:
> > >
> > > On Fri, 5 Oct 2018 16:06:57 +0200
> > > Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
> > >
> > > > Hi again Boris
> > > >
> > > >
> > > > On Fri, Oct 5, 2018 at 2:10 PM Boris Brezillon
> > > > <boris.brezillon@bootlin.com> wrote:
> > > > >
> > > > > On Fri, 5 Oct 2018 14:04:52 +0200
> > > > > Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
> > > > >
> > > > > > Hi Boris
> > > > > > On Fri, Oct 5, 2018 at 12:12 PM Boris Brezillon
> > > > > > <boris.brezillon@bootlin.com> wrote:
> > > > > > >
> > > > > > > On Fri, 5 Oct 2018 11:54:18 +0200
> > > > > > > Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
> > > > > > >
> > > > > > > > Hi Boris
> > > > > > > >
> > > > > > > > Just seen that  you already did the rebase at
> > > > > > > > https://github.com/bbrezillon/linux-0day/commits/mtd/physmap-cleanup
> > > > > > > >
> > > > > > > > Thanks for that.
> > > > > > > >
> > > > > > > > I am about to test it in real hw (unless you want me wait)
> > > > > > >
> > > > > > > Sure, go ahead and test it.
> > > > > > >
> > > > > > > Thanks,
> > > > > > >
> > > > > > > Boris
> > > > > > I had to change this on your patchset to have it working on hw:
> > > > > > https://pastebin.com/78A7yhJ9
> > > > > >
> > > > > > If you send the patchset to the mailing list I can review it patch by patch.
> > > > > >
> > > > > > Also
> > > > > > mtd: maps: Prepare merging of physmap and physmap_of
> > > > > >
> > > > > > I do not think that can be bisected. (Not sure, I have to test it)
> > > > >
> > > > > Okay, I'll have a look.
> > > > >
> > > > > >
> > > > > > I add the diff to the mail, but gmail will probably scramble the
> > > > > > lines(yes I know I have to use other mail client)
> > > > >
> > > > > The diff looks good, I'll fix that an send a push a new version.
> > > >
> > > > Also fix on physmap_flash_remove
> > > >
> > > > physmap_data->exit(dev); must be called BEFORE
> > > > map_destroy(info->mtds[i]);
> > >
> > > Hm, that's weird. That shouldn't happen. Do you have a non-NULL
> > > ->exit()? Can you detail why you think ->exit() call is the cause of
> > > this OOPS?
> > >
> >
> > No idea.  It was crashing at:
> > https://github.com/bbrezillon/linux-0day/blob/mtd/physmap-cleanup/drivers/mtd/chips/cfi_cmdset_0002.c#L2839
> > cfi_cmdset_0002.c seesm to play with cfi->chips on its reset callback
> >
> > I added some printfs:
> >
> > if (!cfi),
> > if (!chip)
> > if (!cfi->chips)
> >
> > sometimes it crashed on one place, sometimes in another :S. Reading
> > back our patch it seemed more logical (semantically :P) to
> > destroy after exit and not the other way around.
>
> Actually no, it makes more sense to call ->exit() after destroying the
> maps, because the platform-specific ->exit() implem might release
> resources that are used during the destroy_map() operation. Another
> reason to keep it in this order is that operations in the remove path
> should be in the reverse order of those done in the probe path, and
> ->init() is definitely called before map_probe().
>

I think I know what might be the issue. on cfi_cmdset_002.c
cfi_amdstd_reset can be called in parrallel to cfi_amdstd_destroy.

maybe we should call
unregister_reboot_notifier(&mtd->reboot_notifier);
before
cfi_amdstd_reset(mtd)

need to try that on real hw with some strategical printfs :P. But that
will ahve to wait til Monday

Cheers


> >
> > I made that change and it stopped OOPsing at reboot.
>
> Maybe it's just a side effect, especially since I'm pretty sure your
> physmap_data->exit() is NULL (assuming you do use DT to declare your
> flash).
>
> >
> > Havent had the time to dig deeper. But if it does not break anything
> > on your side to invert destroy and exit please do so. It was not
> > oopsing with my patchset.
>
> I'd like to understand what's happening before doing this change. As I
> said, I fear this reordering just hides something else.



-- 
Ricardo Ribalda
