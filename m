Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58517C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCC32146F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UejQ85FY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DCC32146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeHBKV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:21:58 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:43356 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeHBKV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:21:58 -0400
Received: by mail-qt0-f169.google.com with SMTP id f18-v6so1368980qtp.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 01:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oNckchScRrgUL8jKS42uSnplmoil5TAfqgcZC/4GdfU=;
        b=UejQ85FYmnKtgqZUs9LkzZwddkkmLdMpkswsd2JDwu/AAo8EGYVlxu+B46TTZ0uCos
         NbG3uhn5f32v30j7ymUXVN8i6ZKbZD9gMUKNaCsgLlw99C2CKUZ5yygtftqVDE42LfdO
         kYXu7W/iqPHS4jijmlc+g6PUn2WKQequirSZ45ulquI7YgY64HzBKjpyIvDAmQ225Zis
         kAJG90awy0IKZJ0tFjj/eDFJUcE06JNZmY8k8NCMucvkkGtR412Fuyk40HojxHOj5AE1
         rHBM7Q52LlTuymPCam+dM7bVkLhoh85Vl6CV2ABn3prPeERQBpsfFarZT656AxVnpbu6
         yDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oNckchScRrgUL8jKS42uSnplmoil5TAfqgcZC/4GdfU=;
        b=baNrhJzBqY/hFAuBxyWrSM1yNem0FLersiAeSF20YbJtEWlbUkd7VzKbS2/+pmPkY/
         Pttnm0TXpyhHvxxzsbhXy2YoHI2eH/c4KXhWXBar0IcOhe4D55uUBS/cL/yXxTLbD4MH
         QmEQad1aQOfmUSMnhWuyw+PH+GQBJz+PAl/pDmpNJoeCXvQU9ffsPtS2pwjTtAuc2pbV
         bljp9VPytM3DHh5Ci4aMMh7IsoSNc3j7vd2qAhDudrA3IYVsAy/S5hOiZkmrSVumAEj0
         QrIYxRIbkj6zRo2KHm6PoMUCQjdsgvH1bVkQeBEL1Lo4ByeEgWlSeh4Zq6oHJe+5VePo
         IG2g==
X-Gm-Message-State: AOUpUlFnWRhnNqQ86VKW+bXTZlKcD1ZBE1wLYwpNZCiUfrJfHSZMoEFo
        42PL4lf5k3pypfXSBCCWzHywV647cLTAQ7+iGQ4hjqni
X-Google-Smtp-Source: AAOMgpfi8hCO9hEFBMz2fprhp29qr/XPe/fBVPWzoraCU0dX95idxZ7JzTZJ7KtylkpcQ9HrxOCRoLf2mTVRvRQAVso=
X-Received: by 2002:a0c:f94e:: with SMTP id i14-v6mr1574842qvo.73.1533198711762;
 Thu, 02 Aug 2018 01:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <1533116658-14924-1-git-send-email-goodwater.wu@gmail.com>
 <1533196290-9669-1-git-send-email-goodwater.wu@gmail.com> <20180802080258.GA13222@kroah.com>
In-Reply-To: <20180802080258.GA13222@kroah.com>
From:   Jheng-Jhong Wu <goodwater.wu@gmail.com>
Date:   Thu, 2 Aug 2018 16:31:40 +0800
Message-ID: <CALtPoQCskvbkEYE2m6Q=h_gPEV6+Abt+SJqLjVtAa+jReHGrzA@mail.gmail.com>
Subject: Re: [PATCH v2] staging: mt29f_spinand: fix memory leak while
 programming pages
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear greg k-h,

Before device is removed and freed memory automatically, programming
pages may run many many times.
Assume we erase and rewrite a large part of the flash, then
spinand_program_page() might exhaust memory if memory is not large
enough.
We may not remove and re-add the device between each programming page, righ=
t?
In fact, OOM indeed occurred when I tested programming multi-pages by
mtd_debug tool.
Erased first, then programmed pages.

Best Regards,
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
Jheng-Jhong Wu (Victor Wu)
E-mail: goodwater.wu@gmail.com
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
Greg Kroah-Hartman <gregkh@linuxfoundation.org> =E6=96=BC 2018=E5=B9=B48=E6=
=9C=882=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:03=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> On Thu, Aug 02, 2018 at 03:51:30PM +0800, Jheng-Jhong Wu wrote:
> > In spinand_program_page(), it uses devm_kzalloc() to allocate memory to
> > wbuf dynamically if internal ECC is on, but it doesn't free memory
> > allocated to wbuf at the end of this function. Before the spinand devic=
e
> > is removed and frees memory automatically, programming pages may run ma=
ny
> > times. This leads to a memory leak issue when internal ECC is on.
>
> How is this a memory leak?  The memory will be freed when the struct
> device is removed from the system.  How did you test that there was a
> leak?
>
> > Changelog:
> >
> > v2:
> > - use kzalloc()/kfree() to replace devm_kzalloc()/devm_kfree()
> > - add some descriptions to commit message
>
> this changelog goes below the --- line.
>
> thanks,
>
> greg k-h
