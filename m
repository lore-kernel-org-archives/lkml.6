Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1535273-1523961582-2-11617978619178710826
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523961581; b=lo9T5fMZFEBme75LQHH5ygAmMZ1et4bRKuBNo2bEmqHUxYSjbV
    NL+sgCbXyLVcfQfWZTb6uHntWtJvqBKFHtbwiBZADEEZ5NkJad1IlNiRKtYfGOkq
    lnEgIXuHA0TZoBOUV7MrgisDtBuFoNAqvpHvNkM+9oJQwDI43pm+OO1sHE/Z7g6V
    /buU7jV5qoN3j0RGbK4I/vZr2/BOzLyiUyuFo01BMj97Fi4TCI6wUKGa9ondF1Xz
    9DKB8Mdz1N4d3rnGJ39izyKquzzjnDZesY0yKaXtYZMYbZFJj9ChJaizrNJT5ce1
    9fP84HcdITZ+efDwNvzrR/j64ZEH7HlbJJLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:from:subject:message-id:date
    :mime-version:content-type:sender:list-id; s=fm2; t=1523961581;
    bh=CMBbNpFW7uXBkN/6B/wBNz3wp0xVGPTcYRzf2ccscEg=; b=I1bCAbPKwjOf
    6nHfuY8gu/nkGRj5iY8zubvuiz/UiD+OYUHQ+QNxOEn4Xzq0BWmRiws33IRk+16a
    BVgQn4uUqeJuwglRvPaYnhz88Ap+KLQT+VDd+5GWDRlYGnbwVTuhTIXgZj9sdTb4
    CInG2zn7QBzau55htMQSEJl5OPmiq/O6+uoRr1CIODndhi66pE1O5vr5C7xKKf5I
    qdqAf1oqaj5Taxihhh9Pjoo9QvzchMs3eJE2TD4eqwdoUAVZFgS1Zs50TrFk7NGH
    +rW9ZIXn1wVFSxm3A3eRvWs15Z3ONqfSdOZA1yzzqcnNYE+7ePKtlqKLauotI8wP
    xsy8GfGVZg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uQosmoN1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=b35z1ukA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uQosmoN1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=b35z1ukA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPN6yRwOqlf5xJQKa2MicvBa5ELiONVMoCk2hL6PxdId3l5EfGRTPXpj5+0EAtCl4MEq2DsziaOYBtD3Qpt7byUJxF9PjakfBcA5E58yeqVHE8Anvq3f
    XicBp83X08Ba0rXYEQqXXs+dMeXAM/q+HuGjDq44bR+1o++3uJ9ua/pfQthQEwqB/2Md77qn8DsVHhAfjkIbuYKRSKxxXXxrqi62gcnVcGlmpeoPPnSsyVz+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=ZVeAwwkMJCUA:10
    a=Kd1tUaAdevIA:10 a=13zjGPudsaEWiJwPRgMA:9 a=NEAV23lmAAAA:8 a=D19gQVrFAAAA:8
    a=IWy9n703bRDnJ7_keQoA:9 a=QEXdDO2ut3YA:10 a=DulXZ3G4tzBhuQ1W7asA:9
    a=ONNS8QRKHyMA:10 a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751810AbeDQKji (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 06:39:38 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36157 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeDQKjh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 06:39:37 -0400
X-Google-Smtp-Source: AIpwx4/mZP1sQHTvYrf3xS+tF976Wf/qPaGW1RhVCfPowHkCplA7uUYe6dbAU13vyWzaqrlQAz7VvA==
To: Jan Kara <jack@suse.cz>, mszeredi@redhat.com, amir73il@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
From: Pavlos Parissis <pavlos.parissis@gmail.com>
Subject: kernel 4.14.x crash around fsnotify_mark_connector
Message-ID: <e7323798-3175-3d27-fdd1-349f1422cb26@gmail.com>
Date: Tue, 17 Apr 2018 12:39:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xnxD2sLDWbG1RnmHCILAOl43qlBQuLh9E"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xnxD2sLDWbG1RnmHCILAOl43qlBQuLh9E
Content-Type: multipart/mixed; boundary="Cf0d4OeM4IvFWjtwla81r91MTZGlPZqDB";
 protected-headers="v1"
From: Pavlos Parissis <pavlos.parissis@gmail.com>
To: Jan Kara <jack@suse.cz>, mszeredi@redhat.com, amir73il@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-ID: <e7323798-3175-3d27-fdd1-349f1422cb26@gmail.com>
Subject: kernel 4.14.x crash around fsnotify_mark_connector

--Cf0d4OeM4IvFWjtwla81r91MTZGlPZqDB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

In one of our production servers where we run kernel version 4.14.32, I n=
oticed
the following:

----
[138630.417246] cache_from_obj: Wrong slab cache. fsnotify_mark_connector=
 but
object is from kmalloc-2048(361:anycast-healthchecker.service)
[138630.477075] ------------[ cut here ]------------
[138630.500028] WARNING: CPU: 14 PID: 26002 at mm/slab.h:377
kmem_cache_free+0x133/0x1c0
[138630.538130] Modules linked in: netconsole binfmt_misc sctp_diag sctp =
dccp_diag
dccp tcp_diag udp_diag inet_diag unix_diag cfg80211 rfkill 8021q garp mrp=
 xfs loop
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel crypto=
_simd
glue_helper cryptd iTCO_wdt intel_cstate hpwdt hpilo iTCO_vendor_support =
sg
intel_rapl_perf ipmi_si pcspkr ioatdma shpchp lpc_ich i2c_i801 ipmi_devin=
tf dca
mfd_core wmi ipmi_msghandler nfsd auth_rpcgss nfs_acl lockd grace sunrpc =
ip_tables
ext4 mbcache jbd2 i2c_algo_bit sd_mod drm_kms_helper syscopyarea sysfillr=
ect
sysimgblt fb_sys_fops ttm bnx2x serio_raw mdio libcrc32c crc32c_intel hps=
a ptp drm
scsi_transport_sas pps_core dm_mirror dm_region_hash dm_log dm_mod dax
[138630.871763] CPU: 14 PID: 26002 Comm: kworker/u66:3 Not tainted
4.14.32-1.el7.x86_64 #1
[138630.910864] Hardware name: HP ProLiant BL460c Gen9, BIOS I36 10/25/20=
17
[138630.943498] Workqueue: events_unbound fsnotify_connector_destroy_work=
fn
[138630.976569] task: ffff88203b62ae80 task.stack: ffffc90008a20000
[138631.005895] RIP: 0010:kmem_cache_free+0x133/0x1c0
[138631.029230] RSP: 0018:ffffc90008a23e20 EFLAGS: 00010246
[138631.055217] RAX: 000000000000007c RBX: ffff882000000000 RCX: 00000000=
00000000
[138631.091346] RDX: 0000000000000000 RSI: ffff88203f3969d8 RDI: ffff8820=
3f3969d8
[138631.127139] RBP: ffffc90008a23e38 R08: 0000000000000001 R09: 00000000=
0000057d
[138631.162575] R10: ffff88102b906cf0 R11: ffff88102b913ea0 R12: ffff8810=
3f579980
[138631.198018] R13: ffff88203bd57c00 R14: ffff88203bd63f00 R15: ffffffff=
82128388
[138631.233371] FS:  0000000000000000(0000) GS:ffff88203f380000(0000)
knlGS:0000000000000000
[138631.273426] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[138631.301980] CR2: 0000000003600fd8 CR3: 000000000200a006 CR4: 00000000=
003606e0
[138631.338783] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
[138631.374525] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
[138631.409797] Call Trace:
[138631.422387]  fsnotify_connector_destroy_workfn+0x68/0x80
[138631.448516]  process_one_work+0x15c/0x380
[138631.468352]  worker_thread+0x4d/0x3e0
[138631.486705]  kthread+0x10c/0x140
[138631.503091]  ? max_active_store+0x80/0x80
[138631.523217]  ? __kthread_parkme+0x70/0x70
[138631.543338]  ? do_syscall_64+0x79/0x1b0
[138631.562518]  ret_from_fork+0x35/0x40
[138631.580199] Code: 4c 3b a7 d8 00 00 00 0f 84 11 ff ff ff 48 8b 4f 60 =
49 8b 54
24 60 48 c7 c6 c0 19 c3 81 48 c7 c7 c0 9c e7 81 31 c0 e8 90 a5 eb ff <0f>=
 0b4c 89
e7 e9 e9 fe ff ff 65 8b 05 2c 3c de 7e 89 c0 48 0f
[138631.672489] ---[ end trace 6748d86d682915c2 ]---
[138631.695691] cache_from_obj: Wrong slab cache. fsnotify_mark_connector=
 but
object is from kmalloc-2048(361:anycast-healthchecker.service)
---

The kernel was fine and server was responsive.
A coworker mentioned that it may come from
https://github.com/torvalds/linux/blob/master/fs/notify/mark.c#L160
and commit
08991e83b728 ("fsnotify: Free fsnotify_mark_connector when there is no ma=
rk
attached") arrived with 4.12-rc1 may be the cause of it.

I am wondering if it is related to the issue I reported
https://lkml.org/lkml/2018/4/16/506. But, that issue causes the whole ser=
ver to
crash, which is not the case for above kernel dump.


Cheers,
Pavlos


--Cf0d4OeM4IvFWjtwla81r91MTZGlPZqDB--

--xnxD2sLDWbG1RnmHCILAOl43qlBQuLh9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa1c7lAAoJEIP8ktofcXa5o9gP/0kLGQ67nx2tSmwRA0Pblq7x
l0zlB3FW/x5o4kNoMp8f+Dn2l8QJe2tIjTTrHsWGSdUzKeR1FtYxNKfag/OLgkKf
MuQSbLt9VuTxuD2pWdXx3eruoBk36I0zx5f+AZVwgLD6wn37OdgOdApSxGGRmWY/
qPRzAvpMF8puu7yZRc19aIJ+9jOi9xIX+G/WPQ3fGEMPrs/g27NZIYsiXbUTDBiB
EkSGIeju15mSJOgunizQUP+YpLGOZvEXG7TtLBGZQwh21ZZjFrPcMuERyuSX8/IO
EkkbSHprKnmmtoy3oy0VqME4vU0D4cEAwPoOEMl1f+B84iN7sOEtRtSPKcGIaU0w
iy78treGVCNWRydYy1HkUZv0iEHVMNUvx/naMNJQ7VKC1st2E/ku/SjqNN6QSym8
K0RxmxtfKzDXzhV2eOVnk7N0NlDF1jPj8XTunAqDoHpYeoEil3JeR+WCFB8yQuix
hBwTD9yWK3RI2ZxRR5cFccOYeP8VHHtca0yCe7S9BebVuwm2yJ1/78ddXh/h6Vrc
9KRuC4PSHiwWVKkde3a26DfLY+zCQ4ER917Ok0/dfWllOjhqS34dMvGCSL8fp5rG
N4xn1CkNB1uHC1+mNrPZbLhb6tfT08t07k+SDuwyW30sKGiK8kasEPFnoXx2r+wZ
9YfjJ4xINTie0DzMcH0u
=krjs
-----END PGP SIGNATURE-----

--xnxD2sLDWbG1RnmHCILAOl43qlBQuLh9E--
