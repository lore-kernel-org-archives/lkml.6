Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A848C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F612081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOvXzhrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F612081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbeKAGT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:19:29 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45004 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeKAGT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:19:29 -0400
Received: by mail-qk1-f193.google.com with SMTP id n12so11050911qkh.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lnoZe0licA3l5VchVC+4/SA4A7KvJ1BVcxteA867W/o=;
        b=hOvXzhrcIRE2HvxMftQeCRcbp4Rx2bPqqqviEfoweYi0yCKE5zb3IZXsrixFesW/kA
         GMEUVpyJ3bBD3mKCkcv2XyMODk/392nRjVZp3Unjj9Qz3IhtoJ04Uo8++Vhao0tPOOv5
         SkAYMVO0nqQBWw+2k0qMYyNeNOsEW5alHg2G7sjqQbumJ5XU9StU2iLfOWGKExDxzMle
         dg6oRHhMGABzJbxzU5HYScjPGYWb8drRoCby4fXOVfuIeIfFps5FfIWQmUeX5kkvVTAZ
         /hK/DTRo3g0ApMaQoAl9HRWg2J41UuP/u2SrwsPDPpCIr2vuVjKN+4HBkkvMHPGBHFG0
         qweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lnoZe0licA3l5VchVC+4/SA4A7KvJ1BVcxteA867W/o=;
        b=HTXIfoM4JYUzLyQ1pBdPjJT1U0jn401ehx+Gt3h+2INEktJi+dFFP0H/37ot4VxSV2
         0daEbqa666YD3cLnehZ0WKKu0f7gM5YtkUg7KNmMuzkEAAgbXlgDEDdjo6sqF9VaINy5
         Yj/hDBZr8ueXk9lS/XH00gTunO6wDYYh7CsRduktMRM45dwgstg97grmFr7zVPnCnOU0
         fLWKKyoBeWx4moNZcoNpDjBMpKNXs4VgFDuc5zMv5osFUce+INkDYjfJLoZS4sWV4BfD
         g/xFTa6iVIbjA4LmLQYP/DcfwBdbabeTnC13bdzhstkpyMefCQwY/FYwwn9tTTJIcqg4
         mveQ==
X-Gm-Message-State: AGRZ1gJkikhXHAG4N4rvpMtxjhzV8Vofz9dB+QJejNnpm7PzC8U0Pz1Z
        dqdukB9RAgDWmCBuQQQAy4U=
X-Google-Smtp-Source: AJdET5d+QsxPX3l7PMM5ICBpb3PnQS2ZSdVgGVfHDf8PEdeuL1E6Dk3fZwzn2uKD9RSJBLX5ko4tjQ==
X-Received: by 2002:a37:a315:: with SMTP id m21mr4043718qke.152.1541020780430;
        Wed, 31 Oct 2018 14:19:40 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d124-v6sm17701246qkf.85.2018.10.31.14.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 14:19:39 -0700 (PDT)
Date:   Wed, 31 Oct 2018 18:19:35 -0300
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] drm: Rename crtc_idr as object_idr to
 KMS cleanups
Message-ID: <20181031211935.p2pxr7fh26m5dc7v@smtp.gmail.com>
References: <20181031205737.cingeaqget7hkbs6@smtp.gmail.com>
 <alpine.DEB.2.21.1810312200520.2391@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810312200520.2391@hadrien>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31, Julia Lawall wrote:
> 
> 
> On Wed, 31 Oct 2018, Shayenne da Luz Moura wrote:
> 
> > Rename 'drm_mode_config.crtc_idr' as 'drm_mode_config.object_idr',
> > as proposed in the task description in TODO list for KMS cleanups.
> 
> Is object_idr a field that already exists?  If so, "Rename" is not the
> best choice of words.  It should be something like "use the object_idr
> field instead of the crtc_idr field" and then explain why.  "task
> description in TODO list for KMS cleanups" isn't very helpful to
> understand why the change should be made.
>
> julia

Hi Julia,

Thank you for your review!

This patch is to solve this TODO task:
 drm_mode_config.crtc_idr is misnamed, since it contains all KMS object. 
 Should be renamed to drm_mode_config.object_idr.

Do you think I need to use this description in my commit message?

Best,
Shayenne
