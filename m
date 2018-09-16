Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFF5C4161C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 15:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B057C208DD
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 15:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O27SQLkk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B057C208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeIPVHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 17:07:10 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35998 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeIPVHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 17:07:09 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8GFhdBI117144;
        Sun, 16 Sep 2018 10:43:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537112619;
        bh=EtaApXq9VT6NNw2tMCAuqgstMuomjcw2ZxyEesfF/RE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=O27SQLkkrZHGIF6n89ncoacg/nIwKrSnaveFWNfHkWNzJ4ThreH7S0mRbqBvLIAaS
         z9zTiokN5YY2joehFDwqQWH9BAz7RpVHQA8+O8sXiZNwbljHVnXt47DQgCsUfKG1V/
         4qY67hDqgUYtYZvkCfYqAc9zeLcQfCggB+Nh2yY4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8GFhdAY010816;
        Sun, 16 Sep 2018 10:43:39 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Sun, 16
 Sep 2018 10:43:39 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Sun, 16 Sep 2018 10:43:38 -0500
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with SMTP id w8GFhcYA009088;
        Sun, 16 Sep 2018 10:43:38 -0500
Date:   Sun, 16 Sep 2018 10:43:38 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     zhong jiang <zhongjiang@huawei.com>
CC:     <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: platform: remove redundant null pointer check
 before of_node_put
Message-ID: <20180916154338.GE17511@ti.com>
References: <1537103811-63670-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1537103811-63670-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhong,

Thank you for the patch.

zhong jiang <zhongjiang@huawei.com> wrote on Sun [2018-Sep-16 21:16:51 +0800]:
> of_node_put has taken the null pinter check into account. So it is

s/pinter/pointer/

> safe to remove the duplicated check before of_node_put.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

with the above change,

Reviewed-by: Benoit Parrot <bparrot@ti.com>

> ---
>  drivers/media/platform/ti-vpe/cal.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
> index cc052b2..5f9d4e0 100644
> --- a/drivers/media/platform/ti-vpe/cal.c
> +++ b/drivers/media/platform/ti-vpe/cal.c
> @@ -1747,14 +1747,10 @@ static int of_cal_create_instance(struct cal_ctx *ctx, int inst)
>  	}
>  
>  cleanup_exit:
> -	if (remote_ep)
> -		of_node_put(remote_ep);
> -	if (sensor_node)
> -		of_node_put(sensor_node);
> -	if (ep_node)
> -		of_node_put(ep_node);
> -	if (port)
> -		of_node_put(port);
> +	of_node_put(remote_ep);
> +	of_node_put(sensor_node);
> +	of_node_put(ep_node);
> +	of_node_put(port);
>  
>  	return ret;
>  }
> -- 
> 1.7.12.4
> 
