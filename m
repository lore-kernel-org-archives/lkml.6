Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E7EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D3A206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XI4YPeV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbfAPDRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 22:17:41 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41111 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729097AbfAPDRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 22:17:40 -0500
Received: by mail-pg1-f194.google.com with SMTP id m1so2134949pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 19:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A8fjqfuCZbV1Ss+ytPCtexDUFcNd+R7NIsyurRBRh74=;
        b=XI4YPeV4w46qxFzP3O6/I7SDYYBqmyrprR0BQ8MKKja0VHQpb/c39p5+d6vgYhr6aE
         FeE8C6zEEsNKmY5js1affbLD/Wwo0sxImo3ZZbu/Ed+n1zhfM61p+0TeS+FN0phCMyhA
         tyGGA+gR4nxlK87wsWsw7YhqBR9hgc854fKkVBNs43vKUwZj8+Y02MVeDK5sVXglOICR
         EkfhP9NsRPzAK8UgpkSWiyXoDG9AddE+Mo2kJSb3vKvXGwy9XBn+nZIB7oLVzsheUDmb
         Xvj4+gDKT2OHcXWA5SjHrOpRV3Tb60eRVOkxR7TX8CU/9G6o+dGYqKf7jEr9csbR822u
         4SbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A8fjqfuCZbV1Ss+ytPCtexDUFcNd+R7NIsyurRBRh74=;
        b=ivpFOAWI3LTXKa5fJb/BU3VBFgAC9AUmR5QHS0fnqfCuzVX1kHGqcD1rGGQ9MixSAu
         +tXeIPxBUg2ygKeECB5yHVFMItM5lTIcGr/JYR4XFQ6n1MavKH7tEofmrSON23w7y0ow
         5geTqNXYj4MIKmvSPqPspAZQWq27/D3H/qX0glr9TfX6JfCTJyv6byTqaC9lQ3M4j6ft
         W5XPJMs9ZH0mFnHYAAZ5fg4NveneeuQaDQPu9q9badNv407FaHfpHtenhl/QZg0ehouC
         AUasrjKk88cbig2StMa/ugdcV8zcPEsMhVtUb5iv6CUJbW58KjM710eNmEc3PFa1cnp+
         QDOA==
X-Gm-Message-State: AJcUukdW2fYT51YpVtGWEFmOIhyLqgwKlAPopJBIG4X2lUnfWi5pTqYl
        O2TxPjGADBBaR56dFOsEsZ4nYg==
X-Google-Smtp-Source: ALg8bN6JSfskxQJoK/KDIJ0/WIRwW89JNUqX5h1Gqf3dHTJIxSX6VgGjWFxVjaFUUdXNy33avlot8A==
X-Received: by 2002:a62:5c1:: with SMTP id 184mr7371169pff.165.1547608659338;
        Tue, 15 Jan 2019 19:17:39 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 78sm8662533pft.184.2019.01.15.19.17.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 19:17:38 -0800 (PST)
Subject: Re: linux-next: manual merge of the block tree with the fscrypt tree
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>
References: <20190116132522.1b756433@canb.auug.org.au>
 <ca843f39-3fcd-1a03-34c9-7284f10fe262@kernel.dk>
 <20190116031301.GC26146@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a1ce4d1d-13e0-c765-bf22-55fd67c9f1d4@kernel.dk>
Date:   Tue, 15 Jan 2019 20:17:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116031301.GC26146@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/19 8:13 PM, Ming Lei wrote:
> On Tue, Jan 15, 2019 at 07:55:39PM -0700, Jens Axboe wrote:
>> On 1/15/19 7:25 PM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Today's linux-next merge of the block tree got a conflict in:
>>>
>>>   fs/ext4/readpage.c
>>>
>>> between commit:
>>>
>>>   acc9eb0a6073 ("ext4: add fs-verity read support")
>>>
>>> from the fscrypt tree and commit:
>>>
>>>   eb754eb2a953 ("block: allow bio_for_each_segment_all() to iterate over multi-page bvec")
>>>
>>> from the block tree.
>>>
>>> I fixed it up (see below - the former moved the code modified by the
>>> latter) and can carry the fix as necessary. This is now fixed as far as
>>> linux-next is concerned, but any non trivial conflicts should be mentioned
>>> to your upstream maintainer when your tree is submitted for merging.
>>> You may also want to consider cooperating with the maintainer of the
>>> conflicting tree to minimise any particularly complex conflicts.
>>
>> Ming, I'm pulling this, I thought we agreed none of these bullshit
>> renames? The fact that a patch looks like this:
>>
>> -               for_each_bvec(bv, (it)->bvecs, __cur_iter, __cur_iter)        \
>> +               for_each_segment(bv, (it)->bvecs, __cur_iter, __cur_iter)     \
>>
>> is SUPER annoying and does NOTHING but to cause merge conflicts.
>>
>> Resend it without that.
> 
> We need to differentiate 'segment' with 'bvec' in bvec helpers, which is
> usually seldom used by drivers. For example, only two in-tree users(ceph, iov_iter).
> That is why I rename it, and seems Christoph prefers to do it too.

If you want to do a rename, then we do it after. I don't want to deal with
weeks and weeks of fallout from this. Write a rename script that we can
then run at the end of the next merge window. You're going to be playing
catch-up until that happens if we go the current route, and honestly
I'm not at all interested in the fallout from that.

I know exactly what will happen until 5.1-rc opens, and what my tree will
look like from having to deal with this. And then I know exactly what Linus
is going to say, and I can't even argue against it, since he'll be totally
right.

Hence it's not going to happen this way.

-- 
Jens Axboe

