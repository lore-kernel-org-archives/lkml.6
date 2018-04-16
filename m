Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-220864-1523921512-2-4513754358897177859
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
    1523921511; b=SRYs8isYzMR9mGUUgYrNx/y4XKypUSV4wQkQnu7KJf9Hk2xkJ8
    NlA2W714G96R/9zntUd9XYoRECrIqyOt6iNL165B2tZOIzvJj+VT7Rdg5nHWDV8d
    s/ApyEp8sREU2aRtmVuYyGqLdxmayld4GgdYUvl2LuqSgA3vQAomzh2QYImuo1ju
    9ad8CQunYvzVgmq2pv4L7oP1gjjabHGUKSe7oH0xG1zM5F6sBDsaqM3jb/l3trCk
    DTiKLxjxxtJM+OkGHLNzcSbhu7VC10UWR4pJVF8ygOEnP0YKYbNlJykvob4BadN0
    k5TTOWRPdiOfAs5M7ZEo+hZ6imlasiTOW25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    fm2; t=1523921511; bh=xglZNu8oAEUrdF5dvXIdhobuQRStwb7z2whyhZ+bnW
    U=; b=g3feAvxnepMm9ALYdiApj/x0fLqU6IQNHhD3r+Uy61VsyWRGjVAg9ceYt3
    TF6tG7AteC974U3IH4LU+Z8FSymzgqCBztdVEvbU1SOCVFg3Lh0Q6rv5F1XCTWjW
    aOoC9DDrZVF9Nkz76LP/2FKBGR/cxgSwxmdOx/U1spIi1aIkohqA86RE55Mz/Dtx
    86TZshSPQRpFcRUxrW1BYfhiZ22mDE4anqcJqsynhhY7WQ6E0bc69iqQNuvLRd16
    q+PfBH+phyrmoI0XEdDbRw8xf4L5SMlskWlfWJTjKg4VT4iVFIbJ5ltLYk0h1pKM
    K4qPVSwgllS3Tu4QgstQEM0Jhtfw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=drcE15vp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H57Mimt6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=drcE15vp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H57Mimt6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIbFxBJt6WD/qW+PnDr/SDUi7XVs8WRUnFsyBkMOe6KVpAX1a/35GS2MXfFKZksla5rMN7O3lnIvukzz837NpbcT1YTmSfphEFU58sQ7Voo4aPhoGT8c
    i+MDeGyHroix1XTrRx1yh2S8hQS1c5tzBcFrVSQlsyDTykVVkXUV+w2LBv1t9HnWjuo7/eoDeIwoQFkE2x2IsfWDbTzp7ZTLXavqnD6OyVY4lufEWtg18lxe
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=ZVeAwwkMJCUA:10
    a=Kd1tUaAdevIA:10 a=13zjGPudsaEWiJwPRgMA:9 a=D19gQVrFAAAA:8
    a=DscMN0iVMo0BgfMDDBsA:9 a=QEXdDO2ut3YA:10 a=OdvuxBTuGZ3QhDn_RSQA:9
    a=ONNS8QRKHyMA:10 a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751060AbeDPXbs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 19:31:48 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:42293 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbeDPXbr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 19:31:47 -0400
X-Google-Smtp-Source: AIpwx4+bPp7HJ0ZdtTG82tN8cP0nMXO8N8wtmzTAluIT5HW1HUJYv9ns/OP2E5thZdh9vKe5hXNdNw==
Subject: Re: kernel panics with 4.14.X versions
To: Jan Kara <jack@suse.cz>, Guillaume Morin <guillaume@morinfr.org>
Cc: stable@vger.kernel.org, decui@microsoft.com, jack@suse.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
From: Pavlos Parissis <pavlos.parissis@gmail.com>
Message-ID: <9b11cfba-4bdc-8a3e-cd33-2f7e8d513bdf@gmail.com>
Date: Tue, 17 Apr 2018 01:31:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2ghRghmoEZzwAlKv35wIbo0E3KXBNuMWB"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2ghRghmoEZzwAlKv35wIbo0E3KXBNuMWB
Content-Type: multipart/mixed; boundary="9FDS8MZPRlFqK18ZMb9Uy5gipiGLmYfiQ";
 protected-headers="v1"
From: Pavlos Parissis <pavlos.parissis@gmail.com>
To: Jan Kara <jack@suse.cz>, Guillaume Morin <guillaume@morinfr.org>
Cc: stable@vger.kernel.org, decui@microsoft.com, jack@suse.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mszeredi@redhat.com
Message-ID: <9b11cfba-4bdc-8a3e-cd33-2f7e8d513bdf@gmail.com>
Subject: Re: kernel panics with 4.14.X versions
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
In-Reply-To: <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>

--9FDS8MZPRlFqK18ZMb9Uy5gipiGLmYfiQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16/04/2018 04:40 =CE=BC=CE=BC, Jan Kara wrote:
> On Mon 16-04-18 15:25:50, Guillaume Morin wrote:
>> Fwiw, there have been already reports of similar soft lockups in
>> fsnotify() on 4.14: https://lkml.org/lkml/2018/3/2/1038
>>
>> We have also noticed similar softlockups with 4.14.22 here.
>=20
> Yeah.
> =20
>> On 16 Apr 13:54, Pavlos Parissis wrote:
>>>
>>> Hi all,
>>>

[..snip..]

>>> [373782.361064] watchdog: BUG: soft lockup - CPU#24 stuck for 22s! [k=
ube-apiserver:24261]
>>> [373782.378225] Modules linked in: binfmt_misc sctp_diag sctp dccp_di=
ag dccp tcp_diag udp_diag
>>> inet_diag unix_diag cfg80211 rfkill dell_rbu 8021q garp mrp xfs libcr=
c32c loop x86_pkg_temp_thermal
>>> intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul cr=
c32_pclmul ghash_clmulni_intel
>>> pcbc aesni_intel vfat fat crypto_simd glue_helper cryptd intel_cstate=
 intel_rapl_perf iTCO_wdt ses
>>> iTCO_vendor_support mxm_wmi ipmi_si dcdbas enclosure mei_me pcspkr ip=
mi_devintf lpc_ich sg mei
>>> ipmi_msghandler mfd_core shpchp wmi acpi_power_meter netconsole nfsd =
auth_rpcgss nfs_acl lockd grace
>>> sunrpc ip_tables ext4 mbcache jbd2 i2c_algo_bit drm_kms_helper syscop=
yarea sysfillrect sysimgblt
>>> fb_sys_fops sd_mod ttm crc32c_intel ahci libahci mlx5_core drm mlxfw =
mpt3sas ptp libata raid_class
>>> pps_core scsi_transport_sas
>>> [373782.516807]  dm_mirror dm_region_hash dm_log dm_mod dax
>>> [373782.531739] CPU: 24 PID: 24261 Comm: kube-apiserver Not tainted 4=
=2E14.32-1.el7.x86_64 #1
>>> [373782.549848] Hardware name: Dell Inc. PowerEdge R630/02C2CP, BIOS =
2.4.3 01/17/2017
>>> [373782.567486] task: ffff882f66d28000 task.stack: ffffc9002120c000
>>> [373782.583441] RIP: 0010:fsnotify+0x197/0x510
>>> [373782.597319] RSP: 0018:ffffc9002120fdb8 EFLAGS: 00000286 ORIG_RAX:=
 ffffffffffffff10
>>> [373782.615308] RAX: 0000000000000000 RBX: ffff882f9ec65c20 RCX: 0000=
000000000002
>>> [373782.632950] RDX: 0000000000028700 RSI: 0000000000000002 RDI: ffff=
ffff8269a4e0
>>> [373782.650616] RBP: ffffc9002120fe98 R08: 0000000000000000 R09: 0000=
000000000000
>>> [373782.668287] R10: 0000000000000000 R11: 0000000000000000 R12: 0000=
000000000000
>>> [373782.685918] R13: 0000000000000000 R14: 0000000000000000 R15: 0000=
000000000000
>>> [373782.703302] FS:  000000c42009f090(0000) GS:ffff882fbf900000(0000)=
 knlGS:0000000000000000
>>> [373782.721887] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [373782.737741] CR2: 00007f82b6539244 CR3: 0000002f3de2a005 CR4: 0000=
0000003606e0
>>> [373782.755247] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000=
000000000000
>>> [373782.772722] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000=
000000000400
>>> [373782.790043] Call Trace:
>>> [373782.802041]  vfs_write+0x151/0x1b0
>>> [373782.815081]  ? syscall_trace_enter+0x1cd/0x2b0
>>> [373782.829175]  SyS_write+0x55/0xc0
>>> [373782.841870]  do_syscall_64+0x79/0x1b0
>>> [373782.855073]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
>=20
> Can you please run RIP through ./scripts/faddr2line to see where exactl=
y
> are we looping? I expect the loop iterating over marks to notify but be=
tter
> be sure.
>=20

I am very newbie on this and I tried with:
 ../repo/Linux/linux/scripts/faddr2line ./vmlinuz-4.14.32-1.el7.x86_64
0010:fsnotify+0x197/0x510
readelf: Error: Not an ELF file - it has the wrong magic bytes at the sta=
rt
size: ./vmlinuz-4.14.32-1.el7.x86_64: Warning: Ignoring section flag
IMAGE_SCN_MEM_NOT_PAGED in section .bss
nm: ./vmlinuz-4.14.32-1.el7.x86_64: Warning: Ignoring section flag
IMAGE_SCN_MEM_NOT_PAGED in section .bss
nm: ./vmlinuz-4.14.32-1.el7.x86_64: no symbols
size: ./vmlinuz-4.14.32-1.el7.x86_64: Warning: Ignoring section flag
IMAGE_SCN_MEM_NOT_PAGED in section .bss
nm: ./vmlinuz-4.14.32-1.el7.x86_64: Warning: Ignoring section flag
IMAGE_SCN_MEM_NOT_PAGED in section .bss
nm: ./vmlinuz-4.14.32-1.el7.x86_64: no symbols
no match for 0010:fsnotify+0x197/0x510

Obviously, I am doing something very wrong.

> How easily can you hit this?

Very easily, I only need to wait 1-2 days for a crash to occur.

> Are you able to run debug kernels

Well, I was under the impression I do as I have:
  grep -E 'DEBUG_KERNEL|DEBUG_INFO' /boot/config-4.14.32-1.el7.x86_64
  CONFIG_DEBUG_INFO=3Dy
  # CONFIG_DEBUG_INFO_REDUCED is not set
  # CONFIG_DEBUG_INFO_SPLIT is not set
  # CONFIG_DEBUG_INFO_DWARF4 is not set
  CONFIG_DEBUG_KERNEL=3Dy

Do you think that my kernel doesn't produce a proper crash dump?
I have a production cluster where I can run any kernel we need, so if I n=
eed
to compile again with different settings I can certainly do that.

> / inspect
> crash dumps when the issue occurs?

I can't do that as the server isn't responsive and I can only power cycle=
 it.

> Also testing with the latest mainline
> kernel (4.16) would be welcome whether this isn't just an issue with th=
e
> backport of fsnotify fixes from Miklos.

I can try the kernel-ml-4.16.2 from elrepo (we use CentOS 7).

Thanks a lot for your reply.
Pavlos Parissis


--9FDS8MZPRlFqK18ZMb9Uy5gipiGLmYfiQ--

--2ghRghmoEZzwAlKv35wIbo0E3KXBNuMWB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa1TJeAAoJEIP8ktofcXa58e8QALlQnsDP7m+SH21eGupW/W9Z
1EZdDJunt6tqawTVMqdOUMHzLIsi21B0Q6buEgH325UoWB4gAUOUbKELaVCO3VDK
LipGV7W0baWt1mWGNK2GlMC4JG7tUsb/7oBwjWt49Cuv8eDkfMloejTbXD4Xdftq
HaHmd6U0tKHIjEqplBqG8EejNnDkeb+iVTZqnTj1P7FMJhOBwieFFASH+YdWMzeV
tgFjr4JHUFs+WTgFLtAvp7lgMBYmm8B8wuqicsrkDtAClwj0A1tmyAUDJ2lcejSz
bWeRnZv8YAV17D9HHwRburXvhEMOFGbcI0KEU6OafWmghadlIATSikZPQngwIQ1V
lYeO3kJ+UgNSdr95kqmVMnsizSRF7I6B078YBT9B38nrJaTD52UsO9IXBr4aEFQk
GgTr9B+I7OpKNNVDWzrEDeFnjsNo3ROy8qcmAAL4F7BAoKIFqF3YIyChfGUidvNH
dUvSXFC9uBSG/IEwZqh4euskILKxvuVvd4xgrA4h3di0ZezaBR2vL9dSO+i06jFv
YTubMXwsZvxLD2lWvyo0TCnI7VsmvgL6pSEnbOQz9jl3Vaa8Y7c33Pf6YtDqHzba
9eeqbXbROP/8DrrWKXTZ1m2DUxPz1EpKMR4uQ8MAxFRz3kqydTkSGU39Qz58u+Y2
VrlzNoiTFxzqK/QDQ5AV
=n09n
-----END PGP SIGNATURE-----

--2ghRghmoEZzwAlKv35wIbo0E3KXBNuMWB--
