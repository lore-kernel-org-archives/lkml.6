Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89191C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 22:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415492082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 22:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Z4EbqP+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415492082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbeKZJR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 04:17:26 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35071 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeKZJR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 04:17:26 -0500
Received: by mail-io1-f67.google.com with SMTP id u19so12421892ioc.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 14:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vtXpmPeDeAdBMqSLjFlNYcEpEpQlR7ppYKSQmBAQoM=;
        b=Z4EbqP+setQE9d6yvhTjSyhO96KtfopJSDizdNfAQbUAeDBLYUUrBQVcCBqP+lhVuM
         Fv992Sr4+vQ2xOdR/R69zvmS2aPFUmhTFkEE/DGh/Q+B+xRSvd0JM081ZOmUrj+I4ehE
         dOE85vEpE4W2IGsWA76GWSJuoLOqAsDgRxANEhrXSsaA1yCq/Ap/vqDs3rTALlNXn4bJ
         8+Il8+6teeLnbmsIw1VfcKgLFAZ2/ohbGEHMkYi+mK70h/Uy+raxYkS0LIn0A1Dn4GqI
         /DDtxCG14siT8DU+67TJPDE5Vhj7PChbc+X+lNf4tLALvfivECu4f2wbwpIfdC7YHR4J
         WnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vtXpmPeDeAdBMqSLjFlNYcEpEpQlR7ppYKSQmBAQoM=;
        b=QVgT51ydQbwBd+aaeK+/RQyBUzEvPw2p264lPlfpjf1OuSK7wUkfsQ8HvEWVdzzEyY
         DU+IMG9jBT7q4TvjvqBIFpWdgYyyyocQF6/pogig0NHF2Wv4FVf0zX2fTpZutQf+5dWk
         iW1npmvIhVE5H0uZGK9YYu9H5V77EZVXyWloHVlkre8E9hf6f3TWH7L4aHmEni3FUSre
         X+YwuQacVUDHbmMjVOxcT6TSSfhvMKAvu34zfpjI8QIVpVO/6XVqh9NmKEvino4lZL3h
         897v4YPVEQ0VqccKkY5p8AeIclbZqVZu2CvQ50+QKt2+TZgRRpZ90FVov3tP9wfu7Qbw
         YzwQ==
X-Gm-Message-State: AA+aEWZS4Q2nYxS6QTBomSx50YGKCyd/XfaNKSsAIuzjZPHmyALuAlHQ
        3fWR+6Nsjz65SsmF3d8+zjMubIVwi02LRgZ6QPd00Q==
X-Google-Smtp-Source: AFSGD/VtooeISGv/uMX2JE0wrWYggNqZmkWbMNEuyJvwEmL4ovCPRkZayrDxSP26pHeyIBu8JejLTtOWMO39WoUUBS0=
X-Received: by 2002:a5e:c107:: with SMTP id v7mr12457464iol.155.1543184716537;
 Sun, 25 Nov 2018 14:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20181125211907.9895-1-otavio@ossystems.com.br> <20181125211907.9895-2-otavio@ossystems.com.br>
In-Reply-To: <20181125211907.9895-2-otavio@ossystems.com.br>
From:   Olof Johansson <olof@lixom.net>
Date:   Sun, 25 Nov 2018 14:25:04 -0800
Message-ID: <CAOesGMjR--5XC1pNMkPHR9BaPfgGfdC8JHAM3oqS3Xte3TQbGA@mail.gmail.com>
Subject: Re: [PATCH 02/13] ARM: multi_v7_defconfig: Add missing systemd options
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        fabio.berton@ossystems.com.br, yannick.fertre@st.com,
        Arnd Bergmann <arnd@arndb.de>, Eric Anholt <eric@anholt.net>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Stefan Agner <stefan@agner.ch>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>,
        Simon Horman <horms+renesas@verge.net.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 1:19 PM Otavio Salvador <otavio@ossystems.com.br> wrote:
>
> From: Fabio Berton <fabio.berton@ossystems.com.br>
>
> Signed-off-by: Fabio Berton <fabio.berton@ossystems.com.br>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

Hi Otavio,

Thanks for these patches. I don't have a reason to _not_ enable
systemd features, but would you mind providing a brief description of
what's not working without this change? Is it completely broken, or is
it just the random-UID featues that don't work, or something else?.
Useful for others to know what's expected to break if someone turns
them off, etc.

Also, I noticed you posted a series of 13 patches, which includes some
dts files for rv1108, some network driver changes and some of these
more generic defconfig changes. I would suggest that you split up your
patches into independent series where possible, especially when they
end up going to different subsystems. Providing suitable cover letters
for the series when you post them is also useful to help reviewers by
summarizing the series, including changes from last time it was
posted, etc. Please address it to the superset of patch receivers on
the series.

I'm asking for the cover letter because this time I was wondering if
there was a reason for the mix of patches so I went looking for it.
Maybe there is a need to group them together even though the
sub-series seem somewhat independent -- I can't tell from the way they
were posted.


Thanks!

-Olof
