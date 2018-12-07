Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF59EC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B259020700
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="T+jWh0AD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B259020700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbeLGNS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:18:27 -0500
Received: from mail-it1-f172.google.com ([209.85.166.172]:39517 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbeLGNS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:18:27 -0500
Received: by mail-it1-f172.google.com with SMTP id a6so6945211itl.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 05:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zIW5gA4Qs/8vcbEr5quVuI1YUEm6sXC6uQrRdhNUXM4=;
        b=T+jWh0ADQtznHs/ucGjRkhqoXJLiUqgs3JLE98xvEkr6EBUV2HG17B+7Xljy73QzB8
         JWxFi3pqKG1INasPTiWZ3RexR3UqwK+nwxFD2ZdKRlGdanFUNFN2jVUGygeF+jq3Bbut
         sbwObDsjwi/NSHG2CiN7X/ihV+dHiQGzHCOKHiO+ifs1DoqUBlvk7ujW+3cdoiWSuGhd
         QGIsKkzVCq5BVusJ6vHtwjsHHbTqmvSjXURPcWoaheYnLcj+zqWSenT3XSXzLTRKSR9O
         jpbi6XlFFEFJCbzDEvmeMpx7LM1re9NdTuIqW8ekJxxUFidHMCmUPv2wwJTKS1KC7iKQ
         NO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zIW5gA4Qs/8vcbEr5quVuI1YUEm6sXC6uQrRdhNUXM4=;
        b=OxI614DueGIJX+dyvKCD2fdye+1qBvo4k+4bGRvRPU/9w2Y69Y6MEJ5hmkvulAsHhM
         UORBzSuLyEM2EtF68A01/XTxrqNoEU/1A62sKXhcWw9OmnhAc72cn58rTjXMZFmsaUwF
         y9TPcdk/aHbmhg6rjgMhU11b1teu71pVX1jI81N0ToTeU4v/pZSKYjYfypWCHjWd+Z8T
         qbrVHl9zVWNqgXfJMabT6+RTa0XjXUVbdGzVN3d3OwFbdc9gOiIg5Ex7F9o9fP8NezDv
         RJu9FHxh9jXWfSOuwEWyHS0hbdGie2csCBuxV7s0i11JRp1sJyHgODWn0WE7uEZoC9+T
         qSSw==
X-Gm-Message-State: AA+aEWZcUdkBn6keG6AeX+zruhWnaPuqhL2xt2449SzL7tEPWjMqbzWT
        9R1wcGBeh0exrmI091dnMEdPTsi1ow4jW4/OS3iDbw==
X-Google-Smtp-Source: AFSGD/XWNdpR4O0W1CEVTkX2ARZaKRNX+Jazm8GLU9FcfCgbSgvOhDWHv3IKf2gJh94VWep/JZPxCJxJ4WnHazfpfyE=
X-Received: by 2002:a02:98bb:: with SMTP id q56mr1711895jaj.24.1544188706505;
 Fri, 07 Dec 2018 05:18:26 -0800 (PST)
MIME-Version: 1.0
References: <20181206094550.18082-1-brgl@bgdev.pl> <20181206104421.a6njveg72dcguckp@katana>
In-Reply-To: <20181206104421.a6njveg72dcguckp@katana>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 7 Dec 2018 14:18:15 +0100
Message-ID: <CAMRc=MfRBgF9CSzGb=VMUGiCsFc1B_y=d5yMgPJ3xc0GyytATA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: i2c: use correct vendor prefix for atmel's
 at24 EEPROMs
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Rosin <peda@axentia.se>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 6 gru 2018 o 11:44 Wolfram Sang <wsa@the-dreams.de> napisa=C5=82(a):
>
> On Thu, Dec 06, 2018 at 10:45:50AM +0100, Bartosz Golaszewski wrote:
> > This is a follow-up to Thierry's patch which missed a few occurences.
> >
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>
> Since I dropped Thierry's original patch, I wonder if it is okay with
> you to simply squash these hunks into it?
>

Yes, feel free to squash those two with my Signed-off-by tag.

Bart
