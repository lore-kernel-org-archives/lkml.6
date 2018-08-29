Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED06C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49BF2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="u9DdSZLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49BF2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbeH2RFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:05:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44671 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeH2RFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:05:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so2239323pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 06:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n2gm/tJ8cTXqdvjAAS276cszFYzzc12+QuZ1BNfGWD8=;
        b=u9DdSZLc9S8ta+xQqVH3nTqV/dvir8IBPH6lN2om7RCjwdZH5ouEiHs3k4nh4yFERB
         xML3+Yhql0Kul6I2J6eAzAhNOvsqsySM56hDEbf8ZnkRT03n6otxhmoWEpZSr7kW1dxb
         huEXbDBC/M9/WhmBa2L0OHH/BeLBlLwvoylTLz9YhR5joC7a8b7qDuS2/E1b14HNF0ga
         F76qQJMxCrrgj0Dy9fe3cnFhLqERAVAF1/b0JhGL7rj3wfSRMantvU/WapMPRC+P6Ndu
         MOhXd3pE5ysKQ0cOxcA2XQF2W5dqE0GVRZov8AVYNHlIwrp7qgtMHC5AXEmM/+j0M5L6
         GaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n2gm/tJ8cTXqdvjAAS276cszFYzzc12+QuZ1BNfGWD8=;
        b=PegQ7cAqS46fuHWKWbj+GireLel957zDg4K/+VFlxfiYBr20XroG4BoLvjKnJDvbc3
         mkc5L8osuod0/vn0ajPOxHUO/2u6tyB6YyG6lIy/PNXQ8tsbjhvEuDyE0e6X9K9ZEaqI
         i1utkSuQAfQ/EytyQjt/LcdRGMBSgFFRP6k9imhoQpYBaFAkiS4gz7NOe2auotNKhDZ2
         hp6S7pL2kiw33ijKof7P7iR/5noU4GEaOnwLtyd0M4O3xm5N9Q3OMMjMfOCOBXKds5Ks
         uwxXTWCNCjGc0q7iSCgBkAXsXrc+w7hJIfOIYN+hmsl9Hm9a8ZxdFeR8VlfQ64r/0ph9
         3TUw==
X-Gm-Message-State: APzg51Bzn8YuGpxCilpDLOAa2Ck1W8TltPpRfUymQf6eY1YOnu9irJG1
        ugCChamtwrIp6POUIP3OLLxf5w==
X-Google-Smtp-Source: ANB0Vda8ZrHTIJCbflBsyOP0q+AQXqJRjpEs1Jw4aMWMQFqUDA6EF2sMqhoZXi0U6/V0AsXijsEDBw==
X-Received: by 2002:a63:7107:: with SMTP id m7-v6mr5625809pgc.73.1535548095656;
        Wed, 29 Aug 2018 06:08:15 -0700 (PDT)
Received: from [10.86.62.45] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id n18-v6sm7127931pfa.50.2018.08.29.06.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 06:08:14 -0700 (PDT)
Subject: Re: [PATCH 3/3] lightnvm: pblk: take write semaphore on metadata
To:     javier@javigon.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, javier@cnexlabs.com
References: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
 <1535532980-27672-4-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f4f8c276-0269-5aa5-39fc-42aecc7bb309@lightnvm.io>
Date:   Wed, 29 Aug 2018 15:08:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1535532980-27672-4-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 10:56 AM, Javier González wrote:
> pblk guarantees write ordering at a chunk level through a per open chunk
> semaphore. At this point, since we only have an open I/O stream for both
> user and GC data, the semaphore is per parallel unit.
> 
> For the metadata I/O that is synchronous, the semaphore is not needed as
> ordering is guaranteed. However, if the metadata scheme changes or
> multiple streams are open, this guarantee might not be preserved.
> 
> This patch makes sure that all writes go through the semaphore, even for
> synchronous I/O. This is consistent with pblk's write I/O model. It also
> simplifies maintenance since changes in the metadata scheme could cause
> ordering issues.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-core.c | 16 +++++++++++++++-
>   drivers/lightnvm/pblk.h      |  1 +
>   2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 767178185f19..1e4dc0c1ed88 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -558,6 +558,20 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
>   	return ret;
>   }
>   
> +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
> +{
> +	struct ppa_addr *ppa_list;
> +	int ret;
> +
> +	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
> +
> +	pblk_down_page(pblk, ppa_list, rqd->nr_ppas);

If the debug stuff is killed inside __pblk_down_page, then ppa_list and 
rqd->nr_ppas does not need to be passed, and this function can be 
inlined in its caller. Can we kill it? I'll make the patch if you like.

> +	ret = pblk_submit_io_sync(pblk, rqd);
> +	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
> +
> +	return ret;
> +}
> +
>   static void pblk_bio_map_addr_endio(struct bio *bio)
>   {
>   	bio_put(bio);
> @@ -788,7 +802,7 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
>   		meta_list[i].lba = lba_list[paddr] = addr_empty;
>   	}
>   
> -	ret = pblk_submit_io_sync(pblk, &rqd);
> +	ret = pblk_submit_io_sync_sem(pblk, &rqd);
>   	if (ret) {
>   		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
>   		bio_put(bio);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index c0d9eddd344b..54f937c1fb62 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -793,6 +793,7 @@ void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
>   void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
>   int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
>   int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd);
> +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd);
>   int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line);
>   void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rqd);
>   struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
> 

