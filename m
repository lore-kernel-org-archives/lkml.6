Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AFDC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FAE26B22
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4MxYmUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FAE26B22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754590AbeFZV74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:59:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46432 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752108AbeFZV7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:59:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id r17-v6so1866730edo.13;
        Tue, 26 Jun 2018 14:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HuiVcmxENrV1SQKd5rqsT5aIVMTsgW3eF06pnrtxYyE=;
        b=P4MxYmUMmJ7wGXdOPiISyjODoMT373/qtWavwmJP3nWG3zY/5qtzzJCDK7huGbcFrE
         YyGFVDnEgpJUXjc1JLYOoHFst5dB534PUFDg6XJbD5dvIvjkKm92xdIGqcZ/ZQrtUwsN
         rYXxg3dg6D+0Ei+0PN0EE1o5ieIOYe3DI6d0K115S8drwUuOtqLY+ZboU/5JYimSvVng
         S1fIAGZALRKgIDUaVyJncvnuZ96BP267jwpfZNBoJQV6hJigzaqgKUocHesTcEVWqJoe
         WayK1vBum34Q7olmHnLBBq/GPIsAYdFZML8MHzqxZhjStChSi2cuzhIAQfSAkHMIX9/q
         QB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HuiVcmxENrV1SQKd5rqsT5aIVMTsgW3eF06pnrtxYyE=;
        b=G/CYr19n23Tqj3WRNeZNAStPmbnWBQzqppINu5Gne+tUSbJ1czL1fCsS/V1WwvTE0i
         OXmRPmGrfykrlA/cCcuhpY0KHUqgOTPkQ4gffZc9xWS9mydf7v8uRYe1q4qf2m+lVxVS
         7WSwET0o4J08v2dLSYAKMRxPzXtl4hgtPALRzTaZtG0AteHIiosOzhegjTT2nzFUA3F1
         1ru6LlA3wD7OhIXTbZxim85M1yIwKZycQkJVr10/E6e5GBRz6GPXXyBLsT/Vx5ScJWO3
         aUmk5ZoD8HIk1NcHz3IKlgXlqtCqPjEC7TmUtKWN851NQGB4Lq6yktva9nSuo3BtP9/F
         8TWA==
X-Gm-Message-State: APt69E3GLx7RGcYTkoh7sbOTI1O+jeH6uOuuvEaY1uffbaSDwjCEj8KZ
        dmIT2LxbDyS9rQgwdTMFEJNPe3pW
X-Google-Smtp-Source: AAOMgpelkxnR4TI9bCyvCKjklxSOlIpqh9A1GTj7nOFONxTCYwEUP53L8oHaU929I7GVafma3dgRwg==
X-Received: by 2002:a50:c211:: with SMTP id n17-v6mr3216744edf.11.1530050391051;
        Tue, 26 Jun 2018 14:59:51 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id c20-v6sm1498677ede.3.2018.06.26.14.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 14:59:50 -0700 (PDT)
Subject: Re: [PATCH net-next v2 1/3] net: phy: xgmiitorgmii: Check phy_driver
 ready before accessing
To:     Brandon Maier <brandon.maier@rockwellcollins.com>,
        netdev@vger.kernel.org
Cc:     andrew@lunn.ch, davem@davemloft.net, michal.simek@xilinx.com,
        clayton.shotwell@rockwellcollins.com,
        kristopher.cory@rockwellcollins.com, linux-kernel@vger.kernel.org
References: <20180626175050.71165-1-brandon.maier@rockwellcollins.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <6387da90-c0de-00d9-9744-d4386a316e79@gmail.com>
Date:   Tue, 26 Jun 2018 14:59:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626175050.71165-1-brandon.maier@rockwellcollins.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/2018 10:50 AM, Brandon Maier wrote:
> Since a phy_device is added to the global mdio_bus list during
> phy_device_register(), but a phy_device's phy_driver doesn't get
> attached until phy_probe(). It's possible of_phy_find_device() in
> xgmiitorgmii will return a valid phy with a NULL phy_driver. Leading to
> a NULL pointer access during the memcpy().
> 
> Fixes this Oops:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = c0004000
> [00000000] *pgd=00000000
> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.40 #1
> Hardware name: Xilinx Zynq Platform
> task: ce4c8d00 task.stack: ce4ca000
> PC is at memcpy+0x48/0x330
> LR is at xgmiitorgmii_probe+0x90/0xe8
> pc : [<c074bc68>]    lr : [<c0529548>]    psr: 20000013
> sp : ce4cbb54  ip : 00000000  fp : ce4cbb8c
> r10: 00000000  r9 : 00000000  r8 : c0c49178
> r7 : 00000000  r6 : cdc14718  r5 : ce762800  r4 : cdc14710
> r3 : 00000000  r2 : 00000054  r1 : 00000000  r0 : cdc14718
> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 18c5387d  Table: 0000404a  DAC: 00000051
> Process swapper/0 (pid: 1, stack limit = 0xce4ca210)
> ...
> [<c074bc68>] (memcpy) from [<c0529548>] (xgmiitorgmii_probe+0x90/0xe8)
> [<c0529548>] (xgmiitorgmii_probe) from [<c0526a94>] (mdio_probe+0x28/0x34)
> [<c0526a94>] (mdio_probe) from [<c04db98c>] (driver_probe_device+0x254/0x414)
> [<c04db98c>] (driver_probe_device) from [<c04dbd58>] (__device_attach_driver+0xac/0x10c)
> [<c04dbd58>] (__device_attach_driver) from [<c04d96f4>] (bus_for_each_drv+0x84/0xc8)
> [<c04d96f4>] (bus_for_each_drv) from [<c04db5bc>] (__device_attach+0xd0/0x134)
> [<c04db5bc>] (__device_attach) from [<c04dbdd4>] (device_initial_probe+0x1c/0x20)
> [<c04dbdd4>] (device_initial_probe) from [<c04da8fc>] (bus_probe_device+0x98/0xa0)
> [<c04da8fc>] (bus_probe_device) from [<c04d8660>] (device_add+0x43c/0x5d0)
> [<c04d8660>] (device_add) from [<c0526cb8>] (mdio_device_register+0x34/0x80)
> [<c0526cb8>] (mdio_device_register) from [<c0580b48>] (of_mdiobus_register+0x170/0x30c)
> [<c0580b48>] (of_mdiobus_register) from [<c05349c4>] (macb_probe+0x710/0xc00)
> [<c05349c4>] (macb_probe) from [<c04dd700>] (platform_drv_probe+0x44/0x80)
> [<c04dd700>] (platform_drv_probe) from [<c04db98c>] (driver_probe_device+0x254/0x414)
> [<c04db98c>] (driver_probe_device) from [<c04dbc58>] (__driver_attach+0x10c/0x118)
> [<c04dbc58>] (__driver_attach) from [<c04d9600>] (bus_for_each_dev+0x8c/0xd0)
> [<c04d9600>] (bus_for_each_dev) from [<c04db1fc>] (driver_attach+0x2c/0x30)
> [<c04db1fc>] (driver_attach) from [<c04daa98>] (bus_add_driver+0x50/0x260)
> [<c04daa98>] (bus_add_driver) from [<c04dc440>] (driver_register+0x88/0x108)
> [<c04dc440>] (driver_register) from [<c04dd6b4>] (__platform_driver_register+0x50/0x58)
> [<c04dd6b4>] (__platform_driver_register) from [<c0b31248>] (macb_driver_init+0x24/0x28)
> [<c0b31248>] (macb_driver_init) from [<c010203c>] (do_one_initcall+0x60/0x1a4)
> [<c010203c>] (do_one_initcall) from [<c0b00f78>] (kernel_init_freeable+0x15c/0x1f8)
> [<c0b00f78>] (kernel_init_freeable) from [<c0763d10>] (kernel_init+0x18/0x124)
> [<c0763d10>] (kernel_init) from [<c0112d74>] (ret_from_fork+0x14/0x20)
> Code: ba000002 f5d1f03c f5d1f05c f5d1f07c (e8b151f8)
> ---[ end trace 3e4ec21905820a1f ]---
> 
> Signed-off-by: Brandon Maier <brandon.maier@rockwellcollins.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
