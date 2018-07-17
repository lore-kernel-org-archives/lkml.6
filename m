Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7539ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AC120BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="HU1nSQ3I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gPWLhwZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56AC120BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeGQEdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:33:06 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:35181 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeGQEdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:33:05 -0400
Received: by mail-yb0-f195.google.com with SMTP id x15-v6so16313298ybm.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 21:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pyJAoi4wxTOveRQPgbVFHzZW88xscBOltlgZ7QXNrXc=;
        b=HU1nSQ3Ij3Ha1FUaC9Vv5NIe2FFX75SbFgysA2JmV9iUAO+2ljvOJrNkPuumN3Kpum
         z90hMP9ofgbla9XjQ4Jtmt35SM4Vysd4xK1/nnoZRVdS6hJtGMaj3M4YJMI8sS/BApQ6
         KMtRxt/M7ckp76Nl5W2VQJrP/7dY0+WdJFJ/IVDC/QmgwZJPXsdWPXWEvYHj+Xh+CjDX
         OKS70/XgVAJR2kDAxaegEq4ivlpq5ia2xeR9MTxRmSk+wPAtUP6zd2t2XHO1HdmSj0Zo
         +LZYKMpk50zps4h23IHCZjq+j1l5LTWRijLem6MMoln8p+EisrSC5LxfzHx/2ESEza+y
         L83A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pyJAoi4wxTOveRQPgbVFHzZW88xscBOltlgZ7QXNrXc=;
        b=gPWLhwZ+plp6JbrkxxKYfxociwL77yljdTkHFe0Z1B5boi1jwkSCViyAczKV9AIVbp
         iJ+30T2T0YG4FtX2ifcPSPpozrzREXVVLLH80t6L54SWUNtjkLSLXTNkSqcJoc7pUpYG
         9x9jZ0q2a8HeTKWbfNgKgVDFdSnVtAfP8oQfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pyJAoi4wxTOveRQPgbVFHzZW88xscBOltlgZ7QXNrXc=;
        b=Wu1kC52kTCtdQo+y0xew8R1pUXR+g9V8zNurL3ap8P1g0Su54qM7S3HdQtG7OEfatj
         /xXbqswFjeB7/xp1tROJrXs9/KuBT8GaBf89nzb/oT2wMqbzm8FKdtxEivQRFiNU+8Yi
         QZtDFwQ1Qsalmix3LpL3bPomWEsebrQQHxMBhuRHKjT602IecrFsz7NkEqeKAsq9DbYn
         pgaLJN1MEVqdR7Q0L2Qojjx0THLSv78PlFG+Ap3Hnfe25piWY8gcCBSIkJz3g1izK3cP
         Ko5LPt94LDdxS85GOLtq+dKvjXyXdeSuWNBsoqbBQbvJs4c6wCJoVr88gVEQUEZZBu3L
         rppA==
X-Gm-Message-State: AOUpUlHvzwK8LKLeBBcw3gAa91T0TK9oQmI9IvWLWkwFGKmNhCqAzp9d
        saciIAtCqRptL36sdYL2lP6hprKbet8q6NZpXCw9qA==
X-Google-Smtp-Source: AAOMgpfnei8FuZ97PVw3K+uosfGXHlucwhxTccdFpETBawLo6obnYN5Vy/B3FSbcp+DBEUdY5tP4WWZ9iBayaaCoPhw=
X-Received: by 2002:a25:15ca:: with SMTP id 193-v6mr611933ybv.484.1531800154267;
 Mon, 16 Jul 2018 21:02:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 21:02:33
 -0700 (PDT)
In-Reply-To: <20180620182723.GA24430@beast>
References: <20180620182723.GA24430@beast>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 16 Jul 2018 21:02:33 -0700
X-Google-Sender-Auth: zV4C-X9AfvzH-tS_Aejnn7mXxZU
Message-ID: <CAGXu5jL-M0jauKK=FCL=hDuwD-rNzHavgpaU9iQGLZ4ziTg4jQ@mail.gmail.com>
Subject: Re: [PATCH] drm/i2c: tda9950: Remove VLA usage
To:     David Airlie <airlied@linux.ie>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 11:27 AM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> sets the buffer to maximum size and adds a sanity check.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Friendly ping! Who's tree should this go through?

Thanks!

-Kees

> ---
>  drivers/gpu/drm/i2c/tda9950.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i2c/tda9950.c b/drivers/gpu/drm/i2c/tda9950.c
> index 3f7396caad48..28314433c351 100644
> --- a/drivers/gpu/drm/i2c/tda9950.c
> +++ b/drivers/gpu/drm/i2c/tda9950.c
> @@ -76,9 +76,12 @@ struct tda9950_priv {
>  static int tda9950_write_range(struct i2c_client *client, u8 addr, u8 *p, int cnt)
>  {
>         struct i2c_msg msg;
> -       u8 buf[cnt + 1];
> +       u8 buf[CEC_MAX_MSG_SIZE + 3];
>         int ret;
>
> +       if (WARN_ON(cnt > sizeof(buf)))
> +               return -EINVAL;
> +
>         buf[0] = addr;
>         memcpy(buf + 1, p, cnt);
>
> --
> 2.17.1
>
>
> --
> Kees Cook
> Pixel Security



-- 
Kees Cook
Pixel Security
