Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6191C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC27D2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="igLkuJ/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC27D2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeLKSFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:05:16 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:36269 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbeLKSFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:05:16 -0500
Received: by mail-it1-f181.google.com with SMTP id c9so5363597itj.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 10:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pyKR+gozXkLNrKKhrpt5D+hcCDuAYM42zKYof/e8FeM=;
        b=igLkuJ/oJsiSD/VhCTm0XFqq0GyhfC2k3d3pbadPl6TV2mciaJdFoC2rrXSi53hjYo
         2CWclP/gtjSoP24fcOjo656QkNbkUYupEJXho7WCucSNpAPzlSDs1YKL6I8XiWUVV/gA
         td/SFCV+XIw6soiX5ffj8wzOFGYuWhhcEAluObv2CfoWNNfqUfnyMjQqp6b4iwb68nhG
         1Pq2lUhtJTuvdDPTSCMbdX2k/v+5MbO/6bayx/IP7+J/CwdYyLyNVrqxyZwCJog8bnhy
         JleTX0ypLBKafhmb3iKXc2BwpKVRiqluh8H8GEqpgzQm0AYgC61/29HT+JCBusuZX0JE
         Hsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pyKR+gozXkLNrKKhrpt5D+hcCDuAYM42zKYof/e8FeM=;
        b=XSyHfR5P3EaoTH+7axHylfTg9/Ct8hpruP1/UVcdC+RR3864+703fiNYUbln1FlvtU
         DUFAhaIZhQ9vuD2S23SMFV/ynZCvFC0ih5xayxJ5S2CIOMTia9GO31AG2Fn3l87C4z6d
         PRLCWR7MyYqBgbUM9MohiG2CPCH53Th95MRRQeE2dRDlwOnDZRlJUTTJGBvw7canSmGV
         NVdb2ov/8EXcQ5AJ0aEcUr9KMJKIpxE6jZWqZ4/pJYGgtwYW7GDaz86vT7gUpk8fqYmM
         5WgL72g2ycqWCoOiTlD5oX1NRCidOeogOpOInZ1GyRCkzXk0fib/rZkpFcQGaPdhze7M
         6aaQ==
X-Gm-Message-State: AA+aEWaEsR0QgTPDUiWgILkoIUIHvykKJsfrAr60UT28d3LVFJe5BdV3
        MsRdqpr3eg3n2LJZdgWyob+0Ow==
X-Google-Smtp-Source: AFSGD/X24hP539+78tJNiKlrl2RrjV4lT17kI9mrdDVuoQ0qRserfBVgOBzLMCCe/niaTjdC5dSIZg==
X-Received: by 2002:a24:5a8f:: with SMTP id v137mr3040345ita.65.1544551514803;
        Tue, 11 Dec 2018 10:05:14 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 79sm1620832itx.11.2018.12.11.10.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 10:05:13 -0800 (PST)
Subject: Re: [PATCH] aio: Convert ioctx_table to XArray
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0f77a532-0d88-78bc-b9cc-06bb203a0405@kernel.dk>
Date:   Tue, 11 Dec 2018 11:05:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <x495zw0lz68.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 11:02 AM, Jeff Moyer wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
>> On Tue, Dec 11, 2018 at 12:21:52PM -0500, Jeff Moyer wrote:
>>> I'm going to submit this version formally.  If you're interested in
>>> converting the ioctx_table to xarray, you can do that separately from a
>>> security fix.  I would include a performance analysis with that patch,
>>> though.  The idea of using a radix tree for the ioctx table was
>>> discarded due to performance reasons--see commit db446a08c23d5 ("aio:
>>> convert the ioctx list to table lookup v3").  I suspect using the xarray
>>> will perform similarly.
>>
>> There's a big difference between Octavian's patch and mine.  That patch
>> indexed into the radix tree by 'ctx_id' directly, which was pretty
>> much guaranteed to exhibit some close-to-worst-case behaviour from the
>> radix tree due to IDs being sparsely assigned.  My patch uses the ring
>> ID which _we_ assigned, and so is nicely behaved, being usually a very
>> small integer.
> 
> OK, good to know.  I obviously didn't look too closely at the two.
> 
>> What performance analysis would you find compelling?  Octavian's original
>> fio script:
>>
>>> rw=randrw; size=256k ;directory=/mnt/fio; ioengine=libaio; iodepth=1
>>> blocksize=1024; numjobs=512; thread; loops=100
>>>
>>> on an EXT2 filesystem mounted on top of a ramdisk
>>
>> or something else?
> 
> I think the most common use case is a small number of ioctx-s, so I'd
> like to see that use case not regress (that should be easy, right?).
> Kent, what were the tests you were using when doing this work?  Jens,
> since you're doing performance work in this area now, are there any
> particular test cases you care about?

I can give it a spin, ioctx lookup is in the fast path, and for "classic"
aio we do it twice for each IO...

-- 
Jens Axboe

