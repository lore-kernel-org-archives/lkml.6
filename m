Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932756AbeCMVbA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:31:00 -0400
Received: from smtprelay0095.hostedemail.com ([216.40.44.95]:43101 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932721AbeCMVa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:30:57 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,shea@shealevy.com,::::::::::::::,RULES_HIT:41:334:355:368:369:379:599:800:871:960:967:973:988:989:1000:1260:1263:1313:1314:1345:1359:1437:1516:1518:1535:1543:1575:1711:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2693:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4605:5007:6117:6119:6261:6506:6747:7281:7875:7903:7909:8660:9025:9388:10004:10049:10848:11026:11232:11473:11658:11914:12043:12291:12555:12683:12740:12776:12895:13148:13230:14040:14094:14096:14106:14107:14180:14181:14721:14849:21060:21063:21080:21433:21451:21627:21740:30003:30012:30054:30089:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: grass61_5f5643433322a
X-Filterd-Recvd-Size: 5100
From: Shea Levy <shea@shealevy.com>
To: Palmer Dabbelt <palmer@sifive.com>, zong@andestech.com
Cc: albert@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, zong@andestech.com, zongbox@gmail.com,
        greentime@andestech.com
Subject: Re: [PATCH 00/11] RISC-V: Resolve the issue of loadable module on 64-bit
In-Reply-To: <mhng-dcc790fc-8fd7-41c8-84c8-cc4b8bd662ea@palmer-si-x1c4>
References: <mhng-dcc790fc-8fd7-41c8-84c8-cc4b8bd662ea@palmer-si-x1c4>
Date: Tue, 13 Mar 2018 17:30:53 -0400
Message-ID: <87sh93zmr6.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi Palmer,

Palmer Dabbelt <palmer@sifive.com> writes:

> On Tue, 13 Mar 2018 01:35:05 PDT (-0700), zong@andestech.com wrote:
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
>>  arch/riscv/Kconfig                  |   5 ++
>>  arch/riscv/Makefile                 |   3 +
>>  arch/riscv/configs/defconfig        |   2 +
>>  arch/riscv/include/asm/module.h     | 112 +++++++++++++++++++++++
>>  arch/riscv/include/uapi/asm/elf.h   |  24 +++++
>>  arch/riscv/kernel/Makefile          |   1 +
>>  arch/riscv/kernel/module-sections.c | 156 ++++++++++++++++++++++++++++++++
>>  arch/riscv/kernel/module.c          | 175 ++++++++++++++++++++++++++++++++++--
>>  arch/riscv/kernel/module.lds        |   8 ++
>>  9 files changed, 480 insertions(+), 6 deletions(-)
>>  create mode 100644 arch/riscv/include/asm/module.h
>>  create mode 100644 arch/riscv/kernel/module-sections.c
>>  create mode 100644 arch/riscv/kernel/module.lds
>
> This is the second set of patches that turn on modules, and it has the same
> R_RISCV_ALIGN problem as the other one
>
>     http://lists.infradead.org/pipermail/linux-riscv/2018-February/000081.html
>
> It looks like this one uses shared libraries for modules instead of static
> objects.  I think using shared objects is the right thing to do, as it'll allow
> us to place modules anywhere in the address space by having multiple GOTs and
> PLTs.

Can you expand on this? It was my understanding that outside of the
context of multiple address spaces sharing code the GOT and PLT were
simply unnecessary overhead, what benefit would they bring here?

> That's kind of complicated, though, so we can start with something
> simpler like this.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlqoQw0ACgkQXAvWlX2G
/icVchAAyNQ307ZnTj0pHn3NqkwsXfOdpUREOu/JtjoMVmLQwFQmTjnPh272owgY
DTg1ZdumDE0QctxjoIbk5A7n9G6q9KDxAIb+t5Z/mm/hJCnVUWl6NJNDwnYH8KBY
vNUk1fN5X7N9RSL6+BS5tW35PSY5cyFSNVI/lRyNMw3bbLqNMmRbpd1yHSG8cLiB
cIPz3CnzEk5MYlywRqcRmQcOkQPt69fjgrEl139RmKwXLifFnbowRz4YsE0XiCLv
0QvbKn+k+g4bcvHANyiS3GhxbjJi9qgIRHgfnpGNZU7/7CoH/QqZSx6jyoZLy0JJ
RNwmFlDN8b7njeFNEa+nGNQf1qBpNjC3TkVBYkXvB8a/kmvEUqmwPYhyD8TpeyAX
r3EdYCz86CmiQI74OaWZ3YyvvcDiUx2cA4W2IL7v3emptWdTCvxMI1lnmsI4VFZA
KLLmYD4ygIi7j+paSncuPc9DZq+G8x7FoUfNk+qGBz8yeizc3yDDRhCnisVrw4fO
dJDLZgIVVxdJ0m6iF34nzOTU3CWhO9xJx15ct2EcLEGVD9STGY7VOZ6pKeOz3Jr6
Yul66gGdwUmI8xZ+Aha/noDA1InCaCABVRjuInvnlc/FCgom4/7ZFVHGP+ofHcDS
7uAabQbV2UXfgl0to8vuxvKLUbJTVPXeSU6UkPgBqXEsU9W11dM=
=JcPA
-----END PGP SIGNATURE-----
--=-=-=--
