Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77134C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3732455C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op2XlFEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3732455C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937457AbeF2Urf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:47:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42570 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932267AbeF2Ure (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:47:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id k20-v6so8273280ljk.9;
        Fri, 29 Jun 2018 13:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rdwyYOzdLbspHFBuENph95V8uA3aWgiXDzXshuhApas=;
        b=Op2XlFEaRhSgQOBMJLjXHure7ab7y0VIFXq66wHcknW2+RJOVvgpgN1W5bK3bI/Gl4
         6ooOMV9sQCyCFMgJxAMZyLEKd+QGimHxF7b/VKIDICOYvXXXAf3hcR4zAWxfCKcXgxGW
         kniKgV3Q4Gp0N5Ar6QEimxxLk7nPUWm8l/lzeGQyH9+eLm2osMKUa66rHZxYhlN0xubt
         +Z6zpGP6ZlanpTUv3XM5yhGfyyQRBUgZJl7TOr8vR4JnjtiP3X6Bt2/Gf9p6dl3inKc2
         Fe/1T9XNposKZIav10qYlRGsuBzuAv/jahgVyKa4kcKGb6hg9fE/aVPrt9Zjj0YaqdtL
         N0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rdwyYOzdLbspHFBuENph95V8uA3aWgiXDzXshuhApas=;
        b=e1GvMvEVtm2Gu1ZdS3DIrS89CKIbrPxGMDty7TgpARN/BPPkwZ7KOsXPJtmmQEp1V/
         oRLKn9FE2GdOfaaiglT+1fEC83sgjI8OWvDpiSfmZYTZDVCk1Iwhvl2djiRykaAYppKu
         w/4wYtO9xxkSL0aXmD2NE9y3Aiv9j+D447fJVSsmDJKQBPPQfCAlertGHupJI/bwOxUC
         3jALzQDjIsuSYH49pf+wThsJ6bzLmrJTVYWnj3Bbb8253nGdr4MqyCCbhteUMl4X31os
         ufol6RcNBz9YtXUioCGohUQlAhez4Tw282KUXEaJkBCAfU0zDafFXMsYGlPEblX2tbNb
         NrDA==
X-Gm-Message-State: APt69E0hzA1VZoTMox4HUzbisHK3cd7DWVdOt2W3bl/K3EcxRXYNTZp8
        H5HTHACQItJU3wOH303OWlQQMbAPmhIIxyA+rkg=
X-Google-Smtp-Source: AAOMgpeukI8saRWUlrbbUfXPrVjLZfHUHywD2YubjNdLuq5pQ1n+VaYq+PHlcThCkOMNKx0zOXuQ3W37h66zb9BFW5A=
X-Received: by 2002:a2e:545a:: with SMTP id y26-v6mr10844476ljd.19.1530305252022;
 Fri, 29 Jun 2018 13:47:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41cf:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 13:47:31
 -0700 (PDT)
In-Reply-To: <20180629184818.GA37439@beast>
References: <20180629184818.GA37439@beast>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 29 Jun 2018 22:47:31 +0200
X-Google-Sender-Auth: d2ub-Yq162byCvHuk60VdgRvnjc
Message-ID: <CAK8P3a3Q9e59uqeZSLw6wqtNZYLe8LVgCO9RQGJB4D0F+3MLdg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/adreno: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 8:48 PM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> switches to using a kasprintf()ed buffer. Return paths are updated
> to free the allocation.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  7 +++++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 28 +++++++++++++++++--------
>  2 files changed, 24 insertions(+), 11 deletions(-)

This seems fine, though using a fixed-length string is probably just
as well here,
given that the 'fwname' variable is always set to the constant string
"a530_zap.mdt"
at the moment, which is not very long.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

       Arnd
