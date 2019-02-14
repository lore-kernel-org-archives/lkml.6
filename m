Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D43F21901
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6jJkeZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394659AbfBNMdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:33:24 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:40417 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394545AbfBNMdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:33:15 -0500
Received: by mail-pf1-f169.google.com with SMTP id h1so3046878pfo.7;
        Thu, 14 Feb 2019 04:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gIrID1Wae0jB54iMP1vE9sKn0wbBfMtpadZffWe4TTQ=;
        b=R6jJkeZJihBPsRO+J77Rd6j1o3PLg+brvhWuEc4ij/PbumdR49aO919p1I3lI+rAF5
         GUtr2FbPNd0+fQJkthWyAyCjlFdkHtM5Uz6U56yGiiKIJhqfseQwOOsm4sS4sKNY+umi
         mi2BN1coMtjcdPuEOemGy8LHy791kqGsV/wjwOtcc+6Sb5e70G0gjysQIgm7MtpmRPZF
         gwGyScaxMNVa6sSmr399DgOuddr9u8buyoh9xNt/kFTi31pOZJ6sIonOjzYvZe0dpULq
         /cSucvW4kHmJg7EXeW56nLhPbmHIO1qyUU3ivr4I4ZkHTyLdTsgphRd+DI9/yRPKjRKB
         CAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gIrID1Wae0jB54iMP1vE9sKn0wbBfMtpadZffWe4TTQ=;
        b=lOKAkPU6ap+Giqx3Dci63SwNulbZCA6oFCfmD70oQbvMqZc7xlqvFcIUXQtukSUVRb
         nbpI0nQS7L8WTIHCJ7LqOS+mEvhYZ6x+Gq82cz/vXDNvAHyksc/5aWDWYlNj8RHKSrNS
         e0mt5Gj//YMfhjWsTpESna88hkK6NRhP0tbceLpIwKCwgNR8PQvqnsjuUqcaBd84SIyO
         iVPljlPoptYmXGcYhcu/boHCggw1YXM7lQLd9ZwFl0Wb/dGYT6M90jvS/o80QZulUNSM
         aH9SOB+AoptOYcfsP7B7LsbDN3GJvLu7wJ1P5KzZnxrJ6lUAvnahKznuR2iGOMljP1jD
         VnXg==
X-Gm-Message-State: AHQUAuYo5Ry/DgZG5t/35Fkja/EKDWwAbjyZHBD90XQgUbGdSBKc1RCp
        z3RjKb+Q8pD7KAzSiHNico+PJkZ+2YjbGT0A9C0=
X-Google-Smtp-Source: AHgI3IYVvU2s6U/WLV4xiynbojv/FmlaD5nYwv9dPn3nmokpoDLN1kg9krbLvJuJxgaAepwFuwKp7W94DDMl5SGEuAY=
X-Received: by 2002:a63:1c42:: with SMTP id c2mr1672615pgm.265.1550147593742;
 Thu, 14 Feb 2019 04:33:13 -0800 (PST)
MIME-Version: 1.0
References: <1550091448-28578-1-git-send-email-info@metux.net>
 <CAHp75VeZSrxoxd298eFiJj-N_MRsCXa2GEAXry5jCUi6twt_Xg@mail.gmail.com> <fadb3559-d397-04c9-1bdd-e4d625cce278@metux.net>
In-Reply-To: <fadb3559-d397-04c9-1bdd-e4d625cce278@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Feb 2019 14:33:02 +0200
Message-ID: <CAHp75VeL8Z1EE=vh6VG18ecDxp9Zq4XKmnxc=PHZnNxKqc_BMg@mail.gmail.com>
Subject: Re: APUv2/v3 board support V2
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 1:37 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
> On 14.02.19 03:17, Andy Shevchenko wrote:

> > I dunno how you created this message, I hope you used --cover-letter
> > parameter to git-format-patch.
>
> I'm using: git send-email --compose <...>
>
> > Just don't forget to add -v<N>, where <N> is version.
>
> hmm, git send-email doesn't seem to have a corresponding flag :(

It's there from several releases. But it's not a send-email option,
it's format-patch one.
send-email passes those commands to format-patch.

Perhaps time to update your ancient version of git tools? :-)

-- 
With Best Regards,
Andy Shevchenko
