Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF79FECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 23:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D232208AE
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 23:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D232208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeIPFPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:15:17 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:33412 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbeIPFPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:15:17 -0400
Received: from MUA
        by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1g1KON-0004qL-0I; Sun, 16 Sep 2018 01:54:23 +0200
Subject: Re: kernel 4.18.5 Realtek 8111G network adapter stops responding
 under high system load
To:     David Arendt <admin@prnet.org>
References: <d05d87f5-1458-f5ce-c644-566ff78e9fc1@prnet.org>
 <4f54989b-9492-420e-374b-d8c9bddf0a7d@prnet.org>
Cc:     linux-kernel@vger.kernel.org, nic_swsd@realtek.com,
        netdev@vger.kernel.org
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Openpgp: preference=signencrypt
Autocrypt: addr=mail@maciej.szmigiero.name; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6c14f6d0-ea61-b8e6-57a2-940d32330ed2@maciej.szmigiero.name>
Date:   Sun, 16 Sep 2018 01:54:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <4f54989b-9492-420e-374b-d8c9bddf0a7d@prnet.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ I've added Realtek Linux NIC and netdev mailing lists to CC ]

Hi David,

On 15.09.2018 23:23, David Arendt wrote:
> Hi,
> 
> just a follow up:
> 
> In kernel 4.18.8 the behaviour is different.
> 
> The network is not reachable a number of times, but restarting to be
> reachable by itself before it finally is no longer reachable at all.
> 
> Here the logging output:
> 
> Sep 15 17:44:43 server kernel: NETDEV WATCHDOG: enp3s0 (r8169): transmit
> queue 0 timed out
> Sep 15 17:44:43 server kernel: r8169 0000:03:00.0 enp3s0: link up
> Sep 15 18:10:26 server kernel: r8169 0000:03:00.0 enp3s0: link up
> Sep 15 18:12:24 server kernel: r8169 0000:03:00.0 enp3s0: link up
> Sep 15 18:13:19 server kernel: r8169 0000:03:00.0 enp3s0: link up
> Sep 15 18:14:48 server kernel: r8169 0000:03:00.0 enp3s0: link up
> Sep 15 18:20:24 server kernel: r8169 0000:03:00.0 enp3s0: link up
> Sep 15 18:34:19 server kernel: r8169 0000:03:00.0 enp3s0: link up
> Sep 15 18:43:43 server kernel: r8169 0000:03:00.0 enp3s0: link up
> Sep 15 18:46:26 server kernel: r8169 0000:03:00.0 enp3s0: link up
> Sep 15 19:00:24 server kernel: r8169 0000:03:00.0 enp3s0: link up
> 
> From 17:44 ro 18:46 the network is recovering automatically. After the
> up from 19:00, the network is no longer reachable without any additional
> message.
> 
> If looking at ifconfig, the counter for TX packets is incrementing, the
> counter for RX packets not.
> 
> Here again the driver from 4.17.14 is working flawlessly.

Could you please try this patch on top of 4.18.8:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f74dd480cf4e31e12971c58a1d832044db945670

In my case the problem fixed by the above commit was only limited to
bad TX performance but my r8169 NIC models were different from what
you have.

If this does not help then try bisecting the issue
(maybe limited to drivers/net/ethernet/realtek/r8169.c to save time).
If the NIC dies after a heavy load it might be possible to generate
such load quickly by in-kernel pktgen.

If that's not possible then at please least compare NIC register
values displayed by "ethtool -d enp3s0" between working and
non-working kernels.

> Thanks in advance,
> David Arendt

Maciej

> 
> 
> On 9/4/18 8:19 AM, David Arendt wrote:
>> Hi,
>>
>> When using kernel 4.18.5 the Realtek 8111G network adapter stops
>> responding under high system load.
>>
>> Dmesg is showing no errors.
>>
>> Sometimes an ifconfig enp3s0 down followed by an ifconfig enp3s0 up is
>> enough for the network adapter to restart responding. Sometimes a reboot
>> is necessary.
>>
>> When copying r8169.c from 4.17.14 to the 4.18.5 kernel, networking works
>> perfectly stable on 4.18.5 so the problem seems r8169.c related.
>>
>> Here the output from lshw:
>>
>>         *-pci:2
>>              description: PCI bridge
>>              product: 8 Series/C220 Series Chipset Family PCI Express
>> Root Port #3
>>              vendor: Intel Corporation
>>              physical id: 1c.2
>>              bus info: pci@0000:00:1c.2
>>              version: d5
>>              width: 32 bits
>>              clock: 33MHz
>>              capabilities: pci pciexpress msi pm normal_decode
>> bus_master cap_list
>>              configuration: driver=pcieport
>>              resources: irq:18 ioport:d000(size=4096)
>> memory:f7300000-f73fffff ioport:f2100000(size=1048576)
>>            *-network
>>                 description: Ethernet interface
>>                 product: RTL8111/8168/8411 PCI Express Gigabit Ethernet
>> Controller
>>                 vendor: Realtek Semiconductor Co., Ltd.
>>                 physical id: 0
>>                 bus info: pci@0000:03:00.0
>>                 logical name: enp3s0
>>                 version: 0c
>>                 serial: <hidden>
>>                 size: 1Gbit/s
>>                 capacity: 1Gbit/s
>>                 width: 64 bits
>>                 clock: 33MHz
>>                 capabilities: pm msi pciexpress msix vpd bus_master
>> cap_list ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd 1000bt
>> 1000bt-fd autonegotiation
>>                 configuration: autonegotiation=on broadcast=yes
>> driver=r8169 driverversion=2.3LK-NAPI duplex=full
>> firmware=rtl8168g-2_0.0.1 02/06/13 latency=0 link=yes multicast=yes
>> port=MII speed=1Gbit/s
>>                 resources: irq:18 ioport:d000(size=256)
>> memory:f7300000-f7300fff memory:f2100000-f2103fff
>>
>> Thanks in advance for looking into this,
>>
>> David Arendt
>>
>>
> 

