Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C02C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 10:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989D5217D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 10:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUgUW16s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfBIKfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 05:35:16 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39738 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfBIKfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 05:35:16 -0500
Received: by mail-pf1-f193.google.com with SMTP id f132so2884572pfa.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 02:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qnAp/jDBF3KApSzXGIlpKmmaIHDtvrtAEVH8ml+PxCk=;
        b=qUgUW16sncFk21q3SM4JL9b8FJAXwYqbn3ppsavHQU0K60k3yUZYbxscYUBMcElWlO
         giQB6mLTb4Bj+QLqJIcBnTtn1Bou0m05neXQoxEXfNPURrjxT7IuiUyxYkWfa/Ik5Bao
         vs4T5yrqz9YdnaheRHEQDNp9jUeZYfSf8Qo3QqyaB9KGh8yKrMOWOcUxgo1B88qG4KLu
         u8cO2wnx5u3lgxr/E8IcHtN9kY55Daj6FFfDOwPlSbFYB+Km9P7QH6wVDvRMI+0ipIxN
         tgBuz/hOJftJvU7kp8PKiQA55AC/ItSSXRSWDoE5lMjdhTylL1AcdlrFaY/CLhZx+4OU
         3Qag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnAp/jDBF3KApSzXGIlpKmmaIHDtvrtAEVH8ml+PxCk=;
        b=IKmn2iAYHdJgF0SxJ5mfgy9efnddo0zQoarUiOukp3+tXbZcNuvin3PCSPvwqN9yNP
         b/MhU2dmiu3R06X9GOsU128hwSrkh/IGB0LAAv1MolOosX+7AFs2CKDdrT2wtVhqS8t9
         7L2/9VZuXCzNLcur4QsR4gooQZMr41+dZ+W1alr++jVzONf0rMoyB5ZfVA+fTAzN8jzT
         HyXsY7Exk1f0FI+pAgD7QUEYqkBzUIZD9RTJMiPs/h2SSnPajSrZFIutegBxkO65D8Fe
         ucEW5olo9QLvR3e+tHgkEVyO+Hsqp4WOofLA9m5IVbCSTVgJsBe/0iE0Kasrw2/byT2u
         vUcg==
X-Gm-Message-State: AHQUAua5FEFRl7ys4JECbWcrxfUXbf1oK4MXvgvZtBBCQT8TyFBakFBK
        uu2WUY4Lvy1Ra3ccFjGZddSsOqcNSq+gkdXh9yg=
X-Google-Smtp-Source: AHgI3IYH1RQwNdNFTLx3ZePe3fZdcPxb0YeVw/XxlKkO6A40lEw2A96TNytZQJc2e8rYDmf5sSuFoKPa8pfko2yrBro=
X-Received: by 2002:aa7:82d5:: with SMTP id f21mr6223002pfn.50.1549708515150;
 Sat, 09 Feb 2019 02:35:15 -0800 (PST)
MIME-Version: 1.0
References: <20181022134048.19693-1-david.engraf@sysgo.com>
 <20181030151805.5519-1-david.engraf@sysgo.com> <CAHp75VdOSC8j_1G3z-UO01_JYN20M-YMGOC2JkFDhi8njNZAvA@mail.gmail.com>
 <20190208140810.76ef6c25825a5644d9625f0a@linux-foundation.org>
In-Reply-To: <20190208140810.76ef6c25825a5644d9625f0a@linux-foundation.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 9 Feb 2019 12:35:03 +0200
Message-ID: <CAHp75VdWyGv2QyuwE+4-oFJt8St2UmeuaHhveeLAFPPPuN5=tg@mail.gmail.com>
Subject: Re: [PATCH RESEND] initramfs: cleanup incomplete rootfs
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Engraf <david.engraf@sysgo.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 9, 2019 at 12:08 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Fri, 8 Feb 2019 21:45:21 +0200 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Tue, Oct 30, 2018 at 5:22 PM David Engraf <david.engraf@sysgo.com> wrote:
> > >
> > > Unpacking an external initrd may fail e.g. not enough memory. This leads
> > > to an incomplete rootfs because some files might be extracted already.
> > > Fixed by cleaning the rootfs so the kernel is not using an incomplete
> > > rootfs.
> >
> > This breaks my setup where I have U-boot provided more size of
> > initramfs than needed. This allows a bit of flexibility to increase or
> > decrease initramfs compressed image without taking care of bootloader.
> > The proper solution is to do this if we sure that we didn't get enough
> > memory, otherwise I can't consider the error fatal to clean up rootfs.
>
> OK, thanks.  Maybe David can suggest a fix - I'll queue up a revert
> meanwhile.
>
> I don't really understand the failure.  Why does an oversized initramfs
> cause unpack_to_rootfs() to fail?

In my case I have got "Junk in compressed archive". I don't know (I
would check if needed) which exact condition I got  since there are
three places with this message. The file itself smaller than the size
passed through bootparam. So, when decomression is finished
(successfully!) we still have a garbarge in the memory which is not
related to archive. Message per se is okay to have, though I consider
this non-fatal.

-- 
With Best Regards,
Andy Shevchenko
