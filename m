Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB638C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B04A20651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bFY4uA+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfANNdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:33:10 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41341 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfANNdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:33:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so10361112pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 05:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PVA4HPjgDr4lmqmO22ZYGj1CcHMWJ4SDsQqPVvOcLMg=;
        b=bFY4uA+7906CkQHa4/fmPzlqbESTP2VXi/cJS35aedEGXYdAzBJthNA99MIpOaaY+/
         V2OAm0cNLT0v2a+bXEiAZ+4JuOqtG3vSh7kszLqtJ1UWYc0Oa0ReOfNy+nGLnxOme8d0
         mE7tXL0h2zG/tVXY8spoHPDlvlTmeXE3WdXB20kXT0d1ZRvojQIGMaPhWQEDtoDO0xau
         Mb5WRDG17lMUb8h+e2RIuYboWxkeNFvF5xNGm1nZO955Kk3LjwM2E4zqDs4EQqv47kyh
         wAj9c4Ajs8wf6dhlD31lvGbQrg/NehXme+B1LQy+8+SA7fgFhvGG1mERWfiVVKeWf8tT
         Q9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PVA4HPjgDr4lmqmO22ZYGj1CcHMWJ4SDsQqPVvOcLMg=;
        b=qWhUMn2zCogPZLUb1S09P1QUMd8mhQTsSw/ubXSEeV8qPVxGxHedPMql1hFQoKgQ4J
         kPiUDmxQ0od6Wpw8yg9wOCV9hEJOewSDVwaMdTKYgDf+QGouv1ogE55ax19z6DT+73Cs
         yz7ZcrH1QIkNNpbbkoz3aRTBb7OidFM9r2QgxVexVG7siUUL9wUPjCQmAOPPoeGT0TCE
         E+ocwvkfFttWT+vBps+NDuL2nlW7F1K4F9JAwQWq2i75mtn3JUIdXkekzbh7zY+qIhzd
         u+nF41+qBES0IALcdpWqiPkm2JP/8VlplroP+dwf9/hrmH8WXmHeM+Maom6RS077mE2H
         aVJw==
X-Gm-Message-State: AJcUuke1ctea9mZEGa/+8zSQGR+PKXPAzWT2oXtd7ajM6v6AnUulyqne
        LCUAi9XfV1E63L856ZXCsDLDAg==
X-Google-Smtp-Source: ALg8bN41edTPh/18l3vKlZR+znN3Cux4dBWkgr5kuotofC1EaIavfZqE6GhZq94PU8OOOGprr078SQ==
X-Received: by 2002:a63:d047:: with SMTP id s7mr22641760pgi.311.1547472789489;
        Mon, 14 Jan 2019 05:33:09 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id r12sm466267pgv.83.2019.01.14.05.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 05:33:08 -0800 (PST)
Subject: Re: [PATCH] drivers/md.c: Make bio_alloc_mddev return
 bio_alloc_bioset
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     shli@kernel.org, linux-raid@vger.kernel.org
References: <20181222100845.566772-1-marcos.souza.org@gmail.com>
 <20190111021740.GB1228567@bebop>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7799ad39-06e1-bbaa-fa7a-60fecb48da21@kernel.dk>
Date:   Mon, 14 Jan 2019 06:33:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111021740.GB1228567@bebop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/19 7:17 PM, Marcos Paulo de Souza wrote:
> ping?
> 
> On Sat, Dec 22, 2018 at 08:08:45AM -0200, Marcos Paulo de Souza wrote:
>> bio_alloc_bioset return a bio pointer or NULL, so we can avoid storing
>> the returned data into a new variable.
>>
>> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
>> ---
>>  drivers/md/md.c | 7 +------
>>  1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index fc488cb30a94..42e018f014cb 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -207,15 +207,10 @@ static bool create_on_open = true;
>>  struct bio *bio_alloc_mddev(gfp_t gfp_mask, int nr_iovecs,
>>  			    struct mddev *mddev)
>>  {
>> -	struct bio *b;
>> -
>>  	if (!mddev || !bioset_initialized(&mddev->bio_set))
>>  		return bio_alloc(gfp_mask, nr_iovecs);
>>  
>> -	b = bio_alloc_bioset(gfp_mask, nr_iovecs, &mddev->bio_set);
>> -	if (!b)
>> -		return NULL;
>> -	return b;
>> +	return bio_alloc_bioset(gfp_mask, nr_iovecs, &mddev->bio_set);
>>  }
>>  EXPORT_SYMBOL_GPL(bio_alloc_mddev);

Applied, thanks.

-- 
Jens Axboe

