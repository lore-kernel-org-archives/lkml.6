Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD72BC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A016266F6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bunXGjuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A016266F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932954AbeFZIkt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:40:49 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:39378 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752481AbeFZIkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:40:45 -0400
Received: by mail-it0-f48.google.com with SMTP id p185-v6so1134260itp.4;
        Tue, 26 Jun 2018 01:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=BJBegf//6W0+lBO6YSwLvQ3bFAywIo7vnQ486jTccRQ=;
        b=bunXGjuT4F9FYiYvpKiwopojhS5sAXXRroqVeHhf9PauPYapKUUrEOrOXqO/XO6ee8
         3U/2EzMRULYojyxrdFtizvhi6znHFNx535JS1BMlYwSsakrjF1Fd4V2lDGVkpTsHRXXG
         XI3xHoc3sN6PUhkAFL/4H6zbWKXkSYK998pqt5isdbH3z/zxhe5YQEZ32qYkVVuETH0Z
         WK1PzyC+qLifTux8mesAtQsHmLmnvSFHaKwNb/uiwQ2rd+Ksz9hpGrOGbZnE/wa4r89s
         iObXM581hIy/sgGImEkoyPOnZF1NCmYSkcgIZ4U5/UzocVO9uCAot23CZtHXK/CEpXij
         Tr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=BJBegf//6W0+lBO6YSwLvQ3bFAywIo7vnQ486jTccRQ=;
        b=arGPMiGG7ZKVqRYZrq3YwAIZW18/qY3cC8ng2uxS7alLJLPGNxAKvKLN4aEWNLILEB
         U+ZJzPnHiX6sWJQsLIoutShluQn29yTyDMTHYg3v87JBbtOkvvwT2k6qQeXm4rguFVWG
         xlPic/quO79V/gOlbqmI/QH/bh/cMQvI47sogFMO1cPhBX1km/HatT6gSqLGyjIsyj/0
         xX0kyHK3N+E2sA2RHNeiTCg0DfSF7S6dZBUjod2u33aXTVG/N0V7wiW/B7ixGjFL9W6j
         KmNcp3rns/y7/q/MGLW31VK55tDGjUYMyUgAvWT4yrlcyoegzW8SzkGtDfmx8qrIlPsN
         9cpA==
X-Gm-Message-State: APt69E2waYq2ckCQ8i9KiD90b+K11puE8Uyq//xREPbc9tsC5v8iPNm9
        yfPESZXd0E2Wl7UfZn7Bc9U=
X-Google-Smtp-Source: AAOMgpfM7Agg02mUQWiJe03iO5OuKSLvIO7zfsRh49V83DPGcy8BcEnF4M+pZMoNDQcrGoWVsO++Og==
X-Received: by 2002:a02:4550:: with SMTP id y77-v6mr498162jaa.12.1530002444661;
        Tue, 26 Jun 2018 01:40:44 -0700 (PDT)
Received: from Schmitz-MBP.telecom (222-154-41-72-adsl.bb.spark.co.nz. [222.154.41.72])
        by smtp.googlemail.com with ESMTPSA id e18-v6sm655619itf.29.2018.06.26.01.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 01:40:43 -0700 (PDT)
Subject: Re: moving affs + RDB partition support to staging?
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     jdow <jdow@earthlink.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <70a446d7-f0d4-f086-b634-f7bb0db6d2ab@gmail.com>
Date:   Tue, 26 Jun 2018 20:40:36 +1200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1611526.WuK5Cf0iMF@merkaba>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,


Am 26.06.18 um 20:02 schrieb Martin Steigerwald:
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
> Well I pretty much believe that this was the standard block size of the 
> tool I used in order to create the RDB. I think it has  been Media 

No offense meant - 512 bytes per block would certainly have been the
default and it certainly wasn't obvious that this needed changing.

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

That's the goal.

> Thanks again for putting together a patch.

The hard work had been done by Joanne and you six years ago, so no
matter at all. If Jens and the crowd at linux-block point out errors in
review, I take that as a learning experience...

Cheers,

     Michael


>
> Thanks,

