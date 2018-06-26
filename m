Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67E9C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74AC6266F3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="lRsuzzMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AC6266F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933122AbeFZImG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:42:06 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:32881 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752708AbeFZImA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:42:00 -0400
Received: by mail-it0-f65.google.com with SMTP id k17-v6so14696937ita.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 01:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ryvLtNh/eR8Aw9M2GublIeEeGpW5oTmK4F8PJTexoSE=;
        b=lRsuzzMf1YVG48eVRW9vbY0vTXv6NlrH+g/s6pkJBrGN6JcgnYmGSURkLQJ+x6p3Vp
         ax0tHEgbB5X9XPw89KYFY08C60Owe86iQvEC+BMIe2pvl4nujQSV3cGmYObdJv3nHFJ1
         9xVIUgKwvxmBiB5vF7SB6iSr9OZbvQRmmdbh4GryPsm49jNemjwTrU1/+7pZQf04PfG6
         VP2gt9itq9X29+ppa0Aw0x/di+IZ97vCCywf0R30PCGd+jkZORjijfaRTd2MM4eg91l9
         tkqhRoShcRp5ZWOTGrzmQQ5ghoDX6+Zd3CF0sSxme+t+x4xhUvzA1eLlOEufLi/FoIYi
         erKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ryvLtNh/eR8Aw9M2GublIeEeGpW5oTmK4F8PJTexoSE=;
        b=C5SD9CXc/l52phIX279pZGXvZtEgksBVzMGq0HcKLyLVOl3K6ULKOtXb6A0r7JMlte
         JhhwLPYtd9zsDVB9RUh9OAcNnzu5DrdfxFyAEEd+9urvBJE3fnN6DcJAdyLpdXykEEGD
         o4bnYJTSazAbsfnqPXSK5haNx7JtszsUuz6Attxc64LtH8khKdWRUYmWcMpzR9D+jcSd
         5s1YwFQb950KX1Rn5E2fmmi5SfUOvjD7Sx/hJSHHoh0h/Zv5NXcthgVJug8C6PF6wLm9
         CF1PLTGJUhR9+Ed9T1gqmhqe1HGwux40v5DVOeHyo0U1UXBT0aiC7DQ48NSeX04jQq7P
         0E4Q==
X-Gm-Message-State: APt69E0MSZVDwje+B/KQiyQnGB+HIquw9CcsH7y80Uq+nKkT7Lrlkezx
        OCfWvveT9CCiJZ4oqwDEwpczlGUl
X-Google-Smtp-Source: AAOMgpcy8sO10BECr8tXYenVCpH5cM8tScM9aehaIFGTAayxGXWP8kLT/Fj2UjYQiPVu0NsKfY+JMw==
X-Received: by 2002:a02:b559:: with SMTP id z25-v6mr448561jaj.27.1530002519913;
        Tue, 26 Jun 2018 01:41:59 -0700 (PDT)
Received: from [10.86.48.245] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id q14-v6sm153806ioh.64.2018.06.26.01.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 01:41:58 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: assume that chunks are closed on 1.2
 devices
To:     hans.ml.holmberg@owltronix.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
References: <1529399189-3239-1-git-send-email-hans.ml.holmberg@owltronix.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <a2bb1959-5244-f8af-b747-6d87e8d456a4@lightnvm.io>
Date:   Tue, 26 Jun 2018 10:41:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1529399189-3239-1-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 11:06 AM, Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> We can't know if a block is closed or not on 1.2 devices, so assume
> closed state to make sure that blocks are erased before writing.
> 
> Fixes: 32ef9412c114 ("lightnvm: pblk: implement get log report chunk")
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> 
> This patch applies on:
> ssh://github.com/OpenChannelSSD/linux branch for-4.19/core
> 
>   drivers/lightnvm/pblk-init.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index aa24264..3b8aa4a 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -717,10 +717,11 @@ static int pblk_setup_line_meta_12(struct pblk *pblk, struct pblk_line *line,
>   
>   		/*
>   		 * In 1.2 spec. chunk state is not persisted by the device. Thus
> -		 * some of the values are reset each time pblk is instantiated.
> +		 * some of the values are reset each time pblk is instantiated,
> +		 * so we have to assume that the block is closed.
>   		 */
>   		if (lun_bb_meta[line->id] == NVM_BLK_T_FREE)
> -			chunk->state =  NVM_CHK_ST_FREE;
> +			chunk->state =  NVM_CHK_ST_CLOSED;
>   		else
>   			chunk->state = NVM_CHK_ST_OFFLINE;
>   
> 

pblk should scan (or the lightnvm subsystem) the blocks for their state, 
such that it doesn't have to reinitialize a full drive if it is already 
in a closed state. If marking closed, it does a full erase cycle on 
initialization, which should be avoided since it is a limited resource.
