Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D69DC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35275208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0ctcWSCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35275208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754409AbeGIHnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750996AbeGIHnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:43:23 -0400
Received: from localhost (unknown [106.201.46.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEEB7208AF;
        Mon,  9 Jul 2018 07:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531122203;
        bh=ZmXRZswSBaU7IWy/mZJC2S8x8pdhCs2OBssybLLZ4HY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0ctcWSCCoLDq4BVqgH46zVqAvrqqNvhO2i1ubnTVU/CmllZUNauKM9m/xLs4As+qY
         kfXKSh08GwIbVZw+YNXpGhPpHQqBpPU/ODo3v2ih8vUd+0LMVfM5MuOUaKbyyjVut0
         KJ7tdXgc4i0s61pEk4l+g4ZASYjhEd0LUrqIozrs=
Date:   Mon, 9 Jul 2018 13:13:15 +0530
From:   Vinod <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rohit kumar <rohitkr@codeaurora.org>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v3 2/5] ASoC: qcom: Add support to parse
 common audio device nodes
Message-ID: <20180709074315.GA22377@vkoul-mobl>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-3-git-send-email-rohitkr@codeaurora.org>
 <84b6f1f7-b9c1-fd0c-b684-1e07d35663ba@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84b6f1f7-b9c1-fd0c-b684-1e07d35663ba@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-07-18, 18:51, Srinivas Kandagatla wrote:
> 
> 
> On 06/07/18 10:43, Rohit kumar wrote:
> > This adds support to parse cpu, platform and codec
> > device nodes and add them in dai-links. Also, add
> > API to add slave components associated with machine
> > driver.
> > 
> > Signed-off-by: Rohit kumar<rohitkr@codeaurora.org>
> > ---
> >   sound/soc/qcom/Kconfig  |   3 +
> >   sound/soc/qcom/Makefile |   1 +
> >   sound/soc/qcom/common.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++++
> >   sound/soc/qcom/common.h |  14 +++++
> >   4 files changed, 168 insertions(+)
> >   create mode 100644 sound/soc/qcom/common.c
> 
> common.c seems to miss

Btw do you need a new Kconfig symbol for this?

Alternate option would be to just add common.o to wherever it is needed

-- 
~Vinod
