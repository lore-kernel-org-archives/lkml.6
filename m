Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7570EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FA1214C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="dJfj7N3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19FA1214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeHUPJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:09:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45362 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbeHUPJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:09:59 -0400
Received: by mail-lf1-f66.google.com with SMTP id r4-v6so6308936lff.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 04:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XjrtxT2GaC2+0mPm5wq/embgzLx+5IYB4bO29cWFRl0=;
        b=dJfj7N3oOtbhm+Nrym7sWVuQnUvub/w4u9hwfEwNzzh6PXGpfuYCn9tmzPWpSTOU7z
         GqAfAAUwlU0RPS/YjZS5fi1NM21yEXtjEsbk71MqvcWn28ALInlmqa7afil51SWF44z7
         VnSvJ4DXUWLQ2qK9AqQgCcXTYzFpoiFnf3JdC5VBmhPSZIojhEzCDnZIPUB7M7KZnHp5
         UJXKb7DlkCacbGR+COW89+srZgoJFrQ/4msvvVMH58wLVqjynEjiiB1Ov38plkcH0xcl
         5JQbxxXsY1yjmf1M+Y1eI2g3fbd9RbfK2/lBwRYATZGZk9WjsueehZVggHlAeipHXGYh
         1Q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XjrtxT2GaC2+0mPm5wq/embgzLx+5IYB4bO29cWFRl0=;
        b=ocwvhT5d06UkeGTWi8DajfP0JTHg5ZRL8rlPOAOP2VJfc9JayE42/DPh/oagW6E7gU
         Aj36YWm+bAPM+bQBFvDGHjTLulax0n7LE8wDGNYRsDbZ82b/23T6T5ZnJwMFPU81FXnv
         2F/dlWCR3sNsjIyNqz5oz7DLqE6vefol0NpUglLIRSAO9Mn8rmhMeoNeW+gZG181rOOo
         fVl6bjIPvHmVpXvk5VYi8hfoQmaw5KK4RGd3iCTGW1sOrHjWG35pMqw/EktUYdmuTfyl
         G1au3Nkc5/OcxjYmTXWYV4uaGnMzWdJj+j/Tb0CQKKy3/DzCPDqq2XKgW+1SG/cpdJE0
         vRvQ==
X-Gm-Message-State: AOUpUlGg8UP5i1iGfFIFVNsj8Z5Y052FZmJXexdgIqlJoHv4/JFBiAeC
        FXILGYaElLrf8EGUeYn/9/I63qU6LtA=
X-Google-Smtp-Source: AA+uWPz2Ijybo+E7C0KtU+7eXfHkoBioqoN6EDf/CzR5EMFnIpvfyWADbRE/MceFNl3WbPZ7RJlRvQ==
X-Received: by 2002:a19:5353:: with SMTP id h80-v6mr17970215lfb.9.1534852206086;
        Tue, 21 Aug 2018 04:50:06 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id 6-v6sm2310088lfv.36.2018.08.21.04.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 04:50:05 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: move bad block and chunk state logic to core
To:     javier@cnexlabs.com
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180817111442.15827-1-mb@lightnvm.io>
 <7189DEC2-B080-4ADB-85B6-0FCED1796FAE@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <ca18185d-5025-b307-a4bb-5381c4d8458e@lightnvm.io>
Date:   Tue, 21 Aug 2018 13:50:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <7189DEC2-B080-4ADB-85B6-0FCED1796FAE@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/2018 02:13 PM, Javier Gonzalez wrote:
>> On 17 Aug 2018, at 13.14, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> pblk implements two data paths for recovery line state. One for 1.2
>> and another for 2.0, instead of having pblk implement these, combine
>> them in the core to reduce complexity and make available to other
>> targets.
>>
>> The new interface will adhere to the 2.0 chunk definition,
>> including managing open chunks with an active write pointer. To provide
>> this interface, a 1.2 device recovers the state of the chunks by
>> manually detecting if a chunk is either free/open/close/offline, and if
>> open, scanning the flash pages sequentially to find the next writeable
>> page. This process takes on average ~10 seconds on a device with 64 dies,
>> 1024 blocks and 60us read access time. The process can be parallelized
>> but is left out for maintenance simplicity, as the 1.2 specification is
>> deprecated. For 2.0 devices, the logic is maintained internally in the
>> drive and retrieved through the 2.0 interface.
> 
> A couple of things from closer review.
> 
>>
>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>> ---
>> drivers/lightnvm/core.c      | 310 +++++++++++++++++++++++++++++++++++--------
>> drivers/lightnvm/pblk-core.c |   6 +-
>> drivers/lightnvm/pblk-init.c | 116 +---------------
>> drivers/lightnvm/pblk.h      |   2 +-
>> drivers/nvme/host/lightnvm.c |   4 +-
>> include/linux/lightnvm.h     |  15 +--
>> 6 files changed, 266 insertions(+), 187 deletions(-)
>>
>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> index 964352720a03..003fc073f496 100644
>> --- a/drivers/lightnvm/core.c
>> +++ b/drivers/lightnvm/core.c
>> @@ -717,46 +717,6 @@ static void nvm_free_rqd_ppalist(struct nvm_tgt_dev *tgt_dev,
>> 	nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, rqd->dma_ppa_list);
>> }
>>
>> -int nvm_get_chunk_meta(struct nvm_tgt_dev *tgt_dev, struct nvm_chk_meta *meta,
>> -		struct ppa_addr ppa, int nchks)
>> -{
>> -	struct nvm_dev *dev = tgt_dev->parent;
>> -
>> -	nvm_ppa_tgt_to_dev(tgt_dev, &ppa, 1);
>> -
>> -	return dev->ops->get_chk_meta(tgt_dev->parent, meta,
>> -						(sector_t)ppa.ppa, nchks);
>> -}
>> -EXPORT_SYMBOL(nvm_get_chunk_meta);
>> -
>> -int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
>> -		       int nr_ppas, int type)
>> -{
>> -	struct nvm_dev *dev = tgt_dev->parent;
>> -	struct nvm_rq rqd;
>> -	int ret;
>> -
>> -	if (nr_ppas > NVM_MAX_VLBA) {
>> -		pr_err("nvm: unable to update all blocks atomically\n");
>> -		return -EINVAL;
>> -	}
>> -
>> -	memset(&rqd, 0, sizeof(struct nvm_rq));
>> -
>> -	nvm_set_rqd_ppalist(tgt_dev, &rqd, ppas, nr_ppas);
>> -	nvm_rq_tgt_to_dev(tgt_dev, &rqd);
>> -
>> -	ret = dev->ops->set_bb_tbl(dev, &rqd.ppa_addr, rqd.nr_ppas, type);
>> -	nvm_free_rqd_ppalist(tgt_dev, &rqd);
>> -	if (ret) {
>> -		pr_err("nvm: failed bb mark\n");
>> -		return -EINVAL;
>> -	}
>> -
>> -	return 0;
>> -}
>> -EXPORT_SYMBOL(nvm_set_tgt_bb_tbl);
>> -
>> static int nvm_set_flags(struct nvm_geo *geo, struct nvm_rq *rqd)
>> {
>> 	int flags = 0;
>> @@ -830,27 +790,159 @@ void nvm_end_io(struct nvm_rq *rqd)
>> }
>> EXPORT_SYMBOL(nvm_end_io);
>>
>> +static int nvm_submit_io_sync_raw(struct nvm_dev *dev, struct nvm_rq *rqd)
>> +{
>> +	if (!dev->ops->submit_io_sync)
>> +		return -ENODEV;
>> +
>> +	rqd->flags = nvm_set_flags(&dev->geo, rqd);
>> +
>> +	return dev->ops->submit_io_sync(dev, rqd);
>> +}
>> +
>> +static int nvm_bb_chunk_sense(struct nvm_dev *dev, struct ppa_addr ppa)
>> +{
>> +	struct nvm_rq rqd = { NULL };
>> +	struct bio bio;
>> +	struct bio_vec bio_vec;
>> +	struct page *page;
>> +	int ret;
>> +
>> +	page = alloc_page(GFP_KERNEL);
>> +	if (!page)
>> +		return -ENOMEM;
>> +
>> +	bio_init(&bio, &bio_vec, 1);
>> +	bio_add_page(&bio, page, PAGE_SIZE, 0);
>> +	bio_set_op_attrs(&bio, REQ_OP_READ, 0);
>> +
>> +	rqd.bio = &bio;
>> +	rqd.opcode = NVM_OP_PREAD;
>> +	rqd.is_seq = 1;
>> +	rqd.nr_ppas = 1;
>> +	rqd.ppa_addr = generic_to_dev_addr(dev, ppa);
>> +
>> +	ret = nvm_submit_io_sync_raw(dev, &rqd);
>> +	if (ret)
>> +		return ret;
>> +
>> +	__free_page(page);
>> +
>> +	return rqd.error;
>> +}
>> +
>> /*
>> - * folds a bad block list from its plane representation to its virtual
>> - * block representation. The fold is done in place and reduced size is
>> - * returned.
>> + * Scans a 1.2 chunk first and last page to determine if its state.
>> + * If the chunk is found to be open, also scan it to update the write
>> + * pointer.
>> + */
>> +static int nvm_bb_scan_chunk(struct nvm_dev *dev, struct ppa_addr ppa,
>> +			     struct nvm_chk_meta *meta)
> 
> Keeping some name consistency would help nvm_bb_chunk_*
> 
>> [...]
> 
>> +
>> +static int nvm_get_bb_meta(struct nvm_dev *dev, sector_t slba,
>> +			   int nchks, struct nvm_chk_meta *meta)
>> +{
>> +	struct nvm_geo *geo = &dev->geo;
>> +	struct ppa_addr ppa;
>> +	u8 *blks;
>> +	int ch, lun, nr_blks;
>> +	int ret;
>> +
>> +	ppa.ppa = slba;
>> +	ppa = dev_to_generic_addr(dev, ppa);
>> +
>> +	if (ppa.g.blk != 0)
>> +		return -EINVAL;
>> +
>> +	if ((nchks % geo->num_chk) != 0)
>> +		return -EINVAL;
>> +
>> +	nr_blks = geo->num_chk * geo->pln_mode;
>> +
>> +	blks = kmalloc(nr_blks, GFP_KERNEL);
>> +	if (!blks)
>> +		return -ENOMEM;
>> +
>> +	for (ch = ppa.g.ch; ch < geo->num_ch; ch++) {
>> +		for (lun = ppa.g.lun; lun < geo->num_lun; lun++) {
>> +			struct ppa_addr ppa_gen, ppa_dev;
>> +
>> +			if (!nchks)
>> +				goto out;
> 
> You should free blks here too.
> 
>> +
>> +			ppa_gen.ppa = 0;
>> +			ppa_gen.a.ch = ch;
>> +			ppa_gen.a.lun = lun;
>> +			ppa_dev = generic_to_dev_addr(dev, ppa_gen);
>> +
>> +			ret = dev->ops->get_bb_tbl(dev, ppa_dev, blks);
>> +			if (ret)
>> +				goto err;
>> +
>> +			ret = nvm_bb_to_chunk(dev, ppa_gen, blks, nr_blks,
>> +									meta);
>> +			if (ret)
>> +				goto err;
>> +
>> +			meta += geo->num_chk;
>> +			nchks -= geo->num_chk;
>> +		}
>> +	}
>> +out:
>> +	return 0;
>> +err:
>> +	kfree(blks);
>> +	return ret;
>> }
>> -EXPORT_SYMBOL(nvm_bb_tbl_fold);
>>
>> -int nvm_get_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr ppa,
>> -		       u8 *blks)
>> [...]
> 
> 

Thanks, I've merged it into the patch.
