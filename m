Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B274C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CA32077C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hJIfCbrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CA32077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbeJHMyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 08:54:22 -0400
Received: from ozlabs.org ([203.11.71.1]:45315 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbeJHMyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 08:54:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42T8SM2Xn7z9s55;
        Mon,  8 Oct 2018 16:44:19 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538977461;
        bh=ENTtqcjNUAzWc6H3uYBHYKOz5l9F0sxYkAwqwUuzF3A=;
        h=Date:From:To:Cc:Subject:From;
        b=hJIfCbrYqfXSvn+hMB6vT18vjAJLbi0p/lRVM0QNWBnPXAK14lCITDlxCEiyGlf1Q
         THhSOGO4/4vAI1R/UDSGulIKOrjhZT4VkLpsIGMMjAIivAWvKTNvdy9GQwREtHj4Mq
         hF3aXmpqEL6ls/VdK4DFw3wViiZeqtZ0l+kbycM5X7PSy8l3lPLTlZOf0wf16e0Q7M
         bEe5YobgU9Khnt4pF186tEf9X8VcUxHKQwWJtQk/jCj9YbYSF9GYNRv7Tv1C8S9UKZ
         ArA2GVERWguVqLwfCrjZAGlHoGk2PrcIWhJBpgtrOfIYo5gpWmTtgOlpyUYz29palI
         FgJ3edo2mqOEg==
Date:   Mon, 8 Oct 2018 16:44:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Alexander Popov <alex.popov@linux.com>
Subject: linux-next: manual merge of the kspp tree with the tip tree
Message-ID: <20181008164418.162fc0c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xWXR/elkoUK5QCDXCRLmyyd"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xWXR/elkoUK5QCDXCRLmyyd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kspp tree got a conflict in:

  Documentation/x86/x86_64/mm.txt

between commits:

  5b1290406579 ("x86/mm/doc: Clean up the x86-64 virtual memory layout desc=
riptions")
  32b89760ddf4 ("x86/mm/doc: Enhance the x86-64 virtual memory layout descr=
iptions")

from the tip tree and commit:

  afaef01c0015 ("x86/entry: Add STACKLEAK erasing the kernel stack at the e=
nd of syscalls")

from the kspp tree.

I fixed it up (see below - could probably be done better) and can carry
the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/x86/x86_64/mm.txt
index 702898633b00,600bc2afa27d..000000000000
--- a/Documentation/x86/x86_64/mm.txt
+++ b/Documentation/x86/x86_64/mm.txt
@@@ -1,124 -1,57 +1,126 @@@
 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
 +Complete virtual memory map with 4-level page tables
 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
 =20
 -Virtual memory map with 4 level page tables:
 -
 -0000000000000000 - 00007fffffffffff (=3D47 bits) user space, different pe=
r mm
 -hole caused by [47:63] sign extension
 -ffff800000000000 - ffff87ffffffffff (=3D43 bits) guard hole, reserved for=
 hypervisor
 -ffff880000000000 - ffffc7ffffffffff (=3D64 TB) direct mapping of all phys=
. memory
 -ffffc80000000000 - ffffc8ffffffffff (=3D40 bits) hole
 -ffffc90000000000 - ffffe8ffffffffff (=3D45 bits) vmalloc/ioremap space
 -ffffe90000000000 - ffffe9ffffffffff (=3D40 bits) hole
 -ffffea0000000000 - ffffeaffffffffff (=3D40 bits) virtual memory map (1TB)
 -... unused hole ...
 -ffffec0000000000 - fffffbffffffffff (=3D44 bits) kasan shadow memory (16T=
B)
 -... unused hole ...
 -				    vaddr_end for KASLR
 -fffffe0000000000 - fffffe7fffffffff (=3D39 bits) cpu_entry_area mapping
 -fffffe8000000000 - fffffeffffffffff (=3D39 bits) LDT remap for PTI
 -ffffff0000000000 - ffffff7fffffffff (=3D39 bits) %esp fixup stacks
 -... unused hole ...
 -ffffffef00000000 - fffffffeffffffff (=3D64 GB) EFI region mapping space
 -... unused hole ...
 -ffffffff80000000 - ffffffff9fffffff (=3D512 MB)  kernel text mapping, fro=
m phys 0
 -ffffffffa0000000 - fffffffffeffffff (1520 MB) module mapping space
 -[fixmap start]   - ffffffffff5fffff kernel-internal fixmap range
 -ffffffffff600000 - ffffffffff600fff (=3D4 kB) legacy vsyscall ABI
 -ffffffffffe00000 - ffffffffffffffff (=3D2 MB) unused hole
 +Notes:
 +
 + - Negative addresses such as "-23 TB" are absolute addresses in bytes, c=
ounted down
 +   from the top of the 64-bit address space. It's easier to understand th=
e layout
 +   when seen both in absolute addresses and in distance-from-top notation.
 +
 +   For example 0xffffe90000000000 =3D=3D -23 TB, it's 23 TB lower than th=
e top of the
 +   64-bit address space (ffffffffffffffff).
 +
 +   Note that as we get closer to the top of the address space, the notati=
on changes
 +   from TB to GB and then MB/KB.
 +
 + - "16M TB" might look weird at first sight, but it's an easier to visual=
ize size
 +   notation than "16 EB", which few will recognize at first sight as 16 e=
xabytes.
 +   It also shows it nicely how incredibly large 64-bit address space is.
 +
 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 +    Start addr    |   Offset   |     End addr     |  Size   | VM area des=
cription
 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 +                  |            |                  |         |
 + 0000000000000000 |    0       | 00007fffffffffff |  128 TB | user-space =
virtual memory, different per mm
 +__________________|____________|__________________|_________|____________=
_______________________________________________
 +                  |            |                  |         |
 + 0000800000000000 | +128    TB | ffff7fffffffffff | ~16M TB | ... huge, a=
lmost 64 bits wide hole of non-canonical
 +                  |            |                  |         |     virtual=
 memory addresses up to the -128 TB
 +                  |            |                  |         |     startin=
g offset of kernel mappings.
 +__________________|____________|__________________|_________|____________=
_______________________________________________
 +                                                            |
 +                                                            | Kernel-spac=
e virtual memory, shared between all processes:
 +____________________________________________________________|____________=
_______________________________________________
 +                  |            |                  |         |
 + ffff800000000000 | -128    TB | ffff87ffffffffff |    8 TB | ... guard h=
ole, also reserved for hypervisor
 + ffff880000000000 | -120    TB | ffffc7ffffffffff |   64 TB | direct mapp=
ing of all physical memory (page_offset_base)
 + ffffc80000000000 |  -56    TB | ffffc8ffffffffff |    1 TB | ... unused =
hole
 + ffffc90000000000 |  -55    TB | ffffe8ffffffffff |   32 TB | vmalloc/ior=
emap space (vmalloc_base)
 + ffffe90000000000 |  -23    TB | ffffe9ffffffffff |    1 TB | ... unused =
hole
 + ffffea0000000000 |  -22    TB | ffffeaffffffffff |    1 TB | virtual mem=
ory map (vmemmap_base)
 + ffffeb0000000000 |  -21    TB | ffffebffffffffff |    1 TB | ... unused =
hole
 + ffffec0000000000 |  -20    TB | fffffbffffffffff |   16 TB | KASAN shado=
w memory
 + fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused =
hole
 +                  |            |                  |         | vaddr_end f=
or KASLR
 + fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_a=
rea mapping
 + fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | LDT remap f=
or PTI
 + ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup =
stacks
 +__________________|____________|__________________|_________|____________=
________________________________________________
 +                                                            |
 +                                                            | Identical l=
ayout to the 47-bit one from here on:
 +____________________________________________________________|____________=
________________________________________________
 +                  |            |                  |         |
 + ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused =
hole
 + ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region =
mapping space
 + ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused =
hole
 + ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text=
 mapping, mapped to physical address 0
 + ffffffff80000000 |-2048    MB |                  |         |
 + ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapp=
ing space
 + ffffffffff000000 |  -16    MB |                  |         |
 +    FIXADDR_START | ~-11    MB | ffffffffff5fffff | ~0.5 MB | kernel-inte=
rnal fixmap range, variable size and offset
 + ffffffffff600000 |  -10    MB | ffffffffff600fff |    4 kB | legacy vsys=
call ABI
 + ffffffffffe00000 |   -2    MB | ffffffffffffffff |    2 MB | ... unused =
hole
 +__________________|____________|__________________|_________|____________=
_______________________________________________
+ STACKLEAK_POISON value in this last hole: ffffffffffff4111
 =20
 -Virtual memory map with 5 level page tables:
 -
 -0000000000000000 - 00ffffffffffffff (=3D56 bits) user space, different pe=
r mm
 -hole caused by [56:63] sign extension
 -ff00000000000000 - ff0fffffffffffff (=3D52 bits) guard hole, reserved for=
 hypervisor
 -ff10000000000000 - ff8fffffffffffff (=3D55 bits) direct mapping of all ph=
ys. memory
 -ff90000000000000 - ff9fffffffffffff (=3D52 bits) LDT remap for PTI
 -ffa0000000000000 - ffd1ffffffffffff (=3D54 bits) vmalloc/ioremap space (1=
2800 TB)
 -ffd2000000000000 - ffd3ffffffffffff (=3D49 bits) hole
 -ffd4000000000000 - ffd5ffffffffffff (=3D49 bits) virtual memory map (512T=
B)
 -... unused hole ...
 -ffdf000000000000 - fffffc0000000000 (=3D53 bits) kasan shadow memory (8PB)
 -... unused hole ...
 -				    vaddr_end for KASLR
 -fffffe0000000000 - fffffe7fffffffff (=3D39 bits) cpu_entry_area mapping
 -... unused hole ...
 -ffffff0000000000 - ffffff7fffffffff (=3D39 bits) %esp fixup stacks
 -... unused hole ...
 -ffffffef00000000 - fffffffeffffffff (=3D64 GB) EFI region mapping space
 -... unused hole ...
 -ffffffff80000000 - ffffffff9fffffff (=3D512 MB)  kernel text mapping, fro=
m phys 0
 -ffffffffa0000000 - fffffffffeffffff (1520 MB) module mapping space
 -[fixmap start]   - ffffffffff5fffff kernel-internal fixmap range
 -ffffffffff600000 - ffffffffff600fff (=3D4 kB) legacy vsyscall ABI
 -ffffffffffe00000 - ffffffffffffffff (=3D2 MB) unused hole
 +
 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
 +Complete virtual memory map with 5-level page tables
 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
 +
 +Notes:
 +
 + - With 56-bit addresses, user-space memory gets expanded by a factor of =
512x,
 +   from 0.125 PB to 64 PB. All kernel mappings shift down to the -64 PT s=
tarting
 +   offset and many of the regions expand to support the much larger physi=
cal
 +   memory supported.
 +
 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 +    Start addr    |   Offset   |     End addr     |  Size   | VM area des=
cription
 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 +                  |            |                  |         |
 + 0000000000000000 |    0       | 00ffffffffffffff |   64 PB | user-space =
virtual memory, different per mm
 +__________________|____________|__________________|_________|____________=
_______________________________________________
 +                  |            |                  |         |
 + 0000800000000000 |  +64    PB | ffff7fffffffffff | ~16K PB | ... huge, s=
till almost 64 bits wide hole of non-canonical
 +                  |            |                  |         |     virtual=
 memory addresses up to the -128 TB
 +                  |            |                  |         |     startin=
g offset of kernel mappings.
 +__________________|____________|__________________|_________|____________=
_______________________________________________
 +                                                            |
 +                                                            | Kernel-spac=
e virtual memory, shared between all processes:
 +____________________________________________________________|____________=
_______________________________________________
 +                  |            |                  |         |
 + ff00000000000000 |  -64    PB | ff0fffffffffffff |    4 PB | ... guard h=
ole, also reserved for hypervisor
 + ff10000000000000 |  -60    PB | ff8fffffffffffff |   32 PB | direct mapp=
ing of all physical memory (page_offset_base)
 + ff90000000000000 |  -28    PB | ff9fffffffffffff |    4 PB | LDT remap f=
or PTI
 + ffa0000000000000 |  -24    PB | ffd1ffffffffffff | 12.5 PB | vmalloc/ior=
emap space (vmalloc_base)
 + ffd2000000000000 |  -11.5  PB | ffd3ffffffffffff |  0.5 PB | ... unused =
hole
 + ffd4000000000000 |  -11    PB | ffd5ffffffffffff |  0.5 PB | virtual mem=
ory map (vmemmap_base)
 + ffd6000000000000 |  -10.5  PB | ffdeffffffffffff | 2.25 PB | ... unused =
hole
 + ffdf000000000000 |   -8.25 PB | fffffdffffffffff |   ~8 PB | KASAN shado=
w memory
 + fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused =
hole
 +                  |            |                  |         | vaddr_end f=
or KASLR
 + fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_a=
rea mapping
 + fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | ... unused =
hole
 + ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup =
stacks
 +__________________|____________|__________________|_________|____________=
________________________________________________
 +                                                            |
 +                                                            | Identical l=
ayout to the 47-bit one from here on:
 +____________________________________________________________|____________=
________________________________________________
 +                  |            |                  |         |
 + ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused =
hole
 + ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region =
mapping space
 + ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused =
hole
 + ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text=
 mapping, mapped to physical address 0
 + ffffffff80000000 |-2048    MB |                  |         |
 + ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapp=
ing space
 + ffffffffff000000 |  -16    MB |                  |         |
 +    FIXADDR_START | ~-11    MB | ffffffffff5fffff | ~0.5 MB | kernel-inte=
rnal fixmap range, variable size and offset
 + ffffffffff600000 |  -10    MB | ffffffffff600fff |    4 kB | legacy vsys=
call ABI
 + ffffffffffe00000 |   -2    MB | ffffffffffffffff |    2 MB | ... unused =
hole
 +__________________|____________|__________________|_________|____________=
_______________________________________________
+ STACKLEAK_POISON value in this last hole: ffffffffffff4111
 =20
  Architecture defines a 64-bit virtual address. Implementations can support
  less. Currently supported are 48- and 57-bit virtual addresses. Bits 63

--Sig_/xWXR/elkoUK5QCDXCRLmyyd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu67rIACgkQAVBC80lX
0GyENgf/Qtkyoy63bWwmt05oi8oq8k3/IwqFrkGEVg67wXTsKIFnqYdcKfAEQcLz
A/TEqnVQzhmJ7yzh5OCQJAtSqLGOYsX7fDdc2uk2335XGxkqBgbcwWXYgAKNBtrE
nUjL1u0qm7jqQVYxAiAwLZ1OXjl9Dpo4RD2mEslGKhBCoXPVkzL9dl+BvLReHIVy
iUTo+Lz+SxdbXUIGYkSwxhp/UIDfPdvRVfUzsIphR0+l1Ngs77Ob6mXGKEWE/bQo
y0dqYMEcErjY13RD8uODYWCk+MQXmz/6kTv9/jQhXYQyHUGYnvF2xe/FhdzbW2Gz
QV8KYNEl+dXEM8Tr6Cf6f7eMLU1cCQ==
=DuD7
-----END PGP SIGNATURE-----

--Sig_/xWXR/elkoUK5QCDXCRLmyyd--
