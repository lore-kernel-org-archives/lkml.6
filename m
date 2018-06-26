Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1979BC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD5325841
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="z88yB4/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD5325841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934999AbeFZMKm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:10:42 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34378 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934690AbeFZMKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:10:40 -0400
Received: by mail-pf0-f195.google.com with SMTP id g3-v6so3243217pfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 05:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:cc:references:from:to:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kKFr+fsUSiwrXLlgtBVMrF621wu3ylIlXvos79BAKnU=;
        b=z88yB4/S5IApA6fT/FCVQcNL4fRV7R2edbpI/grvJddv0HSJ/XCh7F9z8F6cvFyxYU
         m4enL32cF9jXCjXHKXvMAwFwYT0Ky5pjgCK8uNJwpr8THRPJhV9Bn58+bRN5S1MZpzcX
         y4FYwcQyl5CWaQwvbZZOG8RA/fS/8a3Cy45Ui8JA82H/l0zByVPqCqciroXM94lCcp1J
         ZlWJrjiot5D9IuoHzz5CMAlktqC4nU9X/oXpQvSzEfCPLAnmoKdog4hSPnZbQo+pyxhk
         HzWHp+vdm9GU4eIGOeVozMlXr3Rk3NfPfz+mHOZKvTg7JfLV8Z2o7wCQzSnr0QjeN1n7
         zkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:to:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kKFr+fsUSiwrXLlgtBVMrF621wu3ylIlXvos79BAKnU=;
        b=gmPt9SP65nRYWDcilze+jCz+XhDp9cB/vYF2Y7hGOf5krISmnku5PqiE/JFMQ5BQcO
         3fNoqXDqD+nkd4X5rtKWL14S7sI8L8/PgjjNdGpdGvyclymx8/k5W5wSw5VNcxbgX2Ed
         sA1RejdcYWMIHgTbgoMg97hDmoUjM39XrZLMqKyD+KxqY/K7uREMBBUNmtecS2Zdz3cr
         F9MHSMMlkBBa5R5c37LHUCI46JrvewfcLNVPg5Yr/bDnfRMV7bMbAZcUs1y9VLydT6Vb
         VGIb1XVkC/DSIDYGPWZ5RT5os55ukDtxwDtlTRNQUZdlTj3b2hJQON7/2l21ON1fzNMV
         /+uA==
X-Gm-Message-State: APt69E0HoAuC4oaeROtX4eNkboSeBA6aqIGiolgXBeP3iaqgTuwv6Q4u
        crMUuqHdpWoyvCiGTUIbwCX3dQ==
X-Google-Smtp-Source: ADUXVKJv2MOs9qHsWz2W9d93ClpvVMsQOve6oWUJkr56U9S88WrlfLEF6E7Q0OJYtPTmdmQbDzXIfw==
X-Received: by 2002:a63:714c:: with SMTP id b12-v6mr1154836pgn.420.1530015040157;
        Tue, 26 Jun 2018 05:10:40 -0700 (PDT)
Received: from [10.86.48.245] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id j10-v6sm7615457pfj.158.2018.06.26.05.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 05:10:38 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: assume that chunks are closed on 1.2
 devices
Cc:     hans.ml.holmberg@owltronix.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, javier@cnexlabs.com,
        hans.holmberg@cnexlabs.com
References: <1529399189-3239-1-git-send-email-hans.ml.holmberg@owltronix.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
To:     axboe@kernel.dk
Message-ID: <3d09296d-ace3-f025-b6d9-5d99ce6b9fc8@lightnvm.io>
Date:   Tue, 26 Jun 2018 14:10:34 +0200
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

Hi Jens,

Would it be possible to pick this patch up for 4.18? It is a temporary 
fix that lets pblk continue to work with 1.2 OCSSD drives that has open 
blocks on initialization. Without it, writes will fail, as pblk assumes 
that the blocks are free.

A proper fix that scans the block state on initialization will be ready 
for 4.19.

Thank you,
Matias

