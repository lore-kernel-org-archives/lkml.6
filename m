Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F04C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656C720818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656C720818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbeKJICF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:02:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:46027 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbeKJICF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:02:05 -0500
Received: from [192.168.1.153] ([74.104.183.64]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MAgvb-1gEPLs2URv-00Br55; Fri, 09
 Nov 2018 23:19:23 +0100
From:   Qian Cai <cai@gmx.us>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Object debugging warning from efivar
Message-Id: <AAACED12-1AAD-4C03-97EF-EF87F05A7056@gmx.us>
Date:   Fri, 9 Nov 2018 17:19:20 -0500
Cc:     linux-efi@vger.kernel.org,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     open list <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:R4FNwRxNPwj4JDnGhWiOQfIKxaNtoBoTo3zZnz6HEl3KZkoFdht
 ACUNlnyVsmAnRKE4FehHpB794tMu0fjfK8xvnu8wyYk8QtuRoJWqHKfHdEdQ95hu9MP4uzB
 E0zR9cb71omP4YDZwTLdViP4/uJ85H4oW7Wy6Gh7HHF7B9tghdl4Sx1JSGYVQ4kp+a4GClM
 nBSDx0aSGWRc1mfxuzuPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GFa4/yGCAb4=:6lDMa4V6/sZO/kdao4MiXh
 XrAodOHqSe5p2E1S5kPHnXBI/uhHvKnNRBWdVhxAn51Ee/9Ocz+QoGCl4VaTJ6nMV5GkMdaD/
 m2CZxxB3etVlMt9I30bdD2wsCEofGGHJCAEAEW9wGBDaImL7V6K9Rl7FEtoetbaxSUe814EKf
 in3g2Gi5jg+H6vGPxg/o+rFFUqOIpZVE4BT2XiGH6Iud7FsFgeR9p7QmvdZMlhp0w/HT/wsHt
 9uVcoZNOE/G7AmIpLWcID04fvcWX/zNPqMZtA6G1wMJHEUHBBWxafl5JDk6M6Zu2IPFLd/BQl
 jih7p2nysDQxeNTA3BJe15xvhjbZlRwpq3IawgN7BOdMru/TTDDv4Jpjq+mRZzxVwJvFN13l0
 bCgOvqh+eJowwwg1nhaX2zTdzo85XfUudRsvUKMKgnypnwfO6Y3Tp9XIIkffPX+hP9FRh+CGI
 eBiIk/oMJ4m2DtWfD3mDe17PdAq8dyoPdOxsMf1O63/PgRdF6p2B664k5a3Op0pAbkGRbl0v/
 sdX+8KOnl18tCM5aOxF5EwkUU9qWXZvjvYZaCIzIm7jU5mnzEQLpiITsB/Lr4GAKX0crzv0KM
 fvgk3S8E1M3KAZc8ddQxi3VDdp8c+UDSdiQVE2U0FvrNrsdLw71fQY5sbInuoqSBnuCzgmZuT
 i99JVA6wbYYUOKiQtblouvmtxilfGyYeMf0/P2DAluWjwWTgsIaTP6w+0dz7JD5TxIPYiNqM2
 X7ObYPqCGJdJ/UNCzmZjmw0MPXjQj6CG98dFXOyJTpZlgW0m38UpHHBehPh96nzWSMBPxkKbn
 3eCwK1w3MPDPZSdsW82uLXIcs8QxkNY7XCpb2m21xAnBLM4SbwXsi5V8QCpW74tSsaIMloyIm
 nuaqkjL391Z4q7/ySjaveR5uoWVGcJC1XlH+hW3P1JotF0k6/dnszkiKg/Lyo/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting this aarch64 server with the latest mainline (3541833fd1f2) get this warning
using object debugging. Any idea?

[   34.716558] ODEBUG: object (____ptrval____) is NOT on stack (____ptrval____), but annotated.
[   34.725266] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:369 __debug_object_init+0x910/0x918
[   34.733806] Modules linked in:
[   34.736903] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         4.20.0-rc1+ #1
[   34.744740] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.50 06/01/2018
[   34.752051] pstate: 20000085 (nzCv daIf -PAN -UAO)
[   34.756902] pc : __debug_object_init+0x910/0x918
[   34.761576] lr : __debug_object_init+0x594/0x918
[   34.766249] sp : ffff8096c1a0f420
[   34.769603] x29: ffff8096c1a0f420 x28: 1ffff012d8341ec6 
[   34.774984] x27: ffff20000bc21000 x26: ffff20000bc34e40 
[   34.780364] x25: ffff8096c411e8c8 x24: ffff8096c411e8d0 
[   34.785743] x23: ffff20000c5654d0 x22: ffff20000bc21c40 
[   34.791123] x21: ffff801ec1a00060 x20: ffff801ec1a00040 
[   34.796502] x19: ffff801ec1a00040 x18: 000000000000003f 
[   34.801881] x17: 0000000000000000 x16: 0000000000000000 
[   34.807260] x15: 0000000000007fff x14: 6e6120747562202c 
[   34.812640] x13: 295f5f5f5f6c6176 x12: ffff1012d8341ceb 
[   34.818019] x11: 00000000f2f2f2f2 x10: dfff200000000000 
[   34.823399] x9 : ffff20000a0e9848 x8 : ffff801ec1a00b70 
[   34.828778] x7 : 00000000f2f2f204 x6 : 00000000f2f2f204 
[   34.834157] x5 : 0000000041b58ab3 x4 : dfff200000000000 
[   34.839537] x3 : dfff200000000000 x2 : 2b6ba53cf7873600 
[   34.844916] x1 : 0000000000000000 x0 : 0000000000000050 
[   34.850295] Call trace:
[   34.852772]  __debug_object_init+0x910/0x918
[   34.857095]  debug_object_init_on_stack+0x20/0x28
[   34.861859]  __init_work+0x34/0x50
[   34.865304]  virt_efi_get_next_variable+0xbc/0x190
[   34.870153]  efivar_init+0x144/0x4b0
[   34.873773]  efisubsys_init+0x1a8/0x428
[   34.877656]  do_one_initcall+0x160/0x6bc
[   34.881628]  kernel_init_freeable+0x74c/0x814
[   34.886040]  kernel_init+0x18/0x11c
[   34.889572]  ret_from_fork+0x10/0x1c
[   34.893189] irq event stamp: 882290
[   34.896723] hardirqs last  enabled at (882289): [<ffff200008fab538>] _raw_spin_unlock_irqrestore+0x80/0x88
[   34.906496] hardirqs last disabled at (882290): [<ffff200008fab264>] _raw_spin_lock_irqsave+0x34/0x98
[   34.915829] softirqs last  enabled at (881706): [<ffff200008082210>] __do_softirq+0x7c8/0x9c8
[   34.924460] softirqs last disabled at (881697): [<ffff20000812dbe4>] irq_exit+0x25c/0x2f0
[   34.932736] ---[ end trace f86eaf2ac70822cc ]---
