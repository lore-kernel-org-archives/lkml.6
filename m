Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81B7C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A00A2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hIKX4zGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A00A2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbeIYVxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:53:04 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35927 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbeIYVxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:53:04 -0400
Received: by mail-it1-f193.google.com with SMTP id c85-v6so7134738itd.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 08:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=StOrjGbh4tB2+3d19NYRTmusxtp4kq45HoFZkNDg+uk=;
        b=hIKX4zGJSkMn7bBlOCLYD8s16mAMLE5+wwQ93Mttjjt8GvYXVVATI8TPux0aq514nr
         JWELvk9sYKOvoLBbyM9hP5rsq9nLyYQYsfNob4oTEPLvq0eW26CWOLe1DneJJsKCXi7V
         ARPUBom2czeporKjEoy2KkpsHfNVLejBAJ8qbqjPPXSTURiG8NFyULSsW61Na8v+w4y1
         maVGt7TzoYCoPUiWvrihZ0doTvV1meZb0NjGjfKWro6YCqSqdLrAcjjhSns3chL7h0nr
         CD1SFoS5D6f0DUPN5mLtm6eJsT48c/mwWXh3oH0syGff1k1uTtwlhMGl8nj/hHM+umT2
         5GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=StOrjGbh4tB2+3d19NYRTmusxtp4kq45HoFZkNDg+uk=;
        b=i6t/lAjawff/rLrlKCHpu0e3HXQVNUrDlkivTVWs7V3n7uuCLADfVuKBBwGwDTwSD1
         A/3IPYEi3GzMTRNUSxn9XSdumBN47I+7YQ5Vk1jCGMQC1TDlBWe1Rdv7gI0TNCm+X53J
         +E0Sw8LMNpqugHsJNyntEEBR3VfXv5FbL6RkSkpQ1Nf5bP7SZiwcAHtAMGTrqmfRqJix
         GeFakHWU2YTIaspgGZdlj5U1gkjElSrgm/iy3T8PvQTZUUuVgBm+m5dHqMxwc+wKuP10
         njt7ZVzS36ztT/tkMvruWBOQx6mh6DWbrPSXD80qvUCAf8SrW7H6SbgA58x5RjAo67HH
         PAjw==
X-Gm-Message-State: ABuFfog5BGabhopC5uw7wcV0G3RG51GwNhaedDFs9Q0zTs5SJV1S0Bzn
        ueWh0i3v6JQ0UM8PHC2WyCImZQ==
X-Google-Smtp-Source: ACcGV632u1Z+e7NfDKH7BUvZFYG81sqeMLxi8n6fJShCLbCPTnL40TVLRrtZ2l5YGerQk2ujntK4xQ==
X-Received: by 2002:a24:8083:: with SMTP id g125-v6mr1374269itd.2.1537890297841;
        Tue, 25 Sep 2018 08:44:57 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m24-v6sm922853ioh.68.2018.09.25.08.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 08:44:56 -0700 (PDT)
Subject: Re: block: DMA alignment of IO buffer allocated from slab
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christopher Lameter <cl@linux.com>, Christoph Hellwig <hch@lst.de>,
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
 <1a5b255f-682e-783a-7f99-9d02e39c4af2@kernel.dk>
 <20180925074910.GB31060@dastard>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3d63a42f-837a-4bf6-665a-c3a8c8cb46e8@kernel.dk>
Date:   Tue, 25 Sep 2018 09:44:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925074910.GB31060@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/18 1:49 AM, Dave Chinner wrote:
> On Mon, Sep 24, 2018 at 12:09:37PM -0600, Jens Axboe wrote:
>> On 9/24/18 12:00 PM, Christopher Lameter wrote:
>>> On Mon, 24 Sep 2018, Jens Axboe wrote:
>>>
>>>> The situation is making me a little uncomfortable, though. If we export
>>>> such a setting, we really should be honoring it...
> 
> That's what I said up front, but you replied to this with:
> 
> | I think this is all crazy talk. We've never done this, [...]
> 
> Now I'm not sure what you are saying we should do....
> 
>>> Various subsystems create custom slab arrays with their particular
>>> alignment requirement for these allocations.
>>
>> Oh yeah, I think the solution is basic enough for XFS, for instance.
>> They just have to error on the side of being cautious, by going full
>> sector alignment for memory...
> 
> How does the filesystem find out about hardware alignment
> requirements? Isn't probing through the block device to find out
> about the request queue configurations considered a layering
> violation?

Right now it isn't a stacked property, so answering the question
isn't even possible beyond "what does the top device require".

> What if sector alignment is not sufficient?  And how would this work
> if we start supporting sector sizes larger than page size? (which the
> XFS buffer cache supports just fine, even if nothing else in
> Linux does).

If sector alignment isn't sufficient, then we'd need to bounce 512b
formats... But I don't want to over-design something that isn't
relevant to real life setups. I'm not aware of anything that needs
memory aligned to that degree.

> But even ignoring sector size > page size, implementing this
> requires a bunch of new slab caches, especially for 64k page
> machines because XFS supports sector sizes up to 32k.  And every
> other filesystem that uses sector sized buffers (e.g. HFS) would
> have to do the same thing. Seems somewhat wasteful to require
> everyone to implement their own aligned sector slab cache...
> 
> Perhaps we should take the filesystem out of this completely - maybe
> the block layer could provide a generic "sector heap" and have all
> filesystems that use sector sized buffers allocate from it. e.g.
> something like
> 
> 	mem = bdev_alloc_sector_buffer(bdev, sector_size)
> 
> That way we don't have to rely on filesystems knowing anything about
> the alignment limitations of the devices or assumptions about DMA
> to work correctly...

I like that idea, would probably also need a mempool backing for
certain cases.

-- 
Jens Axboe

