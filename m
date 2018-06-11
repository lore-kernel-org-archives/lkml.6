Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 24F6AC04EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11013208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 16:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kllViYcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11013208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933735AbeFKQlv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 12:41:51 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:40224 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933694AbeFKQlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:41:49 -0400
Received: by mail-lf0-f44.google.com with SMTP id q11-v6so31553363lfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 09:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=UNPOPjh2sqYxWnvRosIsX+So3VbsY5LT0TsUr6XpF20=;
        b=kllViYcjOpW1CvpuwHflOZAOtxmecXfjDDUgbR/I4Jv+C9KzL5mb2NYuzizsuX8O5l
         kbYQ0qB6FWxhu/chdhmhKjQ7R7rm4y4+/OicPDyMCJMh+hM06BaRNAjxNBd26tUB3qh4
         5LQxhHhvbas3UOMEkhkCGHfKQA0ZBlIVjbRag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=UNPOPjh2sqYxWnvRosIsX+So3VbsY5LT0TsUr6XpF20=;
        b=WxJT9HDeljc43d34NKPQnVdTHNmNesKjjYzEB2jLKT7CY4yHM61IO4SVzxdxRxSEg4
         EnJOUzh1bQyeuuQxN61IFZKeekcsbQjYHTG34MceJ/42zzMGBjmHfBa6Uf4mgZUSVBR4
         0N8PoqUcJ+E6k+/m/ygvu1nvXXfmEXcS7iqj1Y2r7md7GG+DKUMqgE0ONURu9X2+m9ae
         CNx3JcqieMI44RP1B2onRgdjAKwvGBZSKapDvneMh2PT1UdIxYC91LhR+aQSe6LDx4V5
         oUf/d0aHCMtnkCSaZCSQaF8Z0sYK2oSt9SyHH9u25+XKl2BG1u7XN3fhobcbz5CCN0JO
         0J7w==
X-Gm-Message-State: APt69E2xNfzAqJJch1+Wuoou1FRyhIVF60yNmkcNl6ppzygBtNO/7T88
        p1MEQSMgKHhJM9SUNE82Tc+i5ZO6emAEGuBYZEvrxQ==
X-Google-Smtp-Source: ADUXVKKiXtS/0LEvGjlUNwjNSvKXRpiVbwTG62R0R65kBJLVFboRSZIMITOfPmH70Z18SiQJ/ry8cvpulGCMSkxglSs=
X-Received: by 2002:a19:1a52:: with SMTP id a79-v6mr11378941lfa.43.1528735307082;
 Mon, 11 Jun 2018 09:41:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ee14:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 09:41:46
 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 11 Jun 2018 22:11:46 +0530
Message-ID: <CA+G9fYuuiYES7ucAhgf8P-YXJPaYY2pi6kRKf6eBrfHvXJbQiw@mail.gmail.com>
Subject: mainline: x86_64: kernel panic: RIP: 0010:__xfrm_policy_check+0xcb/0x690
To:     netdev@vger.kernel.org
Cc:     steffen.klassert@secunet.com,
        "David S. Miller" <davem@davemloft.net>,
        herbert@gondor.apana.org.au,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel panic on x86_64 machine running mainline 4.17.0 kernel while testing
selftests bpf test_tunnel.sh test caused this kernel panic.
I have noticed this kernel panic start happening from
4.17.0-rc7-next-20180529 and still happening on 4.17.0-next-20180608.

[  213.638287] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000008
++[ ip xfrm poli  213.674036] PGD 0 P4D 0
[  213.674118] audit: type=3D1327 audit(1528917683.623:7):
proctitle=3D6970007866726D00706F6C69637900616464007372630031302E312E312E313=
0302F3332006473740031302E312E312E3230302F33320064697200696E00746D706C007372=
63003137322E31362E312E31303000647374003137322E31362E312E3230300070726F746F0=
06573700072657169640031006D6F64650074756E6E
[  213.677950] Oops: 0000 [#1] SMP PTI
cy[ add src 10.1.  213.677952] CPU: 2 PID: 0 Comm: swapper/2 Tainted:
G        W         4.17.0-next-20180608 #1
[  213.677953] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[  213.726998] RIP: 0010:__xfrm_policy_check+0xcb/0x690
[  213.731962] Code: 80 3d 0a d8 f1 00 00 0f 84 c1 02 00 00 4c 8b 25
2b af f4 00 e8 66 a6 6a ff 85 c0 74 0d 80 3d eb d7 f1 00 00 0f 84 d5
02 00 00 <49> 8b 44 24 08 48 85 c0 74 0c 48 8d b5 78 ff ff ff 4c 89 ff
ff d0
1.[100/32 dst 10.  213.750836] RSP: 0018:ffff91cf6fd03a48 EFLAGS: 00010246
[  213.757441] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 00000000000=
00002
[  213.764566] RDX: ffffffffb863ebe0 RSI: 0000000000000000 RDI: 00000000000=
00000
[  213.771688] RBP: ffff91cf6fd03b18 R08: ffffffffb863ebe0 R09: 00000000000=
00000
[  213.778813] R10: ffff91cf6fd039d0 R11: 0000000000000000 R12: 00000000000=
00000
[  213.785935] R13: ffff91cf5b23d84e R14: ffff91cf5b779f80 R15: ffff91cf558=
9cc00
[  213.793062] FS:  0000000000000000(0000) GS:ffff91cf6fd00000(0000)
knlGS:0000000000000000
[  213.801162] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  213.806900] CR2: 0000000000000008 CR3: 000000004201e001 CR4: 00000000003=
606e0
[  213.814025] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  213.821200] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  213.828324] Call Trace:
[  213.830769]  <IRQ>
[  213.832783]  ? trace_hardirqs_on+0xd/0x10
[  213.836819]  __xfrm_policy_check2.constprop.36+0x6c/0xc0
[  213.842131]  tcp_v4_rcv+0x9ef/0xbd0
[  213.845615]  ? ip_local_deliver_finish+0x26/0x340
[  213.850314]  ip_local_deliver_finish+0xc1/0x340
[  213.854843]  ip_local_deliver+0x74/0x220
[  213.858761]  ? inet_del_offload+0x40/0x40
[  213.862767]  ip_rcv_finish+0x1f0/0x550
[  213.866519]  ip_rcv+0x282/0x480
[  213.869657]  ? ip_local_deliver_finish+0x340/0x340
[  213.874448]  __netif_receive_skb_core+0x3b2/0xd30
[  213.879145]  ? lock_acquire+0xd5/0x1c0
[  213.882891]  __netif_receive_skb+0x18/0x60
[  213.886990]  ? __netif_receive_skb+0x18/0x60
[  213.891252]  netif_receive_skb_internal+0x79/0x370
[  213.896062]  napi_gro_receive+0x138/0x1b0
[  213.900121]  igb_poll+0x610/0xe70
[  213.903440]  net_rx_action+0x246/0x4b0
[  213.907190]  ? lock_acquire+0xd5/0x1c0
[  213.910933]  ? igb_msix_ring+0x5e/0x70
[  213.914681]  __do_softirq+0xbf/0x493
[  213.918260]  irq_exit+0xc3/0xd0
[  213.921405]  do_IRQ+0x65/0x110
[  213.924464]  common_interrupt+0xf/0xf
[  213.928128]  </IRQ>
[  213.930225] RIP: 0010:cpuidle_enter_state+0xa7/0x370
1.[1.200/32 dir i  213.935182] Code: 47 e8 bd 9a 7f ff 48 89 45 d0 0f
1f 44 00 00 31 ff e8 2d a9 7f ff 80 7d c7 00 0f 85 ee 01 00 00 e8 ae
9f 81 ff fb 48 8b 4d d0 <48> 2b 4d c8 48 ba cf f7 53 e3 a5 9b c4 20 48
89 c8 48 c1 f9 3f 48
[  213.955445] RSP: 0018:ffffab2c01943e38 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffffdc
[  213.963002] RAX: ffff91cf6fd21ec0 RBX: 0000000000000002 RCX: 00000031bdd=
50c87
[  213.970127] RDX: 00000031bdd50c87 RSI: 000000002aaaaaaa RDI: ffffffffb84=
ab752
[  213.977250] RBP: ffffab2c01943e78 R08: 0000000000000061 R09: 00000000000=
00018
[  213.984375] R10: ffffab2c01943e18 R11: 0000000000000092 R12: ffff91cf5ce=
88000
[  213.991497] R13: ffffffffb94cf278 R14: 0000000000000002 R15: ffffffffb94=
cf260
[  213.998624]  ? cpuidle_enter_state+0xa2/0x370
[  214.002982]  ? cpuidle_enter_state+0xa2/0x370
[  214.007332]  cpuidle_enter+0x17/0x20
[  214.010902]  call_cpuidle+0x23/0x40
[  214.014387]  do_idle+0x1f0/0x250
[  214.017613]  cpu_startup_entry+0x73/0x80
[  214.021538]  start_secondary+0x175/0x1a0
[  214.025465]  secondary_startup_64+0xa5/0xb0
[  214.029651] Modules linked in: cls_bpf xt_mark algif_hash af_alg
x86_pkg_temp_thermal fuse
[  214.037941] CR2: 0000000000000008
[  214.041255] ---[ end trace a0b077febc9b99ca ]---
[  214.045874] RIP: 0010:__xfrm_policy_check+0xcb/0x690
n tmpl src 172.1[  214.050838] Code: 80 3d 0a d8 f1 00 00 0f 84 c1 02
00 00 4c 8b 25 2b af f4 00 e8 66 a6 6a ff 85 c0 74 0d 80 3d eb d7 f1
00 00 0f 84 d5 02 00 00 <49> 8b 44 24 08 48 85 c0 74 0c 48 8d b5 78 ff
ff ff 4c 89 ff ff d0
[  214.071103] RSP: 0018:ffff91cf6fd03a48 EFLAGS: 00010246
[  214.076327] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 00000000000=
00002
[  214.083451] RDX: ffffffffb863ebe0 RSI: 0000000000000000 RDI: 00000000000=
00000
[  214.090574] RBP: ffff91cf6fd03b18 R08: ffffffffb863ebe0 R09: 00000000000=
00000
[  214.097699] R10: ffff91cf6fd039d0 R11: 0000000000000000 R12: 00000000000=
00000
[  214.104821] R13: ffff91cf5b23d84e R14: ffff91cf5b779f80 R15: ffff91cf558=
9cc00
[  214.111945] FS:  0000000000000000(0000) GS:ffff91cf6fd00000(0000)
knlGS:0000000000000000
[  214.120022] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  214.125760] CR2: 0000000000000008 CR3: 000000004201e001 CR4: 00000000003=
606e0
[  214.132885] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  214.140009] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  214.147131] Kernel panic - not syncing: Fatal exception in interrupt
[  214.153519] Kernel Offset: 0x36c00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  214.164292] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---
[  214.171852] ------------[ cut here ]------------

Kconfigs on this kernel,
-------------------------------
CONFIG_XFRM=3Dy
CONFIG_XFRM_ALGO=3Dy
CONFIG_XFRM_USER=3Dy
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
http://snapshots.linaro.org/openembedded/lkft/morty/intel-core2-32/rpb/linu=
x-next/274/config

Test case source:
--------------------------
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/to=
ols/testing/selftests/bpf/test_tunnel.sh#n565

steps to reproduce:
--------------------------
cd /tools/testing/selftests/bpf/
./test_tunnel.sh

Debugging shows it is coming from function
setup_xfrm_tunnel() {
<trim>
ip xfrm state add src 172.16.1.100 dst 172.16.1.200 proto esp spi 0x1 \
 reqid 1 mode tunnel auth-trunc 'hmac(sha1)'  \
 0x1111111111111111111111111111111111111111 96 enc 'cbc(aes)' \
 0x22222222222222222222222222222222
<trim>
}

Complete test log can be found in this location,
https://lkft.validation.linaro.org/scheduler/job/269604#L2092

Best regards
Naresh Kamboju
