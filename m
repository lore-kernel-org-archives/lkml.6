Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768C2ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02ABF208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9SpB93Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02ABF208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeGPEwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 00:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbeGPEwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 00:52:19 -0400
Received: from localhost (unknown [122.178.242.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 014AA2075C;
        Mon, 16 Jul 2018 04:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531715212;
        bh=MZ9yeJJKab2CMM5G1EgqI1i8GQaed6UEVMRZM6clYF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9SpB93Q2a15zHG6XcjLkrHYvnAtcGxx+laJoLBwS8vYMQmICpVq2bzdJWw+C3sKy
         pXIb5cyICJR6UHGL6O0sDliksppT5bG22CTNHCfuxX8zVPa1LUQYFjP+p1El54tu1c
         ja56K2Fj9kpsWaH1K1ubuo87Ix7Wcz+XVK9QHEXE=
Date:   Mon, 16 Jul 2018 09:56:43 +0530
From:   Vinod <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org
Subject: Re: [PATCH v2 0/5] ASoC: core: add support to card re-bind using
 component framework
Message-ID: <20180716042643.GA3219@vkoul-mobl>
References: <20180713153632.32511-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713153632.32511-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-07-18, 16:36, Srinivas Kandagatla wrote:
> During discussion regarding card re-binding when components unregister
> and register back at https://lkml.org/lkml/2018/7/9/785 it was suggested
> that component framework can be added into core to provide this feature.
> 
> With this new changes the card will re-bind once the dependent component
> re-registers after unregistering. This works based on the match done
> from component name using component framework.
> 
> I have tested this patch with qdsp start-stop and module-load-unload usecase
> for more than 10000 times in loop on Qcom platforms.

>  6 files changed, 89 insertions(+), 156 deletions(-)

Looks good to me with a nice diff stat.

FWIW:
Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
