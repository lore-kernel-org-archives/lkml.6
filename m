Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C15C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8723A21581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="rSY+r7mK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8723A21581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbeHTQCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:02:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46808 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbeHTQCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:02:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id e23-v6so5455596lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 05:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R344Nn2Xpwll865CNWFEfnhjVEO7XWzhU676sHNPUFM=;
        b=rSY+r7mKbuZkVoYZVf30uLTKVoS6fKwPZQt1VaNflMg5G6vhNRGtiRa4xGkqs3PKix
         7EG3vNhFNBn9Vi3WDnVBnJVWoMIdTyOuYseL7/JXOV4K16ZaGPJMCyQp2XUevDgqSEfK
         goM+1iCTtVqxH1o1Bf8yEWvC+DjWyXNBsnS1fds0ehfTRJxFNPNKKY1aE+Hnrs/F8Omq
         IL00Xgb9W0PicUgUUo9a8kA5X+muLXNG2A8mV6CxVItvTv9QjQxI1Wad56Fuuun1X7LE
         oY1Dxs6NMt5Pyv4UQJGuRavTdprnSs4I0qmWs9ZYtaz/b6ZkOey2v8kz/ZmXgKmyorga
         Uo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R344Nn2Xpwll865CNWFEfnhjVEO7XWzhU676sHNPUFM=;
        b=V7Yo1YHZ4ywq6UTLnP+c5m4i6jrbMhqxxZ1OPFvU/MpouRO1wFdW6a7sBCMvMYNyhI
         x+bKIFQxVmQLtK7c7fpdBnKlIlSMbAHSSLpN2VkD5+fiieNiWxau45sB16cj8ZUdgCM1
         MDE9m25ihkMtHN4NI+kMttKhPN3MQLYfKf1F0xYBQEJYElDSj6nURhFGAf/FuaFhE08t
         +0Df3UDf0V4deeP0SxWYnJyJ3H5c9K4FKSr8bYe8G7lRCG/qFaiq+yPwicj3KTYtY0Lw
         Vsqzy4bnrEGa0qaEYvnrXkFc+5prfIjbgAGxJEjkK/vw7x71bogwtm0CQXlyXqX+QXAi
         X7fA==
X-Gm-Message-State: AOUpUlGxTQ7jH1TysKQ6tNmWZD1UiJTH4/t2WECz9JDd/SPjJm6tJnWd
        suBmj+Gx4KMbzf0z3PEiokBKESZPCCc=
X-Google-Smtp-Source: AA+uWPyZWFz2fFMacEUUubCC9N/94FcJtW9D6WWqdQ26demVcnMH7pXMD6x3VbadZ8XHrMAM7VCGSA==
X-Received: by 2002:a19:cd8c:: with SMTP id d134-v6mr25566748lfg.41.1534769206121;
        Mon, 20 Aug 2018 05:46:46 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id s23-v6sm1603461ljs.38.2018.08.20.05.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 05:46:44 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: introduce nvm_rq_to_ppa_list
To:     javier@cnexlabs.com
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180820121217.11393-1-mb@lightnvm.io>
 <DA2F1D94-23DC-4739-9056-351992D972EE@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <d03ed26c-cb06-d9b7-e7ee-d0b78316641a@lightnvm.io>
Date:   Mon, 20 Aug 2018 14:46:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <DA2F1D94-23DC-4739-9056-351992D972EE@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/2018 02:38 PM, Javier Gonzalez wrote:
>> On 20 Aug 2018, at 14.12, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> There is a number of places in the lightnvm subsystem where the user
>> iterates over the ppa list. Before iterating, the user must know if it
>> is a single or multiple LBAs due to vector commands using either the
>> nvm_rq ->ppa_addr or ->ppa_list fields on command submission, which
>> leads to open-coding the if/else statement.
>>
>> Instead of having multiple if/else's, move it into a function that can
>> be called by its users.
>>
>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>> ---
>> drivers/lightnvm/pblk-read.c  | 4 +---
>> drivers/lightnvm/pblk-write.c | 5 +----
>> drivers/lightnvm/pblk.h       | 4 +---
>> include/linux/lightnvm.h      | 5 +++++
>> 4 files changed, 8 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
>> index f275c7e5abe4..696d3a9c9cf0 100644
>> --- a/drivers/lightnvm/pblk-read.c
>> +++ b/drivers/lightnvm/pblk-read.c
>> @@ -175,11 +175,9 @@ static void __pblk_read_put_line(struct pblk *pblk, struct ppa_addr ppa)
>>
>> static void pblk_read_put_line(struct pblk *pblk, struct nvm_rq *rqd)
>> {
>> -	struct ppa_addr *ppa_list;
>> +	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
>> 	int i;
>>
>> -	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
>> -
>> 	for (i = 0; i < rqd->nr_ppas; i++)
>> 		__pblk_read_put_line(pblk, ppa_list[i]);
>> }
>> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
>> index df99c45778d4..a92450ec7698 100644
>> --- a/drivers/lightnvm/pblk-write.c
>> +++ b/drivers/lightnvm/pblk-write.c
>> @@ -212,10 +212,7 @@ static void pblk_submit_rec(struct work_struct *work)
>>
>> 	pblk_log_write_err(pblk, rqd);
>>
>> -	if (rqd->nr_ppas == 1)
>> -		ppa_list = &rqd->ppa_addr;
>> -	else
>> -		ppa_list = rqd->ppa_list;
>> +	ppa_list = nvm_rq_to_ppa_list(rqd);
>>
>> 	pblk_map_remaining(pblk, ppa_list);
>> 	pblk_queue_resubmit(pblk, c_ctx);
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index 64ae0c7ed3bb..bda098c7cc3b 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -1335,9 +1335,7 @@ static inline int pblk_boundary_ppa_checks(struct nvm_tgt_dev *tgt_dev,
>> static inline int pblk_check_io(struct pblk *pblk, struct nvm_rq *rqd)
>> {
>> 	struct nvm_tgt_dev *dev = pblk->dev;
>> -	struct ppa_addr *ppa_list;
>> -
>> -	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
>> +	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
>>
>> 	if (pblk_boundary_ppa_checks(dev, ppa_list, rqd->nr_ppas)) {
>> 		WARN_ON(1);
>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>> index 0106984400bc..1497e275f90f 100644
>> --- a/include/linux/lightnvm.h
>> +++ b/include/linux/lightnvm.h
>> @@ -487,6 +487,11 @@ static inline struct ppa_addr dev_to_generic_addr(struct nvm_dev *dev,
>> 	return l;
>> }
>>
>> +static inline struct ppa_addr *nvm_rq_to_ppa_list(struct nvm_rq *rqd)
>> +{
>> +	return (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
>> +}
>> +
>> typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
>> typedef sector_t (nvm_tgt_capacity_fn)(void *);
>> typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *,
>> --
>> 2.11.0
> 
> Hans made a similar patch some time ago. There are a number of places
> where you want to use this helper too, also outside of pblk. You can
> look at it here [1]
> 
> [1] https://github.com/OpenChannelSSD/linux/commits/for-4.20/pblk
> 
>     fdd88185bfed
>     17609afb2db9
> 
> Javier
> 

I like Hans' better. Hans, could you please merge my patch with yours? I 
prefer the nvm_rq_to_ppa_list naming, rqdata -> rqd, and if short-hand.

