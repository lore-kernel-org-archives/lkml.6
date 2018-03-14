Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeCNRLx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:11:53 -0400
Received: from smtprelay0225.hostedemail.com ([216.40.44.225]:51582 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751467AbeCNRLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:11:52 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,shea@shealevy.com,::::::::::::::,RULES_HIT:2:41:334:355:368:369:379:599:800:871:960:967:973:988:989:1000:1260:1263:1313:1314:1345:1359:1437:1516:1518:1535:1575:1605:1606:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2693:2840:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4117:4250:4605:5007:6117:6119:6261:6506:6747:7281:7875:7903:7909:8660:9025:9036:9040:9388:10004:10049:10848:11026:11232:11473:11658:11914:12043:12291:12555:12683:12740:12776:12895:12926:13148:13149:13230:14096:14106:14107:21060:21063:21080:21433:21451:21627:21740:30003:30012:30054:30089:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: sound18_4a4ed7c15e325
X-Filterd-Recvd-Size: 6894
From: Shea Levy <shea@shealevy.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: zong@andestech.com, albert@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, zong@andestech.com, zongbox@gmail.com,
        greentime@andestech.com
Subject: Re: [PATCH 00/11] RISC-V: Resolve the issue of loadable module on 64-bit
In-Reply-To: <mhng-fd5e759c-7716-41b2-9fa3-439d6b4b498f@palmer-si-x1c4>
References: <mhng-fd5e759c-7716-41b2-9fa3-439d6b4b498f@palmer-si-x1c4>
Date: Wed, 14 Mar 2018 13:11:49 -0400
Message-ID: <87d106zine.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Palmer Dabbelt <palmer@sifive.com> writes:

> On Wed, 14 Mar 2018 05:07:09 PDT (-0700), shea@shealevy.com wrote:
>> Palmer Dabbelt <palmer@sifive.com> writes:
>>
>>> On Tue, 13 Mar 2018 14:30:53 PDT (-0700), shea@shealevy.com wrote:
>>>> Hi Palmer,
>>>>
>>>> Palmer Dabbelt <palmer@sifive.com> writes:
>>>>
>>>>> On Tue, 13 Mar 2018 01:35:05 PDT (-0700), zong@andestech.com wrote:
>>>>>> These patches resolve the some issues of loadable module.
>>>>>>   - symbol out of ranges
>>>>>>   - unknown relocation types
>>>>>>
>>>>>> The reference of external variable and function symbols
>>>>>> cannot exceed 32-bit offset ranges in kernel module.
>>>>>> The module only can work on the 32-bit OS or the 64-bit
>>>>>> OS with sv32 virtual addressing.
>>>>>>
>>>>>> These patches will generate the .got, .got.plt and
>>>>>> .plt sections during loading module, let it can refer
>>>>>> to the symbol which locate more than 32-bit offset.
>>>>>> These sections depend on the relocation types:
>>>>>>  - R_RISCV_GOT_HI20
>>>>>>  - R_RISCV_CALL_PLT
>>>>>>
>>>>>> These patches also support more relocation types
>>>>>>  - R_RISCV_CALL
>>>>>>  - R_RISCV_HI20
>>>>>>  - R_RISCV_LO12_I
>>>>>>  - R_RISCV_LO12_S
>>>>>>  - R_RISCV_RVC_BRANCH
>>>>>>  - R_RISCV_RVC_JUMP
>>>>>>  - R_RISCV_ALIGN
>>>>>>  - R_RISCV_ADD32
>>>>>>  - R_RISCV_SUB32
>>>>>>
>>>>>> Zong Li (11):
>>>>>>   RISC-V: Add sections of PLT and GOT for kernel module
>>>>>>   RISC-V: Add section of GOT.PLT for kernel module
>>>>>>   RISC-V: Support GOT_HI20/CALL_PLT relocation type in kernel module
>>>>>>   RISC-V: Support CALL relocation type in kernel module
>>>>>>   RISC-V: Support HI20/LO12_I/LO12_S relocation type in kernel module
>>>>>>   RISC-V: Support RVC_BRANCH/JUMP relocation type in kernel modulewq
>>>>>>   RISC-V: Support ALIGN relocation type in kernel module
>>>>>>   RISC-V: Support ADD32 relocation type in kernel module
>>>>>>   RISC-V: Support SUB32 relocation type in kernel module
>>>>>>   RISC-V: Enable module support in defconfig
>>>>>>   RISC-V: Add definition of relocation types
>>>>>>
>>>>>>  arch/riscv/Kconfig                  |   5 ++
>>>>>>  arch/riscv/Makefile                 |   3 +
>>>>>>  arch/riscv/configs/defconfig        |   2 +
>>>>>>  arch/riscv/include/asm/module.h     | 112 +++++++++++++++++++++++
>>>>>>  arch/riscv/include/uapi/asm/elf.h   |  24 +++++
>>>>>>  arch/riscv/kernel/Makefile          |   1 +
>>>>>>  arch/riscv/kernel/module-sections.c | 156 ++++++++++++++++++++++++++++++++
>>>>>>  arch/riscv/kernel/module.c          | 175 ++++++++++++++++++++++++++++++++++--
>>>>>>  arch/riscv/kernel/module.lds        |   8 ++
>>>>>>  9 files changed, 480 insertions(+), 6 deletions(-)
>>>>>>  create mode 100644 arch/riscv/include/asm/module.h
>>>>>>  create mode 100644 arch/riscv/kernel/module-sections.c
>>>>>>  create mode 100644 arch/riscv/kernel/module.lds
>>>>>
>>>>> This is the second set of patches that turn on modules, and it has the same
>>>>> R_RISCV_ALIGN problem as the other one
>>>>>
>>>>>     http://lists.infradead.org/pipermail/linux-riscv/2018-February/000081.html
>>>>>
>>>>> It looks like this one uses shared libraries for modules instead of static
>>>>> objects.  I think using shared objects is the right thing to do, as it'll allow
>>>>> us to place modules anywhere in the address space by having multiple GOTs and
>>>>> PLTs.
>>>>
>>>> Can you expand on this? It was my understanding that outside of the
>>>> context of multiple address spaces sharing code the GOT and PLT were
>>>> simply unnecessary overhead, what benefit would they bring here?
>>>
>>> We don't currently have any position-dependent RISC-V code models larger than
>>> "medany", in which all code and data must live within a single 32-bit
>>> addressable range.  The PLT and GOT sort of provide an out here, so the code
>>> only needs to get to the table (which can then get anywhere via an indirection
>>> layer).
>>>
>>> This is relevant for Linux modules because it lets us load modules anywhere in
>>> the address space.  It's also a bit of a headache, as it either requires a
>>> GOT+PLT per module (which is big) or merging tables (which is hard).
>>
>> I see, thanks! We only get this benefit if we actually do the relevanat
>> indirection in the table, right? And if we merge tables we still have to
>> have all modules within 32 bits of the common table? Is this how some
>> future "medlarge" code model will work, or is it more of a convenient
>> way to reuse existing techniques until other code models are worked out?
>
> The idea is that you'd merge the tables only when it's possible to do that
> correctly, which is the tricky part.
>
> It'd be called "largeany", the "med" part is what limits the code model to 32
> bit offsets.  We might just call it "large", as the "any" is kind of redundant.

Ah, right, that makes more sense :D. So would "mcmodel=large" also use
PLTs/GOTs for long jumps?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlqpV9UACgkQXAvWlX2G
/ieR9hAAmSPEP427jCH06I7r5D/ghxyNwBD3rFpDF4np7YttTBre4LwF5FZzuwgj
e6qP09XTjDBGkB/5P+R7MmmuzFoV/lwmKHIV+oUmDkztTyU1BJO/qHsJ+P+G36hr
HwxzcY5ZU7uRjBqp0Fqmt808qJEIaYo4wT/pojw03iMeicSY0PQdJv0fMGoZgSZ5
rOQf6UoGdcd/TKM5+BPSIaXBIg/LYwYwEeirgD9DyUxJGY2LUKcal38XPh9x25V2
sEAfTB6w7kw/RMM7jBXeX+11nNGOffX1KM1swryui1gqc9uzBKrbNgtZwIoZ9O3/
wkSewFeuqnpQF6BpS0fk9cV7yz9b29x2+k8WJ/Xvntm8OSnAX3U3cY5rFQECk5tM
b440pcRCqnYACXHLqciC7tE6gQ0LF4VxE9EB+UNoQWWcoVvrh36CPGrIux6iechU
eGR0Hle8BRgDPSmAEJRZ9GTID+GAh7tP0Sr3/xpHsQyGHVSiQj2jnfZEAIT4zD7j
R85tR4497HiUfasdpF7QdcWqaaRuPVQoijJsI2N+aGPo/m1R0reqfgbO461qQGif
1A511wTt4s3O90ARo8d0fhoYd8YR+oGZP1Zs3lRGHktjXrRM8KIlZJAPYZxLWoBp
AS16IHKWvZtPs8gqJbgagyhpGUU5tw6xmwFW2dHPXeR3JuOw98Q=
=8lMD
-----END PGP SIGNATURE-----
--=-=-=--
