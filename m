Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2BBC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701A52082F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JXmvUkXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbfAaMYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:24:23 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34873 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbfAaMYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:24:23 -0500
Received: by mail-vs1-f68.google.com with SMTP id e7so1842732vsc.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 04:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/+bZ6/6gdCEtdJq/xtB+MgxD6XcWlf41pwuNrFTkFY=;
        b=JXmvUkXS6Mz/5tdEQ6eVYd6MTFHQ9/LADGbIWxZRKwwmFRXevzpc/DrKcqFq52Tn6C
         D0B3EV1ad6bZ62vM3d1PSgfhNpYDiT+lp21YhCfrZ1UTQc/YevGM8i1QIiwBV2wIAmdu
         jr5hWn2M5WlLz1oeOCPJATtcKJxchPE7qi7jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/+bZ6/6gdCEtdJq/xtB+MgxD6XcWlf41pwuNrFTkFY=;
        b=eulAFLJZVeOBIV8puiJtMMcTckAJmewwm05kZHYslisCfTvb6ai8LOELV4fLSX9flu
         PGlQiNUEjLYlVrahf9+StEZWUcUBNugYqeKcx08aI8qTfcLqRCi5yLHVizUII4JKGRMT
         E6nHxBR5gwAD2gFM5CMrk4JTuNROcv69v1yGStIvApG027UNsm2+N1BCPCIsHusUdvJz
         JYf4TnSzgrWVaKlrLcc9R27Dxb9Mt6ATg8XvT8KDpAyz3txF8XC+0TQoRgA6jDO38Au+
         ck2+0KXXQY6+FkvQUVp4ASxkZ3qsJh+d2xpQ3NNH4bUiba3g5izoWSG/2Sf+HXS3zA8X
         zLSQ==
X-Gm-Message-State: AJcUukdCQCJUZUHbfn2zHASOiti9qi3kY8oVZg0wv5w/Rp8Ps6iPNkSS
        tyt3DnPWGVIVEsPc9n6Agnd3F6QnWWOntgjzU6yGmw==
X-Google-Smtp-Source: ALg8bN4tQraiSEht+qB30uLbffXlsPwL4UOTjIMOSqEyrELw9nfD5lvQPEzCgBUnlG6P/qNtwRyPBbo138r/jXXjDi0=
X-Received: by 2002:a67:1b04:: with SMTP id b4mr14287891vsb.141.1548937461981;
 Thu, 31 Jan 2019 04:24:21 -0800 (PST)
MIME-Version: 1.0
References: <1548740978-28495-1-git-send-email-sumit.garg@linaro.org>
 <20190131084142.GA21196@jax.urgonet> <20190131120542.g7wtnhzuz5nuqbcc@gondor.apana.org.au>
In-Reply-To: <20190131120542.g7wtnhzuz5nuqbcc@gondor.apana.org.au>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 31 Jan 2019 17:54:10 +0530
Message-ID: <CAFA6WYOHX7JKGALhV6nKRH18MFpgMc2g+2J3qLO5PH=sYNhKDA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Introduce TEE bus driver framework
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Matt Mackall <mpm@selenic.com>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Bhupesh Sharma <bhsharma@redhat.com>, tee-dev@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 at 17:36, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, Jan 31, 2019 at 09:41:43AM +0100, Jens Wiklander wrote:
> >
> > I think this patch series is good now. It has received comments which
> > has been addressed and have also gathered a few R-B tags.
> >
> > All patches but "hwrng: add OP-TEE based rng driver" covers what I
> > normally send pull requests to arm-soc for.
> >
> > Matt, Herbert, are you fine with the patch
> > "hwrng: add OP-TEE based rng driver"?
> > If so, is it also OK if I take it via my tree which I then will include
> > in a pull request to arm-soc? An Acked-By tag would be nice to have.
>
> Sure you can add my ack-by:
>
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
>

Thanks Jens and Herbert for providing acceptance to this patch-set.

-Sumit

> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
