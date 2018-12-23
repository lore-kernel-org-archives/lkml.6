Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27D1C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 19:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FAE2087F
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 19:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQg+3NJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbeLWTi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 14:38:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34322 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeLWTi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 14:38:27 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so17991997wmd.1;
        Sun, 23 Dec 2018 11:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CrQcfMW/hu7mD89sAW5QFGL/ixcVEEX3lHkoQz6Ea6o=;
        b=EQg+3NJjNgEBg6Gj5woAWMVpd8n0d5CguYvGXMGH+3DF3NcYmwXdlySKj2ZFMiWmd9
         BjR4XVptqywzVsotnxxVqvcgQyMmYfwYN2rLZSvoeypQqwoAsJUvgK8FsVWWXnrPFvV9
         GS8jMh3AmVhHvPTI46J5VOV/Kn9c2cVa26vLzdbfonQ16tMR0WMpv9E8gQdKemxB8tVJ
         THbJoFqWSfOAgms+lb3E04Lu1YBWPpVgzLHsZBMajmUZhmZHhMJIrt/8eEwtyVWksXZc
         OaU/9pF4QHg0cxSlOB6eQil2mPAEmgESwL1hnW4h8jjkXPK6V/NGgv+pOeh6lnPktGV1
         fSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CrQcfMW/hu7mD89sAW5QFGL/ixcVEEX3lHkoQz6Ea6o=;
        b=S6edDz3ki5aQHWxujQTbTuSL5fOwPqKshXsERbX1lZhVnbDFJi0b0XCasb87yipetn
         ymZIvY4zGyCTx1h85rch4cDOdVOH9h/babGbRXLIubUyFoPvD23lDJe0dXnOfuDlYJdu
         GKQSEExwtdlEraphGDiyxuUL/JI+/aycWgaORGexDPFmZFeeSVtGaqmObjJb8pbbhcNz
         oStQc3velU8Ramp275bgHF88iX2VTiw5N6Wnmv15BjqMGNrBb72h+Ho4Wy8MKxz/5JHd
         RVjk+X7tJl3lSd2foGt8KPZ82nipP0JHzMKI1h7w+UQRizqMv1ngcxeTrPiIhJZm/CC8
         pzqQ==
X-Gm-Message-State: AA+aEWaOjdwfPj2Op90mI4HwoZHEPn7z6tK7xNQqv4K7sMLJnTDacZMH
        OnmjJYG4jJsUiZPzNLL/ddp4JGUG
X-Google-Smtp-Source: ALg8bN6dVko8jhnMeXey8q4pylxAeTz/GM8TqQYeM+bhKxE2+VybVqIG6q3Rgy3XDUnb3BmeM8I2rA==
X-Received: by 2002:a7b:c853:: with SMTP id c19mr9456683wml.61.1545593904581;
        Sun, 23 Dec 2018 11:38:24 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id l37sm34474140wre.69.2018.12.23.11.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 11:38:24 -0800 (PST)
Date:   Sun, 23 Dec 2018 20:38:21 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG] net: sungem: device driver frees DMA memory with wrong function
Message-ID: <20181223193821.GA24922@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

During a boot on a qemu machine, I hit the following problem:
[   21.613659] ------------[ cut here ]------------
[   21.614039] DMA-API: gem 0000:00:0f.0: device driver frees DMA memory with wrong function [device address=0x00000000185c5402] [size=408 bytes] [mapped as page] [unmapped as single]
[   21.615960] WARNING: CPU: 0 PID: 206 at /linux-next/kernel/dma/debug.c:1085 check_unmap+0x1b0/0xd10
[   21.616599] Modules linked in:
[   21.617344] CPU: 0 PID: 206 Comm: dhcpcd Not tainted 4.20.0-rc6-next-20181217+ #12
[   21.617735] NIP:  c00ad4e0 LR: c00ad4e0 CTR: c058a710
[   21.618068] REGS: dfff7cb0 TRAP: 0700   Not tainted  (4.20.0-rc6-next-20181217+)
[   21.618404] MSR:  00021032 <ME,IR,DR,RI>  CR: 28008264  XER: 00000000
[   21.618789] 
[   21.618789] GPR00: c00ad4e0 dfff7d60 d85924c0 000000a8 00000102 00000101 000000fe 5d205b6d 
[   21.618789] GPR08: 00000007 00000000 00000000 000000fe 22008864 100581b4 dfff7f1c de019508 
[   21.618789] GPR16: 00000000 de019000 00000001 c0a67f00 00000004 c0b44018 c0a31fc4 c0b43bdc 
[   21.618789] GPR24: 00009032 c0dadedc c0db0000 c0da999c c0b43bdc c0c0b178 dfff7de0 de076ce8 
[   21.620219] NIP [c00ad4e0] check_unmap+0x1b0/0xd10
[   21.620478] LR [c00ad4e0] check_unmap+0x1b0/0xd10
[   21.620703] Call Trace:
[   21.620963] [dfff7d60] [c00ad4e0] check_unmap+0x1b0/0xd10 (unreliable)
[   21.621379] [dfff7dd0] [c00ae128] debug_dma_unmap_page+0xe8/0x120
[   21.621656] [dfff7e40] [c05a865c] gem_poll+0x1000/0x18fc
[   21.621863] [dfff7f00] [c071f044] net_rx_action+0x1b8/0x41c
[   21.622242] [dfff7f80] [c08a287c] __do_softirq+0x17c/0x3b0
[   21.622495] [dfff7ff0] [c0011378] call_do_softirq+0x24/0x3c
[   21.622697] [d86c9c20] [c000724c] do_softirq_own_stack+0x3c/0x7c
[   21.623008] [d86c9c40] [c004e800] do_softirq.part.1+0x64/0x7c
[   21.623292] [d86c9c60] [c004e8d4] __local_bh_enable_ip+0xbc/0x138
[   21.623526] [d86c9c80] [c071c9b4] __dev_queue_xmit+0x28c/0x874
[   21.623776] [d86c9cf0] [c083ebe8] packet_snd+0x4f8/0x988
[   21.624057] [d86c9d80] [c06eddb8] sock_sendmsg+0x20/0x40
[   21.624410] [d86c9d90] [c06ede94] sock_write_iter+0xbc/0x138
[   21.624636] [d86c9df0] [c018f50c] do_iter_readv_writev+0x1dc/0x1f4
[   21.624872] [d86c9e40] [c01925a8] do_iter_write+0xb4/0x350
[   21.625143] [d86c9e80] [c01928f4] vfs_writev+0x88/0x140
[   21.625446] [d86c9f00] [c0192a1c] do_writev+0x70/0x104
[   21.625621] [d86c9f40] [c001912c] ret_from_syscall+0x0/0x38
[   21.626001] --- interrupt: c01 at 0xfedbd08
[   21.626001]     LR = 0xffbc1f8
[   21.626357] Instruction dump:
[   21.626719] 7eb5ba14 7e95a214 2b940014 419d0970 92c10008 7efcba14 3c60c0a1 7e649b78 
[   21.627152] 38637cac 80d7043c 90c1000c 4bf9d36d <0fe00000> 8261003c 82810040 82a10044 
[   21.627665] ---[ end trace fd53714bd2a5fd06 ]---

After some pr_info, I found that the function triggering this is the pci_unmap_page() in gem_tx().
So clearly this WARNING() is strange since it says "unmapped as single".

The qemu is ran with:
qemu-system-ppc -machine mac99,via=pmu -nographic -net nic,model=sungem,macaddr=52:54:00:12:34:58 -net tap -m 512 -monitor none -append "console=ttyPZ0 root=/dev/ram0" -kernel vmlinux -initrd rootfs.cpio.gz -drive format=qcow2,file=lava-guest.qcow2,media=disk,id=test,if=ide

Regards
