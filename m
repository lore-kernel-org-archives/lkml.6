Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681043-2-16690895025434623628
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681042; b=oAqUA1uZvi+WZLktrPInT/FG/Q2P8K9jJ1vh5SUh/1ocCcI
    Hzuthi0MGUZ/FY1Fhegbq/IxJcZLccPEvHtIPl6I0nB4lVOxdNbuQfS6SwUW2x6F
    +tgeXELDOQ+eBw5H6Zf49dDY3HC1bkjLIuXcbpPqjX5cmHOoZi20Ke9FWW9zSSF/
    RuQVFqPfSStyQPgB2ufnBqI+mmrVZffWIkKS7e6dXGxd8kHtHu/aPRGL5eTWnOz2
    52bYj9aK6Z8CBFeaqMz+PB8Kq9Np3EGvFJpqDvSANh8uF7a/SZTWaKWSIhauUF7W
    aldN5NpRFxeIdSZ+wJFR/qSmZ3nVyj7OcP1xNrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681042; bh=MzfuvR
    xjIuldLkIVxdFrLf/Uc6J9EgnlfzZhgBUkOqk=; b=mb6pWNf5WZ3th+aniB8ahW
    W5NMhqQ908kd6RZwSakt42gucR+Ins2mvSSiiP1hGEgvCmAv3Joa1xQ4lUg+eMJj
    PY2jZOy4SmzM6Ub0Oftb24tzOpmmno99jdHHzM2hbhNTdda0k/uHAeI8qSuUmPpn
    ky8TVACoNuOqG75OFa28DTCXqADcc4qOlbgAuuLpMH2jTvun7lO55E6oeD+/EDvG
    K9LmrrNUT7Ak0gzOJ6tw488DZccP1N/zqxgKgO1nVIP5UryYm2+/ScondX4gaiKa
    kKIzI1GcC9k1O5glrbqNrRc+e/EEv2cmqOTPVIK+iF17T9nby0hhyoELUhKh7TAQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZIh/579W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZIh/579W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752895AbeBCSDm (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:03:42 -0500
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:24267
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752986AbeBCSBu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:01:50 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 018/110] x86/asm: Allow again using asm.h
 when building for the 'bpf' clang target
Thread-Topic: [PATCH AUTOSEL for 4.14 018/110] x86/asm: Allow again using
 asm.h when building for the 'bpf' clang target
Thread-Index: AQHTnRjkKnWfU7jMuEWm/uCdtOyT2g==
Date: Sat, 3 Feb 2018 18:00:36 +0000
Message-ID: <20180203180015.29073-18-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1043;7:+tFkuEYDT4U8C8bIBb9a9Ec2+2OMYhq0NpROGi7BUMqXFjSBeQ7Ol2vYTol5tgj5i3CrCQNSeMLcdP1M0rEJpbKK4nD1Ygh12H7xAnme1fkNIQZiAc1LyY9iEh4NIuM2Dmue5uWJNCPF7C4Gk7XaVu43sr9BxhFujKNJotYmlBr9Jf++NVDAD25INFEBrdlBthCRYpHEqltsWnyANKw+6SK5BE4TqRaJ+QOgR+EJ6AkO+Qqj6l7mhlxZ3VBpI5H/
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b15a402-3cd3-4335-cf0b-08d56b300808
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1043;
x-ms-traffictypediagnostic: BL0PR2101MB1043:
x-microsoft-antispam-prvs: <BL0PR2101MB10436FF4095C3461D5A09B5DFBF80@BL0PR2101MB1043.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(67672495146484)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1043;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1043;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(59450400001)(10290500003)(186003)(6486002)(14454004)(1076002)(102836004)(6306002)(6506007)(76176011)(26005)(6346003)(66066001)(10090500001)(5250100002)(36756003)(6512007)(2501003)(110136005)(99286004)(966005)(54906003)(478600001)(7416002)(53936002)(72206003)(6436002)(316002)(305945005)(7736002)(2950100002)(2906002)(5660300001)(4326008)(106356001)(86362001)(97736004)(25786009)(22452003)(39060400002)(2900100001)(3846002)(107886003)(8676002)(8936002)(6116002)(3280700002)(105586002)(81156014)(81166006)(3660700001)(86612001)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1043;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: XdTPBQZkzSePM2+VEI7VWFJa4ikh9758NJXWYjFc7t9C3h6Oyv6iOpkx1+s0u1Slq8BbnVqyv/wOscivnE40Jw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b15a402-3cd3-4335-cf0b-08d56b300808
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:36.0346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1043
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit ca26cffa4e4aaeb09bb9e308f95c7835cb149248 ]

Up to f5caf621ee35 ("x86/asm: Fix inline asm call constraints for Clang")
we were able to use x86 headers to build to the 'bpf' clang target, as
done by the BPF code in tools/perf/.

With that commit, we ended up with following failure for 'perf test LLVM', =
this
is because "clang ... -target bpf ..." fails since 4.0 does not have bpf in=
line
asm support and 6.0 does not recognize the register 'esp', fix it by guardi=
ng
that part with an #ifndef __BPF__, that is defined by clang when building t=
o
the "bpf" target.

  # perf test -v LLVM
  37: LLVM search and compile                               :
  37.1: Basic BPF llvm compile                              :
  --- start ---
  test child forked, pid 25526
  Kernel build dir is set to /lib/modules/4.14.0+/build
  set env: KBUILD_DIR=3D/lib/modules/4.14.0+/build
  unset env: KBUILD_OPTS
  include option is set to  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-l=
inux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include=
/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/git/lin=
ux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/g=
it/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/li=
nux/include/linux/kconfig.h
  set env: NR_CPUS=3D4
  set env: LINUX_VERSION_CODE=3D0x40e00
  set env: CLANG_EXEC=3D/usr/local/bin/clang
  set env: CLANG_OPTIONS=3D-xc
  set env: KERNEL_INC_OPTIONS=3D -nostdinc -isystem /usr/lib/gcc/x86_64-red=
hat-linux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/in=
clude/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/gi=
t/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/a=
cme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/g=
it/linux/include/linux/kconfig.h
  set env: WORKING_DIR=3D/lib/modules/4.14.0+/build
  set env: CLANG_SOURCE=3D-
  llvm compiling command template: echo '/*
   * bpf-script-example.c
   * Test basic LLVM building
   */
  #ifndef LINUX_VERSION_CODE
  # error Need LINUX_VERSION_CODE
  # error Example: for 4.2 kernel, put 'clang-opt=3D"-DLINUX_VERSION_CODE=
=3D0x40200" into llvm section of ~/.perfconfig'
  #endif
  #define BPF_ANY 0
  #define BPF_MAP_TYPE_ARRAY 2
  #define BPF_FUNC_map_lookup_elem 1
  #define BPF_FUNC_map_update_elem 2

  static void *(*bpf_map_lookup_elem)(void *map, void *key) =3D
	  (void *) BPF_FUNC_map_lookup_elem;
  static void *(*bpf_map_update_elem)(void *map, void *key, void *value, in=
t flags) =3D
	  (void *) BPF_FUNC_map_update_elem;

  struct bpf_map_def {
	  unsigned int type;
	  unsigned int key_size;
	  unsigned int value_size;
	  unsigned int max_entries;
  };

  #define SEC(NAME) __attribute__((section(NAME), used))
  struct bpf_map_def SEC("maps") flip_table =3D {
	  .type =3D BPF_MAP_TYPE_ARRAY,
	  .key_size =3D sizeof(int),
	  .value_size =3D sizeof(int),
	  .max_entries =3D 1,
  };

  SEC("func=3DSyS_epoll_wait")
  int bpf_func__SyS_epoll_wait(void *ctx)
  {
	  int ind =3D0;
	  int *flag =3D bpf_map_lookup_elem(&flip_table, &ind);
	  int new_flag;
	  if (!flag)
		  return 0;
	  /* flip flag and store back */
	  new_flag =3D !*flag;
	  bpf_map_update_elem(&flip_table, &ind, &new_flag, BPF_ANY);
	  return new_flag;
  }
  char _license[] SEC("license") =3D "GPL";
  int _version SEC("version") =3D LINUX_VERSION_CODE;
  ' | $CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=3D$NR_CPUS -DLINUX_VERSION_COD=
E=3D$LINUX_VERSION_CODE $CLANG_OPTIONS $KERNEL_INC_OPTIONS -Wno-unused-valu=
e -Wno-pointer-sign -working-directory $WORKING_DIR -c "$CLANG_SOURCE" -tar=
get bpf -O2 -o -
  test child finished with 0
  ---- end ----
  LLVM search and compile subtest 0: Ok
  37.2: kbuild searching                                    :
  --- start ---
  test child forked, pid 25950
  Kernel build dir is set to /lib/modules/4.14.0+/build
  set env: KBUILD_DIR=3D/lib/modules/4.14.0+/build
  unset env: KBUILD_OPTS
  include option is set to  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-l=
inux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include=
/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/git/lin=
ux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/g=
it/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/li=
nux/include/linux/kconfig.h
  set env: NR_CPUS=3D4
  set env: LINUX_VERSION_CODE=3D0x40e00
  set env: CLANG_EXEC=3D/usr/local/bin/clang
  set env: CLANG_OPTIONS=3D-xc
  set env: KERNEL_INC_OPTIONS=3D -nostdinc -isystem /usr/lib/gcc/x86_64-red=
hat-linux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/in=
clude/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/gi=
t/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/a=
cme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/g=
it/linux/include/linux/kconfig.h
  set env: WORKING_DIR=3D/lib/modules/4.14.0+/build
  set env: CLANG_SOURCE=3D-
  llvm compiling command template: echo '/*
   * bpf-script-test-kbuild.c
   * Test include from kernel header
   */
  #ifndef LINUX_VERSION_CODE
  # error Need LINUX_VERSION_CODE
  # error Example: for 4.2 kernel, put 'clang-opt=3D"-DLINUX_VERSION_CODE=
=3D0x40200" into llvm section of ~/.perfconfig'
  #endif
  #define SEC(NAME) __attribute__((section(NAME), used))

  #include <uapi/linux/fs.h>
  #include <uapi/asm/ptrace.h>

  SEC("func=3Dvfs_llseek")
  int bpf_func__vfs_llseek(void *ctx)
  {
	  return 0;
  }

  char _license[] SEC("license") =3D "GPL";
  int _version SEC("version") =3D LINUX_VERSION_CODE;
  ' | $CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=3D$NR_CPUS -DLINUX_VERSION_COD=
E=3D$LINUX_VERSION_CODE $CLANG_OPTIONS $KERNEL_INC_OPTIONS -Wno-unused-valu=
e -Wno-pointer-sign -working-directory $WORKING_DIR -c "$CLANG_SOURCE" -tar=
get bpf -O2 -o -
  In file included from <stdin>:12:
  In file included from /home/acme/git/linux/arch/x86/include/uapi/asm/ptra=
ce.h:5:
  In file included from /home/acme/git/linux/include/linux/compiler.h:242:
  In file included from /home/acme/git/linux/arch/x86/include/asm/barrier.h=
:5:
  In file included from /home/acme/git/linux/arch/x86/include/asm/alternati=
ve.h:10:
  /home/acme/git/linux/arch/x86/include/asm/asm.h:145:50: error: unknown re=
gister name 'esp' in asm
  register unsigned long current_stack_pointer asm(_ASM_SP);
                                                   ^
  /home/acme/git/linux/arch/x86/include/asm/asm.h:44:18: note: expanded fro=
m macro '_ASM_SP'
  #define _ASM_SP         __ASM_REG(sp)
                          ^
  /home/acme/git/linux/arch/x86/include/asm/asm.h:27:32: note: expanded fro=
m macro '__ASM_REG'
  #define __ASM_REG(reg)         __ASM_SEL_RAW(e##reg, r##reg)
                                 ^
  /home/acme/git/linux/arch/x86/include/asm/asm.h:18:29: note: expanded fro=
m macro '__ASM_SEL_RAW'
  # define __ASM_SEL_RAW(a,b) __ASM_FORM_RAW(a)
                              ^
  /home/acme/git/linux/arch/x86/include/asm/asm.h:11:32: note: expanded fro=
m macro '__ASM_FORM_RAW'
  # define __ASM_FORM_RAW(x)     #x
                                 ^
  <scratch space>:4:1: note: expanded from here
  "esp"
  ^
  1 error generated.
  ERROR:	unable to compile -
  Hint:	Check error message shown above.
  Hint:	You can also pre-compile it into .o using:
     		  clang -target bpf -O2 -c -
     	  with proper -I and -D options.
  Failed to compile test case: 'kbuild searching'
  test child finished with -1
  ---- end ----
  LLVM search and compile subtest 1: FAILED!

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/r/20171128175948.GL3298@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/include/asm/asm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 219faaec51df..386a6900e206 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -136,6 +136,7 @@
 #endif
=20
 #ifndef __ASSEMBLY__
+#ifndef __BPF__
 /*
  * This output constraint should be used for any inline asm which has a "c=
all"
  * instruction.  Otherwise the asm may be inserted before the frame pointe=
r
@@ -145,5 +146,6 @@
 register unsigned long current_stack_pointer asm(_ASM_SP);
 #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
 #endif
+#endif
=20
 #endif /* _ASM_X86_ASM_H */
--=20
2.11.0
