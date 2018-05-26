Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932961AbeEZEfh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 00:35:37 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:43291 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751136AbeEZEfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 00:35:36 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Paul Menzel <pmenzel+linuxppc-dev@molgen.mpg.de>
Subject: arch/powerpc/kernel/head_32.S:1106: Error: missing operand
Message-ID: <e015d6b2-79b8-e05d-5053-5ca0036679d3@molgen.mpg.de>
Date: Sat, 26 May 2018 06:35:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Building the configuration created with `make tinyconfig` on the Power 8 
system IBM S822LC with Ubuntu 18.04 fails with the error below.

```
$ git describe --dirty
v4.17-rc6-296-gbc2dbc5420e8
$ git log --oneline -1
bc2dbc5420e8 (HEAD -> master, origin/master, origin/HEAD) Merge branch 
'akpm' (patches from Andrew)
$ make tinyconfig
$ make -j120
[…]
   AS      arch/powerpc/kernel/head_32.o
arch/powerpc/kernel/head_32.S: Assembler messages:
arch/powerpc/kernel/head_32.S:1106: Error: missing operand
scripts/Makefile.build:413: recipe for target 
'arch/powerpc/kernel/head_32.o' failed
make[1]: *** [arch/powerpc/kernel/head_32.o] Error 1
[…]
```

Is this expected? *ppc64_defconfig* and *ppc64e_defconfig* build fine.


Kind regards,

Paul
