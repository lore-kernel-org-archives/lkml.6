Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3032644-1523879661-2-18361159482320934703
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
    1523879658; b=eOTBi1bmso6hygyXcH0nOnARUmAniX6GjS1q4QIFoxLfhive00
    bMMkClybT0vTTZdG6K9iFEx7+xCHTxlOqQgEjxGPygvPfWHqFulpf59HzwpaAF3S
    1Io0j6SzNafZNHiYBFi4RH/Ks++AERrCL7P+zhrhaeR1c2lz749nddqYaU7XXAAo
    fa20BUcrBcRdURKbZNDvWVoM2kftGDw0P8M8bj3ZGZuK3vSmQxEAKDCWVjbpCl5A
    zdb8ilBToLQyGD21xJwxUGtW3BCnX49+AxYlX9at5YM4G79Xw9vYC/34YUomXVib
    mpb8JL4LkpMWCb0qVTCBVeVxqWI3OxA/T09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:message-id:date
    :mime-version:content-type:sender:list-id; s=fm2; t=1523879658;
    bh=J4SePfvTV+xa7QHLQWsg8SDNexFDQOnQdCdh0DIyB70=; b=AiFH2sLfa2Mq
    HYIOUQsk+4avzzAo3ujATsHG8wC88WTu6LgrYkjqq3nzS8+vP2AmViFe+0OMKY32
    t2vT7OnOb46Mn2B/OLc7vDdehYsAil6G3TFdCBe3yg/tu7wOTl0hzGF4yWzSTOeB
    FKqvkTmMYhd3Ms4CkT9dGGxaOV/KNwIprbLq00hFyU+Uzsp60kAzuNiPK4Fki1fj
    5VmIz9OpI2fU4sUzv75bV0Kn/kv7AAt4hYxPLccnWlXOUJ8GkcbtkhavOgpQjltX
    QgnrBtlxp3jy+ZPYewETGm8EYz/mf1qlAXwHuwq0FBCTjKW/V1gecVaIm2HVBj6R
    27fKti3C6w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QXGvRT3S x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jmjR5tVK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QXGvRT3S x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jmjR5tVK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEgAdpLjRQvQeqS0uiAGk8DlwYUqMARaACw5wwMC4MTbWoAPVSdP/wYxJrDJzmg53XrBvuGBz0MytcLwPJdOWo5xcW935t5FWX82ToSY0n+uwM8BwZI/
    nUZ4yrx/EzxDIE+pJuGPU2fi3/67J9i3HUU+diPfggXcRXa5YIgOq61k2GY01pq4Gp/+bDj7JInXVbbNh0fhTMdiKPJjBoQX0sLhcZ+SyGbpqzJwIceXL0ye
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=ZVeAwwkMJCUA:10
    a=Kd1tUaAdevIA:10 a=13zjGPudsaEWiJwPRgMA:9 a=lBDRjSdID2Lnv6pfUdEA:9
    a=QEXdDO2ut3YA:10 a=CMdTGAHCvWvgwPOtZvMA:9 a=ONNS8QRKHyMA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753412AbeDPLyQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 07:54:16 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:40529 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbeDPLyN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 07:54:13 -0400
X-Google-Smtp-Source: AIpwx48aQBL3JEmnHE8bPFqInoXj7igGjDsc/iStEe2xjjHaIKmMrktJUB+HEBGybEOeQE+QCEvrHQ==
From: Pavlos Parissis <pavlos.parissis@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pavlos.parissis@gmail.com; prefer-encrypt=mutual; keydata=
 xsFNBFE50ZMBEADWTPWBaVLkaIldRGfinwUAPEeawauL+XUmL+3KDMGm/ujxbyWw65vydmu1
 9svBd/OkII0bnf/r/8f5oBXcmYvkARqgu3V2B4L2vFzGDJw+7+5Dex3afg/T1/mvZdo2fUpu
 uWIVyWYIvK/MnVNx5uQpJoP3NwY7OqBUH3tOBTxFCtBSXVyXPLAQnV83GY584tmgvee9o8HU
 5YQhaxxYb6S8ROarAL74K4KAZ2nzlfgjCH5p3wg2lZuNNTzxKln44qIb5Q6HxpAOHiFOPg5d
 yUZd7dcdakegQru2A3MuhHKXVN04SEe5wLMeNdSsu1X+PdWSVvecX5kY/9axzoSvaazt92Vp
 CDovpgN0t7WE7Qcl17Uq76tlJAhCqLZldTMxMaXNtDH7l5csSHC8SHNKvQvhFa+sWc9Wbqya
 cSodO3+anHaAZ5qa7iICQUf0hTqlVu5wlQtIryn+dG/gh6+trp/tYqOOYg8JFfko7o6XHoYC
 v5eUSVbJDxyRkbZ/sUTJFO0/2hAwz3var48nTDYPYxCXxuk+1OaOWGHPGEUmq63fWNX0kOgk
 4o3QDeoivuzXOC8qi0yCW3+uWKT/sVEYPgFAey2/8CJCH+s776oUvdONPlpnQOuQ/6ea9ESF
 WfJNc8JayRhucRzoC2sPgB3wNJe2wBgICNch7JFy1SW+87SruQARAQABzTpQYXZsb3MgUGFy
 aXNzaXMgKHVuaXhzdXJmZXIpIDxwYXZsb3MucGFyaXNzaXNAYm9va2luZy5jb20+wsGYBBMB
 AgBCAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAIZARYhBB2Q2SugwbvmFI+vnYP8ktof
 cXa5BQJaacnZBQkM8l9GAAoJEIP8ktofcXa5wrcQAI1bpgoLNWUQdWEVXGEQDmymUGoiJd+L
 vDYRh0PV8bEh6hXbpWxBJyMQgyZDPtGlpojI6azwfloFg4bmVpx8tuGzxOSamUj12HSRQIcH
 6fZFhVqXXtHxaR/Ar+X25PxXYxzPKbbwlPs6Y5H/5sC7Yn3N9O86m0tBCG/735DYzm0w3KM1
 zvI2MgeNXZVJKdkr4qLhl+4bRZY1g02Pb7VZ2Wr1wc+kY1qe3htt0eq6dYNZn92XNLRtezhn
 H1gN8/RMCJL4WlsuXhMaGoKT1eB84dWzpJG6ZATYzFriAWS2MbZR76ouG60Wfe18YqVIOO8j
 umYve3J0aICxwlYwtFlqKYiNaahCB3YXUubkeLTHYQZkLr8IKSyqzuY8o4D9nq5/++6tscOW
 oT+ptpY9BzhhYuJGT+yBttqDGneJxZ333NyFsDy0GWnsTZTwgSE2NrUEI2M7tBwyunqfEMtF
 lfpF16lQ/+96WyhyB4OTf9TA/iyCaGAZ09wQ8H3fd2tVRjlmJ7szogmZepczpXv48MTXfr34
 mtJ8WEfVsQHkSssO3Vybnnm3bb+L8rbUg7DXDP5yTs7jpdseI57Lo1w8eoiuyhDQ19UN1eEj
 1YUdioXDJT3aLruUkkhboWnZxRRQ8eK9NE2uGs2M2oQrPewFDzcodixePpoSd+9pnSUIh/m3
 eOSdzsFNBFE50ZMBEAC/1BH//nQj2hIdDiBEKegibb8CiM2FrB9f1j0DjKMG68ZxbyqEyZoe
 zWNlREaNhkKmAZAz72/SMRkwQTXZ61UnllKdafppxdoMopcF9pXD6FM/a2Sx7VgBJVDBIx83
 sZpHrw5Pcuk8AuqNZkx+YJQyPIoGJL7wVoeLIkMaz2MVJ9BT3gP73XgsVS0AxBUUndxGbxQ1
 RdEyXSU2F4LEJ5HIJhqW6qppy5uLDZ0Ts6DL9uZYBj++MDkB3YnzVVVEVccvQeERSYEauSuZ
 fPE5iEY2xsQGXECslhiA/zgo4gZ5vn30ffDeoBOnfMztX/4ViLgE6GAO/VnlDCX4M2UGaX61
 6edtzJi1bDQjj1+BNxSQy7x++Z06E4y9wJHRysKLZarCvYO1y7iO/xLcfZiBgSgZ6nYudtjF
 jacA0kpDwTj7ZS3cn4kO52UXUDmx7eP6O9K9qspXpmjwuj147N7YCmsZwgnIPypxm3fVfldH
 nMFHjGeJl7Xs+5l2oF/LpFa6cpXgYFjRhmVwCNbln/5+HyT3YOFnkLdIEc1uCoMBPTsjr4xQ
 nic//fXlrtse/J5TIQR5S3HIchcJT7RIi3HnlAYfRVj1Dy+xvn8BsEkDPSLU5LcnUc8GFGmr
 Vubdz00W5K7vJy9AwvAqh6Sqh/v4+vYvun+BYv64sJxw4o16AcqPhwARAQABwsF8BBgBAgAm
 AhsMFiEEHZDZK6DBu+YUj6+dg/yS2h9xdrkFAlppyb0FCQzyXyoACgkQg/yS2h9xdrlKnA//
 SF0ZAosVWMinrajdSp9euRxWfdsp2Vn1vfEHT2S7V4p8APJZE8wE/I9UcSuPDUPjjB8Vw8iO
 vQoxg9vE11HadGScGaXnC2m5lQP4GgSN+g9AImZRoOkrBzklXBgf12mrrQ92UVJVr3AsflYw
 UBZ0/k4ySkym0KNQjq4Xd0NRbHMaFRHP6KgWTVPn36Cy9j9UwrFBb/QwQKpRbn79B3pWlN3v
 jQxKG4dhTFEburszqTqtEoXBnQeAch6L8wpaNsSNyDzMmoKczjz7dEwWVM65OvANxcflRp8p
 1H9aEWq04ga28fl+fWrNSCMXafHKpX2uz3FQRhtyMLaX8RZsixrTZK9GC+HLPw5Gc7utNFaC
 9WCQP75wE4Re3Z+g4yO7OmdYrOH2WC1Ga3IAEvWpKdf6sx0j4XWOqp4EBJ9GP8wBXZUmm8Xz
 xs0Ui6ayYI4guy08HUsysqcfAp/aGvriqZ01EcjlCkfnvQ/Xs+OIRy47h/mL2XwkT3C0wF+8
 /EYDe4i5XY47vv4cBwoPpw7O7z+AQ85VnQTb6ODJSJIyjIGC3VXb29qsuJOxc+Ina+wgAztE
 0E+eUNN5pjvWx/9v6e8E56bAizJhU/sKbQFk+B4MGYUqHwsSd9xrR8+Y/OtxhaxBU00WLBnw
 CjB2s83SyrTd4UWbbIdiUV5C4QiML5GSewM=
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: kernel panics with 4.14.X versions
Message-ID: <47d114b6-cf57-152a-32ad-07a541b05198@gmail.com>
Date: Mon, 16 Apr 2018 13:54:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MIjo29yQqek6uPytyMJp5P7bmvDC3zx28"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MIjo29yQqek6uPytyMJp5P7bmvDC3zx28
Content-Type: multipart/mixed; boundary="CWF5T6c1xqXOPcHEd2P74b03DlIbe7vAH";
 protected-headers="v1"
From: Pavlos Parissis <pavlos.parissis@gmail.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <47d114b6-cf57-152a-32ad-07a541b05198@gmail.com>
Subject: kernel panics with 4.14.X versions

--CWF5T6c1xqXOPcHEd2P74b03DlIbe7vAH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi all,

We have observed kernel panics on several master kubernetes clusters, whe=
re we run
kubernetes API services and not application workloads.

Those clusters use kernel version 4.14.14 and 4.14.32, but we switched ev=
erything
to kernel version 4.14.32 as a way to address the issue.

We have HP and Dell hardware on those clusters, and network cards are als=
o different,
we have bnx2x and mlx5_core in use.

We also run kernel version 4.14.32 on different type of workloads, softwa=
re load
balancing using HAProxy, and we don't have any crashes there.

Since the crash happens on different hardware, we think it could be a ker=
nel issue,
but we aren't sure about it. Thus, I am contacting kernel people in order=
 to get some
hint, which can help us to figure out what causes this.

In our kubernetes clusters, we have instructed the kernel to panic upon s=
oft lockup,
we use 'kernel.softlockup_panic=3D1', 'kernel.hung_task_panic=3D1' and 'k=
ernel.watchdog_thresh=3D10'.
Thus, we see the stack traces. Today, we have disabled this, later I will=
 explain why.

I believe we have two discint types of panics, one is trigger upon soft l=
ockup and another one
where the call trace is about scheduler("sched: Unexpected reschedule of =
offline CPU#8!)


Let me walk you through the kernel panics and some observations.

The followin series of stack traces are happening when one CPU (CPU 24) i=
s stuck for ~22 seconds.
watchdog_thresh is set to 10 and as far as I remember softlockup threshol=
d is (2 * watchdog_thresh),
so it makes sense to see the kernel crashing after ~20seconds.

After the stack trace, we have the output of sar for CPU#24 and we see th=
at just before the
crash CPU utilization for system level went to 100%. Now let's move to an=
other panic.

[373782.361064] watchdog: BUG: soft lockup - CPU#24 stuck for 22s! [kube-=
apiserver:24261]
[373782.378225] Modules linked in: binfmt_misc sctp_diag sctp dccp_diag d=
ccp tcp_diag udp_diag
inet_diag unix_diag cfg80211 rfkill dell_rbu 8021q garp mrp xfs libcrc32c=
 loop x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_=
pclmul ghash_clmulni_intel
pcbc aesni_intel vfat fat crypto_simd glue_helper cryptd intel_cstate int=
el_rapl_perf iTCO_wdt ses
iTCO_vendor_support mxm_wmi ipmi_si dcdbas enclosure mei_me pcspkr ipmi_d=
evintf lpc_ich sg mei
ipmi_msghandler mfd_core shpchp wmi acpi_power_meter netconsole nfsd auth=
_rpcgss nfs_acl lockd grace
sunrpc ip_tables ext4 mbcache jbd2 i2c_algo_bit drm_kms_helper syscopyare=
a sysfillrect sysimgblt
fb_sys_fops sd_mod ttm crc32c_intel ahci libahci mlx5_core drm mlxfw mpt3=
sas ptp libata raid_class
pps_core scsi_transport_sas
[373782.516807]  dm_mirror dm_region_hash dm_log dm_mod dax
[373782.531739] CPU: 24 PID: 24261 Comm: kube-apiserver Not tainted 4.14.=
32-1.el7.x86_64 #1
[373782.549848] Hardware name: Dell Inc. PowerEdge R630/02C2CP, BIOS 2.4.=
3 01/17/2017
[373782.567486] task: ffff882f66d28000 task.stack: ffffc9002120c000
[373782.583441] RIP: 0010:fsnotify+0x197/0x510
[373782.597319] RSP: 0018:ffffc9002120fdb8 EFLAGS: 00000286 ORIG_RAX: fff=
fffffffffff10
[373782.615308] RAX: 0000000000000000 RBX: ffff882f9ec65c20 RCX: 00000000=
00000002
[373782.632950] RDX: 0000000000028700 RSI: 0000000000000002 RDI: ffffffff=
8269a4e0
[373782.650616] RBP: ffffc9002120fe98 R08: 0000000000000000 R09: 00000000=
00000000
[373782.668287] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000=
00000000
[373782.685918] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
00000000
[373782.703302] FS:  000000c42009f090(0000) GS:ffff882fbf900000(0000) knl=
GS:0000000000000000
[373782.721887] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[373782.737741] CR2: 00007f82b6539244 CR3: 0000002f3de2a005 CR4: 00000000=
003606e0
[373782.755247] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
[373782.772722] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
[373782.790043] Call Trace:
[373782.802041]  vfs_write+0x151/0x1b0
[373782.815081]  ? syscall_trace_enter+0x1cd/0x2b0
[373782.829175]  SyS_write+0x55/0xc0
[373782.841870]  do_syscall_64+0x79/0x1b0
[373782.855073]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[373782.869807] RIP: 0033:0x483084
[373782.882293] RSP: 002b:000000c4387e57f0 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000001
[373782.899997] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000=
00483084
[373782.917177] RDX: 00000000000002b3 RSI: 000000c42e27d800 RDI: 00000000=
0000014b
[373782.934268] RBP: 000000c4387e5840 R08: 0000000000000000 R09: 00000000=
00000000
[373782.951297] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000=
00000000
[373782.968208] R13: 00000000000000f2 R14: 0000000000000032 R15: 00000000=
00000002
[373782.985003] Code: 0f 84 f6 02 00 00 48 8b 45 a0 4d 85 d2 48 8b 00 48 =
89 45 a8 48 89 45 a0 0f 85
ef 02 00 00 48 8b 45 b0 48 89 45 98 48 83 7d a0 00 <0f> 95 c0 48 83 7d 98=
 00 0f 95 c2 89 d1 08 c1 0f
84 fc 02 00 00
[373783.024208] Kernel panic - not syncing: softlockup: hung tasks
[373783.039881] CPU: 24 PID: 24261 Comm: kube-apiserver Tainted: G       =
      L
4.14.32-1.el7.x86_64 #1
[373783.059497] Hardware name: Dell Inc. PowerEdge R630/02C2CP, BIOS 2.4.=
3 01/17/2017
[373783.077206] Call Trace:
[373783.089115]  <IRQ>
[373783.100422]  dump_stack+0x63/0x88
[373783.113081]  panic+0xe8/0x258
[373783.125109]  watchdog_timer_fn+0x21a/0x230
[373783.138546]  ? watchdog+0x30/0x30
[373783.150870]  __hrtimer_run_queues+0xe7/0x230
[373783.164081]  hrtimer_interrupt+0xa8/0x1a0
[373783.176703]  smp_apic_timer_interrupt+0x6b/0x140
[373783.189788]  apic_timer_interrupt+0x8e/0xa0
[373783.202198]  </IRQ>
[373783.211900] RIP: 0010:fsnotify+0x197/0x510
[373783.223746] RSP: 0018:ffffc9002120fdb8 EFLAGS: 00000286 ORIG_RAX: fff=
fffffffffff10
[373783.239434] RAX: 0000000000000000 RBX: ffff882f9ec65c20 RCX: 00000000=
00000002
[373783.254599] RDX: 0000000000028700 RSI: 0000000000000002 RDI: ffffffff=
8269a4e0
[373783.269673] RBP: ffffc9002120fe98 R08: 0000000000000000 R09: 00000000=
00000000
[373783.284629] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000=
00000000
[373783.299460] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
00000000
[373783.314200]  ? fsnotify+0x4bb/0x510
[373783.324757]  vfs_write+0x151/0x1b0
[373783.335115]  ? syscall_trace_enter+0x1cd/0x2b0
[373783.346617]  SyS_write+0x55/0xc0
[373783.356735]  do_syscall_64+0x79/0x1b0
[373783.367330]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[373783.379606] RIP: 0033:0x483084
[373783.389540] RSP: 002b:000000c4387e57f0 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000001
[373783.404657] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000=
00483084
[373783.419294] RDX: 00000000000002b3 RSI: 000000c42e27d800 RDI: 00000000=
0000014b
[373783.433922] RBP: 000000c4387e5840 R08: 0000000000000000 R09: 00000000=
00000000
[373783.448565] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000=
00000000
[373783.463128] R13: 00000000000000f2 R14: 0000000000000032 R15: 00000000=
00000002
[373783.477744] Kernel Offset: disabled
[373783.492343] ---[ end Kernel panic - not syncing: softlockup: hung tas=
ks
[373783.506452] ------------[ cut here ]------------
[373783.518376] WARNING: CPU: 24 PID: 24261 at kernel/sched/core.c:1179 s=
et_task_cpu+0x197/0x1a0
[373783.534730] Modules linked in: binfmt_misc sctp_diag sctp dccp_diag d=
ccp tcp_diag udp_diag
inet_diag unix_diag cfg80211 rfkill dell_rbu 8021q garp mrp xfs libcrc32c=
 loop x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_=
pclmul ghash_clmulni_intel
pcbc aesni_intel vfat fat crypto_simd glue_helper cryptd intel_cstate int=
el_rapl_perf iTCO_wdt ses
iTCO_vendor_support mxm_wmi ipmi_si dcdbas enclosure mei_me pcspkr ipmi_d=
evintf lpc_ich sg mei
ipmi_msghandler mfd_core shpchp wmi acpi_power_meter netconsole nfsd auth=
_rpcgss nfs_acl lockd grace
sunrpc ip_tables ext4 mbcache jbd2 i2c_algo_bit drm_kms_helper syscopyare=
a sysfillrect sysimgblt
fb_sys_fops sd_mod ttm crc32c_intel ahci libahci mlx5_core drm mlxfw mpt3=
sas ptp libata raid_class
pps_core scsi_transport_sas
[373783.667938]  dm_mirror dm_region_hash dm_log dm_mod dax
[373783.682082] CPU: 24 PID: 24261 Comm: kube-apiserver Tainted: G       =
      L
4.14.32-1.el7.x86_64 #1
[373783.700753] Hardware name: Dell Inc. PowerEdge R630/02C2CP, BIOS 2.4.=
3 01/17/2017
[373783.717501] task: ffff882f66d28000 task.stack: ffffc9002120c000
[373783.732386] RIP: 0010:set_task_cpu+0x197/0x1a0
[373783.745458] RSP: 0018:ffff882fbf903b88 EFLAGS: 00010046
[373783.759432] RAX: 0000000000000200 RBX: ffff885fb3cb45c0 RCX: 00000000=
00000001
[373783.775692] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff885f=
b3cb45c0
[373783.791999] RBP: ffff882fbf903ba8 R08: 0000000000000000 R09: 00000000=
00000000
[373783.808362] R10: 0000000000000000 R11: 0000000000000000 R12: ffff885f=
b3cb516c
[373783.824785] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
00022ac0
[373783.841196] FS:  000000c42009f090(0000) GS:ffff882fbf900000(0000) knl=
GS:0000000000000000
[373783.858761] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[373783.873710] CR2: 00007f82b6539244 CR3: 0000002f3de2a005 CR4: 00000000=
003606e0
[373783.890304] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
[373783.906951] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
[373783.923503] Call Trace:
[373783.934742]  <IRQ>
[373783.945346]  try_to_wake_up+0x16c/0x480
[373783.957961]  default_wake_function+0x12/0x20
[373783.971086]  autoremove_wake_function+0x16/0x60
[373783.984483]  __wake_up_common+0x8f/0x160
[373783.997154]  __wake_up_common_lock+0x7e/0xc0
[373784.010293]  __wake_up+0x13/0x20
[373784.022125]  wake_up_klogd_work_func+0x40/0x60
[373784.035365]  irq_work_run_list+0x53/0x80
[373784.048042]  irq_work_run+0x2c/0x30
[373784.060132]  flush_smp_call_function_queue+0x88/0x110
[373784.074076]  generic_smp_call_function_single_interrupt+0x13/0x30
[373784.089312]  smp_call_function_single_interrupt+0x3a/0xe0
[373784.103788]  call_function_single_interrupt+0x8e/0xa0
[373784.117820] RIP: 0010:panic+0x206/0x258
[373784.130402] RSP: 0018:ffff882fbf903e80 EFLAGS: 00000246 ORIG_RAX: fff=
fffffffffff04
[373784.147325] RAX: 000000000000003b RBX: 0000000000000000 RCX: 00000000=
00000006
[373784.163842] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffff882f=
bf9169d0
[373784.180394] RBP: ffff882fbf903ef0 R08: 0000000000000001 R09: 00000000=
000006b1
[373784.197041] R10: 0000000000000001 R11: 0000000000000002 R12: ffffffff=
81e6be9f
[373784.213609] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
ee6b2800
[373784.230077]  watchdog_timer_fn+0x21a/0x230
[373784.243095]  ? watchdog+0x30/0x30
[373784.255113]  __hrtimer_run_queues+0xe7/0x230
[373784.267974]  hrtimer_interrupt+0xa8/0x1a0
[373784.280195]  smp_apic_timer_interrupt+0x6b/0x140
[373784.292919]  apic_timer_interrupt+0x8e/0xa0
[373784.304979]  </IRQ>
[373784.314365] RIP: 0010:fsnotify+0x197/0x510
[373784.325739] RSP: 0018:ffffc9002120fdb8 EFLAGS: 00000286 ORIG_RAX: fff=
fffffffffff10
[373784.340979] RAX: 0000000000000000 RBX: ffff882f9ec65c20 RCX: 00000000=
00000002
[373784.355767] RDX: 0000000000028700 RSI: 0000000000000002 RDI: ffffffff=
8269a4e0
[373784.370474] RBP: ffffc9002120fe98 R08: 0000000000000000 R09: 00000000=
00000000
[373784.385000] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000=
00000000
[373784.399438] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
00000000
[373784.413725]  ? fsnotify+0x4bb/0x510
[373784.423875]  vfs_write+0x151/0x1b0
[373784.433861]  ? syscall_trace_enter+0x1cd/0x2b0
[373784.444973]  SyS_write+0x55/0xc0
[373784.454738]  do_syscall_64+0x79/0x1b0
[373784.464901]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[373784.476731] RIP: 0033:0x483084
[373784.486201] RSP: 002b:000000c4387e57f0 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000001
[373784.500878] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000=
00483084
[373784.515015] RDX: 00000000000002b3 RSI: 000000c42e27d800 RDI: 00000000=
0000014b
[373784.529155] RBP: 000000c4387e5840 R08: 0000000000000000 R09: 00000000=
00000000
[373784.543400] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000=
00000000
[373784.557490] R13: 00000000000000f2 R14: 0000000000000032 R15: 00000000=
00000002
[373784.571578] Code: ff 80 8b ac 08 00 00 04 e9 20 ff ff ff 0f 0b e9 b9 =
fe ff ff f7 83 84 00 00 00
fd ff ff ff 0f 84 c3 fe ff ff 0f 0b e9 bc fe ff ff <0f> 0b e9 cb fe ff ff=
 66 90 0f 1f 44 00 00 55 48
89 e5 41 56 49
[373784.605527] ---[ end trace d3faf76bdc3ca403 ]---
[373784.617188] sched: Unexpected reschedule of offline CPU#0!
[373784.629856] ------------[ cut here ]------------
[373784.641694] WARNING: CPU: 24 PID: 24261 at arch/x86/kernel/smp.c:128
native_smp_send_reschedule+0x42/0x50
[373784.659370] Modules linked in: binfmt_misc sctp_diag sctp dccp_diag d=
ccp tcp_diag udp_diag
inet_diag unix_diag cfg80211 rfkill dell_rbu 8021q garp mrp xfs libcrc32c=
 loop x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_=
pclmul ghash_clmulni_intel
pcbc aesni_intel vfat fat crypto_simd glue_helper cryptd intel_cstate int=
el_rapl_perf iTCO_wdt ses
iTCO_vendor_support mxm_wmi ipmi_si dcdbas enclosure mei_me pcspkr ipmi_d=
evintf lpc_ich sg mei
ipmi_msghandler mfd_core shpchp wmi acpi_power_meter netconsole nfsd auth=
_rpcgss nfs_acl lockd grace
sunrpc ip_tables ext4 mbcache jbd2 i2c_algo_bit drm_kms_helper syscopyare=
a sysfillrect sysimgblt
fb_sys_fops sd_mod ttm crc32c_intel ahci libahci mlx5_core drm mlxfw mpt3=
sas ptp libata raid_class
pps_core scsi_transport_sas
[373784.793557]  dm_mirror dm_region_hash dm_log dm_mod dax
[373784.807848] CPU: 24 PID: 24261 Comm: kube-apiserver Tainted: G       =
 W    L
4.14.32-1.el7.x86_64 #1
[373784.826743] Hardware name: Dell Inc. PowerEdge R630/02C2CP, BIOS 2.4.=
3 01/17/2017
[373784.843685] task: ffff882f66d28000 task.stack: ffffc9002120c000
[373784.858935] RIP: 0010:native_smp_send_reschedule+0x42/0x50
[373784.873706] RSP: 0018:ffff882fbf903b10 EFLAGS: 00010046
[373784.888200] RAX: 000000000000002e RBX: 0000000000000000 RCX: 00000000=
00000006
[373784.904979] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffff882f=
bf9169d0
[373784.921626] RBP: ffff882fbf903b10 R08: 0000000000000001 R09: 00000000=
000006f8
[373784.938313] R10: 0000000000000001 R11: 0000000000000000 R12: ffff882f=
bf622ac0
[373784.955106] R13: ffff885fb3cb45c0 R14: ffff882fbf903bc8 R15: ffff882f=
bf622ac0
[373784.971891] FS:  000000c42009f090(0000) GS:ffff882fbf900000(0000) knl=
GS:0000000000000000
[373784.989852] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[373785.005204] CR2: 00007f82b6539244 CR3: 0000002f3de2a005 CR4: 00000000=
003606e0
[373785.022197] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
[373785.039227] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
[373785.056132] Call Trace:
[373785.067623]  <IRQ>
[373785.078506]  resched_curr+0xae/0xd0
[373785.091051]  check_preempt_curr+0x79/0xa0
[373785.104217]  ttwu_do_wakeup+0x1e/0x160
[373785.117171]  ttwu_do_activate+0x7a/0x90
[373785.130058]  try_to_wake_up+0x1e7/0x480
[373785.142959]  default_wake_function+0x12/0x20
[373785.156411]  autoremove_wake_function+0x16/0x60
[373785.170119]  __wake_up_common+0x8f/0x160
[373785.183152]  __wake_up_common_lock+0x7e/0xc0
[373785.196508]  __wake_up+0x13/0x20
[373785.208612]  wake_up_klogd_work_func+0x40/0x60
[373785.222065]  irq_work_run_list+0x53/0x80
[373785.234885]  irq_work_run+0x2c/0x30
[373785.247071]  flush_smp_call_function_queue+0x88/0x110
[373785.261146]  generic_smp_call_function_single_interrupt+0x13/0x30
[373785.276556]  smp_call_function_single_interrupt+0x3a/0xe0
[373785.291300]  call_function_single_interrupt+0x8e/0xa0
[373785.305485] RIP: 0010:panic+0x206/0x258
[373785.318154] RSP: 0018:ffff882fbf903e80 EFLAGS: 00000246 ORIG_RAX: fff=
fffffffffff04
[373785.335001] RAX: 000000000000003b RBX: 0000000000000000 RCX: 00000000=
00000006
[373785.351418] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffff882f=
bf9169d0
[373785.367776] RBP: ffff882fbf903ef0 R08: 0000000000000001 R09: 00000000=
000006b1
[373785.383990] R10: 0000000000000001 R11: 0000000000000002 R12: ffffffff=
81e6be9f
[373785.400019] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
ee6b2800
[373785.415792]  watchdog_timer_fn+0x21a/0x230
[373785.427910]  ? watchdog+0x30/0x30
[373785.438891]  __hrtimer_run_queues+0xe7/0x230
[373785.450736]  hrtimer_interrupt+0xa8/0x1a0
[373785.462037]  smp_apic_timer_interrupt+0x6b/0x140
[373785.473814]  apic_timer_interrupt+0x8e/0xa0
[373785.485054]  </IRQ>
[373785.493740] RIP: 0010:fsnotify+0x197/0x510
[373785.504592] RSP: 0018:ffffc9002120fdb8 EFLAGS: 00000286 ORIG_RAX: fff=
fffffffffff10
[373785.519343] RAX: 0000000000000000 RBX: ffff882f9ec65c20 RCX: 00000000=
00000002
[373785.533627] RDX: 0000000000028700 RSI: 0000000000000002 RDI: ffffffff=
8269a4e0
[373785.547934] RBP: ffffc9002120fe98 R08: 0000000000000000 R09: 00000000=
00000000
[373785.562192] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000=
00000000
[373785.576431] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
00000000
[373785.590592]  ? fsnotify+0x4bb/0x510
[373785.600647]  vfs_write+0x151/0x1b0
[373785.610507]  ? syscall_trace_enter+0x1cd/0x2b0
[373785.621459]  SyS_write+0x55/0xc0
[373785.630952]  do_syscall_64+0x79/0x1b0
[373785.640818]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[373785.652319] RIP: 0033:0x483084
[373785.661599] RSP: 002b:000000c4387e57f0 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000001
[373785.676059] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000=
00483084
[373785.690181] RDX: 00000000000002b3 RSI: 000000c42e27d800 RDI: 00000000=
0000014b
[373785.704317] RBP: 000000c4387e5840 R08: 0000000000000000 R09: 00000000=
00000000
[373785.718448] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000=
00000000
[373785.732562] R13: 00000000000000f2 R14: 0000000000000032 R15: 00000000=
00000002
[373785.746624] Code: c0 74 1a 48 8b 05 7f 44 ec 00 be fd 00 00 00 48 8b =
80 a0 00 00 00 e8 ae 1a 9b
00 5d c3 89 fe 48 c7 c7 b8 26 e5 81 e8 21 45 09 00 <0f> 0b 5d c3 66 2e 0f=
 1f 84 00 00 00 00 00 0f 1f
44 00 00 55 48
[373785.780531] ---[ end trace d3faf76bdc3ca404 ]---
[373785.792207] sched: Unexpected reschedule of offline CPU#42!
[373785.804993] ------------[ cut here ]------------
[373785.816775] WARNING: CPU: 24 PID: 24261 at arch/x86/kernel/smp.c:128
native_smp_send_reschedule+0x42/0x50
[373785.834478] Modules linked in: binfmt_misc sctp_diag sctp dccp_diag d=
ccp tcp_diag udp_diag
inet_diag unix_diag cfg80211 rfkill dell_rbu 8021q garp mrp xfs libcrc32c=
 loop x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_=
pclmul ghash_clmulni_intel
pcbc aesni_intel vfat fat crypto_simd glue_helper cryptd intel_cstate int=
el_rapl_perf iTCO_wdt ses
iTCO_vendor_support mxm_wmi ipmi_si dcdbas enclosure mei_me pcspkr ipmi_d=
evintf lpc_ich sg mei
ipmi_msghandler mfd_core shpchp wmi acpi_power_meter netconsole nfsd auth=
_rpcgss nfs_acl lockd grace
sunrpc ip_tables ext4 mbcache jbd2 i2c_algo_bit drm_kms_helper syscopyare=
a sysfillrect sysimgblt
fb_sys_fops sd_mod ttm crc32c_intel ahci libahci mlx5_core drm mlxfw mpt3=
sas ptp libata raid_class
pps_core scsi_transport_sas
[373785.968794]  dm_mirror dm_region_hash dm_log dm_mod dax
[373785.983020] CPU: 24 PID: 24261 Comm: kube-apiserver Tainted: G       =
 W    L
4.14.32-1.el7.x86_64 #1
[373786.001870] Hardware name: Dell Inc. PowerEdge R630/02C2CP, BIOS 2.4.=
3 01/17/2017
[373786.018790] task: ffff882f66d28000 task.stack: ffffc9002120c000
[373786.034031] RIP: 0010:native_smp_send_reschedule+0x42/0x50
[373786.048836] RSP: 0018:ffff882fbf9039e0 EFLAGS: 00010046
[373786.063302] RAX: 000000000000002f RBX: 000000000000002a RCX: 00000000=
00000006
[373786.080012] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffff882f=
bf9169d0
[373786.096647] RBP: ffff882fbf9039e0 R08: 0000000000000001 R09: 00000000=
00000743
[373786.113328] R10: 0000000000000001 R11: 0000000000000000 R12: ffff882f=
bfb62ac0
[373786.130019] R13: ffff882fb3f61740 R14: ffff882fbf903a98 R15: ffff882f=
bfb62ac0
[373786.146724] FS:  000000c42009f090(0000) GS:ffff882fbf900000(0000) knl=
GS:0000000000000000
[373786.164613] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[373786.179892] CR2: 00007f82b6539244 CR3: 0000002f3de2a005 CR4: 00000000=
003606e0
[373786.196879] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
[373786.213858] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
[373786.230669] Call Trace:
[373786.242081]  <IRQ>
[373786.252989]  resched_curr+0xae/0xd0
[373786.265510]  check_preempt_curr+0x79/0xa0
[373786.278628]  ttwu_do_wakeup+0x1e/0x160
[373786.291544]  ttwu_do_activate+0x7a/0x90
[373786.304508]  try_to_wake_up+0x1e7/0x480
[373786.317475]  ? check_preempt_curr+0x79/0xa0
[373786.330755]  default_wake_function+0x12/0x20
[373786.344077]  __wake_up_common+0x8f/0x160
[373786.357105]  __wake_up_locked+0x16/0x20
[373786.369982]  complete+0x42/0x60
[373786.381975]  mlx5_cmd_comp_handler+0x28f/0x4b0 [mlx5_core]
[373786.396534]  mlx5_eq_int+0x1ae/0x550 [mlx5_core]
[373786.410080]  ? __wake_up_common+0x8f/0x160
[373786.423054]  __handle_irq_event_percpu+0x42/0x1a0
[373786.436719]  handle_irq_event_percpu+0x32/0x80
[373786.450184]  handle_irq_event+0x3b/0x60
[373786.462935]  handle_edge_irq+0x95/0x1a0
[373786.475441]  handle_irq+0xb5/0x140
[373786.487323]  ? irq_work_run+0x2c/0x30
[373786.499336]  ? flush_smp_call_function_queue+0x88/0x110
[373786.513191]  do_IRQ+0x48/0xe0
[373786.524434]  common_interrupt+0x8e/0x8e
[373786.536517] RIP: 0010:panic+0x206/0x258
[373786.548351] RSP: 0018:ffff882fbf903e80 EFLAGS: 00000246 ORIG_RAX: fff=
fffffffffff7e
[373786.564290] RAX: 000000000000003b RBX: 0000000000000000 RCX: 00000000=
00000006
[373786.579556] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffff882f=
bf9169d0
[373786.594559] RBP: ffff882fbf903ef0 R08: 0000000000000001 R09: 00000000=
000006b1
[373786.609374] R10: 0000000000000001 R11: 0000000000000002 R12: ffffffff=
81e6be9f
[373786.623990] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
ee6b2800
[373786.638331]  watchdog_timer_fn+0x21a/0x230
[373786.649202]  ? watchdog+0x30/0x30
[373786.659024]  __hrtimer_run_queues+0xe7/0x230
[373786.669762]  hrtimer_interrupt+0xa8/0x1a0
[373786.680120]  smp_apic_timer_interrupt+0x6b/0x140
[373786.691100]  apic_timer_interrupt+0x8e/0xa0
[373786.701618]  </IRQ>
[373786.709633] RIP: 0010:fsnotify+0x197/0x510
[373786.719960] RSP: 0018:ffffc9002120fdb8 EFLAGS: 00000286 ORIG_RAX: fff=
fffffffffff10
[373786.734322] RAX: 0000000000000000 RBX: ffff882f9ec65c20 RCX: 00000000=
00000002
[373786.748258] RDX: 0000000000028700 RSI: 0000000000000002 RDI: ffffffff=
8269a4e0
[373786.762175] RBP: ffffc9002120fe98 R08: 0000000000000000 R09: 00000000=
00000000
[373786.776003] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000=
00000000
[373786.789766] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
00000000
[373786.803354]  ? fsnotify+0x4bb/0x510
[373786.812823]  vfs_write+0x151/0x1b0
[373786.822215]  ? syscall_trace_enter+0x1cd/0x2b0
[373786.832724]  SyS_write+0x55/0xc0
[373786.841898]  do_syscall_64+0x79/0x1b0
[373786.851586]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[373786.862893] RIP: 0033:0x483084
[373786.871921] RSP: 002b:000000c4387e57f0 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000001
[373786.886319] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000=
00483084
[373786.900279] RDX: 00000000000002b3 RSI: 000000c42e27d800 RDI: 00000000=
0000014b
[373786.914247] RBP: 000000c4387e5840 R08: 0000000000000000 R09: 00000000=
00000000
[373786.928229] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000=
00000000
[373786.942195] R13: 00000000000000f2 R14: 0000000000000032 R15: 00000000=
00000002
[373786.956171] Code: c0 74 1a 48 8b 05 7f 44 ec 00 be fd 00 00 00 48 8b =
80 a0 00 00 00 e8 ae 1a 9b
00 5d c3 89 fe 48 c7 c7 b8 26 e5 81 e8 21 45 09 00 <0f> 0b 5d c3 66 2e 0f=
 1f 84 00 00 00 00 00 0f 1f
44 00 00 55 48
[373786.989819] ---[ end trace d3faf76bdc3ca405 ]---
[373787.001313] sched: Unexpected reschedule of offline CPU#36!
[373787.013940] ------------[ cut here ]------------
[373787.025482] WARNING: CPU: 24 PID: 24261 at arch/x86/kernel/smp.c:128
native_smp_send_reschedule+0x42/0x50
[373787.042884] Modules linked in: binfmt_misc sctp_diag sctp dccp_diag d=
ccp tcp_diag udp_diag
inet_diag unix_diag cfg80211 rfkill dell_rbu 8021q garp mrp xfs libcrc32c=
 loop x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_=
pclmul ghash_clmulni_intel
pcbc aesni_intel vfat fat crypto_simd glue_helper cryptd intel_cstate int=
el_rapl_perf iTCO_wdt ses
iTCO_vendor_support mxm_wmi ipmi_si dcdbas enclosure mei_me pcspkr ipmi_d=
evintf lpc_ich sg mei
ipmi_msghandler mfd_core shpchp wmi acpi_power_meter netconsole nfsd auth=
_rpcgss nfs_acl lockd grace
sunrpc ip_tables ext4 mbcache jbd2 i2c_algo_bit drm_kms_helper syscopyare=
a sysfillrect sysimgblt
fb_sys_fops sd_mod ttm crc32c_intel ahci libahci mlx5_core drm mlxfw mpt3=
sas ptp libata raid_class
pps_core scsi_transport_sas
[373787.175654]  dm_mirror dm_region_hash dm_log dm_mod dax
[373787.189862] CPU: 24 PID: 24261 Comm: kube-apiserver Tainted: G       =
 W    L
4.14.32-1.el7.x86_64 #1
[373787.208727] Hardware name: Dell Inc. PowerEdge R630/02C2CP, BIOS 2.4.=
3 01/17/2017
[373787.225686] task: ffff882f66d28000 task.stack: ffffc9002120c000
[373787.240916] RIP: 0010:native_smp_send_reschedule+0x42/0x50
[373787.255668] RSP: 0018:ffff882fbf9039e0 EFLAGS: 00010046
[373787.270138] RAX: 000000000000002f RBX: 0000000000000024 RCX: 00000000=
00000006
[373787.286911] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffff882f=
bf9169d0
[373787.303602] RBP: ffff882fbf9039e0 R08: 0000000000000001 R09: 00000000=
00000793
[373787.320314] R10: 0000000000000001 R11: 0000000000000000 R12: ffff882f=
bfaa2ac0
[373787.337037] R13: ffff882fb78bdd00 R14: ffff882fbf903a98 R15: ffff882f=
bfaa2ac0
[373787.353793] FS:  000000c42009f090(0000) GS:ffff882fbf900000(0000) knl=
GS:0000000000000000
[373787.371708] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[373787.387114] CR2: 00007f82b6539244 CR3: 0000002f3de2a005 CR4: 00000000=
003606e0
[373787.404143] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
[373787.421146] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
[373787.438016] Call Trace:
[373787.449503]  <IRQ>
[373787.460353]  resched_curr+0xae/0xd0
[373787.472913]  check_preempt_curr+0x79/0xa0
[373787.486064]  ttwu_do_wakeup+0x1e/0x160
[373787.499014]  ttwu_do_activate+0x7a/0x90
[373787.511930]  try_to_wake_up+0x1e7/0x480
[373787.524803]  ? check_preempt_curr+0x79/0xa0
[373787.538097]  default_wake_function+0x12/0x20
[373787.551463]  __wake_up_common+0x8f/0x160
[373787.564411]  __wake_up_locked+0x16/0x20
[373787.577191]  complete+0x42/0x60
[373787.589104]  mlx5_cmd_comp_handler+0x28f/0x4b0 [mlx5_core]
[373787.603704]  mlx5_eq_int+0x1ae/0x550 [mlx5_core]
[373787.617258]  ? __wake_up_common+0x8f/0x160
[373787.630170]  __handle_irq_event_percpu+0x42/0x1a0
[373787.643819]  handle_irq_event_percpu+0x32/0x80
[373787.657224]  handle_irq_event+0x3b/0x60
[373787.670045]  handle_edge_irq+0x95/0x1a0
[373787.682656]  handle_irq+0xb5/0x140
[373787.694520]  ? irq_work_run+0x2c/0x30
[373787.706546]  ? flush_smp_call_function_queue+0x88/0x110
[373787.720372]  do_IRQ+0x48/0xe0
[373787.731599]  common_interrupt+0x8e/0x8e
[373787.743630] RIP: 0010:panic+0x206/0x258
[373787.755405] RSP: 0018:ffff882fbf903e80 EFLAGS: 00000246 ORIG_RAX: fff=
fffffffffff7e
[373787.771355] RAX: 000000000000003b RBX: 0000000000000000 RCX: 00000000=
00000006
[373787.786634] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffff882f=
bf9169d0
[373787.801646] RBP: ffff882fbf903ef0 R08: 0000000000000001 R09: 00000000=
000006b1
[373787.816462] R10: 0000000000000001 R11: 0000000000000002 R12: ffffffff=
81e6be9f
[373787.831010] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
ee6b2800
[373787.845323]  watchdog_timer_fn+0x21a/0x230
[373787.856160]  ? watchdog+0x30/0x30
[373787.866021]  __hrtimer_run_queues+0xe7/0x230
[373787.876785]  hrtimer_interrupt+0xa8/0x1a0
[373787.887167]  smp_apic_timer_interrupt+0x6b/0x140
[373787.898177]  apic_timer_interrupt+0x8e/0xa0
[373787.908668]  </IRQ>
[373787.916761] RIP: 0010:fsnotify+0x197/0x510
[373787.927091] RSP: 0018:ffffc9002120fdb8 EFLAGS: 00000286 ORIG_RAX: fff=
fffffffffff10
[373787.941434] RAX: 0000000000000000 RBX: ffff882f9ec65c20 RCX: 00000000=
00000002
[373787.955328] RDX: 0000000000028700 RSI: 0000000000000002 RDI: ffffffff=
8269a4e0
[373787.969286] RBP: ffffc9002120fe98 R08: 0000000000000000 R09: 00000000=
00000000
[373787.983117] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000=
00000000
[373787.996820] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
00000000
[373788.010389]  ? fsnotify+0x4bb/0x510
[373788.019908]  vfs_write+0x151/0x1b0
[373788.029296]  ? syscall_trace_enter+0x1cd/0x2b0
[373788.039801]  SyS_write+0x55/0xc0
[373788.048985]  do_syscall_64+0x79/0x1b0
[373788.058645]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[373788.069978] RIP: 0033:0x483084
[373788.079028] RSP: 002b:000000c4387e57f0 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000001
[373788.093401] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000=
00483084
[373788.107361] RDX: 00000000000002b3 RSI: 000000c42e27d800 RDI: 00000000=
0000014b
[373788.121337] RBP: 000000c4387e5840 R08: 0000000000000000 R09: 00000000=
00000000
[373788.135346] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000=
00000000
[373788.149304] R13: 00000000000000f2 R14: 0000000000000032 R15: 00000000=
00000002
[373788.163236] Code: c0 74 1a 48 8b 05 7f 44 ec 00 be fd 00 00 00 48 8b =
80 a0 00 00 00 e8 ae 1a 9b
00 5d c3 89 fe 48 c7 c7 b8 26 e5 81 e8 21 45 09 00 <0f> 0b 5d c3 66 2e 0f=
 1f 84 00 00 00 00 00 0f 1f
44 00 00 55 48
[373788.196867] ---[ end trace d3faf76bdc3ca406 ]---

------[ sar -f ./sa15 -s 20:16:00 -P 24 ]-----------
Linux 4.14.32-1.el7.x86_64 (foobar)        04/15/2018      _x86_64_      =
  (56 CPU)

08:16:00 PM     CPU     %user     %nice   %system   %iowait    %steal    =
 %idle
08:16:01 PM      24      0.00      0.00      0.00      0.00      0.00    =
100.00
08:16:02 PM      24      0.00      0.00      0.00      0.00      0.00    =
100.00
08:16:03 PM      24      0.99      0.00      0.00      0.00      0.00    =
 99.01
08:16:04 PM      24      0.00      0.00      0.00      0.00      0.00    =
100.00
08:16:05 PM      24      1.00      0.00      0.00      0.00      0.00    =
 99.00
08:16:06 PM      24      3.00      0.00      0.00      0.00      0.00    =
 97.00
08:16:07 PM      24      2.00      0.00      0.00      0.00      0.00    =
 98.00
08:16:08 PM      24      1.00      0.00      1.00      0.00      0.00    =
 98.00
08:16:09 PM      24      0.99      0.00      0.00      0.00      0.00    =
 99.01
08:16:10 PM      24      0.00      0.00      0.00      0.00      0.00    =
100.00
08:16:11 PM      24      1.00      0.00      0.00      0.00      0.00    =
 99.00
08:16:12 PM      24      0.00      0.00      0.00      0.00      0.00    =
100.00
08:16:13 PM      24      1.01      0.00      0.00      0.00      0.00    =
 98.99
08:16:14 PM      24      0.00      0.00      0.00      0.00      0.00    =
100.00
08:16:15 PM      24      0.00      0.00      0.00      0.00      0.00    =
100.00
08:16:16 PM      24      0.00      0.00      0.00      0.00      0.00    =
100.00
08:16:17 PM      24      0.00      0.00      0.00      0.00      0.00    =
100.00
08:16:18 PM      24      0.00      0.00      0.99      0.00      0.00    =
 99.01
08:16:19 PM      24      0.00      0.00      0.00      0.00      0.00    =
100.00
08:16:20 PM      24      0.00      0.00      0.00      0.00      0.00    =
100.00
08:16:21 PM      24      1.00      0.00      0.00      0.00      0.00    =
 99.00
08:16:22 PM      24      0.00      0.00      0.00      0.00      0.00    =
100.00
08:16:23 PM      24      1.00      0.00     17.00      0.00      0.00    =
 82.00
08:16:24 PM      24      0.00      0.00    100.00      0.00      0.00    =
  0.00
08:16:25 PM      24      0.00      0.00    100.00      0.00      0.00    =
  0.00
08:16:26 PM      24      0.00      0.00    100.00      0.00      0.00    =
  0.00
08:16:27 PM      24      0.00      0.00    100.00      0.00      0.00    =
  0.00
08:16:28 PM      24      0.00      0.00    100.00      0.00      0.00    =
  0.00
08:16:29 PM      24      0.00      0.00    100.00      0.00      0.00    =
  0.00
08:16:30 PM      24      0.00      0.00    100.00      0.00      0.00    =
  0.00
08:16:31 PM      24      0.00      0.00    100.00      0.00      0.00    =
  0.00
08:16:32 PM      24      0.00      0.00    100.00      0.00      0.00    =
  0.00
08:16:33 PM      24      0.00      0.00    100.00      0.00      0.00    =
  0.00
08:16:34 PM      24      0.00      0.00    100.00      0.00      0.00    =
  0.00
08:16:35 PM      24      0.00      0.00    100.00      0.00      0.00    =
  0.00
08:16:36 PM      24      0.00      0.00    100.00      0.00      0.00    =
  0.00
08:16:37 PM      24      0.00      0.00    100.00      0.00      0.00    =
  0.00
08:16:38 PM      24      0.00      0.00    100.00      0.00      0.00    =
  0.00
08:16:39 PM      24      0.00      0.00    100.00      0.00      0.00    =
  0.00
08:16:40 PM      24      0.00      0.00    100.00      0.00      0.00    =
  0.00
08:16:41 PM      24      0.00      0.00    100.00      0.00      0.00    =
  0.00
08:16:42 PM      24      0.00      0.00    100.00      0.00      0.00    =
  0.00
------[ sar -f ./sa15 -s 20:16:00 -P 24 ]-----------




The following panic is from a different server and we see the same sympto=
m, kernel panics
due to a soft lockup and CPU#21 has 100% utilization for system level. In=
 this panic we see
a timeout from the network driver for queuing packets, I believe this is =
the symptom and not
the cause, as a server with mellox driver had a similar soft lockup.



391838.033960] NETDEV WATCHDOG: eth0 (bnx2x): transmit queue 2 timed out
[391838.065545] ------------[ cut here ]------------
[391838.088431] WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:320 dev=
_watchdog+0x22b/0x230
[391838.128800] Modules linked in: binfmt_misc sctp_diag sctp dccp_diag d=
ccp tcp_diag udp_diag
inet_diag unix_diag cfg80211 rfkill 8021q garp mrp xfs loop vfat fat x86_=
pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_=
pclmul ghash_clmulni_intel
pcbc aesni_intel crypto_simd glue_helper cryptd intel_cstate iTCO_wdt iTC=
O_vendor_support
intel_rapl_perf sg hpilo hpwdt ipmi_si pcspkr lpc_ich ioatdma ipmi_devint=
f dca mfd_core i2c_i801
shpchp wmi ipmi_msghandler nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip=
_tables ext4 mbcache jbd2
i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops=
 ttm sd_mod bnx2x mdio drm
libcrc32c crc32c_intel hpsa ptp scsi_transport_sas pps_core dm_mirror dm_=
region_hash dm_log dm_mod dax
[391838.456941] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.32-1.el7.x=
86_64 #1
[391838.491589] Hardware name: HP ProLiant BL460c Gen9, BIOS I36 10/25/20=
17
[391838.524202] task: ffffffff82012480 task.stack: ffffffff82000000
[391838.553322] RIP: 0010:dev_watchdog+0x22b/0x230
[391838.575252] RSP: 0018:ffff88103fa03e60 EFLAGS: 00010246
[391838.601054] RAX: 0000000000000039 RBX: 0000000000000002 RCX: 00000000=
00000000
[391838.636022] RDX: 0000000000000000 RSI: ffff88103fa169d8 RDI: ffff8810=
3fa169d8
[391838.671651] RBP: ffff88103fa03e90 R08: 0000000000000000 R09: 00000000=
000004df
[391838.707021] R10: 0000000000000001 R11: 0000000000aaaaaa R12: ffff8810=
36674000
[391838.758515] R13: 000000000000005b R14: ffff88103667f100 R15: 00000000=
00000000
[391838.810815] FS:  0000000000000000(0000) GS:ffff88103fa00000(0000) knl=
GS:0000000000000000
[391838.867323] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[391838.912602] CR2: 00007f912eb7fff0 CR3: 000000000200a006 CR4: 00000000=
003606f0
[391838.964401] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
[391839.016170] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
[391839.067361] Call Trace:
[391839.096085]  <IRQ>
[391839.122674]  ? dev_deactivate_queue.constprop.30+0x60/0x60
[391839.166424]  call_timer_fn+0x37/0x140
[391839.201029]  run_timer_softirq+0x1eb/0x450
[391839.238196]  ? timerqueue_add+0x59/0x90
[391839.273260]  ? ktime_get+0x3e/0xa0
[391839.306253]  __do_softirq+0xd2/0x27c
[391839.340016]  irq_exit+0xd9/0xf0
[391839.371464]  smp_apic_timer_interrupt+0x75/0x140
[391839.410012]  apic_timer_interrupt+0x8e/0xa0
[391839.446764]  </IRQ>
[391839.472682] RIP: 0010:cpuidle_enter_state+0xdd/0x2b0
[391839.512914] RSP: 0018:ffffffff82003e00 EFLAGS: 00000246 ORIG_RAX: fff=
fffffffffff10
[391839.565090] RAX: ffff88103fa22ac0 RBX: ffffe8f000200000 RCX: 00000000=
0000001f
[391839.615998] RDX: 0000000000000000 RSI: fff936788221f82b RDI: 00000000=
00000000
[391839.666639] RBP: ffffffff82003e38 R08: 000000000000034d R09: 00000000=
ffffffff
[391839.717691] R10: 000000000000037a R11: 0000000000000008 R12: 00000000=
00000004
[391839.768401] R13: 0000000000000000 R14: ffffffff8216d980 R15: 0001645f=
e6c35649
[391839.819280]  cpuidle_enter+0x17/0x20
[391839.852911]  call_cpuidle+0x23/0x40
[391839.885828]  do_idle+0x172/0x1e0
[391839.916662]  cpu_startup_entry+0x73/0x80
[391839.950559]  rest_init+0xaa/0xb0
[391839.981142]  start_kernel+0x4b7/0x4d8
[391840.013407]  ? set_init_arg+0x5a/0x5a
[391840.045237]  x86_64_start_reservations+0x2a/0x2c
[391840.081722]  x86_64_start_kernel+0x72/0x75
[391840.114722]  secondary_startup_64+0xa5/0xb0
[391840.149320] Code: 60 04 00 00 eb 89 4c 89 e7 c6 05 77 bb b2 00 01 e8 =
6b 38 fd ff 89 d9 48 89 c2
4c 89 e6 48 c7 c7 98 6a ef 81 31 c0 e8 b8 52 a2 ff <0f> 0b eb b9 90 0f 1f=
 44 00 00 55 48 89 e5 41 57
49 89 d7 41 56
[391840.265586] ---[ end trace c661065d595325a9 ]---
[391842.302965] bnx2x: [bnx2x_clean_tx_queue:1205(eth0)]timeout waiting f=
or queue[2]:
txdata->tx_pkt_prod(11525) !=3D txdata->tx_pkt_cons(11500)
[391844.388943] bnx2x: [bnx2x_clean_tx_queue:1205(eth0)]timeout waiting f=
or queue[2]:
txdata->tx_pkt_prod(11525) !=3D txdata->tx_pkt_cons(11500)
[391850.094964] watchdog: BUG: soft lockup - CPU#21 stuck for 22s! [kube-=
apiserver:60495]
[391850.146079] Modules linked in: binfmt_misc sctp_diag sctp dccp_diag d=
ccp tcp_diag udp_diag
inet_diag unix_diag cfg80211 rfkill 8021q garp mrp xfs loop vfat fat x86_=
pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_=
pclmul ghash_clmulni_intel
pcbc aesni_intel crypto_simd glue_helper cryptd intel_cstate iTCO_wdt iTC=
O_vendor_support
intel_rapl_perf sg hpilo hpwdt ipmi_si pcspkr lpc_ich ioatdma ipmi_devint=
f dca mfd_core i2c_i801
shpchp wmi ipmi_msghandler nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip=
_tables ext4 mbcache jbd2
i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops=
 ttm sd_mod bnx2x mdio drm
libcrc32c crc32c_intel hpsa ptp scsi_transport_sas pps_core dm_mirror dm_=
region_hash dm_log dm_mod dax
[391850.573524] CPU: 21 PID: 60495 Comm: kube-apiserver Tainted: G       =
 W
4.14.32-1.el7.x86_64 #1
[391850.634311] Hardware name: HP ProLiant BL460c Gen9, BIOS I36 10/25/20=
17
[391850.682799] task: ffff881022172e80 task.stack: ffffc9000b874000
[391850.727891] RIP: 0010:fsnotify+0x218/0x510
[391850.763842] RSP: 0018:ffffc9000b877db8 EFLAGS: 00000246 ORIG_RAX: fff=
fffffffffff10
[391850.820076] RAX: ffff882001c77a98 RBX: ffff882001c77a70 RCX: 00000000=
00000002
[391850.873470] RDX: 0000000000028400 RSI: 0000000000000002 RDI: ffffffff=
8269a4e0
[391850.925414] RBP: ffffc9000b877e98 R08: 0000000000000000 R09: 00000000=
00000000
[391850.976777] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000=
00000000
[391851.028138] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
00000000
[391851.079135] FS:  000000c42be02090(0000) GS:ffff88103fd40000(0000) knl=
GS:0000000000000000
[391851.135142] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[391851.180107] CR2: 00007f5c3c0690c0 CR3: 0000000fc47c4004 CR4: 00000000=
003606e0
[391851.231704] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
[391851.283258] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
[391851.335898] Call Trace:
[391851.367161]  vfs_write+0x151/0x1b0
[391851.401673]  ? syscall_trace_enter+0x1cd/0x2b0
[391851.440900]  SyS_write+0x55/0xc0
[391851.474214]  do_syscall_64+0x79/0x1b0
[391851.510034]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[391851.551320] RIP: 0033:0x483084
[391851.583001] RSP: 002b:000000c43197d7f0 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000001
[391851.636289] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000=
00483084
[391851.688719] RDX: 00000000000002a9 RSI: 000000c424283c00 RDI: 00000000=
00000040
[391851.740825] RBP: 000000c43197d840 R08: 0000000000000000 R09: 00000000=
00000000
[391851.792257] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000=
00000000
[391851.843292] R13: 00000000000000f2 R14: 0000000000000032 R15: 00000000=
00000002
[391851.896703] Code: 0f 85 08 02 00 00 48 85 db 41 0f 94 c4 4d 85 ed 0f =
94 c1 84 c9 0f 85 ef 02 00
00 8b 4d 90 85 c9 74 26 48 85 db 74 0d f6 43 44 01 <75> 07 c7 43 40 00 00=
 00 00 4d 85 ed 74 0f 41 f6
45 44 01 75 08
[391852.022198] Kernel panic - not syncing: softlockup: hung tasks
[391852.068204] CPU: 21 PID: 60495 Comm: kube-apiserver Tainted: G       =
 W    L
4.14.32-1.el7.x86_64 #1
[391852.130544] Hardware name: HP ProLiant BL460c Gen9, BIOS I36 10/25/20=
17
[391852.180598] Call Trace:
[391852.210411]  <IRQ>
[391852.237477]  dump_stack+0x63/0x88
[391852.270360]  panic+0xe8/0x258
[391852.301307]  watchdog_timer_fn+0x21a/0x230
[391852.337395]  ? watchdog+0x30/0x30
[391852.368943]  __hrtimer_run_queues+0xe7/0x230
[391852.405003]  hrtimer_interrupt+0xa8/0x1a0
[391852.439190]  smp_apic_timer_interrupt+0x6b/0x140
[391852.476151]  apic_timer_interrupt+0x8e/0xa0
[391852.511089]  </IRQ>
[391852.535014] RIP: 0010:fsnotify+0x218/0x510
[391852.568048] RSP: 0018:ffffc9000b877db8 EFLAGS: 00000246 ORIG_RAX: fff=
fffffffffff10
[391852.617533] RAX: ffff882001c77a98 RBX: ffff882001c77a70 RCX: 00000000=
00000002
[391852.664520] RDX: 0000000000028400 RSI: 0000000000000002 RDI: ffffffff=
8269a4e0
[391852.711835] RBP: ffffc9000b877e98 R08: 0000000000000000 R09: 00000000=
00000000
[391852.758813] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000=
00000000
[391852.805527] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
00000000
[391852.851877]  ? fsnotify+0x4bb/0x510
[391852.880665]  vfs_write+0x151/0x1b0
[391852.909135]  ? syscall_trace_enter+0x1cd/0x2b0
[391852.942798]  SyS_write+0x55/0xc0
[391852.969978]  do_syscall_64+0x79/0x1b0
[391852.999194]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[391853.035095] RIP: 0033:0x483084
[391853.061289] RSP: 002b:000000c43197d7f0 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000001
[391853.109641] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000=
00483084
[391853.155956] RDX: 00000000000002a9 RSI: 000000c424283c00 RDI: 00000000=
00000040
[391853.202552] RBP: 000000c43197d840 R08: 0000000000000000 R09: 00000000=
00000000
[391853.248842] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000=
00000000
[391853.295051] R13: 00000000000000f2 R14: 0000000000000032 R15: 00000000=
00000002
[391853.341016] Kernel Offset: disabled
[391853.375061] ---[ end Kernel panic - not syncing: softlockup: hung tas=
ks
[391853.419102] sched: Unexpected reschedule of offline CPU#0!
[391853.457084] ------------[ cut here ]------------
[391853.491472] WARNING: CPU: 21 PID: 60495 at arch/x86/kernel/smp.c:128
native_smp_send_reschedule+0x42/0x50
[391853.549474] Modules linked in: binfmt_misc sctp_diag sctp dccp_diag d=
ccp tcp_diag udp_diag
inet_diag unix_diag cfg80211 rfkill 8021q garp mrp xfs loop vfat fat x86_=
pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_=
pclmul ghash_clmulni_intel
pcbc aesni_intel crypto_simd glue_helper cryptd intel_cstate iTCO_wdt iTC=
O_vendor_support
intel_rapl_perf sg hpilo hpwdt ipmi_si pcspkr lpc_ich ioatdma ipmi_devint=
f dca mfd_core i2c_i801
shpchp wmi ipmi_msghandler nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip=
_tables ext4 mbcache jbd2
i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops=
 ttm sd_mod bnx2x mdio drm
libcrc32c crc32c_intel hpsa ptp scsi_transport_sas pps_core dm_mirror dm_=
region_hash dm_log dm_mod dax
[391853.967080] CPU: 21 PID: 60495 Comm: kube-apiserver Tainted: G       =
 W    L
4.14.32-1.el7.x86_64 #1
[391854.026457] Hardware name: HP ProLiant BL460c Gen9, BIOS I36 10/25/20=
17
[391854.073417] task: ffff881022172e80 task.stack: ffffc9000b874000
[391854.116927] RIP: 0010:native_smp_send_reschedule+0x42/0x50
[391854.158063] RSP: 0018:ffff88103fd43b10 EFLAGS: 00010046
[391854.197408] RAX: 000000000000002e RBX: 0000000000000000 RCX: 00000000=
00000000
[391854.246409] RDX: 0000000000000000 RSI: ffff88103fd569d8 RDI: ffff8810=
3fd569d8
[391854.295777] RBP: ffff88103fd43b10 R08: 0000000000000000 R09: 00000000=
00000556
[391854.345373] R10: 0000000000000001 R11: 0000000000aaaaaa R12: ffff8810=
3fa22ac0
[391854.395334] R13: ffff880f8be48000 R14: ffff88103fd43bc8 R15: ffff8810=
3fa22ac0
[391854.444983] FS:  000000c42be02090(0000) GS:ffff88103fd40000(0000) knl=
GS:0000000000000000
[391854.498575] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[391854.541675] CR2: 00007f5c3c0690c0 CR3: 0000000fc47c4004 CR4: 00000000=
003606e0
[391854.591999] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
[391854.642263] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
[391854.692678] Call Trace:
[391854.719793]  <IRQ>
[391854.744771]  resched_curr+0xae/0xd0
[391854.776585]  check_preempt_curr+0x79/0xa0
[391854.811170]  ttwu_do_wakeup+0x1e/0x160
[391854.844514]  ttwu_do_activate+0x7a/0x90
[391854.877774]  try_to_wake_up+0x1e7/0x480
[391854.910892]  default_wake_function+0x12/0x20
[391854.946665]  autoremove_wake_function+0x16/0x60
[391854.984069]  __wake_up_common+0x8f/0x160
[391855.018321]  __wake_up_common_lock+0x7e/0xc0
[391855.053398]  __wake_up+0x13/0x20
[391855.083708]  wake_up_klogd_work_func+0x40/0x60
[391855.119905]  irq_work_run_list+0x53/0x80
[391855.153377]  irq_work_run+0x2c/0x30
[391855.184508]  flush_smp_call_function_queue+0x88/0x110
[391855.223509]  generic_smp_call_function_single_interrupt+0x13/0x30
[391855.267592]  smp_call_function_single_interrupt+0x3a/0xe0
[391855.308323]  call_function_single_interrupt+0x8e/0xa0
[391855.347202] RIP: 0010:panic+0x206/0x258
[391855.380345] RSP: 0018:ffff88103fd43e80 EFLAGS: 00000246 ORIG_RAX: fff=
fffffffffff04
[391855.431894] RAX: 000000000000003b RBX: 0000000000000000 RCX: 00000000=
00000006
[391855.481301] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffff8810=
3fd569d0
[391855.530810] RBP: ffff88103fd43ef0 R08: 0000000000000000 R09: 00000000=
00000555
[391855.579985] R10: 0000000000000001 R11: 0000000000aaaaaa R12: ffffffff=
81e6be9f
[391855.629525] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
ee6b2800
[391855.677925]  watchdog_timer_fn+0x21a/0x230
[391855.711211]  ? watchdog+0x30/0x30
[391855.740236]  __hrtimer_run_queues+0xe7/0x230
[391855.773231]  hrtimer_interrupt+0xa8/0x1a0
[391855.804713]  smp_apic_timer_interrupt+0x6b/0x140
[391855.838740]  apic_timer_interrupt+0x8e/0xa0
[391855.870671]  </IRQ>
[391855.892208] RIP: 0010:fsnotify+0x218/0x510
[391855.922974] RSP: 0018:ffffc9000b877db8 EFLAGS: 00000246 ORIG_RAX: fff=
fffffffffff10
[391855.970885] RAX: ffff882001c77a98 RBX: ffff882001c77a70 RCX: 00000000=
00000002
[391856.016803] RDX: 0000000000028400 RSI: 0000000000000002 RDI: ffffffff=
8269a4e0
[391856.062423] RBP: ffffc9000b877e98 R08: 0000000000000000 R09: 00000000=
00000000
[391856.108153] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000=
00000000
[391856.153683] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
00000000
[391856.200197]  ? fsnotify+0x4bb/0x510
[391856.228102]  vfs_write+0x151/0x1b0
[391856.256421]  ? syscall_trace_enter+0x1cd/0x2b0
[391856.288496]  SyS_write+0x55/0xc0
[391856.314643]  do_syscall_64+0x79/0x1b0
[391856.342704]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[391856.377545] RIP: 0033:0x483084
[391856.402822] RSP: 002b:000000c43197d7f0 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000001
[391856.449735] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000=
00483084
[391856.494804] RDX: 00000000000002a9 RSI: 000000c424283c00 RDI: 00000000=
00000040
[391856.540308] RBP: 000000c43197d840 R08: 0000000000000000 R09: 00000000=
00000000
[391856.585743] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000=
00000000
[391856.630940] R13: 00000000000000f2 R14: 0000000000000032 R15: 00000000=
00000002
[391856.676366] Code: c0 74 1a 48 8b 05 7f 44 ec 00 be fd 00 00 00 48 8b =
80 a0 00 00 00 e8 ae 1a 9b
00 5d c3 89 fe 48 c7 c7 b8 26 e5 81 e8 21 45 09 00 <0f> 0b 5d c3 66 2e 0f=
 1f 84 00 00 00 00 00 0f 1f
44 00 00 55 48
[391856.792915] ---[ end trace c661065d595325aa ]---
[391856.826793] ------------[ cut here ]------------
[391856.860523] WARNING: CPU: 21 PID: 60495 at kernel/sched/core.c:1179 s=
et_task_cpu+0x197/0x1a0
[391856.913620] Modules linked in: binfmt_misc sctp_diag sctp dccp_diag d=
ccp tcp_diag udp_diag
inet_diag unix_diag cfg80211 rfkill 8021q garp mrp xfs loop vfat fat x86_=
pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_=
pclmul ghash_clmulni_intel
pcbc aesni_intel crypto_simd glue_helper cryptd intel_cstate iTCO_wdt iTC=
O_vendor_support
intel_rapl_perf sg hpilo hpwdt ipmi_si pcspkr lpc_ich ioatdma ipmi_devint=
f dca mfd_core i2c_i801
shpchp wmi ipmi_msghandler nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip=
_tables ext4 mbcache jbd2
i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops=
 ttm sd_mod bnx2x mdio drm
libcrc32c crc32c_intel hpsa ptp scsi_transport_sas pps_core dm_mirror dm_=
region_hash dm_log dm_mod dax
[391857.333766] CPU: 21 PID: 60495 Comm: kube-apiserver Tainted: G       =
 W    L
4.14.32-1.el7.x86_64 #1
[391857.393681] Hardware name: HP ProLiant BL460c Gen9, BIOS I36 10/25/20=
17
[391857.440546] task: ffff881022172e80 task.stack: ffffc9000b874000
[391857.484076] RIP: 0010:set_task_cpu+0x197/0x1a0
[391857.520542] RSP: 0018:ffff88103fd43ae8 EFLAGS: 00010046
[391857.560948] RAX: 0000000000000200 RBX: ffff881038cb45c0 RCX: 00000000=
00000001
[391857.610782] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff8810=
38cb45c0
[391857.660456] RBP: ffff88103fd43b08 R08: 0000000000000008 R09: 00000000=
00000000
[391857.710401] R10: 0000000000000001 R11: 0000000000aaaaaa R12: ffff8810=
38cb516c
[391857.760003] R13: 0000000000000008 R14: 0000000000000008 R15: 00000000=
00022ac0
[391857.809282] FS:  000000c42be02090(0000) GS:ffff88103fd40000(0000) knl=
GS:0000000000000000
[391857.863581] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[391857.906806] CR2: 00007f5c3c0690c0 CR3: 0000000fc47c4004 CR4: 00000000=
003606e0
[391857.956620] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
[391858.007011] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
[391858.057596] Call Trace:
[391858.085525]  <IRQ>
[391858.110876]  try_to_wake_up+0x16c/0x480
[391858.145085]  ? resched_curr+0xae/0xd0
[391858.178173]  default_wake_function+0x12/0x20
[391858.214468]  __wake_up_common+0x8f/0x160
[391858.248941]  __wake_up_locked+0x16/0x20
[391858.283175]  ep_poll_callback+0xd0/0x300
[391858.316965]  __wake_up_common+0x8f/0x160
[391858.351271]  __wake_up_common_lock+0x7e/0xc0
[391858.387289]  __wake_up+0x13/0x20
[391858.417695]  wake_up_klogd_work_func+0x40/0x60
[391858.454575]  irq_work_run_list+0x53/0x80
[391858.488737]  irq_work_run+0x2c/0x30
[391858.520329]  flush_smp_call_function_queue+0x88/0x110
[391858.559946]  generic_smp_call_function_single_interrupt+0x13/0x30
[391858.603988]  smp_call_function_single_interrupt+0x3a/0xe0
[391858.645713]  call_function_single_interrupt+0x8e/0xa0
[391858.685706] RIP: 0010:panic+0x206/0x258
[391858.720431] RSP: 0018:ffff88103fd43e80 EFLAGS: 00000246 ORIG_RAX: fff=
fffffffffff04
[391858.772695] RAX: 000000000000003b RBX: 0000000000000000 RCX: 00000000=
00000006
[391858.822759] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffff8810=
3fd569d0
[391858.872167] RBP: ffff88103fd43ef0 R08: 0000000000000000 R09: 00000000=
00000555
[391858.921420] R10: 0000000000000001 R11: 0000000000aaaaaa R12: ffffffff=
81e6be9f
[391858.971071] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
ee6b2800
[391859.020677]  watchdog_timer_fn+0x21a/0x230
[391859.054291]  ? watchdog+0x30/0x30
[391859.083991]  __hrtimer_run_queues+0xe7/0x230
[391859.118087]  hrtimer_interrupt+0xa8/0x1a0
[391859.150361]  smp_apic_timer_interrupt+0x6b/0x140
[391859.185167]  apic_timer_interrupt+0x8e/0xa0
[391859.217429]  </IRQ>
[391859.239165] RIP: 0010:fsnotify+0x218/0x510
[391859.269961] RSP: 0018:ffffc9000b877db8 EFLAGS: 00000246 ORIG_RAX: fff=
fffffffffff10
[391859.317370] RAX: ffff882001c77a98 RBX: ffff882001c77a70 RCX: 00000000=
00000002
[391859.363263] RDX: 0000000000028400 RSI: 0000000000000002 RDI: ffffffff=
8269a4e0
[391859.409279] RBP: ffffc9000b877e98 R08: 0000000000000000 R09: 00000000=
00000000
[391859.455080] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000=
00000000
[391859.500518] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
00000000
[391859.546063]  ? fsnotify+0x4bb/0x510
[391859.574081]  vfs_write+0x151/0x1b0
[391859.601468]  ? syscall_trace_enter+0x1cd/0x2b0
[391859.634055]  SyS_write+0x55/0xc0
[391859.660517]  do_syscall_64+0x79/0x1b0
[391859.688919]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[391859.723536] RIP: 0033:0x483084
[391859.748891] RSP: 002b:000000c43197d7f0 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000001
[391859.796455] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000=
00483084
[391859.841781] RDX: 00000000000002a9 RSI: 000000c424283c00 RDI: 00000000=
00000040
[391859.887303] RBP: 000000c43197d840 R08: 0000000000000000 R09: 00000000=
00000000
[391859.932494] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000=
00000000
[391859.977838] R13: 00000000000000f2 R14: 0000000000000032 R15: 00000000=
00000002
[391860.023361] Code: ff 80 8b ac 08 00 00 04 e9 20 ff ff ff 0f 0b e9 b9 =
fe ff ff f7 83 84 00 00 00
fd ff ff ff 0f 84 c3 fe ff ff 0f 0b e9 bc fe ff ff <0f> 0b e9 cb fe ff ff=
 66 90 0f 1f 44 00 00 55 48
89 e5 41 56 49
[391860.138078] ---[ end trace c661065d595325ab ]---
[391860.172166] sched: Unexpected reschedule of offline CPU#8!
[391860.210690] ------------[ cut here ]------------
[391860.244671] WARNING: CPU: 21 PID: 60495 at arch/x86/kernel/smp.c:128
native_smp_send_reschedule+0x42/0x50
[391860.303820] Modules linked in: binfmt_misc sctp_diag sctp dccp_diag d=
ccp tcp_diag udp_diag
inet_diag unix_diag cfg80211 rfkill 8021q garp mrp xfs loop vfat fat x86_=
pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_=
pclmul ghash_clmulni_intel
pcbc aesni_intel crypto_simd glue_helper cryptd intel_cstate iTCO_wdt iTC=
O_vendor_support
intel_rapl_perf sg hpilo hpwdt ipmi_si pcspkr lpc_ich ioatdma ipmi_devint=
f dca mfd_core i2c_i801
shpchp wmi ipmi_msghandler nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip=
_tables ext4 mbcache jbd2
i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops=
 ttm sd_mod bnx2x mdio drm
libcrc32c crc32c_intel hpsa ptp scsi_transport_sas pps_core dm_mirror dm_=
region_hash dm_log dm_mod dax
[391860.726277] CPU: 21 PID: 60495 Comm: kube-apiserver Tainted: G       =
 W    L
4.14.32-1.el7.x86_64 #1
[391860.786402] Hardware name: HP ProLiant BL460c Gen9, BIOS I36 10/25/20=
17
[391860.834206] task: ffff881022172e80 task.stack: ffffc9000b874000
[391860.878669] RIP: 0010:native_smp_send_reschedule+0x42/0x50
[391860.920832] RSP: 0018:ffff88103fd43b08 EFLAGS: 00010046
[391860.961851] RAX: 000000000000002e RBX: ffff881038cb45c0 RCX: 00000000=
00000006
[391861.012094] RDX: 0000000000000000 RSI: 0000000000000086 RDI: ffff8810=
3fd569d0
[391861.062447] RBP: ffff88103fd43b08 R08: 0000000000000000 R09: 00000000=
000005e8
[391861.112691] R10: 0000000000000001 R11: 0000000000aaaaaa R12: ffff8810=
38cb516c
[391861.163322] R13: 0000000000000004 R14: 0000000000000046 R15: 00000000=
00022ac0
[391861.213440] FS:  000000c42be02090(0000) GS:ffff88103fd40000(0000) knl=
GS:0000000000000000
[391861.268665] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[391861.311928] CR2: 00007f5c3c0690c0 CR3: 0000000fc47c4004 CR4: 00000000=
003606e0
[391861.362717] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
[391861.414065] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
[391861.464505] Call Trace:
[391861.492319]  <IRQ>
[391861.517992]  try_to_wake_up+0x405/0x480
[391861.551956]  default_wake_function+0x12/0x20
[391861.588252]  __wake_up_common+0x8f/0x160
[391861.622982]  __wake_up_locked+0x16/0x20
[391861.657272]  ep_poll_callback+0xd0/0x300
[391861.691535]  __wake_up_common+0x8f/0x160
[391861.726097]  __wake_up_common_lock+0x7e/0xc0
[391861.762240]  __wake_up+0x13/0x20
[391861.793096]  wake_up_klogd_work_func+0x40/0x60
[391861.830133]  irq_work_run_list+0x53/0x80
[391861.864538]  irq_work_run+0x2c/0x30
[391861.896744]  flush_smp_call_function_queue+0x88/0x110
[391861.936872]  generic_smp_call_function_single_interrupt+0x13/0x30
[391861.981074]  smp_call_function_single_interrupt+0x3a/0xe0
[391862.022733]  call_function_single_interrupt+0x8e/0xa0
[391862.062300] RIP: 0010:panic+0x206/0x258
[391862.096123] RSP: 0018:ffff88103fd43e80 EFLAGS: 00000246 ORIG_RAX: fff=
fffffffffff04
[391862.148335] RAX: 000000000000003b RBX: 0000000000000000 RCX: 00000000=
00000006
[391862.197879] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffff8810=
3fd569d0
[391862.247474] RBP: ffff88103fd43ef0 R08: 0000000000000000 R09: 00000000=
00000555
[391862.296985] R10: 0000000000000001 R11: 0000000000aaaaaa R12: ffffffff=
81e6be9f
[391862.346312] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
ee6b2800
[391862.395985]  watchdog_timer_fn+0x21a/0x230
[391862.430116]  ? watchdog+0x30/0x30
[391862.460248]  __hrtimer_run_queues+0xe7/0x230
[391862.494845]  hrtimer_interrupt+0xa8/0x1a0
[391862.527650]  smp_apic_timer_interrupt+0x6b/0x140
[391862.563130]  apic_timer_interrupt+0x8e/0xa0
[391862.596032]  </IRQ>
[391862.618884] RIP: 0010:fsnotify+0x218/0x510
[391862.650285] RSP: 0018:ffffc9000b877db8 EFLAGS: 00000246 ORIG_RAX: fff=
fffffffffff10
[391862.698849] RAX: ffff882001c77a98 RBX: ffff882001c77a70 RCX: 00000000=
00000002
[391862.744636] RDX: 0000000000028400 RSI: 0000000000000002 RDI: ffffffff=
8269a4e0
[391862.791246] RBP: ffffc9000b877e98 R08: 0000000000000000 R09: 00000000=
00000000
[391862.837248] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000=
00000000
[391862.883324] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
00000000
[391862.928937]  ? fsnotify+0x4bb/0x510
[391862.957183]  vfs_write+0x151/0x1b0
[391862.984840]  ? syscall_trace_enter+0x1cd/0x2b0
[391863.017128]  SyS_write+0x55/0xc0
[391863.043812]  do_syscall_64+0x79/0x1b0
[391863.072403]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[391863.107687] RIP: 0033:0x483084
[391863.133412] RSP: 002b:000000c43197d7f0 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000001
[391863.180683] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000=
00483084
[391863.226639] RDX: 00000000000002a9 RSI: 000000c424283c00 RDI: 00000000=
00000040
[391863.272308] RBP: 000000c43197d840 R08: 0000000000000000 R09: 00000000=
00000000
[391863.317590] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000=
00000000
[391863.363056] R13: 00000000000000f2 R14: 0000000000000032 R15: 00000000=
00000002
[391863.409871] Code: c0 74 1a 48 8b 05 7f 44 ec 00 be fd 00 00 00 48 8b =
80 a0 00 00 00 e8 ae 1a 9b
00 5d c3 89 fe 48 c7 c7 b8 26 e5 81 e8 21 45 09 00 <0f> 0b 5d c3 66 2e 0f=
 1f 84 00 00 00 00 00 0f 1f
44 00 00 55 48
[391863.522945] ---[ end trace c661065d595325ac ]---


----[ sar -f ./sa16 -s 04:25:50 -e 05:00:00 -P 21 ]----
Linux 4.14.32-1.el7.x86_64 (foobar)        04/16/2018      _x86_64_      =
  (32 CPU)

04:25:50 AM     CPU     %user     %nice   %system   %iowait    %steal    =
 %idle
04:25:51 AM      21      0.00      0.00      0.00      0.00      0.00    =
100.00
04:25:52 AM      21      1.00      0.00      1.00      0.00      0.00    =
 98.00
04:25:53 AM      21      0.00      0.00      0.00      0.00      0.00    =
100.00
04:25:54 AM      21      1.00      0.00      0.00      0.00      0.00    =
 99.00
04:25:55 AM      21      0.00      0.00     70.71      0.00      0.00    =
 29.29
04:25:56 AM      21      0.00      0.00    100.00      0.00      0.00    =
  0.00
04:25:57 AM      21      0.00      0.00    100.00      0.00      0.00    =
  0.00
04:25:58 AM      21      0.00      0.00    100.00      0.00      0.00    =
  0.00
04:25:59 AM      21      0.00      0.00    100.00      0.00      0.00    =
  0.00
04:26:00 AM      21      0.00      0.00    100.00      0.00      0.00    =
  0.00
04:26:01 AM      21      0.00      0.00    100.00      0.00      0.00    =
  0.00
04:26:02 AM      21      0.00      0.00    100.00      0.00      0.00    =
  0.00
04:26:03 AM      21      0.00      0.00    100.00      0.00      0.00    =
  0.00
----[ sar -f ./sa16 -s 04:25:50 -e 05:00:00 -P 21 ]----


The fact we see one CPU spinning at 100% utilization in all above crashes=
 is a good thing,
as we can use it as a start point for our investigation. We just need to =
find out which
(kernel/hardware/network driver/userland application) process makes a sin=
gle CPU to be stuck.
Thus, we disabled the trigger to panic the kernel when a soft lockup occu=
rs, and we hope
can find out the process.

The following panic is from the second type of panics I mentioned, where =
we don't
observe soft lockups and CPU utilization is close to zero before the cras=
h.

[123379.816452] perf: interrupt took too long (6243 > 6231), lowering
kernel.perf_event_max_sample_rate to 32000
[295349.255065] general protection fault: 0000 [#1] SMP PTI
[295349.281440] Modules linked in: binfmt_misc sctp_diag sctp dccp_diag d=
ccp tcp_diag udp_diag
inet_diag unix_diag cfg80211 rfkill 8021q garp mrp xfs x86_pkg_temp_therm=
al intel_powerclamp loop
coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmu=
lni_intel pcbc aesni_intel
crypto_simd glue_helper cryptd iTCO_wdt ipmi_si iTCO_vendor_support intel=
_cstate intel_rapl_perf
lpc_ich sg hpilo hpwdt ioatdma pcspkr ipmi_devintf i2c_i801 dca shpchp mf=
d_core wmi ipmi_msghandler
nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables ext4 mbcache jbd2 i=
2c_algo_bit drm_kms_helper
syscopyarea sysfillrect sysimgblt sd_mod fb_sys_fops ttm bnx2x mdio libcr=
c32c crc32c_intel serio_raw
hpsa ptp drm scsi_transport_sas pps_core dm_mirror dm_region_hash dm_log =
dm_mod dax
[295349.615070] CPU: 26 PID: 1384 Comm: thread.rb:70 Not tainted 4.14.32-=
1.el7.x86_64 #1
[295349.654011] Hardware name: HP ProLiant BL460c Gen9, BIOS I36 10/25/20=
17
[295349.686931] task: ffff882035430000 task.stack: ffffc90007bb4000
[295349.716421] RIP: 0010:prefetch_freepointer.isra.63+0x11/0x20
[295349.744812] RSP: 0018:ffffc90007bb7e08 EFLAGS: 00010202
[295349.771654] RAX: 0000000000000000 RBX: 6236612d38373234 RCX: 00000000=
000199bb
[295349.807690] RDX: 00000000000199ba RSI: 6236612d38373234 RDI: ffff8820=
3ec259a0
[295349.843664] RBP: ffffc90007bb7e08 R08: 0000000000028060 R09: ffffffff=
82051cc0
[295349.879868] R10: 0000000000002000 R11: 0000000000000040 R12: 00000000=
014000c0
[295349.916097] R13: ffff88203ec25980 R14: ffff88203ec25980 R15: ffff8820=
00000000
[295349.951868] FS:  00007f3f439f9700(0000) GS:ffff88203f480000(0000) knl=
GS:0000000000000000
[295349.993039] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[295350.021664] CR2: 000000c43069c000 CR3: 000000203943e001 CR4: 00000000=
003606e0
[295350.057534] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
[295350.093663] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
[295350.129254] Call Trace:
[295350.141644]  kmem_cache_alloc+0x9c/0x1b0
[295350.161581]  ? fsnotify_add_mark_locked+0x153/0x320
[295350.186330]  fsnotify_add_mark_locked+0x153/0x320
[295350.210023]  SyS_inotify_add_watch+0x2d5/0x350
[295350.232414]  do_syscall_64+0x79/0x1b0
[295350.250528]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[295350.275482] RIP: 0033:0x7f3f53f409b7
[295350.293330] RSP: 002b:00007f3f439f70c8 EFLAGS: 00000202 ORIG_RAX: 000=
00000000000fe
[295350.330889] RAX: ffffffffffffffda RBX: 00007f3f2c232fc0 RCX: 00007f3f=
53f409b7
[295350.365971] RDX: 0000000022000fc6 RSI: 0000000002eaba50 RDI: 00000000=
00000018
[295350.400949] RBP: 0000000002677d20 R08: 000000005ad2a563 R09: 00000000=
09caa9a8
[295350.436090] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000=
02677d20
[295350.471552] R13: 000000000000fd02 R14: 000000000005dc08 R15: 00000000=
000081a4
[295350.507348] Code: 31 d2 e8 b3 ea ff ff 5b 41 5c 5d c3 0f 1f 40 00 66 =
2e 0f 1f 84 00 00 00 00 00
0f 1f 44 00 00 55 48 85 f6 48 89 e5 74 0a 48 63 07 <48> 8b 04 06 0f 18 08=
 5d c3 66 0f 1f 44 00 00 0f
1f 44 00 00 48
[295350.601490] RIP: prefetch_freepointer.isra.63+0x11/0x20 RSP: ffffc900=
07bb7e08
[295350.637891] ---[ end trace 97f09d2dbcdbfe07 ]---
[295350.666426] Kernel panic - not syncing: Fatal exception
[295350.692470] Kernel Offset: disabled
[295350.715267] ---[ end Kernel panic - not syncing: Fatal exception
[295350.745027] ------------[ cut here ]------------
[295350.767882] WARNING: CPU: 26 PID: 1384 at kernel/sched/core.c:1179 se=
t_task_cpu+0x197/0x1a0
[295350.809229] Modules linked in: binfmt_misc sctp_diag sctp dccp_diag d=
ccp tcp_diag udp_diag
inet_diag unix_diag cfg80211 rfkill 8021q garp mrp xfs x86_pkg_temp_therm=
al intel_powerclamp loop
coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmu=
lni_intel pcbc aesni_intel
crypto_simd glue_helper cryptd iTCO_wdt ipmi_si iTCO_vendor_support intel=
_cstate intel_rapl_perf
lpc_ich sg hpilo hpwdt ioatdma pcspkr ipmi_devintf i2c_i801 dca shpchp mf=
d_core wmi ipmi_msghandler
nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables ext4 mbcache jbd2 i=
2c_algo_bit drm_kms_helper
syscopyarea sysfillrect sysimgblt sd_mod fb_sys_fops ttm bnx2x mdio libcr=
c32c crc32c_intel serio_raw
hpsa ptp drm scsi_transport_sas pps_core dm_mirror dm_region_hash dm_log =
dm_mod dax
[295351.141701] CPU: 26 PID: 1384 Comm: thread.rb:70 Tainted: G      D   =
      4.14.32-1.el7.x86_64 #1
[295351.186528] Hardware name: HP ProLiant BL460c Gen9, BIOS I36 10/25/20=
17
[295351.219763] task: ffff882035430000 task.stack: ffffc90007bb4000
[295351.249425] RIP: 0010:set_task_cpu+0x197/0x1a0
[295351.272046] RSP: 0018:ffff88203f483cd8 EFLAGS: 00010046
[295351.298021] RAX: 0000000000000200 RBX: ffff880fc6730000 RCX: 00000000=
00000001
[295351.333003] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff880f=
c6730000
[295351.368440] RBP: ffff88203f483cf8 R08: 0000000000000008 R09: 00000000=
00000000
[295351.404295] R10: 0000000000000000 R11: 0000000000000000 R12: ffff880f=
c6730bac
[295351.440065] R13: 0000000000000008 R14: 0000000000000008 R15: 00000000=
00022ac0
[295351.475936] FS:  00007f3f439f9700(0000) GS:ffff88203f480000(0000) knl=
GS:0000000000000000
[295351.516850] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[295351.545941] CR2: 000000c43069c000 CR3: 000000203943e001 CR4: 00000000=
003606e0
[295351.581551] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
[295351.616790] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
[295351.652332] Call Trace:
[295351.664980]  <IRQ>
[295351.675389]  try_to_wake_up+0x16c/0x480
[295351.694771]  default_wake_function+0x12/0x20
[295351.716287]  autoremove_wake_function+0x16/0x60
[295351.738731]  __wake_up_common+0x8f/0x160
[295351.758434]  __wake_up_common_lock+0x7e/0xc0
[295351.780379]  __wake_up+0x13/0x20
[295351.796700]  wake_up_klogd_work_func+0x40/0x60
[295351.818797]  irq_work_run_list+0x53/0x80
[295351.838265]  ? tick_sched_do_timer+0x70/0x70
[295351.859777]  irq_work_tick+0x40/0x50
[295351.877976]  update_process_times+0x42/0x60
[295351.899104]  tick_sched_handle+0x2d/0x60
[295351.919406]  tick_sched_timer+0x39/0x70
[295351.938722]  __hrtimer_run_queues+0xe7/0x230
[295351.960148]  hrtimer_interrupt+0xa8/0x1a0
[295351.979989]  smp_apic_timer_interrupt+0x6b/0x140
[295352.003308]  apic_timer_interrupt+0x8e/0xa0
[295352.024371]  </IRQ>
[295352.035497] RIP: 0010:panic+0x206/0x258
[295352.055056] RSP: 0018:ffffc90007bb7c58 EFLAGS: 00000246 ORIG_RAX: fff=
fffffffffff10
[295352.092974] RAX: 0000000000000034 RBX: 0000000000000200 RCX: 00000000=
00000006
[295352.129345] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff8820=
3f4969d0
[295352.164888] RBP: ffffc90007bb7cc8 R08: 0000000000000000 R09: 00000000=
000004bf
[295352.200268] R10: ffffffff8140e7c0 R11: 00000000000004be R12: ffffffff=
81e4b096
[295352.236368] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
00000000
[295352.272653]  ? vgacon_invert_region+0x80/0x80
[295352.294690]  ? panic+0x1ff/0x258
[295352.311125]  oops_end+0xba/0xd0
[295352.327275]  die+0x42/0x50
[295352.341034]  do_general_protection+0xd2/0x160
[295352.362771]  general_protection+0x25/0x50
[295352.382624] RIP: 0010:prefetch_freepointer.isra.63+0x11/0x20
[295352.410365] RSP: 0018:ffffc90007bb7e08 EFLAGS: 00010202
[295352.435958] RAX: 0000000000000000 RBX: 6236612d38373234 RCX: 00000000=
000199bb
[295352.471228] RDX: 00000000000199ba RSI: 6236612d38373234 RDI: ffff8820=
3ec259a0
[295352.506333] RBP: ffffc90007bb7e08 R08: 0000000000028060 R09: ffffffff=
82051cc0
[295352.541869] R10: 0000000000002000 R11: 0000000000000040 R12: 00000000=
014000c0
[295352.577452] R13: ffff88203ec25980 R14: ffff88203ec25980 R15: ffff8820=
00000000
[295352.613390]  ? idr_alloc_cmn+0x98/0xe0
[295352.633360]  kmem_cache_alloc+0x9c/0x1b0
[295352.653132]  ? fsnotify_add_mark_locked+0x153/0x320
[295352.677495]  fsnotify_add_mark_locked+0x153/0x320
[295352.700960]  SyS_inotify_add_watch+0x2d5/0x350
[295352.723337]  do_syscall_64+0x79/0x1b0
[295352.741929]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[295352.767022] RIP: 0033:0x7f3f53f409b7
[295352.785431] RSP: 002b:00007f3f439f70c8 EFLAGS: 00000202 ORIG_RAX: 000=
00000000000fe
[295352.823469] RAX: ffffffffffffffda RBX: 00007f3f2c232fc0 RCX: 00007f3f=
53f409b7
[295352.859222] RDX: 0000000022000fc6 RSI: 0000000002eaba50 RDI: 00000000=
00000018
[295352.901958] RBP: 0000000002677d20 R08: 000000005ad2a563 R09: 00000000=
09caa9a8
[295352.937907] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000=
02677d20
[295352.974108] R13: 000000000000fd02 R14: 000000000005dc08 R15: 00000000=
000081a4
[295353.010354] Code: ff 80 8b ac 08 00 00 04 e9 20 ff ff ff 0f 0b e9 b9 =
fe ff ff f7 83 84 00 00 00
fd ff ff ff 0f 84 c3 fe ff ff 0f 0b e9 bc fe ff ff <0f> 0b e9 cb fe ff ff=
 66 90 0f 1f 44 00 00 55 48
89 e5 41 56 49
[295353.103228] ---[ end trace 97f09d2dbcdbfe08 ]---
[295353.126793] sched: Unexpected reschedule of offline CPU#8!
[295353.154571] ------------[ cut here ]------------
[295353.178193] WARNING: CPU: 26 PID: 1384 at arch/x86/kernel/smp.c:128
native_smp_send_reschedule+0x42/0x50
[295353.225115] Modules linked in: binfmt_misc sctp_diag sctp dccp_diag d=
ccp tcp_diag udp_diag
inet_diag unix_diag cfg80211 rfkill 8021q garp mrp xfs x86_pkg_temp_therm=
al intel_powerclamp loop
coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmu=
lni_intel pcbc aesni_intel
crypto_simd glue_helper cryptd iTCO_wdt ipmi_si iTCO_vendor_support intel=
_cstate intel_rapl_perf
lpc_ich sg hpilo hpwdt ioatdma pcspkr ipmi_devintf i2c_i801 dca shpchp mf=
d_core wmi ipmi_msghandler
nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables ext4 mbcache jbd2 i=
2c_algo_bit drm_kms_helper
syscopyarea sysfillrect sysimgblt sd_mod fb_sys_fops ttm bnx2x mdio libcr=
c32c crc32c_intel serio_raw
hpsa ptp drm scsi_transport_sas pps_core dm_mirror dm_region_hash dm_log =
dm_mod dax
[295353.554858] CPU: 26 PID: 1384 Comm: thread.rb:70 Tainted: G      D W =
      4.14.32-1.el7.x86_64 #1
[295353.600673] Hardware name: HP ProLiant BL460c Gen9, BIOS I36 10/25/20=
17
[295353.634304] task: ffff882035430000 task.stack: ffffc90007bb4000
[295353.664086] RIP: 0010:native_smp_send_reschedule+0x42/0x50
[295353.691429] RSP: 0018:ffff88203f483c60 EFLAGS: 00010046
[295353.717211] RAX: 000000000000002e RBX: 0000000000000008 RCX: 00000000=
00000006
[295353.753162] RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffff8820=
3f4969d0
[295353.789028] RBP: ffff88203f483c60 R08: 0000000000000000 R09: 00000000=
0000050a
[295353.824901] R10: ffffffff8140e7c0 R11: 0000000000000509 R12: ffff8820=
3f222ac0
[295353.860780] R13: ffff880fc6730000 R14: ffff88203f483d18 R15: ffff8820=
3f222ac0
[295353.897041] FS:  00007f3f439f9700(0000) GS:ffff88203f480000(0000) knl=
GS:0000000000000000
[295353.937015] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[295353.965230] CR2: 000000c43069c000 CR3: 000000203943e001 CR4: 00000000=
003606e0
[295354.001263] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
[295354.037348] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
[295354.073079] Call Trace:
[295354.085676]  <IRQ>
[295354.096271]  resched_curr+0xae/0xd0
[295354.114398]  check_preempt_curr+0x79/0xa0
[295354.134774]  ttwu_do_wakeup+0x1e/0x160
[295354.153738]  ttwu_do_activate+0x7a/0x90
[295354.173017]  try_to_wake_up+0x1e7/0x480
[295354.192199]  default_wake_function+0x12/0x20
[295354.213726]  autoremove_wake_function+0x16/0x60
[295354.236555]  __wake_up_common+0x8f/0x160
[295354.256636]  __wake_up_common_lock+0x7e/0xc0
[295354.278570]  __wake_up+0x13/0x20
[295354.295265]  wake_up_klogd_work_func+0x40/0x60
[295354.317984]  irq_work_run_list+0x53/0x80
[295354.337965]  ? tick_sched_do_timer+0x70/0x70
[295354.359264]  irq_work_tick+0x40/0x50
[295354.377736]  update_process_times+0x42/0x60
[295354.399024]  tick_sched_handle+0x2d/0x60
[295354.418996]  tick_sched_timer+0x39/0x70
[295354.438406]  __hrtimer_run_queues+0xe7/0x230
[295354.459586]  hrtimer_interrupt+0xa8/0x1a0
[295354.479258]  smp_apic_timer_interrupt+0x6b/0x140
[295354.502194]  apic_timer_interrupt+0x8e/0xa0
[295354.523081]  </IRQ>
[295354.533789] RIP: 0010:panic+0x206/0x258
[295354.553565] RSP: 0018:ffffc90007bb7c58 EFLAGS: 00000246 ORIG_RAX: fff=
fffffffffff10
[295354.590890] RAX: 0000000000000034 RBX: 0000000000000200 RCX: 00000000=
00000006
[295354.626876] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff8820=
3f4969d0
[295354.662703] RBP: ffffc90007bb7cc8 R08: 0000000000000000 R09: 00000000=
000004bf
[295354.698251] R10: ffffffff8140e7c0 R11: 00000000000004be R12: ffffffff=
81e4b096
[295354.733758] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
00000000
[295354.769850]  ? vgacon_invert_region+0x80/0x80
[295354.791724]  ? panic+0x1ff/0x258
[295354.808021]  oops_end+0xba/0xd0
[295354.823809]  die+0x42/0x50
[295354.837948]  do_general_protection+0xd2/0x160
[295354.859636]  general_protection+0x25/0x50
[295354.880150] RIP: 0010:prefetch_freepointer.isra.63+0x11/0x20
[295354.908869] RSP: 0018:ffffc90007bb7e08 EFLAGS: 00010202
[295354.935002] RAX: 0000000000000000 RBX: 6236612d38373234 RCX: 00000000=
000199bb
[295354.970812] RDX: 00000000000199ba RSI: 6236612d38373234 RDI: ffff8820=
3ec259a0
[295355.006560] RBP: ffffc90007bb7e08 R08: 0000000000028060 R09: ffffffff=
82051cc0
[295355.042849] R10: 0000000000002000 R11: 0000000000000040 R12: 00000000=
014000c0
[295355.077849] R13: ffff88203ec25980 R14: ffff88203ec25980 R15: ffff8820=
00000000
[295355.113175]  ? idr_alloc_cmn+0x98/0xe0
[295355.132128]  kmem_cache_alloc+0x9c/0x1b0
[295355.151819]  ? fsnotify_add_mark_locked+0x153/0x320
[295355.176264]  fsnotify_add_mark_locked+0x153/0x320
[295355.199925]  SyS_inotify_add_watch+0x2d5/0x350
[295355.222164]  do_syscall_64+0x79/0x1b0
[295355.240555]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[295355.266353] RIP: 0033:0x7f3f53f409b7
[295355.284573] RSP: 002b:00007f3f439f70c8 EFLAGS: 00000202 ORIG_RAX: 000=
00000000000fe
[295355.322272] RAX: ffffffffffffffda RBX: 00007f3f2c232fc0 RCX: 00007f3f=
53f409b7
[295355.357920] RDX: 0000000022000fc6 RSI: 0000000002eaba50 RDI: 00000000=
00000018
[295355.393626] RBP: 0000000002677d20 R08: 000000005ad2a563 R09: 00000000=
09caa9a8
[295355.429391] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000=
02677d20
[295355.464726] R13: 000000000000fd02 R14: 000000000005dc08 R15: 00000000=
000081a4
[295355.500091] Code: c0 74 1a 48 8b 05 7f 44 ec 00 be fd 00 00 00 48 8b =
80 a0 00 00 00 e8 ae 1a 9b
00 5d c3 89 fe 48 c7 c7 b8 26 e5 81 e8 21 45 09 00 <0f> 0b 5d c3 66 2e 0f=
 1f 84 00 00 00 00 00 0f 1f
44 00 00 55 48
[295355.592809] ---[ end trace 97f09d2dbcdbfe09 ]---
[295355.616249] sched: Unexpected reschedule of offline CPU#0!
[295355.642901] ------------[ cut here ]------------
[295355.666243] WARNING: CPU: 26 PID: 1384 at arch/x86/kernel/smp.c:128
native_smp_send_reschedule+0x42/0x50
[295355.713782] Modules linked in: binfmt_misc sctp_diag sctp dccp_diag d=
ccp tcp_diag udp_diag
inet_diag unix_diag cfg80211 rfkill 8021q garp mrp xfs x86_pkg_temp_therm=
al intel_powerclamp loop
coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmu=
lni_intel pcbc aesni_intel
crypto_simd glue_helper cryptd iTCO_wdt ipmi_si iTCO_vendor_support intel=
_cstate intel_rapl_perf
lpc_ich sg hpilo hpwdt ioatdma pcspkr ipmi_devintf i2c_i801 dca shpchp mf=
d_core wmi ipmi_msghandler
nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables ext4 mbcache jbd2 i=
2c_algo_bit drm_kms_helper
syscopyarea sysfillrect sysimgblt sd_mod fb_sys_fops ttm bnx2x mdio libcr=
c32c crc32c_intel serio_raw
hpsa ptp drm scsi_transport_sas pps_core dm_mirror dm_region_hash dm_log =
dm_mod dax
[295356.048067] CPU: 26 PID: 1384 Comm: thread.rb:70 Tainted: G      D W =
      4.14.32-1.el7.x86_64 #1
[295356.094292] Hardware name: HP ProLiant BL460c Gen9, BIOS I36 10/25/20=
17
[295356.127304] task: ffff882035430000 task.stack: ffffc90007bb4000
[295356.157937] RIP: 0010:native_smp_send_reschedule+0x42/0x50
[295356.186118] RSP: 0018:ffff88203f483c58 EFLAGS: 00010046
[295356.212721] RAX: 000000000000002e RBX: ffff8810391945c0 RCX: 00000000=
00000006
[295356.247928] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff8820=
3f4969d0
[295356.284320] RBP: ffff88203f483c58 R08: 0000000000000000 R09: 00000000=
00000559
[295356.320685] R10: ffffffff8140e7c0 R11: 0000000000000558 R12: ffff8810=
3919516c
[295356.356635] R13: 0000000000000004 R14: 0000000000000046 R15: 00000000=
00022ac0
[295356.392135] FS:  00007f3f439f9700(0000) GS:ffff88203f480000(0000) knl=
GS:0000000000000000
[295356.432737] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[295356.461522] CR2: 000000c43069c000 CR3: 000000203943e001 CR4: 00000000=
003606e0
[295356.497800] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
[295356.533485] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
[295356.569205] Call Trace:
[295356.581694]  <IRQ>
[295356.591921]  try_to_wake_up+0x405/0x480
[295356.611188]  default_wake_function+0x12/0x20
[295356.632564]  __wake_up_common+0x8f/0x160
[295356.652486]  __wake_up_locked+0x16/0x20
[295356.671808]  ep_poll_callback+0xd0/0x300
[295356.691565]  __wake_up_common+0x8f/0x160
[295356.711684]  __wake_up_common_lock+0x7e/0xc0
[295356.733447]  __wake_up+0x13/0x20
[295356.749916]  wake_up_klogd_work_func+0x40/0x60
[295356.772512]  irq_work_run_list+0x53/0x80
[295356.792701]  ? tick_sched_do_timer+0x70/0x70
[295356.821294]  irq_work_tick+0x40/0x50
[295356.839929]  update_process_times+0x42/0x60
[295356.860941]  tick_sched_handle+0x2d/0x60
[295356.881072]  tick_sched_timer+0x39/0x70
[295356.900787]  __hrtimer_run_queues+0xe7/0x230
[295356.922396]  hrtimer_interrupt+0xa8/0x1a0
[295356.942760]  smp_apic_timer_interrupt+0x6b/0x140
[295356.966377]  apic_timer_interrupt+0x8e/0xa0
[295356.987700]  </IRQ>
[295356.998764] RIP: 0010:panic+0x206/0x258
[295357.018139] RSP: 0018:ffffc90007bb7c58 EFLAGS: 00000246 ORIG_RAX: fff=
fffffffffff10
[295357.055880] RAX: 0000000000000034 RBX: 0000000000000200 RCX: 00000000=
00000006
[295357.092139] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff8820=
3f4969d0
[295357.127348] RBP: ffffc90007bb7cc8 R08: 0000000000000000 R09: 00000000=
000004bf
[295357.163530] R10: ffffffff8140e7c0 R11: 00000000000004be R12: ffffffff=
81e4b096
[295357.200334] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
00000000
[295357.236063]  ? vgacon_invert_region+0x80/0x80
[295357.257667]  ? panic+0x1ff/0x258
[295357.274076]  oops_end+0xba/0xd0
[295357.290155]  die+0x42/0x50
[295357.303914]  do_general_protection+0xd2/0x160
[295357.326145]  general_protection+0x25/0x50
[295357.346126] RIP: 0010:prefetch_freepointer.isra.63+0x11/0x20
[295357.374233] RSP: 0018:ffffc90007bb7e08 EFLAGS: 00010202
[295357.400584] RAX: 0000000000000000 RBX: 6236612d38373234 RCX: 00000000=
000199bb
[295357.436122] RDX: 00000000000199ba RSI: 6236612d38373234 RDI: ffff8820=
3ec259a0
[295357.471905] RBP: ffffc90007bb7e08 R08: 0000000000028060 R09: ffffffff=
82051cc0
[295357.508220] R10: 0000000000002000 R11: 0000000000000040 R12: 00000000=
014000c0
[295357.544201] R13: ffff88203ec25980 R14: ffff88203ec25980 R15: ffff8820=
00000000
[295357.580063]  ? idr_alloc_cmn+0x98/0xe0
[295357.598651]  kmem_cache_alloc+0x9c/0x1b0
[295357.617905]  ? fsnotify_add_mark_locked+0x153/0x320
[295357.641988]  fsnotify_add_mark_locked+0x153/0x320
[295357.665286]  SyS_inotify_add_watch+0x2d5/0x350
[295357.687722]  do_syscall_64+0x79/0x1b0
[295357.706171]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[295357.731499] RIP: 0033:0x7f3f53f409b7
[295357.749414] RSP: 002b:00007f3f439f70c8 EFLAGS: 00000202 ORIG_RAX: 000=
00000000000fe
[295357.787490] RAX: ffffffffffffffda RBX: 00007f3f2c232fc0 RCX: 00007f3f=
53f409b7
[295357.823420] RDX: 0000000022000fc6 RSI: 0000000002eaba50 RDI: 00000000=
00000018
[295357.859615] RBP: 0000000002677d20 R08: 000000005ad2a563 R09: 00000000=
09caa9a8
[295357.895120] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000=
02677d20
[295357.931829] R13: 000000000000fd02 R14: 000000000005dc08 R15: 00000000=
000081a4
[295357.967565] Code: c0 74 1a 48 8b 05 7f 44 ec 00 be fd 00 00 00 48 8b =
80 a0 00 00 00 e8 ae 1a 9b
00 5d c3 89 fe 48 c7 c7 b8 26 e5 81 e8 21 45 09 00 <0f> 0b 5d c3 66 2e 0f=
 1f 84 00 00 00 00 00 0f 1f
44 00 00 55 48
[295358.060705] ---[ end trace 97f09d2dbcdbfe0a ]---


---[ sar -f ./sa15 -s 01:05:00 -e 02:00:00 -P 26 ]---
Linux 4.14.32-1.el7.x86_64 (foomar) 	04/15/2018 	_x86_64_	(32 CPU)

01:05:00 AM     CPU     %user     %nice   %system   %iowait    %steal    =
 %idle
01:05:01 AM      26      0.00      0.00      0.00      0.00      0.00    =
100.00
01:05:02 AM      26      0.00      0.00      0.00      0.00      0.00    =
100.00
01:05:03 AM      26      0.00      0.00      0.00      0.00      0.00    =
100.00
01:05:04 AM      26      0.00      0.00      0.00      0.00      0.00    =
100.00
01:05:05 AM      26      0.99      0.00      0.99      0.00      0.00    =
 98.02
01:05:06 AM      26      0.00      0.00      0.00      0.00      0.00    =
100.00
01:05:07 AM      26      0.00      0.00      0.00      0.00      0.00    =
100.00
01:05:08 AM      26      0.00      0.00      0.00      0.00      0.00    =
100.00
01:05:09 AM      26      0.00      0.00      0.00      0.00      0.00    =
100.00
01:05:10 AM      26      0.00      0.00      0.00      0.00      0.00    =
100.00
01:05:11 AM      26      0.99      0.00      0.00      0.00      0.00    =
 99.01
01:05:12 AM      26      0.00      0.00      0.00      0.00      0.00    =
100.00
01:05:13 AM      26      0.00      0.00      0.00      0.00      0.00    =
100.00
01:05:14 AM      26      0.00      0.00      0.00      0.00      0.00    =
100.00
01:05:15 AM      26      0.00      0.00      0.00      0.00      0.00    =
100.00
01:05:16 AM      26      2.00      0.00      1.00      0.00      0.00    =
 97.00
01:05:17 AM      26      0.00      0.00      0.00      0.00      0.00    =
100.00
01:05:18 AM      26      0.00      0.00      0.00      0.00      0.00    =
100.00
---[ sar -f ./sa15 -s 01:05:00 -e 02:00:00 -P 26 ]---


Any ideas would be very much appreciated.

Cheers,
Pavlos Parissis


--CWF5T6c1xqXOPcHEd2P74b03DlIbe7vAH--

--MIjo29yQqek6uPytyMJp5P7bmvDC3zx28
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEHZDZK6DBu+YUj6+dg/yS2h9xdrkFAlrUjt8ACgkQg/yS2h9x
drmHEg//bq6er64qr72zAwJRq9Erqn7TuuQKTJ6xSH7mFJqbfEnjetpMmZ5zyc7L
n0oM6Y7pGsPqZjpagMsv7vRCh1mHmB7KSUcsRA7HcCuA3Gy9Zmt//KMP9jP7CBfs
KSpmIUZZGAta5JJbuhLW2tNzF1hXPhU7DOWNYah6i0rb+SM9SGSW2Rxc4+ouZ1k9
1H6zydJ9fa25R6p2nQLp83hL5+GIoqqXt4OH5fv0Zud64llIerdE/l3T6ixrfvqJ
TKXT8xx99YrHAx6N3u8kUtG82ctG1A9jtZk9VpWtk+XS9scbjQEVDNct4OWkokRh
xEAiow2Taq+6dKW2I+1ig6F3R/8Rhlecder8ux21GKWT1Fqxh9k1vo9mjWpJHE0h
+0hwiHjtKywKwRP5Ox3b0cnj719nLJdGG5qLdCBvCLN9ItEtr8onLmtx6DygOpr6
r59Ee2pOMXgTQ6tIYxv5erdSFN43iDGORPYPLVk2OMrU1OhsVCJlh7H4cKm9rNVx
4yZFK84/2mCpOGbPDBz50VTh3o5xJxRjXGHZ7V4ZFnWnLzn+Hyw1OMpDtH6rc56n
rv23j8fyKomtBp2NZbBF3kCBRgb+/uvYz+1BIduXowmwrwMrB/m4u/cPwYG2TrUZ
oVWwKpuBAwejo5IEtgCqb9iIevXsSm7szrHTAg/5PxzfRVGIub8=
=u7jj
-----END PGP SIGNATURE-----

--MIjo29yQqek6uPytyMJp5P7bmvDC3zx28--
