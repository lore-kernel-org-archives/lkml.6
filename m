Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6157CC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF6D23F9D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="e6l/Jmyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF6D23F9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934676AbeF1IK0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:10:26 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40790 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934056AbeF1IKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:10:20 -0400
Received: by mail-lf0-f65.google.com with SMTP id q11-v6so3517179lfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 01:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YimzF2t7RRVhAbo+HVcMCR602d8ihwwXCU6YhnN+9Cw=;
        b=e6l/Jmytq4OiXgSmzNMDzjvpBVOqstS0WIhAHk4zbOzmVGo5eI+3Z/vru4P03Sz7kJ
         YjpvshOUJHcPMWvpe7sBy6sow6HuJU4LBJw+/1AQTUu9zkz3xHDJqWRpmziNRza92ELf
         1NkaEDc/qyK0r9HF1L0RvlNOh6VCQRSsfpxfqXIW0B/wC3qMbnecNH/l/9svNAsfPIP9
         Rc1PPQ6sFAUW3smpdBwM4iYL/FEg7vGUD3zQ27X/eGbwoIiY6SVwWrtWTl0HiL6PWeY2
         7zJ2Tan5ihrRLSp/VyiVXJ2K/PG/uFrCsEYUT7EgNUDT4fjJUYqk+c+SwbLmKsdOkByN
         RAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YimzF2t7RRVhAbo+HVcMCR602d8ihwwXCU6YhnN+9Cw=;
        b=LZV+yUjj0qTgFOvyUZ0Hh8J+E/exqtTdn+MwydDgZQUU/zUHcqIkoJ0g2NXbo03oTq
         oM9dnHRm0Dk+SSzJlYjSRLvw7uTOUmhxa05B0gtyyKd29peuXzrZuY1C6n8vXrvfbRaa
         XgD+wKjXMA2Fmb/AHG1/GkM0+IMhh3NTyyAoKUgRrMqtCW0hKE6uhr5sKtgto/zYve/Z
         10vaQKYqnm94QwjBGnA6pDIJP8GvXTYFA25eHiY883fBGfUzD3meMNe77yQb7cU4nmtP
         cZFY3nxAcBYRBgmWebvo8nhzV80x15+sFpd8A1spu5bVQpDL98asx/O1s40iaBIkldY3
         i05Q==
X-Gm-Message-State: APt69E3p78A9os8hzdFymxmluvtTpf1U0MuVPKHS3h2CuOeX+WVi25bG
        397PStBYkJlQpLmGVh+J7H7T7R47
X-Google-Smtp-Source: AAOMgpcrixSyfcm6UI044sRGgUQfDnvp215pHG9GHhkZU6FOdkTjQOXK9VofJfrh7GrbwPc30dBuEA==
X-Received: by 2002:a19:e955:: with SMTP id g82-v6mr6009641lfh.44.1530173418281;
        Thu, 28 Jun 2018 01:10:18 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id j22-v6sm1018106ljh.0.2018.06.28.01.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 01:10:17 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: fix read_bitmap for 32bit archs
To:     igor.j.konopko@intel.com
Cc:     marcin.dziegielewski@intel.com, javier@cnexlabs.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180627194206.30384-1-mb@lightnvm.io>
 <c46fb234-a985-02e8-2122-c85e54f97b39@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <259e585a-4d30-b270-1030-d3f9b0bf7e88@lightnvm.io>
Date:   Thu, 28 Jun 2018 10:10:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <c46fb234-a985-02e8-2122-c85e54f97b39@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/28/2018 12:18 AM, Igor Konopko wrote:
> 
> 
> On 27.06.2018 12:42, Matias Bjørling wrote:
>> If using pblk on a 32bit architecture, and there is a need to
>> perform a partial read, the partial read bitmap will only have
>> allocated 32 entries, where as 64 are needed.
>>
>> Make sure that the read_bitmap is initialized to 64bits on 32bit
>> architectures as well.
>>
>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>> ---
>>   drivers/lightnvm/pblk-read.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
>> index 6e93c489ce57..671635275d56 100644
>> --- a/drivers/lightnvm/pblk-read.c
>> +++ b/drivers/lightnvm/pblk-read.c
>> @@ -401,7 +401,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio 
>> *bio)
>>       struct pblk_g_ctx *r_ctx;
>>       struct nvm_rq *rqd;
>>       unsigned int bio_init_idx;
>> -    unsigned long read_bitmap; /* Max 64 ppas per request */
>> +    DECLARE_BITMAP(read_bitmap, 64); /* Max 64 ppas per request */
> 
> Probably it would be nicer to use NVM_MAX_VLBA define instead of 
> explicit 64.
> 
>>       int ret = NVM_IO_ERR;
>>       /* logic error: lba out-of-bounds. Ignore read request */
>> @@ -413,7 +413,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio 
>> *bio)
>>       generic_start_io_acct(q, READ, bio_sectors(bio), 
>> &pblk->disk->part0);
>> -    bitmap_zero(&read_bitmap, nr_secs);
>> +    bitmap_zero(read_bitmap, nr_secs);
>>       rqd = pblk_alloc_rqd(pblk, PBLK_READ);
>> @@ -444,19 +444,19 @@ int pblk_submit_read(struct pblk *pblk, struct 
>> bio *bio)
>>           rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
>>           rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
>> -        pblk_read_ppalist_rq(pblk, rqd, bio, blba, &read_bitmap);
>> +        pblk_read_ppalist_rq(pblk, rqd, bio, blba, read_bitmap 
>> >       } else {
>> -        pblk_read_rq(pblk, rqd, bio, blba, &read_bitmap);
>> +        pblk_read_rq(pblk, rqd, bio, blba, read_bitmap);
>>       }
>> -    if (bitmap_full(&read_bitmap, nr_secs)) {
>> +    if (bitmap_full(read_bitmap, nr_secs)) {
>>           atomic_inc(&pblk->inflight_io);
>>           __pblk_end_io_read(pblk, rqd, false);
>>           return NVM_IO_DONE;
>>       }
>>       /* All sectors are to be read from the device */
>> -    if (bitmap_empty(&read_bitmap, rqd->nr_ppas)) {
>> +    if (bitmap_empty(read_bitmap, rqd->nr_ppas)) {
>>           struct bio *int_bio = NULL;
>>           /* Clone read bio to deal with read errors internally */
>> @@ -480,7 +480,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio 
>> *bio)
>>       /* The read bio request could be partially filled by the write 
>> buffer,
>>        * but there are some holes that need to be read from the drive.
>>        */
>> -    return pblk_partial_read(pblk, rqd, bio, bio_init_idx, 
>> &read_bitmap);
>> +    return pblk_partial_read(pblk, rqd, bio, bio_init_idx, read_bitmap);
>>   fail_rqd_free:
>>       pblk_free_rqd(pblk, rqd, PBLK_READ);
>>
> 
> Otherwise looks good.
> 
> Reviewed-by: Igor Konopko <igor.j.konopko@intel.com>

Thanks. I've applied it for 4.19 with the fix and also, now that 
NVM_MAX_VBLK is used, removed the max 64 ppas comment.
