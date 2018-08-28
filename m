Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22E9C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E7120896
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHfDJdph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E7120896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeH1Lph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:45:37 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:34375 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeH1Lph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:45:37 -0400
Received: by mail-qt0-f169.google.com with SMTP id m13-v6so687838qth.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 00:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0Thc8fN8jp/Nz8iU+oF4R3DCkKHl45UoMRkB4ZTU7U=;
        b=gHfDJdphCOeP/SSz6wA+oE7otPut2/6w6MOZG411CRweTv/B/C7xvFJ2Rd957hIEIl
         8QnFXnP4RIdnSHk2dEW8q/xDet6TP02YCxlFFzCFmJyOh3hUcTGgNP5jVTogT4jwVRqL
         fgBvwJF1y/XHnbI5OKILjHV9fl7wdamPznVbzdFnvLgnv++WJwb+NRohlo19o5BoJSJf
         pL+EEBv4s4Ql1hQE+4Ij5NdB3GtcwdxRz/UnvOyUEOQYgJwtGA1+vH6w4CACHVH2fdSl
         K8N3NJqMYp29TwPF1hK3wwvpEuahQgN6Ri/6FeNGBgmmv9d7/IyrHLID9RbqOr2I4mGd
         Dl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0Thc8fN8jp/Nz8iU+oF4R3DCkKHl45UoMRkB4ZTU7U=;
        b=OIKp/mJKfQevU4YfNyluEXvhHeDFeEiBRUnsuWGfktkUmUQyzP+/WdW56129+b9P5O
         0gFoMASf4CCbUN+ddZNG1eBBsVDngUeYDqmymZtscxP0maXZgdqm6vQUuAUTz7DQcznt
         zeJqbvttRAD1eDnqjQPKTn/o/887DUNHZLkyUyw4gPyZUw1VeFQc710QeIj+YE3/8hFT
         Kv/hD5FxsmVwrcIXuSuCEpRfa7wViKyTVIwzi1GzW2IPDb1dESe1YwYbDNuzJOwpGlg4
         /inWpALqZLaXng0KjWqsf1AydbLQE2T2UUkiqWfr9VvVn1uxUDx+hdzNUWJH7N5qlMXA
         XTIw==
X-Gm-Message-State: APzg51ALMz5WPqeMh56Nw6tGVl3BEmBv1U5fZMa8ke47hMHGBYrb47Xu
        mLUe+VqyJuGUYSdMU/noAXMfrYK6lLpKBQyxFsk=
X-Google-Smtp-Source: ANB0VdbTmgSNvL/qofFMBTZuOw8imB5EkVKXMeBZP4xnm1hU7b0+Fhp8YH52vSPLOxSysVZUM1UJS5+v11+Dr8oXo1o=
X-Received: by 2002:a0c:e985:: with SMTP id z5-v6mr386989qvn.136.1535442890220;
 Tue, 28 Aug 2018 00:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-50-robh@kernel.org>
In-Reply-To: <20180828015252.28511-50-robh@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Aug 2018 10:54:39 +0300
Message-ID: <CAHp75VeBTdugxXeM9wj=x-JarLqRcmZzwDLav71RM66FcP-xjQ@mail.gmail.com>
Subject: Re: [PATCH] sound: Convert to using %pOFn instead of device_node.name
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 4:56 AM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

> +       if (snprintf(node_name, sizeof(node_name), "%pOFn", np) != 5)
>                 return 0;

> +       if (strncmp(np, "i2s-", 4))
>                 return 0;

Shouldn't be node_name here?



-- 
With Best Regards,
Andy Shevchenko
