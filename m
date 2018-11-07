Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D2CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD3720882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KSHJePkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD3720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeKHHqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:46:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39494 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeKHHqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:46:00 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA7M8v8o064369;
        Wed, 7 Nov 2018 22:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=az1iP6jLwmZMKJf5dIWJ1VabA5mRINyfJJRvDweTwp8=;
 b=KSHJePkDbMMNHFAi7Gm6CaY+ORAPEhrt2CxDVZ8oPwa0gh5Rrz5Mn/Mf4DGyDy1gMIP8
 Gddv2ZH+KIfPdy1mtLLBkvE1d/kAXVlQEyASszXoCaYZQwnL3YyPN8qy/RWeYrwhIHoN
 I6qtx/WPFXnK/tiohwtQBbaArYi7qz+p7AgkVPCarMY6sTY3SFb7G2Mwm4gnuMvf4mm8
 CRoExhKcdeGJs+h4b72Z0AKqqW/5PqVBls4HkqLRnIaMr0MdtQxCVkoj1s02gXRKaLxW
 zukNJPA5kFQB3L4N4TOWPL6a63GQpj3xFVJurpRM2sclzH9V+o8EbAPUEXuz6GCdNwY+ Og== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2nh4aqx5ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Nov 2018 22:13:32 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA7MDVon004920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Nov 2018 22:13:31 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA7MDUsw030904;
        Wed, 7 Nov 2018 22:13:30 GMT
Received: from [192.168.14.112] (/79.178.245.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Nov 2018 14:13:30 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: KMSAN: kernel-infoleak in kvm_write_guest_page
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <000000000000b10cfe057a17b246@google.com>
Date:   Thu, 8 Nov 2018 00:13:25 +0200
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C6FA81C5-D725-43F8-B08D-9EFAC011FBC7@oracle.com>
References: <000000000000b10cfe057a17b246@google.com>
To:     syzbot <syzbot+a8ef68d71211ba264f56@syzkaller.appspotmail.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9070 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=957
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811070196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 7 Nov 2018, at 20:58, syzbot =
<syzbot+a8ef68d71211ba264f56@syzkaller.appspotmail.com> wrote:
>=20
> Hello,
>=20
> syzbot found the following crash on:
>=20
> HEAD commit:    7438a3b20295 kmsan: print user address when reporting =
info..
> git tree:       =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_google_k=
msan.git_master&d=3DDwIBaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE=
&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3D_zu2xJguqdkES0k8nx8Ul=
glUdOiAHk72aWKl44bi2Sw&s=3DfcwxYfHP71V16E_WRx7hgde6KeNMFBzprI2k6PzzZEo&e=3D=

> console output: =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__syzkaller.appspot.c=
om_x_log.txt-3Fx-3D10d782f5400000&d=3DDwIBaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8B=
v7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3D_zu=
2xJguqdkES0k8nx8UlglUdOiAHk72aWKl44bi2Sw&s=3DG8EVFBcgaTj-Rg8XsqlSgOVE7Hjg9=
gU5JEG7hA0ry1I&e=3D
> kernel config:  =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__syzkaller.appspot.c=
om_x_.config-3Fx-3D8df5fc509a1b351b&d=3DDwIBaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh=
8Bv7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3D_=
zu2xJguqdkES0k8nx8UlglUdOiAHk72aWKl44bi2Sw&s=3DyxSBwzSyc6oRH7v1EJAKQMbq9Vg=
hK3Nme98FwYd8iJA&e=3D
> dashboard link: =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__syzkaller.appspot.c=
om_bug-3Fextid-3Da8ef68d71211ba264f56&d=3DDwIBaQ&c=3DRoP1YumCXCgaWHvlZYR8P=
Zh8Bv7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3D=
_zu2xJguqdkES0k8nx8UlglUdOiAHk72aWKl44bi2Sw&s=3DFqvBbzpE2srFcjavB0i99ekCvz=
nCaHFOuWgIwYzmrXs&e=3D
> compiler:       clang version 8.0.0 (trunk 343298)
> syz repro:      =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__syzkaller.appspot.c=
om_x_repro.syz-3Fx-3D15f09133400000&d=3DDwIBaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh=
8Bv7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3D_=
zu2xJguqdkES0k8nx8UlglUdOiAHk72aWKl44bi2Sw&s=3D0JDFhFc1yLDbhcyTkAE1NO9PulB=
lKC3ZAsRaieLSDWg&e=3D
> C reproducer:   =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__syzkaller.appspot.c=
om_x_repro.c-3Fx-3D15a39e05400000&d=3DDwIBaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8B=
v7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3D_zu=
2xJguqdkES0k8nx8UlglUdOiAHk72aWKl44bi2Sw&s=3DFSZ1iQgxwIrifJ7X_cwC7-L4zPR3q=
H5jVMEFYpP2770&e=3D
>=20
> IMPORTANT: if you fix the bug, please add the following tag to the =
commit:
> Reported-by: syzbot+a8ef68d71211ba264f56@syzkaller.appspotmail.com
>=20
> L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 =
and =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.kernel.org_doc_=
html_latest_admin-2Dguide_l1tf.html&d=3DDwIBaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh=
8Bv7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3D_=
zu2xJguqdkES0k8nx8UlglUdOiAHk72aWKl44bi2Sw&s=3DRlJUg93Uo3_bn1O3eehqy8r8h6I=
XBRoE0YNsIVFQY2A&e=3D for details.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KMSAN: kernel-infoleak in __copy_to_user =
include/linux/uaccess.h:121 [inline]
> BUG: KMSAN: kernel-infoleak in __kvm_write_guest_page =
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1849 [inline]
> BUG: KMSAN: kernel-infoleak in kvm_write_guest_page+0x373/0x500 =
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1861
> CPU: 1 PID: 6274 Comm: syz-executor149 Not tainted 4.19.0+ #78
> Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 01/01/2011
> Call Trace:
> __dump_stack lib/dump_stack.c:77 [inline]
> dump_stack+0x32d/0x480 lib/dump_stack.c:113
> kmsan_report+0x19f/0x300 mm/kmsan/kmsan.c:911
> kmsan_internal_check_memory+0x35f/0x450 mm/kmsan/kmsan.c:993
> kmsan_copy_to_user+0x7c/0xe0 mm/kmsan/kmsan_hooks.c:552
> __copy_to_user include/linux/uaccess.h:121 [inline]
> __kvm_write_guest_page arch/x86/kvm/../../../virt/kvm/kvm_main.c:1849 =
[inline]
> kvm_write_guest_page+0x373/0x500 =
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1861
> kvm_write_guest+0x1e1/0x360 =
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1883
> kvm_pv_clock_pairing arch/x86/kvm/x86.c:6793 [inline]
> kvm_emulate_hypercall+0x1c96/0x21b0 arch/x86/kvm/x86.c:6866
> handle_vmcall+0x41/0x50 arch/x86/kvm/vmx.c:7487
> vmx_handle_exit+0x1e81/0xbac0 arch/x86/kvm/vmx.c:10128
> vcpu_enter_guest arch/x86/kvm/x86.c:7667 [inline]
> vcpu_run arch/x86/kvm/x86.c:7730 [inline]
> kvm_arch_vcpu_ioctl_run+0xac32/0x11d80 arch/x86/kvm/x86.c:7930
> kvm_vcpu_ioctl+0xfb1/0x1f90 =
arch/x86/kvm/../../../virt/kvm/kvm_main.c:2590
> do_vfs_ioctl+0xf77/0x2d30 fs/ioctl.c:46
> ksys_ioctl fs/ioctl.c:702 [inline]
> __do_sys_ioctl fs/ioctl.c:709 [inline]
> __se_sys_ioctl+0x1da/0x270 fs/ioctl.c:707
> __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:707
> do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
> entry_SYSCALL_64_after_hwframe+0x63/0xe7
> RIP: 0033:0x442b39
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 =
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d =
01 f0 ff ff 0f 83 1b 0c fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffcb4e05478 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000442b39
> RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000007
> RBP: 00000000006cd018 R08: 0000000020000100 R09: 0000000020000100
> R10: 0000000000000000 R11: 0000000000000217 R12: 0000000000403be0
> R13: 0000000000403c70 R14: 0000000000000000 R15: 0000000000000000
>=20
> Local variable description: ----clock_pairing.i@kvm_emulate_hypercall
> Variable was created at:
> kvm_emulate_hypercall+0x60/0x21b0 arch/x86/kvm/x86.c:6827
> handle_vmcall+0x41/0x50 arch/x86/kvm/vmx.c:7487
>=20
> Bytes 28-63 of 64 are uninitialized
> Memory access of size 64 starts at ffff8801aac5f3d8
> Data copied to user address 0000000020000000
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The info-leak here seems to be pretty obvious.
kvm_pv_clock_pairing() copies entire =E2=80=9Cclock_pairing=E2=80=9D var =
to guest using kvm_write_guest(),
but it doesn=E2=80=99t initialize clock_pairing.pad[] bytes (which is =
exactly bytes 28-63).

I will submit a patch to fix this=E2=80=A6

-Liran




