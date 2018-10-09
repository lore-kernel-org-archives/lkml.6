Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A093C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE45A214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="icAUxZS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE45A214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeJJE20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:28:26 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:40074 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJE2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:28:25 -0400
Received: from [192.168.0.21] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8EE4A6F;
        Tue,  9 Oct 2018 23:09:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539119374;
        bh=VpriqSkYL6Rf0104sPedjCOgh+9u/p01Leemhv4EFgQ=;
        h=Subject:To:Cc:References:Reply-To:From:Date:In-Reply-To:From;
        b=icAUxZS/FQZlqUC0rUxpGNIHEE9WStK8ufwtDWJCx1bimYqV0ryk0S2Xrh/NBlOaz
         O/kVJ4Pl0asYcts+iewlb257velUPfI1HrDDUClmXWI51sSoHseJBdu4F8DxTK7zSn
         /rlCyhrCsrp7mCcoEi8Oz0vKQ4ibtkCLbAMUHsQo=
Subject: Re: [PATCH] media: tc358743: Remove unnecessary self assignment
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Mats Randgaard <matrandg@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181008221128.22510-1-natechancellor@gmail.com>
Reply-To: kieran.bingham+renesas@ideasonboard.com
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <b5f1c169-3770-96a7-cd1a-59939de8064b@ideasonboard.com>
Date:   Tue, 9 Oct 2018 22:09:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008221128.22510-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

Thank you for the patch,

On 08/10/18 23:11, Nathan Chancellor wrote:
> Clang warns when a variable is assigned to itself.
> 
> drivers/media/i2c/tc358743.c:1921:7: warning: explicitly assigning value
> of variable of type 'int' to itself [-Wself-assign]
>                 ret = ret;
>                 ~~~ ^ ~~~
> 1 warning generated.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Certainly somewhat redundant.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> ---
>  drivers/media/i2c/tc358743.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
> index ca5d92942820..41d470d9ca94 100644
> --- a/drivers/media/i2c/tc358743.c
> +++ b/drivers/media/i2c/tc358743.c
> @@ -1918,7 +1918,6 @@ static int tc358743_probe_of(struct tc358743_state *state)
>  	ret = v4l2_fwnode_endpoint_alloc_parse(of_fwnode_handle(ep), &endpoint);
>  	if (ret) {
>  		dev_err(dev, "failed to parse endpoint\n");
> -		ret = ret;
>  		goto put_node;
>  	}
>  
> 

