Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C4EC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8114921872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8PqV+7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfBAXZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:25:51 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38311 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfBAXZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:25:50 -0500
Received: by mail-oi1-f195.google.com with SMTP id a77so7236842oii.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 15:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QG8B8uf0uS1WbVos3318Dh1x3QaECizZNfuSG9sTntU=;
        b=r8PqV+7nf4wddHcnVkVAWYdxTnK/XlpAjSC+ZS0kLXibVietD36ALhtfmBiPm6Yhrb
         B3zJzsKKV1qDDv/fAP6pvBfpM73OOHZ/1qo61RG7I7i8f4yaoH8+A/O9K/CG05Ha1Eqo
         y/AGuZ864flmlHm79VO1b+LNtW7VyVVmFjXiJkOiitIk9jI3zLUIe9CrU4b65mXjiVIo
         B6YcZd9BNiHZbNbf0wwgYwRYp4nuPPWlv6kdhc2LN6KSIn/vEZ8zinvl35KMOUAgQphB
         I+OaKeNvxNyV8fjApIDsj4oOgyF+pSbGofNnsHW3EvhoYjE3yWG/HDFzX0lNSENxlvnQ
         NeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QG8B8uf0uS1WbVos3318Dh1x3QaECizZNfuSG9sTntU=;
        b=BJH+VlA/uom66wlbSLOYpgbY5PWIFgf0saTkAyLpDqPIELCJNbAAgtaczc2w26+iYM
         VeLNS3rcrHBJVbwZBkzyPtuS3NwotzKW6QxPI8/L3hlm4cYK2ig4e9ILnhCVa1rr4Fq7
         BeK27nAjnickl5sLbvNCxq0JQfbWg3K98QTiVuXiUzywgGrFMFwYfkJErOrl1UNnp9RU
         bNm5J6qzFkCQZR6eW4gJ1cXnJyf34Xu9pFCY8wzdE9gR3mgIR4bGWxlrzWlt53iWKjCE
         fmLje9fDlxQ3lLLifyaNVWroRuAwVcDKuZBrQa0GRNEw4gE8bx4bogyTJisTTj9FLBrs
         HRXw==
X-Gm-Message-State: AJcUukfXOzDanYOY3vQYGrPXcgko3wU9xA5dwTfgQhG7bvbOQSc2l96g
        yqg8ia7ZiIwAv6Kez6rw+DrVH3CI981y77l7AMY=
X-Google-Smtp-Source: AHgI3Ia7ppvi3da2IOeN6drAr0p1y9uDvam+AdkFRvpnqbSa4Yj9sXX95bH0/ANk9p1Grbw9gqSblHuj8Ta6Y/OnKeU=
X-Received: by 2002:aca:3fc6:: with SMTP id m189mr20353644oia.142.1549063549802;
 Fri, 01 Feb 2019 15:25:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548856186.git.shayenneluzmoura@gmail.com>
In-Reply-To: <cover.1548856186.git.shayenneluzmoura@gmail.com>
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
Date:   Fri, 1 Feb 2019 21:25:38 -0200
Message-ID: <CAKkTe8GsZkBhLLE=Z-JaCpErhi5VvcadTmsw3Wh25Kg5U+VbCA@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/vkms: Bugfix for igt-tests
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Vetter and I were discussing about this solution. We figured out tha=
t
after these patches, tests were passing but when the computer has a heavy
background workload, tests fail.

I tried a new solution. Instead of change the vblank_time variable, make th=
e
`get_vblank_timestamp` return false when is not happening a vblank_irq.

It worked in the same way of our last attempt.

The reason for this change is that, when the timestamp is not accurate,
drm_vblank deals with this correcting timestamp when `get_vblank_timestamp`
returns false. However, this requirement is important when real hardware ha=
s an
error, and could not return the accurate vblank. Now, we need to know if ou=
r
`vkms_get_vblank_timestamp` should return false and when.

Em qua, 30 de jan de 2019 =C3=A0s 14:05, Shayenne Moura
<shayenneluzmoura@gmail.com> escreveu:
>
> This patchset contains patches to fix the extra frame bug on kms_flip
> igt-test. First patch solves the extra vblank frame that breaks many
> tests on kms_flip and second patch solves the race condition caused
> by the solution added in the first one.
>
> Shayenne Moura (2):
>   drm/vkms: Bugfix extra vblank frame
>   drm/vkms: Bugfix racing hrtimer vblank handle
>
>  drivers/gpu/drm/vkms/vkms_crtc.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>
> --
> 2.17.1
>
