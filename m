Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E47C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C308A20891
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=contabo.de header.i=@contabo.de header.b="Bj02kjgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C308A20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=contabo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbeGYQYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:24:22 -0400
Received: from mail.contabo.com ([91.205.175.50]:54355 "EHLO mail.contabo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbeGYQYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=contabo.de;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FdtZ7UrMQafjP/yUL0pmqdGfURrz6ktW9ExEteFxtIc=; b=Bj02kjgfXvxGDFZyUkEQzsVF8S
        8m0mBi2iWjJy/HDEDSsL0xyIFDoGCSO22MsPt5vytrvBd5SykOKJSQ2hgY44QPegL1XzXe4JQkddV
        S6553kveMXA2OI4a7kajCpPl0MR93H5b8fvc02ltTwBSRPnjT6tkJjGEMNQJ463C22dE95jNo+zyR
        +Twb5bBML6ZU36e5oS/C+BoS4vTORCKsO9KvH0BMo3ipSJtKcHNxRgWnKorZKNGb4WTICqGUPG8xI
        tLuDzxpzJ0ZfdVka36YGfK0bc1DNr53d9qxrEinAoKKNHpwIMLf1WR+BzI3otfLRGM8ZxydrTHGCm
        PqUJYLfw==;
Received: from [178.238.239.246] (port=42318 helo=[192.168.178.123])
        by mail.contabo.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <tino.lehnig@contabo.de>)
        id 1fiLSX-00082t-HC; Wed, 25 Jul 2018 17:12:13 +0200
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
To:     Minchan Kim <minchan@kernel.org>
Cc:     ngupta@vflare.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <0516ae2d-b0fd-92c5-aa92-112ba7bd32fc@contabo.de>
 <20180724010342.GA195675@rodete-desktop-imager.corp.google.com>
 <d4f4b5a1-9e31-375d-0599-b6d8b0ebc9df@contabo.de>
 <20180725132126.GA2893@rodete-laptop-imager.corp.google.com>
From:   Tino Lehnig <tino.lehnig@contabo.de>
Message-ID: <d07348bb-3102-30f0-d138-de23449e23df@contabo.de>
Date:   Wed, 25 Jul 2018 17:12:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725132126.GA2893@rodete-laptop-imager.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mail.contabo.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - contabo.de
X-Get-Message-Sender-Via: mail.contabo.com: authenticated_id: tino.lehnig@contabo.de
X-Authenticated-Sender: mail.contabo.com: tino.lehnig@contabo.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/25/2018 03:21 PM, Minchan Kim wrote:
> It would be much helpful if you could check more versions with git-bisect.

I started bisecting today, but my results are not conclusive yet. It is 
certain that the problem started with 4.15 though. I have not 
encountered the bug message in 4.15-rc1 so far, but the kvm processes 
always became unresponsive after hitting swap and could not be killed 
there. I saw the same behavior in rc2, rc3, and other builds in between, 
but the bad state bug would only trigger occasionally there. The 
behavior in 4.15.18 is the same as in newer kernels.

> I also want to reproduce it.
> 
> Today, I downloaded one window iso and execute it as cdrom with my owned
> compiled kernel on KVM but I couldn't reproduce.
> I also tested some heavy swap workload(kernel build with multiple CPU
> on small memory) but I failed to reproduce, too.
> 
> Please could you told me your method more detail?

I found that running Windows in KVM really is the only reliable method, 
maybe because the zero pages are easily compressible. There is actually 
not a lot of disk utilization on the backing device when running this test.

My operating system is a minimal install of Debian 9. I took the kernel 
configuration from the default Debian kernel and built my own kernel 
with "make oldconfig" leaving all settings at their defaults. The only 
thing I changed in the configuration was enabling the zram writeback 
feature.

All my tests were done on bare-metal hardware with Xeon processors and 
lots of RAM. I encounter the bug quite quickly, but it still takes 
several GBs of swap usage. Below is my /proc/meminfo with enough KVM 
instances running (3 in my case) to trigger the bug on my test machine.

I will also try to reproduce the problem on some different hardware next.

--

MemTotal:       264033384 kB
MemFree:         1232968 kB
MemAvailable:          0 kB
Buffers:            1152 kB
Cached:             5036 kB
SwapCached:        49200 kB
Active:         249955744 kB
Inactive:        5096148 kB
Active(anon):   249953396 kB
Inactive(anon):  5093084 kB
Active(file):       2348 kB
Inactive(file):     3064 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:      1073741820 kB
SwapFree:       938603260 kB
Dirty:                68 kB
Writeback:             0 kB
AnonPages:      255007752 kB
Mapped:             4708 kB
Shmem:              1212 kB
Slab:              88500 kB
SReclaimable:      16096 kB
SUnreclaim:        72404 kB
KernelStack:        5040 kB
PageTables:       765560 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    1205758512 kB
Committed_AS:   403586176 kB
VmallocTotal:   34359738367 kB
VmallocUsed:           0 kB
VmallocChunk:          0 kB
HardwareCorrupted:     0 kB
AnonHugePages:  254799872 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
DirectMap4k:       75136 kB
DirectMap2M:    10295296 kB
DirectMap1G:    260046848 kB

-- 
Kind regards,

Tino Lehnig
