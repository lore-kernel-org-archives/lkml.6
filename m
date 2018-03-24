Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbeCXM70 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 08:59:26 -0400
Received: from smtprelay0234.hostedemail.com ([216.40.44.234]:32836 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751879AbeCXM7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 08:59:25 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,-10,0,,d41d8cd98f00b204,shea@shealevy.com,::::::::::::::,RULES_HIT:41:334:355:368:369:379:599:800:871:960:967:973:988:989:1000:1260:1263:1313:1314:1345:1359:1437:1516:1518:1535:1544:1575:1605:1711:1730:1747:1777:1792:2393:2525:2553:2559:2564:2682:2685:2693:2859:2895:2903:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4117:4250:4321:4362:4605:4860:5007:6117:6119:6238:6261:6506:6747:7281:7875:7903:7909:8660:9010:9025:9040:9388:10004:10049:10848:11026:11232:11473:11658:11914:12043:12291:12379:12438:12555:12663:12683:12740:12776:12895:12986:13148:13230:14106:14107:14180:14181:14721:14849:21060:21063:21080:21433:21451:21627:21740:30054:30056:30060:30070:30089:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: fog30_34dc0f053bb5a
X-Filterd-Recvd-Size: 6556
From: Shea Levy <shea@shealevy.com>
To: Palmer Dabbelt <palmer@sifive.com>, zong@andestech.com
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org,
        zongbox@gmail.com, zong@andestech.com, albert@sifive.com,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 00/11] RISC-V: Resolve the issue of loadable module on 64-bit
In-Reply-To: <mhng-381d004e-2fbd-4012-9ccc-e845dd5396c0@palmer-si-x1c4>
References: <mhng-381d004e-2fbd-4012-9ccc-e845dd5396c0@palmer-si-x1c4>
Date: Sat, 24 Mar 2018 08:59:21 -0400
Message-ID: <87370pvdcm.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi Palmer, Zong,

Palmer Dabbelt <palmer@sifive.com> writes:

> On Thu, 15 Mar 2018 01:50:40 PDT (-0700), zong@andestech.com wrote:
>> These patches resolve the some issues of loadable module.
>>   - symbol out of ranges
>>   - unknown relocation types
>>
>> The reference of external variable and function symbols
>> cannot exceed 32-bit offset ranges in kernel module.
>> The module only can work on the 32-bit OS or the 64-bit
>> OS with sv32 virtual addressing.
>>
>> These patches will generate the .got, .got.plt and
>> .plt sections during loading module, let it can refer
>> to the symbol which locate more than 32-bit offset.
>> These sections depend on the relocation types:
>>  - R_RISCV_GOT_HI20
>>  - R_RISCV_CALL_PLT
>>
>> These patches also support more relocation types
>>  - R_RISCV_CALL
>>  - R_RISCV_HI20
>>  - R_RISCV_LO12_I
>>  - R_RISCV_LO12_S
>>  - R_RISCV_RVC_BRANCH
>>  - R_RISCV_RVC_JUMP
>>  - R_RISCV_ALIGN
>>  - R_RISCV_ADD32
>>  - R_RISCV_SUB32
>>
>> This is the list of testing modules:
>> # lsmod
>> btrfs 7876158 0 - Live 0xffffffd00745d000
>> ramoops 90806 0 - Live 0xffffffd0024b8000
>> lzo 10554 0 - Live 0xffffffd002050000
>> zstd_decompress 567575 1 btrfs, Live 0xffffffd00238b000
>> zstd_compress 1543837 1 btrfs, Live 0xffffffd002211000
>> zram 101300 0 - Live 0xffffffd0021b8000
>> xxhash 62254 2 zstd_decompress,zstd_compress, Live 0xffffffd0020cf000
>> xor 33246 1 btrfs, Live 0xffffffd002042000
>> xfs 4395343 0 - Live 0xffffffd00399e000
>> tun 252041 0 - Live 0xffffffd0038e0000
>> test_user_copy 5265 0 - Live 0xffffffd003783000
>> test_static_keys 19606 0 - Live 0xffffffd003717000
>> test_static_key_base 7374 1 test_static_keys, Live 0xffffffd0036dc000
>> test_printf 7804 0 [permanent], Live 0xffffffd00369c000
>> test_module 1557 0 - Live 0xffffffd003646000
>> test_kmod 49100 0 - Live 0xffffffd0035f2000
>> test_bpf 1599301 0 - Live 0xffffffd003000000
>> test_bitmap 4403 0 - Live 0xffffffd002dd8000
>> reed_solomon 38866 1 ramoops, Live 0xffffffd002d86000
>> raid6_pq 161872 1 btrfs, Live 0xffffffd002b9e000
>> netdevsim 65401 0 - Live 0xffffffd002910000
>>
>> Signed-off-by: Zong Li <zong@andestech.com>
>> ---
>> Change in v2:
>>  - Add compile option 'mno-relax' for build kernel module
>>  - Just fail on ALIGN type, this is unexpected type with mno-relax.
>>
>> Zong Li (11):
>>   RISC-V: Add sections of PLT and GOT for kernel module
>>   RISC-V: Add section of GOT.PLT for kernel module
>>   RISC-V: Support GOT_HI20/CALL_PLT relocation type in kernel module
>>   RISC-V: Support CALL relocation type in kernel module
>>   RISC-V: Support HI20/LO12_I/LO12_S relocation type in kernel module
>>   RISC-V: Support RVC_BRANCH/JUMP relocation type in kernel modulewq
>>   RISC-V: Support ALIGN relocation type in kernel module
>>   RISC-V: Support ADD32 relocation type in kernel module
>>   RISC-V: Support SUB32 relocation type in kernel module
>>   RISC-V: Enable module support in defconfig
>>   RISC-V: Add definition of relocation types
>>
>>  arch/riscv/Kconfig                  |   5 +
>>  arch/riscv/Makefile                 |   5 +
>>  arch/riscv/configs/defconfig        |   2 +
>>  arch/riscv/include/asm/module.h     | 113 +++++++++++++++++++++++
>>  arch/riscv/include/uapi/asm/elf.h   |   7 ++
>>  arch/riscv/kernel/Makefile          |   1 +
>>  arch/riscv/kernel/module-sections.c | 156 +++++++++++++++++++++++++++++++
>>  arch/riscv/kernel/module.c          | 179 ++++++++++++++++++++++++++++++++++--
>>  arch/riscv/kernel/module.lds        |   8 ++
>>  9 files changed, 470 insertions(+), 6 deletions(-)
>>  create mode 100644 arch/riscv/include/asm/module.h
>>  create mode 100644 arch/riscv/kernel/module-sections.c
>>  create mode 100644 arch/riscv/kernel/module.lds
>
> Thanks!  I've added this to our for-next branch, so it should start to get a
> bit more testing soon.  I've had a bit of the flu and am therefor a bit out of
> it, so I'll try to look closer before the next merge window.
>

I've updated my kernel to point to riscv-all, and now I'm getting:

scsi_mod: target ffffffe000029a80 can not be addressed by the 32-bit offset from PC = 00000000fe3be867

Any idea why this might be? My patchset had a patch [1] to ensure
modules were loaded within a 32 bit offset of the kernel text, do we
need to include that?

Thanks,
Shea

[1] http://lists.infradead.org/pipermail/linux-riscv/2018-February/000083.html

> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlq2S6kACgkQXAvWlX2G
/iczghAAxGGhuBZV4qDsVtF1vXd1Tgm0WL1gHRITlu9IZn8guXRdv5HSJoQBctj7
pcpmRJSCkxy8ff03lDET+JdF2SK7n08mNDEv2wQuUCC5dBnLdfMO4BP+1UJevItj
sJIQfrb1nGQ8VH0Wj3mM33GqB8YVVcoBdbBJf8vDtOz1fg+2zdHHRuBwy7WRXIkg
Rlvad9+nAHOwVgZXDUzHGnkJjQNnOntYSGh5OzWsPqjeL7cYip++krqo5VLDAAfd
sBfPfkV6/8ADcQPdEAKDcITLO+MCkf7KaWEgMJVEHUtK0AYsoDdyfLaQUk1j6KjU
af4AZZvhXVnY3Sn6xTiWHc2nXF+XKNKnfmMWFEH7JDO/mRkGIH5mK1zbJ8ccSMuX
HHEMSUEhVd4ZparZ39j2ybqzh3BcJMPlge0A/qfMEIScXKFD9SaOS831QFDSYjK+
JQJQqlRcwYjyHrUXZZIImg/oo3h4vq1a0Bn3ZSumHLDdjCAHo+sTfQotkF8tH3K4
jrrIuiHybPedUyvXR/TTjuX3OY/urdfpZ0X623UCtTlcoqu61nSX6+MoF13TMQNS
GCVU/X8h6AQcSrWKu32x4xF20uCkLVghg6RaBJrVsg8HHe9qJWNzmiTNym7lrLO3
uw2undabOz/DdQv9g54tmTORU/tN/dmh5rQyChH/AAzwM6pUFPs=
=T6fE
-----END PGP SIGNATURE-----
--=-=-=--
