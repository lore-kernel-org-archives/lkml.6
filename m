Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61447C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C4720675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ui6KGInA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393505AbfAPO1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:27:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37479 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbfAPO1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:27:32 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so3110283plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 06:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gK4mfBGLBrh5POBPW2X5qTnQBKWYXHGFQBIKi/qw64s=;
        b=Ui6KGInAxCpbrCQzslYXq51lQ3HsLayqz/AVnSe/KNcXRjVTfw/xYgsSohFhoSzn9r
         aaE2pbNLowRm6wPmRF/UlE0qoBkvPJSt2ocyTQQdB6GEaIoH3Ubw4HcNKvWxBat6wUwa
         NCp2LnX06cXBh/ofbxlJc25Eb28dHXUz8Rj2eT3JkY1nTSjUDXM9686x8mIZibe3Helg
         DEsmnCFioUorVRJzZqpE5N+FUax4NSN14Lsy0/9fGvtRAMqxqE7vJKBjnINlq+nAK2t+
         a5fFS6M5oGmdKx8uvAgYZcUpOCZZ3H3Tl/LtaJz1cQpSuwbWDCbAT1jckpymri/S5Izc
         Hzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gK4mfBGLBrh5POBPW2X5qTnQBKWYXHGFQBIKi/qw64s=;
        b=tYvJNlsbKu3F3bjLsGii3GxQuNAXUXlQWt6W+XIuoKRkzZlhFP7mUFfVJAlXfYvy68
         lMy2e6ZFy60iJ1CxEumofI65VK4bcJndDVXcYu4I8H4vKhxzhHb8XCGlEvT6Erdv8hCJ
         EK9hMsOddnlZYhNkt8CaS8fwWP36UHbj2345/pWxM6SJbbvZpG7tKKvZgyxgzaiLZ1ko
         03sDaXMqgwT7DSfy/HkHym3FkZgR6raNy2h9pdCs8CZSu6niKh7spgzXCdr4j1sU+2gb
         JnvA8CxmRO6ghlgeSDxfFjOBc1i1O2IYmW1gBv7lpioKn1fzGTUH3WhvaffWJcajGwnL
         Xzlw==
X-Gm-Message-State: AJcUukd1d+oxnT46TY++ACSGFn6zbZlTTbKUR+r/KtRI6xiBRACRMs68
        A+AHLyAiUWWWnTxBF8cY3MjQNw==
X-Google-Smtp-Source: ALg8bN7Nq5IWYjCaOaqn4HRZyfgPqLja+nJunKXMbaIUDzWiF55NTjKkX3LKHDhly2IbSh0yoOkrGg==
X-Received: by 2002:a17:902:32c3:: with SMTP id z61mr10128272plb.114.1547648850951;
        Wed, 16 Jan 2019 06:27:30 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e86sm9073777pfb.6.2019.01.16.06.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 06:27:28 -0800 (PST)
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
 <a1ce4d1d-13e0-c765-bf22-55fd67c9f1d4@kernel.dk>
 <20190116073915.GA1089@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <62f1085d-a436-d0ab-6bc1-2b3d7d0ea2c7@kernel.dk>
Date:   Wed, 16 Jan 2019 07:27:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116073915.GA1089@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 12:39 AM, Ming Lei wrote:
> On Tue, Jan 15, 2019 at 08:17:36PM -0700, Jens Axboe wrote:
>> On 1/15/19 8:13 PM, Ming Lei wrote:
>>> On Tue, Jan 15, 2019 at 07:55:39PM -0700, Jens Axboe wrote:
>>>> On 1/15/19 7:25 PM, Stephen Rothwell wrote:
>>>>> Hi all,
>>>>>
>>>>> Today's linux-next merge of the block tree got a conflict in:
>>>>>
>>>>>   fs/ext4/readpage.c
>>>>>
>>>>> between commit:
>>>>>
>>>>>   acc9eb0a6073 ("ext4: add fs-verity read support")
>>>>>
>>>>> from the fscrypt tree and commit:
>>>>>
>>>>>   eb754eb2a953 ("block: allow bio_for_each_segment_all() to iterate over multi-page bvec")
>>>>>
>>>>> from the block tree.
>>>>>
>>>>> I fixed it up (see below - the former moved the code modified by the
>>>>> latter) and can carry the fix as necessary. This is now fixed as far as
>>>>> linux-next is concerned, but any non trivial conflicts should be mentioned
>>>>> to your upstream maintainer when your tree is submitted for merging.
>>>>> You may also want to consider cooperating with the maintainer of the
>>>>> conflicting tree to minimise any particularly complex conflicts.
>>>>
>>>> Ming, I'm pulling this, I thought we agreed none of these bullshit
>>>> renames? The fact that a patch looks like this:
>>>>
>>>> -               for_each_bvec(bv, (it)->bvecs, __cur_iter, __cur_iter)        \
>>>> +               for_each_segment(bv, (it)->bvecs, __cur_iter, __cur_iter)     \
>>>>
>>>> is SUPER annoying and does NOTHING but to cause merge conflicts.
>>>>
>>>> Resend it without that.
>>>
>>> We need to differentiate 'segment' with 'bvec' in bvec helpers, which is
>>> usually seldom used by drivers. For example, only two in-tree users(ceph, iov_iter).
>>> That is why I rename it, and seems Christoph prefers to do it too.
>>
>> If you want to do a rename, then we do it after. I don't want to deal with
>> weeks and weeks of fallout from this. Write a rename script that we can
>> then run at the end of the next merge window. You're going to be playing
>> catch-up until that happens if we go the current route, and honestly
>> I'm not at all interested in the fallout from that.
>>
>> I know exactly what will happen until 5.1-rc opens, and what my tree will
>> look like from having to deal with this. And then I know exactly what Linus
>> is going to say, and I can't even argue against it, since he'll be totally
>> right.
>>
>> Hence it's not going to happen this way.
> 
> I can remove the renaming in patch 'block: rename bvec helpers', but
> change on bio_for_each_segment_all() is inevitable, and it is still an
> API change, so merge conflict can't avoid too.

That's not what I'm complaining about, API changes are inevitable for
something like this. What I'm complaining about is the very example
I posted above, and which has already caused issues. That's a frivolous
name change. Don't do it.

-- 
Jens Axboe

