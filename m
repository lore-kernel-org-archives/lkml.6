Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbeCNL4P (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 07:56:15 -0400
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:38130 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751015AbeCNL4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 07:56:14 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,shea@shealevy.com,:::::::::::::,RULES_HIT:2:41:196:334:355:368:369:379:599:800:871:960:967:968:973:981:988:989:1000:1260:1263:1313:1314:1345:1359:1437:1516:1518:1535:1575:1605:1622:1730:1747:1777:1792:2198:2199:2393:2525:2553:2560:2564:2682:2685:2692:2693:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4050:4120:4184:4250:4321:4605:5007:6117:6119:6261:6506:6671:6747:7281:7514:7875:7903:7909:7974:8660:9010:9025:9036:9388:10004:10049:10848:11026:11232:11473:11658:11914:12043:12050:12291:12555:12683:12740:12776:12895:12926:12986:13007:13148:13230:14106:14107:21060:21063:21080:21325:21433:21451:21611:21627:21740:30003:30012:30036:30054:30060:30070:30083:30089:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:non
X-HE-Tag: eyes20_5343a36f69d4f
X-Filterd-Recvd-Size: 9066
From: Shea Levy <shea@shealevy.com>
To: Zong Li <zongbox@gmail.com>, Palmer Dabbelt <palmer@sifive.com>
Cc: Zong Li <zong@andestech.com>, albert@sifive.com,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greentime@andestech.com
Subject: Re: [PATCH 00/11] RISC-V: Resolve the issue of loadable module on 64-bit
In-Reply-To: <CA+ZOyajM8k8+o4Y4DL5z4VE7SoMW2SqzpuPyNAd7dn8smsdsfQ@mail.gmail.com>
References: <CA+ZOyagHPWNw6uLAGri0cQph06MmspMjUZC--YBe8HRBA2Cd5g@mail.gmail.com> <mhng-bb15ab0a-464a-4baf-bd4c-e8c409722351@palmer-si-x1c4> <CA+ZOyajM8k8+o4Y4DL5z4VE7SoMW2SqzpuPyNAd7dn8smsdsfQ@mail.gmail.com>
Date: Wed, 14 Mar 2018 07:56:10 -0400
Message-ID: <87lgeuzx9h.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Zong Li <zongbox@gmail.com> writes:

> 2018-03-14 11:07 GMT+08:00 Palmer Dabbelt <palmer@sifive.com>:
>> On Tue, 13 Mar 2018 18:34:19 PDT (-0700), zongbox@gmail.com wrote:
>>>
>>> 2018-03-14 5:30 GMT+08:00 Shea Levy <shea@shealevy.com>:
>>>>
>>>> Hi Palmer,
>>>>
>>>> Palmer Dabbelt <palmer@sifive.com> writes:
>>>>
>>>>> On Tue, 13 Mar 2018 01:35:05 PDT (-0700), zong@andestech.com wrote:
>>>>>>
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
>>>>>>  arch/riscv/kernel/module-sections.c | 156
>>>>>> ++++++++++++++++++++++++++++++++
>>>>>>  arch/riscv/kernel/module.c          | 175
>>>>>> ++++++++++++++++++++++++++++++++++--
>>>>>>  arch/riscv/kernel/module.lds        |   8 ++
>>>>>>  9 files changed, 480 insertions(+), 6 deletions(-)
>>>>>>  create mode 100644 arch/riscv/include/asm/module.h
>>>>>>  create mode 100644 arch/riscv/kernel/module-sections.c
>>>>>>  create mode 100644 arch/riscv/kernel/module.lds
>>>>>
>>>>>
>>>>> This is the second set of patches that turn on modules, and it has the
>>>>> same
>>>>> R_RISCV_ALIGN problem as the other one
>>>>>
>>>>>
>>>>> http://lists.infradead.org/pipermail/linux-riscv/2018-February/000081.html
>>>>>
>>>>> It looks like this one uses shared libraries for modules instead of
>>>>> static
>>>>> objects.  I think using shared objects is the right thing to do, as
>>>>> it'll allow
>>>>> us to place modules anywhere in the address space by having multiple
>>>>> GOTs and
>>>>> PLTs.
>>>>
>>>>
>>>> Can you expand on this? It was my understanding that outside of the
>>>> context of multiple address spaces sharing code the GOT and PLT were
>>>> simply unnecessary overhead, what benefit would they bring here?
>>>>
>>>>> That's kind of complicated, though, so we can start with something
>>>>> simpler like this.
>>>
>>>
>>> Hi,
>>>
>>> The kernel module is a object file, it is not be linked by linker, the
>>> GOT and PLT
>>> sections will not be generated through -fPIC option, but it will
>>> generate the relative
>>> relocation type. As Palmer mention before, If we have GOT and PLT
>>> sections,
>>> we can put the module anywhere, even we support the KASLR in the kernel.
>>
>>
>> Sorry, I guess I meant PIC objects not shared objects (I keep forgetting
>> about
>> PIE).  We'll probably eventually add large code model targets, but they
>> might
>> end up just being functionally equilivant to PIE with multi-GOT and
>> multi-PLT
>> so it might not matter.
>>
>> Either way, this is the sanest way to do it for now.
>
> Actually, I try to use the large code model and without PIC before.
> (The compiler with mcmodel=large obtain from my colleague development)
> On this compiler version, the `-mcmodel=large` uses the constant pool
> mechanism to
> puts the addresses of data symbols at the function tail. It can resolve
> the reference about out of range of data symbol, but this code generation not
> apply to function call. For the compiler code generation and no linker to do
> relax reason, kernel module still needs the PLT section to jump to far target.
> On the other hand, the ARM64 mailing list has the patches to remove
> the large code model for cache performance.
>
> https://marc.info/?l=linux-arm-kernel&m=151860828416766
>
> so maybe we can use the `medany + fPIC` for now.
>
>>> For the ALIGN problem, the kernel module loader is difficult to remove
>>> or migrate
>>> the module's code like relax doing, so the remnant nop instructions harm
>>> the
>>> performance,  I agree the point that adding the mno-relax option and
>>> checking
>>> the alignment in ALIGN type in module loader.
>>
>>
>> Sounds good.  I just merged the mno-relax stuff, it'll show up when I get
>> around to generating a 7.3.0 backport branch.  For now I think you should
>> just
>> fail on R_RISCV_ALIGN and attempt to pass -mno-relax to the compiler (via
>> something like "$(call cc-option,-mno-relax)", like we do for
>> "-mstrict-align").  I don't think it's worth handling R_RISCV_ALIGN in the
>> kernel, as that's essentially the same as full relaxation support.
>
> OK. I will send the v2 patches with the modification as you mention about
> R_RISCV_ALIGN type?

Just to avoid work duplication, do you think you'll get to this before
this weekend? I was planning on bringing my patches up-to-date then, but
since we're going the PIC route I can base my no-relax/ALIGN support on
top of your series instead.

>
>> If I understand your code correctly, you're currently generating one GOT and
>> one PLT per loaded module.  If that's the case, then this is correct, it's
>> just
>> possible to save some memory by merging these tables.  It's probably not
>> worth
>> the complexity for kernel modules for a while.
>
> Yes, there are one GOT and one PLT per loaded module.
> In the [PATCH 02/11], I generate the third section .got.plt for saving
> more memory of
> each PLT entry.
>
> Thanks a lot.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlqpDdoACgkQXAvWlX2G
/id4cw/+JD2bQkzk3QuhNnEwCy+J6NWzL0HOB/Miae4TbIvPpmBzfE+8EgVS4c28
9+BfmT01n1SKei/1vo1lNXboigLfsMDZBfHfU8yZLdXg1jYDL18p1GnilVf1ejbu
W5+P9ACYG4A+5FOKUjO2fCx7lQ027o7pxzzIykdqF5LFtTqvKtr1erLvRkgOvMGu
G6Ysj2724U9w/PDMBMHfPcLRLGn8jZdfwDuK6t4XK6pHdXn53PY+xKou1OgR7dBs
QcHsyVKnDU5OkK1oFG7gorTzcgXCGQvhGESFj9qjCOyDokjzkBD7BHTtfxzRjKNF
NZW76tsC5KnO3D+PLGPEvq4UPpgzWquiLU9UplnrlNnTRuG53noUfH+68m5tVI6y
QDEEamY5y/g4NZ9zWlPnEJJ3WiJNdNbMwOSkFIydjWYRTVSaN4FZKoIDRhRDDO0d
gJwOoogDdb2vsYghDlb0cEJ7Lfy+Wf/Ck6YdJ/mK8YIykTtthNd6wPj5Cfk2nkyR
tXMTue5NBA2zF8kZnxwixVAkLGCgkzJPc0bwYNpoAeyqxLe+AU0HEN/0lE1l4+99
uYCS2/ubeJp8lopXqgPNh1hIcyJByITxN67VvGJDseRbKkQnKRIJnCJFWc5aad6n
kxnUwHQ6BDvFXDPhfUZXiDm9xU5DjjMCGzQSLCgK3cNmIoRumMk=
=8VjR
-----END PGP SIGNATURE-----
--=-=-=--
