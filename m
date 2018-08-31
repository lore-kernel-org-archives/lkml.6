Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31896C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B6D2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="eSv6Uade"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B6D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbeHaS06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:26:58 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40005 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbeHaS05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:26:57 -0400
Received: by mail-lf1-f67.google.com with SMTP id x26-v6so10119778lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 07:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JFv2UQ6Ppo/FdH/7K6R6GZQI/d7A1j9kO70RMsqcIoI=;
        b=eSv6UadeZHPuXEVpxEbDd7A+R5X5WyvKYvG7/LH9+PpnLYEAVeskFaPVraxoWaD8RJ
         5vjtHfNRmoKNtr6K1+Uv0kgwohcwK7jD27E1L3oTTH1knJ3IfFnw9NvYAiFKcOkJASlI
         HQdFImK1tydusXbfpdhd0WGaBTpOE8964qFKwMSLs/SPahE7+a6Awp9K7FvpYb7dSWWn
         4iznUIDHM41Xtf1b1HGqmlp7zrBzHBfQcm5SzzH3GFHIRNIgwLQcinNt3t3tC77GSlCe
         OeaXn3JAjeALpXQ34yC4QyV7tNuumycRKPkDfitPDXtG6FnbNOYADH8pxm4zPVpu2Eow
         EZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JFv2UQ6Ppo/FdH/7K6R6GZQI/d7A1j9kO70RMsqcIoI=;
        b=E8A2rWUlj/fft4prSiTYKF/4nTkjxm7IKzJHLerKV71xzUma7gwyCz0rkKobYpuQV4
         hsu0kp3z/qux/+GwJGyCQRaiKz9IMCAD8NTXGc4YTxwCLF/TIEeDEaYCwNZKzqF3QKOf
         vwazuN2W4Gemw6tjdRGX585qxOR2YGwsNALesTKW2w1PYFpSTuTOvCg7dQ5qbjbMO4h6
         Q9zp9Z4Tg5b5h/mNVdDNkO6zwGYSaQFU/7KuRdistog8Vly4FOFCUOkKkQOPfWLZqiaO
         03kiN481QJK6aBEF+rxJBNGVdSSPpMpJnuGl7160DpcOaVd4XbD2kzVj4OtfuwFrmqKo
         aQeA==
X-Gm-Message-State: APzg51CGnOKYnYNeHtzpNacJDpsyxO9kKfmZnn/OHJrW3HC/A97W8N67
        Y0UVnljVG2tasGQW3qVKnTRhPh2MGvM=
X-Google-Smtp-Source: ANB0Vdaa9mIpnSxebRSlbZqnZoojVE6Szcz72LZbYgPQJ7YoDrvk0+mfFlJUE9wNDzqv8wD6AWq+CA==
X-Received: by 2002:a19:655d:: with SMTP id c29-v6mr4261589lfj.138.1535725151434;
        Fri, 31 Aug 2018 07:19:11 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id c5-v6sm1878890lff.65.2018.08.31.07.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 07:19:10 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: move ppa transformations to core
To:     javier@cnexlabs.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535551926-4731-1-git-send-email-javier@cnexlabs.com>
 <e40fc6c5-3cc7-89bc-089f-0c9882324d32@lightnvm.io>
 <7CC06FE6-1678-4AC5-A249-893AF36A30E9@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <9856c21d-a790-623a-e3e7-d9af4135e98e@lightnvm.io>
Date:   Fri, 31 Aug 2018 16:19:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <7CC06FE6-1678-4AC5-A249-893AF36A30E9@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 10:27 PM, Javier Gonzalez wrote:
> 
>> On 29 Aug 2018, at 16.30, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 08/29/2018 04:12 PM, Javier González wrote:
>>> Continuing the effort of moving 1.2 and 2.0 specific code to core, move
>>> 64_to_32 and 32_to_64 ppa helpers from pblk to core.
>>> Signed-off-by: Javier González <javier@cnexlabs.com>
>>> ---
>>>   drivers/lightnvm/pblk.h  | 78 +++------------------------------------------
>>>   include/linux/lightnvm.h | 83 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 87 insertions(+), 74 deletions(-)
>>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>>> index f95fe75fef6e..88ff529290f8 100644
>>> --- a/drivers/lightnvm/pblk.h
>>> +++ b/drivers/lightnvm/pblk.h
>>> @@ -1086,86 +1086,16 @@ static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
>>>     static inline struct ppa_addr pblk_ppa32_to_ppa64(struct pblk *pblk, u32 ppa32)
>>>   {
>>> -	struct ppa_addr ppa64;
>>> +	struct nvm_tgt_dev *dev = pblk->dev;
>>>   -	ppa64.ppa = 0;
>>> -
>>> -	if (ppa32 == -1) {
>>> -		ppa64.ppa = ADDR_EMPTY;
>>> -	} else if (ppa32 & (1U << 31)) {
>>> -		ppa64.c.line = ppa32 & ((~0U) >> 1);
>>> -		ppa64.c.is_cached = 1;
>>> -	} else {
>>> -		struct nvm_tgt_dev *dev = pblk->dev;
>>> -		struct nvm_geo *geo = &dev->geo;
>>> -
>>> -		if (geo->version == NVM_OCSSD_SPEC_12) {
>>> -			struct nvm_addrf_12 *ppaf =
>>> -					(struct nvm_addrf_12 *)&pblk->addrf;
>>> -
>>> -			ppa64.g.ch = (ppa32 & ppaf->ch_mask) >>
>>> -							ppaf->ch_offset;
>>> -			ppa64.g.lun = (ppa32 & ppaf->lun_mask) >>
>>> -							ppaf->lun_offset;
>>> -			ppa64.g.blk = (ppa32 & ppaf->blk_mask) >>
>>> -							ppaf->blk_offset;
>>> -			ppa64.g.pg = (ppa32 & ppaf->pg_mask) >>
>>> -							ppaf->pg_offset;
>>> -			ppa64.g.pl = (ppa32 & ppaf->pln_mask) >>
>>> -							ppaf->pln_offset;
>>> -			ppa64.g.sec = (ppa32 & ppaf->sec_mask) >>
>>> -							ppaf->sec_offset;
>>> -		} else {
>>> -			struct nvm_addrf *lbaf = &pblk->addrf;
>>> -
>>> -			ppa64.m.grp = (ppa32 & lbaf->ch_mask) >>
>>> -							lbaf->ch_offset;
>>> -			ppa64.m.pu = (ppa32 & lbaf->lun_mask) >>
>>> -							lbaf->lun_offset;
>>> -			ppa64.m.chk = (ppa32 & lbaf->chk_mask) >>
>>> -							lbaf->chk_offset;
>>> -			ppa64.m.sec = (ppa32 & lbaf->sec_mask) >>
>>> -							lbaf->sec_offset;
>>> -		}
>>> -	}
>>> -
>>> -	return ppa64;
>>> +	return ppa32_to_ppa64(dev->parent, &pblk->addrf, ppa32);
>>>   }
>>>     static inline u32 pblk_ppa64_to_ppa32(struct pblk *pblk, struct ppa_addr ppa64)
>>>   {
>>> -	u32 ppa32 = 0;
>>> +	struct nvm_tgt_dev *dev = pblk->dev;
>>>   -	if (ppa64.ppa == ADDR_EMPTY) {
>>> -		ppa32 = ~0U;
>>> -	} else if (ppa64.c.is_cached) {
>>> -		ppa32 |= ppa64.c.line;
>>> -		ppa32 |= 1U << 31;
>>> -	} else {
>>> -		struct nvm_tgt_dev *dev = pblk->dev;
>>> -		struct nvm_geo *geo = &dev->geo;
>>> -
>>> -		if (geo->version == NVM_OCSSD_SPEC_12) {
>>> -			struct nvm_addrf_12 *ppaf =
>>> -					(struct nvm_addrf_12 *)&pblk->addrf;
>>> -
>>> -			ppa32 |= ppa64.g.ch << ppaf->ch_offset;
>>> -			ppa32 |= ppa64.g.lun << ppaf->lun_offset;
>>> -			ppa32 |= ppa64.g.blk << ppaf->blk_offset;
>>> -			ppa32 |= ppa64.g.pg << ppaf->pg_offset;
>>> -			ppa32 |= ppa64.g.pl << ppaf->pln_offset;
>>> -			ppa32 |= ppa64.g.sec << ppaf->sec_offset;
>>> -		} else {
>>> -			struct nvm_addrf *lbaf = &pblk->addrf;
>>> -
>>> -			ppa32 |= ppa64.m.grp << lbaf->ch_offset;
>>> -			ppa32 |= ppa64.m.pu << lbaf->lun_offset;
>>> -			ppa32 |= ppa64.m.chk << lbaf->chk_offset;
>>> -			ppa32 |= ppa64.m.sec << lbaf->sec_offset;
>>> -		}
>>> -	}
>>> -
>>> -	return ppa32;
>>> +	return ppa64_to_ppa32(dev->parent, &pblk->addrf, ppa64);
>>>   }
>>>     static inline struct ppa_addr pblk_trans_map_get(struct pblk *pblk,
>>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>>> index 77743a02ec0d..7107a8b84039 100644
>>> --- a/include/linux/lightnvm.h
>>> +++ b/include/linux/lightnvm.h
>>> @@ -506,6 +506,89 @@ static inline u64 dev_to_chunk_addr(struct nvm_dev *dev, void *addrf,
>>>   	return caddr;
>>>   }
>>>   +static inline struct ppa_addr ppa32_to_ppa64(struct nvm_dev *dev,
>>> +					     void *addrf, u32 ppa32)
>>> +{
>>> +	struct ppa_addr ppa64;
>>> +
>>> +	ppa64.ppa = 0;
>>> +
>>> +	if (ppa32 == -1) {
>>> +		ppa64.ppa = ADDR_EMPTY;
>>> +	} else if (ppa32 & (1U << 31)) {
>>> +		ppa64.c.line = ppa32 & ((~0U) >> 1);
>>> +		ppa64.c.is_cached = 1;
>>> +	} else {
>>> +		struct nvm_geo *geo = &dev->geo;
>>> +
>>> +		if (geo->version == NVM_OCSSD_SPEC_12) {
>>> +			struct nvm_addrf_12 *ppaf = addrf;
>>> +
>>> +			ppa64.g.ch = (ppa32 & ppaf->ch_mask) >>
>>> +							ppaf->ch_offset;
>>> +			ppa64.g.lun = (ppa32 & ppaf->lun_mask) >>
>>> +							ppaf->lun_offset;
>>> +			ppa64.g.blk = (ppa32 & ppaf->blk_mask) >>
>>> +							ppaf->blk_offset;
>>> +			ppa64.g.pg = (ppa32 & ppaf->pg_mask) >>
>>> +							ppaf->pg_offset;
>>> +			ppa64.g.pl = (ppa32 & ppaf->pln_mask) >>
>>> +							ppaf->pln_offset;
>>> +			ppa64.g.sec = (ppa32 & ppaf->sec_mask) >>
>>> +							ppaf->sec_offset;
>>> +		} else {
>>> +			struct nvm_addrf *lbaf = addrf;
>>> +
>>> +			ppa64.m.grp = (ppa32 & lbaf->ch_mask) >>
>>> +							lbaf->ch_offset;
>>> +			ppa64.m.pu = (ppa32 & lbaf->lun_mask) >>
>>> +							lbaf->lun_offset;
>>> +			ppa64.m.chk = (ppa32 & lbaf->chk_mask) >>
>>> +							lbaf->chk_offset;
>>> +			ppa64.m.sec = (ppa32 & lbaf->sec_mask) >>
>>> +							lbaf->sec_offset;
>>> +		}
>>> +	}
>>> +
>>> +	return ppa64;
>>> +}
>>> +
>>> +static inline u32 ppa64_to_ppa32(struct nvm_dev *dev,
>>> +				 void *addrf, struct ppa_addr ppa64)
>>> +{
>>> +	u32 ppa32 = 0;
>>> +
>>> +	if (ppa64.ppa == ADDR_EMPTY) {
>>> +		ppa32 = ~0U;
>>> +	} else if (ppa64.c.is_cached) {
>>> +		ppa32 |= ppa64.c.line;
>>> +		ppa32 |= 1U << 31;
>>> +	} else {
>>> +		struct nvm_geo *geo = &dev->geo;
>>> +
>>> +		if (geo->version == NVM_OCSSD_SPEC_12) {
>>> +			struct nvm_addrf_12 *ppaf = addrf;
>>> +
>>> +			ppa32 |= ppa64.g.ch << ppaf->ch_offset;
>>> +			ppa32 |= ppa64.g.lun << ppaf->lun_offset;
>>> +			ppa32 |= ppa64.g.blk << ppaf->blk_offset;
>>> +			ppa32 |= ppa64.g.pg << ppaf->pg_offset;
>>> +			ppa32 |= ppa64.g.pl << ppaf->pln_offset;
>>> +			ppa32 |= ppa64.g.sec << ppaf->sec_offset;
>>> +		} else {
>>> +			struct nvm_addrf *lbaf = addrf;
>>> +
>>> +			ppa32 |= ppa64.m.grp << lbaf->ch_offset;
>>> +			ppa32 |= ppa64.m.pu << lbaf->lun_offset;
>>> +			ppa32 |= ppa64.m.chk << lbaf->chk_offset;
>>> +			ppa32 |= ppa64.m.sec << lbaf->sec_offset;
>>> +		}
>>> +	}
>>> +
>>> +	return ppa32;
>>> +}
>>> +
>>> +
>>>   typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
>>>   typedef sector_t (nvm_tgt_capacity_fn)(void *);
>>>   typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *,
>>
>> Thanks. Applied for 4.20. I've updated the global ppa[32/64]_to_ppa[64/32] to prepend nvm_.
> 
> Cool, thanks. Should we do the same for the rest of the helpers dev_to_*?
> 

It's fine by me either way. At some point I'll properly do a larger 
cleanup to fix it all.
