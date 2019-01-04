Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67674C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA3E21872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n07XWpQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfADUvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:51:38 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40516 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfADUvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:51:37 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so3114361ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 12:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CfY0nxT6hD4OTvKX9Dpnp9MDVRoQ4GloA6OIWGmcbPs=;
        b=n07XWpQERdoNAU+5VPY5aozqt3Bkn0JKDHBYjtTBFcXs0dROrwLGZPKx2awUcoV44m
         GCOwBxxJww2uuGkjVC3gg2cEH2cK3Qz2E++loNB5YBnwcyd5KB/qbh8riDF8Sn2DjMVo
         g0wzZuG1xzf1sXL3jwuLPzLGskXTwCeof0szCqgyEo8b4WyRJB9AvoI42pK6+L0w1dOc
         fL9N+HIGDFtqprLGqeR2RjCH88Namsu2N3Eg4hIms0YOACvc3wbgp0B0WAgB26jJHxNj
         Yd6BdJ1wJN2Mo9+xyu15jpO3rKF7KUbyNfV49mBLpHQayWR1qwRbGU4HvhJSIYs8TyMU
         mVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CfY0nxT6hD4OTvKX9Dpnp9MDVRoQ4GloA6OIWGmcbPs=;
        b=YmhdxB2kklucDShjGjq730YkfothndVN6NzP00NhGs6NZgw864aE5qveD1G66fdyMK
         i2bdwYOfbFkTi8nQ6wQIVDjQ9JuKoAoC089f9n3y2fe07qlJ5C5LAUVvxJywSHOZSyRZ
         k/FpseUxQzTy7AECNjhMmFR2eOrZtPaofwxQUuiFTCKF8Db2X1Lzi0KaFKxx2Ihg4Wi3
         zGH8k+hjHvGuP+bFtjxUfs0YPIBuMvCx3gH6Vnhw5H1J8Wii/XMKtqBUoVBjk4KVeM8a
         LQtBarAaj4hAYian7brr5iYrBKAP/RQ4kOtFiiu49IFDKrXLDmf3T7n9N58wPCYWB5Wf
         Vr5Q==
X-Gm-Message-State: AJcUukeXH1p30f6NoFmRyOzEHUwwSOT5a/qnbXJmO6moEIL32tNaE9aM
        umLYU3H/GJBMXZ+mcy8IwVQKGuAme6nFJg==
X-Google-Smtp-Source: ALg8bN5vLIUMul33M6DPmaBLxqWQ1k30c2Huse4HkKIH9d0g7HkeeLIcsZRBWPk/aWTrg+m5dqlc7Q==
X-Received: by 2002:a05:660c:781:: with SMTP id h1mr1571590itk.52.1546635095562;
        Fri, 04 Jan 2019 12:51:35 -0800 (PST)
Received: from google.com ([2620:15c:183:200:4f03:26b9:1e31:4fda])
        by smtp.gmail.com with ESMTPSA id u3sm954674ita.18.2019.01.04.12.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 12:51:34 -0800 (PST)
Date:   Fri, 4 Jan 2019 13:51:32 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dylan Reid <dgreid@chromium.org>, Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Hsinyu Chao <hychao@chromium.org>
Subject: Re: [PATCH] ASoC: rt5677: use more of the volume range from DACs
Message-ID: <20190104205132.GA106594@google.com>
References: <20181220232555.90030-1-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220232555.90030-1-zwisler@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 04:25:55PM -0700, Ross Zwisler wrote:
> From: Dylan Reid <dgreid@chromium.org>
> 
> The DACs volume can go over 0, both according to the data sheet and
> real world testing.  The control can go up to +30dB.
> 
> This was tested by playing audio at full volume on a samus chromebook.
> 
> Signed-off-by: Dylan Reid <dgreid@chromium.org>
> Reviewed-by: Hsinyu Chao <hychao@chromium.org>
> Signed-off-by: Ross Zwisler <zwisler@google.com>

Ping on this patch.
