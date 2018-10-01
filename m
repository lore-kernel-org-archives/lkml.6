Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F01C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DD22145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pheBw9VH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DD22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbeJBCxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:53:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36691 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeJBCxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:53:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id f4-v6so59308edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 13:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7U9eDoBe/VI8seVqccayQju44ffoyBPXhZTfbsnUaCU=;
        b=pheBw9VHT87xxgAF45/klsR3jiIzRnNt/8FlRzAxCq+JssvIV3ShFDpZZYpfkcsqBZ
         cbfKpXj8YLbA1JG3MLDLYC82kQ58M2bKemj7HH6Qb0Nja4iDofC0n/RlLtQkaOvH/Yrv
         Soxi0RqCTXZAwfx+z5uEgJhyePssMuMuiIgpDbnRjW7N41Mx+9rAoFOhO2cdSbtGMR+k
         vryDogpana4UZsQomBjYsg2BpeGNWCnQVXl9BqMie9gPSLMTNdt37cwhRWiEtZn90lQW
         rPNe+tvv32PcBR4mFqk9gKaiysWL+T+5cez3vTt/EzeC5BOu32PxY6J6F0mQ5BKPy+RP
         9gOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7U9eDoBe/VI8seVqccayQju44ffoyBPXhZTfbsnUaCU=;
        b=O1GEWNVBxJQN45lpu3+843BD7u6aIeVxTkxLGvpqXqFfr4vbFVlfJigmDbgAoeodYq
         6OkaNjKQ397AbsdihDty5V7egBPrWiFgsSiNDROiTv0oTvPB9JJeYb15Db+a1kbIlKWR
         B+Fwg9Vi+q71dDwjMdwHi7Ei+VaETkwNspjc0bTwg+TQLTTy39SJXiX9mWIjBDIC+spm
         s5M69c2r9Q9zNnnqNbARt32h/q+uBN8jbCzd1jLSR1roOu31cXqaTEOqueDc2ZkaCILL
         MhaJ6tMQZ3rjAX1IZW5AYVLpVxzDVHG0x6W0VJF10HrH+ipj6Y9eyKSQaQjZ061PkzFp
         VXjA==
X-Gm-Message-State: ABuFfogKmXBPH0RohekoYzY4hn5dpuBpRutBNYBDCmY3NXd8Li9TVOvL
        qjfZiEy3APakGABl/IIcDIcobJyVz4BuDZi4xu0=
X-Google-Smtp-Source: ACcGV62KbUrEsKVHyoK7A0yR+XfHqIM4C8c92DTMxPYDQAMys7xH+hg8BLwJoqX5AG2CfTMgLSSDuPxLzuBIEO9x3VU=
X-Received: by 2002:a17:906:2412:: with SMTP id z18-v6mr4045254eja.164.1538424850923;
 Mon, 01 Oct 2018 13:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180904202747.14968-1-peter@lekensteyn.nl>
In-Reply-To: <20180904202747.14968-1-peter@lekensteyn.nl>
From:   Fubo Chen <fubo.chen@gmail.com>
Date:   Mon, 1 Oct 2018 13:13:59 -0700
Message-ID: <CAJAFBLBhAjEtoCegy7QzG65PoxM-DZA2xki9SwfrZ6af=0fvUQ@mail.gmail.com>
Subject: Re: [PATCH] qxl: fix null-pointer crash during suspend
To:     peter@lekensteyn.nl
Cc:     airlied@redhat.com, kraxel@redhat.com,
        alan.christopher.jenkins@gmail.com,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 2:10 PM Peter Wu <peter@lekensteyn.nl> wrote:
>
> "crtc->helper_private" is not initialized by the QXL driver and thus the
> "crtc_funcs->disable" call would crash (resulting in suspend failure).
> Fix this by converting the suspend/resume functions to use the
> drm_mode_config_helper_* helpers.
>
> Tested system sleep with QEMU 3.0 using "echo mem > /sys/power/state".
> During suspend the following message is visible from QEMU:
>
>     spice/server/display-channel.c:2425:display_channel_validate_surface: canvas address is 0x7fd05da68308 for 0 (and is NULL)
>     spice/server/display-channel.c:2426:display_channel_validate_surface: failed on 0
>
> This seems to be triggered by QXL_IO_NOTIFY_CMD after
> QXL_IO_DESTROY_PRIMARY_ASYNC, but aside from the warning things still
> seem to work (tested with both the GTK and -spice options).
>
> Signed-off-by: Peter Wu <peter@lekensteyn.nl>

Is this a new issue or something that was introduced a long time ago?
In the latter case, please consider adding a "Cc:
<stable@vger.kernel.org>" tag to this patch.

Thanks,

Fubo.
