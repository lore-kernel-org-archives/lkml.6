Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10146C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93B020645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZO5NG05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93B020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeIDUjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:39:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45772 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbeIDUjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:39:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id x26-v6so1886102pge.12;
        Tue, 04 Sep 2018 09:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W8j1+yLCrGMraFjiLUwPAFVNbacfVjxk+8aTf9fb9Wk=;
        b=BZO5NG05UFrLGpTath6Pi806KgQDkYsoV0Mnq3H8x+eon8v8qho2O5QDw07CWmJjh0
         YvDmBraNVDESq0wvLYqhPkz0kUAtgsOwUoV/XvpNajgPceoakdKZfBdRVHAYssjd+T5q
         l/7rQfdtjDCmp1YpfuhsKUYLscnyz7ogiTF5W+6tVicMX5QQ3P0nH2EM26kT97P12CKr
         dcU9f6o7aHnxSQ8rrdY7X7f6cteX3EtjnojkzCWxyAvOXktwk/tepCDYO93CyR8g31J0
         rLPTDkfOn+Z4/2Osq3lxgrIxWO6f4G9YWjwB/K3u1A7KN/QMBI7cWsvKAsGWN06dF+I/
         dijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W8j1+yLCrGMraFjiLUwPAFVNbacfVjxk+8aTf9fb9Wk=;
        b=hiB3WmcqsDXw88lxrF6PBOan3qc4DbQc/lsknmSxboMuz5EqXv2j1iPb432twaSmNC
         npwEL4qVRwlnKAyKwbq74yAfTEil+jzOVlOA3/1RdcHpa5Ueym3qBX7bjn2LYlIhuwix
         EwCQ/L7XczzqUOizt42fVVbsh7r04Yl8R3DdHq5WrPQ09Uw+M9HfoEgFy/hCSWDm+jyi
         3OkJ7kPKF68rZ142aFen7aeHBB6aj3Q8iJJd8OfHdtLrdyoANBwmhdRocNSstiXssZwg
         SeRBxkfZuvJjySwq7sc2mYbvRjIeQI6dGLVx7RGKpe5Y5gp3D7IjLd5hsglbnZNguR6x
         /0lQ==
X-Gm-Message-State: APzg51C1YeL+G7hAR9/6vmsjTbp5MEuF5BUWnRXkgnKhoMxW3gHCddkC
        z7HlmBZByLO7MPKvzXA8DbOU8eZW
X-Google-Smtp-Source: ANB0VdaeGH6hGBlNNc5AXwmaKeGeU2Q1emYlb6YIK5122h7lqiwX/z9zg7Ldq0PXlBKtk65Mf7tNeg==
X-Received: by 2002:a63:eb53:: with SMTP id b19-v6mr31947131pgk.371.1536077634662;
        Tue, 04 Sep 2018 09:13:54 -0700 (PDT)
Received: from dsa-mb.local ([2601:282:800:fd80:1145:f235:fa5f:50ca])
        by smtp.googlemail.com with ESMTPSA id z11-v6sm48690574pgz.62.2018.09.04.09.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 09:13:53 -0700 (PDT)
Subject: Re: [PATCH net] devlink: Fix devlink_param_driverinit_value_set()
 stub return code
To:     Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1536066265-18641-1-git-send-email-moshe@mellanox.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <2bf31ad0-c3f8-cdfd-8b96-1a8e3280064d@gmail.com>
Date:   Tue, 4 Sep 2018 10:13:52 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536066265-18641-1-git-send-email-moshe@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/18 7:04 AM, Moshe Shemesh wrote:
> The stub function returned -EOPNOTSUPP while CONFIG_NET_DEVLINK is off.
> It caused false warning during driver load. Driver needs to update
> devlink on a parameter value if devlink module is there, if not it
> doesn't need any error code.
> 
> Fixes: ec01aeb1803e ("devlink: Add support for get/set driverinit value")
> Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
> Acked-by: Jiri Pirko <jiri@mellanox.com>
> ---
>  include/net/devlink.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/devlink.h b/include/net/devlink.h
> index b9b89d6..b467357 100644
> --- a/include/net/devlink.h
> +++ b/include/net/devlink.h
> @@ -781,7 +781,7 @@ static inline bool devlink_dpipe_table_counter_enabled(struct devlink *devlink,
>  devlink_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
>  				   union devlink_param_value init_val)
>  {
> -	return -EOPNOTSUPP;
> +	return 0;
>  }
>  
>  static inline void
> 

This should be handled by the driver -- check for -EOPNOTSUPP and not
log an error.

devlink is generic infrastructure. If a call is made and the operation
is not supported, then devlink should return an error.
