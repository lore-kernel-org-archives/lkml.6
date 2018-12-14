Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C523BC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC0B20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dt3ld9K9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC0B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeLNGP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:15:26 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38610 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNGP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 01:15:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so2238353plb.5;
        Thu, 13 Dec 2018 22:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=58i+t0kU8F4VDq4ZxuUKVo/OgJwAtPkO3y9tiFyJ/Bo=;
        b=Dt3ld9K9kI5vmgBnLnAcBhIWJgkt1thXvuPlvMiNptKONNRi9f5En0TkP8ryO1cLeR
         vXiwwarQdYvYDQX2/Gu97fn7zi7vzsOHZsZZ0aX+AeAvbk/147g3gKcmO3h6gNheliaJ
         Q6AfuXFVUI5ZgSJznWAUaABLiXJKW6yFFbVQAmtrr026UCm7TxfIdiF9l86q5JvJR388
         BPcApoTuxv+QTQm6U6iLYe5g6+I0wX+MIqV4p7+De97ptLHFtjgwLewh0hN3IjIlBxhI
         Fnu8/gBxyKy3VYhVCQNXvhmvD3XIaNVl8y2Veu3OWb5fPTe1RormoHI/2k8ECmi95Uct
         qmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=58i+t0kU8F4VDq4ZxuUKVo/OgJwAtPkO3y9tiFyJ/Bo=;
        b=a2Nfn7PR805c50BpwnFg109ynS6JlO20t3dsgNDANof5gro6vIM2IIULmJbz3qxlq1
         rblQ+vZB6vjnODSvAHRCqCFXsV3kYk/qSxyzjWwXSBdx8KcvrjkpCshCNVbc5E68yEgi
         ZSKPE243GOWznOgpmBSPl9k4sPd+amWBdYL2KeJ/bnCoKtj7faDgBdA9S/onGt+mPvmX
         z6AZdpwkmdEygxr4Fym5KGBl6SBZolOBaX9UMEeI2VPmSqk0ioFliVjC+LQ7h7DmFzUB
         7+IJ7mP3GhecLUk2IhFAssFmPesSJYqem4fQyKjwGFM8M/LbWKRZUnDitqZfrT/00cEV
         deTQ==
X-Gm-Message-State: AA+aEWZtdWb9xHFNT4gn00seMLaAh3Y4shtWVRb22gIa/OUczD5JzROw
        KSE2FlbHCj1IjFIZYd7u1qes4xkUqL0=
X-Google-Smtp-Source: AFSGD/Vgg9eJlQN+rgWpFX7vf1be4itDGESMbuRl/FLdDSAVXS2RAyOIeNd55RwbnAs8cjBhuzSprg==
X-Received: by 2002:a17:902:9a07:: with SMTP id v7mr1659858plp.247.1544768125131;
        Thu, 13 Dec 2018 22:15:25 -0800 (PST)
Received: from [0.0.0.0] (104.194.84.186.16clouds.com. [104.194.84.186])
        by smtp.gmail.com with ESMTPSA id 89sm6649679pfl.120.2018.12.13.22.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 22:15:24 -0800 (PST)
Subject: Re: ubifs: fix page_count in ->ubifs_migrate_page()
To:     Dave Chinner <david@fromorbit.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org
References: <1544624037-3436-1-git-send-email-openzhangj@gmail.com>
 <5829763.q4qAXljTxb@blindfold> <20181213225736.GF29416@dastard>
From:   zhangjun <openzhangj@gmail.com>
Message-ID: <e477c69a-082b-586b-a45a-50dee2b530ca@gmail.com>
Date:   Fri, 14 Dec 2018 14:15:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213225736.GF29416@dastard>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/14 上午6:57, Dave Chinner wrote:
> On Thu, Dec 13, 2018 at 03:23:37PM +0100, Richard Weinberger wrote:
>> Hello zhangjun,
>>
>> thanks a lot for bringing this up!
>>
>> Am Mittwoch, 12. Dezember 2018, 15:13:57 CET schrieb zhangjun:
>>> Because the PagePrivate() in UBIFS is different meanings,
>>> alloc_cma() will fail when one dirty page cache located in
>>> the type of MIGRATE_CMA
>>>
>>> If not adjust the 'extra_count' for dirty page,
>>> ubifs_migrate_page() -> migrate_page_move_mapping() will
>>> always return -EAGAIN for:
>>> 	expected_count += page_has_private(page)
>>> This causes the migration to fail until the page cache is cleaned
>>>
>>> In general, PagePrivate() indicates that buff_head is already bound
>>> to this page, and at the same time page_count() will also increase.
>
> That's an invalid assumption.
>
> We should not be trying to infer what PagePrivate() means in code
> that has no business using looking at it i.e. page->private is private
> information for the owner of the page, and it's life cycle and
> intent are unknown to anyone other than the page owner.
>
> e.g. on XFS, a page cache page's page->private /might/ contain a
> struct iomap_page, or it might be NULL. Assigning a struct
> iomap_page to the page does not change the reference count on the
> page.  IOWs, the page needs to be handled exactly the same
> way by external code regardless of whether there is somethign
> attached to page->private or not.
>
> Hence it looks to me like the migration code is making invalid
> assumptions about PagePrivate inferring reference counts and so the
> migration code needs to be fixed. Requiring filesystems to work
> around invalid assumptions in the migration code is a sure recipe
> for problems with random filesystems using page->private for their
> own internal purposes....
>
> Cheers,
>
> Dave.
I agree with your main point of view, but for the buffer_head based file 
system this assumption is no problem,
and the parameters and comments from the migrate_page_move_mapping() 
function:
   * 3 for pages with a mapping and PagePrivate/PagePrivate2 set.
This assumption has been explained.
Or to accurately say that the migrate system does not currently have a 
generic function for this case.
Since you call the function implemented for buffer_head, you should 
follow its rules.

