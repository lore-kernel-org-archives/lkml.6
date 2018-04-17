Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1636556-1523963938-2-5126372387741871121
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
    1523963938; b=oVYCqXFujKDF3eH5BwY5wbD01uodtRz1ny5p+Y4EaboCjPKATy
    6MMgrNBwk/PRMw7nO/fx6RN2PuQMvLQU3sBC1bPDAWE7HemUsbS5atXOF/aPC9nu
    4oIi4W6XUA8gV5Zr1c1CLr1nuEWvNdH+TjA53GKyXQwgyi0YX+uKrA4NEdo+z1le
    OmQADsb1tJv305Ewm8QESR6YapHfvrpRprGpUizuIu7DGxLtwMyNQUsmiFSbmhXX
    lySFsXkKjW/Zi+i8oZDW8be/I55Z0Z3t4OGNX4vdsGmfFoMDOzLmw2gye8d/USY9
    b4gQwlyWdWcHtSbz6WYRmA2Bp0inDqBBHDLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    fm2; t=1523963938; bh=lWRlXMR2AV5IDbTSjYT+mD9HQUpupHNbNWPWWsoSBv
    Q=; b=wU5v5SW8zt8HIsB2y4W9MbzutmT5jgG/auKufHgO9fufFo2Na/75i46u96
    VBTc8aiYuFE/Cpw3iDFN371XUKlruszyxQjfUEEUbbjr3Eu81H0MV4HgQMhMSFQ7
    CbMjLqzktZkWTB5IMqjdCCYxlyk5S34lCEU92I425LqCIzgE6L0vFp4fmWBA1ZAB
    aPtN2Rg6V0iXTr6V3R/X7iSeRIdXZfBLAYyvRDcQhn41VYLeVhWJxzOssbbtDScj
    p2oZfKLo+8Idah1DvWM1NQ4TqMg3KEfvY9Ej3QB7RFFsmknEbKltWyG6LMyD/FSU
    VBw/LGA1xCRgFASBJWauA8btDsqg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=J61lAQnt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FA4F1mNW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=J61lAQnt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FA4F1mNW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNbNZSPRFhQ9tEjZaLf6qNjIEnlqdvtNW/onXMAH6yE1vXR56aaF2XOaEi17UAunUosKWBJDZQ1BtYLSOTG3183JPXrDfJFOJxXs21NjkIHdBMh+Dkwd
    fK4qN79FJNsmS2SlOSN+0D8LzCaTcrPc0tyOeicjTZ5JBsuqiXwF31Wm5R11e24UEdmG/NeERj+ulTVmiZRtDk4KeSvpjAhs2MkxLMhsILXmpQI2vh+NH7zO
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=ZVeAwwkMJCUA:10
    a=Kd1tUaAdevIA:10 a=13zjGPudsaEWiJwPRgMA:9 a=D19gQVrFAAAA:8
    a=RJuVFKeMriLBPHSdby4A:9 a=IhhUuD9YAecM3MUJ:21 a=3f2dlhCQKCoQoPUe:21
    a=QEXdDO2ut3YA:10 a=aykHN3Q8OHmYjDRtgk8A:9 a=ONNS8QRKHyMA:10
    a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbeDQLSx (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 07:18:53 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33232 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeDQLSu (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 07:18:50 -0400
X-Google-Smtp-Source: AIpwx4++C4JsFXJ28HSPQdElZeOXHPx5FOcoPaPHdugghQtUXGjn0pzqcFPjnk7Ztqx/uglf7WTeBQ==
Subject: Re: kernel panics with 4.14.X versions
From: Pavlos Parissis <pavlos.parissis@gmail.com>
To: Jan Kara <jack@suse.cz>, Guillaume Morin <guillaume@morinfr.org>
Cc: stable@vger.kernel.org, decui@microsoft.com, jack@suse.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
 <9b11cfba-4bdc-8a3e-cd33-2f7e8d513bdf@gmail.com>
Message-ID: <134eb955-fae7-9fd0-946e-787986509d7b@gmail.com>
Date: Tue, 17 Apr 2018 13:18:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9b11cfba-4bdc-8a3e-cd33-2f7e8d513bdf@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ai8yaQgESfaoWlnxUhkQyxJQda3vbW3Pe"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ai8yaQgESfaoWlnxUhkQyxJQda3vbW3Pe
Content-Type: multipart/mixed; boundary="9XlytmznuQJvjcKNRANSgao5WQPrhWlad";
 protected-headers="v1"
From: Pavlos Parissis <pavlos.parissis@gmail.com>
To: Jan Kara <jack@suse.cz>, Guillaume Morin <guillaume@morinfr.org>
Cc: stable@vger.kernel.org, decui@microsoft.com, jack@suse.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mszeredi@redhat.com
Message-ID: <134eb955-fae7-9fd0-946e-787986509d7b@gmail.com>
Subject: Re: kernel panics with 4.14.X versions
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
 <9b11cfba-4bdc-8a3e-cd33-2f7e8d513bdf@gmail.com>
In-Reply-To: <9b11cfba-4bdc-8a3e-cd33-2f7e8d513bdf@gmail.com>

--9XlytmznuQJvjcKNRANSgao5WQPrhWlad
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17/04/2018 01:31 =CF=80=CE=BC, Pavlos Parissis wrote:
> On 16/04/2018 04:40 =CE=BC=CE=BC, Jan Kara wrote:
>> On Mon 16-04-18 15:25:50, Guillaume Morin wrote:
>>> Fwiw, there have been already reports of similar soft lockups in
>>> fsnotify() on 4.14: https://lkml.org/lkml/2018/3/2/1038
>>>
>>> We have also noticed similar softlockups with 4.14.22 here.
>>
>> Yeah.
>> =20
>>> On 16 Apr 13:54, Pavlos Parissis wrote:
>>>>
>>>> Hi all,
>>>>
>=20
> [..snip..]
>=20
>>>> [373782.361064] watchdog: BUG: soft lockup - CPU#24 stuck for 22s! [=
kube-apiserver:24261]
>>>> [373782.378225] Modules linked in: binfmt_misc sctp_diag sctp dccp_d=
iag dccp tcp_diag udp_diag
>>>> inet_diag unix_diag cfg80211 rfkill dell_rbu 8021q garp mrp xfs libc=
rc32c loop x86_pkg_temp_thermal
>>>> intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul c=
rc32_pclmul ghash_clmulni_intel
>>>> pcbc aesni_intel vfat fat crypto_simd glue_helper cryptd intel_cstat=
e intel_rapl_perf iTCO_wdt ses
>>>> iTCO_vendor_support mxm_wmi ipmi_si dcdbas enclosure mei_me pcspkr i=
pmi_devintf lpc_ich sg mei
>>>> ipmi_msghandler mfd_core shpchp wmi acpi_power_meter netconsole nfsd=
 auth_rpcgss nfs_acl lockd grace
>>>> sunrpc ip_tables ext4 mbcache jbd2 i2c_algo_bit drm_kms_helper sysco=
pyarea sysfillrect sysimgblt
>>>> fb_sys_fops sd_mod ttm crc32c_intel ahci libahci mlx5_core drm mlxfw=
 mpt3sas ptp libata raid_class
>>>> pps_core scsi_transport_sas
>>>> [373782.516807]  dm_mirror dm_region_hash dm_log dm_mod dax
>>>> [373782.531739] CPU: 24 PID: 24261 Comm: kube-apiserver Not tainted =
4.14.32-1.el7.x86_64 #1
>>>> [373782.549848] Hardware name: Dell Inc. PowerEdge R630/02C2CP, BIOS=
 2.4.3 01/17/2017
>>>> [373782.567486] task: ffff882f66d28000 task.stack: ffffc9002120c000
>>>> [373782.583441] RIP: 0010:fsnotify+0x197/0x510
>>>> [373782.597319] RSP: 0018:ffffc9002120fdb8 EFLAGS: 00000286 ORIG_RAX=
: ffffffffffffff10
>>>> [373782.615308] RAX: 0000000000000000 RBX: ffff882f9ec65c20 RCX: 000=
0000000000002
>>>> [373782.632950] RDX: 0000000000028700 RSI: 0000000000000002 RDI: fff=
fffff8269a4e0
>>>> [373782.650616] RBP: ffffc9002120fe98 R08: 0000000000000000 R09: 000=
0000000000000
>>>> [373782.668287] R10: 0000000000000000 R11: 0000000000000000 R12: 000=
0000000000000
>>>> [373782.685918] R13: 0000000000000000 R14: 0000000000000000 R15: 000=
0000000000000
>>>> [373782.703302] FS:  000000c42009f090(0000) GS:ffff882fbf900000(0000=
) knlGS:0000000000000000
>>>> [373782.721887] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [373782.737741] CR2: 00007f82b6539244 CR3: 0000002f3de2a005 CR4: 000=
00000003606e0
>>>> [373782.755247] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
>>>> [373782.772722] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
>>>> [373782.790043] Call Trace:
>>>> [373782.802041]  vfs_write+0x151/0x1b0
>>>> [373782.815081]  ? syscall_trace_enter+0x1cd/0x2b0
>>>> [373782.829175]  SyS_write+0x55/0xc0
>>>> [373782.841870]  do_syscall_64+0x79/0x1b0
>>>> [373782.855073]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
>>
>> Can you please run RIP through ./scripts/faddr2line to see where exact=
ly
>> are we looping? I expect the loop iterating over marks to notify but b=
etter
>> be sure.
>>
>=20
> I am very newbie on this and I tried with:
>  ../repo/Linux/linux/scripts/faddr2line ./vmlinuz-4.14.32-1.el7.x86_64
> 0010:fsnotify+0x197/0x510
> readelf: Error: Not an ELF file - it has the wrong magic bytes at the s=
tart
> size: ./vmlinuz-4.14.32-1.el7.x86_64: Warning: Ignoring section flag
> IMAGE_SCN_MEM_NOT_PAGED in section .bss
> nm: ./vmlinuz-4.14.32-1.el7.x86_64: Warning: Ignoring section flag
> IMAGE_SCN_MEM_NOT_PAGED in section .bss
> nm: ./vmlinuz-4.14.32-1.el7.x86_64: no symbols
> size: ./vmlinuz-4.14.32-1.el7.x86_64: Warning: Ignoring section flag
> IMAGE_SCN_MEM_NOT_PAGED in section .bss
> nm: ./vmlinuz-4.14.32-1.el7.x86_64: Warning: Ignoring section flag
> IMAGE_SCN_MEM_NOT_PAGED in section .bss
> nm: ./vmlinuz-4.14.32-1.el7.x86_64: no symbols
> no match for 0010:fsnotify+0x197/0x510
>=20
> Obviously, I am doing something very wrong.
>=20

I produced an uncompressed image(the error above caused by giving a compr=
essed
image to faddr2line) by compiling 4.14.32 with config which we have in pr=
oduction
and now faddr2line reports:

 ../repo/Linux/linux/scripts/faddr2line ./vmlinux 0010:fsnotify+0x197/0x5=
10
no match for 0010:fsnotify+0x197/0x510


 ../repo/Linux/linux/scripts/faddr2line ./vmlinux fsnotify+0x197/0x510



skipping fsnotify address at 0xffffffff8129baf7 due to size mismatch (0x5=
10 !=3D 0x520)
no match for fsnotify+0x197/0x510

what am I doing wrong?

Cheers,
Pavlos



--9XlytmznuQJvjcKNRANSgao5WQPrhWlad--

--ai8yaQgESfaoWlnxUhkQyxJQda3vbW3Pe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa1dgWAAoJEIP8ktofcXa5C48P+gM5HrenPrLO9gMvkHcqmOIa
OdJtr6g15A+PPUcZeyInLSLIk+XF6JjkxbV1jXzYZOOBYDTFCCSNee7SZbYjqqGN
AFBDW5Rp+xArTh6U++0kmCFY+BLWC0BvEKWS0dNR4R25DD0Y7ewYpKhhtaYGqauP
bkktzCfap5CGSUu6oNawzMsb9ZcHLT3G26QyHFA6AY+2xMZeBvTE97g4AvyjPFLC
xSe+/YKlkmj+2Zi2waDXUHQETWBv/samMWlwZL7VnBGUoIHTvWmdpRPDRdSAVOK7
sbq90jX5DXgmWrVjTFtZA823E1pe9x8xiObZ8l8T7+nzw+wdgs7qghTlixdmlTg5
b0qSmVishqXw8Y0xzX+VJF83nmag2LvpskjVDCyj+iVt8Relh/v5EKSk2XKD2bNA
BC/2HeQkWXhSH1lCxzC1ahMCA7+F/FgIqWHtf8BbocAPiIrtyM47ylsF08gcx4FS
R8qMSBSHSftSV2btKwI08dGkx55w9UHu3mPGb4gbPltduI4/beruksl0w65k2S5y
AtezEoRnL5IhaqU0jKP28ZOkYSMX5S8iZSigVn1K834dqKcewIpfhfi3PPaDCfqf
VFsjcWg1bR1LUDDh+A0RI38faHYoy5xZtpAHeu6yo5RDmjLGelYLBPir6Tut3tSy
gon2MetZ7vd9nK/Ip5sB
=2FQe
-----END PGP SIGNATURE-----

--ai8yaQgESfaoWlnxUhkQyxJQda3vbW3Pe--
