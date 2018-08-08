Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31A0C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC0821AA9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bpiy6bTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC0821AA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbeHIA2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:28:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42496 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHIA2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:28:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so1790090pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 15:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8vcXyIP3sMNFO7jsKanYQJy1IVvnw38ITsh/GO0K6M0=;
        b=Bpiy6bTnocohdIHNKRVhi8EIj+wK6j4mPP4BKf37K1THNDIXYoqF0Hg/S9A8LwBMVb
         nLK7gISbJ2FOcN5qd+e6fYfT1wr55A8dSJ0HsWtvcDxzX/iizHemslGK5oj8Q5AgQn2P
         +qyv5z0//4AkK/sCFCGqYVPzuBmUiMLAFfJYBrV7HZjwex3fPuOlxv992HtwP89uYOo0
         pUeiDDMBMME4aw1GcZl7mtrDt7L+ONbTLrvNZ+1XvzldIsPHfw7bXx/3MWDeU1TA/du9
         rWkGhx9g5OVRty3ltT3+zHi+rScnBVU8G7wDrkeqA/KIuMZAUo1HT2Iievs5OMsjvwH+
         Y9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vcXyIP3sMNFO7jsKanYQJy1IVvnw38ITsh/GO0K6M0=;
        b=PlWLFMMkIk6fqzQKmv5SzdsjXQsTj0jEnhqbqlUSKB+k9S/UZ+kTiwg+shF/giikXO
         n5Q4RzcLqPjDfkfA/v+PHmXdTYGTagpFSfT9gRCvVqrmhYb+kl5g8HxFCXOPbmv7QE5Q
         KsKxMA4/1DucFTIh7GI4/fagU/IAV5vEUQTGTI9uXM8XhQycNMrd9NwYL2o4rwK4okQf
         3zH7fCwCTsw4jbKPT8nMqM6jtHxtjsK5xBF1ZEvgSfp4+vXY8Q5ZtzFHi4z1sn6jWWHD
         jodNJnWjDUHIWvm14N9vI++gQA/8NNCoP16RYOftmkDMjciSaDubBNRvJzaaMZn76kkd
         UHTA==
X-Gm-Message-State: AOUpUlEmGbF4p+HpW51URK+TsC2oH7igb08vwAE7eoaPu/Ux8PaAIE/C
        xpncVjqf9vDua6ibj4IEQulKOEVGgog3P3XRCFiKwQ==
X-Google-Smtp-Source: AA+uWPwmdtavpPLeoJ5XriuQUb8AOpy51ONG3fvYnGShxEqstO3lxRsXCXM5qj/rHcTNG0L+l0U94f9f2dC5/H02Tpc=
X-Received: by 2002:a63:d916:: with SMTP id r22-v6mr4046470pgg.381.1533766030896;
 Wed, 08 Aug 2018 15:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180615223749.149073-1-ndesaulniers@google.com>
In-Reply-To: <20180615223749.149073-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 8 Aug 2018 15:06:59 -0700
Message-ID: <CAKwvOd=aemtfORow2KCyNfSJuhEQGWtGPL7H+Pb0grj2PDXzDA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: simple: fix -Wliteral-conversion warning
To:     Thierry Reding <thierry.reding@gmail.com>, airlied@linux.ie
Cc:     Jagan Teki <jagannadh.teki@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bumping for review.
On Fri, Jun 15, 2018 at 3:38 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Fixes commit 8cfe83419cdb ("drm/panel: simple: Add
> support for KEO TX31D200VM0BAA")
>
> drivers/gpu/drm/panel/panel-simple.c:1250:27: warning: implicit conversion from
>       'double' to 'u32' (aka 'unsigned int') changes value from 33.5 to 33
>       [-Wliteral-conversion]
>         .vfront_porch = { 6, 21, 33.5 },
>                         ~        ^~~~
> drivers/gpu/drm/panel/panel-simple.c:1251:26: warning: implicit conversion from
>       'double' to 'u32' (aka 'unsigned int') changes value from 33.5 to 33
>       [-Wliteral-conversion]
>         .vback_porch = { 6, 21, 33.5 },
>                        ~        ^~~~
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Alternatively, should these be rounded up to 34?  I'm guessing the
> current behaviour (truncation) is correct since that's how the patch was
> operating.
>
>  drivers/gpu/drm/panel/panel-simple.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index cbf1ab404ee7..12bcbd1dd77b 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1247,8 +1247,8 @@ static const struct display_timing koe_tx31d200vm0baa_timing = {
>         .hback_porch = { 16, 36, 56 },
>         .hsync_len = { 8, 8, 8 },
>         .vactive = { 480, 480, 480 },
> -       .vfront_porch = { 6, 21, 33.5 },
> -       .vback_porch = { 6, 21, 33.5 },
> +       .vfront_porch = { 6, 21, 33 },
> +       .vback_porch = { 6, 21, 33 },
>         .vsync_len = { 8, 8, 8 },
>         .flags = DISPLAY_FLAGS_DE_HIGH,
>  };
> --
> 2.18.0.rc1.244.gcf134e6275-goog
>


-- 
Thanks,
~Nick Desaulniers
