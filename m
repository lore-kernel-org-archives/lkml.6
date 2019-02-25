Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A770C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AD12084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWpL3/TM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfBYGNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 01:13:11 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45861 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfBYGNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 01:13:10 -0500
Received: by mail-ed1-f68.google.com with SMTP id d9so6502867edh.12;
        Sun, 24 Feb 2019 22:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=EJvjfImsCd+HkVmDOBgsj+8LPa+8x3Pnc5b1YI/lGV4=;
        b=ZWpL3/TMZUE1crtoRQ6bX9z3SQB8go9x4n0M/ldha5YcJm3igEjy7G8hUwNEDhAmk1
         0dwyjmcGaorSmdaUVZ8s7C96nYJ3K1Dr4Es6WgnzNrlID2uMwDjmVHBRV2VUutaJpk3d
         i/AOPNJ2vsZMot9lUyMszRNKQXSIeyZMJ79cGJdW6t58fXrsrP8hrBeaKHiFHZfCNSz8
         Dvy2g5OBQ1d2bsZOOf6cX2wiYhTdEwdgY/dzr22s/YiccqCPC5F8ibElnUGkYD/dDfDb
         nHLOiyrFvH4+H2m+jZkFU6TfDdYzZwav2Wz0HIPEEXNQO4AA8tbrrxWiXMh53Fno4xOf
         p4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EJvjfImsCd+HkVmDOBgsj+8LPa+8x3Pnc5b1YI/lGV4=;
        b=M8IpU105yaVZXVDdENEhzb7YDU+aFBbgtN3hqiWMtXUq3orSOH9BmQHsDSS2EBKgrv
         gLbTYibw9qukMASnOE4NfiYsy26KkWOdQkw9LWptR+/0fUoKtnmSTBlj8ALRSqH5ooMY
         lRB8BTcHnlGRQGv+B4gOeGJsYYLP+GkC2M/9jvlNgPY6CQznI+cPlNI2ObDyPc77VwKK
         PnBnbYUt298FRyK4Z5zpmkBr3ubHxNhlf7m9HXR1lqhf/ekDZDZJEC2hCbb9nAe8hvxK
         wjQmOAFDxXBvwJKzmEXp0FNJgu8u4zRvpp8eMD6elHswCZseKGKArOj+WqMfe4BjXXFl
         fWbg==
X-Gm-Message-State: AHQUAuZ6z4mk8SjPTOcfURcA437Y4lAQjH62jEnCXi6aWFWaQLh1VTaP
        eiXatGaEDWP7NxID3Ue0ptg=
X-Google-Smtp-Source: AHgI3Ia/09sw9eioxKlKWncxOeuQM4VGrjAKT1G2eSKNy159YNGKe3a34LGzdRdT+xjeCh8MboTt5g==
X-Received: by 2002:a17:906:6a8a:: with SMTP id p10mr11769658ejr.135.1551075185143;
        Sun, 24 Feb 2019 22:13:05 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id s3sm1554310ejk.34.2019.02.24.22.13.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 24 Feb 2019 22:13:03 -0800 (PST)
Date:   Sun, 24 Feb 2019 23:13:01 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Clang patches for 4.9
Message-ID: <20190225061301.GA23411@archlinux-ryzen>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg and Sasha,

Attached are three mbox files containing patches that bring the Clang
backports that Nick did in 4.9.139 up to date with what is currently in
4.14 and mainline, as well as fix warnings that are present in the arm64
and x86_64 defconfigs here and in AOSP (cuttlefish_defconfig). All of
these warnings are fixed in 4.14 so there will be no regressions from
upgrading.

They were tested with Arch Linux's GCC 8.2.1 and AOSP's clang-r349610 [1]
and boot tested in QEMU 3.1.0 with our rootfs files [2].

Additionally, for Greg, I have provided a merge resolution for
the Makefile conflict you will get when doing the android-4.9 merge.
You will also get a conflict in arch/arm64/include/asm/arch_gicv3.h,
just check out to MERGE_HEAD as the {read,write}_sysreg_s macros have
the LTO workaround that causes the conflict in the first place. I
tested this resolution by building and booting cuttlefish_defconfig
for arm64 with CONFIG_LTO_CLANG and CONFIG_CFI_CLANG enabled.

[1]: https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+/803bf398de492bb70560a2444d24491bc42b84ec/clang-r349610/
[2]: https://github.com/ClangBuiltLinux/continuous-integration/tree/8a288264aa71f59a1725d2946b0a40364aafcad7/images

Please let me know if there are any concerns or objections!
Nathan

--n8g4imXOkfNTN/H1
Content-Type: application/mbox
Content-Disposition: attachment; filename="core-clang-fixes-4.9.mbox"
Content-Transfer-Encoding: quoted-printable

=46rom 44ada4bcd5c9c57187c90adcb8092c577953b2de Mon Sep 17 00:00:00 2001=0A=
=46rom: Masahiro Yamada <yamada.masahiro@socionext.com>=0ADate: Mon, 27 Nov=
 2017 21:15:13 +0900=0ASubject: [PATCH 1/7] kbuild: move cc-option and cc-d=
isable-warning after incl.=0A arch Makefile=0A=0Acommit cfe17c9bbe6a673fdaf=
dab179c32b355ed447f66 upstream.=0A=0AGeert reported commit ae6b289a3789 ("k=
build: Set KBUILD_CFLAGS before=0Aincl. arch Makefile") broke cross-compila=
tion using a cross-compiler=0Athat supports less compiler options than the =
host compiler.=0A=0AFor example,=0A=0A  cc1: error: unrecognized command li=
ne option "-Wno-unused-but-set-variable"=0A=0AThis problem happens on archi=
tectures that setup CROSS_COMPILE in their=0Aarch/*/Makefile.=0A=0AMove the=
 cc-option and cc-disable-warning back to the original position,=0Abut keep=
 the Clang target options untouched.=0A=0AFixes: ae6b289a3789 ("kbuild: Set=
 KBUILD_CFLAGS before incl. arch Makefile")=0AReported-by: Geert Uytterhoev=
en <geert@linux-m68k.org>=0ASigned-off-by: Masahiro Yamada <yamada.masahiro=
@socionext.com>=0ATested-by: Geert Uytterhoeven <geert@linux-m68k.org>=0A[n=
c: Backport to 4.9; adjust context due to a previous backport]=0ASigned-off=
-by: Nathan Chancellor <natechancellor@gmail.com>=0A---=0A Makefile | 43 ++=
+++++++++++++++++++++--------------------=0A 1 file changed, 23 insertions(=
+), 20 deletions(-)=0A=0Adiff --git a/Makefile b/Makefile=0Aindex af70503df=
3f4..50e04f851c91 100644=0A--- a/Makefile=0A+++ b/Makefile=0A@@ -521,26 +52=
1,6 @@ CLANG_GCC_TC	:=3D -gcc-toolchain $(GCC_TOOLCHAIN)=0A endif=0A KBUILD=
_CFLAGS +=3D $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)=0A KBUILD_AFLA=
GS +=3D $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)=0A-KBUILD_CPPFLAGS =
+=3D $(call cc-option,-Qunused-arguments,)=0A-KBUILD_CFLAGS +=3D $(call cc-=
disable-warning, unused-variable)=0A-KBUILD_CFLAGS +=3D $(call cc-disable-w=
arning, format-invalid-specifier)=0A-KBUILD_CFLAGS +=3D $(call cc-disable-w=
arning, gnu)=0A-KBUILD_CFLAGS +=3D $(call cc-disable-warning, address-of-pa=
cked-member)=0A-# Quiet clang warning: comparison of unsigned expression < =
0 is always false=0A-KBUILD_CFLAGS +=3D $(call cc-disable-warning, tautolog=
ical-compare)=0A-# CLANG uses a _MergedGlobals as optimization, but this br=
eaks modpost, as the=0A-# source of a reference will be _MergedGlobals and =
not on of the whitelisted names.=0A-# See modpost pattern 2=0A-KBUILD_CFLAG=
S +=3D $(call cc-option, -mno-global-merge,)=0A-KBUILD_CFLAGS +=3D $(call c=
c-option, -fcatch-undefined-behavior)=0A-KBUILD_CFLAGS +=3D $(call cc-optio=
n, -no-integrated-as)=0A-KBUILD_AFLAGS +=3D $(call cc-option, -no-integrate=
d-as)=0A-else=0A-=0A-# These warnings generated too much noise in a regular=
 build.=0A-# Use make W=3D1 to enable them (see scripts/Makefile.build)=0A-=
KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-but-set-variable)=0A-K=
BUILD_CFLAGS +=3D $(call cc-disable-warning, unused-const-variable)=0A endi=
f=0A =0A =0A@@ -739,6 +719,29 @@ ifdef CONFIG_CC_STACKPROTECTOR=0A endif=0A=
 KBUILD_CFLAGS +=3D $(stackp-flag)=0A =0A+ifeq ($(cc-name),clang)=0A+KBUILD=
_CPPFLAGS +=3D $(call cc-option,-Qunused-arguments,)=0A+KBUILD_CFLAGS +=3D =
$(call cc-disable-warning, unused-variable)=0A+KBUILD_CFLAGS +=3D $(call cc=
-disable-warning, format-invalid-specifier)=0A+KBUILD_CFLAGS +=3D $(call cc=
-disable-warning, gnu)=0A+KBUILD_CFLAGS +=3D $(call cc-disable-warning, add=
ress-of-packed-member)=0A+# Quiet clang warning: comparison of unsigned exp=
ression < 0 is always false=0A+KBUILD_CFLAGS +=3D $(call cc-disable-warning=
, tautological-compare)=0A+# CLANG uses a _MergedGlobals as optimization, b=
ut this breaks modpost, as the=0A+# source of a reference will be _MergedGl=
obals and not on of the whitelisted names.=0A+# See modpost pattern 2=0A+KB=
UILD_CFLAGS +=3D $(call cc-option, -mno-global-merge,)=0A+KBUILD_CFLAGS +=
=3D $(call cc-option, -fcatch-undefined-behavior)=0A+KBUILD_CFLAGS +=3D $(c=
all cc-option, -no-integrated-as)=0A+KBUILD_AFLAGS +=3D $(call cc-option, -=
no-integrated-as)=0A+else=0A+=0A+# These warnings generated too much noise =
in a regular build.=0A+# Use make W=3D1 to enable them (see scripts/Makefil=
e.extrawarn)=0A+KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-but-se=
t-variable)=0A+KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-const-v=
ariable)=0A+endif=0A+=0A ifdef CONFIG_FRAME_POINTER=0A KBUILD_CFLAGS	+=3D -=
fno-omit-frame-pointer -fno-optimize-sibling-calls=0A else=0A-- =0A2.21.0=
=0A=0A=0AFrom 3b7f4533277a6df18f1498774cc3cbc90d9ac146 Mon Sep 17 00:00:00 =
2001=0AFrom: David Lin <dtwlin@google.com>=0ADate: Fri, 20 Oct 2017 14:09:1=
3 -0700=0ASubject: [PATCH 2/7] kbuild: clang: fix build failures with spars=
e check=0A=0Acommit bb3f38c3c5b759163e09b9152629cc789731de47 upstream.=0A=
=0AWe should avoid using the space character when passing arguments to=0Acl=
ang, because static code analysis check tool such as sparse may=0Amisinterp=
ret the arguments followed by spaces as build targets hence=0Acause the bui=
ld to fail.=0A=0ASigned-off-by: David Lin <dtwlin@google.com>=0ASigned-off-=
by: Masahiro Yamada <yamada.masahiro@socionext.com>=0A[nc: Backport to 4.9;=
 adjust context]=0ASigned-off-by: Nathan Chancellor <natechancellor@gmail.c=
om>=0A---=0A Makefile | 4 ++--=0A 1 file changed, 2 insertions(+), 2 deleti=
ons(-)=0A=0Adiff --git a/Makefile b/Makefile=0Aindex 50e04f851c91..5f455784=
6b71 100644=0A--- a/Makefile=0A+++ b/Makefile=0A@@ -511,13 +511,13 @@ endif=
=0A =0A ifeq ($(cc-name),clang)=0A ifneq ($(CROSS_COMPILE),)=0A-CLANG_TARGE=
T	:=3D -target $(notdir $(CROSS_COMPILE:%-=3D%))=0A+CLANG_TARGET	:=3D --tar=
get=3D$(notdir $(CROSS_COMPILE:%-=3D%))=0A GCC_TOOLCHAIN_DIR :=3D $(dir $(s=
hell which $(LD)))=0A CLANG_PREFIX	:=3D --prefix=3D$(GCC_TOOLCHAIN_DIR)=0A =
GCC_TOOLCHAIN	:=3D $(realpath $(GCC_TOOLCHAIN_DIR)/..)=0A endif=0A ifneq ($=
(GCC_TOOLCHAIN),)=0A-CLANG_GCC_TC	:=3D -gcc-toolchain $(GCC_TOOLCHAIN)=0A+C=
LANG_GCC_TC	:=3D --gcc-toolchain=3D$(GCC_TOOLCHAIN)=0A endif=0A KBUILD_CFLA=
GS +=3D $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)=0A KBUILD_AFLAGS +=
=3D $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)=0A-- =0A2.21.0=0A=0A=0A=
=46rom 85c7bf6f69875577ecc2dfee492536d3915ccae8 Mon Sep 17 00:00:00 2001=0A=
=46rom: Nick Desaulniers <nick.desaulniers@gmail.com>=0ADate: Sat, 7 Oct 20=
17 13:23:23 -0700=0ASubject: [PATCH 3/7] kbuild: clang: remove crufty HOSTC=
FLAGS=0A=0Acommit df16aaac26e92e97ab7234d3f93c953466adc4b5 upstream.=0A=0AW=
hen compiling with `make CC=3Dclang HOSTCC=3Dclang`, I was seeing warnings=
=0Athat clang did not recognize -fno-delete-null-pointer-checks for HOSTCC=
=0Atargets.  These were added in commit 61163efae020 ("kbuild: LLVMLinux:=
=0AAdd Kbuild support for building kernel with Clang").=0A=0AClang does not=
 support -fno-delete-null-pointer-checks, so adding it to=0AHOSTCFLAGS if H=
OSTCC is clang does not make sense.=0A=0AIt's not clear why the other warni=
ngs were disabled, and just for=0AHOSTCFLAGS, but I can remove them, add -W=
error to HOSTCFLAGS and compile=0Awith clang just fine.=0A=0ASuggested-by: =
Masahiro Yamada <yamada.masahiro@socionext.com>=0ASigned-off-by: Nick Desau=
lniers <nick.desaulniers@gmail.com>=0ASigned-off-by: Masahiro Yamada <yamad=
a.masahiro@socionext.com>=0A[nc: Backport to 4.9; adjust context]=0ASigned-=
off-by: Nathan Chancellor <natechancellor@gmail.com>=0A---=0A Makefile | 5 =
-----=0A 1 file changed, 5 deletions(-)=0A=0Adiff --git a/Makefile b/Makefi=
le=0Aindex 5f4557846b71..cf5f1a5cf42d 100644=0A--- a/Makefile=0A+++ b/Makef=
ile=0A@@ -306,11 +306,6 @@ HOSTCXX      =3D g++=0A HOSTCFLAGS   :=3D -Wall =
-Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=3Dgn=
u89=0A HOSTCXXFLAGS =3D -O2=0A =0A-ifeq ($(shell $(HOSTCC) -v 2>&1 | grep -=
c "clang version"), 1)=0A-HOSTCFLAGS  +=3D -Wno-unused-value -Wno-unused-pa=
rameter \=0A-		-Wno-missing-field-initializers -fno-delete-null-pointer-che=
cks=0A-endif=0A-=0A # Decide whether to build built-in, modular, or both.=
=0A # Normally, just do built-in.=0A =0A-- =0A2.21.0=0A=0A=0AFrom b51c90170=
bf25436de097a9b08a90d2eb064814f Mon Sep 17 00:00:00 2001=0AFrom: Sodagudi P=
rasad <psodagud@codeaurora.org>=0ADate: Tue, 6 Feb 2018 15:46:51 -0800=0ASu=
bject: [PATCH 4/7] kbuild: clang: disable unused variable warnings only whe=
n=0A constant=0A=0Acommit 0a5f41767444cc3b4fc5573921ab914b4f78baaa upstream=
=2E=0A=0ACurrently, GCC disables -Wunused-const-variable, but not=0A-Wunuse=
d-variable, so warns unused variables if they are=0Anon-constant.=0A=0AWhil=
e, Clang does not warn unused variables at all regardless of=0Athe const qu=
alifier because -Wno-unused-const-variable is implied=0Aby the stronger opt=
ion -Wno-unused-variable.=0A=0ADisable -Wunused-const-variable instead of -=
Wunused-variable so that=0AGCC and Clang work in the same way.=0A=0ASigned-=
off-by: Prasad Sodagudi <psodagud@codeaurora.org>=0ASigned-off-by: Masahiro=
 Yamada <yamada.masahiro@socionext.com>=0ASigned-off-by: Nathan Chancellor =
<natechancellor@gmail.com>=0A---=0A Makefile | 3 +--=0A 1 file changed, 1 i=
nsertion(+), 2 deletions(-)=0A=0Adiff --git a/Makefile b/Makefile=0Aindex c=
f5f1a5cf42d..eca3e7f15edf 100644=0A--- a/Makefile=0A+++ b/Makefile=0A@@ -71=
6,7 +716,6 @@ KBUILD_CFLAGS +=3D $(stackp-flag)=0A =0A ifeq ($(cc-name),cla=
ng)=0A KBUILD_CPPFLAGS +=3D $(call cc-option,-Qunused-arguments,)=0A-KBUILD=
_CFLAGS +=3D $(call cc-disable-warning, unused-variable)=0A KBUILD_CFLAGS +=
=3D $(call cc-disable-warning, format-invalid-specifier)=0A KBUILD_CFLAGS +=
=3D $(call cc-disable-warning, gnu)=0A KBUILD_CFLAGS +=3D $(call cc-disable=
-warning, address-of-packed-member)=0A@@ -734,9 +733,9 @@ else=0A # These w=
arnings generated too much noise in a regular build.=0A # Use make W=3D1 to=
 enable them (see scripts/Makefile.extrawarn)=0A KBUILD_CFLAGS +=3D $(call =
cc-disable-warning, unused-but-set-variable)=0A-KBUILD_CFLAGS +=3D $(call c=
c-disable-warning, unused-const-variable)=0A endif=0A =0A+KBUILD_CFLAGS +=
=3D $(call cc-disable-warning, unused-const-variable)=0A ifdef CONFIG_FRAME=
_POINTER=0A KBUILD_CFLAGS	+=3D -fno-omit-frame-pointer -fno-optimize-siblin=
g-calls=0A else=0A-- =0A2.21.0=0A=0A=0AFrom 063216dbf52cd026866429aec8f075f=
a195a91d3 Mon Sep 17 00:00:00 2001=0AFrom: Stefan Agner <stefan@agner.ch>=
=0ADate: Mon, 19 Mar 2018 22:12:53 +0100=0ASubject: [PATCH 5/7] kbuild: set=
 no-integrated-as before incl. arch Makefile=0A=0Acommit 0f0e8de334c54c3881=
8a4a5390a39aa09deff5bf upstream.=0A=0AIn order to make sure compiler flag d=
etection for ARM works=0Acorrectly the no-integrated-as flags need to be se=
t before=0Aincluding the arch specific Makefile.=0A=0AFixes: cfe17c9bbe6a (=
"kbuild: move cc-option and cc-disable-warning after incl. arch Makefile")=
=0ASigned-off-by: Stefan Agner <stefan@agner.ch>=0ASigned-off-by: Masahiro =
Yamada <yamada.masahiro@socionext.com>=0A[nc: Backport to 4.9; adjust conte=
xt due to a previous backport]=0ASigned-off-by: Nathan Chancellor <natechan=
cellor@gmail.com>=0A---=0A Makefile | 4 ++--=0A 1 file changed, 2 insertion=
s(+), 2 deletions(-)=0A=0Adiff --git a/Makefile b/Makefile=0Aindex eca3e7f1=
5edf..893325dec526 100644=0A--- a/Makefile=0A+++ b/Makefile=0A@@ -516,6 +51=
6,8 @@ CLANG_GCC_TC	:=3D --gcc-toolchain=3D$(GCC_TOOLCHAIN)=0A endif=0A KBU=
ILD_CFLAGS +=3D $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)=0A KBUILD_A=
FLAGS +=3D $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)=0A+KBUILD_CFLAGS=
 +=3D $(call cc-option, -no-integrated-as)=0A+KBUILD_AFLAGS +=3D $(call cc-=
option, -no-integrated-as)=0A endif=0A =0A =0A@@ -726,8 +728,6 @@ KBUILD_CF=
LAGS +=3D $(call cc-disable-warning, tautological-compare)=0A # See modpost=
 pattern 2=0A KBUILD_CFLAGS +=3D $(call cc-option, -mno-global-merge,)=0A K=
BUILD_CFLAGS +=3D $(call cc-option, -fcatch-undefined-behavior)=0A-KBUILD_C=
FLAGS +=3D $(call cc-option, -no-integrated-as)=0A-KBUILD_AFLAGS +=3D $(cal=
l cc-option, -no-integrated-as)=0A else=0A =0A # These warnings generated t=
oo much noise in a regular build.=0A-- =0A2.21.0=0A=0A=0AFrom 193aa7dee7c5f=
ad0f8767011edf8314f4292b6db Mon Sep 17 00:00:00 2001=0AFrom: Masahiro Yamad=
a <yamada.masahiro@socionext.com>=0ADate: Tue, 6 Nov 2018 12:04:54 +0900=0A=
Subject: [PATCH 6/7] kbuild: add -no-integrated-as Clang option=0A uncondit=
ionally=0A=0Acommit dbe27a002ef8573168cb64e181458ea23a74e2b6 upstream.=0A=
=0AWe are still a way off the Clang's integrated assembler support for=0Ath=
e kernel. Hence, -no-integrated-as is mandatory to build the kernel=0Awith =
Clang. If you had an ancient version of Clang that does not=0Arecognize thi=
s option, you would not be able to compile the kernel=0Aanyway.=0A=0ASigned=
-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>=0AReviewed-by: Nic=
k Desaulniers <ndesaulniers@google.com>=0ATested-by: Nick Desaulniers <ndes=
aulniers@google.com>=0ASigned-off-by: Nathan Chancellor <natechancellor@gma=
il.com>=0A---=0A Makefile | 4 ++--=0A 1 file changed, 2 insertions(+), 2 de=
letions(-)=0A=0Adiff --git a/Makefile b/Makefile=0Aindex 893325dec526..37dd=
faeb25f1 100644=0A--- a/Makefile=0A+++ b/Makefile=0A@@ -516,8 +516,8 @@ CLA=
NG_GCC_TC	:=3D --gcc-toolchain=3D$(GCC_TOOLCHAIN)=0A endif=0A KBUILD_CFLAGS=
 +=3D $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)=0A KBUILD_AFLAGS +=3D=
 $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)=0A-KBUILD_CFLAGS +=3D $(ca=
ll cc-option, -no-integrated-as)=0A-KBUILD_AFLAGS +=3D $(call cc-option, -n=
o-integrated-as)=0A+KBUILD_CFLAGS +=3D -no-integrated-as=0A+KBUILD_AFLAGS +=
=3D -no-integrated-as=0A endif=0A =0A =0A-- =0A2.21.0=0A=0A=0AFrom 78efe0d0=
b9fab78ea4cd6e718cd32c640ddc51cf Mon Sep 17 00:00:00 2001=0AFrom: Masahiro =
Yamada <yamada.masahiro@socionext.com>=0ADate: Tue, 6 Nov 2018 12:04:55 +09=
00=0ASubject: [PATCH 7/7] kbuild: consolidate Clang compiler flags=0A=0Acom=
mit 238bcbc4e07fad2fff99c5b157d0c37ccd4d093c upstream.=0A=0ACollect basic C=
lang options such as --target, --prefix, --gcc-toolchain,=0A-no-integrated-=
as into a single variable CLANG_FLAGS so that it can be=0Aeasily reused in =
other parts of Makefile.=0A=0ASigned-off-by: Masahiro Yamada <yamada.masahi=
ro@socionext.com>=0AReviewed-by: Nick Desaulniers <ndesaulniers@google.com>=
=0ATested-by: Nick Desaulniers <ndesaulniers@google.com>=0AAcked-by: Greg H=
ackmann <ghackmann@google.com>=0ASigned-off-by: Nathan Chancellor <natechan=
cellor@gmail.com>=0A---=0A Makefile | 13 ++++++-------=0A 1 file changed, 6=
 insertions(+), 7 deletions(-)=0A=0Adiff --git a/Makefile b/Makefile=0Ainde=
x 37ddfaeb25f1..95cc8793032f 100644=0A--- a/Makefile=0A+++ b/Makefile=0A@@ =
-506,18 +506,17 @@ endif=0A =0A ifeq ($(cc-name),clang)=0A ifneq ($(CROSS_C=
OMPILE),)=0A-CLANG_TARGET	:=3D --target=3D$(notdir $(CROSS_COMPILE:%-=3D%))=
=0A+CLANG_FLAGS	:=3D --target=3D$(notdir $(CROSS_COMPILE:%-=3D%))=0A GCC_TO=
OLCHAIN_DIR :=3D $(dir $(shell which $(LD)))=0A-CLANG_PREFIX	:=3D --prefix=
=3D$(GCC_TOOLCHAIN_DIR)=0A+CLANG_FLAGS	+=3D --prefix=3D$(GCC_TOOLCHAIN_DIR)=
=0A GCC_TOOLCHAIN	:=3D $(realpath $(GCC_TOOLCHAIN_DIR)/..)=0A endif=0A ifne=
q ($(GCC_TOOLCHAIN),)=0A-CLANG_GCC_TC	:=3D --gcc-toolchain=3D$(GCC_TOOLCHAI=
N)=0A+CLANG_FLAGS	+=3D --gcc-toolchain=3D$(GCC_TOOLCHAIN)=0A endif=0A-KBUIL=
D_CFLAGS +=3D $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)=0A-KBUILD_AFL=
AGS +=3D $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)=0A-KBUILD_CFLAGS +=
=3D -no-integrated-as=0A-KBUILD_AFLAGS +=3D -no-integrated-as=0A+CLANG_FLAG=
S	+=3D -no-integrated-as=0A+KBUILD_CFLAGS	+=3D $(CLANG_FLAGS)=0A+KBUILD_AFL=
AGS	+=3D $(CLANG_FLAGS)=0A endif=0A =0A =0A-- =0A2.21.0=0A=0A
--n8g4imXOkfNTN/H1
Content-Type: application/mbox
Content-Disposition: attachment; filename="arm64-clang-warning-fixes-4.9.mbox"
Content-Transfer-Encoding: quoted-printable

=46rom 0730b71869344823102ced9dafddc4534851b516 Mon Sep 17 00:00:00 2001=0A=
=46rom: Will Deacon <will.deacon@arm.com>=0ADate: Fri, 28 Oct 2016 12:23:57=
 +0100=0ASubject: [PATCH 1/7] irqchip/gic-v3: Convert arm64 GIC accessors t=
o=0A {read,write}_sysreg_s=0A=0Acommit d44ffa5ae70a15a15190aa9ffa6f6acdeae1=
d25c upstream.=0A=0AThe GIC system registers are accessed using open-coded =
wrappers around=0Athe mrs_s/msr_s asm macros.=0A=0AThis patch moves the cod=
e over to the {read,wrote}_sysreg_s accessors=0Ainstead, reducing the amoun=
t of explicit asm blocks in the arch headers.=0A=0AReviewed-by: Mark Rutlan=
d <mark.rutland@arm.com>=0ASigned-off-by: Will Deacon <will.deacon@arm.com>=
=0ASigned-off-by: Marc Zyngier <marc.zyngier@arm.com>=0A[nc: Also fix gic_w=
rite_bpr1, which was incidentally fixed in=0A     0e9884fe63c6 ("arm64: sys=
reg: subsume GICv3 sysreg definitions")]=0ASigned-off-by: Nathan Chancellor=
 <natechancellor@gmail.com>=0A---=0A arch/arm64/include/asm/arch_gicv3.h | =
47 +++++++++++------------------=0A 1 file changed, 18 insertions(+), 29 de=
letions(-)=0A=0Adiff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm=
64/include/asm/arch_gicv3.h=0Aindex f8ae6d6e4767..85a15b38b6d8 100644=0A---=
 a/arch/arm64/include/asm/arch_gicv3.h=0A+++ b/arch/arm64/include/asm/arch_=
gicv3.h=0A@@ -80,18 +80,8 @@=0A #include <linux/stringify.h>=0A #include <a=
sm/barrier.h>=0A =0A-#define read_gicreg(r)							\=0A-	({								\=0A-		u6=
4 reg;						\=0A-		asm volatile("mrs_s %0, " __stringify(r) : "=3Dr" (reg))=
;	\=0A-		reg;							\=0A-	})=0A-=0A-#define write_gicreg(v,r)						\=0A-	do=
 {								\=0A-		u64 __val =3D (v);					\=0A-		asm volatile("msr_s " __stri=
ngify(r) ", %0" : : "r" (__val));\=0A-	} while (0)=0A+#define read_gicreg		=
	read_sysreg_s=0A+#define write_gicreg			write_sysreg_s=0A =0A /*=0A  * Low=
-level accessors=0A@@ -102,13 +92,13 @@=0A =0A static inline void gic_write=
_eoir(u32 irq)=0A {=0A-	asm volatile("msr_s " __stringify(ICC_EOIR1_EL1) ",=
 %0" : : "r" ((u64)irq));=0A+	write_sysreg_s(irq, ICC_EOIR1_EL1);=0A 	isb()=
;=0A }=0A =0A static inline void gic_write_dir(u32 irq)=0A {=0A-	asm volati=
le("msr_s " __stringify(ICC_DIR_EL1) ", %0" : : "r" ((u64)irq));=0A+	write_=
sysreg_s(irq, ICC_DIR_EL1);=0A 	isb();=0A }=0A =0A@@ -116,7 +106,7 @@ stati=
c inline u64 gic_read_iar_common(void)=0A {=0A 	u64 irqstat;=0A =0A-	asm vo=
latile("mrs_s %0, " __stringify(ICC_IAR1_EL1) : "=3Dr" (irqstat));=0A+	irqs=
tat =3D read_sysreg_s(ICC_IAR1_EL1);=0A 	dsb(sy);=0A 	return irqstat;=0A }=
=0A@@ -134,10 +124,12 @@ static inline u64 gic_read_iar_cavium_thunderx(voi=
d)=0A =0A 	asm volatile(=0A 		"nop;nop;nop;nop\n\t"=0A-		"nop;nop;nop;nop\n=
\t"=0A-		"mrs_s %0, " __stringify(ICC_IAR1_EL1) "\n\t"=0A-		"nop;nop;nop;no=
p"=0A-		: "=3Dr" (irqstat));=0A+		"nop;nop;nop;nop");=0A+=0A+	irqstat =3D r=
ead_sysreg_s(ICC_IAR1_EL1);=0A+=0A+	asm volatile(=0A+		"nop;nop;nop;nop");=
=0A 	mb();=0A =0A 	return irqstat;=0A@@ -145,43 +137,40 @@ static inline u6=
4 gic_read_iar_cavium_thunderx(void)=0A =0A static inline void gic_write_pm=
r(u32 val)=0A {=0A-	asm volatile("msr_s " __stringify(ICC_PMR_EL1) ", %0" :=
 : "r" ((u64)val));=0A+	write_sysreg_s(val, ICC_PMR_EL1);=0A }=0A =0A stati=
c inline void gic_write_ctlr(u32 val)=0A {=0A-	asm volatile("msr_s " __stri=
ngify(ICC_CTLR_EL1) ", %0" : : "r" ((u64)val));=0A+	write_sysreg_s(val, ICC=
_CTLR_EL1);=0A 	isb();=0A }=0A =0A static inline void gic_write_grpen1(u32 =
val)=0A {=0A-	asm volatile("msr_s " __stringify(ICC_GRPEN1_EL1) ", %0" : : =
"r" ((u64)val));=0A+	write_sysreg_s(val, ICC_GRPEN1_EL1);=0A 	isb();=0A }=
=0A =0A static inline void gic_write_sgi1r(u64 val)=0A {=0A-	asm volatile("=
msr_s " __stringify(ICC_SGI1R_EL1) ", %0" : : "r" (val));=0A+	write_sysreg_=
s(val, ICC_SGI1R_EL1);=0A }=0A =0A static inline u32 gic_read_sre(void)=0A =
{=0A-	u64 val;=0A-=0A-	asm volatile("mrs_s %0, " __stringify(ICC_SRE_EL1) :=
 "=3Dr" (val));=0A-	return val;=0A+	return read_sysreg_s(ICC_SRE_EL1);=0A }=
=0A =0A static inline void gic_write_sre(u32 val)=0A {=0A-	asm volatile("ms=
r_s " __stringify(ICC_SRE_EL1) ", %0" : : "r" ((u64)val));=0A+	write_sysreg=
_s(val, ICC_SRE_EL1);=0A 	isb();=0A }=0A =0A static inline void gic_write_b=
pr1(u32 val)=0A {=0A-	asm volatile("msr_s " __stringify(ICC_BPR1_EL1) ", %0=
" : : "r" (val));=0A+	write_sysreg_s(val, ICC_BPR1_EL1);=0A }=0A =0A #defin=
e gic_read_typer(c)		readq_relaxed(c)=0A-- =0A2.21.0=0A=0A=0AFrom a0f748e51=
8d558f78f4115fbe86c138bbf2d257b Mon Sep 17 00:00:00 2001=0AFrom: Nathan Cha=
ncellor <natechancellor@gmail.com>=0ADate: Wed, 31 Oct 2018 17:50:21 -0700=
=0ASubject: [PATCH 2/7] pinctrl: max77620: Use define directive for=0A max7=
7620_pinconf_param values=0A=0Acommit 1f60652dd586d1b3eee7c4602892a97a62fa9=
37a upstream.=0A=0AClang warns when one enumerated type is implicitly conve=
rted to another:=0A=0Adrivers/pinctrl/pinctrl-max77620.c:56:12: warning: im=
plicit conversion=0Afrom enumeration type 'enum max77620_pinconf_param' to =
different=0Aenumeration type 'enum pin_config_param' [-Wenum-conversion]=0A=
                .param =3D MAX77620_ACTIVE_FPS_SOURCE,=0A                  =
       ^~~~~~~~~~~~~~~~~~~~~~~~~~=0A=0AIt is expected that pinctrl drivers =
can extend pin_config_param because=0Aof the gap between PIN_CONFIG_END and=
 PIN_CONFIG_MAX so this conversion=0Aisn't an issue. Most drivers that take=
 advantage of this define the=0APIN_CONFIG variables as constants, rather t=
han enumerated values. Do the=0Asame thing here so that Clang no longer war=
ns.=0A=0ALink: https://github.com/ClangBuiltLinux/linux/issues/139=0ASigned=
-off-by: Nathan Chancellor <natechancellor@gmail.com>=0ASigned-off-by: Linu=
s Walleij <linus.walleij@linaro.org>=0A---=0A drivers/pinctrl/pinctrl-max77=
620.c | 14 ++++++--------=0A 1 file changed, 6 insertions(+), 8 deletions(-=
)=0A=0Adiff --git a/drivers/pinctrl/pinctrl-max77620.c b/drivers/pinctrl/pi=
nctrl-max77620.c=0Aindex d9ff53e8f715..a7c4e32d31c3 100644=0A--- a/drivers/=
pinctrl/pinctrl-max77620.c=0A+++ b/drivers/pinctrl/pinctrl-max77620.c=0A@@ =
-34,14 +34,12 @@ enum max77620_pin_ppdrv {=0A 	MAX77620_PIN_PP_DRV,=0A };=
=0A =0A-enum max77620_pinconf_param {=0A-	MAX77620_ACTIVE_FPS_SOURCE =3D PI=
N_CONFIG_END + 1,=0A-	MAX77620_ACTIVE_FPS_POWER_ON_SLOTS,=0A-	MAX77620_ACTI=
VE_FPS_POWER_DOWN_SLOTS,=0A-	MAX77620_SUSPEND_FPS_SOURCE,=0A-	MAX77620_SUSP=
END_FPS_POWER_ON_SLOTS,=0A-	MAX77620_SUSPEND_FPS_POWER_DOWN_SLOTS,=0A-};=0A=
+#define MAX77620_ACTIVE_FPS_SOURCE		(PIN_CONFIG_END + 1)=0A+#define MAX776=
20_ACTIVE_FPS_POWER_ON_SLOTS	(PIN_CONFIG_END + 2)=0A+#define MAX77620_ACTIV=
E_FPS_POWER_DOWN_SLOTS	(PIN_CONFIG_END + 3)=0A+#define MAX77620_SUSPEND_FPS=
_SOURCE		(PIN_CONFIG_END + 4)=0A+#define MAX77620_SUSPEND_FPS_POWER_ON_SLOT=
S	(PIN_CONFIG_END + 5)=0A+#define MAX77620_SUSPEND_FPS_POWER_DOWN_SLOTS	(PI=
N_CONFIG_END + 6)=0A =0A struct max77620_pin_function {=0A 	const char *nam=
e;=0A-- =0A2.21.0=0A=0A=0AFrom 22696fca63d66d8bef0be5761812fafd42115191 Mon=
 Sep 17 00:00:00 2001=0AFrom: Colin Ian King <colin.king@canonical.com>=0AD=
ate: Thu, 23 Nov 2017 11:10:47 +0000=0ASubject: [PATCH 3/7] phy: tegra: rem=
ove redundant self assignment of 'map'=0A=0Acommit a0dd6773038f3fd2bd1b4f7e=
c193887cffc49046 upstream.=0A=0AThe assignment of map to itself is redundan=
t and can be removed.=0ADetected with Coccinelle.=0A=0ASigned-off-by: Colin=
 Ian King <colin.king@canonical.com>=0ASigned-off-by: Kishon Vijay Abraham =
I <kishon@ti.com>=0ASigned-off-by: Nathan Chancellor <natechancellor@gmail.=
com>=0A---=0A drivers/phy/tegra/xusb.c | 2 +-=0A 1 file changed, 1 insertio=
n(+), 1 deletion(-)=0A=0Adiff --git a/drivers/phy/tegra/xusb.c b/drivers/ph=
y/tegra/xusb.c=0Aindex 873424ab0e32..bd0e65900216 100644=0A--- a/drivers/ph=
y/tegra/xusb.c=0A+++ b/drivers/phy/tegra/xusb.c=0A@@ -418,7 +418,7 @@ tegra=
_xusb_port_find_lane(struct tegra_xusb_port *port,=0A {=0A 	struct tegra_xu=
sb_lane *lane, *match =3D ERR_PTR(-ENODEV);=0A =0A-	for (map =3D map; map->=
type; map++) {=0A+	for (; map->type; map++) {=0A 		if (port->index !=3D map=
->port)=0A 			continue;=0A =0A-- =0A2.21.0=0A=0A=0AFrom a7bb9833f415c5a0ee6=
39d9c52419c16acd0791c Mon Sep 17 00:00:00 2001=0AFrom: Stefan Agner <stefan=
@agner.ch>=0ADate: Mon, 19 Mar 2018 22:26:32 +0100=0ASubject: [PATCH 4/7] d=
rm/msm/dsi: use correct enum in dsi_get_cmd_fmt=0A=0Acommit cf606fe3300cbd3=
db44785174934e61e5a2ffc37 upstream.=0A=0AThe function dsi_get_cmd_fmt retur=
ns enum dsi_cmd_dst_format,=0Ause the correct enum value also for MIPI_DSI_=
FMT_RGB666/_PACKED.=0A=0AThis has been discovered using clang:=0A  drivers/=
gpu/drm/msm/dsi/dsi_host.c:743:35: warning: implicit conversion=0A        f=
rom enumeration type 'enum dsi_vid_dst_format' to different=0A        enume=
ration type 'enum dsi_cmd_dst_format' [-Wenum-conversion]=0A          case =
MIPI_DSI_FMT_RGB666:       return VID_DST_FORMAT_RGB666;=0A                =
                          ~~~~~~ ^~~~~~~~~~~~~~~~~~~~~=0A=0ASigned-off-by: =
Stefan Agner <stefan@agner.ch>=0AReviewed-by: Archit Taneja <architt@codeau=
rora.org>=0ASigned-off-by: Rob Clark <robdclark@gmail.com>=0ASigned-off-by:=
 Nathan Chancellor <natechancellor@gmail.com>=0A---=0A drivers/gpu/drm/msm/=
dsi/dsi_host.c | 2 +-=0A 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0Adiff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/ds=
i/dsi_host.c=0Aindex 6f240021705b..48d190c2eed7 100644=0A--- a/drivers/gpu/=
drm/msm/dsi/dsi_host.c=0A+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c=0A@@ -749=
,7 +749,7 @@ static inline enum dsi_cmd_dst_format dsi_get_cmd_fmt(=0A 	swi=
tch (mipi_fmt) {=0A 	case MIPI_DSI_FMT_RGB888:	return CMD_DST_FORMAT_RGB888=
;=0A 	case MIPI_DSI_FMT_RGB666_PACKED:=0A-	case MIPI_DSI_FMT_RGB666:	return=
 VID_DST_FORMAT_RGB666;=0A+	case MIPI_DSI_FMT_RGB666:	return CMD_DST_FORMAT=
_RGB666;=0A 	case MIPI_DSI_FMT_RGB565:	return CMD_DST_FORMAT_RGB565;=0A 	de=
fault:			return CMD_DST_FORMAT_RGB888;=0A 	}=0A-- =0A2.21.0=0A=0A=0AFrom 2f=
7a27ae99db4f7b7e8b41473018510941e8dc13 Mon Sep 17 00:00:00 2001=0AFrom: Mat=
thias Kaehlcke <mka@chromium.org>=0ADate: Mon, 30 Oct 2017 11:08:16 -0700=
=0ASubject: [PATCH 5/7] sched/sysctl: Fix attributes of some extern declara=
tions=0A=0Acommit a9903f04e0a4ea522d959c2f287cdf0ab029e324 upstream.=0A=0AT=
he definition of sysctl_sched_migration_cost, sysctl_sched_nr_migrate=0Aand=
 sysctl_sched_time_avg includes the attribute const_debug. This=0Aattribute=
 is not part of the extern declaration of these variables in=0Ainclude/linu=
x/sched/sysctl.h, while it is in kernel/sched/sched.h,=0Aand as a result Cl=
ang generates warnings like this:=0A=0A  kernel/sched/sched.h:1618:33: warn=
ing: section attribute is specified on redeclared variable [-Wsection]=0A  =
extern const_debug unsigned int sysctl_sched_time_avg;=0A                  =
              ^=0A  ./include/linux/sched/sysctl.h:42:21: note: previous de=
claration is here=0A  extern unsigned int sysctl_sched_time_avg;=0A=0AThe h=
eader only declares the variables when CONFIG_SCHED_DEBUG is defined,=0Athe=
refore it is not necessary to duplicate the definition of const_debug.=0AIn=
stead we can use the attribute __read_mostly, which is the expansion of=0Ac=
onst_debug when CONFIG_SCHED_DEBUG=3Dy is set.=0A=0ASigned-off-by: Matthias=
 Kaehlcke <mka@chromium.org>=0AReviewed-by: Nick Desaulniers <nick.desaulni=
ers@gmail.com>=0ACc: Douglas Anderson <dianders@chromium.org>=0ACc: Guenter=
 Roeck <groeck@chromium.org>=0ACc: Linus Torvalds <torvalds@linux-foundatio=
n.org>=0ACc: Peter Zijlstra <peterz@infradead.org>=0ACc: Shile Zhang <shile=
=2Ezhang@nokia.com>=0ACc: Thomas Gleixner <tglx@linutronix.de>=0ALink: http=
://lkml.kernel.org/r/20171030180816.170850-1-mka@chromium.org=0ASigned-off-=
by: Ingo Molnar <mingo@kernel.org>=0A[nc: Backport to 4.9]=0ASigned-off-by:=
 Nathan Chancellor <natechancellor@gmail.com>=0A---=0A include/linux/sched/=
sysctl.h | 6 +++---=0A 1 file changed, 3 insertions(+), 3 deletions(-)=0A=
=0Adiff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h=
=0Aindex 22db1e63707e..05e8b6e4edcb 100644=0A--- a/include/linux/sched/sysc=
tl.h=0A+++ b/include/linux/sched/sysctl.h=0A@@ -33,9 +33,9 @@ extern unsign=
ed int sysctl_numa_balancing_scan_period_max;=0A extern unsigned int sysctl=
_numa_balancing_scan_size;=0A =0A #ifdef CONFIG_SCHED_DEBUG=0A-extern unsig=
ned int sysctl_sched_migration_cost;=0A-extern unsigned int sysctl_sched_nr=
_migrate;=0A-extern unsigned int sysctl_sched_time_avg;=0A+extern __read_mo=
stly unsigned int sysctl_sched_migration_cost;=0A+extern __read_mostly unsi=
gned int sysctl_sched_nr_migrate;=0A+extern __read_mostly unsigned int sysc=
tl_sched_time_avg;=0A extern unsigned int sysctl_sched_shares_window;=0A =
=0A int sched_proc_update_handler(struct ctl_table *table, int write,=0A-- =
=0A2.21.0=0A=0A=0AFrom 8ab2085a41922c2b2662c69de5539e49127522a1 Mon Sep 17 =
00:00:00 2001=0AFrom: Matthias Kaehlcke <mka@chromium.org>=0ADate: Fri, 8 S=
ep 2017 16:13:02 -0700=0ASubject: [PATCH 6/7] mm/zsmalloc.c: change stat ty=
pe parameter to int=0A=0Acommit 3eb95feac113d8ebad5b7b5189a65efcbd95a749 up=
stream.=0A=0Azs_stat_inc/dec/get() uses enum zs_stat_type for the stat type=
, however=0Asome callers pass an enum fullness_group value.  Change the typ=
e to int to=0Areflect the actual use of the functions and get rid of 'enum-=
conversion'=0Awarnings=0A=0ALink: http://lkml.kernel.org/r/20170731175000.5=
6538-1-mka@chromium.org=0ASigned-off-by: Matthias Kaehlcke <mka@chromium.or=
g>=0AReviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>=0AAcked=
-by: Minchan Kim <minchan@kernel.org>=0ACc: Doug Anderson <dianders@chromiu=
m.org>=0ASigned-off-by: Andrew Morton <akpm@linux-foundation.org>=0ASigned-=
off-by: Linus Torvalds <torvalds@linux-foundation.org>=0ASigned-off-by: Nat=
han Chancellor <natechancellor@gmail.com>=0A---=0A mm/zsmalloc.c | 9 ++++++=
---=0A 1 file changed, 6 insertions(+), 3 deletions(-)=0A=0Adiff --git a/mm=
/zsmalloc.c b/mm/zsmalloc.c=0Aindex d3548c48369f..3d675c5d92f1 100644=0A---=
 a/mm/zsmalloc.c=0A+++ b/mm/zsmalloc.c=0A@@ -558,20 +558,23 @@ static int g=
et_size_class_index(int size)=0A 	return min(zs_size_classes - 1, idx);=0A =
}=0A =0A+/* type can be of enum type zs_stat_type or fullness_group */=0A s=
tatic inline void zs_stat_inc(struct size_class *class,=0A-				enum zs_stat=
_type type, unsigned long cnt)=0A+				int type, unsigned long cnt)=0A {=0A =
	class->stats.objs[type] +=3D cnt;=0A }=0A =0A+/* type can be of enum type =
zs_stat_type or fullness_group */=0A static inline void zs_stat_dec(struct =
size_class *class,=0A-				enum zs_stat_type type, unsigned long cnt)=0A+			=
	int type, unsigned long cnt)=0A {=0A 	class->stats.objs[type] -=3D cnt;=0A=
 }=0A =0A+/* type can be of enum type zs_stat_type or fullness_group */=0A =
static inline unsigned long zs_stat_get(struct size_class *class,=0A-				en=
um zs_stat_type type)=0A+				int type)=0A {=0A 	return class->stats.objs[ty=
pe];=0A }=0A-- =0A2.21.0=0A=0A=0AFrom b17a769245558de24f4c57aa9f87ca412eb38=
a5b Mon Sep 17 00:00:00 2001=0AFrom: Nick Desaulniers <nick.desaulniers@gma=
il.com>=0ADate: Mon, 10 Jul 2017 15:47:26 -0700=0ASubject: [PATCH 7/7] mm/z=
smalloc.c: fix -Wunneeded-internal-declaration=0A warning=0A=0Acommit 3457f=
4147675108aa83f9f33c136f06bb9f8518f upstream.=0A=0Ais_first_page() is only =
called from the macro VM_BUG_ON_PAGE() which is=0Aonly compiled in as a run=
time check when CONFIG_DEBUG_VM is set,=0Aotherwise is checked at compile t=
ime and not actually compiled in.=0A=0AFixes the following warning, found w=
ith Clang:=0A=0A  mm/zsmalloc.c:472:12: warning: function 'is_first_page' i=
s not needed and will not be emitted [-Wunneeded-internal-declaration]=0A  =
static int is_first_page(struct page *page)=0A           ^=0A=0ALink: http:=
//lkml.kernel.org/r/20170524053859.29059-1-nick.desaulniers@gmail.com=0ASig=
ned-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>=0AReviewed-by: Se=
rgey Senozhatsky <sergey.senozhatsky@gmail.com>=0AAcked-by: Minchan Kim <mi=
nchan@kernel.org>=0ASigned-off-by: Andrew Morton <akpm@linux-foundation.org=
>=0ASigned-off-by: Linus Torvalds <torvalds@linux-foundation.org>=0ASigned-=
off-by: Nathan Chancellor <natechancellor@gmail.com>=0A---=0A mm/zsmalloc.c=
 | 2 +-=0A 1 file changed, 1 insertion(+), 1 deletion(-)=0A=0Adiff --git a/=
mm/zsmalloc.c b/mm/zsmalloc.c=0Aindex 3d675c5d92f1..cf15851a7d2f 100644=0A-=
-- a/mm/zsmalloc.c=0A+++ b/mm/zsmalloc.c=0A@@ -473,7 +473,7 @@ static bool =
is_zspage_isolated(struct zspage *zspage)=0A 	return zspage->isolated;=0A }=
=0A =0A-static int is_first_page(struct page *page)=0A+static __maybe_unuse=
d int is_first_page(struct page *page)=0A {=0A 	return PagePrivate(page);=
=0A }=0A-- =0A2.21.0=0A=0A
--n8g4imXOkfNTN/H1
Content-Type: application/mbox
Content-Disposition: attachment; filename="x86_64-clang-warning-fixes-4.9.mbox"
Content-Transfer-Encoding: quoted-printable

=46rom eb51591703e8e84e952e9d740c6038789eed0172 Mon Sep 17 00:00:00 2001=0A=
=46rom: Matthias Kaehlcke <mka@chromium.org>=0ADate: Mon, 13 Mar 2017 11:57=
:25 -0700=0ASubject: [PATCH 1/7] hpet: Make cmd parameter of hpet_ioctl_com=
mon() unsigned=0A=0Acommit 5cd5e6ad0ede862432e1e766bfe02a9ad447533e upstrea=
m.=0A=0AThe value passed by the two callers of the function is unsigned any=
way.=0A=0AMaking the parameter unsigned fixes the following warning when bu=
ilding=0Awith clang:=0A=0Adrivers/char/hpet.c:588:7: error: overflow conver=
ting case value to switch condition type (2149083139 to 1844674407156366745=
9) [-Werror,-Wswitch]=0A        case HPET_INFO:=0A             ^=0Ainclude/=
uapi/linux/hpet.h:18:19: note: expanded from macro 'HPET_INFO'=0A          =
              ^=0Ainclude/uapi/asm-generic/ioctl.h:77:28: note: expanded fr=
om macro '_IOR'=0A                                ^=0Ainclude/uapi/asm-gene=
ric/ioctl.h:66:2: note: expanded from macro '_IOC'=0A        (((dir)  << _I=
OC_DIRSHIFT) | \=0A=0ASigned-off-by: Matthias Kaehlcke <mka@chromium.org>=
=0AAcked-by: Clemens Ladisch <clemens@ladisch.de>=0ASigned-off-by: Greg Kro=
ah-Hartman <gregkh@linuxfoundation.org>=0ASigned-off-by: Nathan Chancellor =
<natechancellor@gmail.com>=0A---=0A drivers/char/hpet.c | 2 +-=0A 1 file ch=
anged, 1 insertion(+), 1 deletion(-)=0A=0Adiff --git a/drivers/char/hpet.c =
b/drivers/char/hpet.c=0Aindex be54e5331a45..50272fe81f26 100644=0A--- a/dri=
vers/char/hpet.c=0A+++ b/drivers/char/hpet.c=0A@@ -574,7 +574,7 @@ static i=
nline unsigned long hpet_time_div(struct hpets *hpets,=0A }=0A =0A static i=
nt=0A-hpet_ioctl_common(struct hpet_dev *devp, int cmd, unsigned long arg,=
=0A+hpet_ioctl_common(struct hpet_dev *devp, unsigned int cmd, unsigned lon=
g arg,=0A 		  struct hpet_info *info)=0A {=0A 	struct hpet_timer __iomem *t=
imer;=0A-- =0A2.21.0=0A=0A=0AFrom 52b07869901d3fdd806ae78f957de5c9e0113ee8 =
Mon Sep 17 00:00:00 2001=0AFrom: Matthias Kaehlcke <mka@chromium.org>=0ADat=
e: Tue, 18 Apr 2017 16:30:37 -0700=0ASubject: [PATCH 2/7] clocksource: Use =
GENMASK_ULL in definition of=0A CLOCKSOURCE_MASK=0A=0Acommit 0773cea37470f8=
e080c510fe720fc356cf35df3a upstream=0A=0ABesides reusing existing code this=
 removes the special case handling=0Afor 64-bit masks, which causes clang t=
o raise a shift count overflow=0Awarning due to https://bugs.llvm.org//show=
_bug.cgi?id=3D10030.=0A=0ASuggested-by: Dmitry Torokhov <dtor@chromium.org>=
=0ASigned-off-by: Matthias Kaehlcke <mka@chromium.org>=0ACc: Grant Grundler=
 <grundler@chromium.org>=0ACc: Greg Hackmann <ghackmann@google.com>=0ACc: M=
ichael Davidson <md@google.com>=0ACc: John Stultz <john.stultz@linaro.org>=
=0ALink: http://lkml.kernel.org/r/20170418233037.70990-1-mka@chromium.org=
=0ASigned-off-by: Thomas Gleixner <tglx@linutronix.de>=0A[nc: cycle_t wasn'=
t eliminated until commit a5a1d1c2914b ("clocksource:=0A     Use a plain u6=
4 instead of cycle_t") in v4.10]=0ASigned-off-by: Nathan Chancellor <natech=
ancellor@gmail.com>=0A---=0A include/linux/clocksource.h | 2 +-=0A 1 file c=
hanged, 1 insertion(+), 1 deletion(-)=0A=0Adiff --git a/include/linux/clock=
source.h b/include/linux/clocksource.h=0Aindex 08398182f56e..36dc52067377 1=
00644=0A--- a/include/linux/clocksource.h=0A+++ b/include/linux/clocksource=
=2Eh=0A@@ -117,7 +117,7 @@ struct clocksource {=0A #define CLOCK_SOURCE_RES=
ELECT			0x100=0A =0A /* simplify initialization of mask field */=0A-#define=
 CLOCKSOURCE_MASK(bits) (cycle_t)((bits) < 64 ? ((1ULL<<(bits))-1) : -1)=0A=
+#define CLOCKSOURCE_MASK(bits) GENMASK_ULL((bits) - 1, 0)=0A =0A static in=
line u32 clocksource_freq2mult(u32 freq, u32 shift_constant, u64 from)=0A {=
=0A-- =0A2.21.0=0A=0A=0AFrom 98c093b51cbfc5d47efff9384bad8e84f491570a Mon S=
ep 17 00:00:00 2001=0AFrom: Matthias Kaehlcke <mka@chromium.org>=0ADate: Tu=
e, 25 Jul 2017 11:36:25 -0700=0ASubject: [PATCH 3/7] netpoll: Fix device na=
me check in netpoll_setup()=0A=0Acommit 0c3a8f8b8fabff4f3ad2dd7b95ae0e90cdd=
1aebb upstream.=0A=0AApparently netpoll_setup() assumes that netpoll.dev_na=
me is a pointer=0Awhen checking if the device name is set:=0A=0Aif (np->dev=
_name) {=0A  ...=0A=0AHowever the field is a character array, therefore the=
 condition always=0Ayields true. Check instead whether the first byte of th=
e array has a=0Anon-zero value.=0A=0ASigned-off-by: Matthias Kaehlcke <mka@=
chromium.org>=0ASigned-off-by: David S. Miller <davem@davemloft.net>=0ASign=
ed-off-by: Nathan Chancellor <natechancellor@gmail.com>=0A---=0A net/core/n=
etpoll.c | 2 +-=0A 1 file changed, 1 insertion(+), 1 deletion(-)=0A=0Adiff =
--git a/net/core/netpoll.c b/net/core/netpoll.c=0Aindex 457f882b0f7b..9b2d6=
1120c0d 100644=0A--- a/net/core/netpoll.c=0A+++ b/net/core/netpoll.c=0A@@ -=
666,7 +666,7 @@ int netpoll_setup(struct netpoll *np)=0A 	int err;=0A =0A 	=
rtnl_lock();=0A-	if (np->dev_name) {=0A+	if (np->dev_name[0]) {=0A 		struct=
 net *net =3D current->nsproxy->net_ns;=0A 		ndev =3D __dev_get_by_name(net=
, np->dev_name);=0A 	}=0A-- =0A2.21.0=0A=0A=0AFrom 0502beba555a0a681adeb98b=
18526f0a5007ee38 Mon Sep 17 00:00:00 2001=0AFrom: Matthias Kaehlcke <mka@ch=
romium.org>=0ADate: Fri, 21 Apr 2017 16:41:10 -0700=0ASubject: [PATCH 4/7] =
tracing: Use cpumask_available() to check if cpumask=0A variable may be use=
d=0A=0Acommit 4dbbe2d8e95c351157f292ece067f985c30c7b53 upstream.=0A=0AThis =
fixes the following clang warning:=0A=0Akernel/trace/trace.c:3231:12: warni=
ng: address of array 'iter->started'=0A  will always evaluate to 'true' [-W=
pointer-bool-conversion]=0A        if (iter->started)=0A=0ALink: http://lkm=
l.kernel.org/r/20170421234110.117075-1-mka@chromium.org=0A=0ASigned-off-by:=
 Matthias Kaehlcke <mka@chromium.org>=0ASigned-off-by: Steven Rostedt (VMwa=
re) <rostedt@goodmis.org>=0ASigned-off-by: Nathan Chancellor <natechancello=
r@gmail.com>=0A---=0A kernel/trace/trace.c | 5 +++--=0A 1 file changed, 3 i=
nsertions(+), 2 deletions(-)=0A=0Adiff --git a/kernel/trace/trace.c b/kerne=
l/trace/trace.c=0Aindex a47339b156ce..6786c507f1f9 100644=0A--- a/kernel/tr=
ace/trace.c=0A+++ b/kernel/trace/trace.c=0A@@ -3022,13 +3022,14 @@ static v=
oid test_cpu_buff_start(struct trace_iterator *iter)=0A 	if (!(iter->iter_f=
lags & TRACE_FILE_ANNOTATE))=0A 		return;=0A =0A-	if (iter->started && cpum=
ask_test_cpu(iter->cpu, iter->started))=0A+	if (cpumask_available(iter->sta=
rted) &&=0A+	    cpumask_test_cpu(iter->cpu, iter->started))=0A 		return;=
=0A =0A 	if (per_cpu_ptr(iter->trace_buffer->data, iter->cpu)->skipped_entr=
ies)=0A 		return;=0A =0A-	if (iter->started)=0A+	if (cpumask_available(iter=
->started))=0A 		cpumask_set_cpu(iter->cpu, iter->started);=0A =0A 	/* Don'=
t print started cpu buffer for the first entry of the trace */=0A-- =0A2.21=
=2E0=0A=0A=0AFrom cd914bdfa797b5f4f7c45e286f8c57c7d5fa0957 Mon Sep 17 00:00=
:00 2001=0AFrom: Matthias Kaehlcke <mka@chromium.org>=0ADate: Tue, 25 Jul 2=
017 14:50:53 -0700=0ASubject: [PATCH 5/7] x86/boot: Disable the address-of-=
packed-member compiler=0A warning=0A=0Acommit 20c6c189045539d29f4854d92b7ea=
9c329e1edfc upstream.=0A=0AThe clang warning 'address-of-packed-member' is =
disabled for the general=0Akernel code, also disable it for the x86 boot co=
de.=0A=0AThis suppresses a bunch of warnings like this when building with c=
lang:=0A=0A./arch/x86/include/asm/processor.h:535:30: warning: taking addre=
ss of=0A  packed member 'sp0' of class or structure 'x86_hw_tss' may result=
 in an=0A  unaligned pointer value [-Waddress-of-packed-member]=0A    retur=
n this_cpu_read_stable(cpu_tss.x86_tss.sp0);=0A                            =
    ^~~~~~~~~~~~~~~~~~~=0A./arch/x86/include/asm/percpu.h:391:59: note: exp=
anded from macro=0A  'this_cpu_read_stable'=0A    #define this_cpu_read_sta=
ble(var)       percpu_stable_op("mov", var)=0A                             =
                                       ^~~=0A./arch/x86/include/asm/percpu.=
h:228:16: note: expanded from macro=0A  'percpu_stable_op'=0A    : "p" (&(v=
ar)));=0A             ^~~=0A=0ASigned-off-by: Matthias Kaehlcke <mka@chromi=
um.org>=0ACc: Doug Anderson <dianders@chromium.org>=0ACc: Linus Torvalds <t=
orvalds@linux-foundation.org>=0ACc: Masahiro Yamada <yamada.masahiro@socion=
ext.com>=0ACc: Peter Zijlstra <peterz@infradead.org>=0ACc: Thomas Gleixner =
<tglx@linutronix.de>=0ALink: http://lkml.kernel.org/r/20170725215053.135586=
-1-mka@chromium.org=0ASigned-off-by: Ingo Molnar <mingo@kernel.org>=0ASigne=
d-off-by: Nathan Chancellor <natechancellor@gmail.com>=0A---=0A arch/x86/bo=
ot/compressed/Makefile | 1 +=0A 1 file changed, 1 insertion(+)=0A=0Adiff --=
git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile=
=0Aindex cda8e14bd72a..89b163351e64 100644=0A--- a/arch/x86/boot/compressed=
/Makefile=0A+++ b/arch/x86/boot/compressed/Makefile=0A@@ -34,6 +34,7 @@ KBU=
ILD_CFLAGS +=3D $(cflags-y)=0A KBUILD_CFLAGS +=3D -mno-mmx -mno-sse=0A KBUI=
LD_CFLAGS +=3D $(call cc-option,-ffreestanding)=0A KBUILD_CFLAGS +=3D $(cal=
l cc-option,-fno-stack-protector)=0A+KBUILD_CFLAGS +=3D $(call cc-disable-w=
arning, address-of-packed-member)=0A =0A KBUILD_AFLAGS  :=3D $(KBUILD_CFLAG=
S) -D__ASSEMBLY__=0A GCOV_PROFILE :=3D n=0A-- =0A2.21.0=0A=0A=0AFrom 0f4b6f=
3baf1bc8d559c8fc95e019061d28f4c619 Mon Sep 17 00:00:00 2001=0AFrom: Matthia=
s Kaehlcke <mka@chromium.org>=0ADate: Mon, 17 Jul 2017 11:14:03 -0700=0ASub=
ject: [PATCH 6/7] drm/i915: Consistently use enum pipe for PCH transcoders=
=0A=0Acommit a21960339c8c107eae99d68c85e6355189b22192 upstream.=0A=0AThe cu=
rrent code uses in some instances enum transcoder for PCH=0Atranscoders and=
 enum pipe in others. This is error prone and clang=0Araises warnings like =
this:=0A=0Adrivers/gpu/drm/i915/intel_dp.c:3546:51: warning: implicit conve=
rsion=0A  from enumeration type 'enum pipe' to different enumeration type=
=0A  'enum transcoder' [-Wenum-conversion]=0A    intel_set_pch_fifo_underru=
n_reporting(dev_priv, PIPE_A, false);=0A=0AConsistently use the type enum p=
ipe for PCH transcoders.=0A=0ASigned-off-by: Matthias Kaehlcke <mka@chromiu=
m.org>=0ASigned-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>=0ALink: http=
s://patchwork.freedesktop.org/patch/msgid/20170717181403.57324-1-mka@chromi=
um.org=0A[nc: Backport to 4.9; adjust context and drop unneeded hunks]=0ASi=
gned-off-by: Nathan Chancellor <natechancellor@gmail.com>=0A---=0A drivers/=
gpu/drm/i915/i915_irq.c            | 10 +++++-----=0A drivers/gpu/drm/i915/=
intel_display.c       | 14 +++++++-------=0A drivers/gpu/drm/i915/intel_drv=
=2Eh           |  4 ++--=0A drivers/gpu/drm/i915/intel_fifo_underrun.c |  4=
 ++--=0A 4 files changed, 16 insertions(+), 16 deletions(-)=0A=0Adiff --git=
 a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c=0Ainde=
x 279d1e021421..685247c3d489 100644=0A--- a/drivers/gpu/drm/i915/i915_irq.c=
=0A+++ b/drivers/gpu/drm/i915/i915_irq.c=0A@@ -1985,10 +1985,10 @@ static v=
oid ibx_irq_handler(struct drm_i915_private *dev_priv, u32 pch_iir)=0A 		DR=
M_DEBUG_DRIVER("PCH transcoder CRC error interrupt\n");=0A =0A 	if (pch_iir=
 & SDE_TRANSA_FIFO_UNDER)=0A-		intel_pch_fifo_underrun_irq_handler(dev_priv=
, TRANSCODER_A);=0A+		intel_pch_fifo_underrun_irq_handler(dev_priv, PIPE_A)=
;=0A =0A 	if (pch_iir & SDE_TRANSB_FIFO_UNDER)=0A-		intel_pch_fifo_underrun=
_irq_handler(dev_priv, TRANSCODER_B);=0A+		intel_pch_fifo_underrun_irq_hand=
ler(dev_priv, PIPE_B);=0A }=0A =0A static void ivb_err_int_handler(struct d=
rm_i915_private *dev_priv)=0A@@ -2022,13 +2022,13 @@ static void cpt_serr_i=
nt_handler(struct drm_i915_private *dev_priv)=0A 		DRM_ERROR("PCH poison in=
terrupt\n");=0A =0A 	if (serr_int & SERR_INT_TRANS_A_FIFO_UNDERRUN)=0A-		in=
tel_pch_fifo_underrun_irq_handler(dev_priv, TRANSCODER_A);=0A+		intel_pch_f=
ifo_underrun_irq_handler(dev_priv, PIPE_A);=0A =0A 	if (serr_int & SERR_INT=
_TRANS_B_FIFO_UNDERRUN)=0A-		intel_pch_fifo_underrun_irq_handler(dev_priv, =
TRANSCODER_B);=0A+		intel_pch_fifo_underrun_irq_handler(dev_priv, PIPE_B);=
=0A =0A 	if (serr_int & SERR_INT_TRANS_C_FIFO_UNDERRUN)=0A-		intel_pch_fifo=
_underrun_irq_handler(dev_priv, TRANSCODER_C);=0A+		intel_pch_fifo_underrun=
_irq_handler(dev_priv, PIPE_C);=0A =0A 	I915_WRITE(SERR_INT, serr_int);=0A =
}=0Adiff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i91=
5/intel_display.c=0Aindex c185625d67f2..d915877b6ecb 100644=0A--- a/drivers=
/gpu/drm/i915/intel_display.c=0A+++ b/drivers/gpu/drm/i915/intel_display.c=
=0A@@ -1849,7 +1849,7 @@ static void lpt_enable_pch_transcoder(struct drm_i=
915_private *dev_priv,=0A =0A 	/* FDI must be feeding us bits for PCH ports=
 */=0A 	assert_fdi_tx_enabled(dev_priv, (enum pipe) cpu_transcoder);=0A-	as=
sert_fdi_rx_enabled(dev_priv, TRANSCODER_A);=0A+	assert_fdi_rx_enabled(dev_=
priv, PIPE_A);=0A =0A 	/* Workaround: set timing override bit. */=0A 	val =
=3D I915_READ(TRANS_CHICKEN2(PIPE_A));=0A@@ -1950,7 +1950,7 @@ static void =
intel_enable_pipe(struct intel_crtc *crtc)=0A 	assert_sprites_disabled(dev_=
priv, pipe);=0A =0A 	if (HAS_PCH_LPT(dev_priv))=0A-		pch_transcoder =3D TRA=
NSCODER_A;=0A+		pch_transcoder =3D PIPE_A;=0A 	else=0A 		pch_transcoder =3D=
 pipe;=0A =0A@@ -4636,7 +4636,7 @@ static void lpt_pch_enable(struct drm_cr=
tc *crtc)=0A 	struct intel_crtc *intel_crtc =3D to_intel_crtc(crtc);=0A 	en=
um transcoder cpu_transcoder =3D intel_crtc->config->cpu_transcoder;=0A =0A=
-	assert_pch_transcoder_disabled(dev_priv, TRANSCODER_A);=0A+	assert_pch_tr=
anscoder_disabled(dev_priv, PIPE_A);=0A =0A 	lpt_program_iclkip(crtc);=0A =
=0A@@ -5410,7 +5410,7 @@ static void haswell_crtc_enable(struct intel_crtc_=
state *pipe_config,=0A 		return;=0A =0A 	if (intel_crtc->config->has_pch_en=
coder)=0A-		intel_set_pch_fifo_underrun_reporting(dev_priv, TRANSCODER_A,=
=0A+		intel_set_pch_fifo_underrun_reporting(dev_priv, PIPE_A,=0A 						    =
  false);=0A =0A 	intel_encoders_pre_pll_enable(crtc, pipe_config, old_stat=
e);=0A@@ -5498,7 +5498,7 @@ static void haswell_crtc_enable(struct intel_cr=
tc_state *pipe_config,=0A 		intel_wait_for_vblank(dev, pipe);=0A 		intel_wa=
it_for_vblank(dev, pipe);=0A 		intel_set_cpu_fifo_underrun_reporting(dev_pr=
iv, pipe, true);=0A-		intel_set_pch_fifo_underrun_reporting(dev_priv, TRANS=
CODER_A,=0A+		intel_set_pch_fifo_underrun_reporting(dev_priv, PIPE_A,=0A 		=
				      true);=0A 	}=0A =0A@@ -5597,7 +5597,7 @@ static void haswell_crtc=
_disable(struct intel_crtc_state *old_crtc_state,=0A 	enum transcoder cpu_t=
ranscoder =3D intel_crtc->config->cpu_transcoder;=0A =0A 	if (intel_crtc->c=
onfig->has_pch_encoder)=0A-		intel_set_pch_fifo_underrun_reporting(dev_priv=
, TRANSCODER_A,=0A+		intel_set_pch_fifo_underrun_reporting(dev_priv, PIPE_A=
,=0A 						      false);=0A =0A 	intel_encoders_disable(crtc, old_crtc_stat=
e, old_state);=0A@@ -5626,7 +5626,7 @@ static void haswell_crtc_disable(str=
uct intel_crtc_state *old_crtc_state,=0A 	intel_encoders_post_disable(crtc,=
 old_crtc_state, old_state);=0A =0A 	if (old_crtc_state->has_pch_encoder)=
=0A-		intel_set_pch_fifo_underrun_reporting(dev_priv, TRANSCODER_A,=0A+		in=
tel_set_pch_fifo_underrun_reporting(dev_priv, PIPE_A,=0A 						      true);=
=0A }=0A =0Adiff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm=
/i915/intel_drv.h=0Aindex 6a9860df208f..8aafb9601540 100644=0A--- a/drivers=
/gpu/drm/i915/intel_drv.h=0A+++ b/drivers/gpu/drm/i915/intel_drv.h=0A@@ -10=
95,12 +1095,12 @@ static inline unsigned int intel_num_planes(struct intel_=
crtc *crtc)=0A bool intel_set_cpu_fifo_underrun_reporting(struct drm_i915_p=
rivate *dev_priv,=0A 					   enum pipe pipe, bool enable);=0A bool intel_se=
t_pch_fifo_underrun_reporting(struct drm_i915_private *dev_priv,=0A-					  =
 enum transcoder pch_transcoder,=0A+					   enum pipe pch_transcoder,=0A 		=
			   bool enable);=0A void intel_cpu_fifo_underrun_irq_handler(struct drm_=
i915_private *dev_priv,=0A 					 enum pipe pipe);=0A void intel_pch_fifo_un=
derrun_irq_handler(struct drm_i915_private *dev_priv,=0A-					 enum transco=
der pch_transcoder);=0A+					 enum pipe pch_transcoder);=0A void intel_chec=
k_cpu_fifo_underruns(struct drm_i915_private *dev_priv);=0A void intel_chec=
k_pch_fifo_underruns(struct drm_i915_private *dev_priv);=0A =0Adiff --git a=
/drivers/gpu/drm/i915/intel_fifo_underrun.c b/drivers/gpu/drm/i915/intel_fi=
fo_underrun.c=0Aindex 2aa744081f09..36075ba5deb8 100644=0A--- a/drivers/gpu=
/drm/i915/intel_fifo_underrun.c=0A+++ b/drivers/gpu/drm/i915/intel_fifo_und=
errun.c=0A@@ -311,7 +311,7 @@ bool intel_set_cpu_fifo_underrun_reporting(st=
ruct drm_i915_private *dev_priv,=0A  * Returns the previous state of underr=
un reporting.=0A  */=0A bool intel_set_pch_fifo_underrun_reporting(struct d=
rm_i915_private *dev_priv,=0A-					   enum transcoder pch_transcoder,=0A+		=
			   enum pipe pch_transcoder,=0A 					   bool enable)=0A {=0A 	struct drm=
_crtc *crtc =3D dev_priv->pipe_to_crtc_mapping[pch_transcoder];=0A@@ -384,7=
 +384,7 @@ void intel_cpu_fifo_underrun_irq_handler(struct drm_i915_private=
 *dev_priv,=0A  * interrupt to avoid an irq storm.=0A  */=0A void intel_pch=
_fifo_underrun_irq_handler(struct drm_i915_private *dev_priv,=0A-					 enum=
 transcoder pch_transcoder)=0A+					 enum pipe pch_transcoder)=0A {=0A 	if =
(intel_set_pch_fifo_underrun_reporting(dev_priv, pch_transcoder,=0A 						 =
 false))=0A-- =0A2.21.0=0A=0A=0AFrom f0cd73d0aa366ab4b1812bb87effe68e78eef6=
f8 Mon Sep 17 00:00:00 2001=0AFrom: =3D?UTF-8?q?Ville=3D20Syrj=3DC3=3DA4l=
=3DC3=3DA4?=3D <ville.syrjala@linux.intel.com>=0ADate: Fri, 1 Sep 2017 17:3=
1:23 +0300=0ASubject: [PATCH 7/7] drm/i915: Fix enum pipe vs. enum transcod=
er for the PCH=0A transcoder=0AMIME-Version: 1.0=0AContent-Type: text/plain=
; charset=3DUTF-8=0AContent-Transfer-Encoding: 8bit=0A=0Acommit 41c32e5da3f=
f3922490341a988b2a3ae46d0b6a8 upstream.=0A=0AUse enum pipe for PCH transcod=
ers also in the FIFO underrun code.=0A=0AFixes the following new sparse war=
nings:=0Aintel_fifo_underrun.c:340:49: warning: mixing different enum types=
=0Aintel_fifo_underrun.c:340:49:     int enum pipe  versus=0Aintel_fifo_und=
errun.c:340:49:     int enum transcoder=0Aintel_fifo_underrun.c:344:49: war=
ning: mixing different enum types=0Aintel_fifo_underrun.c:344:49:     int e=
num pipe  versus=0Aintel_fifo_underrun.c:344:49:     int enum transcoder=0A=
intel_fifo_underrun.c:397:57: warning: mixing different enum types=0Aintel_=
fifo_underrun.c:397:57:     int enum pipe  versus=0Aintel_fifo_underrun.c:3=
97:57:     int enum transcoder=0Aintel_fifo_underrun.c:398:17: warning: mix=
ing different enum types=0Aintel_fifo_underrun.c:398:17:     int enum pipe =
 versus=0Aintel_fifo_underrun.c:398:17:     int enum transcoder=0A=0ACc: Ma=
tthias Kaehlcke <mka@chromium.org>=0AFixes: a21960339c8c ("drm/i915: Consis=
tently use enum pipe for PCH transcoders")=0ASigned-off-by: Ville Syrj=C3=
=A4l=C3=A4 <ville.syrjala@linux.intel.com>=0ALink: https://patchwork.freede=
sktop.org/patch/msgid/20170901143123.7590-3-ville.syrjala@linux.intel.com=
=0AReviewed-by: Chris Wilson <chris@chris-wilson.co.uk>=0A[nc: Backport to =
4.9, drop unneeded hunks]=0ASigned-off-by: Nathan Chancellor <natechancello=
r@gmail.com>=0A---=0A drivers/gpu/drm/i915/intel_fifo_underrun.c | 20 +++++=
+++++----------=0A 1 file changed, 10 insertions(+), 10 deletions(-)=0A=0Ad=
iff --git a/drivers/gpu/drm/i915/intel_fifo_underrun.c b/drivers/gpu/drm/i9=
15/intel_fifo_underrun.c=0Aindex 36075ba5deb8..b6b64a2d4b71 100644=0A--- a/=
drivers/gpu/drm/i915/intel_fifo_underrun.c=0A+++ b/drivers/gpu/drm/i915/int=
el_fifo_underrun.c=0A@@ -185,11 +185,11 @@ static void broadwell_set_fifo_u=
nderrun_reporting(struct drm_device *dev,=0A }=0A =0A static void ibx_set_f=
ifo_underrun_reporting(struct drm_device *dev,=0A-					    enum transcoder =
pch_transcoder,=0A+					    enum pipe pch_transcoder,=0A 					    bool enab=
le)=0A {=0A 	struct drm_i915_private *dev_priv =3D to_i915(dev);=0A-	uint32=
_t bit =3D (pch_transcoder =3D=3D TRANSCODER_A) ?=0A+	uint32_t bit =3D (pch=
_transcoder =3D=3D PIPE_A) ?=0A 		       SDE_TRANSA_FIFO_UNDER : SDE_TRANSB=
_FIFO_UNDER;=0A =0A 	if (enable)=0A@@ -201,7 +201,7 @@ static void ibx_set_=
fifo_underrun_reporting(struct drm_device *dev,=0A static void cpt_check_pc=
h_fifo_underruns(struct intel_crtc *crtc)=0A {=0A 	struct drm_i915_private =
*dev_priv =3D to_i915(crtc->base.dev);=0A-	enum transcoder pch_transcoder =
=3D (enum transcoder) crtc->pipe;=0A+	enum pipe pch_transcoder =3D crtc->pi=
pe;=0A 	uint32_t serr_int =3D I915_READ(SERR_INT);=0A =0A 	assert_spin_lock=
ed(&dev_priv->irq_lock);=0A@@ -212,12 +212,12 @@ static void cpt_check_pch_=
fifo_underruns(struct intel_crtc *crtc)=0A 	I915_WRITE(SERR_INT, SERR_INT_T=
RANS_FIFO_UNDERRUN(pch_transcoder));=0A 	POSTING_READ(SERR_INT);=0A =0A-	DR=
M_ERROR("pch fifo underrun on pch transcoder %s\n",=0A-		  transcoder_name(=
pch_transcoder));=0A+	DRM_ERROR("pch fifo underrun on pch transcoder %c\n",=
=0A+		  pipe_name(pch_transcoder));=0A }=0A =0A static void cpt_set_fifo_un=
derrun_reporting(struct drm_device *dev,=0A-					    enum transcoder pch_tr=
anscoder,=0A+					    enum pipe pch_transcoder,=0A 					    bool enable, bo=
ol old)=0A {=0A 	struct drm_i915_private *dev_priv =3D to_i915(dev);=0A@@ -=
235,8 +235,8 @@ static void cpt_set_fifo_underrun_reporting(struct drm_devi=
ce *dev,=0A =0A 		if (old && I915_READ(SERR_INT) &=0A 		    SERR_INT_TRANS_=
FIFO_UNDERRUN(pch_transcoder)) {=0A-			DRM_ERROR("uncleared pch fifo underr=
un on pch transcoder %s\n",=0A-				  transcoder_name(pch_transcoder));=0A+	=
		DRM_ERROR("uncleared pch fifo underrun on pch transcoder %c\n",=0A+				  =
pipe_name(pch_transcoder));=0A 		}=0A 	}=0A }=0A@@ -388,8 +388,8 @@ void in=
tel_pch_fifo_underrun_irq_handler(struct drm_i915_private *dev_priv,=0A {=
=0A 	if (intel_set_pch_fifo_underrun_reporting(dev_priv, pch_transcoder,=0A=
 						  false))=0A-		DRM_ERROR("PCH transcoder %s FIFO underrun\n",=0A-			=
  transcoder_name(pch_transcoder));=0A+		DRM_ERROR("PCH transcoder %c FIFO =
underrun\n",=0A+			  pipe_name(pch_transcoder));=0A }=0A =0A /**=0A-- =0A2.=
21.0=0A=0A
--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="android-4.9-Makefile.diff"

diff --git a/Makefile b/Makefile
index 1b3780acf7c6..e493143bfde1 100644
--- a/Makefile
+++ b/Makefile
@@ -306,11 +306,6 @@ HOSTCXX      = g++
 HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu89
 HOSTCXXFLAGS = -O2
 
-ifeq ($(shell $(HOSTCC) -v 2>&1 | grep -c "clang version"), 1)
-HOSTCFLAGS  += -Wno-unused-value -Wno-unused-parameter \
-		-Wno-missing-field-initializers -fno-delete-null-pointer-checks
-endif
-
 # Decide whether to build built-in, modular, or both.
 # Normally, just do built-in.
 
@@ -513,40 +508,20 @@ endif
 ifeq ($(cc-name),clang)
 ifneq ($(CROSS_COMPILE),)
 CLANG_TRIPLE	?= $(CROSS_COMPILE)
-CLANG_TARGET	:= --target=$(notdir $(CLANG_TRIPLE:%-=%))
-ifeq ($(shell $(srctree)/scripts/clang-android.sh $(CC) $(CLANG_TARGET)), y)
+CLANG_FLAGS	:= --target=$(notdir $(CLANG_TRIPLE:%-=%))
+ifeq ($(shell $(srctree)/scripts/clang-android.sh $(CC) $(CLANG_FLAGS)), y)
 $(error "Clang with Android --target detected. Did you specify CLANG_TRIPLE?")
 endif
 GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
-CLANG_PREFIX	:= --prefix=$(GCC_TOOLCHAIN_DIR)
+CLANG_FLAGS	+= --prefix=$(GCC_TOOLCHAIN_DIR)
 GCC_TOOLCHAIN	:= $(realpath $(GCC_TOOLCHAIN_DIR)/..)
 endif
 ifneq ($(GCC_TOOLCHAIN),)
-CLANG_GCC_TC	:= --gcc-toolchain=$(GCC_TOOLCHAIN)
+CLANG_FLAGS	+= --gcc-toolchain=$(GCC_TOOLCHAIN)
 endif
-KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
-KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
-KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-variable)
-KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
-KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
-KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
-KBUILD_CFLAGS += $(call cc-disable-warning, duplicate-decl-specifier)
-# Quiet clang warning: comparison of unsigned expression < 0 is always false
-KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
-# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
-# source of a reference will be _MergedGlobals and not on of the whitelisted names.
-# See modpost pattern 2
-KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
-KBUILD_CFLAGS += $(call cc-option, -fcatch-undefined-behavior)
-KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
-KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
-else
-
-# These warnings generated too much noise in a regular build.
-# Use make W=1 to enable them (see scripts/Makefile.build)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
+CLANG_FLAGS	+= -no-integrated-as
+KBUILD_CFLAGS	+= $(CLANG_FLAGS)
+KBUILD_AFLAGS	+= $(CLANG_FLAGS)
 endif
 
 
@@ -806,6 +781,27 @@ ifdef CONFIG_CC_STACKPROTECTOR
 endif
 KBUILD_CFLAGS += $(stackp-flag)
 
+ifeq ($(cc-name),clang)
+KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
+KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
+KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
+KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
+KBUILD_CFLAGS += $(call cc-disable-warning, duplicate-decl-specifier)
+# Quiet clang warning: comparison of unsigned expression < 0 is always false
+KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
+# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
+# source of a reference will be _MergedGlobals and not on of the whitelisted names.
+# See modpost pattern 2
+KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
+KBUILD_CFLAGS += $(call cc-option, -fcatch-undefined-behavior)
+else
+
+# These warnings generated too much noise in a regular build.
+# Use make W=1 to enable them (see scripts/Makefile.extrawarn)
+KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
+endif
+
+KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
 ifdef CONFIG_FRAME_POINTER
 KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
 else

--n8g4imXOkfNTN/H1--
