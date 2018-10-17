Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589CBECDE3C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0340421476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT6DCT6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0340421476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJRHQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:16:50 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41925 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeJRHQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:16:50 -0400
Received: by mail-oi1-f194.google.com with SMTP id l197-v6so22497497oib.8;
        Wed, 17 Oct 2018 16:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hJn87BvLuxhYZmiTqEFnXSI74/Mevnd5q3TnwuBF7bw=;
        b=jT6DCT6mYcmFRp9jb/7O5FRZ3t2vsI1hQb3kMjLFxIetz0GCf3hO/FNiiUkQRtHy2K
         Pqzu0URt/bwT6vAjUn2AtvMBgUsAU7xSN2QF4mQDAyvzCDDYNismy3atKqoqCE+bx5Cr
         4gU8VBf51bDJOB5LP3dnDcTuBjcl9MsDIOwTQ6ZeVFrDvspMHUukq017C1wWlXWnC0TS
         0cJgZT/eIp9oxqSfPzz3n0vGPHESOklFfvP+l9qYkAYjI3iup11hbyuJrc3FKK//ZjvW
         TRo2XNhak8JjSRLTWnnGFJ5K479TZ/sMN9t6Et2rTPzawExpS+tADYxiHMUPmGYrJFl5
         UjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hJn87BvLuxhYZmiTqEFnXSI74/Mevnd5q3TnwuBF7bw=;
        b=bFubelYK2APa+XAwA0P5U78yN+ZbY2YXow0yoCIqJXjUwm2iOi9z8nxhlUhtIc08Nt
         wvZsHJ8m3je3RZ6Db6xAllCbi6/SFHJkcJ5+XW60wfedeiKPUDZhdCKGKRkyNsCXz2om
         RQXJqi0QVruGZbYMOr/Na5UVU+CfR/bjMCg0MI5Gpzv7C5YATPdQNlnXzcONEzGZqEha
         V+kucNdf65jUFDkjvtjePMsx96WAPP55bb8RoHXfxGWymFQuncKa/WWQ13zVyAzp+fpH
         1RfEdgB62+4LdkgGZWEUSYFNZVeXWkSaWjIL30VEiKPMe6rvunfwz7oSafoW7BZPvdzO
         cXng==
X-Gm-Message-State: ABuFfog7TVkDrBRDVjmAzMfziFSmTKki2/RJJra73Io4/kIHLwSSG4WN
        Zv+kh4N40R/Z631JRA41qAhjSGFrjUSuk7Bin3A=
X-Google-Smtp-Source: ACcGV63aFM79y/zVo4zBF7ahtIHm0C3pzoFL24KTo/LlAW1e3jAgu7hC6ZTYgpc0udJfAbqmkC34QEvMFRw5MeDre1Q=
X-Received: by 2002:aca:1c19:: with SMTP id c25-v6mr14310383oic.246.1539818330014;
 Wed, 17 Oct 2018 16:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181017000809.GA21292@WindFlash> <716d591a-a0da-e048-a00d-0fe7dabdc4f1@koikeco.de>
In-Reply-To: <716d591a-a0da-e048-a00d-0fe7dabdc4f1@koikeco.de>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Wed, 17 Oct 2018 20:18:37 -0300
Message-ID: <CADvQ+rGoxSHuVjA1-wbYW=bvb5sUjJS1EZSKdkHU2dwzjgDxow@mail.gmail.com>
Subject: Re: [Lkcamp] [PATCH 1/4] Adds -Wshadow=local on KBUILD_HOSTCFLAGS
To:     helen@koikeco.de
Cc:     lkcamp@lists.libreplanetbr.org, x86@kernel.org,
        linux-kbuild@vger.kernel.org, Matthew Wilcox <willy6545@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Helen,

On Wed, Oct 17, 2018 at 1:32 AM Helen Koike <helen@koikeco.de> wrote:
>
> Hi Leonardo,
>
> Thanks for the patch.
>
> On 10/16/18 9:08 PM, Leonardo Br=C3=A1s wrote:
> > Adds -Wshadow=3Dlocal on KBUILD_HOSTCFLAGS to show shadow warnings
> > on tools built for HOST.
> >
> > Signed-off-by: Leonardo Br=C3=A1s <leobras.c@gmail.com>
> > ---
> >  Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index e8b599b4dcde..fb0a9ac195e7 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -360,7 +360,7 @@ HOST_LFS_LIBS :=3D $(shell getconf LFS_LIBS 2>/dev/=
null)
> >
> >  HOSTCC       =3D gcc
> >  HOSTCXX      =3D g++
> > -KBUILD_HOSTCFLAGS   :=3D -Wall -Wmissing-prototypes -Wstrict-prototype=
s -O2 \
> > +KBUILD_HOSTCFLAGS   :=3D -Wall -Wshadow=3Dlocal -Wmissing-prototypes -=
Wstrict-prototypes -O2 \
> >               -fomit-frame-pointer -std=3Dgnu89 $(HOST_LFS_CFLAGS) \
> >               $(HOSTCFLAGS)
> >  KBUILD_HOSTCXXFLAGS :=3D -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
> >
>
> I believe this should be the last patch on this series and not the first
> one to avoid commits in between where we have those warnings.
>

You are right, I will change the order for v2.
Thanks!

> Regards
> Helen

Regards,
Leonardo
