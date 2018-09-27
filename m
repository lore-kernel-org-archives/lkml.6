Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67922C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CA1216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=odi.ch header.i=@odi.ch header.b="h4oIM1Ns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CA1216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=odi.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeI0WHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:07:16 -0400
Received: from vie01a-dmta-ch02-2.mx.upcmail.net ([84.116.36.95]:40895 "EHLO
        vie01a-dmta-ch02-2.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727212AbeI0WHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:07:15 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-ch02.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <odi@odi.ch>)
        id 1g5YWb-0007dD-A8
        for linux-kernel@vger.kernel.org; Thu, 27 Sep 2018 17:48:21 +0200
Received: from gandalf.odi.ch ([84.74.184.48])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id gfoJ1y00J134B7001foKii; Thu, 27 Sep 2018 17:48:20 +0200
X-SourceIP: 84.74.184.48
X-Authenticated-Sender: odi.ch@hispeed.ch
Received: from [10.11.1.254] (unknown [81.7.230.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gandalf.odi.ch (Postfix) with ESMTPSA id E22564600A3;
        Thu, 27 Sep 2018 17:48:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=odi.ch; s=mail;
        t=1538063298; bh=EZyW8QJpY2iao+DH0YUF/XilZ6oZxa9jbsvPH0zNWDc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=h4oIM1NsBWoNGVrVaptmkncIe2ALhQdc5I1E5KNsrB+AjvfiNKa2mBuQcAEgykDxW
         rEgPG5jcR+QmYLjExgjhfaz/BuKcuZiY5hfj9ONEnkZriwjDeTMctXMbyIM/IXlxAj
         eFglRiPaKuhaWGGWpe4gaE+jWBUy5uNTUyDHc+Wk=
Subject: Re: kernel 4.18.5 Realtek 8111G network adapter stops responding
 under high system load
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        David Arendt <admin@prnet.org>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Gabriel C <nix.or.die@gmail.com>
Cc:     linux-kernel@vger.kernel.org, nic_swsd@realtek.com,
        netdev@vger.kernel.org
References: <20180918102349.Horde.yHctatUod-_SC696oYKmySa@cloud.luxmemories.lu>
 <039cc66f-13b0-e745-b6ec-68f4580e90ef@maciej.szmigiero.name>
 <0e865e74-e587-61b7-d319-9afe0a5e8828@prnet.org>
 <968f03ee-a271-242b-d90a-5c70ea72ce3b@gmail.com>
From:   =?UTF-8?Q?Ortwin_Gl=c3=bcck?= <odi@odi.ch>
Message-ID: <b91cbc27-4dcb-2260-00ed-cc7328798670@odi.ch>
Date:   Thu, 27 Sep 2018 17:48:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <968f03ee-a271-242b-d90a-5c70ea72ce3b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.09.18 23:03, Heiner Kallweit wrote:
> It seems that all chip versions from 34 (= RTL8168E-VL) with the
> exception of version 39 (= RTL8106E, first sub-version) need
> bit TXCFG_AUTO_FIFO.
> 
> And indeed, due to reordering of calls this bit is overwritten.
> Following patch moves setting the bit from the chip-specific
> hw_start function to rtl_set_tx_config_registers().
> 
> Whoever is hit by the issue and has the option to build a kernel,
> could you please test whether the patch fixes the issue for you?

Hi,

Looks good so far! No problems for almost 24 hours. This is on a router/firewall that links various 
sites via IPSec and other VPNs and has >10 network interfaces, 5 of which are Realtek ones.

Thanks,

Ortwin

# uname -a
Linux lofw 4.18.10+ #72 SMP PREEMPT Wed Sep 26 17:07:07 CEST 2018 x86_64 Intel(R) Core(TM) i5-7500 
CPU @ 3.40GHz GenuineIntel GNU/Linux
# uptime
  17:42:37 up 22:54,  1 user,  load average: 0.48, 0.38, 0.30
# ifconfig wan
wan: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
         inet 81.7.230.226  netmask 255.255.255.248  broadcast 81.7.230.231
         inet6 fe80::529a:4cff:fe2e:92be  prefixlen 64  scopeid 0x20<link>
         ether 50:9a:4c:2e:92:be  txqueuelen 100  (Ethernet)
         RX packets 56342905  bytes 40589502599 (37.8 GiB)
         RX errors 0  dropped 0  overruns 0  frame 0
         TX packets 54032328  bytes 44607761646 (41.5 GiB)
         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

# ifconfig lan
lan: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
         inet 10.11.1.1  netmask 255.255.255.0  broadcast 10.11.1.255
         inet6 fe80::20a:cdff:fe31:6022  prefixlen 64  scopeid 0x20<link>
         ether 00:0a:cd:31:60:22  txqueuelen 100  (Ethernet)
         RX packets 54799469  bytes 43111097607 (40.1 GiB)
         RX errors 0  dropped 0  overruns 0  frame 0
         TX packets 55158558  bytes 35746992802 (33.2 GiB)
         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
