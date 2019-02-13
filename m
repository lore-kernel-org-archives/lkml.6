Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D800CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2073222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403840AbfBMOwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:52:39 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42823 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfBMOwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:52:39 -0500
Received: by mail-qt1-f194.google.com with SMTP id b8so2798204qtr.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 06:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9KSjIK52ErBRfHNEMox6sTC1sXaTyTQwnEhhuFMq8g=;
        b=N+n+y7CnQN0ipOhuBDB21B6a+RxzL575m8WCxXcaSJ9UJ0mDSvHdcw3ZJtjJZqLGr2
         AN8clDiQdBN/TyTMGcvGdZYFpnPtQMMZSDqD8r2E4iDsz3Fv+lf0vr6xTfDVEIzrl+0I
         7rr1F/pC7YaAqWXwYFLR9j2lm9kT+LIk+7AFiajy+VrmzSJzlPCGJmXG7EIDc3m0LRPS
         +hBEJvREGEmReqzF+VcAZYk6TGd3aAvquycRQm++amNiN0kVc3SpiwMuFwhy4yfOqTI2
         +usctiG4GZUD9CYrXCgal7jDJKc87K6Ndefzy0aRll1rwf5uJBV422HvF1n8xuTzKbfY
         snZg==
X-Gm-Message-State: AHQUAuYVIjhMB5i1mJReiPtwngjzmvhUhjQJ4sCQUe3UVf224OCHwQf1
        angldZ+3wM6noBZalrDnrCuhendA8W8NwMs2AOp6ow==
X-Google-Smtp-Source: AHgI3IYnzFi2wTloBnRpZY8ymIWUUUlevsvxmXjBYzP1x7OeAOvAThJDQ8eBENxNwCKsDXGHCsSJxNTNqQ27L7BrZ+c=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr692562qtl.343.1550069558029;
 Wed, 13 Feb 2019 06:52:38 -0800 (PST)
MIME-Version: 1.0
References: <20190213095613.31045-1-benjamin.gaignard@linaro.org>
In-Reply-To: <20190213095613.31045-1-benjamin.gaignard@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Feb 2019 15:52:21 +0100
Message-ID: <CAK8P3a0mbEqfzQhP0qX3kSnErBLws9ojkmbVQng9HhujFLCMvA@mail.gmail.com>
Subject: Re: [PATCH 0/2] ARM errata 814220
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:56 AM Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
>
> Implement ARM errata 814220 for Cortex A7.
>
> This patch has been wroten by Jason Liu years ago but never send upstream.
> I have tried to contact the author on multiple email addresses but I haven't
> found any valid one...
> I have keep Jason's sign-off and just rebase the patch on to v5-rc6.
>
> Benjamin Gaignard (2):
>   ARM: errata 814220-B-Cache maintenance by set/way operations can
>     execute out of order.
>   ARM: stm32: select ARM errata 814220
>
>  arch/arm/Kconfig            | 10 ++++++++++
>  arch/arm/mach-stm32/Kconfig |  1 +
>  arch/arm/mm/cache-v7.S      |  3 +++
>  3 files changed, 14 insertions(+)

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

It probably makes most sense to keep them as a series, either
through the soc tree or Russell's patch tracker, so feel free to add
it there, and have them both in the stm32 soc branch for arm-soc
if Russell prefers.

As we have a number of Cortex-A7 based platforms with all
kinds of revisions, I wonder if we should also select the workaround
for the others. I can probably figure out which SoC platforms
are based on Cortex-A7, but I have no idea about the revisions,
so that might mean we'd have to do it for all of them. According
to the latest TRM I found, only revisions r0p0 through r0p5
exist, and the erraturm text lists r0p2 through r0p5, which may
mean all products ever shipped in practice (the oldest public
TRM from 2012 already describe r0p3).




     Arnd
