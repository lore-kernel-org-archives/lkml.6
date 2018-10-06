Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC78ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306FA208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiwEkO1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306FA208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbeJGEXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 00:23:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43990 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeJGEXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 00:23:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id r8-v6so14548090ljc.10;
        Sat, 06 Oct 2018 14:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nyQA9OblBIWJcm5p8Zg/bhzRyBzuHUmKIgYWPhS+Yrc=;
        b=fiwEkO1x0p13PEkKnacBQQHvM42hO29bkp+UL4LeOqCjlbBsDjH8vSwEsRv1ShtQgz
         pw+Fj0TeepPbtyWk+qHGeLiwrLvkGwsJXr+E6ctfF9yWm40iHNGXxQHoGmon+QhYM4uB
         gC/ZAOSA91b/7X79bQnwbHVlfEJNkjj/ucsrYriAAAlYuFXBhwXaFJ9t+zDM7Q+ZVkep
         rzsQnEWt/yVxnGv3wyZaOKoKAsKUK3YOHRpb6bYh5k2BsezRBAO/xALu6FADO5X8xHnp
         bb9FF2F4jZ+TuO2pZmcSIXAG4osgHpH2mD4E0QwPt0oNr+lC96EP3ad0gzO9NoddQD9L
         0W7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nyQA9OblBIWJcm5p8Zg/bhzRyBzuHUmKIgYWPhS+Yrc=;
        b=pzWFhhzM2GbqjKGp1IV55EPDbscCFHRBR+4VNw84jgL6aeEn2qU5j3IWPVBbXv76Za
         Cj+kG6WqT3BAGEGGCs+mbmCFKDy1rYqjuTepbPnLtg57NsKSiaVTT8nOT/vM6lbQq2Ci
         4Fp5UvpCYJR3yd3PRkAT6sKoX/6iuBYz+NswHOeOzKDWAFZe9vJvBOTVR3J0JHUCvDv/
         bGtIWw6BI4MqGIAHeWq0yoWG5EVBdGtXMHn+pQgOdRXqB+yJX/08OCYYvwDqUTA/m2Cn
         grcIKziawksUDJ4HpuGCjYjKiUtNRzGevg39WpNCjXu5180ekNDJiHIXzvLHmJkYfQzp
         BY0A==
X-Gm-Message-State: ABuFfogXFw2Fxm5PcHwlAp+SHfcmf256UmeELgatDtPqtZDrYkMpsmI3
        hAz0tehuGtE9ZQIIkqQlAh8IcBxmhRLyt9iK+ms=
X-Google-Smtp-Source: ACcGV61MPXtCwL0Gi9p5CQxsE21DFRqWgtIxnA7Nm86/5cQEdTrsJ3nQQQJ8hycKv6O6m3PnUHW4xh5jG+WXsV0N0kA=
X-Received: by 2002:a2e:501c:: with SMTP id e28-v6mr10669835ljb.45.1538860697448;
 Sat, 06 Oct 2018 14:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180921142234.16882-1-kieran.bingham+renesas@ideasonboard.com> <20181005083313.2088252-1-arnd@arndb.de>
In-Reply-To: <20181005083313.2088252-1-arnd@arndb.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 6 Oct 2018 23:18:06 +0200
Message-ID: <CANiq72mHDxe9-+pFf+dDuYXRz5YeyRYi6RW65tyo9-ENNngsCw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix kernel/bounds.c 'W=1' warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-renesas-soc@vger.kernel.org,
        kieran.bingham+renesas@ideasonboard.com, stable@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 10:35 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Building any configuration with 'make W=1' produces a warning:
>
> kernel/bounds.c:16:6: warnign: no previous prototype for 'foo' [-Wmissing-prototypes]
>
> When also passing -Werror, this prevents us from building any
> other files. Nobody ever calls the function, but we can't make
> it 'static' either since we want the compiler output.
>
> Calling it 'main' instead however avoids the warning, because gcc
> does not insist on having a declaration for main.

I think marking the function as static __used should do the trick and
would be less confusing.

Cheers,
Miguel
