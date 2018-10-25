Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103FFC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B010320848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZGoddWcw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZGoddWcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B010320848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeJZB0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:26:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48526 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbeJZB0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:26:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8073B60C5F; Thu, 25 Oct 2018 16:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540486384;
        bh=xVseYqk9plG4FbTOUKZlnWxKU4W86Ty1/1ePQCHPU2Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZGoddWcwMegLRO+wgLdf+pOk4CVWkWTJD6qL5h2qO7vfwwqUDwEa7S+xM0bXKMabl
         VCKwhIZqNdEZVhXTn+7xjlKE/Sk0GXSuO0Pkf/y83HqX10NMaqESpIXPg2gyCX+mKy
         bwBsW6c4EXhClHeFL8pe0RY71df4zOjUeQFF5Ljw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0BFB760792;
        Thu, 25 Oct 2018 16:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540486384;
        bh=xVseYqk9plG4FbTOUKZlnWxKU4W86Ty1/1ePQCHPU2Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZGoddWcwMegLRO+wgLdf+pOk4CVWkWTJD6qL5h2qO7vfwwqUDwEa7S+xM0bXKMabl
         VCKwhIZqNdEZVhXTn+7xjlKE/Sk0GXSuO0Pkf/y83HqX10NMaqESpIXPg2gyCX+mKy
         bwBsW6c4EXhClHeFL8pe0RY71df4zOjUeQFF5Ljw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 25 Oct 2018 22:23:04 +0530
From:   alokc@codeaurora.org
To:     swboyd@chromium.org, dianders@chromium.org,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] spi-geni-qcom: Cleanup nitpicks and simplify probe
 function
In-Reply-To: <1540485629-5970-1-git-send-email-alokc@codeaurora.org>
References: <1540485629-5970-1-git-send-email-alokc@codeaurora.org>
Message-ID: <b391e2df12e31be9ba5e48f197a86471@codeaurora.org>
X-Sender: alokc@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-25 22:10, Alok Chauhan wrote:
> This patch series fixed the following:
> * nitpicks from the previous review
>  (https://patchwork.kernel.org/patch/10624849/)
> * Cleanup probe function by re-arranging existing APIs to starting of
>   function and hence avoiding one goto jump and remove few redundant
>   variables.
> 
> Alok Chauhan (2):
>   spi: spi-geni-qcom: fix nitpicks
>   spi: spi-geni-qcom: Simplify probe function
> 
>  drivers/spi/spi-geni-qcom.c | 64 
> +++++++++++++++++++++------------------------
>  1 file changed, 30 insertions(+), 34 deletions(-)

Added more folks as some them got missed by get_maintainer.pl for this 
patch.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,a Linux Foundation Collaborative Project
