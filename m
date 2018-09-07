Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36EBC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CDB204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="fofoPSLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CDB204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeIGOlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:41:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34603 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeIGOlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:41:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id f6-v6so6392930plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 03:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kFcCsyKI3U5OZk30HhyH6sqOAI4wZcu6hunC8AVXCPg=;
        b=fofoPSLj8SCCVGnQhik1hrUkRiat9guG2R8LObReA8ldShjOhEM6wncrGqA4KdzSYf
         cznNq64ytHqEvdHJOaBbbtGbuf3o3tN01PwQfIoQx6yD2SKOJk0ZRt5KWq5M2GKBCmqr
         IwqMqV80TbHCzUWm4uySHCu6I+lTkvb+mNFbzGjeuhYMUQ1PW0X0vCUQ9vr/sfE6g3oR
         aDTX49tfCuarlaxMsB+OLhuxDcBR0/TMRGeNv0ThUUGu1IMOOeBHC2r+qxQZ8BNehR5Z
         Esc9WGNCJq0ANwEGh9U1+QtzltrAQmfBA9nT/CGi1XjXY2Of0uCb2CPI0ZiPcZnyf2yg
         PeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kFcCsyKI3U5OZk30HhyH6sqOAI4wZcu6hunC8AVXCPg=;
        b=assTFpg3CtL0XzQWLZI7BY+lnjC7OhndjKril4lm4YnLo85qWwADbrZKznlDDn5a0d
         93xqM54GJ+0La1nN27FBudpCLf9AELf8U4IRH3MtiKEGuOEQpND951+1QnKacWX9Bey1
         mm7kQI6xCSTDBB4dUNLIGRktyn9kmHf/jU4JIK6xkJKZO07sE4F3ZPAw2OHlm9D+FP/K
         IOIk5TC4GLn8l7nRCD16LOeDjRIVQFrwMpZvRf2iAqNUvWwNU+9trBcqJXyx9z3Tuysa
         whDHervFtGMS20q0/CQxiZMHhzwHAxgyaFZf/405q8zZAuQNs8RGg5piEJPelbjQXy7a
         xT6A==
X-Gm-Message-State: APzg51DyPfzyZB7jxBqlVl0U8ZqrhNwNqYcvVzgFanCaJDdSzXtDfMSC
        zu7kTk8yVQ8JqII8XO69r8khzsuPjqIMqA==
X-Google-Smtp-Source: ANB0VdZsjqqXCN92t4V68w9tlgvzn3OPVq/0rNKzMUvFchAPXD6gNF2H0aQXY1nKkd8tJ5UOXi1/YQ==
X-Received: by 2002:a17:902:9a47:: with SMTP id x7-v6mr7199510plv.37.1536314459877;
        Fri, 07 Sep 2018 03:00:59 -0700 (PDT)
Received: from [10.86.62.183] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id n79-v6sm21641488pfh.2.2018.09.07.03.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 03:00:58 -0700 (PDT)
Subject: Re: [PATCH v2] lightnvm: pblk-recovery: lightnvm: pblk: Fix two
 sleep-in-atomic-context bugs
To:     javier@cnexlabs.com, baijiaju1990@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180905084017.27593-1-baijiaju1990@gmail.com>
 <4FEA8984-5E08-44E1-9E5C-03A6516AF7F6@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <07fd7366-3deb-6c3e-1cc9-b0dcfdd9ad9f@lightnvm.io>
Date:   Fri, 7 Sep 2018 12:00:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4FEA8984-5E08-44E1-9E5C-03A6516AF7F6@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2018 03:18 PM, Javier Gonzalez wrote:
>> On 5 Sep 2018, at 01.40, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>>
>> The driver may sleep with holding a spinlock.
>>
>> The function call paths (from bottom to top) in Linux-4.16 are:
>>
>> [FUNC] nvm_dev_dma_alloc(GFP_KERNEL)
>> drivers/lightnvm/pblk-core.c, 754:
>> 	nvm_dev_dma_alloc in pblk_line_submit_smeta_io
>> drivers/lightnvm/pblk-core.c, 1048:
>> 	pblk_line_submit_smeta_io in pblk_line_init_bb
>> drivers/lightnvm/pblk-core.c, 1434:
>> 	pblk_line_init_bb in pblk_line_replace_data
>> drivers/lightnvm/pblk-recovery.c, 980:
>> 	pblk_line_replace_data in pblk_recov_l2p
>> drivers/lightnvm/pblk-recovery.c, 976:
>> 	spin_lock in pblk_recov_l2p
>>
>> [FUNC] bio_map_kern(GFP_KERNEL)
>> drivers/lightnvm/pblk-core.c, 762:
>> 	bio_map_kern in pblk_line_submit_smeta_io
>> drivers/lightnvm/pblk-core.c, 1048:
>> 	pblk_line_submit_smeta_io in pblk_line_init_bb
>> drivers/lightnvm/pblk-core.c, 1434:
>> 	pblk_line_init_bb in pblk_line_replace_data
>> drivers/lightnvm/pblk-recovery.c, 980:
>> 	pblk_line_replace_data in pblk_recov_l2p
>> drivers/lightnvm/pblk-recovery.c, 976:
>> 	spin_lock in pblk_recov_l2p
>>
>> To fix these bugs, the call to pblk_line_replace_data()
>> is moved out of the spinlock protection.
>>
>> These bugs are found by my static analysis tool DSAC.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>> v2:
>> * Move the call to pblk_line_replace_data() out of the spinlock
>>   protection, instead of v1 that changes GFP_KERNEL to GFP_ATOMIC in
>>   the calls to bio_map_kern() and nvm_dev_dma_alloc().
>>   Thanks Javier for good advice.
>> ---
>> drivers/lightnvm/pblk-recovery.c | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
>> index 3a5069183859..5fde414d78bb 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -955,12 +955,14 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
>> 		}
>> 	}
>>
>> -	spin_lock(&l_mg->free_lock);
>> 	if (!open_lines) {
>> +		spin_lock(&l_mg->free_lock);
>> 		WARN_ON_ONCE(!test_and_clear_bit(meta_line,
>> 							&l_mg->meta_bitmap));
>> +		spin_unlock(&l_mg->free_lock);
>> 		pblk_line_replace_data(pblk);
>> 	} else {
>> +		spin_lock(&l_mg->free_lock);
>> 		/* Allocate next line for preparation */
>> 		l_mg->data_next = pblk_line_get(pblk);
>> 		if (l_mg->data_next) {
>> @@ -968,8 +970,8 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
>> 			l_mg->data_next->type = PBLK_LINETYPE_DATA;
>> 			is_next = 1;
>> 		}
>> +		spin_unlock(&l_mg->free_lock);
>> 	}
>> -	spin_unlock(&l_mg->free_lock);
>>
>> 	if (is_next)
>> 		pblk_line_erase(pblk, l_mg->data_next);
>> --
>> 2.17.0
> 
> It looks good to me. Thanks Jia-Ju.
> 
> Reviewed-by: Javier González <javier@cnexlabs.com>
> 

Thanks. Applied for 4.20.
