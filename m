Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0A6C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B61C2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BTvrLZbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B61C2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeJXLzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:55:50 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:45794 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJXLzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:55:49 -0400
Received: by mail-wr1-f52.google.com with SMTP id n5-v6so74515wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 20:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UL0FnEkKan/Ci2vKER5bbj1QIuQpnn8aTQPNAhMgD9g=;
        b=BTvrLZbmXVW9+XxS+XODnGMD6tLKARJD5Gmio5YoxWNg4ppi1Goli03eEmhyRnCFKq
         KMj/2yUfeRl+IjlDdW3oRx2HtPpgVsz5gfDcbpv7fr/Ij/bVk+zBzkL2Gu9++eqv10QD
         pkBVdj58ZiI0Lk4i9Io+EVPvzxbXaj77Nt4U0qd0OgLx6y0q5KIfGdJK974J3nZAhKZh
         nQ/cqlNgn4AULOezGixwI4grEO+9J6yyHqP/UokH0Zcyj5dFE6/OUYMOLfn8W5l3mchH
         oTBACq3aBuy0fsG1qQoHLvefF/fbdXwEy47sWZhu6DafrKVeBZay/+T9xlsdndLVqONh
         ZWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UL0FnEkKan/Ci2vKER5bbj1QIuQpnn8aTQPNAhMgD9g=;
        b=hjdGR39jpW08hnk9GuLCLAs9ZN0N/iKfOzK0npminjPIcR73gVuTDDUeGeT9ssclP4
         k3ILOGqXt9nCtEUWp2wx4CvhGy7nZqqlkXrSMgvsvaA5kVd4QXIUK33ln0ARdplVlxOI
         KdGtM+sK9PLxpHkgVg8d25fVeho2evw+h8JmO19HVEAv22TZpaKeLl0ULOj8VHPTAqWi
         +wLC15WQPe6ER2uV3xYHguxLYFt9Knww6gRevfxGR4LVKMKkQqvlaZsV6HXQjL3YaJyX
         n/UvopGSbZT6Jg6NWQI7w+UbOuxRJ6n9JCWM7tnqkTbfm2F8xtB0h19AjvBut662Ee9i
         9ZUQ==
X-Gm-Message-State: AGRZ1gJWG6JrgyNQG76nDtGY5gbmnlwmH/glsMgXpeJ30TbbK0y4PYgd
        kwgYLAJuLCUdeVsViyhrlX+tykImqj0uHw==
X-Google-Smtp-Source: AJdET5cEalNZDfESpHwLRY1sIVkVN19Ge6SRbBzEQJxl96pdyo79IwbUDOEyL/YhLs0Gjjbj02TR0w==
X-Received: by 2002:adf:e2c1:: with SMTP id d1-v6mr570733wrj.26.1540344264407;
        Tue, 23 Oct 2018 18:24:24 -0700 (PDT)
Received: from [10.111.198.69] ([109.144.219.254])
        by smtp.gmail.com with ESMTPSA id x8-v6sm6351396wrd.54.2018.10.23.18.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 18:24:23 -0700 (PDT)
Subject: Re: [LKP] [null_blk] e50b1e327a: blktests.block.022.fail
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
References: <20181024011914.GL24195@shao2-debian>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cc431c8d-b877-8b8e-dee7-6993ed0e6799@kernel.dk>
Date:   Tue, 23 Oct 2018 19:24:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181024011914.GL24195@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/18 7:19 PM, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: e50b1e327aeb4b224364aa6f85c1713ff8b3654b ("null_blk: remove legacy IO path")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: blktests
> with following parameters:
> 
> 	disk: 1HDD
> 	test: block-group2

[snip]

These are expected, it'll fail to load with queue_mode=1 when
that path is removed. I'll send an update to blktests to only
run that test for kernels that support it.

-- 
Jens Axboe

