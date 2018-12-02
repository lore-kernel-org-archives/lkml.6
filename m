Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80063C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 08:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270662082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 08:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7P/dJkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270662082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbeLBIft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 03:35:49 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51259 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeLBIft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 03:35:49 -0500
Received: by mail-it1-f196.google.com with SMTP id x19so4824117itl.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 00:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Uq69dIEkiIjTcqOHiKLHkPsY2FuJJIC6176FyVtaVA=;
        b=i7P/dJkp3BTfVnISsKTYx85nBVcf8kTbVIQnlVEquFFASE7BIrBKBEif27gKE+Y1dn
         i8sXuDuMChvAJXB6bExCCRJB+lvZrzLcXDib65utlG7UPDE6eYE66PH2Wjr01hlbOTX0
         viZ3cmW6H06uX2U2ICZdeI50blTG6Lmh1MKb8uGsMJ19wFBblZTs+i4+pp54syjP8oeo
         Xbly5r7oujQmC5F1nIdiR0ScuwVRRrp03kFNbRjvHNj0xUtPYhsph6bWKOkSM6ofisHz
         V7X2C6M4UE2ZvrH4gvQEXFvZlHQCkCu04zjYW6diVydHhvBFCe6d4ekSw0jkc7PndRt4
         7M2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Uq69dIEkiIjTcqOHiKLHkPsY2FuJJIC6176FyVtaVA=;
        b=n7x3+iKhZjlgbudAvD56xiBB/fJm0deKWtTgphg++Ja1gsjwU6zxm1fJ5GcGRFDN4Z
         iCATIzyISy2l3zdjfFT1+4L9t7KqP4pCrd9lREXO6cDhTGgJnIxqGYEdNC6Y9qyE2whc
         0EBEN38GjZaOS1CUPEpykvzmSUFuMj46v1xnCsHPYgacWLo5Qc+ZRYbGYbWJL1SqSTaS
         CFfEz2UL0ipH1m349Wau2aUH+G7ENOQE3Vg9kh0W0dMI8pwkUZM0GfcXaXWNG/VITtmO
         FfxGLtXfKl+UZVLXoKEhEJ68N6hgPsh0Afes9bdU5PF/JF4q6Yth93BaZpcuEC3Ciz9n
         NmJg==
X-Gm-Message-State: AA+aEWbBEJEiJ2F4SafnSAlepdJD1dUG3wN7fD+aFbr199eyHHDd0qdW
        hCmzp2yMViGpdzUgJZbd/QOlol7udbKG9Q+3ST0=
X-Google-Smtp-Source: AFSGD/VjBYBwe078qT5AWRCXp1fz3Cy744AkBgbfWCsunMaTr7qs1Jgl7NkGKJ18nFH2UvytSaKgR+hQUK6pV8VJ7wU=
X-Received: by 2002:a02:6c90:: with SMTP id w138mr10651122jab.60.1543739742979;
 Sun, 02 Dec 2018 00:35:42 -0800 (PST)
MIME-Version: 1.0
References: <20181202073202.10587-1-tiny.windzz@gmail.com> <20181202091543.73c74aea@bbrezillon>
In-Reply-To: <20181202091543.73c74aea@bbrezillon>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 2 Dec 2018 16:35:20 +0800
Message-ID: <CAEExFWtRoC2dQd_6B5d1c1tt-stdSa4jafBNTsUWJxrZkczfkw@mail.gmail.com>
Subject: Re: [PATCH v3] mtd: remove DEBUGFS_RO_ATTR()
To:     boris.brezillon@bootlin.com
Cc:     robert.jarzmik@free.fr, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>,
        richard@nod.at, miquel.raynal@bootlin.com,
        Kees Cook <keescook@chromium.org>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 2, 2018 at 4:15 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> Looks like getting rid of DEBUGFS_RO_ATTR() is just one of the change
> you do. I think you should change the subject line:
>
> "mtd: use DEFINE_SHOW_ATTRIBUTE() instead of open-coding it"
>
> This way it covers all of your changes.
>
> On Sun,  2 Dec 2018 02:32:02 -0500
> Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> > We already have the DEFINE_SHOW_ATTRIBUTE.There is no need to define
>
>                                             ^ missing space
>
> > such a macro,so remove DEBUGFS_RO_ATTR.Also use DEFINE_SHOW_ATTRIBUTE
>
>                ^ here as well
>
> > to simplify some code.
>
> If you go for the new subject line, you'll have to change this commit
> message.
How about the newer?

MBR,
Yangtao
