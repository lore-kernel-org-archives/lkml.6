Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6242FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0350820873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=postn.eu header.i=@postn.eu header.b="nPiM7cBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfANQ0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:26:48 -0500
Received: from postn.eu ([84.200.50.9]:58486 "EHLO postn.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfANQ0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:26:48 -0500
Received: from [127.0.0.123] (cloakedhost.private [127.0.0.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by postn.eu (Postfix) with ESMTPSA id 3B2455FEEF;
        Mon, 14 Jan 2019 17:26:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postn.eu; s=mail;
        t=1547483206; bh=WdRXu6ZhCOhpiqO0d/EjoBEhXJxC86C3emP0UdKgq9M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nPiM7cBAEVNTaLJ9o0lGfPIoLCZaHIcT/POG26q10dd+lrhjDnke39HY/6byTyMzh
         SbNjjNKwl8PegxGOXpdCWPz1axCav4mNJNjDCMYWDO8BVePhRmqXrLiRoJES/r6/rw
         JUKb65hKnrFoROQA8NQSULqrHOdUI68Tl/X9WEJg=
Subject: Re: udf: Prevent write-unsupported filesystem to be remounted
 read-write
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <124cc6ea-ca79-20f2-651e-c2f909729ac0@gmx.de>
 <8cf39b7c-505b-91e6-849d-e66ba980042f@postn.eu>
 <20190114103011.GD13316@quack2.suse.cz>
 <20190114151242.vrspcgld3n645qez@pali>
From:   Kevin Weidemann <kwe-lnx@postn.eu>
Message-ID: <1aeb551f-827e-4e4d-b373-c6f9901a798e@postn.eu>
Date:   Mon, 14 Jan 2019 17:26:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114151242.vrspcgld3n645qez@pali>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-PH
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 January 2019 at 16:12 Pali Rohár wrote:
> So you should not use -m dvd for hard disks.
>
> Also DVDs have block size of 2048 bytes and UDF mandates that medium
> block size matches UDF block size. Linux versions >= 4.11 do not have
> problems with it, but other operating systems enforce that rule.
>
> So you should not use -b 512 for DVD medias.

Hi Pali,

thanks for your pointers.
Interestingly enough, I chose that combination based on my test that
resulted in all (to me) relevant OSes (various Windows variants and my
set of Linux boxes) handling the resulting file system the way I
expected them to.
Choosing the bigger size of 2048 resulted in either issues when mounting
on Windows and/or having to pass a specific block size when mounting
under Linux, if I remember it correctly. It might have to do with the
block size of the block device under it. I think the point of using `-m
dvd` was to make the file system mount as read-only by default, though
it's been some months. I do remember checking what exactly `-m dvd` did
other than setting the access-type of the fs, but I must admit I don't
remember the result of that.

The main issue is, however, unaffected by this. I do agree that a
tune2fsque sort of tool as part of udftools would greatly improve the
situation.
