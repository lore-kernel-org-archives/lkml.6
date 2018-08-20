Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A59C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5114321655
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="liecztUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5114321655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbeHTPmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:42:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36038 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbeHTPmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:42:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id c21-v6so957895lfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 05:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m92lF2I2fawSM2PJsknZhO+6eFATR0u3ezc+9X1u+/U=;
        b=liecztUX9WpQ7W3/Gc5fjhfnw8a5QYpO7uKpUmatYnAS35sAWrKW6YOPlTvGRMX9xZ
         nohkSnA6X2yIovMAgzIO0voFeXmukqJxmbm9pw4FezQ3y5CkQP1maTpBeFU156Pg7VC2
         riFLnQbO5RGM/oEZVi4doJiezrO3Mxm1O7ZxvlFtup4mvcpy9P/yhTmYcREFIhGroIrc
         CVC5jQlngD89+AqNpZ9vPT0bw2s5FPhXmTLJdX7AWpIG98b8NEP1Ar4tSY2uP8KCjCqg
         drXuB3oXoDslmcmC8U+/dmZBBh1Aiplgl1jk0voAIOkATLouTiVmIly/qagpXv7shLi5
         ftlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m92lF2I2fawSM2PJsknZhO+6eFATR0u3ezc+9X1u+/U=;
        b=o3FzpYPM07kP5vKtqSKG37HiyHZ4jvZGO2kXTz+5K7lsVoAyobnUjIbL0cPeEbBbYf
         sy0CcewDOZlqqEOh42cBCoczHMhZh2Mk4sUHEaaUZ6vQ2UQCOom/NwBiovAjoH1+toFl
         Onr/XZHa9KeViyjxwuoxbqkgp/kMBmU0xUlanJCuTUS7sin9/4CKj+93hnkOktiqK6pk
         yIxkgSGfEkulRzqq3VeLli9pq2oeYj4YQ4ERm4OV27g0b4bC/YmYP/fMX3RPegP6upEX
         NV0CLn8Myk7l1/PTrJEhRgIZ8PlylGQFktk0ulRRSS/Rr8D5L7CbznWQhuLDAzxg6i4k
         qC5w==
X-Gm-Message-State: AOUpUlFIK1BPtPurIYFmS5aLMlgVrgqiL4DCrx2wWh8NYokCkfOkyG20
        ltbI6yyiC4ZyDB+dUNcU/1Ek1FhPhns=
X-Google-Smtp-Source: AA+uWPz0GUYy+CrTNV2/p0yt+/u3dsVJvMfFz11kQtG8/povgbbBjkMbWqTO4MTq1+GqmF/45agqYw==
X-Received: by 2002:a19:cd8c:: with SMTP id d134-v6mr25518190lfg.41.1534768036693;
        Mon, 20 Aug 2018 05:27:16 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id i86-v6sm573225lfb.67.2018.08.20.05.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 05:27:15 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: refactor put line fn on read completion
To:     hlitz@ucsc.edu
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180820114320.3764-1-mb@lightnvm.io>
 <CAJbgVnWe0b03gvO2815rGeB=J4NOEst9FSPf_vyJ3iUSgBuQnw@mail.gmail.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <8cbf9dd9-a982-a73c-23ed-d18c0e0ad3ad@lightnvm.io>
Date:   Mon, 20 Aug 2018 14:27:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAJbgVnWe0b03gvO2815rGeB=J4NOEst9FSPf_vyJ3iUSgBuQnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/2018 02:22 PM, Heiner Litz wrote:
> Consider removing the "_read", make it non-static and move the function to
> pblk-core.c as the function isn't read specific.
> 
> On Mon, Aug 20, 2018 at 1:43 PM Matias Bjørling <mb@lightnvm.io> wrote:
> 
>> The read completion path uses the put_line variable to decide whether
>> the reference on a line should be released. The function name used for
>> that is pblk_read_put_rqd_kref, which could lead one to believe that it
>> is the rqd that is releasing the reference, while it is the line
>> reference that is put.
>>
>> Rename and also split the function in two to account for either rqd or
>> single ppa callers.
>>
>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>> ---
>>   drivers/lightnvm/pblk-read.c | 23 +++++++++++++----------
>>   1 file changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
>> index cd2f61eed6a0..16858eaf694a 100644
>> --- a/drivers/lightnvm/pblk-read.c
>> +++ b/drivers/lightnvm/pblk-read.c
>> @@ -165,20 +165,23 @@ static void pblk_read_check_rand(struct pblk *pblk,
>> struct nvm_rq *rqd,
>>          WARN_ONCE(j != rqd->nr_ppas, "pblk: corrupted random request\n");
>>   }
>>
>> -static void pblk_read_put_rqd_kref(struct pblk *pblk, struct nvm_rq *rqd)
>> +static void __pblk_read_put_line(struct pblk *pblk, struct ppa_addr ppa)
>>   {
>> -       struct ppa_addr *ppa_list;
>> -       int i;
>> -
>> -       ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
>> -
>> -       for (i = 0; i < rqd->nr_ppas; i++) {
>> -               struct ppa_addr ppa = ppa_list[i];
>>                  struct pblk_line *line;
>>
>>                  line = &pblk->lines[pblk_ppa_to_line(ppa)];
>>                  kref_put(&line->ref, pblk_line_put_wq);
>> -       }
>> +}
>> +
>> +static void pblk_read_put_line(struct pblk *pblk, struct nvm_rq *rqd)
>> +{
>> +       struct ppa_addr *ppa_list;
>> +       int i;
>> +
>> +       ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
>> +
>> +       for (i = 0; i < rqd->nr_ppas; i++)
>> +               __pblk_read_put_line(pblk, ppa_list[i]);
>>   }
>>
>>   static void pblk_end_user_read(struct bio *bio)
>> @@ -208,7 +211,7 @@ static void __pblk_end_io_read(struct pblk *pblk,
>> struct nvm_rq *rqd,
>>                  bio_put(int_bio);
>>
>>          if (put_line)
>> -               pblk_read_put_rqd_kref(pblk, rqd);
>> +               pblk_read_put_line(pblk, rqd);
>>
>>   #ifdef CONFIG_NVM_PBLK_DEBUG
>>          atomic_long_add(rqd->nr_ppas, &pblk->sync_reads);
>> --
>> 2.11.0
>>
>>
> 

Thanks Heiner. I'll send a v2.
