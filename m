Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A2CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E52D214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a4vdo/2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E52D214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732747AbeKVGOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:14:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40502 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728923AbeKVGOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:14:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so6918745wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7LnR1whi3fCktNHA4lhxnEMOZoyUlIA+LYKd9nJvDZc=;
        b=a4vdo/2ml5eQ9BRGYN2EP+P+2awrFFv3xldZYspRRFmSeC49418y+d/9MZooWthiDl
         3hBcyCUYtW4LtEUO5l/myUwMFdBrgsHZ9DwZRJcLXqSvxAPYCkbb+7JCUbmx08nL9vTy
         F2nLF8vrHrao6JBLzP9+JijQ6eauz5dHdiKts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LnR1whi3fCktNHA4lhxnEMOZoyUlIA+LYKd9nJvDZc=;
        b=Cci+5jNIEFz9+nKo8ZIiSNnOC+xVPSw8YfQ7PmxMy6uvOK11vdMbxiEL8Plu6jkC0N
         YC5UNv16+dajC7z/oJUL5+/8yxsqSf9oWPSSCIOt6SWqvGCqGUJdyiGf3fX/YvxA5Yr2
         a0T5QRuCz1z1kt1aJzg11TJDA7ta5cyPfUeBdZu5dD3xou9ZHKNa9wx6JVfo/Z92hQW9
         GlVAWygl8nMAHgxoo2rEVA9ETVnXiquuMFSZc6D517BAYdqKeqi+8f+5Joo76n9IpJgC
         k0aqhvQCsKmNjIE4K0p02BQNlCpNT0J/P0+rw9e+M98WJDeEwcOI0n3A5E2KL3Z59uoq
         e/zw==
X-Gm-Message-State: AA+aEWZpx1TRwtC5DvNCQ+VBkoArlyOSW2JOk1dyLSib/+/oCOW8pesD
        Pf2LR0lrVZGFk1pEX+QyrwON9LKk9xaQRoc4RzZcGg==
X-Google-Smtp-Source: AFSGD/V/nmdjhKILiX1GjgbK8zoe/WU06+aTKEns0p7/0kB2zsSAAsHJFY0iHfGXW+rWvoU8Ui6lHb+jywzV+/oagPo=
X-Received: by 2002:adf:a4d9:: with SMTP id h25mr6648764wrb.167.1542829154769;
 Wed, 21 Nov 2018 11:39:14 -0800 (PST)
MIME-Version: 1.0
References: <20181030202713.26203-1-semen.protsenko@linaro.org>
 <CAKaJLVu0h5woVtN5=Mh38ajACBZZQ3JHfRhkjNrwMwYXHEG-NQ@mail.gmail.com>
 <CAHp75Vd-ydncUWQtc8ziLpCMJRFCvjV=ueKB0wRgn7W-pnV09Q@mail.gmail.com>
 <20181121181042.4gzuniz2vzjikpwc@cs.cmu.edu> <CAKaJLVs4MUws7sPPdDk7hnjZ+Z1V0V6bGt=eWn=gsF_B+yULeg@mail.gmail.com>
In-Reply-To: <CAKaJLVs4MUws7sPPdDk7hnjZ+Z1V0V6bGt=eWn=gsF_B+yULeg@mail.gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 21 Nov 2018 21:39:03 +0200
Message-ID: <CAKaJLVvHZwJHu_uZuUDtCZrD7EKY-5xpGhNZN7cQ2M4Bz9osDA@mail.gmail.com>
Subject: Re: [PATCH v2] codafs: Fix build using bare-metal toolchain
To:     Jan Harkes <jaharkes@cs.cmu.edu>
Cc:     hch@lst.de, Andrew Morton <akpm@linux-foundation.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org, Praneeth Bajjuri <praneeth@ti.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Jan Harkes back to "To:" list, slipped away somehow...

On Wed, Nov 21, 2018 at 9:36 PM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> On Wed, Nov 21, 2018 at 8:10 PM Jan Harkes <jaharkes@cs.cmu.edu> wrote:
> >
> > On Wed, Nov 21, 2018 at 06:41:13PM +0200, Andy Shevchenko wrote:
> > > I'm not sure how you managed to miss people in this list (perhaps by
> > > default you have suppress all Cc in your Git configuration), but I
> > > guess we may gently ask Christoph to apply this in case Jan will not
> > > appear.
> >
> > You have got to give me a little more than 10 minutes to respond before
> > assuming that I would not appear... I don't think I've ignored any
> > previous emails on this subject and the only issues has been some people
> > not receiving my responses for unknown reasons (agressive spam filter?).
> >
> > I have no problem with this patch, have it sitting with some other
> > non-urgent patches and in case it doesn't appear upstream it should
> > piggyback with whatever I have to send.
> >
>
> Thanks, Jan, really appreciate it. We need this patch to fix our tests
> with allmodconfig configuration (in Linaro CI loops).
>
> > I still don't know why the bare-metal toolchain couldn't just add a
> > -D__linux__.  I understand that this define is expected to be always
> > present while compiling kernel headers so that there is no good reason
> > to even bother testing for it, which is why I have no issue with the
> > patch. But it seems it would make your life a lot easier if you had it
> > defined.
> >
>
> As I understand it, from toolchain's point of view, if __linux__ is
> defined then it means that the program is being built *for* Linux
> (i.e. we can use Linux specific features, ABI, like syscalls).
> Checking this definition can make sense in uapi headers, but in kernel
> code we shouldn't use it (as kernel is baremetal program and not
> compiled for some OS). I presume that's why __linux__ is not defined
> in bare-metal toolchains (as those don't provide Linux specific
> features, libc, etc).
>
> > Jan
> >
