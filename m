Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357F8C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DE6218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UaLXnGSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfAXQWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:22:09 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35865 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbfAXQWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:22:08 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so3117223plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 08:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/fRY7oF3DeYWNwEI4YZpPRoMmGSUZKLLD8+Q6ex5zuc=;
        b=UaLXnGSjHouWOidyRBXh+0UTIjZnOzrBL8iIOsNjyPOhKiIsoCiczrCGBvQvgM59Yv
         5jvMdtBA26+xM00wd+FAfrb+gfg4UWmq+S+W7Swku7R9JUWyJnD/cQ9BEc/veUaA5IHA
         fC4yDyDyjXfHHfk9ZKG3nEYTxLMUCeieWtZE47lJ5lMpDXF0ctM6ENOuYTN9mEXiHOzR
         4JkDRn81Yfnd0maxtFvPOVW03m329yFLZW2MNIRly8c2oPuqezBy+Mrgd09/xuv+Q2Gi
         aBnX0lZzvLbsjxhNLDpdy1FbMjd+11E8/28jsMOxea71BoLi1Fl2bFnY2IwFj+3DR6uL
         NATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/fRY7oF3DeYWNwEI4YZpPRoMmGSUZKLLD8+Q6ex5zuc=;
        b=a0a9SsZQUtiYT6qCmphal+G8eA3AgxX5LoXBRmWd3BfVH51RXI00W5vf+KR09cj/FI
         iZHtVahjEGSn/+8/TdzVQOPbufiA0mh0kR/4lKpLM/EslLHT+3BSqJF/Zyx18xR9QP25
         l/dt6x3TGwdXWUnbJ5iIkwzxSmTlBlIIu3CFGxIxUZyTRJcA9uuCQ8fvIlJjpL7yQMUA
         ZNuBN3OrUW+NVJij6lTzRQcZBzgFrg+CdpKcBrF+1suScZqliPZn8nExcIOACT8qfTnT
         BBbQFjGjrPqF/iyM1qHHVs508SSinWBrH1B391Z4vv7uhFGyMGB9S+fylPmew7+7qgaA
         x7dQ==
X-Gm-Message-State: AJcUukecKwBIct1Cvw6YXc8ahGq/MWDUDhI6cyresT9uASwV6KesK8EC
        EMDeT9WsgzNTmJcwnnj/qM/vQXus0eM=
X-Google-Smtp-Source: ALg8bN5X2wS+wG0J8jOFEKjWuDQRTd76gR5USEq3UO+5CpackMmeS0wfl86wxO7sGvBe9VzOywBn4Q==
X-Received: by 2002:a17:902:e18d:: with SMTP id cd13mr7200528plb.262.1548346926828;
        Thu, 24 Jan 2019 08:22:06 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m85sm34643513pfj.171.2019.01.24.08.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 08:22:05 -0800 (PST)
Subject: Re: [PATCH] blk-mq: fix the cmd_flag_name array
To:     Jeff Moyer <jmoyer@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1548325735-1760-1-git-send-email-jianchao.w.wang@oracle.com>
 <x49h8dygkih.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c3bde1b4-73ea-9120-0e6c-f9f57c0bbb24@kernel.dk>
Date:   Thu, 24 Jan 2019 09:22:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <x49h8dygkih.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/19 8:09 AM, Jeff Moyer wrote:
> Jianchao Wang <jianchao.w.wang@oracle.com> writes:
> 
>> Swap REQ_NOWAIT and REQ_NOUNMAP and add REQ_HIPRI.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>> ---
>>  block/blk-mq-debugfs.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>> index 90d6876..f812083 100644
>> --- a/block/blk-mq-debugfs.c
>> +++ b/block/blk-mq-debugfs.c
>> @@ -308,8 +308,9 @@ static const char *const cmd_flag_name[] = {
>>  	CMD_FLAG_NAME(PREFLUSH),
>>  	CMD_FLAG_NAME(RAHEAD),
>>  	CMD_FLAG_NAME(BACKGROUND),
>> -	CMD_FLAG_NAME(NOUNMAP),
>>  	CMD_FLAG_NAME(NOWAIT),
>> +	CMD_FLAG_NAME(NOUNMAP),
>> +	CMD_FLAG_NAME(HIPRI),
>>  };
>>  #undef CMD_FLAG_NAME
> 
> Acked-by: Jeff Moyer <jmoyer@redhat.com>
> 
> You might consider also adding a comment above the req_flag_bits enum
> noting that modifications also need to be propagated to cmd_flag_name.

Agree... These things are notoriously difficult to keep in sync, this
isn't the first time we've had a fixup. Not sure if that situation
is improvable, but at least a comment might help.

-- 
Jens Axboe

