Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FA5C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CF0208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="EYohu7OX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CF0208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeJVUuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:50:08 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41047 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbeJVUuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:50:08 -0400
Received: by mail-yb1-f196.google.com with SMTP id e16-v6so16064974ybk.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 05:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YiJ3RRSFZ8BTQJoDayD8Lx19t5Apc42hVAwMLkEcRY8=;
        b=EYohu7OX09Fj+a3XSl/eaEh5BFZg5ccRLlve9SAsgo1AJ5wJ88A75WtVozvoWVdfIW
         ExhLk6kBe5zxndgyswMoUx3UlHqS/fA5G+tGzsB8l4tcdvik1uPjodPT8fL3PKoTKaYO
         2HMbBw4yTFOsnsVGLYzx5SSZ1FXjYW3xhB2sEpC+80HrMFb7HRCaxY9YpnjonqAAUGgr
         uOI4iG7+DY9Y8tYVtVhSnZ80/Ldp7LM3Ca0G+y6fLubqFU9W277RG9KeuNd/4brDJW1q
         gxs2eUHTKqsRTHXJLGWM4ujBdfA3SIKO06UuoysnphtzKPSLl+aAN7qH6iM2CLqtPEOe
         /BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YiJ3RRSFZ8BTQJoDayD8Lx19t5Apc42hVAwMLkEcRY8=;
        b=a5xu3iC1sU2P1eE3afTDpZCcn8zXiOjOcrNNfHhpfShmT3mtqdooUIT/OIMF9QFa8d
         YVwtry4pB0ODljfKFkvDSBqfE9n/NAim9zHDm1rUGIfr8zvrRMybeA1e2fBYBQoGHmuO
         rXbNmPJmae4lLAweysVsv4kk3YSwJ2QGUTMy/QpW45qlULXMyiO+pEtXM7NPe2ySAZM4
         OAUAvCdn0uaX0WQzlWk2vlRda7rks56738pkCyiJ+/t0mQWgqoWNDKB9J93i473/KU49
         rOPuRD8NZf79Pfn5Hg8XHLk7ZnKlSqQf3Sh9ol227+spxhqS0yCc4Csljysfh7trTNwI
         /+MA==
X-Gm-Message-State: ABuFfoizXWXpi9nbEqvfz4a8cqPPghpRvKmgOQ/Aa9e5hcoyhG9UZdJb
        V/Iyuwn9Zn8HUKIiQNayLtFSgw==
X-Google-Smtp-Source: ACcGV638uX2sKuT3o1vzZIkrG19kF5juXHmPUTic5FHGKzvaAtIBpJneLDkqlwXVWDQDg0+trRWAzw==
X-Received: by 2002:a25:73c2:: with SMTP id o185-v6mr10558105ybc.254.1540211503701;
        Mon, 22 Oct 2018 05:31:43 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id 207-v6sm992536ywr.13.2018.10.22.05.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 05:31:43 -0700 (PDT)
Date:   Mon, 22 Oct 2018 08:31:42 -0400
From:   Sean Paul <sean@poorly.run>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] MAINTAINERS: Add entry for VKMS
Message-ID: <20181022123142.GE154175@art_vandelay>
References: <20181022012701.7a2rkmot2bj37xfb@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022012701.7a2rkmot2bj37xfb@smtp.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 10:27:01PM -0300, Rodrigo Siqueira wrote:
> Add maintainers and reviewers for VKMS driver
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

Acked-by: Sean Paul <sean@poorly.run>

> ---
> Changes in v2:
>   - Insert the section in alphabetical order
> 
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 39c3f6682ace..56572f0968ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4733,6 +4733,16 @@ S:	Odd Fixes
>  F:	drivers/gpu/drm/udl/
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  
> +DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
> +M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> +R:	Haneen Mohammed <hamohammed.sa@gmail.com>
> +R:	Daniel Vetter <daniel@ffwll.ch>
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +S:	Maintained
> +L:	dri-devel@lists.freedesktop.org
> +F:	drivers/gpu/drm/vkms/
> +F:	Documentation/gpu/vkms.rst
> +
>  DRM DRIVER FOR VMWARE VIRTUAL GPU
>  M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
>  M:	Sinclair Yeh <syeh@vmware.com>
> -- 
> 2.19.1
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
