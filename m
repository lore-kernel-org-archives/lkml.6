Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3D4C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EDB2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BuXhoyZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfA2Gy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:54:56 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41273 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbfA2Gyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:54:55 -0500
Received: by mail-vs1-f66.google.com with SMTP id t17so11331152vsc.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 22:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uTFhP2hf07RCJjdACO2rmD+NffGPjRaInt4xFoxof60=;
        b=BuXhoyZK54ctH8Kyw4F1g1E2IoWLO2z1uNG22JGTW18vgIpiqSifUw4N1u4M2QpDee
         nt61ViNKqcNsH1FQK5hZQaLyam1W4sR91/E/iD/K3RB4AQm6zn6ZH00MjJXnb+MoorbS
         j3xbNAfSH1CLaF96nahrzQUAefXec4yPUwNFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uTFhP2hf07RCJjdACO2rmD+NffGPjRaInt4xFoxof60=;
        b=XBUzNWYYe8q9p8r4Pw1TVYqXxoY6u+kPdlZkB/O3hgTIVlDh+Nh8wCOLur0QW6CNcv
         LCH+R2vjqGfFD3i8I3waWm82evgBO0nwDbjMkYxndPxi+4GbqOqeL38pXlPd8Jsr3Bhr
         qo35YM1Ak94Uo7iU14KU5nG2V4ruPz6APHRFb06k/5l9b2cvO6qQr6neTtzmwm/RsJNF
         haApRrvMb4+W0F4AIZs1j3CRI+SnyFnie6azd1XykPRiMp6GgRf1fpwec/gRffyVixdf
         Va8071nDIk53ON9FHbmQk0cHTxNslyqCw/2Uq1x+Gg/J12WaoYYVXza40N8SQRHW78mF
         SEQA==
X-Gm-Message-State: AJcUukfaHZTE83j1+M7WKWIZI+1omuOkysl4Qy4f1EbKjxNo9XSNsNWY
        uMfW4HMzoWxSwLlXDurGMp5HvyfFPUTz6F4m44K6Hg==
X-Google-Smtp-Source: ALg8bN5IDLk1SStMbEQMuuSoQ0P8tBGGY7NuOFDhVkYavFfDfvl0yOwuYMv8qEcgoylcVkxdx0EEHDeCZF4FDhFlL9A=
X-Received: by 2002:a67:78d4:: with SMTP id t203mr10201364vsc.138.1548744893976;
 Mon, 28 Jan 2019 22:54:53 -0800 (PST)
MIME-Version: 1.0
References: <20181226070317.72022-1-cychiang@chromium.org> <20190107192402.GW9570@sirena.org.uk>
 <20190108095450.GA27286@dell> <20190108161238.GG6590@sirena.org.uk>
 <CAFv8NwK4=m1ffsyTruMPw534FVK6QBeaMKxxW461aS_yNYugNg@mail.gmail.com> <20190128065030.GA4678@dell>
In-Reply-To: <20190128065030.GA4678@dell>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Tue, 29 Jan 2019 14:54:26 +0800
Message-ID: <CAFv8NwJfovuFmRiOctGxoGLBR=pZCPSBUkPztMhVubYTugHppg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mfd: cros_ec: Add commands to control codec
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>,
        tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 2:50 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Mon, 28 Jan 2019, Cheng-yi Chiang wrote:
>
> > Hi Lee,
> >   Could you please give Mark a tag so he can merge ?
> > The later patch for cros_ec_codec driver is pending on it.
>
> Apologies for not getting back to you.
>
> I was waiting to see if my late PR would be merged.
>
> It was, which means the tag you were asking for is actually upstream.
>
> Any issues, let me know.

Hi Lee,
  Thanks for the reply. I see. Yes it was merged in upstream:
c1f3375be60c mfd: cros_ec: Add commands to control codec

Hi Mark,
  I am not sure what would be the best practice for you.
Would it work if you cherrypick this patch from upstream into your branch ?

Thanks!


>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
