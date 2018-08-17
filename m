Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E5BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5941218F9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TNHdzF4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5941218F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbeHRAne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 20:43:34 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42058 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbeHRAne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 20:43:34 -0400
Received: by mail-pl0-f67.google.com with SMTP id g23-v6so1300646plq.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 14:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K8DxOqKOMR195VGzDvMwTuEKXaF8lZ6PT7Pf09W7Kzk=;
        b=TNHdzF4+s0ZkwfSM61qq8ZcNaMSoySOEmzVGkbXwqJ3fCePSI4mktskjFuPMWRjUbq
         S/VvW2J47bsCHDzc1fn0A4zwOr4RjWU83XerdnoQFsfv2oN1OFJHeuv5S9H4sAyGfW3x
         QqUMZP1MqHn1wHFbaY0Oc5nQHuk9YxOR0y0xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K8DxOqKOMR195VGzDvMwTuEKXaF8lZ6PT7Pf09W7Kzk=;
        b=XsxcLD9kW8fEhj4TI2mTrUELgQeBfxp1y1L1QkMJh30uddefb19FO0uRCZPrrAeVrO
         98f43n+CIQaxrUo+lS7ZkOIcuHO3kvwpuI1hL29Zrk3YatggowvqpAWxDuX5jdxrUWqA
         VngKFsc68x9QYwaanCs3iqdnrLNHJAdM7bxJy8xZIdp71TxpDO7AtJF/QsRQ71oF0bPK
         7yS56Iu3H34iXRCU6ViItf5VA+rfC1EERFTsrrq1oUF5QQjGOtf3VapH5Sn0vcaxw08B
         0ZbZlNj0qnNHofGQBrk8ABsOPOflNOI/2A3C+jjn78EaiF/d78fghr4AycOuG5wSYbFs
         +lHg==
X-Gm-Message-State: AOUpUlFzv+SVjpB82rdpGuw3nGaKckbs3VWb7d4r+rc8TDvkopSkamCG
        ULmDVLtnxHNNaiHMK8VopcjFgw==
X-Google-Smtp-Source: AA+uWPwfPJEum5FAThKLEnFP7DXoez1hcofe0cYTZW7p4yjeqNBrE4vgtee3zoJYUTuu+3oFK0OcVA==
X-Received: by 2002:a17:902:1101:: with SMTP id d1-v6mr35074768pla.131.1534541912250;
        Fri, 17 Aug 2018 14:38:32 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k73-v6sm3271939pge.18.2018.08.17.14.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 14:38:31 -0700 (PDT)
Date:   Fri, 17 Aug 2018 14:36:01 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        collinsd@codeaurora.org, swboyd@chromium.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] regulator: core: If consumers don't call
 regulator_set_load() assume max
Message-ID: <20180817213601.GT30024@minitux>
References: <20180814170617.100087-1-dianders@chromium.org>
 <20180814170617.100087-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814170617.100087-2-dianders@chromium.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14 Aug 10:06 PDT 2018, Douglas Anderson wrote:

> Not all regulator consumers call regulator_set_load().  On some
> regulators (like on RPMh-regulator) this could be bad since the
> regulator framework will treat this as if consumer needs no load.
> It's much better to assume that a dumb client needs the maximum
> possible load so we get correctness first.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

FWIW, we've had this problem on other devices as well; where the eMMC
won't operate properly unless the supply operates in HPM. We've worked
around this by specifying regulator-system-load for said regulators.

Only drawback with that is that we use DT to work around missing
features in the code. But at least the improved implementation will be
backwards compatible with existing DT.

Regards,
Bjorn
