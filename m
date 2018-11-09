Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC34C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0E320883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MWzjAqHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0E320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbeKJF0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:26:32 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33541 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbeKJF0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:26:32 -0500
Received: by mail-it1-f194.google.com with SMTP id p11-v6so5237052itf.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 11:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KCJAxbNs6jbm9awHvnOB45DGu6gqEyepnM1LUxgobOo=;
        b=MWzjAqHPceT0HbeXzMeGo5P+r/Zjk0JUsTjxFWLub279+HiEPF5pod2KdLN1cvSDcJ
         +T3egbplDRjJaPC3V+u3wZKspOnZsCprYv6rJJWy/M2wb1Ct+CZEd4SMnPRxbdAOr+iM
         Jba5yAJ6aU+bTN/l+IuVQ7u92PUOYlM0xhPlUOsv/UPpk/Z5secAGkZSJ+COUebfaG5I
         z9DMIsUZYEQpQH5sZLCiCXyUsD+obHGvaOVbFTM2+S7WPTKAjTSxLH5jf2+6Cy9vjat2
         Y0TdWp5tnymy7uc+o/bRthHkr/DBH/Bj/wETBdbCDyZoQdYU/9NthdzmGcoLqfsXSPlv
         WZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KCJAxbNs6jbm9awHvnOB45DGu6gqEyepnM1LUxgobOo=;
        b=O7p7gklVBRqWjhb8RGxmUs/Gx4EEey1HHQuZfVzyda4FduSfKb3fc9ekOUosHIlcLp
         ts9NigUOeY+cylQW/Cv03htRiINZuGcdZEfwv5cGHZoTCPxtWBgEnWp+6goYvurBx4Lv
         6BnthO+p4i7b/G3zZGwcB3SVaaxOkCDrSbVP3nc1AeuMzsIFLsAJfSMIEmevnKF1e8KO
         j20wMnlInHpsIIvy9sc/BOMqCStLLxyR2rCMJmVcGfzZn25yZjm/7dlTTcBFSHZShXQu
         vOAacCdqxesD74UqpResYEsctPHQg0Kwraz/O6dm7dw91ykhN11LTJgpYgA/vL3/jiT1
         AAMw==
X-Gm-Message-State: AGRZ1gLXC3ncCAt9V4Z/Fog7aiBIhgCPn7HRzDe85BK4lLWjcNGYqyVf
        7m7nzIKQ+s6ifA3R2ygIT0p04w==
X-Google-Smtp-Source: AJdET5dsQ2UtdKXFeOsI0yKf9lXCnxamujGOiLUA86A9rZt641ma6+8nHXg7BWomsKR3YgB/8M/irA==
X-Received: by 2002:a24:446:: with SMTP id 67-v6mr3471208itb.150.1541792669845;
        Fri, 09 Nov 2018 11:44:29 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id a185-v6sm1079460itc.14.2018.11.09.11.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 11:44:28 -0800 (PST)
Subject: Re: [PATCH V8 00/18] block: support multi-page bvec
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel@vger.kernel.org
References: <20181109162610.18981-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ac1b9d7-46b9-b546-b2df-800014f1a2ff@kernel.dk>
Date:   Fri, 9 Nov 2018 12:44:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181109162610.18981-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/18 9:25 AM, Ming Lei wrote:
> Hi,
> 
> This patchset brings multi-page bvec into block layer:
> 
> 1) what is multi-page bvec?
> 
> Multipage bvecs means that one 'struct bio_bvec' can hold multiple pages
> which are physically contiguous instead of one single page used in linux
> kernel for long time.
> 
> 2) why is multi-page bvec introduced?
> 
> Kent proposed the idea[1] first. 
> 
> As system's RAM becomes much bigger than before, and huge page, transparent
> huge page and memory compaction are widely used, it is a bit easy now
> to see physically contiguous pages from fs in I/O. On the other hand, from
> block layer's view, it isn't necessary to store intermediate pages into bvec,
> and it is enough to just store the physicallly contiguous 'segment' in each
> io vector.
> 
> Also huge pages are being brought to filesystem and swap [2][6], we can
> do IO on a hugepage each time[3], which requires that one bio can transfer
> at least one huge page one time. Turns out it isn't flexiable to change
> BIO_MAX_PAGES simply[3][5]. Multipage bvec can fit in this case very well.
> As we saw, if CONFIG_THP_SWAP is enabled, BIO_MAX_PAGES can be configured
> as much bigger, such as 512, which requires at least two 4K pages for holding
> the bvec table.
> 
> With multi-page bvec:
> 
> - Inside block layer, both bio splitting and sg map can become more
> efficient than before by just traversing the physically contiguous
> 'segment' instead of each page.
> 
> - segment handling in block layer can be improved much in future since it
> should be quite easy to convert multipage bvec into segment easily. For
> example, we might just store segment in each bvec directly in future.
> 
> - bio size can be increased and it should improve some high-bandwidth IO
> case in theory[4].
> 
> - there is opportunity in future to improve memory footprint of bvecs. 
> 
> 3) how is multi-page bvec implemented in this patchset?
> 
> The patches of 1 ~ 13 implement multipage bvec in block layer:
> 
> 	- put all tricks into bvec/bio/rq iterators, and as far as
> 	drivers and fs use these standard iterators, they are happy
> 	with multipage bvec
> 
> 	- introduce bio_for_each_bvec() to iterate over multipage bvec for splitting
> 	bio and mapping sg
> 
> 	- keep current bio_for_each_segment*() to itereate over singlepage bvec and
> 	make sure current users won't be broken; especailly, convert to this
> 	new helper prototype in single patch 21 given it is bascially a mechanism
> 	conversion
> 
> 	- enalbe multipage bvec in patch 13 
> 
> Patch 14 redefines BIO_MAX_PAGES as 256.
> 
> Patch 15 documents usages of bio iterator helpers.
> 
> Patch 16~18 kills NO_SG_MERGE.
> 
> These patches can be found in the following git tree:
> 
> 	git:  https://github.com/ming1/linux.git  for-4.21-block-mp-bvec-V8
> 
> Lots of test(blktest, xfstests, ltp io, ...) have been run with this patchset,
> and not see regression.
> 
> Thanks Christoph for reviewing the early version and providing very good
> suggestions, such as: introduce bio_init_with_vec_table(), remove another
> unnecessary helpers for cleanup and so on.
> 
> Any comments are welcome!

I'd really like to see this make 4.21 finally. I'm busy these days and
will be next week as well, but I'll try and set aside some time to
review it - and I encourage others to do the same!

-- 
Jens Axboe

