Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB13CC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855B420882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCKpZUs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855B420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbeGYMBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 08:01:48 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44809 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbeGYMBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 08:01:48 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so6256750ljq.11;
        Wed, 25 Jul 2018 03:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qUzhh2J/s3kbrYBU2tB2QgFf5kOXLIrTvfYitocPUkg=;
        b=oCKpZUs2e2Wgq5EkFPHA5fAYPQpJy/1oLTsqVrLAkLYjOGMDDo7SJQ8nTGC1yzqc1B
         kRHq4Emt3WWjtIHHGBAg3HefBIPvQQkGqY4MnBjSzZ9wNExDUgnRw6l7yHfS6Q3MQQiV
         Nw/Zd492x5TL/v/duobRvExnZk4EvrD0i9qQAgbNySU16/++DZJAjpr93hTHmTGfwJ5C
         aX4+FXCP4GxVx9HCK6yxsZ9XHCokvRYa+SL27eTZpcczX6LJilXcEKqO9EC2RKT5Xhru
         sK1NWdBPFtGJpTlFv8XPvIN75OomdtnJRVVZyYsh7Dms6wQ1dpKmwxKm8t2oWrqsm6UG
         GAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qUzhh2J/s3kbrYBU2tB2QgFf5kOXLIrTvfYitocPUkg=;
        b=nBloZKp/Wj5duV+bd+xEfagcqijpou+R53F+5uF23VotxzHjuoWzQJurHbtDfrVyYr
         Gh+8vx1mBWPqF05Zi9DCCFQ/FO7RTPx2wlIUbdxdUaBTEjpJzC24N1g3B0RLlrnGKXlG
         csRKiIj2tB5oEGojTYlyg6gx0mCgV/409xeWBXjX4XajJbiBDxpwX/qFc9zx0Q99bVli
         NmXSr53T1LguTTu0xcnLD+hT3/v01FX2h4yBI7Gx45qvJR3HUXsqvFLpg7TCkguk3plW
         yYfYVV1orP600wkFhqsnprtRnT1/m9RDCAZC6XcBuFCW/Mh8g3w/6q8Hnh0oYeSmFlgu
         /OHg==
X-Gm-Message-State: AOUpUlE9jq0Y1VR8zmWkELUJ/AnDxQhVSgmov1WvjNAG14YXyBUKszJ2
        LDp6BVGwKlra2FOaE+xPkUI=
X-Google-Smtp-Source: AAOMgpdAIktMNnqXO3/95KA9opGq/YWiwu2Acc6NWKAxuhnkzzQpiSEEbVnS+0YU56/jwdmsDZxaCg==
X-Received: by 2002:a2e:8616:: with SMTP id a22-v6mr15903803lji.43.1532515838284;
        Wed, 25 Jul 2018 03:50:38 -0700 (PDT)
Received: from ?IPv6:2001:2012:22e:1b00:f2e2:9015:9262:3fde? ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id x2-v6sm1636015ljx.64.2018.07.25.03.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 03:50:37 -0700 (PDT)
Subject: Re: [PATCH] 9p: validate PDU length
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     davem@davemloft.net, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
References: <20180723154404.2406-1-tomasbortoli@gmail.com>
 <20180725041139.GB11041@nautica>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b3c5017f-34d0-c9f4-ec29-1fbb4aa4969a@gmail.com>
Date:   Wed, 25 Jul 2018 12:50:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725041139.GB11041@nautica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/25/2018 06:11 AM, Dominique Martinet wrote:
> Tomas Bortoli wrote on Mon, Jul 23, 2018:
>> diff --git a/net/9p/client.c b/net/9p/client.c
>> index 18c5271910dc..92240ccf476b 100644
>> --- a/net/9p/client.c
>> +++ b/net/9p/client.c
>> @@ -524,6 +525,12 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
>>  	int ecode;
>>  
>>  	err = p9_parse_header(req->rc, NULL, &type, NULL, 0);
>> +	if (req->rc->size >= c->msize) {
> 
> I was looking at this again, I think it's more appropriate to use
> req->rc->capacity at this point like you did in the first version of the
> patch.
> 
> I had suggested msize in the common p9_parse_header function because
> that'd let us accept zc requests where the size in the pdu could be
> bigger than capacity, but this isn't the case in p9_check_errors.
> 
> If you're ok with this I'll edit your commit directly, this is less work
> for me than having to check a new patch.
> 
> Thanks,
> 

Yes sure, just forward me the changes later.

Tomas
