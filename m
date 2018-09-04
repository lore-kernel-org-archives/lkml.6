Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67C8C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864A820843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="lGZeKg6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864A820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeIDPV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:21:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37464 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeIDPV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:21:57 -0400
Received: by mail-lf1-f66.google.com with SMTP id j8-v6so2573271lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/tBmxR8wU32IhszEJXa8aMo6L0IWseZRyICM24Wp3Q8=;
        b=lGZeKg6DtENbRntllUWqYYRfiKBDQxC5CDpW4XBk7diNtINPKfD9oQIE7EwlWUAVea
         BJjnX4IOLrCIvavzCYbhpu/tFupEQbPQgivjFbdw5ClRVewRgotKeNdd9g0lLuP1X0Qu
         pWXrPk7G9quljzsk5PvuzFOyZfz4LiFkMZ3qEZSKWYHa1qs7sbVNOAk42uq7NRP899jf
         lolx+Uq32uYrzIZ/SQMbZku1GKufET+k0I2pQ6tz48zbNQv0Cnw/0mMFdidarM2I99a7
         IUNuflqXcAULR+jDy+qSwE/KDCQYz8amspfdJtGZVEkVpKXUpEl4it9AY9hJlz6Waa1j
         +D+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/tBmxR8wU32IhszEJXa8aMo6L0IWseZRyICM24Wp3Q8=;
        b=USgWqNXoAFopusA3oO3ZoU510ONszW5CYAIGX8OTI2TXYovPaqYo+pWYjCDRRHECEa
         nODSkTVh0FEUGy6DLJtg2FB7APLiDiBHIb0t/KaaRJtp4wY4Ahi2neVGokMlbWFbL/Ys
         2XIP1obHyTCNYxTDy3coW6VgvfRIuG/rGM0DbmT5Y2BMt9Jedof8lDe0onUJvkDPl+V/
         iUrw7bjER4GQbdm91Jr7v8j3Py+WKYIuLIVVbBAQb9idBmAqImdpE44KSn7H+SE3nOls
         7cn5DI9hqfpm5Pbe3KDsEQxgJb+baem0HmlAqcdnxDw+HMXbztmDOG67+iW1m1yNqBRL
         B/WA==
X-Gm-Message-State: APzg51BC+yFrxagRz7rhscjBsryEzQgI/xfMXQyOi8VRFvGkY5rd0P7O
        ltV8jWLCZV4A7/TfFD50d6Lr8A==
X-Google-Smtp-Source: ANB0VdYyn22xI6ccNP6CgO2HUtN8pw+kBu8Qua6o5lNHYBHh9ILpkZgyQTWCQ7xmxIYiVyflGfKMIw==
X-Received: by 2002:a19:d206:: with SMTP id j6-v6mr8205858lfg.31.1536058639719;
        Tue, 04 Sep 2018 03:57:19 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id o102-v6sm3068310lfi.53.2018.09.04.03.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 03:57:18 -0700 (PDT)
Subject: Re: [PATCH V2] lightnvm: pblk: add tracing for chunk resets
To:     hans.ml.holmberg@owltronix.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
References: <1536057487-17267-1-git-send-email-hans.ml.holmberg@owltronix.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <76c839e6-7a30-7365-1813-d1f2aa81f4c8@lightnvm.io>
Date:   Tue, 4 Sep 2018 12:57:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1536057487-17267-1-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 12:38 PM, Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> Trace state of chunk resets.
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
> 
> ---
> 
> You already picked up the first version of this patch Matias,
> but here's a V2 adressing the review comment from Javier that came
> after that.
> 
> Changes in V2:
> 	Moved the synchronous PBLK_CHUNK_RESET_START trace to
> 	pblk_blk_erase_sync (as Javier suggested)
> 
>   drivers/lightnvm/pblk-core.c  | 12 ++++++++++++
>   drivers/lightnvm/pblk-trace.h | 31 +++++++++++++++++++++++++++++++
>   drivers/lightnvm/pblk.h       |  6 ++++++
>   3 files changed, 49 insertions(+)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 73f117bc99a9..951f81a1b273 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -90,9 +90,15 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
>   	atomic_dec(&line->left_seblks);
>   
>   	if (rqd->error) {
> +		trace_pblk_chunk_reset(pblk_disk_name(pblk),
> +				&rqd->ppa_addr, PBLK_CHUNK_RESET_FAILED);
> +
>   		chunk->state = NVM_CHK_ST_OFFLINE;
>   		pblk_mark_bb(pblk, line, rqd->ppa_addr);
>   	} else {
> +		trace_pblk_chunk_reset(pblk_disk_name(pblk),
> +				&rqd->ppa_addr, PBLK_CHUNK_RESET_DONE);
> +
>   		chunk->state = NVM_CHK_ST_FREE;
>   	}
>   
> @@ -923,6 +929,9 @@ static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
>   	struct nvm_rq rqd = {NULL};
>   	int ret;
>   
> +	trace_pblk_chunk_reset(pblk_disk_name(pblk), &ppa,
> +				PBLK_CHUNK_RESET_START);
> +
>   	pblk_setup_e_rq(pblk, &rqd, ppa);
>   
>   	/* The write thread schedules erases so that it minimizes disturbances
> @@ -1736,6 +1745,9 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
>   	rqd->end_io = pblk_end_io_erase;
>   	rqd->private = pblk;
>   
> +	trace_pblk_chunk_reset(pblk_disk_name(pblk),
> +				&ppa, PBLK_CHUNK_RESET_START);
> +
>   	/* The write thread schedules erases so that it minimizes disturbances
>   	 * with writes. Thus, there is no need to take the LUN semaphore.
>   	 */
> diff --git a/drivers/lightnvm/pblk-trace.h b/drivers/lightnvm/pblk-trace.h
> index c171d0450c07..679e5c458ca6 100644
> --- a/drivers/lightnvm/pblk-trace.h
> +++ b/drivers/lightnvm/pblk-trace.h
> @@ -31,6 +31,37 @@ struct ppa_addr;
>   	{ PBLK_STATE_RECOVERING,	"RECOVERING",	},	\
>   	{ PBLK_STATE_STOPPED,		"STOPPED"	})
>   
> +#define show_chunk_erase_state(state) __print_symbolic(state,	\
> +	{ PBLK_CHUNK_RESET_START,	"START",	},	\
> +	{ PBLK_CHUNK_RESET_DONE,	"OK",		},	\
> +	{ PBLK_CHUNK_RESET_FAILED,	"FAILED"	})
> +
> +
> +TRACE_EVENT(pblk_chunk_reset,
> +
> +	TP_PROTO(const char *name, struct ppa_addr *ppa, int state),
> +
> +	TP_ARGS(name, ppa, state),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(u64, ppa)
> +		__field(int, state);
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->ppa = ppa->ppa;
> +		__entry->state = state;
> +	),
> +
> +	TP_printk("dev=%s grp=%llu pu=%llu chk=%llu state=%s", __get_str(name),
> +			(u64)(((struct ppa_addr *)(&__entry->ppa))->m.grp),
> +			(u64)(((struct ppa_addr *)(&__entry->ppa))->m.pu),
> +			(u64)(((struct ppa_addr *)(&__entry->ppa))->m.chk),
> +			show_chunk_erase_state((int)__entry->state))
> +
> +);
>   
>   TRACE_EVENT(pblk_chunk_state,
>   
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index ae705fb52cf7..f0fcd963ab3a 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -79,6 +79,12 @@ enum {
>   	PBLK_BLK_ST_CLOSED =	0x2,
>   };
>   
> +enum {
> +	PBLK_CHUNK_RESET_START,
> +	PBLK_CHUNK_RESET_DONE,
> +	PBLK_CHUNK_RESET_FAILED,
> +};
> +
>   struct pblk_sec_meta {
>   	u64 reserved;
>   	__le64 lba;
> 

Thanks. Applied for 4.20 (replaced the previous one)
