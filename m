Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1019EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DB220881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="C5BHEvrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DB220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933663AbeGJOWw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:22:52 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51900 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933416AbeGJOWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:22:50 -0400
Received: by mail-it0-f68.google.com with SMTP id g4-v6so14710916iti.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZjNOcrX6N5Yhbsj1nFZCzyXqslgEbO9pe7jx7DtugfY=;
        b=C5BHEvrSEoF2VEbQI81vv5lgHxb1KXPuEmGN7iK2hkCyS0FhSRikNCtJuk/f1/HftO
         k97sFWkVXKejVo0rK5cCJmJbWguKirQbVztsfhWwcKiRAgDGHh4G9lk9vNX6fOCpbcZo
         tFQQMWlWMDBFqtjkXVUgH5smU52xRw4dF956Ltddm1VjsA7yHKTF9ewYx85RurrUwlDU
         xOz8nWXr9niL5G1lydu3S36ixcX0I6TynjEQmRlRaciQeSg0JltqYiDipFjgCKfh58kl
         4YNQkXWA9hmyGjD3opcapKaOc76GmWBli3N6bIqOT7IDR81ROfkNqkJr0Xc/0HqOOH9p
         qSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZjNOcrX6N5Yhbsj1nFZCzyXqslgEbO9pe7jx7DtugfY=;
        b=j0jP0jwI/5BWhjqInLZT4O71UmVh7cCp9bsiqcDuaslOowcJVkRUDFp0TwurQgwOAq
         rWZ/PgswFe86c0xv9rX6FxCAwXtxhLd/A9o674hPZSLonD2dRnCQdKVSzujLBq1pKYNX
         jO3RPeKfzS+5M+fNHtpw2Sq38xsxAOqfk43vJVO23oYWphY11X6yxj4IDXdXjp5UhELg
         HMCWKR3HfDMqjqf0779mW1d7jLtURaaa84IGbWtM44YNzQ0N7kSosmFJ+pcV4U9oOTo7
         cYoqSh20sd4ABdwMX0LMsG3AixMwPZfOQiWPCrXUSX/h5mcHsSXSnyU4F+2Drv5Ewln6
         gB1w==
X-Gm-Message-State: APt69E2s8yWpSAk0p3GsBJ3MRepWEVUdrjSe91Od9vU2qKQUHGn9IpoX
        sezHBRRTllLev0Tmy12aGlEEIg==
X-Google-Smtp-Source: AAOMgpcUQpvlo8C0NngKAg6vWA7iwFKwu1IToCei14ezezNyalP2TWC8snHdciBZawfno5Cq/pClLA==
X-Received: by 2002:a24:c102:: with SMTP id e2-v6mr18702072itg.131.1531232569653;
        Tue, 10 Jul 2018 07:22:49 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l126-v6sm9934392itb.5.2018.07.10.07.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 07:22:48 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the scsi tree
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Omar Sandoval <osandov@fb.com>
References: <20180620132911.5f6ab464@canb.auug.org.au>
 <20180710173114.17ee69ad@canb.auug.org.au>
 <280ebbdf-fafb-1744-f517-815a30e682bb@kernel.dk>
 <1531232063.4963.8.camel@HansenPartnership.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3f0359a5-6733-f9d3-a616-d27ce430c904@kernel.dk>
Date:   Tue, 10 Jul 2018 08:22:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1531232063.4963.8.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/18 8:14 AM, James Bottomley wrote:
> On Tue, 2018-07-10 at 08:09 -0600, Jens Axboe wrote:
>> On 7/10/18 1:31 AM, Stephen Rothwell wrote:
> [...]
>>> I am still seeing these warnings ...
>>
>> Martin queued up the forward declaration patch for this one, not sure
>> why it isn't showing up in the scsi tree yet.
> 
> All the trees are fully up to date ... which commit is it?

It's a patch from Arnd, I don't know what commit id it is. But
Martin replied a few days ago that it was applied. I don't have
the email handy, though.

-- 
Jens Axboe

