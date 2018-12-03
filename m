Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9DCC65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307132145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="B2SBVgJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307132145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbeLCJmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:42:13 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39412 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeLCJmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:42:13 -0500
Received: by mail-io1-f67.google.com with SMTP id k7so9873744iob.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 01:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJhyObZHH+z3JMwCDzBJOiMf2OvwIyDMaaZPnyC+mJI=;
        b=B2SBVgJWw4wISQbZPf1NwK1npbia/yVTs4q7AxGtUmAaio0K0YONAzUEz8zGXpqfoe
         XKMLc0F7qfxvAtt/sligAW8AKU/Tk/DrdUQxhpKlYGu9eheddYKL2KF1hBjtP/f1xxK5
         jpX7L+GZcYm8MZxrrxFMqcigTWY82iLWB09pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJhyObZHH+z3JMwCDzBJOiMf2OvwIyDMaaZPnyC+mJI=;
        b=Y3dmd92Smx7c7j1er9XeiuiiRrGTPiIv7OXDOQftz7rbMgl+9QDcfsAzd2RiILnh2D
         0qg2RRAmPc/HlwT4bUFr5GWepL20lvwPtfa3Jg9a5Dm/pifQqXj2b6T7hKFcM2WYxwef
         hA0n61WIhnkK3Y4b47HyOTHLEmgPI7ggewIXT9GfEPwvKT3sfa/hSzfFjiqVaI25215E
         moy0hcdB3/CLGVacTVThbiWdTJYXBfBEhouHBBfQ8jKSaQa/biIKLxWC3A5JHuFygoHs
         lK7QkeWnYMBcXDNLv8bBnFGcASvNvI5uby45sE7+bGLafQ8gvnpd47NOqaqUuLwBKfYW
         KXtA==
X-Gm-Message-State: AA+aEWbg4SEmx5b+QJFSK5GxkBxHGd8aRjydY9mN1SPzp9/zOtEubtN4
        tx4SujTNfQ8xX7PYxfKsNK2grXNZwlnXsJwvL+cRuw==
X-Google-Smtp-Source: AFSGD/VnPpar5Bk1bJoyfUTzjkSCrRwrHD8hRdHsgcFBg6pQJgGlrT41KmOH3kSyIcpDWEG7eTCsml2+uXV0Y2Agr4g=
X-Received: by 2002:a6b:e50d:: with SMTP id y13mr12284674ioc.114.1543830116872;
 Mon, 03 Dec 2018 01:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20181130075849.16941-1-wens@csie.org> <20181130075849.16941-2-wens@csie.org>
In-Reply-To: <20181130075849.16941-2-wens@csie.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 3 Dec 2018 15:11:45 +0530
Message-ID: <CAMty3ZC-4hnVOx9AYhm7uUCUHF=n_NoH3xV-3SyUXWxb_X8TGg@mail.gmail.com>
Subject: Re: [PATCH 1/6] media: dt-bindings: media: sun6i: Separate H3
 compatible from A31
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
> Split out the H3 compatible as a separate entry, with no fallback.
>
> Fixes: b7eadaa3a02a ("media: dt-bindings: media: sun6i: Add A31 and H3
>                       compatibles")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

"media" text appear two times on commit head.

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
