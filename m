Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09206C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2892084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="K+grE9Ms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2892084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbeGSULX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 16:11:23 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:43798 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732029AbeGSULX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 16:11:23 -0400
Received: by mail-io0-f177.google.com with SMTP id y10-v6so8024344ioa.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Q9GODC0daVzGD/O4C7veKyR9Ur4HjgGTd4dW0a4G5r8=;
        b=K+grE9MsDqRMUCHM2oC3lei0Xp7rPkCye1QOurKwNHTYiXNwWsBxWobLOjb/Mm2x3h
         TtBSGdN5khY8nISIVuHa6YV4C4KadVvX09/Yj/z5uhz5pLKyned8eiGnEKb3AfKxgc+J
         ZU/5CrhnRURGYqM3Q9X5o7FeJYvLxESmYbrEuINyPwoscBRSmffAHO0ay/l4lYPNXykB
         gw1AcFSLEmOHGuuCH7ky1J6BAAszqauH917zcfZ77cXT3pEPWSGXv2qWfgTzIMkEQzrt
         9jRCvnJdh3mL99bRZmc6t8l0MFVnz4awb6XwdWOcmuM2V7b5k6v0YcZ05v+djdWrjM2m
         +PDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Q9GODC0daVzGD/O4C7veKyR9Ur4HjgGTd4dW0a4G5r8=;
        b=BghO4Jyfoqp8i3M9MfGcEpSeb6J80whARGBlD51adVnoGTgxBXNJzWwK0LG2tOvlSE
         F8KU+weInNr67D1v+Et40sqtVQp/w4dQwsAUDrMtl7fjWpwFHLbXgSBI4mR6ITHj5wF+
         5pr6Bf9TMCctyklPaLMnlinGAX9KnRy5ZEw03mGAucWwiE7hkqOK/OWfLaRvXaz3KUoJ
         vVdYBckBC8ef+YtgcFCBY2JOacxi/ywoOEH1GUVVvMihzFvJHgr0zCLrM9QC+E91mi1U
         /A+U5zCoM0R75HGBGhXCzvPybhH7bhPeHEQCeBNl1+smn1OVKM8xsi4k1QC5VoJFlo/N
         UyZg==
X-Gm-Message-State: AOUpUlF7zs+pCRWbp8FH14KZcgCZaQmx7s/d5oaXcrtxMNuop/kwsvX4
        W4j9Vd9Dus7ZcOhTwU7XrnxtgQ==
X-Google-Smtp-Source: AA+uWPzgxAamgL9TcYIxLVnrS681Yl4nqRidyx0cvLv7WZZCtEOkwG0WHzfJ5/A0J2mckmZHVFWYMA==
X-Received: by 2002:a6b:1d4b:: with SMTP id d72-v6mr8780632iod.190.1532028409596;
        Thu, 19 Jul 2018 12:26:49 -0700 (PDT)
Received: from localhost ([2604:2d80:4413:8125:59cb:8e52:e49b:158f])
        by smtp.googlemail.com with ESMTPSA id r13-v6sm2595759ioc.71.2018.07.19.12.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 12:26:48 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     arm@kernel.org, Olof Johansson <olof@lixom.net>
Cc:     Carlo Caione <carlo@caione.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Signed-off-by missing for commits in the amlogic tree
Organization: BayLibre
References: <20180716080014.75c9016b@canb.auug.org.au>
Date:   Thu, 19 Jul 2018 14:26:47 -0500
In-Reply-To: <20180716080014.75c9016b@canb.auug.org.au> (Stephen Rothwell's
        message of "Mon, 16 Jul 2018 08:00:14 +1000")
Message-ID: <7h4lgvm3go.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Commits
>
>   3f1ad8c53b29 ("ARM64: dts: meson: enable the saradc node in meson-gx-p23x-q20x.dtsi")
>   4dabd157d48e ("ARM64: dts: meson-gx-p23x-q20x: move the wifi node to each board's .dts")
>
> are missing a Signed-off-by from their committer.

Oops.  I missed these.

Olof, these were just merged by you in my PR[1].  How do you want me to
handle this?

I could respin the PR, or just send another with them reverted then
re-applied with signoff?

Or, since these branches don't need to be static (yet), I suppose you
could just edit the commits and add my signoff.  

I'm OK with any of the above, let me know your preferene.

Kevin

[1] https://marc.info/?l=linux-arm-kernel&m=153184268320170
