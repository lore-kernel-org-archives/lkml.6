Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeBRIHF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 03:07:05 -0500
Received: from mail-pl0-f45.google.com ([209.85.160.45]:37543 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbeBRIHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 03:07:04 -0500
X-Google-Smtp-Source: AH8x227rOaiR3D9Iw5xpJTOmHwBfdnZ+A4ebZsODIN4EPDSNKI4QEDOV/2vdvF2tCxlLMV/Py0PGZA==
Message-ID: <1518941218.12663.1.camel@gmail.com>
Subject: Use of GCC plugin instead ISO C
From: Progyan Bhattacharya <bprogyan@gmail.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Sun, 18 Feb 2018 13:36:58 +0530
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Again,

According to last time talked, you said me to avoid "-Werror=pedantic"
flag to build the GNU specific plugins instead of Standard ISO C. I
changed my default compiler flags and tried to rebuild. But I am still
getting the same error messages at:

	CC /***/Linux/tools/objtool/arch/x86/decode.o

All of them were arising due to same "-pedantic" flag being enabled.
1. Range expression in Case statements were not allowed.
2. Use of braced-group were not allowed in MACRO definition.
3. Pointer arithmetic with void pointer was not allowed.

I took a look on related Makefiles, but found none with "-pedantic" or
"-Werror=pedantic" flag.

Flags I found being used in compilation so far,

tools/objtool/Makefile:
	-Wall -Werror -Wno-switch-default -Wno-switch-enum -Wno-packed
tools/scripts/Makefile.include:
	-Wbad-function-cast -Wdeclaration-after-statement -Wformat-
security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-
prototypes -Wnested-externs -Wno-system-headers -Wold-style-definition
-Wpacked -Wredundant-decls -Wshadow -Wstrict-prototypes -Wswitch-
default -Wswitch-enum -Wundef -Wwrite-strings -Wformat

Compiler I am using:
	gcc version 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC)

Thanks in advance.
-- 
Regards,
Progyan Bhattacharya
(http://codeprogyan.me)
