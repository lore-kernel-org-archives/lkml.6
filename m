Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2IpwFcr4HVsxNgAAmS7hNA
	; Mon, 11 Jun 2018 04:21:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CD45D607A4; Mon, 11 Jun 2018 04:21:32 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dfd5R1f2"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5C2EC602FC;
	Mon, 11 Jun 2018 04:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C2EC602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753919AbeFKEVa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 00:21:30 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34267 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753801AbeFKEV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 00:21:28 -0400
Received: by mail-pl0-f66.google.com with SMTP id g20-v6so11565771plq.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 21:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5zhAVZKwMMeKB/iTBpRxyK0hRyebu1oigRIY94Ajy24=;
        b=dfd5R1f2whh5pQX9sHuICSHOgF0zCFq3Cx2d3YuLj9m3PSCmub045kEaS2OsuuAMhe
         Bki/0Ivxl0weRVyTz9JKWlFHR5ZLmTlovE4pglkIm3aXZw8wPED7ru0Aez3LceX0cf0N
         Vj9uWF5R/3S3edneyOaGnnROQrlhkRQWPh0UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5zhAVZKwMMeKB/iTBpRxyK0hRyebu1oigRIY94Ajy24=;
        b=MHkZe8AtcXckVBr7iAwQN7iHfxzvfpyHtSl9aOR5IMUWwTeV9mOQHgfTmksGVZvWvW
         CjcyL1HTb19x53G1sfgkOOROdcz6ilHpfdPBQwleFtVcYcfKLVWJ2ocBsPJJQL7ItTb2
         0BJ00xUevPuP3+8+ngYDSffvtOeg+KmtXp4OqV7P0msOJkSvHiblqTdJ75+ZBsiAkZO4
         ippZuw1aYSjVfpQPm41GlQQP6t2IrhspaN+s3h/4V2TjKeQK7ne9FeJVVlJtcbUDQJd3
         wj5ZDFBVa1dQv7hAECe5V+7uKa6abORCXmQK6/zgJGVoGDSvmfhEAmTDEQ4NMhi942pT
         fpZQ==
X-Gm-Message-State: APt69E2tNjF+mqwmvvKRz98Bg1XQWnFkTcNXDOc0EKHrGlS4EdWJediH
        A0o9/++wX7yZ8L7oGz68TlB/Dw==
X-Google-Smtp-Source: ADUXVKK/xypmAN6/Uf4AZY2VprBs+vYpKPkVmL8USTQKguSJbyvLNl9AKb/wZM2ZRWYryBq8id8srg==
X-Received: by 2002:a17:902:a416:: with SMTP id p22-v6mr16708510plq.228.1528690887878;
        Sun, 10 Jun 2018 21:21:27 -0700 (PDT)
Received: from localhost ([106.201.98.91])
        by smtp.gmail.com with ESMTPSA id n22-v6sm26683280pgv.60.2018.06.10.21.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Jun 2018 21:21:27 -0700 (PDT)
Date: Mon, 11 Jun 2018 09:51:25 +0530
From: Vinod Koul <vinod.koul@linaro.org>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND v2] dmaengine: pxa: add a default requestor policy
Message-ID: <20180611042125.GD2452@vkoul-mobl>
References: <20180530201249.26972-1-robert.jarzmik@free.fr>
 <878t7oruya.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878t7oruya.fsf@belgarion.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-06-18, 14:43, Robert Jarzmik wrote:
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> 
> > As what former drcmr -1 value meant, add a this as a default to each
> > channel, ie. that by default no requestor line is used.
> >
> > This is specifically used for network drivers smc91x and smc911x, and
> > needed for their port to slave maps.
> >
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > ---
> > Since v1: changed -1 to U32_MAX
> Hi Vinod,
> 
> Could I have your ack on this so that I add this one to the dma slave map serie
> after the merge window is closed please ?

Sorry I was thinking it would go thru dmaengine tree, please do
indicate if that is not the case. Nevertheless

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
