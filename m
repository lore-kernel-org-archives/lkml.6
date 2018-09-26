Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7C3C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A95214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=odi.ch header.i=@odi.ch header.b="jPO3IMrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A95214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=odi.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbeIZVas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:30:48 -0400
Received: from vie01a-dmta-ch02-2.mx.upcmail.net ([84.116.36.95]:51748 "EHLO
        vie01a-dmta-ch02-2.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727157AbeIZVar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:30:47 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-ch02.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <odi@odi.ch>)
        id 1g5BZ2-0005d7-Dy
        for linux-kernel@vger.kernel.org; Wed, 26 Sep 2018 17:17:20 +0200
Received: from gandalf.odi.ch ([84.74.184.48])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id gFHJ1y01F134B7001FHL2r; Wed, 26 Sep 2018 17:17:20 +0200
X-SourceIP: 84.74.184.48
X-Authenticated-Sender: odi.ch@hispeed.ch
Received: from [10.11.1.254] (unknown [81.7.230.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gandalf.odi.ch (Postfix) with ESMTPSA id 6BF1E4600A3;
        Wed, 26 Sep 2018 17:17:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=odi.ch; s=mail;
        t=1537975038; bh=AJkk42CCS/OG8fYZ0pXrzjaZZFCCQt8aONBZb2dEa+g=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=jPO3IMrXLgDyYvVHE60CoTMb0ZHW9ekMlPuu90B4JmKtCueUsgfq7QTsY24g6mRGX
         PJuzzyx2EJ4qjmYLRbD4riUvP04AOCbBpztLr0SiTOa++mKZ5WinuXcg7q6OYQgNov
         RMJRTud9+NeGSwzbb17NvJYoiAdDPtFv1fYXhJpw=
Subject: Re: r8169 hang on 4.18
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
References: <332fecce-3fab-1c92-1558-67a1d90d6372@odi.ch>
 <680acec6-f610-7f9d-5aa2-a03e878354d1@gmail.com>
 <4584fb8e-32f8-7375-8481-fe35c3cf693e@odi.ch>
 <9fb89abb-917a-44b6-5dff-9c4a0ed1fd6b@gmail.com>
From:   =?UTF-8?Q?Ortwin_Gl=c3=bcck?= <odi@odi.ch>
Message-ID: <98c29c26-b898-8b79-f4bd-00399d5e9f06@odi.ch>
Date:   Wed, 26 Sep 2018 17:17:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <9fb89abb-917a-44b6-5dff-9c4a0ed1fd6b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25.09.18 20:44, Heiner Kallweit wrote:
> Unfortunately the lspci info doesn't allow to determine the exact chip type.
> Relevant would be the syslog info as you provided it in your first mail:
> r8169 0000:07:00.0 eth4: RTL8168h/8111h, 50:9a:4c:2e:92:be, XID 54100800, IRQ 16
> Are the chips on the extension card the same as the on-board chip?

They are different: G and H versions.

[    1.696997] r8169 0000:03:00.0 eth0: RTL8168g/8111g at 0x        (ptrval), 00:0a:cd:31:60:1f, XID 
0c000800 IRQ 17
[    1.712910] r8169 0000:04:00.0 eth1: RTL8168g/8111g at 0x        (ptrval), 00:0a:cd:31:60:20, XID 
0c000800 IRQ 18
[    1.724969] r8169 0000:05:00.0 eth2: RTL8168g/8111g at 0x        (ptrval), 00:0a:cd:31:60:21, XID 
0c000800 IRQ 19
[    1.736923] r8169 0000:06:00.0 eth3: RTL8168g/8111g at 0x        (ptrval), 00:0a:cd:31:60:22, XID 
0c000800 IRQ 16
[    1.753031] r8169 0000:07:00.0 eth4: RTL8168h/8111h at 0x        (ptrval), 50:9a:4c:2e:92:be, XID 
14100800 IRQ 16

I am going to try your patch against 4.18.10 and report back!

Thanks,

Ortwin
