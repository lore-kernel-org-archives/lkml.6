Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BC2C65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9CA21473
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iRvrG1nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9CA21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbeLCJnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:43:08 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55965 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeLCJnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:43:07 -0500
Received: by mail-it1-f196.google.com with SMTP id o19so8193792itg.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 01:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FICbMrAKk/4QUbgjYyqeR5wy4ls3W8G0AZ8zJkO8kB0=;
        b=iRvrG1nwQOJtGIavT6yFNFhN9x6dm4SVhWzUfVQN+wQbxwtM6uLI30LYEMHlra6sTf
         l5Fx0i2LxjRShSnUasGCJ9r3fL+3Z8xAalktsgnehc0oT8RelefQN+6AfdyyQ1mdTshi
         X2+eWq53A8vX7tvsifHDnSAaehLX8CBy3t590=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FICbMrAKk/4QUbgjYyqeR5wy4ls3W8G0AZ8zJkO8kB0=;
        b=dyWCZRvtY7YLdhLpHL6iqfzK2PMDTi4mWzHce11NaKx9sZTPHst2BGzmzLsV5FN1VY
         HD/wozdeyCQCtmepw1N9VHEgAw1vEuqYb95gBKqbzmTwzHR/mr3N4G3KYWQreEhxYDWk
         u+/RmO23ZaH0QFgk8uSDvQ2Wz77cy7F2PFS9RB20f4Zi3mLWGj/CDQp0mWF+L6/RVKcQ
         RVuMxNxki09jHe1QGVVedBdpvDVeTvVUH0pRMsNS4ljNCT8tAKe108G5gde3ScF8wANI
         Wd4w7zNaChhIKhKBb9GdXy0OMFCn4ytyifnfEJvv59l+8JAabU4D/nbIii6P0ZqSaLqb
         jmHg==
X-Gm-Message-State: AA+aEWbTbD7p9lUtGBmbaF4H9OrB0PGMrMjezQxSKJvGZqRhiLReKML0
        /h0xzOY543HRATVpSlDrH3I0tDE1VjSdimEJUD6IjA==
X-Google-Smtp-Source: AFSGD/VIS48miG6cg4v4naJvPOyKOiD2zfO2ey2hcXviYpHoBb0otT1n3U2rT4aFo5dDGzt42NP9NJRzq+LA8ktHGM8=
X-Received: by 2002:a24:5411:: with SMTP id t17mr6868271ita.32.1543830170475;
 Mon, 03 Dec 2018 01:42:50 -0800 (PST)
MIME-Version: 1.0
References: <20181130075849.16941-1-wens@csie.org> <20181130075849.16941-3-wens@csie.org>
In-Reply-To: <20181130075849.16941-3-wens@csie.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 3 Dec 2018 15:12:39 +0530
Message-ID: <CAMty3ZBig1hJWgjF7LF52Z9vjJcqpNXLgdkru0S55fnrebT-ig@mail.gmail.com>
Subject: Re: [PATCH 2/6] media: sun6i: Add H3 compatible
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-media <linux-media@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 1:29 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> The CSI controller found on the H3 (and H5) is a reduced version of the
> one found on the A31. It only has 1 channel, instead of 4 channels for
> time-multiplexed BT.656. Since the H3 is a reduced version, it cannot
> "fallback" to a compatible that implements more features than it
> supports.
>
> Add a compatible string entry for the H3.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
