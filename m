Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53EBC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D0820818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbR5PmZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfBEQfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:35:33 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35822 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfBEQfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:35:32 -0500
Received: by mail-qt1-f195.google.com with SMTP id v11so4533455qtc.2;
        Tue, 05 Feb 2019 08:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:cc:subject:in-reply-to:references
         :mime-version:content-disposition:content-transfer-encoding;
        bh=Rszw6ydJowqnNIBIqLDOTf8j5oGR7rrTgv4o1bfmdfI=;
        b=nbR5PmZDRejvnwucQasaFCVNUmIGNsJgp37o1TqJZzjJ2EkLrw8HRvQKWYiNIPf5RH
         Amu8LdtI38u6s6d2FVgaiLbjObJHAdCsVXTPHCfgLZD1AaG2binpkl6b0hdt9AdQrOjK
         T1nkZpMK2Q1zFoqdgudIiPSviYTZZSN2dDCluNMDwDrx6SyRrcrH0M9kiHvH8iyZSioE
         H01q6O6DYXrV/NmIZMe8i3ISFgV4E/E8tJ5DxKRKJCnrhlM+2t6i9zKwTRs7aH3Oern8
         g+UcGwHmUnoKWYNjFn62b7+OQCdJCCNBotr1X9n1tEYiUanJwm7Dv7p9paDSnP27B74u
         nTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject:in-reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding;
        bh=Rszw6ydJowqnNIBIqLDOTf8j5oGR7rrTgv4o1bfmdfI=;
        b=Gk61mL/tVXmV9qZTK900A/fQ+jwhCBueGA2DY1+GcO9FKk2UiFN22vSIs1VJ+Zwxt+
         mx5nGXJc/ZbczQ8aqmORV1falTznKJhVE02maLN/Ky1aa1aJCenx7mPxQGuksAVeAWEh
         YdfV8HbbmsOcKSVyQxUQA/h0oW4k/1nniDqYndPLXGTf5VyLb1QKPU4c1cbtlllerQb8
         4oRyI9ftcRX4Kt27Gw6nO+eRlqZVemxAZgNY6rvsDe12xE8E32s5RODJi8WQpmlu0ipQ
         yvm6xzA4mXGxbzip7SMcQSESKvlEGdgXMZMbmAsWfsFIOKAxfXlaRT0mO+Nf3NKHzJsa
         gmrQ==
X-Gm-Message-State: AHQUAubYfaL9lBgQY55FW69fr7KNmWuLQOzGd0IdypNtXKdl8TBj9tfk
        70Wt6/fFHvJutPDufWVGRIc=
X-Google-Smtp-Source: AHgI3Iafexa/icdNPN/hlH3CDwLRgRahbR63eeyXxZyqT0thB81di4zrp55yMAn/bl4qm5kHzJOolg==
X-Received: by 2002:a0c:ad48:: with SMTP id v8mr4398191qvc.83.1549384530884;
        Tue, 05 Feb 2019 08:35:30 -0800 (PST)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id w34sm19578545qtj.27.2019.02.05.08.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 08:35:29 -0800 (PST)
Date:   Tue, 5 Feb 2019 11:35:28 -0500
Message-ID: <20190205113528.GD13620@t480s.localdomain>
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] net: dsa: Fix lockdep false positive splat
In-Reply-To: <20190202175329.5969-1-marc.zyngier@arm.com>
References: <20190202175329.5969-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 Feb 2019 17:53:29 +0000, Marc Zyngier <marc.zyngier@arm.com> wrote:
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
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>
