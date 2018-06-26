Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1647FC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2962267DB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="cBBjLraZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2962267DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=earthlink.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933985AbeFZJcK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:32:10 -0400
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:42612 "EHLO
        elasmtp-curtail.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932558AbeFZJcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=earthlink.net;
        s=dk12062016; t=1530005658; bh=/4qo3q8SZXlcfG5cT84A33Zx2cuyWWklqet/
        oDuFvj4=; h=Received:Subject:To:Cc:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP; b=cBBjLra
        ZBKmZdC8CfVWqihWB70F7XD4o1Ns3G7VklzVpmQT0TLXrVo43HrRJEdjnuH6t+9U1Wg
        LO8ygY/9HlGQZcShcMnKX+GiDdc6NNyH/IySD/EuayZotZn2nQ2On5ovRB3jjE/Ziii
        NwkHXewhxcOHtRdbEiJ8SZZ5lxkXppm4OKvuzsITVyFySOz77wH8hahrDDskJs5a8OV
        sIpZaUOfN4pm3dfDaljGWZ3eUlnjfmLpRyNHPAoP239c86gypkOvOzlJVkMwyDKyLC5
        QcI1jL+yBEPu7BjJlzS6L7Kog8mpN7xu+ZzfuVs2C+dxwA1ybzTTBmXFh1dS2511ZNQ
        ==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=earthlink.net;
  b=El+XA5X49NFd2NrtdESC9TRR/TLOsj2AwwHXcG0sGR3LRv78GvhaxCE9HyB9+jy5xxVP2B7DEde6YjqUHDaySPg7l/cI8wZWBtG41hgI5K9eki+I4e29AZA3Zxg+Q5lPVDHK2NXueLqjxBvq6d4PHskIK2OtwcD1KBKAvlhmeUPECmba/nZhkkEBppBKeSr5E943ynifZwHjij4Xn7AyRjsF2EJ95FtSqyCHxqp9aibphqT63EO8regFCgjaHOmCu6TNCAqYn8iV0l/0WgbEyo+P1MQBIsYjkt6mWT+MVmErZOQwtALrXuZD46z028JI5Fhdi0fyD/sY9IQL1gsWVw==;
  h=Received:Subject:To:Cc:References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP;
Received: from [68.183.100.61] (helo=[192.168.37.199])
        by elasmtp-curtail.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <jdow@earthlink.net>)
        id 1fXkMY-0009PV-8L; Tue, 26 Jun 2018 05:34:14 -0400
Subject: Re: moving affs + RDB partition support to staging?
To:     Martin Steigerwald <martin@lichtvoll.de>,
        Michael Schmitz <schmitzmic@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <c76b4e4d-7e8e-13ac-81e4-9132f4235eb8@earthlink.net>
 <CAOmrzk+CuuraUnWWKDKen9FV6=UcgKgc6+qJ3g-Fx+tkt5HHQw@mail.gmail.com>
 <1611526.WuK5Cf0iMF@merkaba>
From:   jdow <jdow@earthlink.net>
Message-ID: <2485b9b9-8e3f-c001-1d9e-18858ca166bd@earthlink.net>
Date:   Tue, 26 Jun 2018 02:31:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1611526.WuK5Cf0iMF@merkaba>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b571120e34ac1e402a3b8c142b39a0514d123dbfa28775b88914bb8350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.183.100.61
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HDToolBox is not mine. That is where the intelligence is needed.

{^_^}

On 20180626 01:02, Martin Steigerwald wrote:
> Michael.
> 
> Michael Schmitz - 26.06.18, 04:23:
>> Joanne,
>>
>> Martin's boot log (including your patch) says:
>>
>> Jun 19 21:19:09 merkaba kernel: [ 7891.843284]  sdb: RDSK (512) sdb1
>> (LNX^@)(res 2 spb 1) sdb2 (JXF^D)(res 2 spb 1) sdb3 (DOS^C)(res 2 spb
>> 4)
>> Jun 19 21:19:09 merkaba kernel: [ 7891.844055] sd 7:0:0:0: [sdb]
>> Attached SCSI disk
>>
>> so it's indeed a case of self inflicted damage (RDSK (512) means 512
>> byte blocks) and can be worked around by using a different block size.
> 
> Well I pretty much believe that this was the standard block size of the
> tool I used in order to create the RDB. I think it has  been Media
> Toolbox + the engine behind it, from AmigaOS 4.0 (not 4.1) or so. DOS-
> Type JXF points to JXFS, an AmigaOS 4 only filesystem that meanwhile has
> been deprecated by AmigaOS upstream.
> 
> Maybe HDToolbox + hdwrench.library by Joanne (AmigaOS 3.5/3.9) would
> have set it up differently.
> 
> Anyway: It works like this in AmigaOS 4 without any issues. With 512
> Byte Blocks. I think it is good that Linux does not create data
> corruption when writing to disks that work just fine in AmigaOS.
> Especially as those using AmigaNG machines like AmigaOne X1000/X5000 or
> Acube Sam machines may dual boot AmigaOS and Linux on their machines.
> 
> Thanks again for putting together a patch.
> 
> Thanks,
> 
