Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13F4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05512147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550645746;
	bh=WL0oUnJzLH6dyJIpkFuqyeo/UYoGOnl53nHG9dHMXqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y6hotBlSAuLUJrKONgsFrG6fMgMkORPrwKHis8jfNzilb8d+mGwNUWBMjNI+PP79U
	 Z8YWGDz0rea2jfTVnCLCDXy2NzUWRRGRuGruAhAlOJq9W2Qb3aO6XmdUcGnVnBAlDW
	 hsQlTseKa4w3Y4+KKxJ1eDZCAGwseM3U77G5I6b8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbfBTGzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 01:55:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:55202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbfBTGzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 01:55:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 046EC2147A;
        Wed, 20 Feb 2019 06:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550645744;
        bh=WL0oUnJzLH6dyJIpkFuqyeo/UYoGOnl53nHG9dHMXqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wdDRTjJpEqnCQjiUimNFcq+HxhlQ6gakLRCTB4T21WuavLqp4ezBztXSJkm8d8kiM
         uSbAqOSqpRY2qyVgkgVzk52tujOZh2yJ/w/YOE9tnB/uKzoInqOHxqraF+FXZqW7C7
         XnhOJtnDSzmsCOrS4dxoHRIGENGjHdIgxer3kiRQ=
Date:   Wed, 20 Feb 2019 07:55:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org
Subject: Re: [PATCH v2 5/5] base: soc: Export soc_device_register/unregister
 APIs
Message-ID: <20190220065541.GA8860@kroah.com>
References: <20190220045946.7452-1-vaishali.thakkar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220045946.7452-1-vaishali.thakkar@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:29:46AM +0530, Vaishali Thakkar wrote:
> From: Vinod Koul <vkoul@kernel.org>
> 
> Qcom Socinfo driver can be built as a module, so
> export these two APIs.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
> ---
> Changes since v1:
> 	- None

This is fixing a build breakage introduced by an earlier patch.  Please
rearange the patches so that breakage never happens.

Also, any chance you can properly "thread" your patches so they all show
up together?  git send-email does this automatically...

thanks,

greg k-h
