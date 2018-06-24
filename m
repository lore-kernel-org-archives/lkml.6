Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F72C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AAD25265
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="b0AnHCX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AAD25265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=earthlink.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754820AbeFXQQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 12:16:58 -0400
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68]:43050 "EHLO
        elasmtp-masked.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754508AbeFXQQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 12:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=earthlink.net;
        s=dk12062016; t=1529857125; bh=TVABSjFk3buI4MJlIGrUCX+slTiI2ZHjGW/p
        xmSW1Vw=; h=Received:Subject:To:Cc:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP; b=b0AnHCX
        1Xdd+hb5YdzBCHFv7+b9kwJzVB7U3c7fbHFulHvGP1PeI0ifwK28O6eC7MN3FeppUSt
        boiVrfOQ9vf1QXVV2hQlY7tzbe9mbRWa/FGBDI7BWDIaKXuPLuffP1/DvDFsGJ2Yt87
        FOF2oa7T55vSk0mJ9zcVP5WROMNegg9mRvfMR9GFpLtDYBBW8ilIHX5FCQKY3sZZ0hO
        5npFmWHclHeTl7cDh0xwRQ2sZ5Wv2BO9L1FsZeALyBkh4cAscPEoPkEPm5Msh7EuItK
        XALvFWEYAJfTP5fht9ULDZeETmwT9iiipf0GfAA0dkyOdUfgyOfZoXoQPwWVlr0YXQA
        ==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=earthlink.net;
  b=nl/mq1sTrE/+2PV4gvqlBIPua64QDmenGtIiN4qZTf5lmauScO8f6AyL3bWGZtEE9QtAeQp9lpDVy6jKiSKCDziA4+TDnGpSjU168eTfDpUUVCU+yW6fntVNK0oOICLFuL6hGYT3V7LWgbzSiX46BZmMxHZ49UMIgehidgBucWaIBqTkEJJHElY5bvlW+tV/BADH6kSW04Zy7lYZseMyAIuwwNEUD6uv59hSau1KAQ9gEf/ON0WxkTN+crJMpRyvifolzvVmxkoxTcpNjYD8GLaSUscsoywQez8e6I5DX7j64igMJlpHe5yCnNDKJuJtml+uyPBLNPwqKz5PysmpHQ==;
  h=Received:Subject:To:Cc:References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP;
Received: from [68.183.100.61] (helo=[192.168.37.199])
        by elasmtp-masked.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <jdow@earthlink.net>)
        id 1fX3II-0004yI-7r; Sun, 24 Jun 2018 07:34:58 -0400
Subject: Re: moving affs + RDB partition support to staging?
To:     Martin Steigerwald <martin@lichtvoll.de>,
        Michael Schmitz <schmitzmic@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        jdow <jdow@earthlink.net>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <CAMuHMdXt11A-3wZ2uhxF9WE-3+=VV-AbQhpXrkxnV_nwa+E4tA@mail.gmail.com>
 <CAOmrzkKunsjZzwpj9gtovKwXVkj1kTt81ea1zmB7BCDtZz409g@mail.gmail.com>
 <1910962.ItDVNtUG5Q@merkaba>
From:   jdow <jdow@earthlink.net>
Message-ID: <a6a3d542-5a91-1ee9-0738-eb10e0720492@earthlink.net>
Date:   Sun, 24 Jun 2018 04:33:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1910962.ItDVNtUG5Q@merkaba>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b5711203ea72318b6ae6b44016055a6ba94de1231a49835436c9336350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.183.100.61
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's more likely the filesystem unless I didn't get the RDBs up to 3.1 status. I 
am pretty damn sure I did as I had an 18 gigabyte disk I was using at the time. 
And I made sure it would mount with Linux. Files greater than 2 gigs were sure 
to get messed up. But that was not RDBs. The disk had 9 gigs worth of AFS 
partitions and 9 gigs worth of SFS partitions. The big SFS partition was most of 
the 9 gigabytes. (The hdf file is 8,932,818,944 bytes.) There was a tiny system 
partition on it. It used some of Bill Hawes' goodies to overlay some useful paths.

I'm not sure the machine still boots. The disk in question no longer spins up.

{^_^}

On 20180624 02:06, Martin Steigerwald wrote:
> Hi.
> 
> Michael Schmitz - 27.04.18, 04:11:
>> test results at https://bugzilla.kernel.org/show_bug.cgi?id=43511
>> indicate the RDB parser bug is fixed by the patch given there, so if
>> Martin now submits the patch, all should be well?
> 
> Ok, better be honest than having anyone waiting for it:
> 
> I do not care enough about this, in order to motivate myself preparing
> the a patch from Joanne Dow´s fix.
> 
> I am not even using my Amiga boxes anymore, not even the Sam440ep which
> I still have in my apartment.
> 
> So RDB support in Linux it remains broken for disks larger 2 TB, unless
> someone else does.
> 
> Thanks.
> 
