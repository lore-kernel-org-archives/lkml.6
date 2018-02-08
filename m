Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeBHOeZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:34:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751079AbeBHOeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:34:24 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF6E20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Thu, 8 Feb 2018 23:34:21 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: arch/x86/tools/insn_decoder_test: warning: ffffffff810005ac: 0f
 ff e9 ud0    %ecx,%ebp
Message-Id: <20180208233421.ae91bc45d5c264eb85c52e05@kernel.org>
In-Reply-To: <201802080625.McxPAKsk%fengguang.wu@intel.com>
References: <201802080625.McxPAKsk%fengguang.wu@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2018 06:04:45 +0800
kbuild test robot <fengguang.wu@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7590e37bdaeec25ae325f4ba450be13e2aac6c8d
> commit: 10c91577d5e631773a6394e14cf60125389b71ae x86/tools: Standardize output format of insn_decode_test
> date:   8 weeks ago
> config: x86_64-randconfig-s2-02072130 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>         git checkout 10c91577d5e631773a6394e14cf60125389b71ae
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
> >> arch/x86/tools/insn_decoder_test: warning: ffffffff810005ac:	0f ff e9             	ud0    %ecx,%ebp

Does UD0 really take an operand? Hmm, indeed, the latest Intel SDM (December2017) says

NOTES:
1. Some older processors decode the UD0 instruction without a ModR/M byte. As a result, those processors would deliver an invalid-
opcode exception instead of a fault on instruction fetch when the instruction with a ModR/M byte (and any implied bytes) would
cross a page or segment boundary.

and older SDM (e.g. March 2017) says UD0 has no modrm byte.
It is easy to change x86-opecode-map.txt, but this means this test may fail with older objdump...

>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff8100207e:	0f ff eb             	ud0    %ebx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff81002218:	0f ff e9             	ud0    %ecx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff81002317:	0f ff e9             	ud0    %ecx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff810029f4:	0f ff e9             	ud0    %ecx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff81002af4:	0f ff eb             	ud0    %ebx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff81002c27:	0f ff eb             	ud0    %ebx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff81002da5:	0f ff eb             	ud0    %ebx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff81002dd5:	0f ff eb             	ud0    %ebx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff81002eda:	0f ff 65 8b          	ud0    -0x75(%rbp),%esp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 4 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff81002f58:	0f ff eb             	ud0    %ebx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff810030c6:	0f ff eb             	ud0    %ebx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff81003158:	0f ff 5b 5d          	ud0    0x5d(%rbx),%ebx
>    arch/x86/tools/insn_decoder_test: warning: objdump says 4 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff8100404c:	0f ff 5b 5d          	ud0    0x5d(%rbx),%ebx
>    arch/x86/tools/insn_decoder_test: warning: objdump says 4 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff81004053:	0f ff eb             	ud0    %ebx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff81004056:	f7 0f ff eb ab 0f    	testl  $0xfabebff,(%rdi)
>    arch/x86/tools/insn_decoder_test: warning: objdump says 6 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff81005004:	0f ff eb             	ud0    %ebx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff81005039:	0f ff eb             	ud0    %ebx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff810052a4:	0f ff eb             	ud0    %ebx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff81005889:	0f ff eb             	ud0    %ebx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff8100588d:	0f ff eb             	ud0    %ebx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff810059a1:	0f ff eb             	ud0    %ebx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff81005a3a:	0f ff eb             	ud0    %ebx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff8100609f:	0f ff c3             	ud0    %ebx,%eax
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff8100617c:	0f ff eb             	ud0    %ebx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff8100620a:	0f ff eb             	ud0    %ebx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff8100652b:	0f ff c3             	ud0    %ebx,%eax
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff8100655a:	0f ff e9             	ud0    %ecx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff810069ce:	0f ff eb             	ud0    %ebx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff81007332:	0f ff c3             	ud0    %ebx,%eax
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff81007382:	0f ff c3             	ud0    %ebx,%eax
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff81007c1f:	0f ff 41 8b          	ud0    -0x75(%rcx),%eax
>    arch/x86/tools/insn_decoder_test: warning: objdump says 4 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff81007c2f:	0f ff eb             	ud0    %ebx,%ebp
>    arch/x86/tools/insn_decoder_test: warning: objdump says 3 bytes, but insn_get_length() says 2
>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
>    arch/x86/tools/insn_decoder_test: warning: ffffffff81008a3c:	0f ff 5b 5d          	ud0    0x5d(%rbx),%ebx
>    arch/x86/tools/insn_decoder_test: warning: objdump says 4 bytes, but insn_get_length() says 2
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


-- 
Masami Hiramatsu <mhiramat@kernel.org>
