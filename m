Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA22DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA302082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA302082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeJZEXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:23:47 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41943 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeJZEXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:23:46 -0400
Received: by mail-oi1-f195.google.com with SMTP id i10-v6so4940047oik.8;
        Thu, 25 Oct 2018 12:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TZnCYIYXecA+M31SddVtNLY3eBwIyIKVXHve2FgLeRY=;
        b=nv6XNwMcpUCRQO5A43c4frt+W6GuESUatqYBPyIcSsbsn9cVT155qFTI5eA8NnAGlj
         pwHORxmQ2btMe0PRM3BxsPmCAqLxL5hluOFJADb8rKm80om5gJZLqRXKCyl8qkEMi2UO
         zo6KO4sKtF0FZux1bMKLzvFc4nmt5BIzheXYoLWzA/yFpVBpGbCi2upD9nYQakIjxSVt
         cOq/f+/5h1mmiF45Z6mkhYeYb6I9nsFmmcldfxtD6vtdX56Vnxxd4uOwn3wVqvgC1l8C
         w73OUFm3xeU+VFHk+NW29t4UBJ4rzoCVXnRjOsG0oS8ZZl0MphxqspElNLyliJ0dDd6S
         OJ5g==
X-Gm-Message-State: AGRZ1gK2NZA+1zFFIZdKZCOYnm8Hd+MZvZ+VBjiKuVZV/5kiK5FZzu+M
        76NIclws1uVnnpH7MOfHnQT3ieE=
X-Google-Smtp-Source: AJdET5cc4Qq99ISXeinh7oQpV+rxSdvmkSlr5FVvfBHzo6QmspVs7X/E4ZTa7m4NhvuRlprd8JaRYQ==
X-Received: by 2002:aca:bfc2:: with SMTP id p185-v6mr349304oif.285.1540496978595;
        Thu, 25 Oct 2018 12:49:38 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m63-v6sm2759234oia.30.2018.10.25.12.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 12:49:38 -0700 (PDT)
Date:   Thu, 25 Oct 2018 14:49:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jsanka@codeaurora.org, ryandcase@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 6/6] dt-bindings: drm/panel: simple: Innolux TV123WAM is
 actually P120ZDG-BF1
Message-ID: <20181025194937.GA11705@bogus>
References: <20181022204639.8558-1-dianders@chromium.org>
 <20181022204639.8558-6-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022204639.8558-6-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2018 13:46:39 -0700, Douglas Anderson wrote:
> As far as I can tell the bindings that were added in commit
> 9c04400f7ea6 ("dt-bindings: drm/panel: Document Innolux TV123WAM panel
> bindings") weren't actually for Innolux TV123WAM but were actually for
> Innolux P120ZDG-BF1.
> 
> As far as I can tell the Innolux TV123WAM isn't a real panel and but
> it's a mosh between the TI TV123WAM and the Innolux P120ZDG-BF1.
> Let's unmosh.
> 
> Here's my evidence:
> 
> * Searching for TV123WAM on the Internet turns up a TI panel.  While
>   it's possible that an Innolux panel has the same model number as the
>   TI Panel, it seems a little doubtful.  Looking up the datasheet from
>   the TI Panel shows that it's 1920 x 1280 and 259.2 mm x 172.8 mm.
> 
> * As far as I know, the patch adding the Innolux Panel was supposed to
>   be for the board that's sitting in front of me as I type this
>   (support for that board is not yet upstream).  On the back of that
>   panel I see Innolux P120ZDZ-EZ1 rev B1.
> 
> * Someone pointed me at a datasheet that's supposed to be for the
>   panel in front of me (sorry, I can't share the datasheet).  That
>   datasheet has the string "p120zdg-bf1"
> 
> * If I search for "P120ZDG-BF1" on the Internet I get hits for panels
>   that are 2160x1440.  They don't have datasheets, but the fact that
>   the resolution matches is a good sign.
> 
> While we doing the rename, also mention that no-hpd can be used with
> this panel.  See the previous patch in this series ("drm/panel:
> simple: Add "no-hpd" delay for Innolux TV123WAM").
> 
> Fixes: 9c04400f7ea6 ("dt-bindings: drm/panel: Document Innolux TV123WAM panel bindings")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Cc: Sandeep Panda <spanda@codeaurora.org>
> ---
> 
>  .../{innolux,tv123wam.txt => innolux,p120zdg-bf1.txt}     | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>  rename Documentation/devicetree/bindings/display/panel/{innolux,tv123wam.txt => innolux,p120zdg-bf1.txt} (70%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
