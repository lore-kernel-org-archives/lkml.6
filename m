Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeENWI5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 18:08:57 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34935 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeENWIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 18:08:55 -0400
X-Google-Smtp-Source: AB8JxZpEwsQNmtPj/YzQVpHn9DKtPQAjOQAtAgqqcbKtxtoa71V1tMVhqmxOuTtrmGriUBJYfkzITg==
Date: Tue, 15 May 2018 01:08:52 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip:x86/pti 14/14] arch/x86/mm/mem_encrypt_boot.o: warning:
 objtool: .text+0x51: unreachable instruction
Message-ID: <20180514220852.GA8281@avx2>
References: <201805142145.FPNj1BCK%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201805142145.FPNj1BCK%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 09:44:48PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/pti
> head:   51bad67ffbce0aaa44579f84ef5d05597054ec6a
> commit: 51bad67ffbce0aaa44579f84ef5d05597054ec6a [14/14] x86/asm: Pad assembly functions with INT3 instructions
> config: x86_64-randconfig-x018-201819 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         git checkout 51bad67ffbce0aaa44579f84ef5d05597054ec6a
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/x86/mm/mem_encrypt_boot.o: warning: objtool: .text+0x51: unreachable instruction
> >> arch/x86/xen/xen-asm.o: warning: objtool: .text+0x1a: unreachable instruction

There are warnings:

	arch/x86/lib/clear_page_64.o: warning: objtool: .text+0xb: unreachable instruction

	0000000000000000 <clear_page_rep>:
	   0:   b9 00 02 00 00          mov    ecx,0x200
	   5:   31 c0                   xor    eax,eax
	   7:   f3 48 ab                rep stos QWORD PTR es:[rdi],rax
	   a:   c3                      ret
  ===>	   b:   cc                      int3
	   c:   cc                      int3
	   d:   cc                      int3
	   e:   cc                      int3
	   f:   cc                      int3
	
	0000000000000010 <clear_page_orig>:

But both function are annotated with ENTRY/ENDPROC.
