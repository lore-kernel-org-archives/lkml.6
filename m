Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175B5C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBA6217B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xXZvSf9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBBA6217B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeHUUVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:21:49 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39363 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbeHUUVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:21:49 -0400
Received: by mail-io0-f196.google.com with SMTP id l7-v6so15964589iok.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PGENX9nfNP1DKRFPtf8XmtVNp3tr7KXllULIdRxU+NU=;
        b=xXZvSf9Fw3CK79Q6eghs6L8F0O6nPorQsyFZPaeNLZf+Qg7SiEwcEsRZ6MsTRdqJJa
         k9F+jgnf8Cr/BBeIFqLvJ8/cpl3Va+Z9WDFDnFyMGuU/d4zEjCfY4Jq7ybMmSKBeETYj
         dU0GWMC7YMbOvvnj9qz2MjJN4+MMDT+NlD1wpLhymG8ODiGBlPbZndglsIUUnAXLMCFs
         IFznY3HGoZMTWz98oA+BwaSNp+SpuLF0a8JN5Zirpl7giP2hXYHBHO7uAP3+CSNmXYkp
         YnP6QMils2H6YjNId/+i/QqvpYdHZAbxUN9GObiKhAQVj7mUzqOa6nhro/f1EW/iQQwV
         l29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PGENX9nfNP1DKRFPtf8XmtVNp3tr7KXllULIdRxU+NU=;
        b=HPhn/j0nbEAb3RR7HDh6eVy86m53Um2uNEQJZVteoPczNNrk1mYbzclHW41gSODNwN
         ksKfmdusAq+F62GGQXsQveDRD8fvO5X9nZhZHuAYXQklMV0FcSNdSM6HZM3N0Nuu3Eds
         4phuKQovC2Mbvf009JSbbSmjJ7hk2nRHN/ohkpRQdz4B7LMlUdo5ihA2FCjGe1QM0epl
         PjP85zojKgtXBXFs5/Mgpw90GxleWxS24T5Hjx5skp8+aNUxn4NnTWLFMx2LgqavC7Io
         cXjcHwEM0xuwPS8ADhCuvX+2F/4F8wr7dz8KAzt0lcndShEufRKhhMqZ/PcBMbiDMYyn
         W/Ng==
X-Gm-Message-State: AOUpUlGx6IYvEnnm5zk0UYdfveJPy5GywYQij7vHQf4CebNkhCBDlQzk
        eE5gIeiFL1La1rYIj4Y9Xv1GtNY1sf0=
X-Google-Smtp-Source: AA+uWPwjvuqB6litCAD51nU+kBU37heFWGmGtr7L8/B7NE+f70szfqmgXx/tYIUzCZ1LOwAWDuYAJg==
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr42578844iof.173.1534870851750;
        Tue, 21 Aug 2018 10:00:51 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r126-v6sm1674276ita.26.2018.08.21.10.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:00:50 -0700 (PDT)
Subject: Re: [PATCH] block/DAC960.c: make some arrays static const, shrinks
 object size
To:     Colin King <colin.king@canonical.com>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180821091248.8669-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cbe876ce-8f1f-1dc3-86fb-b26278277312@kernel.dk>
Date:   Tue, 21 Aug 2018 11:00:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180821091248.8669-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/18 3:12 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the arrays ReadCacheStatus, WriteCacheStatus and
> SenseErrors on the stack but instead make them static const. Makes
> the object code smaller by 47 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>  160974	  34628	    832	 196434	  2ff52	drivers/block/DAC960.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>  160671	  34884	    832	 196387	  2ff23	drivers/block/DAC960.o
> 
> (gcc version 8.2.0 x86_64)

Applied, thanks.

-- 
Jens Axboe

