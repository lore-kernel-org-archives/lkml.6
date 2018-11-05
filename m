Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA67DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0C82081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQXr5oHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0C82081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387490AbeKFB2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:28:06 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:46420 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbeKFB2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:28:06 -0500
Received: by mail-io1-f54.google.com with SMTP id y22-v6so6836169ioj.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 08:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k9p+tBu5HvWbjVvK+KG64/i7HPnw3HQt2b0njU5ufOg=;
        b=UQXr5oHDBc74XwmpgdW+NCg+pphV6IWkQEfgLb6T08mCr/a9PS4+0eduhe3OOe9OAj
         psf8YZKaFyZTqBkdz7CuGBm+T3NEkJStqDCc+07Uoq0wSL/GFejuQz+d4rLjye5sNrRS
         h7q0M2jF4a/9J9mxj1uLdW3cwZli4NskUhG8oZTRn0fKpdPx/tLYIKOk3Cc82+G0uc9w
         l79adcjfvjX/gVify+EUnJD0dWlRwp+j99r3aONqzq966IetNnLWXQvGK9Q8DP3Y60Px
         k5tfXGzCrzvz1KfO56MUFXGj6ZAHwok4T0HBP/jgwomMde3dlumBclMG978Fsxo3tR6k
         qaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k9p+tBu5HvWbjVvK+KG64/i7HPnw3HQt2b0njU5ufOg=;
        b=GFA+VhMu+tZZTfcmctjSOprwU9Zw+Dy+tDMAJLP3y6bKllB+MopslYBwcdLofaMpwa
         CJRXQxMRJu7r37e4dmixYnX4WRFnUpfrH0ZMRladAPiZlAhNlYNARc1+qhm48v4+VWku
         4qQgkuL4kgVCuBirl70SSrZwlbBxPjfG7wHGoLEex6ketp3anR0ZGXk5TZGvPIYGpW7x
         2j2+FuoJA1MtvdHIzTbevbmcEuKslo+O+2+4dyH0e8jtClepBAKqmIEAD29TpKIB7Tz2
         0n/EJv9VjHFTjFsN5VKRP+4LFwEZe91qVuQ4IcBc0KmzkJAvaj+RRiPzWqJT+dhuHzo1
         LV1Q==
X-Gm-Message-State: AGRZ1gKkj/fg+yccCkF0RGUyTM6VwAfGq6cmiegQkK4NXhbummgL6CLr
        KU4feyduugO5RVxhVjHuNBw=
X-Google-Smtp-Source: AJdET5egfXXEeT1ry7Sz85sif/n4dHiv4/8cyYc8ym3WkZWN+UU0tqAbtAneSQ4Xo0aYT8WKZd7xCw==
X-Received: by 2002:a6b:8e44:: with SMTP id q65-v6mr11534227iod.197.1541434062444;
        Mon, 05 Nov 2018 08:07:42 -0800 (PST)
Received: from [191.9.209.46] (rrcs-147-0-47-180.central.biz.rr.com. [147.0.47.180])
        by smtp.gmail.com with ESMTPSA id k3-v6sm2698375iop.26.2018.11.05.08.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 08:07:41 -0800 (PST)
Subject: Re: Creating compressed backing_store as swapfile
To:     Adam Borowski <kilobyte@angband.pl>,
        Pintu Agarwal <pintu.ping@gmail.com>
Cc:     linux-mm@kvack.org, open list <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org
References: <CAOuPNLjuM5qq3go9ZFZcK0G5pQxTQb0DY36xu+8SL4vC4zJntw@mail.gmail.com>
 <20181105155815.i654i5ctmfpqhggj@angband.pl>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <79d0c96a-a0a2-63ec-db91-42fd349d50c1@gmail.com>
Date:   Mon, 5 Nov 2018 11:07:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181105155815.i654i5ctmfpqhggj@angband.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/2018 10:58 AM, Adam Borowski wrote:
> On Mon, Nov 05, 2018 at 08:31:46PM +0530, Pintu Agarwal wrote:
>> Hi,
>>
>> I have one requirement:
>> I wanted to have a swapfile (64MB to 256MB) on my system.
>> But I wanted the data to be compressed and stored on the disk in my swapfile.
>> [Similar to zram, but compressed data should be moved to disk, instead of RAM].
>>
>> Note: I wanted to optimize RAM space, so performance is not important
>> right now for our requirement.
>>
>> So, what are the options available, to perform this in 4.x kernel version.
>> My Kernel: 4.9.x
>> Board: any - (arm64 mostly).
>>
>> As I know, following are the choices:
>> 1) ZRAM: But it compresses and store data in RAM itself
>> 2) frontswap + zswap : Didn't explore much on this, not sure if this
>> is helpful for our case.
>> 3) Manually creating swapfile: but how to compress it ?
>> 4) Any other options ?
> 
> Loop device on any filesystem that can compress (such as btrfs)?  The
> performance would suck, though -- besides the indirection of loop, btrfs
> compresses in blocks of 128KB while swap wants 4KB writes.  Other similar
> option is qemu-nbd -- it can use compressed disk images and expose them to a
> (local) nbd client.

Swap on any type of a networked storage device (NBD, iSCSI, ATAoE, etc) 
served from the local system is _really_ risky.  The moment the local 
server process for the storage device gets forced out to swap, you deadlock.

Performance isn't _too_ bad for the BTRFS case though (I've actually 
tested this before), just make sure you disable direct I/O mode on the 
loop device, otherwise you run the risk of data corruption.
