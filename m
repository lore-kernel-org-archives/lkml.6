Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA0BC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AE82086B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yXZ7N81O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2AE82086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388551AbeKPCiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:38:46 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45387 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbeKPCiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:38:46 -0500
Received: by mail-io1-f67.google.com with SMTP id w7so7186837iom.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 08:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tx62oY/cQGEQBatE3T+ZeNxDEUkb6ZnVjpvyQS2CbEs=;
        b=yXZ7N81O4WaHO2liYAjKeUMC7J8Ygqqmyhi6Wd03NuR5xOx0MzCvYs4eN/RfnXK1JU
         ObIqEzKIctWYhf1R9HDq4v0j1clVAMJqCTBBaBsKB+KjNwUS2Pc1e2jXdoXZeeGKvFe4
         VsCWGaqJ/6+ZQ6pTv5k2fo389eZ3lB2ZoWBf5Pb6n3z76p0Ht+pyCZlJUZE06fTaOFtw
         VGt+pnW9MeEN1cAPgoLDZv1Xt0plfUBNlga/jVx4gSdBvUS2f1AQZFxVS+V3+kPvVhOM
         GnGG4fderMfma0gQfUCtGptN9YWQiiY0l6g/I1faSvYURftxw8U3SQwVB0DCJ1u6Ypb7
         hYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tx62oY/cQGEQBatE3T+ZeNxDEUkb6ZnVjpvyQS2CbEs=;
        b=my0EgztqHd826TAUtMlU+nW0xZgaEJChMoKX8QEU4qNi3sS70uccyG6TRkMSR2s7ST
         sb+I/LsVqmg3oxL88SO1z1UPtaYA/nX552zdVYG6HIahEkMYrX6kTWy5ecXF69f1+Znb
         nMtRDEmf4kMl9Y05jO0jBFKjNaPQ2jHP55WRmGOeisL5n6zCB/LtmUx+htQixXDG/Xc4
         emjvc46eelLL6IFyyOPUhsATbUCuDX/+QvjJMZobtAFcImcp+jOJlayXXvkkL6fGQyDj
         IeG8VghlOftiLVU1G7F5AHQWe4eykgGVpYG9tFhyQlfQgrUtfXNkUopdBQLgOy7gxuXF
         Q8Mw==
X-Gm-Message-State: AGRZ1gKvq3Zom4vhRK7jwUtbC34wABVhaXizX1RwHcYanAdP5OjHhnS/
        yhIcjU0b69VhlVLD+zTMn+bOWw==
X-Google-Smtp-Source: AFSGD/WV+bsznzSatMkCuMk+godCpeIRmk9fH1CyeA+Y4ejgUTBx5nkMTnpVtf4+Y2BtHEWQYQZANQ==
X-Received: by 2002:a6b:ee13:: with SMTP id i19-v6mr5687729ioh.69.1542299414868;
        Thu, 15 Nov 2018 08:30:14 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x22-v6sm9810833ioh.2.2018.11.15.08.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 08:30:13 -0800 (PST)
Subject: Re: [PATCH 00/12] unify the interface of the proportional-share
 policy in blkio/io
To:     Angelo Ruocco <angelo.ruocco.90@gmail.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        lennart@poettering.net
References: <20181112095632.69114-1-paolo.valente@linaro.org>
 <9e8adb3271680165d85994a225713391@natalenko.name>
 <E8A20452-A73C-4A31-B5EC-48EFB9937832@linaro.org>
 <e85cfae0-7743-8c51-c2c9-0855c26f868e@kernel.dk>
 <CADiTV-37tqWsbxmeZJsqq+pqSqxN-_L9+T9R+PmBBJhfO-G09g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <79a2da26-669a-359c-3832-354ec2b47231@kernel.dk>
Date:   Thu, 15 Nov 2018 09:30:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CADiTV-37tqWsbxmeZJsqq+pqSqxN-_L9+T9R+PmBBJhfO-G09g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 4:54 AM, Angelo Ruocco wrote:
> Hi Jens,
> 
> I have rebased the patchset against the for-4.21/block branch, but I
> can't test them properly because the compiling process has an error on
> a different file. In particular:
> 
> include/net/xfrm.h:1465:3 error: unknown type 'spruct'
> include/net/xfrm.h:1465:30 error: expected ':', ',', ';', '}' or
> '__attribute__' before 'auth'
> 
> To be clear, and so that you can check I haven't made some trivial
> mistakes: I have added/fetched the remote [1] and then simply rebased
> against the for-4.21/block branch.

I think you have memory issues, a 'p' is just one bit away from a 't'.

-- 
Jens Axboe

