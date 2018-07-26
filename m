Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EECBC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F195F20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=contabo.de header.i=@contabo.de header.b="Cvct8HIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F195F20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=contabo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeGZH0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 03:26:00 -0400
Received: from mail.contabo.com ([91.205.175.50]:54086 "EHLO mail.contabo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbeGZHZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 03:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=contabo.de;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/R2bu6WftCZKNlZTvzndUj/wKEnPOO/y4vWbMyeirLg=; b=Cvct8HIxqGpfk16Q8bruCpfkOS
        BLAbRBhwMe1T+hF74myVZqWlShTrte4gBMMcnJ+eFs82/NqtPsUaNwTNyXu8vVLddAfO2mR8/bhed
        ZIOs0ZFikqUolh6QFz4KiaMrsPeakbdSN4aIt+JJsI1eH4hz1fWGbFSxmpfdflVeMDZq3ooqZn4/d
        A25sfHoBwqn/y5Lmaz6Ka0Vcvni3aR3tAFTPIwIUJzHURVxxYp1e8vWn4ELGaFVhrgfSuN0uwl48B
        ExrSR6rQ6+pcuvxT6OAO9AC1EhIv1o/8C8vR8kurernRbau3/ePB/v3FT+ljSZOZ1fC/o8a8oms8n
        ldZrT1Rg==;
Received: from [178.238.239.246] (port=30200 helo=[192.168.178.123])
        by mail.contabo.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <tino.lehnig@contabo.de>)
        id 1fiZU1-00013k-OS; Thu, 26 Jul 2018 08:10:41 +0200
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
 <d07348bb-3102-30f0-d138-de23449e23df@contabo.de>
 <20180726020351.GA221405@rodete-desktop-imager.corp.google.com>
From:   Tino Lehnig <tino.lehnig@contabo.de>
Message-ID: <1684cefc-c920-d53c-8d2d-c32da213a045@contabo.de>
Date:   Thu, 26 Jul 2018 08:10:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180726020351.GA221405@rodete-desktop-imager.corp.google.com>
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

On 07/26/2018 04:03 AM, Minchan Kim wrote:
> A thing I could imagine is
> [0bcac06f27d75, skip swapcache for swapin of synchronous device]
> It was merged into v4.15. Could you check it by bisecting?

Thanks, I will check that.

>> My operating system is a minimal install of Debian 9. I took the kernel
>> configuration from the default Debian kernel and built my own kernel with
>> "make oldconfig" leaving all settings at their defaults. The only thing I
>> changed in the configuration was enabling the zram writeback feature.
> 
> You mean you changed host kernel configuration?
> 
>>
>> All my tests were done on bare-metal hardware with Xeon processors and lots
>> of RAM. I encounter the bug quite quickly, but it still takes several GBs of
>> swap usage. Below is my /proc/meminfo with enough KVM instances running (3
>> in my case) to trigger the bug on my test machine.
> 
> Aha.. you did writeback feature into your bare-metal host machine and execute
> kvm with window images as a guest. So, PG_uptodate warning happens on host side,
> not guest? Right?

Yes, I am only talking about the host kernel. Zram swap is set up on the 
host. I just used Windows guests to fill up the host RAM and force it 
into swap.

>> I will also try to reproduce the problem on some different hardware next.

Just to confirm, I was able to reproduce the problem on another machine 
running Ubuntu 18.04 with the Ubuntu stock kernel (4.15) and no 
modifications to the kernel configuration whatsoever. The host had 8 GB 
of RAM, 32 GB of swap with zram and a 32 GB SSD as backing device. I had 
to start only one Windows VM with "-m 32768" to trigger the bug.

-- 
Kind regards,

Tino Lehnig
