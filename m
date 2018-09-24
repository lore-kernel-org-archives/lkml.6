Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCE2ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDD920C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fJ2E6rxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDD920C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbeIXXw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:52:58 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55496 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbeIXXw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:52:57 -0400
Received: by mail-it1-f194.google.com with SMTP id c23-v6so3597832itd.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gvjrS2GhMjxr+neoEq5hTDN2Nb/weh/WOvMr8kIrZbM=;
        b=fJ2E6rxdg/NEPdj62G0AXDI+K9c7Mnwv5Hyqi6/PAdZvqs3HuqMESAuvEARKfN03wh
         Mfw65Nv4b31mm+Zt7tuXNsNT48CmSwuGt7QEmIMjVWH9p0hnEvv23YxOmdV9/cdyNi+u
         UEaFUlX7kfQw8YE6q2OlIspQi08T9lpMlUUR/iHdDG7AlOQRIEnpovxmRwaD6NZIm/ic
         Kjzq3XVM51/KXa8F+tbRuZYWoNEYZyNlP/CSr+61saS+RqOIYPbwqfmlCpQJ3ajp1VcV
         TFjTWtE+mv9GPvh9UM+4Ng7F15OKDbxSOZu+OCtGVwLQoPmN0xrTr4aZxkBNaNOjK5QC
         dIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gvjrS2GhMjxr+neoEq5hTDN2Nb/weh/WOvMr8kIrZbM=;
        b=N8CiAw26W67+g9tIZQ1iU0xkWRpHkE4wedEKujZmnKMOpqfgp/mgf/bxZHHffjDQVO
         rBqlCm+b7LIXzq69EHnCKpiggGyUXD4GB6TWyuqZSc62NKJLvED6NwGCC533UxX/Fil6
         P7d8DBewMPgxx6elHPq28B1gU77NfOOXY+3l7f2QDBDiickm0VIHqJ26V0xQ2Wa1hRWW
         kCrS+aDP8XKjGfm8E6ZV7MeMSD0subUEbtSG2gzy9NFjga2KYgd7HgdPx0sGI9XYORGi
         K/bfROwWLndazGfDxl1F3Pcgu0jvb9CPL4rZFxVnNbsSpcuhlfhvjYQ0ShposBPXMC9r
         j3RA==
X-Gm-Message-State: APzg51CLk34Mwgnl7EU+vhRLr8k612hfzuflMKp9v9SU4wqYCKigWEkZ
        Mjn+bHTWD9qKNs6h9niuuy+VJw==
X-Google-Smtp-Source: ANB0VdarV49goD/cgmdKgMDyRnKL21Wbq/nJlpZiltaCHmWzk+yFOr/eYEqe+4lHTcS4DrYIxm2zCg==
X-Received: by 2002:a02:94e5:: with SMTP id x92-v6mr10343077jah.67.1537811379173;
        Mon, 24 Sep 2018 10:49:39 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v6-v6sm2298769ioh.42.2018.09.24.10.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 10:49:37 -0700 (PDT)
Subject: Re: block: DMA alignment of IO buffer allocated from slab
To:     Christopher Lameter <cl@linux.com>, Christoph Hellwig <hch@lst.de>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1f88f59a-2cac-e899-4c2e-402e919b1034@kernel.dk>
Date:   Mon, 24 Sep 2018 11:49:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <010001660c54fb65-b9d3a770-6678-40d0-8088-4db20af32280-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/18 10:06 AM, Christopher Lameter wrote:
> On Fri, 21 Sep 2018, Christoph Hellwig wrote:
> 
>> On Fri, Sep 21, 2018 at 03:04:18PM +0200, Vitaly Kuznetsov wrote:
>>> Christoph Hellwig <hch@lst.de> writes:
>>>
>>>> On Wed, Sep 19, 2018 at 05:15:43PM +0800, Ming Lei wrote:
>>>>> 1) does kmalloc-N slab guarantee to return N-byte aligned buffer?  If
>>>>> yes, is it a stable rule?
>>>>
>>>> This is the assumption in a lot of the kernel, so I think if somethings
>>>> breaks this we are in a lot of pain.
>>>
>>> It seems that SLUB debug breaks this assumption. Kernel built with
>>>
>>> CONFIG_SLUB_DEBUG=y
>>> CONFIG_SLUB=y
>>> CONFIG_SLUB_DEBUG_ON=y
>>
>> Looks like we should fix SLUB debug then..
> 
> Nope. We need to not make unwarranted assumptions. Alignment is guaranteed
> to ARCH_KMALLOC_MINALIGN for kmalloc requests. Fantasizing about
> alighments and guessing from alignments that result on a particular
> hardware and slab configuration that these are general does not work.

The summary is that, no, kmalloc(N) is not N-1 aligned and nobody should
rely on that. On the block side, a few drivers set DMA alignment to
the sector size. Given that things seem to Just Work, even with XFS doing
kmalloc(512) and submitting IO with that, I think we can fairly safely
assume that most of those drivers are just being overly cautious and are
probably quite fine with 4/8 byte alignment.

The situation is making me a little uncomfortable, though. If we export
such a setting, we really should be honoring it...

-- 
Jens Axboe

