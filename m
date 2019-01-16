Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A78FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2604820859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="O/yLpiwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbfAPCzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:55:44 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41810 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730410AbfAPCzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:55:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id m1so2111815pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 18:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NlCNJRfq+FMwOQQsz5Mv+iueRK/wVSIhGkujcxgikKc=;
        b=O/yLpiwHJuNO3lVO+4VCFezhfKFym7B8BAAvEH/ijmF/xomX/OfGeraL4o5GDQ/PIC
         3HTNQDpCzgNPY4UiDq6p3AEgtQBaEXvfZVbQrZSRGMQZm2AJxmyhHjB5OROg0aGzrjFN
         ekqMl6MAHUFgEnf5LICpzhLSqdpRJpg7B4MKvrtYu383C1qnJ+tThhvLG09k6anFLn/h
         FPN1YnGQCqFaZXKRS65ckDdnVV+eTZhbJGTK+Xa8MgJPiyzvwIZHiteTZrvdGlTqo0x2
         8ABfJyne3NtiWEfaAXjbVA7kNfh3X+QAB8K1bA3r4YwW5dN7l36P3OOQhCdpM968jZ2S
         FqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NlCNJRfq+FMwOQQsz5Mv+iueRK/wVSIhGkujcxgikKc=;
        b=ookBfiu3MGXQMr8s0OuGhNOyp61k1AvEcD/tE6uIsuNcK6KIodmHVL6yMAIeDFKgw5
         n57aNRObLvV+QJM7L8E1yXBewNiwQCzUPrQXpy+6jt12rkcxWvC1znXbI67dYdzG0G6b
         6YKBNSSp/5u5YnQS0aJ1h41EWQUdRtwx69nhutYzzNYGxtwPQ+qjXyNn9HxiLuQ5Cp2b
         AAt8Z4/cgLBAA4Tfm8avFCRIXT2kOPGWor1UzFy0MposUnznFPcCEpyuMzYOy0Gi4HYp
         MEsJMkCq9hcZ1M9Ee8AdDSnyGNSBibEcdSf6UFDOsmK0y38lcXWs1EJn9duQcWe4Z815
         nKVg==
X-Gm-Message-State: AJcUukeuOC3KnBP6VLQdxYbr3/dAFQxU66Xmet1cJy/tWXp3PHMmbr9+
        po+7XEt63CSYj6aJ0gSOAOEpkUNy/mANVw==
X-Google-Smtp-Source: ALg8bN7cf8y7XE1xrpqYQSt36u+UhqmOLCE1F8/UpW2WWeLYrhixLq1g4hv6FdqQi1z1J+LVgu+Aig==
X-Received: by 2002:a63:e001:: with SMTP id e1mr6756010pgh.39.1547607342255;
        Tue, 15 Jan 2019 18:55:42 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id h82sm10777045pfa.105.2019.01.15.18.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 18:55:41 -0800 (PST)
Subject: Re: linux-next: manual merge of the block tree with the fscrypt tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Eric Biggers <ebiggers@google.com>
References: <20190116132522.1b756433@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ca843f39-3fcd-1a03-34c9-7284f10fe262@kernel.dk>
Date:   Tue, 15 Jan 2019 19:55:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116132522.1b756433@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/19 7:25 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the block tree got a conflict in:
> 
>   fs/ext4/readpage.c
> 
> between commit:
> 
>   acc9eb0a6073 ("ext4: add fs-verity read support")
> 
> from the fscrypt tree and commit:
> 
>   eb754eb2a953 ("block: allow bio_for_each_segment_all() to iterate over multi-page bvec")
> 
> from the block tree.
> 
> I fixed it up (see below - the former moved the code modified by the
> latter) and can carry the fix as necessary. This is now fixed as far as
> linux-next is concerned, but any non trivial conflicts should be mentioned
> to your upstream maintainer when your tree is submitted for merging.
> You may also want to consider cooperating with the maintainer of the
> conflicting tree to minimise any particularly complex conflicts.

Ming, I'm pulling this, I thought we agreed none of these bullshit
renames? The fact that a patch looks like this:

-               for_each_bvec(bv, (it)->bvecs, __cur_iter, __cur_iter)        \
+               for_each_segment(bv, (it)->bvecs, __cur_iter, __cur_iter)     \

is SUPER annoying and does NOTHING but to cause merge conflicts.

Resend it without that.

-- 
Jens Axboe

