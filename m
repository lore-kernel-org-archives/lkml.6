Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944A7C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EB42154C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57EB42154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbeIVT0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 15:26:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42460 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730087AbeIVT0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 15:26:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id l5so12826885edw.9;
        Sat, 22 Sep 2018 06:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XbgpVQXZz+keq3sdU5HgUFvpdQBZ3J115aJ3yBtFJpk=;
        b=qFQ1lEaZN0CSrlgDxFEyj6pRTXh62lW/Jm1p/D3wjMXX7rhlehTJ/GOtrRRFqdacX2
         KDocBHJoSkHCL63L/rnROtX1FYiz7hfBtmvKEGO5cQf7VX0AEGU2C6cU3+UYPyxVpuOx
         AuDcSxvGrW0z6VQZ1u3xcDWm6LbKPiSaRDNpgnu6vlCOrkcJgg1WJHyhlCKoVS0za4wf
         fz5FT9W1OzoGK/KLzgxhWj2+DKC3AauQ6IM+u4N+jm15B6eeQi80yPJ4GH7LlUxc+dP/
         iWQasp6cw2zb4un7YfjKJTioGfTNOEyj6n4OrpWdbWFOnXFDPU7Kyvwl7u3yEuvqOygZ
         qHVg==
X-Gm-Message-State: ABuFfohOebqgihjzsKl6stlNW1lsUky4fCglH5gMKat0zvSqpRcGTUfm
        Mfjm6z7K2khKrSMPAyp/5u8lpRA8tv4=
X-Google-Smtp-Source: ACcGV609K3heDCKPt1FRNtx2rsJm6DYkcf/sM0/qVT4TL96ZK4d0tdLx2wxgKiAGei1yvt6Ivr+FEA==
X-Received: by 2002:a50:a267:: with SMTP id 94-v6mr4030020edl.189.1537623146778;
        Sat, 22 Sep 2018 06:32:26 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id w8-v6sm443864edq.81.2018.09.22.06.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 06:32:25 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id f21-v6so5563441wmc.5;
        Sat, 22 Sep 2018 06:32:25 -0700 (PDT)
X-Received: by 2002:a7b:c18a:: with SMTP id y10-v6mr1705583wmi.87.1537623145265;
 Sat, 22 Sep 2018 06:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-10-jernej.skrabec@siol.net> <5b9f3f4d.1c69fb81.c776b.ee42@mx.google.com>
In-Reply-To: <5b9f3f4d.1c69fb81.c776b.ee42@mx.google.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 22 Sep 2018 21:32:13 +0800
X-Gmail-Original-Message-ID: <CAGb2v67yHpV042LW=iwBBNV7krauwCGX8CFh23nTNFsHkHXQqQ@mail.gmail.com>
Message-ID: <CAGb2v67yHpV042LW=iwBBNV7krauwCGX8CFh23nTNFsHkHXQqQ@mail.gmail.com>
Subject: Re: [PATCH 09/27] dt-bindings: display: sun4i-drm: Add H6 display
 engine compatibles
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        devicetree <devicetree@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 1:44 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sun,  2 Sep 2018 09:26:25 +0200, Jernej Skrabec wrote:
> > This commit adds compatibles used in H6 display pipeline, namely for
> > display engine, mixer and TV TCON.
> >
> > H6 display engine is somewhat similar to R40, just less TCONs and
> > mixer support more features.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> >  .../devicetree/bindings/display/sunxi/sun4i-drm.txt          | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
