Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A047C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55549217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GVMoq9vT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfBRS6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:58:42 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53326 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbfBRS6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:58:42 -0500
Received: by mail-it1-f195.google.com with SMTP id x131so387460itc.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 10:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lz107P4BMhmp2Ybd/5l12BPSYujlnGszI7ylzRy5yys=;
        b=GVMoq9vTM3n1FucY1lTCr+BkbnEVDi2EphLCWpkAqQFbyFQNIs5vE+ucVJAH14s6Q5
         WHjErg07+WmhwRKwpHZuKxqoBBHEDQlC1XtDr2pyBy2o6ROCHDojSiz8VoooMpldo5rP
         o69FCSzZJbb6hh2eFJGR9hAbk4nNbGQ1MD26o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lz107P4BMhmp2Ybd/5l12BPSYujlnGszI7ylzRy5yys=;
        b=CPFZ5+zlQqqhtEWZgYRVNUFT5KEMT96OgLUHXPQ+ZlGS33vriux5Lq3GqLR060EjVG
         tZHuaaLvwmqdoZrw6PoU7MS4JAFx48wDq7gLdoBqe8Skil5QYwC8EK58Kq6TUC5ygOch
         /BNPHOkXQQNnolDIq2/8WoGfrGBH1FAO0hJjn2YYW2SjttCzuRlRYGmmFKdGnXB3iokj
         /WNl1DKak64xPClfDKFOfgOPpGRuud+0p1gA60b0jaEbk7r4+Z/3BP4n2DyAPPjiJQg9
         LcfzTLnn4hnSN/k3VDvUOYIZMU8Gi5Z1QlKkOM7cdLz6t6o8XkggL1XcuuafUch7dAJB
         C2zQ==
X-Gm-Message-State: AHQUAubjjA0DXR29sdDeJ91tlGKJoAVupyMLCpvsXIgQIG82Wbqzn34E
        UdQYXc9TI6XoVrbNl5STWmU8bxROG8nzj3eUv00keA==
X-Google-Smtp-Source: AHgI3IZRxYL36EPOEyiJzolsYbqOjW0LT1O8oWaFBQ3JT803jv2boX1Bl9X5jEkyaxEA1CswIorEcUsHTCRrTaLdsgQ=
X-Received: by 2002:a02:a992:: with SMTP id q18mr13523899jam.70.1550516321179;
 Mon, 18 Feb 2019 10:58:41 -0800 (PST)
MIME-Version: 1.0
References: <20190215170546.GA30950@embeddedor> <20190218085701.GR2665@phenom.ffwll.local>
 <bb073383-e4c2-f089-cdaa-a582ffc7fe79@embeddedor.com>
In-Reply-To: <bb073383-e4c2-f089-cdaa-a582ffc7fe79@embeddedor.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 18 Feb 2019 19:58:29 +0100
Message-ID: <CAKMK7uEpH0hMUjNYDunFwkBDKUM41cdMyVBSS0Z3rg6txMJMog@mail.gmail.com>
Subject: Re: [PATCH] drm/drm_vm: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 7:02 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hi Daniel,
>
> On 2/18/19 2:57 AM, Daniel Vetter wrote:
> > On Fri, Feb 15, 2019 at 11:05:46AM -0600, Gustavo A. R. Silva wrote:
> >> In preparation to enabling -Wimplicit-fallthrough, mark switch
> >> cases where we are expecting to fall through.
> >>
> >> Warning level 3 was used: -Wimplicit-fallthrough=3
> >>
> >> Notice that, in this particular case, the code comment is modified
> >> in accordance with what GCC is expecting to find.
> >>
> >> This patch is part of the ongoing efforts to enable
> >> -Wimplicit-fallthrough.
> >>
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >
> > Queued for 5.2, thanks for your patch.
> > -Daniel
> >
>
> I wonder if you could take this one too, or give me some feedback
> about it:
>
> https://patchwork.kernel.org/patch/10646783/
>
> I've pinged twice, but I haven't received any responses.

Dave? nouveau is kinda your thing, at least all the fallout :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
