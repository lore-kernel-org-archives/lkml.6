Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD135C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755F62081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="mIDbuzh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755F62081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbeKKDSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 22:18:53 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:47065 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeKKDSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 22:18:53 -0500
Received: by mail-io1-f67.google.com with SMTP id y22-v6so3487243ioj.13
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 09:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lIXvBXOlZQMyGtiKoQxO18AiSmChEBS7m0aX4KP3rXo=;
        b=mIDbuzh9nLGJmMo9QyRRzni35eAc1Q8XgPaw+o4N62aTOmNWfhMoOP2BfJzhbImSYo
         tnOCwoy2NrfoyWRbvZ9lh750M4TzI0CMY8HS8lP+mwcE6folFY9Of+1WGSNn45Vl4VWN
         db7wo8TSOcFRlitPu+jwe65voLEUgdksYllwzrjXwX4+B5PLpgeHva/1tmPgpVgK+ttU
         napMc192LlwMaKbeGsvuA8ihTfmt6SKr6zcwRkD4O4QjUxbg/LiNxb3zMjSTVLwHSiw1
         hWYNteNaRSgKgas6uF7mt0yZjRkYbtjTGVt+/V/y1NxcrAt9FrJPU9Enxc0GvNjB1lKF
         /7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIXvBXOlZQMyGtiKoQxO18AiSmChEBS7m0aX4KP3rXo=;
        b=e+KbZcWprSF3EojDNyUd60LqSJUwcd1IYGLHtR8brsnkttHYEduuCeY+TmAuDJ1ny5
         8FBt84Pv+4fzRBE8Elp8l57a8pzKS51gQkG8QsEOp1T7HfSMkenHn/rrBMpXgN9DXEho
         XIcTghTgAANqvHBIz5Jcig2Nef0vTk9/XCSuL1g/HmD0vvkUZQ0XYU95wmUYl9/+ikVn
         RoyFCYvxzrE2FnPtxUzpXUMxF98mEmVhRB1vRIGx4j/pY8xekXui9bgfUG/4iiLlbwiH
         zCjHifgxg7EGUrjEil1XcittBzjWNma50m43aHGQno+Qwyav6rydqoySBWkkYzxeNJrb
         k6Vg==
X-Gm-Message-State: AGRZ1gJSX22EMLftUxPfJfN/msTvKzm4mltZdOtGTLlmTO707ap8ErsR
        3vnSxklIFDX9QFVv57/R1f71rIFf2YrUolrA69K7WQ==
X-Google-Smtp-Source: AJdET5fuOipbhx2PcJACDChKMIaVf2Kr31EkkOnc68jhMjzBjhthmpJUSghVQ3qDy1Wz7aGzQxXyyMidXO2owK1pWbI=
X-Received: by 2002:a6b:1414:: with SMTP id 20mr515613iou.140.1541871187418;
 Sat, 10 Nov 2018 09:33:07 -0800 (PST)
MIME-Version: 1.0
References: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr> <03f41ca8-68c6-f075-cb1e-c7f630a3b128@free.fr>
 <20181108093617.GB8433@e107155-lin> <CAK8P3a1129B-u60sjHCvLuE8i6OCJRDSe-JFy3S-JJWFGbHCPQ@mail.gmail.com>
 <3f5ff18e-a264-981d-505f-69636fcf4355@free.fr> <CAK8P3a3z_BWHgjvWFBEHLvOdbcGnh6NZ4eT9OtSqLGFHPGbigg@mail.gmail.com>
In-Reply-To: <CAK8P3a3z_BWHgjvWFBEHLvOdbcGnh6NZ4eT9OtSqLGFHPGbigg@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Sat, 10 Nov 2018 09:32:55 -0800
Message-ID: <CAOesGMgdYDZw0t=q0CmiG6x1a0agQdShrZrWxJMRXXsM4B8d2w@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     marc.w.gonzalez@free.fr, Sudeep Holla <sudeep.holla@arm.com>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 8:05 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On 11/10/18, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> > On 10/11/2018 09:57, Arnd Bergmann wrote:
> >
> >> On Thu, Nov 8, 2018 at 10:36 AM Sudeep Holla <sudeep.holla@arm.com>
> >> wrote:
> >>>
> >>> On Wed, Nov 07, 2018 at 11:39:42PM +0100, Marc Gonzalez wrote:
> >>>> Commit a7314405d83c ("drop ARM_BIG_LITTLE_CPUFREQ support for ARM64")
> >>>> dropped ARM_BIG_LITTLE_CPUFREQ support for ARM64.
> >>>>
> >>>
> >>> Looks good,
> >>>
> >>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> >>>
> >>> But I left it intentionally to avoid churn assuming it will go away when
> >>> ARM SoC team runs savedefconfig and sync the defconfig.
> >>
> >> I would never do that,
> >
> > Isn't that what commit c432c0880596 did? :-p
>
> Olof did that one ;-)

Yeah, it was because of churn caused by things moving over many releases.

In the end, it's documenting what the kernel builds anyway. We don't
do it often, I think this was the first time in recent memory.


-Olof
