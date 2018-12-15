Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686EDC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36981206A2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLC0az6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbeLOIaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:30:55 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39626 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbeLOIay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 03:30:54 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so13121940itl.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 00:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KA14MOiCNouwDXt9jLdrsV1HBjN2GhYFwwWE8kymLgM=;
        b=gLC0az6oB9W/byxNYbICQALno4r+vzIkejR9vjUN1DxMOVVb4JeKraX90BBlum+1hR
         EM2E12a07lOb/9hsFMaKtDLLq5eLOtFdf6Fz/lIAsXPCaZrieVb75rrfleLzsjjlYmh5
         C+79ofIaGM/YB/dWJdGtsS+AN5Q7yzwddd+4HMks/XupZDQWGjfFAndAZEekkZv9KoYF
         Ub/6R/YSIwpUw6LDiBWa8ATvcAZBvFHW/lxpQGjlkV0yHFNIj0R6axng1LNpEGEeaMWd
         V79/1JPdHNdWadogSWS7/iF29a0hh0ZmZpGGPfmfVyopJHIdsmgBibW/i0T8i1LPSXOS
         UOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KA14MOiCNouwDXt9jLdrsV1HBjN2GhYFwwWE8kymLgM=;
        b=lt0Q+ZIIbs/MT+W6M1cbtR86xN7cwBnv0t9CIZG2PhzfJ1R9/uooSHVWs2+PzwRDgL
         k43ma3rIlayElR8uPhraCfKot8bVbBZ1LPTuMTAaBdPrG44fP7V5ccmbglwbBw8/FbZq
         vE+jm1fDQeBL9bFBRX+VmUgUdQrW+zDiduyQtNlr0Z5VM+BJy1WEg/l6kZsf+EewRvji
         Y7LdAI2prx4Z0Bi/sBgjk/JhYJciRHdVbu+EsdOZe2dj04UpGpGBxB2CmypFD3EBJ2yX
         hZyBSj2wplmOO7Ze126x0dT/9tiZ8d8rOTy2vg21imNowkhDN8KPFRNsEKQAPJGMOxk0
         IH+Q==
X-Gm-Message-State: AA+aEWb5h/E4qO/sl4bS9rWb/Pzqk76VWfDZhAYtmTS/KMg2ewXnE5n9
        /QR2fUbC7VhUmu+vJeXB4sDV3HuMEU4twtIUpls=
X-Google-Smtp-Source: AFSGD/ULdlGye9Vn9Tka35JgwuYx/sDSjCgPhQ7NWm1UxSlElh5Jm3joZN5/AHb+YOVc5zJ+qTXvK9KKfm/pHXydAFA=
X-Received: by 2002:a24:648f:: with SMTP id t137mr5692951itc.95.1544862653900;
 Sat, 15 Dec 2018 00:30:53 -0800 (PST)
MIME-Version: 1.0
References: <20181101154153.23042-1-tiny.windzz@gmail.com> <CAEExFWuoVpKmaGKCUVcORXirBLKwA-z+sHuWVMY4Hc8ptpdPTQ@mail.gmail.com>
 <20181210173111.GC4497@dell>
In-Reply-To: <20181210173111.GC4497@dell>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sat, 15 Dec 2018 16:30:43 +0800
Message-ID: <CAEExFWug8Y=OeuGZdByya3dkbPn7=NqCo5CbJsGvxq_zSB0FWw@mail.gmail.com>
Subject: Re: [PATCH] mfd: fix small typo
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 1:31 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 11 Dec 2018, Frank Lee wrote:
>
> > ping.......
>
> Please don't do that.
>
> If you think your patch has been missed, then please send it again as
> a [RESEND].  In this case you will need to fix the $SUBJECT line too.
> To see what it should look like do the following:
>
>   `git log --oneline -- drivers/mfd`
>
> Once fixed, s/[PATCH]/[RESEND/ and resubmit it.
Thanks.The newer has been sent.
Yangtao
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
