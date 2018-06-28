Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06BBC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC4D271BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="r3SPxoQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC4D271BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=earthlink.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935372AbeF1KBA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:01:00 -0400
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:56690 "EHLO
        elasmtp-mealy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933711AbeF1KA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=earthlink.net;
        s=dk12062016; t=1530179861; bh=027suHSWk8pvWIF+xPGY72obDIxGXWHWBehm
        e2AFPyo=; h=Received:Subject:To:Cc:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP; b=r3SPxoQ
        KZ07rpfyRuufcnqg+JsH3D4ERX9tUodbv4Ykq77wwhZ4Rrypj2xKzfjJVIt7ma0bm2p
        yog8zRQvP7ig/sK7oeYx8VroSE2nhEQmjATaNqei92vYOeV2/tyzddNi1oOx1kdRMbr
        HAV+QuYNGqGoc1JkVG5VQkQyFiaJWKAM9B9I08S06UudBIk5CE3v5O2l9ddm5de4zsC
        UhF6sllu+q2akHQj8O5hoFSBwT+FDHlIeASPL1F7uVLS0ei7n2eXJUbAyp9S7JoY4DH
        e4phBJ4xBxUoOPqzmQ3LldYfRhDPP2sdvBjuyiwR+Vdofcihb91PYlmP0GEo+Qx7KjA
        ==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=earthlink.net;
  b=c0tNdtoXDwvberq8VnJE8M5TDTP8DkF3rQSYC0re8JHBFMs824PEkB8q7ITCrrlaR5btiJqSdNt4mj2I9kHFbDskyNgIiFfAudqlzaa/unREt6yXKkxuHCmrl8qG5C/I5yUyOvPEnAhYoR3Gc9vytwCMb38jpSReNvH7vPDFLhA1Y81AOgkigLPk95dLNvkyu/wnxRpia+Uf8ruiULbeCBoNp8agevMJSj25AvDeUe2Q14FNP85RdclsKQBFNJd46n/YKA7/QTNMJOz7y1CX8JffzX7BoaFTVUr9qPHkonlVPBjHXSzLsrJGfZ4vWohFPBCZWXAP/r/WCVRhrMS4og==;
  h=Received:Subject:To:Cc:References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP;
Received: from [68.183.100.61] (helo=[192.168.37.199])
        by elasmtp-mealy.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <jdow@earthlink.net>)
        id 1fYTgH-0002na-50; Thu, 28 Jun 2018 05:57:37 -0400
Subject: Re: Amiga RDB partition support for disks >= 2 TB
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <c552b9e3-03ff-75ef-18e1-35d39cfdaca5@gmail.com>
 <07b0cd8a-a353-ba45-07a1-d0e5bb80b83f@earthlink.net>
 <1556186.3D3gH2gU0T@merkaba>
From:   jdow <jdow@earthlink.net>
Message-ID: <a8bef8a7-7b99-bc91-87b6-f9e4e838a4b8@earthlink.net>
Date:   Thu, 28 Jun 2018 03:00:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1556186.3D3gH2gU0T@merkaba>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b5711209cf7ffa7a2ea362302ace4656af6bceed64b622aaf00e9d9350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.183.100.61
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20180628 01:16, Martin Steigerwald wrote:
> Dear Joanne.
> 
> jdow - 28.06.18, 08:39:
>> Anything done to RDBs for Linux must remain 100.000% compatible with
>> existing Amiga equipment. Otherwise, what's the point of bothering to
>> use RDBs?
> 
> Done to, in the sense of written to: Yes. I completely agree. But that
> is for amiga-fdisk and parted. And for partitioning tools on native OS.

Design changes, too.

> […]
>> That brings to the fore an interesting question. Why bother with RDBs
>> over 2TB unless you want a disk with one single partition? This Win10
>> monster I am using has a modest BIOS driver partition for the OS and
>> a giant data partition. That smaller partition would easily work with
>> any RDB/Filesystem combination since 2.0. So there are some good
>> workarounds that are probably "safer" and at least as flexible as
>> RDBs, one Linux has used for a very long time, too.
> 
> Well, my use case was simple:
> 
> I had this 2 TB disk and I choose to share it as a backup disk for Linux
> *and* AmigaOS 4.x on that Sam440ep I still have next to me desk here.

EEEEEEK! The hair on my neck is standing up straight! Have you heard of SAMBA? 
The linux mail server firewall etc machine has an extra 4TB disk on it as a 
backup for the other systems, although a piddly 4TB is small when I save the 
entire 3G RAID system I have. It's a proof of concept so.... A full backup on a 
1gig Ethernet still takes a looooong time. But backing up even an 18GB disk on 
an Amiga via 100Base-t isn't too bad. And disk speeds of the era being what they 
were it's about all you can do anyway.

{o.o}
