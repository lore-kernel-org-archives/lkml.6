Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C547DC65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C38520838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544172331;
	bh=WoS5iVPFqPBkM/aI8SGjRvloj0ihgY/PbNSTH9+PXm0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SuTPulq7/gBR1PeVmOe7cz8lvwQHkhEeQGwoX341EjtYlbMWWhYWiYnyoO01ubsGH
	 rT2nPO2ys2LVtoXgyh8wFzogB86XpwkCKlyH0Hsk8xo/x4aQ7qwAvUSFPnSlzWFlN1
	 nPp1FZH6xHfcZ80SUrKMunFviVHzC1dG5kCmuZs4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C38520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeLGIpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbeLGIpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:45:30 -0500
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EC7320989;
        Fri,  7 Dec 2018 08:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544172329;
        bh=WoS5iVPFqPBkM/aI8SGjRvloj0ihgY/PbNSTH9+PXm0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rp+Lu2V3sboswK+BwqU+YBw8SVL3RwRL3S9ngdMUpKsq4a1HUdmfU5gimUsLkCOjD
         Hki9WR5Lss5dqEKT83WX+VrWCUiQYg5MhE8mBic03z2L7hYZflMJb3sqT9cw4OixsD
         RxgSbPUB4BWRguarTq/TsE3dyiTMHZPCGdGRH4pA=
Received: by mail-lj1-f172.google.com with SMTP id k15-v6so2838223ljc.8;
        Fri, 07 Dec 2018 00:45:29 -0800 (PST)
X-Gm-Message-State: AA+aEWagpe2N+qBtFKJnZDjoV+Nb97bYuMF3p5GmMKftlHlpXbyUlsCZ
        Iz6+cA339X58IqC315bJSobjGmkdNz4Hkq/nn7w=
X-Google-Smtp-Source: AFSGD/W+6F1JlT6vfn6BhSG9L3x2X7KKkKPY6dxVZZ3/5MBXZhgUkMJ0iIdgv2iH4UM0KgXqE9Ax50iaJubsocaz+NQ=
X-Received: by 2002:a2e:9cd2:: with SMTP id g18-v6mr829636ljj.161.1544172327332;
 Fri, 07 Dec 2018 00:45:27 -0800 (PST)
MIME-Version: 1.0
References: <20181206215858.3880-1-sboyd@kernel.org> <20181206215858.3880-8-sboyd@kernel.org>
In-Reply-To: <20181206215858.3880-8-sboyd@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 7 Dec 2018 09:45:15 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcmgvgu8F32ETtVBfB47H0UJ4fM3=6S0t=XYQF4QohJWA@mail.gmail.com>
Message-ID: <CAJKOXPcmgvgu8F32ETtVBfB47H0UJ4fM3=6S0t=XYQF4QohJWA@mail.gmail.com>
Subject: Re: [PATCH 7/8] clk: samsung: s3c2410: Remove usage of CLK_IS_BASIC
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, kgene@kernel.org, s.nawrocki@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 at 22:59, Stephen Boyd <sboyd@kernel.org> wrote:
>
> This flag doesn't look to be used by any code, just set in the clk init
> structure and then never tested again. Remove it from this drivers as it
> doesn't provide any benefit.
>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/samsung/clk-s3c2410-dclk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
