Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35438C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBCE20824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0QjhBcTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBCE20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeJ3CZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:25:23 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37190 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeJ3CZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:25:23 -0400
Received: by mail-it1-f193.google.com with SMTP id e74-v6so10428236ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 10:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QTFLXZPFEhv7vg44uTUgjGaFxkucOrDlKrr93JC0jtU=;
        b=0QjhBcTB/wDJ3gPtvAdZShyllB1fplX9VLkmqZJbROj6iIPvomym2fdRu4WS8pYEaK
         2yN//hDeSHCSmqKVJ94ijeAcfzLSHmmHY+8TNB1fV8mXGWjEJwo/tlFTBGAUngsvP9Zl
         WGOSrK7JXICpkBr/IxiGGtD+BcXnaqJlxqfpV5YxJabc8BgGuGLOqByVwalvvHj4OZwK
         EzHnI95bF1VyT/XcgqE7jQUn8Wops5hV3MDTcTntU4S2yLccoSTcP2jzJUiKcp5Wmcbq
         KNjbHN3LtdpnXFEOEQ/pP8zq1YKzZEj6+XasWW65mzbBqVu13TSfRWM7m9IiTz0KLxnE
         2zXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QTFLXZPFEhv7vg44uTUgjGaFxkucOrDlKrr93JC0jtU=;
        b=X4eNv53wVc6GIBbm3iJR9gJwKan73stToBejCPoSWxkBhvZesE0BRJ7aP30kCNQxER
         bFmo8gHGs79qvL52wDl3AB4W8LGUKjWHrxWsOsQ2CCcGql8Y/Xt0D8Mje1J4J6pyzetr
         tD+4oEY1NUKtGb5GXXKBAIn83SBPdi7UlLxr8zxU8f9ht5PyyfZFzCNTONZZ6GBjaj3r
         GeerUZ9n1p/BVJ+B/CPQUNSflIXwEvNO+QnS/HloaI6MuAkIhNBdpoK/TDb/4DDVPrPc
         C0mGM1GiCS7AL7EkT0P2QqUokA32CP+p8IzXdEDyTjyF0P11uRY9V20UjcLnPeI0g7aI
         3FMg==
X-Gm-Message-State: AGRZ1gJqdpvYOF65pF68E3B5bMqKRLCb4v0hoPLBNx+MQliK38FqcP8Y
        fUuw9UzSdB/jBY7zKNkkqz4lJ3Q037k=
X-Google-Smtp-Source: AJdET5dkxQ2rg96P01OLxVcoLrPmhsTZ+hotK1SS4x3QILHEtTlZQkJGQZpJDD3hole3LB/vmC0wKQ==
X-Received: by 2002:a02:8646:: with SMTP id e64-v6mr1846351jai.113.1540834548074;
        Mon, 29 Oct 2018 10:35:48 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f18-v6sm5624798ioc.69.2018.10.29.10.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 10:35:46 -0700 (PDT)
Subject: Re: [PATCH 05/14] blk-mq: allow software queue to map to multiple
 hardware queues
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-6-axboe@kernel.dk> <1540834474.196084.64.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d1a8f544-0c38-c002-f61f-bf2a104040ca@kernel.dk>
Date:   Mon, 29 Oct 2018 11:35:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540834474.196084.64.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/18 11:34 AM, Bart Van Assche wrote:
> On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
>> The mapping used to be dependent on just the CPU location, but
>> now it's a tuple of { type, cpu} instead. This is a prep patch
>> for allowing a single software queue to map to multiple hardware
>> queues. No functional changes in this patch.
> 
> A nitpick: mathematicians usually use the { } notation for sets and () for
> tuples. See also https://en.wikipedia.org/wiki/Tuple.

Alright :-)

>> +		/* wrap */
>> +		BUG_ON(!hctx->nr_ctx);
> 
> Another nitpick: how about changing the "wrap" comment into "detect integer
> overflow" or so to make the purpose of the BUG_ON() statement more clear?

Sure, I'll improve that one too.

-- 
Jens Axboe

