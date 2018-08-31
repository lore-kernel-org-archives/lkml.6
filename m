Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCF1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7985B2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="KM6XpGdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7985B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbeHaSZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:25:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33302 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbeHaSZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:25:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id s12-v6so10250040ljj.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 07:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oUIMj6OwB7c8gll4ZrvN2I3ijica9AMtPikiJbvBOg4=;
        b=KM6XpGdzmL59cHyb9+ZxxemZeAuQLwQ4mL5GYA0luUwOvPTZCGrvNpXQGYPWXKNOtT
         rUWiE+AQH8DKk8R4OZNEEZNlyHRiGmpf7tfWJfS5aX67Md4OJEWGckE5oTgOQkR7vS8D
         YaAM+Bpes304iqDhKydiWQbIgAES5kSRZZfWcmSPb2HcNhTFmafwe7rQ0KrGvzT7+Hws
         rXwBSTojvy6AJpRfSnEhmhp4W1WpStT4jr4cudtRbswKYA8wXAW9mgRa2hamwMo56n9N
         FDw71XGnY63a76sQuLDYsUm9Enich1FF/98MTZCb5Qlv11qyMxXXjOnLE74JDsDiCy2H
         wQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oUIMj6OwB7c8gll4ZrvN2I3ijica9AMtPikiJbvBOg4=;
        b=fXx3jEjq14lPpNJ3zOZnkn5skdnBBNkBH8fO3ACwm+v1lrl00IYmHlHA9LzORcBkvZ
         oZ2DI5dWLJkG4/ObKQf28xDCHb9xPPlyae07UYpHoxe092NfpGNV9pG0ttHRlQcuNzFg
         suFu6MvW/bOzC4Gtta66Ii2h9xHL7mQm2EiL6HQVyMzXpPCb4EV12GpJWaRszzUg1hFN
         InXbrxp/tymK2g2ff27d0yU28q1vqY18P1Ls2iy2kcmQ1qTSmp5PgR1Upef2W4AmWHAS
         qksCkGY4++wN2ih/vL3op+R+CVVSNgOG8V7/ttjiPq0FFZB6lQIr5tupFHejt/EN1nUc
         WKKA==
X-Gm-Message-State: APzg51BNnXqkSrO9Ewki1wx++sIy4d2CXyy+qF94xdVpzjZFdxNoHuTv
        kjTPKgJdY8Zbdp394yPFZiJfJg==
X-Google-Smtp-Source: ANB0VdaEtThru2rtvY+rV5moOmE/6sfO7/jPo55ud8HXdaluFGHJrCxAfmPINsZZEpzTt3Hm0DOcVQ==
X-Received: by 2002:a2e:9dc7:: with SMTP id x7-v6mr10438813ljj.142.1535725095205;
        Fri, 31 Aug 2018 07:18:15 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id q16-v6sm1782318ljj.68.2018.08.31.07.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 07:18:14 -0700 (PDT)
Subject: Re: [PATCH V2] lightnvm: pblk: fix mapping issue on failed writes
To:     hans.ml.holmberg@owltronix.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
References: <1535709570-8923-1-git-send-email-hans.ml.holmberg@owltronix.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <70ce6061-61f0-9a14-7b70-59d0ad2bfa43@lightnvm.io>
Date:   Fri, 31 Aug 2018 16:18:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1535709570-8923-1-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018 11:59 AM, Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> On 1.2-devices, the mapping-out of remaning sectors in the
> failed-write's block can result in an infinite loop,
> stalling the write pipeline, fix this.
> 
> Fixes: 6a3abf5beef6 ("lightnvm: pblk: rework write error recovery path")
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> 
> Changes in V2:
> 	Moved the helper function pblk_next_ppa_in_blk to lightnvm core
> 	Renamed variable done->last in the helper function
> 	
> 
>   drivers/lightnvm/pblk-write.c | 10 +---------
>   include/linux/lightnvm.h      | 34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
> index 5e6df65d392c..922506d2d0a6 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -125,15 +125,7 @@ static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
>   		if (!test_and_set_bit(paddr, line->invalid_bitmap))
>   			le32_add_cpu(line->vsc, -1);
>   
> -		if (geo->version == NVM_OCSSD_SPEC_12) {
> -			map_ppa.ppa++;
> -			if (map_ppa.g.pg == geo->num_pg)
> -				done = 1;
> -		} else {
> -			map_ppa.m.sec++;
> -			if (map_ppa.m.sec == geo->clba)
> -				done = 1;
> -		}
> +		done = nvm_next_ppa_in_blk(geo, &map_ppa);
>   	}
>   
>   	line->w_err_gc->has_write_err = 1;
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 09f65c6c6676..2a6cbfe1d1b4 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -593,6 +593,40 @@ static inline u32 nvm_ppa64_to_ppa32(struct nvm_dev *dev,
>   	return ppa32;
>   }
>   
> +static inline int nvm_next_ppa_in_blk(struct nvm_geo *geo, struct ppa_addr *ppa)

You can pass nvm_tgt_dev here. Then the two unfoldings in 
pblk_map_remaining are not needed.

The naming sounds very 1.2ish, how about nvm_get_next_lba_in_chk?

> +{
> +	int last = 0;
> +
> +	if (geo->version == NVM_OCSSD_SPEC_12) {
> +		int sec = ppa->g.sec;
> +
> +		sec++;
> +		if (sec == geo->ws_min) {
> +			int pg = ppa->g.pg;
> +
> +			sec = 0;
> +			pg++;
> +			if (pg == geo->num_pg) {
> +				int pl = ppa->g.pl;
> +
> +				pg = 0;
> +				pl++;
> +				if (pl == geo->num_pln)
> +					last = 1;
> +
> +				ppa->g.pl = pl;
> +			}
> +			ppa->g.pg = pg;
> +		}
> +		ppa->g.sec = sec;
> +	} else {
> +		ppa->m.sec++;
> +		if (ppa->m.sec == geo->clba)
> +			last = 1;
> +	}
> +
> +	return last;
> +}
>   
>   typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
>   typedef sector_t (nvm_tgt_capacity_fn)(void *);
> 

