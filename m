Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeCNLyS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 07:54:18 -0400
Received: from smtprelay0059.hostedemail.com ([216.40.44.59]:37890 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750964AbeCNLyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 07:54:17 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,shea@shealevy.com,:::::::::::::,RULES_HIT:2:41:334:355:368:369:379:599:800:871:960:967:968:973:981:988:989:1000:1260:1263:1313:1314:1345:1359:1437:1516:1518:1535:1575:1605:1606:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2692:2693:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4118:4184:4250:4321:4605:5007:6117:6119:6261:6506:6747:7281:7514:7875:7903:7909:7974:8660:9025:9036:9388:10004:10049:10848:11026:11232:11473:11658:11914:12043:12291:12555:12663:12683:12740:12776:12895:12926:13148:13230:14096:14106:14107:21060:21063:21080:21325:21433:21451:21627:21740:30003:30012:30036:30054:30070:30089:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: vein06_42520fe56462c
X-Filterd-Recvd-Size: 7807
From: Shea Levy <shea@shealevy.com>
To: Palmer Dabbelt <palmer@sifive.com>, zongbox@gmail.com
Cc: zong@andestech.com, albert@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, greentime@andestech.com
Subject: Re: [PATCH 00/11] RISC-V: Resolve the issue of loadable module on 64-bit
In-Reply-To: <mhng-bb15ab0a-464a-4baf-bd4c-e8c409722351@palmer-si-x1c4>
References: <mhng-bb15ab0a-464a-4baf-bd4c-e8c409722351@palmer-si-x1c4>
Date: Wed, 14 Mar 2018 07:54:14 -0400
Message-ID: <87o9jqzxcp.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Palmer Dabbelt <palmer@sifive.com> writes:

> On Tue, 13 Mar 2018 18:34:19 PDT (-0700), zongbox@gmail.com wrote:
>> 2018-03-14 5:30 GMT+08:00 Shea Levy <shea@shealevy.com>:
>>> Hi Palmer,
>>>
>>> Palmer Dabbelt <palmer@sifive.com> writes:
>>>
>>>> On Tue, 13 Mar 2018 01:35:05 PDT (-0700), zong@andestech.com wrote:
>>>>> These patches resolve the some issues of loadable module.
>>>>>   - symbol out of ranges
>>>>>   - unknown relocation types
>>>>>
>>>>> The reference of external variable and function symbols
>>>>> cannot exceed 32-bit offset ranges in kernel module.
>>>>> The module only can work on the 32-bit OS or the 64-bit
>>>>> OS with sv32 virtual addressing.
>>>>>
>>>>> These patches will generate the .got, .got.plt and
>>>>> .plt sections during loading module, let it can refer
>>>>> to the symbol which locate more than 32-bit offset.
>>>>> These sections depend on the relocation types:
>>>>>  - R_RISCV_GOT_HI20
>>>>>  - R_RISCV_CALL_PLT
>>>>>
>>>>> These patches also support more relocation types
>>>>>  - R_RISCV_CALL
>>>>>  - R_RISCV_HI20
>>>>>  - R_RISCV_LO12_I
>>>>>  - R_RISCV_LO12_S
>>>>>  - R_RISCV_RVC_BRANCH
>>>>>  - R_RISCV_RVC_JUMP
>>>>>  - R_RISCV_ALIGN
>>>>>  - R_RISCV_ADD32
>>>>>  - R_RISCV_SUB32
>>>>>
>>>>> Zong Li (11):
>>>>>   RISC-V: Add sections of PLT and GOT for kernel module
>>>>>   RISC-V: Add section of GOT.PLT for kernel module
>>>>>   RISC-V: Support GOT_HI20/CALL_PLT relocation type in kernel module
>>>>>   RISC-V: Support CALL relocation type in kernel module
>>>>>   RISC-V: Support HI20/LO12_I/LO12_S relocation type in kernel module
>>>>>   RISC-V: Support RVC_BRANCH/JUMP relocation type in kernel modulewq
>>>>>   RISC-V: Support ALIGN relocation type in kernel module
>>>>>   RISC-V: Support ADD32 relocation type in kernel module
>>>>>   RISC-V: Support SUB32 relocation type in kernel module
>>>>>   RISC-V: Enable module support in defconfig
>>>>>   RISC-V: Add definition of relocation types
>>>>>
>>>>>  arch/riscv/Kconfig                  |   5 ++
>>>>>  arch/riscv/Makefile                 |   3 +
>>>>>  arch/riscv/configs/defconfig        |   2 +
>>>>>  arch/riscv/include/asm/module.h     | 112 +++++++++++++++++++++++
>>>>>  arch/riscv/include/uapi/asm/elf.h   |  24 +++++
>>>>>  arch/riscv/kernel/Makefile          |   1 +
>>>>>  arch/riscv/kernel/module-sections.c | 156 ++++++++++++++++++++++++++++++++
>>>>>  arch/riscv/kernel/module.c          | 175 ++++++++++++++++++++++++++++++++++--
>>>>>  arch/riscv/kernel/module.lds        |   8 ++
>>>>>  9 files changed, 480 insertions(+), 6 deletions(-)
>>>>>  create mode 100644 arch/riscv/include/asm/module.h
>>>>>  create mode 100644 arch/riscv/kernel/module-sections.c
>>>>>  create mode 100644 arch/riscv/kernel/module.lds
>>>>
>>>> This is the second set of patches that turn on modules, and it has the same
>>>> R_RISCV_ALIGN problem as the other one
>>>>
>>>>     http://lists.infradead.org/pipermail/linux-riscv/2018-February/000081.html
>>>>
>>>> It looks like this one uses shared libraries for modules instead of static
>>>> objects.  I think using shared objects is the right thing to do, as it'll allow
>>>> us to place modules anywhere in the address space by having multiple GOTs and
>>>> PLTs.
>>>
>>> Can you expand on this? It was my understanding that outside of the
>>> context of multiple address spaces sharing code the GOT and PLT were
>>> simply unnecessary overhead, what benefit would they bring here?
>>>
>>>> That's kind of complicated, though, so we can start with something
>>>> simpler like this.
>>
>> Hi,
>>
>> The kernel module is a object file, it is not be linked by linker, the
>> GOT and PLT
>> sections will not be generated through -fPIC option, but it will
>> generate the relative
>> relocation type. As Palmer mention before, If we have GOT and PLT sections,
>> we can put the module anywhere, even we support the KASLR in the kernel.
>
> Sorry, I guess I meant PIC objects not shared objects (I keep forgetting about
> PIE).  We'll probably eventually add large code model targets, but they might
> end up just being functionally equilivant to PIE with multi-GOT and multi-PLT
> so it might not matter.
>
> Either way, this is the sanest way to do it for now.
>
>> For the ALIGN problem, the kernel module loader is difficult to remove
>> or migrate
>> the module's code like relax doing, so the remnant nop instructions harm the
>> performance,  I agree the point that adding the mno-relax option and checking
>> the alignment in ALIGN type in module loader.
>
> Sounds good.  I just merged the mno-relax stuff, it'll show up when I get
> around to generating a 7.3.0 backport branch.  For now I think you should just
> fail on R_RISCV_ALIGN and attempt to pass -mno-relax to the compiler (via
> something like "$(call cc-option,-mno-relax)", like we do for
> "-mstrict-align").  I don't think it's worth handling R_RISCV_ALIGN in the
> kernel, as that's essentially the same as full relaxation support.
>

Should we unconditionally fail on R_RISCV_ALIGN or only if the code
isn't already aligned?

>
>>>> That's kind of complicated, though, so we can start with something
>>>> simpler like this.
>>
>> So what is the suggestion for that.
>
> Well, I'm not really sure -- essentially the idea of proper multi-GOT and
> multi-PLT support would be to merge the GOTs and PLTs of modules together when
> they're within range of each other.  We haven't even figured this out in
> userspace yet, so it's probably not worth attempting for kernel modules for a
> bit.
>
> If I understand your code correctly, you're currently generating one GOT and
> one PLT per loaded module.  If that's the case, then this is correct, it's just
> possible to save some memory by merging these tables.  It's probably not worth
> the complexity for kernel modules for a while.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlqpDWYACgkQXAvWlX2G
/ich6w/9HcGSrZsWhkdxR48amrzAD6eyO8aMgHBTLGWjamXAmsvpnC/7RvMdZN6x
xDdP27u34kvENZSmGFMivnnKHm/6KOKfgFu36VDQLv6iNe20j+xqZQLNpvyQktMb
18aodfMS9VYiVQ9czr6hwyi5Rg3cyA5oY7Dol1NVr/OcMAIUR3twBiaa74nUvs4Z
pPH7KsCPDK+qv8VdIlo4H1kHT6AMRv3D+0s2jsPvhRA0ub3SCMFzq00jlg+NFqp7
Tc9rNjyxm/uC3Ka8GsSRW6KdAR3in/k2+0pN924Hnpp9ydUnG3V3ME17HYd4GygO
SCxMNK8vQPUmoqkxAe3QzwPJXa4UTwmMw+NEC6Gv9A9JDWD8fdVGr3JcLxGQca5U
0Knu7T0iGWLtq1Odcb1nfiSmrgIrd+K8o9CToPIUAY6IkeS5ZGzeUuxAcQO7JEX9
h4GavuDTEvL4CZEWXd1BJegnqrjBYKPuixLK9T4bFOoCk6TgAG3gqAg8fAIim+sz
ON4z7Mdig9frnnDJs1O5sUYYDvboSU/SOPKy/WZ4K2hYIwYF25fmi0MRou18EOZW
yMbjW7FAly42a1baqiWwUdAEX2vAgPPZcIz+uh6lKcOv3C0xCpVT0TF0ZG2vfQ+K
gklWlAq6o1F/isKxZ9UyQSAXwqFdyRtvU1tc7Pu9bJeYTQkmAvQ=
=iXhw
-----END PGP SIGNATURE-----
--=-=-=--
