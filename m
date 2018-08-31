Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC409C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B57620661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="IPuXCfTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B57620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbeHaSao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:30:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46772 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbeHaSao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:30:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id e23-v6so10101219lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 07:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MUyWnXjKODL9FQj9z5/zKElvdxggQAXUvsiQIX6jJI8=;
        b=IPuXCfTFgvk4EhnNMAqYvtyd20gxAikRd+5iQW54rwFJRK3NY3sPMZ60S4pG7tiJ5F
         f/j2EcLcBG6UelSYkUw3oWchLLXo6IldZGvAxDb8yTkLUJcWrEvpxIa30rK5n853/Ik8
         J68F5xLyi9djkzGL33bG9U1eGzMtwl6k5kLADpo5rz17tm8CwMRwwtctO/jmGbvUtryY
         0Zud8DxDa1RLf6ALlnOzdbXOq154x5x+PT7tMcWhUSe7JJIinvnc7rzaOPvCV2IftdbM
         68EYcuBSAoPptWcZLY03+nIYEwlRNYGX6r+K2l27SId3HeHfV/5UsRnHk5s++JQ/ukA+
         CIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MUyWnXjKODL9FQj9z5/zKElvdxggQAXUvsiQIX6jJI8=;
        b=qDpb145/8wkZVYy4r8e8c5R6XoM+HB7B6/UPvpMIS5E2Auvbi0Pgh/jxaDtFreAkV7
         hTJZm8dRGf3bH1tDCTI0Rz1olUtC8RXlNcGY02LYPDCb3v/DBc1K3eTk/MqOgpu+UERg
         BpU4vvCoHr6/4KLSSkfFG3sCHAiBykZ/FamP8VRhhanyEU6TsrhvEJWrgZgJU1kWn+es
         y/28XT48REancAP8Qwgd2R+y0knmDfFaJgGiTiXIwYS/L5KfcXOLdkY61sszGpsCikrE
         9w+40qoHpR7WRlYR1Dm+oSW+NQtaKDV58FFBpnIu4RhuxfrnVT0nAQhIFhbIDcMMspBZ
         CI3w==
X-Gm-Message-State: APzg51CBkqrjDD5LmIYm7dDMTKDrXdHtAaaS6F3hkQzJEJ0EAz3AoU5L
        nyAB61lMKULpYsW1BkMHgun+ERs1uJo=
X-Google-Smtp-Source: ANB0VdYo+GLz0/KBjSuNNmHIR9Mp1BxJJpfIskZQF5rkjdb8SE4cBKOna26XcoELpTyqAj1KfQL7Ug==
X-Received: by 2002:a19:14e6:: with SMTP id 99-v6mr10550193lfu.26.1535725378189;
        Fri, 31 Aug 2018 07:22:58 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id h26-v6sm1277241ljg.36.2018.08.31.07.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 07:22:57 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: remove debug from pblk_[down/up]_page
To:     javier@cnexlabs.com
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180829140832.29341-1-mb@lightnvm.io>
 <AAA74C68-4C22-48C8-B138-1C8EE72A875C@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <e0076c19-7e7e-b51a-1f25-25250ed88b5c@lightnvm.io>
Date:   Fri, 31 Aug 2018 16:22:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <AAA74C68-4C22-48C8-B138-1C8EE72A875C@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018 02:11 PM, Javier Gonzalez wrote:
>> On 29 Aug 2018, at 16.08, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> Remove the debug only iteration within __pblk_down_page, which
>> then allows us to reduce the number of arguments down to pblk and
>> the parallel unit from the functions that calls it. Simplifying the
>> callers logic considerably.
>>
>> Also, rename the functions pblk_[down/up]_page to pblk_[down/up]_pu,
>> to communicate that it takes a lock on the parallel unit.
>>
>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>> ---
>> drivers/lightnvm/pblk-core.c     | 34 +++++++++-------------------------
>> drivers/lightnvm/pblk-map.c      |  2 +-
>> drivers/lightnvm/pblk-recovery.c |  6 +++---
>> drivers/lightnvm/pblk-write.c    |  6 +++---
>> drivers/lightnvm/pblk.h          |  6 +++---
>> 5 files changed, 19 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>> index bb1a7cc24cbb..08df6bcd2f81 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -1861,8 +1861,7 @@ void pblk_gen_run_ws(struct pblk *pblk, struct pblk_line *line, void *priv,
>> 	queue_work(wq, &line_ws->ws);
>> }
>>
>> -static void __pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list,
>> -			     int nr_ppas, int pos)
>> +static void __pblk_down_pu(struct pblk *pblk, int pos)
>> {
>> 	struct pblk_lun *rlun = &pblk->luns[pos];
>> 	int ret;
>> @@ -1871,13 +1870,6 @@ static void __pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list,
>> 	 * Only send one inflight I/O per LUN. Since we map at a page
>> 	 * granurality, all ppas in the I/O will map to the same LUN
>> 	 */
>> -#ifdef CONFIG_NVM_PBLK_DEBUG
>> -	int i;
>> -
>> -	for (i = 1; i < nr_ppas; i++)
>> -		WARN_ON(ppa_list[0].a.lun != ppa_list[i].a.lun ||
>> -				ppa_list[0].a.ch != ppa_list[i].a.ch);
>> -#endif
>>
>> 	ret = down_timeout(&rlun->wr_sem, msecs_to_jiffies(30000));
>> 	if (ret == -ETIME || ret == -EINTR)
>> @@ -1885,21 +1877,21 @@ static void __pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list,
>> 				-ret);
>> }
>>
>> -void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas)
>> +void pblk_down_pu(struct pblk *pblk, struct ppa_addr ppa)
>> {
>> 	struct nvm_tgt_dev *dev = pblk->dev;
>> 	struct nvm_geo *geo = &dev->geo;
>> -	int pos = pblk_ppa_to_pos(geo, ppa_list[0]);
>> +	int pos = pblk_ppa_to_pos(geo, ppa);
>>
>> -	__pblk_down_page(pblk, ppa_list, nr_ppas, pos);
>> +	__pblk_down_pu(pblk, pos);
>> }
>>
>> -void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
>> +void pblk_down_rq(struct pblk *pblk, struct ppa_addr ppa,
>> 		  unsigned long *lun_bitmap)
>> {
>> 	struct nvm_tgt_dev *dev = pblk->dev;
>> 	struct nvm_geo *geo = &dev->geo;
>> -	int pos = pblk_ppa_to_pos(geo, ppa_list[0]);
>> +	int pos = pblk_ppa_to_pos(geo, ppa);
>>
>> 	/* If the LUN has been locked for this same request, do no attempt to
>> 	 * lock it again
>> @@ -1907,23 +1899,15 @@ void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
>> 	if (test_and_set_bit(pos, lun_bitmap))
>> 		return;
>>
>> -	__pblk_down_page(pblk, ppa_list, nr_ppas, pos);
>> +	__pblk_down_pu(pblk, pos);
>> }
>>
>> -void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas)
>> +void pblk_up_pu(struct pblk *pblk, struct ppa_addr ppa)
>> {
>> 	struct nvm_tgt_dev *dev = pblk->dev;
>> 	struct nvm_geo *geo = &dev->geo;
>> 	struct pblk_lun *rlun;
>> -	int pos = pblk_ppa_to_pos(geo, ppa_list[0]);
>> -
>> -#ifdef CONFIG_NVM_PBLK_DEBUG
>> -	int i;
>> -
>> -	for (i = 1; i < nr_ppas; i++)
>> -		WARN_ON(ppa_list[0].a.lun != ppa_list[i].a.lun ||
>> -				ppa_list[0].a.ch != ppa_list[i].a.ch);
>> -#endif
>> +	int pos = pblk_ppa_to_pos(geo, ppa);
>>
>> 	rlun = &pblk->luns[pos];
>> 	up(&rlun->wr_sem);
>> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
>> index dc0efb852475..ff677ca6e4e1 100644
>> --- a/drivers/lightnvm/pblk-map.c
>> +++ b/drivers/lightnvm/pblk-map.c
>> @@ -79,7 +79,7 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
>> 		}
>> 	}
>>
>> -	pblk_down_rq(pblk, ppa_list, nr_secs, lun_bitmap);
>> +	pblk_down_rq(pblk, ppa_list[0], lun_bitmap);
>> 	return 0;
>> }
>>
>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
>> index eea901d7cebc..df624d504d24 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -227,7 +227,7 @@ static void pblk_end_io_recov(struct nvm_rq *rqd)
>> 	struct pblk_pad_rq *pad_rq = rqd->private;
>> 	struct pblk *pblk = pad_rq->pblk;
>>
>> -	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
>> +	pblk_up_pu(pblk, ppa_list[0]);
>>
>> 	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
>>
>> @@ -339,12 +339,12 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
>> 	}
>>
>> 	kref_get(&pad_rq->ref);
>> -	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
>> +	pblk_down_pu(pblk, rqd->ppa_list[0]);
>>
>> 	ret = pblk_submit_io(pblk, rqd);
>> 	if (ret) {
>> 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
>> -		pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
>> +		pblk_up_pu(pblk, rqd->ppa_list[0]);
>> 		goto fail_free_bio;
>> 	}
>>
>> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
>> index cd579b440b56..55d198edd70a 100644
>> --- a/drivers/lightnvm/pblk-write.c
>> +++ b/drivers/lightnvm/pblk-write.c
>> @@ -270,7 +270,7 @@ static void pblk_end_io_write_meta(struct nvm_rq *rqd)
>> 	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
>> 	int sync;
>>
>> -	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
>> +	pblk_up_pu(pblk, ppa_list[0]);
>>
>> 	if (rqd->error) {
>> 		pblk_log_write_err(pblk, rqd);
>> @@ -420,7 +420,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
>> 		list_del(&meta_line->list);
>> 	spin_unlock(&l_mg->close_lock);
>>
>> -	pblk_down_page(pblk, ppa_list, rqd->nr_ppas);
>> +	pblk_down_pu(pblk, ppa_list[0]);
>>
>> 	ret = pblk_submit_io(pblk, rqd);
>> 	if (ret) {
>> @@ -431,7 +431,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
>> 	return NVM_IO_OK;
>>
>> fail_rollback:
>> -	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
>> +	pblk_up_pu(pblk, ppa_list[0]);
>> 	spin_lock(&l_mg->close_lock);
>> 	pblk_dealloc_page(pblk, meta_line, rq_ppas);
>> 	list_add(&meta_line->list, &meta_line->list);
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index 2f61f4428fcb..390855375b1e 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -823,10 +823,10 @@ u64 pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int nr_secs);
>> u64 __pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int nr_secs);
>> int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
>> 		   unsigned long secs_to_flush);
>> -void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas);
>> -void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
>> +void pblk_up_pu(struct pblk *pblk, struct ppa_addr ppa);
>> +void pblk_down_rq(struct pblk *pblk, struct ppa_addr ppa,
>> 		  unsigned long *lun_bitmap);
>> -void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas);
>> +void pblk_down_pu(struct pblk *pblk, struct ppa_addr ppa);
>> void pblk_up_rq(struct pblk *pblk, unsigned long *lun_bitmap);
>> int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t flags,
>> 		       int nr_pages);
>> --
>> 2.11.0
> 
> 
> The patch looks good to me. The renaming to PU though is confusing. The
> underlying reason to take the semaphore is to avoid write pointer
> violations. At the moment, we only have an open line in pblk, which
> makes that the semaphore effectively protects a PU, but when we have
> several open lines this is no longer true.
> 

I don't understand this, how will it change when multiple lines are active?

My guess is that one has to keep track of the number of outstanding I/Os 
for each PU. Regarding naming, pblk_[down/up]_line doesn't quite cut it, 
and _page doesn't mean anything to me. Can we find a better name?

