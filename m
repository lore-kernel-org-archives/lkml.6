Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F869C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CB1206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBb6LpjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CB1206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbeIMUPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:15:54 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35703 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbeIMUPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:15:54 -0400
Received: by mail-ua1-f66.google.com with SMTP id m26-v6so4961050uap.2;
        Thu, 13 Sep 2018 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mi4KnT1imwsO/ZnQMpJQ/Hg8p+G2PM+roVF/gQ9mpn4=;
        b=HBb6LpjQM6kmnXJz1hNSilptrzz+V6OALz3xtPKiiaANCiS4f4/dFkNEYjCL3Ma+7b
         IOeiPKvId2LY1tYCjOuUpdc8Vb4DV86g9XxoDZLe06L3shdaof//TwkFpm+lVx9gKUt0
         DbFM/gvAw4NQewYoMdFOv72rMwUeMgOPf+OVxWUCGa3ezYfTDmuFnU8Y8sspRBTz5fvU
         csB8MIHtZzIzcuCt30hlEFnjZsZvuijb8t8EHdDg4Oddp4h9kBJe9Gn3fylQ4sdq9XMr
         egA56DDGPnYtdMMCJ+hbgFfA3leShz3S1zt7zR7pY3l5i7hPRfcplsBh0W9q1jMoe8TB
         O4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mi4KnT1imwsO/ZnQMpJQ/Hg8p+G2PM+roVF/gQ9mpn4=;
        b=B1h/b0u2oQ71T/c/9BqY5tqFYucwudmG0XL6WlVCddnawX0I2pgE0HjQoO2vnlNw2F
         C8bgs9Fbp2GAe2tTMPXzpfLzD8BS3hrCYhqbaOJ7mZIGfDzSoHIwYuFrP/C1NQtqufGj
         w9EIMiLehf/mwLRRRyARwNGRn/mlSEG2SUWcNWVkl8yjlaEE7nXNyFDLu9nn9k9xjy6i
         flTyiCowbP7uM/BrMh20kHO8P5aqa++Hb4F/f2p4q0aB/urWKCteYQGnccXns1XD8jDG
         /tQXCk73hJG8QJ7ARmh9YyqRFjWNo2bYRzqap7XTDYThRV0uTq1DuD2m+Ge5BhDXdgll
         Q9pw==
X-Gm-Message-State: APzg51AfQKJpQHNI3Lsi8xtMJ/iouHuQPLl+d+g3Krb58l9oGmdQGtQW
        o+8wGhZdFsp2vc2Ooue5pdQDUcx8y7lOuCEELg==
X-Google-Smtp-Source: ANB0VdaJ4Ot7iIo5FNmgDNosQYXa/hKSjsrwm4UXrHiuKoMKN1xrD4LCmtzYnzAtMsFpuL9+JNnOTqnzwfjRwopip+M=
X-Received: by 2002:a67:5bcd:: with SMTP id w74-v6mr2627362vsg.43.1536851158396;
 Thu, 13 Sep 2018 08:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvb4hOY_Hew-jEUtpyhkGbmh4Tgb0doPC6EaGtz_rMGt7A@mail.gmail.com>
 <eb1fe15c9ced6950d6a38c901278b8196ae4938d.camel@decadent.org.uk>
In-Reply-To: <eb1fe15c9ced6950d6a38c901278b8196ae4938d.camel@decadent.org.uk>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 13 Sep 2018 16:05:47 +0100
Message-ID: <CALjTZvYcKOycB=XeF-Eqtmq3ADh2be+gfWGiw0jbSgEUo6q8Dw@mail.gmail.com>
Subject: Re: 4.19-rc3: bindeb-pkg target is failing on ppc64
To:     ben@decadent.org.uk
Cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018 at 13:32, Ben Hutchings <ben@decadent.org.uk> wrote:
>
> On Tue, 2018-09-11 at 15:58 +0100, Rui Salvaterra wrote:
> > Greetings! I'm having trouble building the kernel on my ppc64 machine
> > (Power Mac G5) running Debian Sid. The make bindeb-pkg target is failing
> > ever since 4.19-rc1. Is this a known issue? If not, let me know if you need
> > anything else in order to help debug this. Thanks in advance!
>
> It sounds like you don't actually have a ppc64 installation, but a
> powerpc installation with a 64-bit kernel.  In that case you will now
> need to add ppc64 as a secondary architecture by running:
>
>     dpkg --add-architecture ppc64
>
> If that doesn't help, please send the error messages you're getting.
>
> Ben.
>
> --
> Ben Hutchings
> Computers are not intelligent.  They only think they are.
>

Hi, Ben!

Thanks for the hint, I had added the ppc64 architecture already, but
no luck. I spent yesterday bisecting between v4.18 and v4.19-rc1, but
the result pointed to an obviously wrong commit.
Serendipitously (by building a v4.19-rc3 allnoconfig), I discovered
32-bit builds fine, but 64-bit big endian doesn't.
I started digging in the git history for some clues. I tried reverting
this commit[1], which seemed suspicious, but the build still fails
(the initial dpkg-buildpackage warnings are gone, though).
Let me know what else can I do to help.

Thanks,

Rui

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=50d511ba6246c46654857b8ef64aefe76a87e455
