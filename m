Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE84C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 19:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D51A2084C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 19:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkkNkE4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfBBTaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 14:30:18 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35639 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfBBTaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 14:30:18 -0500
Received: by mail-oi1-f195.google.com with SMTP id v6so8607716oif.2;
        Sat, 02 Feb 2019 11:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=agPGLtDbS4rzP1kRVb9+U/NdHzYTV2SEf+ROvgCpbUA=;
        b=qkkNkE4/QczWNYPHyOjld+JGgsKtW/o9Bwsrzk37d/GSjPN5ckNLn9JsK9w7pCt8Pt
         nVhtmFUegsKO908EiZLsqJeKcmR0b2OF8BfaWfB20ZgP9B3fGvpHOVE7BmKbO3RA2+yD
         Oyyh61o+/xSWZFpMvAJsWtVwS7xCU7Dx2qNIcF9EGTbWt9AAxPyOAdp+PhpRZEwSEVXV
         smlwR2e0G7SNYCYNMM1TWFrX6u3drFs2mceDWmWZAOK39cCAuAY8HJN13s9oQTXMItd7
         lTfAAFL3rD45vzJcdIQw4ijosngEDMuHLYlzIfDMbauiDgm9ukCAI6S9XcQh/4ePq8SR
         bJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=agPGLtDbS4rzP1kRVb9+U/NdHzYTV2SEf+ROvgCpbUA=;
        b=tlQKZNNHv7Hl7qCXsdJdhf655scU3diIyNak8Pu5T7WCQh7+lPQSoZNurYQ4U1y909
         s9V3WkX1q6LAYCO/BGfN6MUAKMSSmhWTbU8FmM5xDf2BuFWkTyJD7tbD7Vh3ACVzKFg7
         Gj3sj1GGteJV9L+/ViCAAywuRg8YfmCJ1uG05wyQJh73y08yiOvPaugMRUAHGS6KEMhF
         ExV2CLqaJ21w5nxd996ulh+G4rxKxeJtBGpYoZoCCSoogJgbP1vfDLUDxXrjeaJKtra/
         fIuggRZpOcSLHAeVcl28ccxlAzS+f1U4RSOseqgRa+TnP8REEvKiuMENaiznaa9dRVC8
         oy2A==
X-Gm-Message-State: AHQUAuYYXf2atdOmBaLmfHBRZ2XMnB6JKxzL1w13DNnNMIp4cwwP5+di
        rjVJTLbZVU1Jg6AcdCJcTy4=
X-Google-Smtp-Source: ALg8bN4R62WAfqv7jkxjhz/mGiVyhQAsRZWlyxmE4wJm8Yt19P4x4XFtCVGq5zcWxLNtj8ruTfeG8g==
X-Received: by 2002:aca:4b48:: with SMTP id y69mr22811991oia.200.1549135816500;
        Sat, 02 Feb 2019 11:30:16 -0800 (PST)
Received: from [192.168.1.2] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.googlemail.com with ESMTPSA id l16sm4743657otr.13.2019.02.02.11.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 11:30:15 -0800 (PST)
Subject: Re: [PATCH] net: dsa: Fix lockdep false positive splat
To:     Marc Zyngier <marc.zyngier@arm.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20190202175329.5969-1-marc.zyngier@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 a9BQwACgnzGuH1BVeT2J0Ra+ZYgkx7DaPR0=
Message-ID: <1235e632-8e06-00c1-7c0c-9effac869838@gmail.com>
Date:   Sat, 2 Feb 2019 11:30:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190202175329.5969-1-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 2/2/19 à 9:53 AM, Marc Zyngier a écrit :
> Creating a macvtap on a DSA-backed interface results in the following
> splat when lockdep is enabled:
> 
> [   19.638080] IPv6: ADDRCONF(NETDEV_CHANGE): lan0: link becomes ready
> [   23.041198] device lan0 entered promiscuous mode
> [   23.043445] device eth0 entered promiscuous mode
> [   23.049255]
> [   23.049557] ============================================
> [   23.055021] WARNING: possible recursive locking detected
> [   23.060490] 5.0.0-rc3-00013-g56c857a1b8d3 #118 Not tainted
> [   23.066132] --------------------------------------------
> [   23.071598] ip/2861 is trying to acquire lock:
> [   23.076171] 00000000f61990cb (_xmit_ETHER){+...}, at: dev_set_rx_mode+0x1c/0x38
> [   23.083693]
> [   23.083693] but task is already holding lock:
> [   23.089696] 00000000ecf0c3b4 (_xmit_ETHER){+...}, at: dev_uc_add+0x24/0x70
> [   23.096774]
> [   23.096774] other info that might help us debug this:
> [   23.103494]  Possible unsafe locking scenario:
> [   23.103494]
> [   23.109584]        CPU0
> [   23.112093]        ----
> [   23.114601]   lock(_xmit_ETHER);
> [   23.117917]   lock(_xmit_ETHER);
> [   23.121233]
> [   23.121233]  *** DEADLOCK ***
> [   23.121233]
> [   23.127325]  May be due to missing lock nesting notation
> [   23.127325]
> [   23.134315] 2 locks held by ip/2861:
> [   23.137987]  #0: 000000003b766c72 (rtnl_mutex){+.+.}, at: rtnetlink_rcv_msg+0x338/0x4e0
> [   23.146231]  #1: 00000000ecf0c3b4 (_xmit_ETHER){+...}, at: dev_uc_add+0x24/0x70
> [   23.153757]
> [   23.153757] stack backtrace:
> [   23.158243] CPU: 0 PID: 2861 Comm: ip Not tainted 5.0.0-rc3-00013-g56c857a1b8d3 #118
> [   23.166212] Hardware name: Globalscale Marvell ESPRESSOBin Board (DT)
> [   23.172843] Call trace:
> [   23.175358]  dump_backtrace+0x0/0x188
> [   23.179116]  show_stack+0x14/0x20
> [   23.182524]  dump_stack+0xb4/0xec
> [   23.185928]  __lock_acquire+0x123c/0x1860
> [   23.190048]  lock_acquire+0xc8/0x248
> [   23.193724]  _raw_spin_lock_bh+0x40/0x58
> [   23.197755]  dev_set_rx_mode+0x1c/0x38
> [   23.201607]  dev_set_promiscuity+0x3c/0x50
> [   23.205820]  dsa_slave_change_rx_flags+0x5c/0x70
> [   23.210567]  __dev_set_promiscuity+0x148/0x1e0
> [   23.215136]  __dev_set_rx_mode+0x74/0x98
> [   23.219167]  dev_uc_add+0x54/0x70
> [   23.222575]  macvlan_open+0x170/0x1d0
> [   23.226336]  __dev_open+0xe0/0x160
> [   23.229830]  __dev_change_flags+0x16c/0x1b8
> [   23.234132]  dev_change_flags+0x20/0x60
> [   23.238074]  do_setlink+0x2d0/0xc50
> [   23.241658]  __rtnl_newlink+0x5f8/0x6e8
> [   23.245601]  rtnl_newlink+0x50/0x78
> [   23.249184]  rtnetlink_rcv_msg+0x360/0x4e0
> [   23.253397]  netlink_rcv_skb+0xe8/0x130
> [   23.257338]  rtnetlink_rcv+0x14/0x20
> [   23.261012]  netlink_unicast+0x190/0x210
> [   23.265043]  netlink_sendmsg+0x288/0x350
> [   23.269075]  sock_sendmsg+0x18/0x30
> [   23.272659]  ___sys_sendmsg+0x29c/0x2c8
> [   23.276602]  __sys_sendmsg+0x60/0xb8
> [   23.280276]  __arm64_sys_sendmsg+0x1c/0x28
> [   23.284488]  el0_svc_common+0xd8/0x138
> [   23.288340]  el0_svc_handler+0x24/0x80
> [   23.292192]  el0_svc+0x8/0xc
> 
> This looks fairly harmless (no actual deadlock occurs), and is
> fixed in a similar way to c6894dec8ea9 ("bridge: fix lockdep
> addr_list_lock false positive splat") by putting the addr_list_lock
> in its own lockdep class.

Great timing, I was just looking at this after solving another one seen
with the bridge code on net-next. AFAIR you can also trigger this with
VLAN and pretty much anything that tries to push UC/MC address list down
to the master device.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
