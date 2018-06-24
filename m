Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1A0C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 11:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BA124EB1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 11:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="LsrxGlic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BA124EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=earthlink.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbeFXLkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 07:40:11 -0400
Received: from elasmtp-galgo.atl.sa.earthlink.net ([209.86.89.61]:33502 "EHLO
        elasmtp-galgo.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750795AbeFXLkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 07:40:09 -0400
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Jun 2018 07:40:09 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=earthlink.net;
        s=dk12062016; t=1529840598; bh=tYhhJKU+J3HpYKjYBNMc1Iyt9r/V3Xa3LREx
        PyUKIeo=; h=Received:Subject:To:Cc:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP; b=LsrxGli
        ck7ARSYRBmhUyDvP7LdUFIwwbyjBQCX4WzxCxM3TUn6VlzJ+steNpXqdqH0tTEHzupK
        Zk+lVmYQKWAyc+W8WKdiqrW8RyWDFNMhOWI/m+xz2/K/S9P6DotJWk7L1i44xcFtAnN
        aTUoqUG7rdnlOmdjZorP0jsFysxkVymAhdqIiP/E6M6LyZrE7ymCKu91I90bRi6oR9V
        u7dqyrD93PwtaORgtyQwnoTgs2+qa6DpjqAL+7URFWUJ2BMhED/DrGwiAq5r8ymRaQ2
        Uo8vlOCdE5jjUR/oKQLhtL9UbApm2t0G8WRyRbwd+opp7MYTfYQqvyoQpgXVGxW5pOQ
        ==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=earthlink.net;
  b=KUNK0FGuDc/GUI+ZUY2PNcHqgQqS3ZJwLHmArtIZScbZz+2GB9ex+ori12cOpYTB3xyLmhdZ3NNuSn8lDiKObvCOPD4KUkq/RGSKxvHzVql1n2fNeu2ECrhEWiifM6uDjFlF1QY9I7yHe2t0byl22Ozo4bHxW+ZO3hYYn48O+Mu7SnFqu48RkrrVlHk3uTmMucOsqantVFg/8q/WzRBTPswS9dA2Gk0U+MuGAK0FKwW0Nxy8v+awHMSQj7E9tTy9TO+dy7g52iQUGPhMUJUThNoYvJYzod+1ilZMmTGTLz6e99/95j5+NjBdT1P9wux6nobDLelNAfSYALkhYmIe8Q==;
  h=Received:Subject:To:Cc:References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP;
Received: from [68.183.100.61] (helo=[192.168.37.199])
        by elasmtp-galgo.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <jdow@earthlink.net>)
        id 1fX3QI-0003VO-HI; Sun, 24 Jun 2018 07:43:14 -0400
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
Message-ID: <c76b4e4d-7e8e-13ac-81e4-9132f4235eb8@earthlink.net>
Date:   Sun, 24 Jun 2018 04:40:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1910962.ItDVNtUG5Q@merkaba>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b5711203ea72318b6ae6b4436380d5cacdda059111b7d63be367df8350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.183.100.61
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BTW - anybody who uses 512 byte blocks with an Amiga file system is a famn dool.

If memory serves the RDBs think in blocks rather than bytes so it should work up 
to 2 gigablocks whatever your block size is. 512 blocks is 2199023255552 bytes. 
But that wastes just a WHOLE LOT of disk in block maps. Go up to 4096 or 8192. 
The latter is 35 TB.

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
