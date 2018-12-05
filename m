Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E985CC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5E920851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="V7tjByPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5E920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbeLENs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:48:27 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:43209 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeLENs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 08:48:26 -0500
Received: by mail-pf1-f176.google.com with SMTP id w73so10034482pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 05:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5bQP5GF38p6tNBGkNNSdM9jrCUfjWB3hksiQ0JVFb5o=;
        b=V7tjByPdfvuxTTVaM7N53ibJ1UApYyiZiwC/F+J5Fn+BZuqIhtsJBIBCuAkdbIUnRN
         FlXtwB3Su9V1I2zwRvwRXu7h8hzwibGlaxjaf4GLDK5iLEnN9QnuYJMZYbrG45gjNOR1
         3gqPRNAfKJcOHjHEpXSmI7Whk2TzyK90mgG9CZOtW0ri2NflSGuJ7iZYGXnCEqhOtOr8
         VQz+p6T+vFQRClu7JVX6uZqO+KPSak7ZZEZ0apWZCU003CtuqKIYz9WXj7U1+vHZ/BL3
         8q+EPMio719XrLaYNfLNvWwR5ltveE/td8aIP3dFmolDLGnE07bD+Ztc/rmNkbMqgeHv
         OJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5bQP5GF38p6tNBGkNNSdM9jrCUfjWB3hksiQ0JVFb5o=;
        b=gKe0amcKm6cBdHOuQljxXJRWPqPzsU1o2NA8HP9KSPX8ttg6jAGxZF4lV+6B8Qq6HT
         mdJKrjYKdxOO3b7PGkdyVbggjMtPWBO6/24j8ZTnoKrWVu6t5peEUwlltVhnVlwVm0fM
         wBqiktDSYcD7WDjc8AVqrIP81xck4zaew8ZXVhPkqcWMUYZGzmlHtTZGKGHS9VGRoJmI
         Ab0EtXqUtvugK1zqVvqC+DMKJXVwbtlISMjalCIRH+EBXvpB1gAlO8GUYJUARP0ucp3/
         GcpoQujVEcUbwbyD6UTeLiCjzQYdHawZzQTBJEOoQfuUckzKp9JMZ0kbx3plFbYEb8OX
         Bk8Q==
X-Gm-Message-State: AA+aEWYGuDBZREucJErX+qiI8aViChIXTMfwxZtm5DJI0rXaQCbZ0TKT
        2va3zh4I/Zn6c2ZsUqkY6coBZb72fQY=
X-Google-Smtp-Source: AFSGD/Uoli/9J+EWCBGBnqwrlMSiQOjpuFETYcordDaQJ4OkTokm3sYZVMFTUlQLqAs+XC46G7/WvQ==
X-Received: by 2002:a62:99dd:: with SMTP id t90mr19609855pfk.179.1544017705582;
        Wed, 05 Dec 2018 05:48:25 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id j14sm26594399pfn.175.2018.12.05.05.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 05:48:24 -0800 (PST)
Subject: Re: Kernel crashes after 529262d56dbe "block: remove ->poll_fn"
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, sagi@grimberg.me,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0bd2d36e-bef0-b836-7039-124ae4d346a6@virtuozzo.com>
 <c374e085-a86b-6df3-2142-74968f067bc7@kernel.dk>
 <5e8d3302-a7d0-3483-6540-f0b87c237f7d@virtuozzo.com>
 <0e6c1e68-38b0-6618-40cd-a2b72dc4e240@kernel.dk>
 <a6efd5b2-3190-54e7-ad4c-06f9ac441641@kernel.dk>
 <20181205134727.GA26794@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0bf49b6e-19ea-5bf8-164d-4d0dbf8446fe@kernel.dk>
Date:   Wed, 5 Dec 2018 06:48:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205134727.GA26794@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/18 6:47 AM, Christoph Hellwig wrote:
> On Wed, Dec 05, 2018 at 06:39:26AM -0700, Jens Axboe wrote:
>>> What device is this?
>>
>> This might also help...
> 
> Yes, it should.  I had missed that we turned on QUEUE_FLAG_POLL
> by default, which is rather odd.  The even weirder things is that
> git-blame claims it was me who enabled it :)

No presents for you this year!

-- 
Jens Axboe

