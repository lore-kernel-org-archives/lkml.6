Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C92C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E01420989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="hcRgMb2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E01420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeK1BUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:20:10 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33799 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeK1BUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:20:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id u6-v6so20209592ljd.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 06:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vsMTG1GlyfgjNQeIjQBRUaW+k2MHzv5C2e2Hf7Pp9iU=;
        b=hcRgMb2cJU4dsvlcbj2cAMTJru0tzWpK8LXeLJxUsdEh+DG/YBUuhu4FBZ3nahJpDi
         SlUxsQHJIJ6C3D7j0b/mThLO7vulYvF2xeG2HM4fIOSajXFlQiUw4ZmlPB/zqYH5Yktr
         bUVtfQpLbzAzs7taAkqD2K/jZ5+59HFVBcBiW5ozpDLscTuXyBGJpdyfsaN1hto2tuRM
         LXkvAIXtSWoSbuUWxUb8EFRUm5ZE6ZGgCclK7Nct19B3E6cwtEaMG3WTqAa+ptXMduOd
         BUnJPrHNWPmK0uTP+z24Cnb8sp2ztU0ecWZZeObnTDc8pOtwmGRX9RtOIS/specn7/fn
         Ct8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vsMTG1GlyfgjNQeIjQBRUaW+k2MHzv5C2e2Hf7Pp9iU=;
        b=sDkVm2wPExsWiWFvtaho/6GR8JRj/6njM4ObL97qcm/3Az8Fgf1k77FjRWSmfHoSe9
         DPeR6/6USmlP/pp5I95DYozs0HFIKgMB/SFg2WwLcApCpjVa+qBHjp5bVid5P4czX15z
         DfB48/Npi7VpN1VBacuDEyFF7CnuBXdCxb8g4ZfeWcWWxcNyPudHtCFDc1ymfPX3NfRZ
         Q2Pq1IoqerpEkMrljUzkgM+/FbvF2iTysw+f/j4d16Nw7xfG9s6ZTNtF3rb9/kmFHHWA
         xQHYDaUhMTTsJkbrO3VVWwMTEKU1gbeOlzl1wu0tOKFEoeuDzAiP3wFWnJVSJbrrzXd2
         WSBA==
X-Gm-Message-State: AA+aEWanDbcgKzA0aa62mB0uvcBEwUTZTFe2JOPkhhXJkl5PFN0Bo6GL
        azQz1LtHX+j8JzD9bVkT/HQAl8EOLYs=
X-Google-Smtp-Source: AFSGD/XjJMiKWCc4RxTZp0UhG916aQK7pKcigYgtziS9Bz2KFND136V0/14YGaxj+NEfQHLidEuTXA==
X-Received: by 2002:a2e:458b:: with SMTP id s133-v6mr19551929lja.170.1543328523665;
        Tue, 27 Nov 2018 06:22:03 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id y131sm615566lfc.43.2018.11.27.06.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 06:22:02 -0800 (PST)
Subject: Re: [PATCH] lightnvm: pblk: adjust the position of the lock
To:     javier@cnexlabs.com, suhua.tanke@gmail.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181127015309.2374-1-suhua.tanke@gmail.com>
 <F75BC3C7-FACE-4C04-A9BE-5A3AA25D3466@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <a53eb78d-90d3-f84e-a0bf-9acbc32671f4@lightnvm.io>
Date:   Tue, 27 Nov 2018 15:22:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <F75BC3C7-FACE-4C04-A9BE-5A3AA25D3466@cnexlabs.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2018 01:57 PM, Javier Gonzalez wrote:
> 
>> On 27 Nov 2018, at 02.53, Hua Su <suhua.tanke@gmail.com> wrote:
>>
>> Add lock protection for list operations.
>> Signed-off-by: Hua Su <suhua.tanke@gmail.com>
>> ---
>> drivers/lightnvm/pblk-core.c | 17 ++++++++++-------
>> 1 file changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>> index 6944aac43b01..e490df217dac 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -1286,24 +1286,27 @@ int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
>> 	list_del(&line->list);
>>
>> 	ret = pblk_line_prepare(pblk, line);
>> -	if (ret) {
>> -		list_add(&line->list, &l_mg->free_list);
>> -		spin_unlock(&l_mg->free_lock);
>> -		return ret;
>> -	}
>> -	spin_unlock(&l_mg->free_lock);
>> +	if (ret)
>> +		goto out;
>>
>> 	ret = pblk_line_alloc_bitmaps(pblk, line);
>> 	if (ret)
>> -		return ret;
>> +		goto out;
>>
>> 	if (!pblk_line_init_bb(pblk, line, 0)) {
>> 		list_add(&line->list, &l_mg->free_list);
>> +		spin_unlock(&l_mg->free_lock);
>> 		return -EINTR;
>> 	}
>> +	spin_unlock(&l_mg->free_lock);
>>
>> 	pblk_rl_free_lines_dec(&pblk->rl, line, true);
>> 	return 0;
>> +
>> +out:
>> +	list_add(&line->list, &l_mg->free_list);
>> +	spin_unlock(&l_mg->free_lock);
>> +	return ret;
>> }
>>
>> void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line)
>> --
>> 2.19.1
> 
> This path is only touched by the recovery path, which is single
> threaded, so there is no race condition as is. Also, if recovery fails,
> pblk will not create the instance at all. This said, it would be
> good to protect the list_add on the pblk_line_init_bb() error path in
> case this code is used for some other purpose in the future.

I like your explanation here. Another option is that we could add a 
comment to notify the developer that it safe in this context?

> 
> However, the implementation you propose has some issues due to the
> extended critical zone, which covers pblk_line_alloc_bitmaps(). Here,
> allocations are intentionally non-atomic (i.e., GFP_KERNEL).
> 
> You can instead do the following:
> 
> diff --git i/drivers/lightnvm/pblk-core.c w/drivers/lightnvm/pblk-core.c
> index 615817bf97e3..02c4c1708c45 100644
> --- i/drivers/lightnvm/pblk-core.c
> +++ w/drivers/lightnvm/pblk-core.c
> @@ -1301,15 +1301,22 @@ int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
> 
>          ret = pblk_line_alloc_bitmaps(pblk, line);
>          if (ret)
> -               return ret;
> +               goto fail;
> 
>          if (!pblk_line_init_bb(pblk, line, 0)) {
> -               list_add(&line->list, &l_mg->free_list);
> -               return -EINTR;
> +               ret = -EINTR;
> +               goto fail;
>          }
> 
>          pblk_rl_free_lines_dec(&pblk->rl, line, true);
>          return 0;
> +
> +fail:
> +       spin_lock(&l_mg->free_lock);
> +       list_add(&line->list, &l_mg->free_list);
> +       spin_unlock(&l_mg->free_lock);
> +
> +       return ret;
>   }
> 
>   void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line)
> 
> Javier
> 
> 

