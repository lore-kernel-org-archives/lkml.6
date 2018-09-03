Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B666C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A5C20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKMsLhn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A5C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeICTcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:32:12 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:36264 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICTcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:32:12 -0400
Received: by mail-io0-f177.google.com with SMTP id q5-v6so661532iop.3;
        Mon, 03 Sep 2018 08:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qb8K/qhM08+8LbmFEFyZMFZh2Dvf9853JXYmu1ZGGoo=;
        b=vKMsLhn/Pzfp0q2Ch4GUMDHD2ZWtnHbCJZQ5vHy419prVjwzlscngeRTiXWjM48NQq
         qvEd7xVycBX0l+eFDM4aD53rF7jXRDzGQ5j5QRTbh5Zmkcra+O6MEmZsCERu3/8lJzjv
         tMq0QsjHbWQbn0Fs8QqVucmV/mAcwAC6kkJboYa5QCbiQtWZPh1pnSX2DOMOPbrEyguz
         eyvAFvVhBUkPaE3GoZaZmqWLOYH2DgFYH/uDsNe/t81EXaNXgLF8Zgfs/2tIwVynsIb3
         aC2xQ6BeM+G2dfMKaFPjsvbH0TsaFD2ZQQQQFo7Nyk0zOkHz1H63F46qmZW5v+2y/M82
         YzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qb8K/qhM08+8LbmFEFyZMFZh2Dvf9853JXYmu1ZGGoo=;
        b=I+LGrI7b+jv0cWbrtfZ2zvagWMeR79Tk8XsPhSvUj/ynsIzDxTNwfQd4uWiqfD8tEQ
         todGJBKxG7fX0oYnKWIadOA1QEs2VonI/6RIjJm49MG506WUPK784TWa8pvGqQXpK3EI
         Jg5dEmdzkBsAGyyYhZ2lLmPumyxnve21OQZp9k1zVh/FcV58PKNo/XHPBmR1JgzW4kwz
         x9mYKukUItl/3hz1DUHvlROMzyinMbYt+T3eaGzfBBUuZj7S+Sb7Vpewg1THlGIZJ4UL
         i8ESsq/QaU55UXjMlp9zihSO8YxdvAg9XAQn/zqe0V/0LAdQKVfhr1LgwIsp4iuySnBH
         zt5g==
X-Gm-Message-State: APzg51Dpjlv6Jfw6z1tEr2PL+PT9cHXNl41hF0Pqo8bAli1hoQwpr+3A
        owvQP8iyQikZw7HzOa1PnJICuUBQ0+KeMidxQT0=
X-Google-Smtp-Source: ANB0Vda0N43S8gJDcDS9iG1Z5PJg6koe/HOiqnrz/Ngyp+lgVEpQXg5xLoHHf59S7fW/aEdFWDBFw0uxibGKUMNRXRc=
X-Received: by 2002:a6b:27c9:: with SMTP id n192-v6mr18223016ion.138.1535987495469;
 Mon, 03 Sep 2018 08:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20180903132353epcas4p373e876f1b52dbed6df7bd3acc73fcdf4@epcas4p3.samsung.com>
 <CANq1E4QwNg0VuAZZtatOTXspv7Y-z_HSa-9CHzK2Y28CGK8W4Q@mail.gmail.com>
 <1982440.Fn0LzJ7a3l@amdc3058> <dc7f08d7-77fc-92ca-b6ec-f9d5a8f24cf3@redhat.com>
In-Reply-To: <dc7f08d7-77fc-92ca-b6ec-f9d5a8f24cf3@redhat.com>
From:   David Herrmann <dh.herrmann@gmail.com>
Date:   Mon, 3 Sep 2018 17:11:23 +0200
Message-ID: <CANq1E4TiMSY=udGJWZoDzMhdsRjC==QCRFPO+Oja7KoyBX-6fg@mail.gmail.com>
Subject: Re: [REGRESSION] boot-screen override by "34db50e55656 efifb: Copy
 the ACPI BGRT"
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, linux-efi@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey

On Mon, Sep 3, 2018 at 4:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 03-09-18 16:16, Bartlomiej Zolnierkiewicz wrote:
> >
> > Hi,
> >
> > On Monday, September 03, 2018 03:23:38 PM David Herrmann wrote:
> >> Hey
> >>
> >> Since this commit:
> >>
> >>      34db50e55656 efifb: Copy the ACPI BGRT
> >>
> >> the kernel will override boot-splashs unasked. This breaks the
> >> graphical boot-process on our setups. In particular, we have a setup
> >> where an efi-boot-entry draws the early boot-splash on-screen, then
> >> hands-over to the linux-kernel + initrd. The boot-splash daemon in the
> >> initrd then takes over control of possible animations.
> >>
> >> With the mentioned commit compiled in, the kernel will redraw the
> >> firmware logo on screen at a random time without any way to intervene.
> >
> > You have CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER=y (the deferred
> > console takeover support introduced in v4,19-rc1). I assume that this
> > is intended?
> >
> >> What is the intention of this commit? Why is the kernel re-drawing the
> >> firmware logo unasked? If someone during the boot-process draws
> >> content on the screen, I would prefer if the kernel does not clear
> >> that on driver load.
> >
> > +/*
> > + * If fbcon deffered console takeover is configured, the intent is for the
> > + * framebuffer to show the boot graphics (e.g. vendor logo) until there is some
> > + * (error) message to display. But the boot graphics may have been destroyed by
> > + * e.g. option ROM output, detect this and restore the boot graphics.
> > + */
> > +#if defined CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER && \
> > +    defined CONFIG_ACPI_BGRT
> > ...
> > +static void efifb_show_boot_graphics(struct fb_info *info)
> > ...
> > +#else
> > +static inline void efifb_show_boot_graphics(struct fb_info *info) {}
> > +#endif
> >
> >> Can we either provide an option to disable this feature, or revert the commit?
> >
> > Hans?
>
> We use the ACPI bgrt extension to get the logo to draw and then
> draw it since some devices rely on the OS to draw it and otherwise we
> just end up with a blackscreen when doing silent / flickerfree boot.
>
> Ideally you would be able to get your vendor to put the logo in firmware
> in the ACPI bgrt extension, then you also do not need to play any tricks
> with an EFI binary drawing your own logo. But I can understand if you don't
> have control over this, so you need to do this with the EFI binary trick.
>
> I can also understand that you want to use deferred console takeover
> in a setup like yours to avoid fbcon messing up what is on the display
> during boot, that is exactly what it is for. So I think a reasonable
> approach here is to add a kernel commandline option, say:
>
> video=efifb:nobgrt
>
> David, would that work for you?

That would be perfect!

Thanks
David
