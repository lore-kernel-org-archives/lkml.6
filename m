Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B945EC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7153B2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CXJVC3Kv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7153B2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934536AbeFRUFB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:05:01 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:37882 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755364AbeFRUE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:04:59 -0400
Received: by mail-ua0-f194.google.com with SMTP id l14-v6so8107163uao.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZBmxdClNbO3D1ke6pc+oFVFlTduwTbrWQdZdiERJ6gQ=;
        b=CXJVC3Kvc/sVxa3zeU+PbDu3CeNc7bxRoZiMy1CdzoW4Lwi6HfUGJP9rd740t9h82J
         Q8QKZFcXP6ow4LzMwPCzC4Cj6PFJvo9wxunGlZhJTtNsQrmHDEtmhCYm5Rq66h/bG1cw
         NV6/gJLeY1BreUdR0F4UrraZijfjJrWIPxDXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZBmxdClNbO3D1ke6pc+oFVFlTduwTbrWQdZdiERJ6gQ=;
        b=kb/1Cb9+fdM/IM1lAOnSfHpZnCQOfaf33iZOa8VCT8bpHPxgVcTvp4iLhaQI5UGP7D
         sntsgicSKiWUUOSoOqpwgelpg+S39eJKznVUqkL3mEa6tGw6gKdA7CXCA2xNf/Krnwak
         k66Zdagt2FtWG7ydAeQlAb3WO2igoagpg2BUd4Ex3kd6i1o0eTDQCIHihcgcE/K4quED
         chdnjz16ellciMj56e5uR4RkyBF+xxCqWQzj0nwxreohW/k/45qQWQDquoPbOcI3dDdU
         mHc36v/lwinO1pXanmVPci4eUR33yg9sBLtf7PgEwtfab97eTTqNov2ngMzTNkPTBoA6
         +bvw==
X-Gm-Message-State: APt69E0PESWWk/iEmhNnszZ3oWjIZPrjSOfeESxXyDEUdpB0l5ffRJSW
        +BxlGG48M+VRm7qAP/MzlCIysBI0zRLt6ugANt//KA==
X-Google-Smtp-Source: ADUXVKIDbJbPdpLlAg4Qhbq97A5DRGvfHGLGGsMESsTNezoX//hbrVqRRrVoi5TqNIM1d0c6cnW2AOnZEJvQeJCDlXE=
X-Received: by 2002:a9f:358e:: with SMTP id t14-v6mr8556728uad.9.1529352298344;
 Mon, 18 Jun 2018 13:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180616220531.GB14131@decadent.org.uk>
In-Reply-To: <20180616220531.GB14131@decadent.org.uk>
From:   Julius Werner <jwerner@chromium.org>
Date:   Mon, 18 Jun 2018 13:04:44 -0700
Message-ID: <CAODwPW8aPTACtWcQAFCdAkjT3jHNCu1rKxCh4uYJfj_QnBrTdA@mail.gmail.com>
Subject: Re: [PATCH] firmware: Update Kconfig help text for Google firmware
To:     ben@decadent.org.uk
Cc:     Julius Werner <jwerner@chromium.org>,
        Thierry Escande <thierry.escande@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>, pm.debian@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 3:05 PM Ben Hutchings <ben@decadent.org.uk> wrote:
>
> The help text for GOOGLE_FIRMWARE states that it should only be
> enabled when building a kernel for Google's own servers.  However, it
> is now also a dependency for various Chromebook firmware drivers.
>
> Update the help text to reflect this double duty.  Add the qualifier
> "server" to the help text for GOOGLE_SMI, which doesn't appear to be
> useful on Chromebooks.
>
> Fixes: d384d6f43d1e ("firmware: google memconsole: Add coreboot support")
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  drivers/firmware/google/Kconfig | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
> index f16b381a569c..6fda2c5c69e4 100644
> --- a/drivers/firmware/google/Kconfig
> +++ b/drivers/firmware/google/Kconfig
> @@ -2,9 +2,8 @@ menuconfig GOOGLE_FIRMWARE
>         bool "Google Firmware Drivers"
>         default n
>         help
> -         These firmware drivers are used by Google's servers.  They are
> -         only useful if you are working directly on one of their
> -         proprietary servers.  If in doubt, say "N".
> +         These firmware drivers are used by Google servers and
> +         Chromebooks.  If in doubt, say "N".

nit: Technically, most of the stuff is useful on all coreboot devices,
not just Chromebooks. (Ideally we'd want to factor that out into a
separate drivers/firmware/coreboot, but it's a bit tricky because the
same memconsole frontend is used for both coreboot and a proprietary
Google server BIOS, so it's a little tricky to decide where everything
should go. Nobody had the time to go untangle it yet.)

>  if GOOGLE_FIRMWARE
>
> @@ -14,8 +13,8 @@ config GOOGLE_SMI
>         select EFI_VARS
>         help
>           Say Y here if you want to enable SMI callbacks for Google
> -         platforms.  This provides an interface for writing to and
> -         clearing the EFI event log and reading and writing NVRAM
> +         server platforms.  This provides an interface for writing to
> +         and clearing the EFI event log and reading and writing NVRAM
>           variables.

GSMI is also used by Chromebooks AFAIK. (I think it's sort of become a
general coreboot interface by now as well, although the name still
says Google.)
