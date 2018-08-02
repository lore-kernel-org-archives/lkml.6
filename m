Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A072CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DD82152B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eUSgoABO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DD82152B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732219AbeHBTA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:00:27 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40018 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732177AbeHBTA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:00:27 -0400
Received: by mail-it0-f66.google.com with SMTP id h23-v6so4404347ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 10:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DWKPVMHB8HiQnQUpWWXzSJ+RkhD+9kIYuWUSuxWdg4E=;
        b=eUSgoABOrtWPWnIxLMvKEJ1/KKcYwmMFxWc96b6wpSpM14GuW2f3jsF4xQr+lzYldE
         cESFWuTZcdC1AcfjiJS6RL6+YgCdPsSXE5D68g/c150o4TtDocswu5IqenH4kyai8nwG
         FPcXwB+h78sL8pqhi91M5qwyFnibTwaYmmzb1+0YvibE/ygM5/woNlx5v8sqg1ZjCEkP
         2yBN72IPTTVUUl4WSZ7yZM8pNrro2a2l7M9WqWHRBjsXS1aD3sk7NAbYaROlD6ETGfkv
         v7mxLaJ/Bd6fiIODZWrEfWaQeb8baCW66JJJ5gcEjM3dBE32LlhGI4XSUKgyPboP75MZ
         kHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DWKPVMHB8HiQnQUpWWXzSJ+RkhD+9kIYuWUSuxWdg4E=;
        b=cxd2e6JPK+U+kGyM5Z49B3wO0haNx/ydlpeVAbMV04KwqYz6nhyKT7v3GgNddfOs/S
         Ljd+hJGOE4ASOjcZUtBPyQrqaiTcS01mqLk9YOE4KmbxAfuGqY5E0LRHaeBYyqbWArM4
         It1Si984VgfW3q84WK8Ns76+s0VNd1miZVbWinkBwmtUMUFlJj0aaA0/xmLxa3AfxerV
         NEMKkhwvb23YUfxUI9qQ6KYZ5mqxurKN/CvW3jgZxhInIomesv7We9LymooMAxOnPWWq
         8ILgtoXNr/3Ybz0eNMxgl1C8xGnQ7oxN1wa2an0QCmWCPk6RDWAaF7ohi4AQCB3EhN9x
         pWtA==
X-Gm-Message-State: AOUpUlEJZVGPBMctxBlDZ/or8qQO4WL2ocQ8UEuZ+Nwx+0zQtebW3fSH
        1QYBjobWSQV5D5b+qQW/FAyXC2Si2LA=
X-Google-Smtp-Source: AAOMgpetIRtiOPVS7TOlP/232jOLfQ4tVLhHmZ4t2Ck5kipgJDWkIHX4Cea9gxPYSraVmcyGbDgvVg==
X-Received: by 2002:a24:54d:: with SMTP id 74-v6mr3241025itl.96.1533229705791;
        Thu, 02 Aug 2018 10:08:25 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id g23-v6sm649248iob.88.2018.08.02.10.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 10:08:24 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: fix blk_mq_tagset_busy_iter
To:     Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180802164329.11900-1-ming.lei@redhat.com>
 <1533228846.3915.17.camel@HansenPartnership.com>
 <20180802170601.GC8928@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <acd8de2a-4a24-385c-e76a-5f54c8dc09d7@kernel.dk>
Date:   Thu, 2 Aug 2018 11:08:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180802170601.GC8928@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/18 11:06 AM, Ming Lei wrote:
> On Thu, Aug 02, 2018 at 09:54:06AM -0700, James Bottomley wrote:
>> On Fri, 2018-08-03 at 00:43 +0800, Ming Lei wrote:
>>> Commit d250bf4e776ff09d5("blk-mq: only iterate over inflight requests
>>> in blk_mq_tagset_busy_iter") uses 'blk_mq_rq_state(rq) ==
>>> MQ_RQ_IN_FLIGHT'
>>> to replace 'blk_mq_request_started(req)', this way is wrong, and
>>> causes
>>> lots of test system hang during booting.
>>>
>>> Fix the issue by using blk_mq_request_started(req) inside
>>> bt_tags_iter().
>>>
>>> Fixes: d250bf4e776ff09d5 ("blk-mq: only iterate over inflight
>>> requests in blk_mq_tagset_busy_iter")
>>> Cc: Josef Bacik <josef@toxicpanda.com>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>> Cc: Mark Brown <broonie@kernel.org>
>>> Cc: Matt Hart <matthew.hart@linaro.org>
>>> Cc: Johannes Thumshirn <jthumshirn@suse.de>
>>> Cc: John Garry <john.garry@huawei.com>
>>> Cc: Hannes Reinecke <hare@suse.com>,
>>> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
>>> Cc: James Bottomley <James.Bottomley@hansenpartnership.com>
>>> Cc: linux-scsi@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>  block/blk-mq-tag.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>> index 09b2ee6694fb..3de0836163c2 100644
>>> --- a/block/blk-mq-tag.c
>>> +++ b/block/blk-mq-tag.c
>>> @@ -271,7 +271,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap,
>>> unsigned int bitnr, void *data)
>>>  	 * test and set the bit before assining ->rqs[].
>>>  	 */
>>>  	rq = tags->rqs[bitnr];
>>> -	if (rq && blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
>>> +	if (rq && blk_mq_request_started(rq))
>>
>> So now we have dueling versions of this patch:
>>
>> https://marc.info/?l=linux-scsi&m=153322802207688
>>
>> Can we at least make sure we've root caused the problem and confirmed
>> we've got it fixed before we start the formal patch process?  When we
> 
> EH uses scsi_host_busy to check if the error handler needs to be waken
> up. And blk_mq_tagset_busy_iter() is used for implementing scsi_host_busy(),
> so causes EH not waken up, then this timed-out request can't be handled.
> 
>> do start the formal patch process, please give appropriate credit to
>> the reporter(s) since this has been a royal pain for them to help us
>> track down.
> 
> Sure.
> 
> Jens, could you add reported-by if you are fine with this version? Or please
> just let me know if new version is needed, then I can add it.

I'll add that, would also love a tested-by from the reporter. The patch
looks good to me, however.

-- 
Jens Axboe

