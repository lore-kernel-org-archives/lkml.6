Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26069C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59FF2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8tDZEfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59FF2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeK3Xbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:31:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:55936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbeK3Xbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:31:38 -0500
Received: from localhost (unknown [122.178.222.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 209152082F;
        Fri, 30 Nov 2018 12:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543580550;
        bh=9priqn8A7a/uGImHLWI5x5lMrKSCESWS4+BBES+gE5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D8tDZEfxkv1jkn/u9qd0PwsxeT+syKOUejIFvvVSRGLj05KJh0VopxqJwozqvf1b/
         AGfx1KO8V0Jw6QwYcW9qKfysdM1opUtwki555ZzhoqVHQpRgSY1J9l1OR0s2TG54kh
         yhYAbIGaVzuliwWYIKBL3YTD8Q0z9of5WINJSPVI=
Date:   Fri, 30 Nov 2018 17:52:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        lgirdwood@gmail.com, tiwai@suse.com, devicetree@vger.kernel.org,
        srini@kernel.org
Subject: Re: [PATCH v3 0/5] ASoC: qdsp6: add compress offload support
Message-ID: <20181130122220.GO3175@vkoul-mobl.Dlink>
References: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-11-18, 18:13, Srinivas Kandagatla wrote:
> This patchset adds support to very basic MP3 playback compress offload
> support via QDSP ASM module.
> 
> Tested this patchset on DB410c with APQ8016 and DB820c with APQ8096 using
> tinycompress library.
> 
> Adding other codec support should be trivial w.r.t qdsp6 side, however
> there are other dependencies like compress UAPI header changes and
> FastRPC which are being worked in parallel. Once ready will post them!

Thanks Srini, with this we will have compress support upstream for a
public board.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
