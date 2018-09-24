Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5216ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90660214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Eihb7jRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90660214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbeIYAND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:13:03 -0400
Received: from mail-it1-f170.google.com ([209.85.166.170]:51993 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731633AbeIYAND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:13:03 -0400
Received: by mail-it1-f170.google.com with SMTP id e14-v6so11859025itf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UHCeYyqZzNK6+M3bf4mg3QpUQh57EyXFgjsqKKsrGCg=;
        b=Eihb7jRHsFUSBQ7rNZLWVsmUrDeA1VbPk29jqAXyvL7i32hh/aEFfy50fW9Z/Ax6vL
         wvHcjGSl6FnZbgNGMdhR+r4KtHC1VAU6MH3zHVB/sFTuRjKC1UbUp3vi7298zIGXlIs3
         dLSXeChXM0oEXn/4ssG5PntyoCKbbw9cmdygg45QOoxR83GRaxc9hJre6vhbriAqygY0
         yz8/vEbU77LfdanfpZW7+AZZsJZQbekag9taXDkxTBHAJRTJ5m7fzDANi2EazFXPl7HS
         QQPgkJqEXf2xjE95ix72sbg09bLQnztTdvx6Y+e32SUjXLcRwmuS1jH44EA5V+0UIF/9
         qyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UHCeYyqZzNK6+M3bf4mg3QpUQh57EyXFgjsqKKsrGCg=;
        b=b4WzeZspAlk7O1Ygv4ZkmiQwH+VqHbRLAuYl7ZJwFapDirWLlLJJK6GCW3tSbj3c8t
         Nkn8aizTqygT+/E2Ds2Sbp7X383ZuLTIFNdUMUOJILehaYZBg/K/o1VdhxcLlfgjXCdn
         7H+6dZ5Jxpybd5KYWlvCwmDZ1rRi5wWSvDn5UAsZ1FamAgpULPgZuLBHk7hLoU7Ygpb9
         JaGN0ayb2d2zEnIQ2oFVJ40tGA53fnWyJoMS8/q3vV1MlQAJ7gpbkkA5Dxy/e+bvrJNx
         s7+t3YpmH4Itfcr+5oFL/3tkyMmDTTmDXDB9wSBCG3263nWIH/cAkgalzAc/XbyY5wYF
         Q6qQ==
X-Gm-Message-State: ABuFfoiWCwVDZDdyuD2wZmzmbtcPTRXhBwi+lTKeomKnwog8AAxnIof/
        C4KKXb5gdw7DT17tNTiHxBa4+w==
X-Google-Smtp-Source: ACcGV6354j3hOuH/c3H+IleEzd1hDuPCpe4UWhyHKugMjfk5b6uVOs7jBTdAd00cjLv+Saw8J+yPYA==
X-Received: by 2002:a02:898d:: with SMTP id p13-v6mr31670jaj.74.1537812579878;
        Mon, 24 Sep 2018 11:09:39 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t134-v6sm6846988itb.41.2018.09.24.11.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 11:09:38 -0700 (PDT)
Subject: Re: block: DMA alignment of IO buffer allocated from slab
To:     Christopher Lameter <cl@linux.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
 <20180920063129.GB12913@lst.de> <87h8ij0zot.fsf@vitty.brq.redhat.com>
 <20180921130504.GA22551@lst.de>
 <010001660c54fb65-b9d3a770-6678-40d0-8088-4db20af32280-000000@email.amazonses.com>
 <1f88f59a-2cac-e899-4c2e-402e919b1034@kernel.dk>
 <010001660cbd51ea-56e96208-564d-4f5d-a5fb-119a938762a9-000000@email.amazonses.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1a5b255f-682e-783a-7f99-9d02e39c4af2@kernel.dk>
Date:   Mon, 24 Sep 2018 12:09:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <010001660cbd51ea-56e96208-564d-4f5d-a5fb-119a938762a9-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/18 12:00 PM, Christopher Lameter wrote:
> On Mon, 24 Sep 2018, Jens Axboe wrote:
> 
>> The situation is making me a little uncomfortable, though. If we export
>> such a setting, we really should be honoring it...
> 
> Various subsystems create custom slab arrays with their particular
> alignment requirement for these allocations.

Oh yeah, I think the solution is basic enough for XFS, for instance.
They just have to error on the side of being cautious, by going full
sector alignment for memory...

-- 
Jens Axboe

