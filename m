Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15397C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAEE20838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="tPBtQ/tK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfBUOfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:35:45 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:33469 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUOfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:35:44 -0500
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x1LEZITS016105;
        Thu, 21 Feb 2019 23:35:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x1LEZITS016105
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550759720;
        bh=sYB6kQmooR6C1jKUrdaHy0ETJuYDxi3haI1gR5eB8Y4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tPBtQ/tK1Rhc9wvVZKGrSWewJBbPUFY094b+GQg/kfsqTnqbACtlvY74Y8+yP+QIU
         8vTOSYVPKH1b7mim9OcBLYHAqp9J20yWGKFdybZkpbzvWufwyyTX7nJWzAhLyH2OoQ
         NUMsKRCwcroHCtcmy5QSxJc/C1Vk+/xeboBeDCtRPYngRRKgUtZKhhoxgcrMSZ3KBY
         eDjiHDZcjm3dAZnc5JPy5LLkWRHxDNzkL3g0Kt7XCRuQMf8MA4v81nTIhUk7/CZt8V
         mCoKnJdtRORpS06v7+vz0dHFMlf6YR5Xz2+kFPbsfl81/P1nKX4GL/3GVyq7W3KXmp
         xt5ekfyqUKYqA==
X-Nifty-SrcIP: [209.85.221.169]
Received: by mail-vk1-f169.google.com with SMTP id k64so1240693vke.1;
        Thu, 21 Feb 2019 06:35:19 -0800 (PST)
X-Gm-Message-State: AHQUAuaOLfgOufDD3v7GIbV1QzcdDw8QE036TdnRw53b+IiezG4gVARc
        Nf4dc32NTqjQ9Bddi1ta+IkPsi5ZCWx0ZKa5Dv8=
X-Google-Smtp-Source: AHgI3IZ7WpT/03GOkiWOWUMXhEKZoFECQAjV/SpUc+I8GXlZ4FhDB++3dznHcBJmSbYBRfpohpohacPYdg0X8WLzhqk=
X-Received: by 2002:a67:f107:: with SMTP id n7mr4445728vsk.54.1550759718322;
 Thu, 21 Feb 2019 06:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20190211143600.15021-1-joel@joelfernandes.org>
 <20190215031926.ljzluy2cfxp64u6o@ast-mbp> <CAK7LNAThSm1n1B_Ss0gRDZ3H-DWj2bvpZ+6Ui2jEo4Pt9YynEA@mail.gmail.com>
 <CAK7LNATf4adEEqWko2YO46wHHi-Vvc+_LBjQGNnM7rt8GSOgZQ@mail.gmail.com> <20190219151652.GA110907@google.com>
In-Reply-To: <20190219151652.GA110907@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 21 Feb 2019 23:34:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ7GqCNc008ZZ4K0_BdTVMdwwVUgnfqBO-kDBmw4ikr3w@mail.gmail.com>
Message-ID: <CAK7LNAQ7GqCNc008ZZ4K0_BdTVMdwwVUgnfqBO-kDBmw4ikr3w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        atish patra <atishp04@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 12:17 AM Joel Fernandes <joel@joelfernandes.org> wr=
ote:

>
> Firstly, I want to apologize for not testing this and other corner cases =
you
> brought up. I should have known better. Since my build was working, I ass=
umed
> that the feature is working. For that, I am very sorry.


You do not need to apologize. 0day bot usually catches build errors.
I guess 0day bot performs compile-tests only incrementally
and that is why we did not get any report.



> Secondly, it turns out Module.symvers circularly dependency problem also
> exists with another use case.
> If one does 'make modules_prepare' in a base kernel tree and then tries t=
o
> build modules with that tree, a warning like this is printed but the modu=
le
> still gets built:
>
>   WARNING: Symbol version dump ./Module.symvers
>            is missing; modules will have no dependencies and modversions.
>
>   CC [M]  /tmp/testmod/test.o
>   Building modules, stage 2.
>   MODPOST 1 modules
>   CC      /tmp/testmod/test.mod.o
>   LD [M]  /tmp/testmod/test.ko
>
> So, I am thinking that at least for first pass I will just drop the inclu=
sion
> of Module.symvers in the archive and allow any modules built using
> /proc/kheaders.tar.xz to not use it.
>
> Kbuild will print a warning anyway when anyone tries to build using
> /proc/kheaders.tar.xz, so if the user really wants module symbol versioni=
ng
> then they should probably use a full kernel source tree with Module.symve=
rs
> available. For our usecase, kernel symbol versioning is a bit useless whe=
n
> using /proc/kheaders.tar.gz because the proc file is generated with the s=
ame
> kernel that the module is being built against, and subsequently loaded in=
to
> the kernel. So it is not likely that the CRC of a kernel symbol will be
> different from what the module expects.


Without Module.symver, modpost cannot check whether references are
resolvable or not.

You will see "WARNING ... undefined" for every symbol referenced from
the module.


I am not an Android developer.
So, I will leave this judge to other people.




One more request if you have a chance to submit the next version.
Please do not hide error messages.

I wondered why you redirected stdout/stderr from the script.

I applied the following patch, and I tested.  Then I see why.

Please fix your code instead of hiding underlying problems.


diff --git a/kernel/Makefile b/kernel/Makefile
index 1d13a7a..a76ccbd 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -148,7 +148,7 @@ $(obj)/kheaders.o: $(obj)/kheaders_data.h
 targets +=3D kheaders_data.txz

 quiet_cmd_genikh =3D GEN     $(obj)/kheaders_data.txz
-cmd_genikh =3D $(srctree)/scripts/gen_ikh_data.sh $@ $^ >/dev/null 2>&1
+cmd_genikh =3D $(srctree)/scripts/gen_ikh_data.sh $@ $^
 $(obj)/kheaders_data.txz: $(ikh_file_list) FORCE
        $(call cmd,genikh)






masahiro@grover:~/workspace/linux-yamada$ make
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
  CHK     include/generated/compile.h
  GEN     kernel/kheaders_data.txz
find: =E2=80=98FORCE=E2=80=99: No such file or directory
70106 blocks
Can't do inplace edit: kernel/kheaders_data.txz.tmp is not a regular file.
Can't do inplace edit: kernel/kheaders_data.txz.tmp/arch is not a regular f=
ile.
Can't do inplace edit: kernel/kheaders_data.txz.tmp/arch/x86 is not a
regular file.
Can't do inplace edit: kernel/kheaders_data.txz.tmp/arch/x86/include
is not a regular file.
Can't do inplace edit:
kernel/kheaders_data.txz.tmp/arch/x86/include/uapi is not a regular
file.
Can't do inplace edit:
kernel/kheaders_data.txz.tmp/arch/x86/include/uapi/asm is not a
regular file.
Can't do inplace edit:
kernel/kheaders_data.txz.tmp/arch/x86/include/generated is not a
regular file.
Can't do inplace edit:
kernel/kheaders_data.txz.tmp/arch/x86/include/generated/uapi is not a
regular file.
Can't do inplace edit:
kernel/kheaders_data.txz.tmp/arch/x86/include/generated/uapi/asm is
not a regular file.
Can't do inplace edit:
kernel/kheaders_data.txz.tmp/arch/x86/include/generated/asm is not a
regular file.
Can't do inplace edit:
kernel/kheaders_data.txz.tmp/arch/x86/include/asm is not a regular
file.
Can't do inplace edit:
kernel/kheaders_data.txz.tmp/arch/x86/include/asm/xen is not a regular
file.
Can't do inplace edit:
kernel/kheaders_data.txz.tmp/arch/x86/include/asm/uv is not a regular
file.
Can't do inplace edit:
kernel/kheaders_data.txz.tmp/arch/x86/include/asm/numachip is not a
regular file.
Can't do inplace edit:
kernel/kheaders_data.txz.tmp/arch/x86/include/asm/e820 is not a
regular file.
Can't do inplace edit:
kernel/kheaders_data.txz.tmp/arch/x86/include/asm/fpu is not a regular
file.
Can't do inplace edit:
kernel/kheaders_data.txz.tmp/arch/x86/include/asm/crypto is not a
regular file.
Can't do inplace edit:
kernel/kheaders_data.txz.tmp/arch/x86/include/asm/trace is not a
regular file.
Can't do inplace edit: kernel/kheaders_data.txz.tmp/scripts is not a
regular file.
Can't do inplace edit: kernel/kheaders_data.txz.tmp/scripts/genksyms
is not a regular file.
Can't do inplace edit: kernel/kheaders_data.txz.tmp/scripts/ksymoops
is not a regular file.
Can't do inplace edit: kernel/kheaders_data.txz.tmp/scripts/gdb is not
a regular file.
Can't do inplace edit: kernel/kheaders_data.txz.tmp/scripts/gdb/linux
is not a regular file.
Can't do inplace edit: kernel/kheaders_data.txz.tmp/scripts/basic is
not a regular file.
Can't do inplace edit: kernel/kheaders_data.txz.tmp/scripts/dtc is not
a regular file.
Can't do inplace edit: kernel/kheaders_data.txz.tmp/scripts/dtc/libfdt
is not a regular file.
Can't do inplace edit:
kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes is not a
regular file.
Can't open kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/arm64:
No such file or directory.
Can't open kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/xtensa=
:
No such file or directory.
Can't open kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/openri=
sc:
No such file or directory.
Can't open kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/nios2:
No such file or directory.
Can't open kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/mips:
No such file or directory.
Can't open kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/arm:
No such file or directory.
Can't open kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/microb=
laze:
No such file or directory.
Can't open kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/arc:
No such file or directory.
Can't open kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/sh:
No such file or directory.
Can't open kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/powerp=
c:
No such file or directory.
Can't do inplace edit:
kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/dt-bindings
is not a regular file.

  [ massive amount of error messages continues ]






> I can't think any other ways at the moment to break the circular dependen=
cy
> so I'm thinking this is good enough for now especially since Kbuild will
> print a proper warning. Let me know what you think?
>
> thanks,
>
>  - Joel
>
--
Best Regards
Masahiro Yamada
