Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863BBC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B1821522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="pw756e3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B1821522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbeITWXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:23:22 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43310 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeITWXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:23:22 -0400
Received: by mail-qk1-f193.google.com with SMTP id 130-v6so5416541qkd.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=hXkOWKr79irQebrEhdECzLeU3ACL8OkvnergRcmaUlM=;
        b=pw756e3SD92E/5glK5+o2k0tC0UonmSnTiUf62ke25qj+wHyWKc6QBqa1174o5D2Vy
         MAVPEZtRUWo7QgFaVxwQcjEcYPKY5S6htfok/OrZ1ONvyhnnE9CbcrjTpfU6yEwkM3sS
         v/od05Y59u+Iv+sE5lc4Xgxf9lQhgmwsS46dgZRcCKmD+CWEM6PmN8Q2Z2RmB07wQQkN
         lsjxHOXRDAbL18upg7POP22WF17Du4UvaBpqpw2wI5kRsSsxnWMzxeaRbS9cbnUMCr+7
         3ghG6K5xuzIqPx5irQgxcUNbdni9Eds4zzuH2H6SjlrnZa9BSejRXlyCuJypApLyabtz
         zgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=hXkOWKr79irQebrEhdECzLeU3ACL8OkvnergRcmaUlM=;
        b=eL//pER27BIVY4Rji/7E6ClHmsfGg+asVReDRhW9NnJti+qOOEuDRUuFsB4uzjtyr7
         M2BTodQ3Kpe7X6TbBdvUSEWzkk3bBJg7sHErOXfn3kPAWlAGV8hlS1T2Gf4V2BOyWZfr
         sUw8D9unqJVlZ5SZV0K9EZz64TYPwjV3YesEyyN/Rb1OR7+E0aPe1sisRHt3SS5Z35fk
         ypsUr3S+pTnTKEb2fxi07DG1AJKNpEAkLKcVN0F079KLlavIpWXiwBQnbj5hn/o9BuSp
         jsZXVh2T7Es/q6L6MCN+WmS91t8A5jRK9O3TKxka7mUVKQhaqWhwVb/0W3MKTNnjWqB3
         ZdJQ==
X-Gm-Message-State: APzg51AZJcb8wKgnF502UYWWV1K300Ei7O/mUDv21f5etA70TumEbb/y
        yqtMbG5IwvPFBWvhd+W2en5NEg==
X-Google-Smtp-Source: ANB0Vdab5W04XtBBxGMOgKkKs6tn8dwQSU186E3Cx1a6tLrUEtL30M3WAdCvof4RqUPGOllRjRb8Jw==
X-Received: by 2002:ad4:5052:: with SMTP id m18-v6mr29219149qvq.164.1537461541903;
        Thu, 20 Sep 2018 09:39:01 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id p22-v6sm8783768qtk.29.2018.09.20.09.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:39:01 -0700 (PDT)
Date:   Thu, 20 Sep 2018 09:38:57 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     <davem@davemloft.net>, <dirk.vandermerwe@netronome.com>,
        <simon.horman@netronome.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: netronome: remove redundant continue
Message-ID: <20180920093857.6227710f@cakuba.netronome.com>
In-Reply-To: <1537430541-37817-1-git-send-email-zhongjiang@huawei.com>
References: <1537430541-37817-1-git-send-email-zhongjiang@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2018 16:02:21 +0800, zhong jiang wrote:
> The continue will not truely skip any code. hence it is safe to
> remove it.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

I think this came up during review at some point.  I still prefer to
keep the continue.  The body of the loop performs initialization of
objects, if an object is removed we shouldn't carry on with the body.
It's easy to miss that the object got freed otherwise, there is no
error being set and no warning printed...

> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
> index 0b1ac9c..50d7b58 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
> @@ -230,10 +230,8 @@ static void nfp_net_pf_free_vnics(struct nfp_pf *pf)
>  		ctrl_bar += NFP_PF_CSR_SLICE_SIZE;
>  
>  		/* Kill the vNIC if app init marked it as invalid */
> -		if (nn->port && nn->port->type == NFP_PORT_INVALID) {
> +		if (nn->port && nn->port->type == NFP_PORT_INVALID)
>  			nfp_net_pf_free_vnic(pf, nn);
> -			continue;
> -		}
>  	}
>  
>  	if (list_empty(&pf->vnics))

