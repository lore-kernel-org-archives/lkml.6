Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C68DC6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5179A20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544581958;
	bh=52fJVM69HL4Nu58eL7xFh/vhOkWVB8TRGYmsLKSGyy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xo3HLnSzYnjjnfEGMi4RrucVV5WOO7g0q46GevlNb7d4ftbXBqiZz3uMEsWGSyd+K
	 q+JUEBtS0MUXUxv8SPYMGHlAOTVqXSS2ys3gt5nYnAWecGC+HsA6tyJDs4NU3Zogcm
	 OJ/lnZ01TewKqq92xttiZOr+VbjIVeKVBJVqDeZA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5179A20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbeLLCch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:32:37 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39576 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLLCcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:32:36 -0500
Received: by mail-oi1-f195.google.com with SMTP id i6so13830363oia.6;
        Tue, 11 Dec 2018 18:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SIpVD26WKBT7G/yT/0SS01I2JfBHt0unDCcPL+LLsBs=;
        b=JCLi9iMCV7lEXv61f6ZEYSR7onJoHwtuARZv4aSKSLRDE6Mgk/FvKBsHvWDGUMJlvU
         LfM3SevRMuWJnketKFwklgl7mIfBKvdLs0lg+NIm4e9iBHjhMl+Rdd0pHBHKlT9m5Ylo
         ewte015BR5w/B5fB1R4g6fjZLsNLPhTbllE0YkAw6Ypxg08h8iL4KQPRudOa24sRYuMm
         9BHonNRIoOtU5Gklcwb4Fx7Se17bWedRMSobP/CR2uOd5jnogIWPwDA37jWibZf4e4p3
         a5E99hL8gHn17z+rNPLWS0FygVTOOxyHHeq+Nvui/IV9CkMcZ030dQUeLwgd81ZG7wTH
         8kkA==
X-Gm-Message-State: AA+aEWYcJz7dDJ+rj0HJ63NicMqxIIzs0S1oHXtN6p5XqCfGyvQfuO0l
        NtuM+9cdIStPl9bAR3UakA==
X-Google-Smtp-Source: AFSGD/X8VpFE0CmMNvfsx4X8Bopir8wT6OVEb+BeQtycZfExHYGGDw5qfJeUXW/zUU2s+upcpJAGuQ==
X-Received: by 2002:aca:2d3:: with SMTP id 202mr193652oic.214.1544581955727;
        Tue, 11 Dec 2018 18:32:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t8sm7493673otp.69.2018.12.11.18.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 18:32:35 -0800 (PST)
Date:   Tue, 11 Dec 2018 20:32:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, bgoswami@codeaurora.org,
        Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH 1/2] dt-binding: remoteproc: Remove lpass_aon clock from
 adsp pil clock list
Message-ID: <20181212023234.GA4973@bogus>
References: <1543562950-23997-1-git-send-email-rohitkr@codeaurora.org>
 <1543562950-23997-2-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543562950-23997-2-git-send-email-rohitkr@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 12:59:09 +0530, Rohit kumar wrote:
> LPASS_Audio_Wrapper_AON clock is on by default. Remove
> it from lpass clock list to avoid voting for it.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
