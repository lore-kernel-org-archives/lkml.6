Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B06AC282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E413121872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="vNZKc78m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfAXSSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:18:25 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42096 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfAXSSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:18:24 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so5007528lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 10:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mLkJF++EN+xLnkc1hwmRvOspw9pLqtnvWZad8y3Oyo0=;
        b=vNZKc78m0VMDBggImgv0dc0DDZWKtWkm3hbyjtRKkN5E71FcqgRhDAYXA7TO2WJByr
         5vq2XcOJNN536mWPmEQKzv/vK9R660DPnCS79qFk+9WYz+qA6bThj13fKy7PYFqKfJ2W
         5Ti5H3/hk09dkUViHXv2/dMg1LAn35aYjsymkbOY8GON5X3CFmEsxecdFdswHLD6vwCG
         w/akSfjPcnXeXVI+vy2BK5aClU0l77zg+KYAGA1yn9Q9lAHeMvnuupMxtrFu3awDXF+K
         gwx60bB0rbGiXdoVsUF2AboIUXgGVDKlNOBhLDXG1laGLXBnKW9/LhUF4xTVfvCInHXy
         t9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mLkJF++EN+xLnkc1hwmRvOspw9pLqtnvWZad8y3Oyo0=;
        b=aODTJrJIxq3JPdJ2aa1uHKxJ65yuS0yueFYch63HT5xtKep07p409aGg6SG1VFtWur
         eBmBtXBJHVRPowExKqmPgZkv9m0Oz/WnzKmVNDTDIZaBH+mlpAZvS/26H/bXzUDjV8+w
         s67IdRy0i8f0VRJRr6yY70ZvYiPCL1iGRtLntR6fGeQWWdKXxj4i/DPlqu4UPu+Lldsp
         vHe71sKeiiUNJDa6CR7h05saRJPFM+oBfzLtIBkN3udBNuRmsB5sNILSxVnxXwa9cDnC
         3srFYgwWqUbLhdBDGvGTA7S2I5RY7JG9kkta3tRYsUYVE110U9Q+BCfLMIzZDEgXktz+
         kg5w==
X-Gm-Message-State: AJcUukeU456K62Yr7IoTiOEIJ/P2jT+3qrViZxqXZka5+mqaey0wvKn2
        or+OHb6sTIXYrjlKa7M+AobnGmkKnc8=
X-Google-Smtp-Source: ALg8bN5UyHI6AJTjrSl4uYKt8EV960okP3pDTKviiZaT5gG1znv3rrPmowPR0Dfr9aV6Zn9VJ81tRQ==
X-Received: by 2002:a19:8c1b:: with SMTP id o27mr5904248lfd.90.1548353901389;
        Thu, 24 Jan 2019 10:18:21 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id z6sm1055185lfa.87.2019.01.24.10.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 10:18:20 -0800 (PST)
Subject: Re: [PATCH v2] lightnvm: pblk: Switch to use new generic UUID API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
References: <20190124143137.13880-1-andriy.shevchenko@linux.intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <1aa110f3-1fa8-a4b1-67eb-c11c3d2f71f1@lightnvm.io>
Date:   Thu, 24 Jan 2019 19:18:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124143137.13880-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/19 3:31 PM, Andy Shevchenko wrote:
> There are new types and helpers that are supposed to be used in new code.
> 
> As a preparation to get rid of legacy types and API functions do
> the conversion here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v2:
> - convert instance_uuid to guid_t and get rid of pblk_setup_uuid()
> - fix subject line to show subsystem
> 
>   drivers/lightnvm/pblk-core.c     |  4 ++--
>   drivers/lightnvm/pblk-init.c     |  2 +-
>   drivers/lightnvm/pblk-recovery.c |  8 +++++---
>   drivers/lightnvm/pblk.h          | 10 +---------
>   4 files changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 1ff165351180..189339965957 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1065,7 +1065,7 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
>   	bitmap_set(line->lun_bitmap, 0, lm->lun_bitmap_len);
>   
>   	smeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
> -	memcpy(smeta_buf->header.uuid, pblk->instance_uuid, 16);
> +	guid_copy((guid_t *)&smeta_buf->header.uuid, &pblk->instance_uuid);
>   	smeta_buf->header.id = cpu_to_le32(line->id);
>   	smeta_buf->header.type = cpu_to_le16(line->type);
>   	smeta_buf->header.version_major = SMETA_VERSION_MAJOR;
> @@ -1874,7 +1874,7 @@ void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
>   
>   	if (le32_to_cpu(emeta_buf->header.identifier) != PBLK_MAGIC) {
>   		emeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
> -		memcpy(emeta_buf->header.uuid, pblk->instance_uuid, 16);
> +		guid_copy((guid_t *)&emeta_buf->header.uuid, &pblk->instance_uuid);
>   		emeta_buf->header.id = cpu_to_le32(line->id);
>   		emeta_buf->header.type = cpu_to_le16(line->type);
>   		emeta_buf->header.version_major = EMETA_VERSION_MAJOR;
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index f9a3e47b6a93..5768333d103f 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -130,7 +130,7 @@ static int pblk_l2p_recover(struct pblk *pblk, bool factory_init)
>   	struct pblk_line *line = NULL;
>   
>   	if (factory_init) {
> -		pblk_setup_uuid(pblk);
> +		guid_gen(&pblk->instance_uuid);
>   	} else {
>   		line = pblk_recov_l2p(pblk);
>   		if (IS_ERR(line)) {
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 5ee20da7bdb3..6761d2afa4d0 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -703,11 +703,13 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
>   
>   		/* The first valid instance uuid is used for initialization */
>   		if (!valid_uuid) {
> -			memcpy(pblk->instance_uuid, smeta_buf->header.uuid, 16);
> +			guid_copy(&pblk->instance_uuid,
> +				  (guid_t *)&smeta_buf->header.uuid);
>   			valid_uuid = 1;
>   		}
>   
> -		if (memcmp(pblk->instance_uuid, smeta_buf->header.uuid, 16)) {
> +		if (!guid_equal(&pblk->instance_uuid,
> +				(guid_t *)&smeta_buf->header.uuid)) {
>   			pblk_debug(pblk, "ignore line %u due to uuid mismatch\n",
>   					i);
>   			continue;
> @@ -737,7 +739,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
>   	}
>   
>   	if (!found_lines) {
> -		pblk_setup_uuid(pblk);
> +		guid_gen(&pblk->instance_uuid);
>   
>   		spin_lock(&l_mg->free_lock);
>   		WARN_ON_ONCE(!test_and_clear_bit(meta_line,
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 85e38ed62f85..12bf02df4204 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -646,7 +646,7 @@ struct pblk {
>   
>   	int sec_per_write;
>   
> -	unsigned char instance_uuid[16];
> +	guid_t instance_uuid;
>   
>   	/* Persistent write amplification counters, 4kb sector I/Os */
>   	atomic64_t user_wa;		/* Sectors written by user */
> @@ -1360,14 +1360,6 @@ static inline unsigned int pblk_get_secs(struct bio *bio)
>   	return  bio->bi_iter.bi_size / PBLK_EXPOSED_PAGE_SIZE;
>   }
>   
> -static inline void pblk_setup_uuid(struct pblk *pblk)
> -{
> -	uuid_le uuid;
> -
> -	uuid_le_gen(&uuid);
> -	memcpy(pblk->instance_uuid, uuid.b, 16);
> -}
> -
>   static inline char *pblk_disk_name(struct pblk *pblk)
>   {
>   	struct gendisk *disk = pblk->disk;
> 

Thanks Andy. I've applied it for 5.1.
