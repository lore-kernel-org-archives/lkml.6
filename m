Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2941935-1524137560-2-7983985574909044734
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524137556; b=jjG7tCMHtLQ+wRBuKbA95zu63XqJt15EWmcPmbTqI/x/M1z1dL
    8fCNEomdk379/hszB6nqaZ23resLpY8Ems4VOnGAb8WD3yLMcb+lEg2hEeDTi2G/
    d+3jYHVXQtdArq0FXt2hVQ2G1TAqqaLMAxU9rOcyG2dsYFQsPTo63GkAUqzhfwF5
    a7UA31LiFSHx2ojBNiFnavDnkodUl8XK8dfn71WzHLUG+VC4EDowAS5vjSrSElBG
    BNLmCCvpzAaH30YHgQEOSegRU7zGzeOILOmWKcdYR0ej4mAi45Y92u3Vg9jqn4Pi
    PXzwysLoLuAD5KzFosV3uXEYV1B3s4i5c1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524137556; bh=EGmqO/V4EBgFV2kRAxPhqgApYxQGbaYfE2B8Ukf/1G
    s=; b=cXvDxEviwjw9KqB4JBtGD9kKNYmb+D7gqKsipFvaYDyHkfYx98I6YoZbJ+
    8GK/Axtom8wck1TRV20x99HZ2d+TRmJKjlgQlWOb8ih0YAT3oE1sXxw8xWOd0jEc
    yzZCSTzRB0pvT7WpjvWOAa2rlDchSRYYYwYbFJup/K13OpJWAFGaOY1lA1x9IbGE
    jADtB/gT6KMlwPlv6EdKJOdGpZMrbp0OIqlyaQl3zJ1VLdGtX453l4IC2wja/pnv
    sE+T1PeT9WUAK5b7P8m6LrNRFOECUej8WR4U7GW88HKIIz7KDrz6tiq7qJIgah5H
    mwwTRYaerrH0ZUWAmyvN8zWTBKOw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=D7lDpexl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OYU0Stmq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=D7lDpexl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OYU0Stmq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEzgXKm/oHZa2TLvDXJUQVDhgWnt5FcE7SsYlnpn3gvTI2/1vLGznDRbbR3oUWlpeps3y/ouVqk8CQ8jwSAB2MyYPYFlDgEmjyrUKz/Sd/izYbDDe8oF
    0YGCgIADXGRbbtIUA3wQqg5WfbZsXHn5jfv27L2QVr/VPolTHhC0UzY0UTDd8RFfZr4I4uVWb2a/KjG10qtSfO7XaOlRV5Ir+YcGn6kUENd6eEM/eT5qKVAf
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=8AirrxEcAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=KKAkSRfTAAAA:8 a=qL2kPfosAhpsQjuGp1sA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=ST-jHhOKWsTCqRlWije3:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbeDSLcX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 07:32:23 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35179 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeDSLcW (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Apr 2018 07:32:22 -0400
X-Google-Smtp-Source: AB8JxZoWrriStykOz2ToWei7Mt01VKy8QLyUDTjIKskdsYJOfChjtva+pGUIn+cM0MPY9JE3ROh4S5ZtzbqG9L11Iww=
MIME-Version: 1.0
In-Reply-To: <20180411183630.390575424@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org> <20180411183630.390575424@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 19 Apr 2018 17:02:19 +0530
Message-ID: <CA+G9fYtR_3AXKvhrkE3WEZhVOX6XwJ1r38PLav1XKkz4L4eQZQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 181/310] net: phy: micrel: Restore led_mode and
 clk_sel on resume
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 12 April 2018 at 00:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> 4.9-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Leonard Crestez <leonard.crestez@nxp.com>
>
>
> [ Upstream commit 79e498a9c7da0737829ff864aae44df434105676 ]
>
> These bits seem to be lost after a suspend/resume cycle so just set them
> again. Do this by splitting the handling of these bits into a function
> that is also called on resume.
>
> This patch fixes ethernet suspend/resume on imx6ul-14x14-evk boards.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/phy/micrel.c |   42 ++++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 14 deletions(-)

arm32 x15 device booting 4.9 kernel shows kernel warning and
the network is not working on the device.

Linux version 4.9.95-rc1 (buildslave@lkft-01) (gcc version 6.2.1 20161016
 (Linaro GCC 6.2-2016.11) ) #1 SMP Tue Apr 17 19:12:22 UTC 2018

Boot log kernel crash log:
--------------------------
[   13.766589] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   13.805441] net eth0: initializing cpsw version 1.15 (0)
[   13.930334] Unable to handle kernel NULL pointer dereference at
virtual address 00000008
[   13.938486] pgd = ed7987c0
[   13.941221] [00000008] *pgd=ad7f1003, *pmd=fb0b6003
[   13.946163] Internal error: Oops: 207 [#1] SMP ARM
[   13.950976] Modules linked in: snd_soc_simple_card
snd_soc_simple_card_utils snd_soc_core snd_pcm_dmaengine snd_pcm
snd_timer snd soundcore ac97_bus
[   13.964430] CPU: 0 PID: 251 Comm: NetworkManager Not tainted 4.9.95-rc1 #1
[   13.971334] Hardware name: Generic DRA74X (Flattened Device Tree)
[   13.977452] task: ed6ed5c0 task.stack: ec220000
[   13.982009] PC is at kszphy_config_reset+0x1c/0x150
[   13.986909] LR is at kszphy_resume+0x24/0x64
[   13.991198] pc : [<c0b6f680>]    lr : [<c0b6f940>]    psr: 60000013
[   13.991198] sp : ec221920  ip : ec221940  fp : ec22193c
[   14.002723] r10: 00000000  r9 : 00000007  r8 : 00000000
[   14.007969] r7 : ed213000  r6 : 00000000  r5 : ee6fa800  r4 : ed213400
[   14.014523] r3 : 00000001  r2 : 00000000  r1 : 00000110  r0 : ed213400
[   14.021079] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   14.028245] Control: 30c5387d  Table: ad7987c0  DAC: fffffffd
[   14.034014] Process NetworkManager (pid: 251, stack limit = 0xec220220)
[   14.040655] Stack: (0xec221920 to 0xec222000)
<>
[   14.496761] [<c0b6f680>] (kszphy_config_reset) from [<c0b6f940>]
(kszphy_resume+0x24/0x64)
[   14.505067] [<c0b6f940>] (kszphy_resume) from [<c0b693f8>]
(phy_attach_direct+0xc4/0x1cc)
[   14.513284] [<c0b693f8>] (phy_attach_direct) from [<c0b69600>]
(phy_connect_direct+0x24/0x5c)
[   14.521848] [<c0b69600>] (phy_connect_direct) from [<c0b6968c>]
(phy_connect+0x54/0x88)
[   14.529901] [<c0b6968c>] (phy_connect) from [<c0c0e47c>]
(cpsw_slave_open+0x230/0x294)
[   14.529912] [<c0c0e47c>] (cpsw_slave_open) from [<c0c11634>]
(cpsw_ndo_open+0x4b4/0x618)
[   14.529924] [<c0c11634>] (cpsw_ndo_open) from [<c0deeb64>]
(__dev_open+0xbc/0x124)
[   14.529934] [<c0deeb64>] (__dev_open) from [<c0deee4c>]
(__dev_change_flags+0xa4/0x154)
[   14.529943] [<c0deee4c>] (__dev_change_flags) from [<c0deef24>]
(dev_change_flags+0x28/0x58)
[   14.529953] [<c0deef24>] (dev_change_flags) from [<c0e025f0>]
(do_setlink+0x2f0/0x890)
[   14.529962] [<c0e025f0>] (do_setlink) from [<c0e04554>]
(rtnl_newlink+0x4b0/0x784)
[   14.529970] [<c0e04554>] (rtnl_newlink) from [<c0e04908>]
(rtnetlink_rcv_msg+0xe0/0x1fc)
[   14.529979] [<c0e04908>] (rtnetlink_rcv_msg) from [<c0e1e538>]
(netlink_rcv_skb+0xb0/0xcc)
[   14.529990] [<c0e1e538>] (netlink_rcv_skb) from [<c0e01c1c>]
(rtnetlink_rcv+0x38/0x40)
[   14.529998] [<c0e01c1c>] (rtnetlink_rcv) from [<c0e1de70>]
(netlink_unicast+0x180/0x210)
[   14.530006] [<c0e1de70>] (netlink_unicast) from [<c0e1e29c>]
(netlink_sendmsg+0x2c4/0x380)
[   14.530014] [<c0e1e29c>] (netlink_sendmsg) from [<c0dc8304>]
(sock_sendmsg+0x24/0x34)
[   14.530023] [<c0dc8304>] (sock_sendmsg) from [<c0dc8a70>]
(___sys_sendmsg+0x1e0/0x1f0)
[   14.530035] [<c0dc8a70>] (___sys_sendmsg) from [<c0dc9884>]
(__sys_sendmsg+0x50/0x7c)
[   14.530043] [<c0dc9884>] (__sys_sendmsg) from [<c0dc98c8>]
(SyS_sendmsg+0x18/0x1c)
[   14.530055] [<c0dc98c8>] (SyS_sendmsg) from [<c0408c80>]
(ret_fast_syscall+0x0/0x1c)
[   14.530062] Code: e52de004 e8bd4000 e59062dc e1a04000 (e5d63008)
[   14.530113] ---[ end trace f4394cbc177fdd86 ]---


LAVA job id:
https://lkft.validation.linaro.org/scheduler/job/187429#L3341
