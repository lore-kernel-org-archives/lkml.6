Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B5BC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD3926664
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD3926664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932417AbeFZICK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:02:10 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:50015 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932279AbeFZICF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:02:05 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 38DD034FF29;
        Tue, 26 Jun 2018 10:02:03 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     jdow <jdow@earthlink.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: moving affs + RDB partition support to staging?
Date:   Tue, 26 Jun 2018 10:02:02 +0200
Message-ID: <1611526.WuK5Cf0iMF@merkaba>
In-Reply-To: <CAOmrzk+CuuraUnWWKDKen9FV6=UcgKgc6+qJ3g-Fx+tkt5HHQw@mail.gmail.com>
References: <20180425154602.GA8546@bombadil.infradead.org> <c76b4e4d-7e8e-13ac-81e4-9132f4235eb8@earthlink.net> <CAOmrzk+CuuraUnWWKDKen9FV6=UcgKgc6+qJ3g-Fx+tkt5HHQw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael.

Michael Schmitz - 26.06.18, 04:23:
> Joanne,
> 
> Martin's boot log (including your patch) says:
> 
> Jun 19 21:19:09 merkaba kernel: [ 7891.843284]  sdb: RDSK (512) sdb1
> (LNX^@)(res 2 spb 1) sdb2 (JXF^D)(res 2 spb 1) sdb3 (DOS^C)(res 2 spb
> 4)
> Jun 19 21:19:09 merkaba kernel: [ 7891.844055] sd 7:0:0:0: [sdb]
> Attached SCSI disk
> 
> so it's indeed a case of self inflicted damage (RDSK (512) means 512
> byte blocks) and can be worked around by using a different block size.

Well I pretty much believe that this was the standard block size of the 
tool I used in order to create the RDB. I think it has  been Media 
Toolbox + the engine behind it, from AmigaOS 4.0 (not 4.1) or so. DOS-
Type JXF points to JXFS, an AmigaOS 4 only filesystem that meanwhile has 
been deprecated by AmigaOS upstream.

Maybe HDToolbox + hdwrench.library by Joanne (AmigaOS 3.5/3.9) would 
have set it up differently.

Anyway: It works like this in AmigaOS 4 without any issues. With 512 
Byte Blocks. I think it is good that Linux does not create data 
corruption when writing to disks that work just fine in AmigaOS. 
Especially as those using AmigaNG machines like AmigaOne X1000/X5000 or 
Acube Sam machines may dual boot AmigaOS and Linux on their machines.

Thanks again for putting together a patch.

Thanks,
-- 
Martin


