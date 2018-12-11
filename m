Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC32C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBA720870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DaLh2nJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBA720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeLKSgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:36:45 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55540 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbeLKSgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:36:44 -0500
Received: by mail-it1-f195.google.com with SMTP id o19so5094385itg.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 10:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5sP8BrMmGL+4vp6LwQoT7fF2LtbFDXTIdgV2PMryJ6s=;
        b=DaLh2nJYv16RjOVbiqUfw64V7HqRZ4Tv9ZE8i1cLCdu4ECmmGypLrJo0w5FF8VMNq+
         nwtIzkmV3ZmuxoBzdqZMQdIm3ZkOUMccDTqaOvCdZoblcOxrJ0ETq0huIFOes2V/k8Vp
         54PxF/rTN/QB6yIsmHvFtEEAN78y2zVMr5X3NY+s9QpfPHwD0fFwFD+Ryqw7IJCfPtec
         LU8k0/7V2n3wOC/gW9ol0qm0Lv2Xup3LQqXrWtfeyESgQ7xkpxjIN6O2nBLv5BvhlHZJ
         WnumZjlSkQQzvIVk7jqahycGxCN4Fst5UD2xWkNnACtgFlxqV317PiC2NlyyzMivjxoB
         qn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5sP8BrMmGL+4vp6LwQoT7fF2LtbFDXTIdgV2PMryJ6s=;
        b=WIROiXv1m55ruzIvOdwezl4h7chpfwFOrHUbOl10der7EbmBf037n/l6VTT3SOV6kY
         f4lE3ZxeTp7d8/5RiN9OlA6ank3Gb4+PyejtCuvfQX8KSVhI01MZqkIEfYTYmlccm5Xj
         3kvqyDcYxcd6i2ePXUShF/n17up1a9zm4n8vflWi9DeLu79lkFJbffKapcI3zGvQLUoV
         h7mYmnZU04l0dyvUQmi4biTn2AFc1R/iWQopO9RXEA15TVU/xa95If25H5idXtw7LdhK
         wYypjRqjyycTEwWJnFJnEx35FBD9X+o59m+4HEGTZ5RADNNvkMAWbKnlVehnmP2TiL5P
         4ySA==
X-Gm-Message-State: AA+aEWa0djudYARePv0mwDly7iMIYXqVjurs+vTcItpCdU4utn2KP7Nc
        1yodLzIcDCcWK1u72DtdTeyJB1qHflDiSQ==
X-Google-Smtp-Source: AFSGD/WgGbL2T4a6OSY1ns7v8VGRbKeU9HH/DIAs1SdJhZ9ZeePZkTYYVuuAh8Q5FXSKwVi71u3PTQ==
X-Received: by 2002:a02:1b1d:: with SMTP id l29mr16620921jad.98.1544553403731;
        Tue, 11 Dec 2018 10:36:43 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id a17sm702500ioc.67.2018.12.11.10.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 10:36:42 -0800 (PST)
Subject: Re: [PATCH] aio: Convert ioctx_table to XArray
From:   Jens Axboe <axboe@kernel.dk>
To:     Jeff Moyer <jmoyer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kent.overstreet@gmail.com
References: <20181128183531.5139-1-willy@infradead.org>
 <x49va46e1p0.fsf@segfault.boston.devel.redhat.com>
 <x49pnuee1gm.fsf@segfault.boston.devel.redhat.com>
 <x49mupcm11r.fsf@segfault.boston.devel.redhat.com>
 <20181211175156.GF6830@bombadil.infradead.org>
 <x495zw0lz68.fsf@segfault.boston.devel.redhat.com>
 <0f77a532-0d88-78bc-b9cc-06bb203a0405@kernel.dk>
 <6b9a45c4-47a2-4c44-aa7e-6e5e90eff9df@kernel.dk>
Message-ID: <78dfbfa3-b2d1-4e9d-f59c-b263678a9866@kernel.dk>
Date:   Tue, 11 Dec 2018 11:36:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6b9a45c4-47a2-4c44-aa7e-6e5e90eff9df@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 11:32 AM, Jens Axboe wrote:
> On 12/11/18 11:05 AM, Jens Axboe wrote:
>> On 12/11/18 11:02 AM, Jeff Moyer wrote:
>>> Matthew Wilcox <willy@infradead.org> writes:
>>>
>>>> On Tue, Dec 11, 2018 at 12:21:52PM -0500, Jeff Moyer wrote:
>>>>> I'm going to submit this version formally.  If you're interested in
>>>>> converting the ioctx_table to xarray, you can do that separately from a
>>>>> security fix.  I would include a performance analysis with that patch,
>>>>> though.  The idea of using a radix tree for the ioctx table was
>>>>> discarded due to performance reasons--see commit db446a08c23d5 ("aio:
>>>>> convert the ioctx list to table lookup v3").  I suspect using the xarray
>>>>> will perform similarly.
>>>>
>>>> There's a big difference between Octavian's patch and mine.  That patch
>>>> indexed into the radix tree by 'ctx_id' directly, which was pretty
>>>> much guaranteed to exhibit some close-to-worst-case behaviour from the
>>>> radix tree due to IDs being sparsely assigned.  My patch uses the ring
>>>> ID which _we_ assigned, and so is nicely behaved, being usually a very
>>>> small integer.
>>>
>>> OK, good to know.  I obviously didn't look too closely at the two.
>>>
>>>> What performance analysis would you find compelling?  Octavian's original
>>>> fio script:
>>>>
>>>>> rw=randrw; size=256k ;directory=/mnt/fio; ioengine=libaio; iodepth=1
>>>>> blocksize=1024; numjobs=512; thread; loops=100
>>>>>
>>>>> on an EXT2 filesystem mounted on top of a ramdisk
>>>>
>>>> or something else?
>>>
>>> I think the most common use case is a small number of ioctx-s, so I'd
>>> like to see that use case not regress (that should be easy, right?).
>>> Kent, what were the tests you were using when doing this work?  Jens,
>>> since you're doing performance work in this area now, are there any
>>> particular test cases you care about?
>>
>> I can give it a spin, ioctx lookup is in the fast path, and for "classic"
>> aio we do it twice for each IO...
> 
> Don't see any regressions. But if we're fiddling with it anyway, can't
> we do something smarter? Make the fast path just index a table, and put
> all the big hammers in setup/destroy. We're spending a non-substantial
> amount of time doing lookups, that's really no different before and
> after the patch.

Looks like it's the percpu ref get, in terms of "lookup" we already
look pretty good.

-- 
Jens Axboe

