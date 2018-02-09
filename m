Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeBIAaZ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 19:30:25 -0500
Received: from mga07.intel.com ([134.134.136.100]:36564 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752013AbeBIAaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 19:30:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,481,1511856000";
   d="scan'208";a="16630697"
From: "Hao, Shun" <shun.hao@intel.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
        "Wu, Fengguang" <fengguang.wu@intel.com>
CC: Ingo Molnar <mingo@kernel.org>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hao, Shun" <shun.hao@intel.com>
Subject: RE: [kbuild-all] arch/x86/tools/insn_decoder_test: warning:
 ffffffff810005ac: 0f ff e9 ud0 %ecx, %ebp
Thread-Topic: [kbuild-all] arch/x86/tools/insn_decoder_test: warning:
 ffffffff810005ac: 0f ff e9 ud0 %ecx, %ebp
Thread-Index: AQHToOnxjHkyPcSq4E+De9dasWkAVaObNwZg
Date: Fri, 9 Feb 2018 00:30:20 +0000
Message-ID: <FA205DA42E4CA94F8A738F66E929C3D4533476A3@SHSMSX104.ccr.corp.intel.com>
References: <201802080625.McxPAKsk%fengguang.wu@intel.com>
 <20180208233421.ae91bc45d5c264eb85c52e05@kernel.org>
In-Reply-To: <20180208233421.ae91bc45d5c264eb85c52e05@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Masami, so that explains why a lot of these warnings come out just after 
we upgrading to gcc-7.3 (now the objdump version is 2.30). 
Currently we've already ignore these warnings and won't send this report. 

>-----Original Message-----
>From: kbuild-all [mailto:kbuild-all-bounces@lists.01.org] On Behalf Of Masami
>Hiramatsu
>Sent: Thursday, February 8, 2018 10:34 PM
>To: Wu, Fengguang <fengguang.wu@intel.com>
>Cc: Ingo Molnar <mingo@kernel.org>; kbuild-all@01.org; linux-
>kernel@vger.kernel.org
>Subject: Re: [kbuild-all] arch/x86/tools/insn_decoder_test: warning: ffffffff810005ac:
>0f ff e9 ud0 %ecx, %ebp
>
>On Thu, 8 Feb 2018 06:04:45 +0800
>kbuild test robot <fengguang.wu@intel.com> wrote:
>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   7590e37bdaeec25ae325f4ba450be13e2aac6c8d
>> commit: 10c91577d5e631773a6394e14cf60125389b71ae x86/tools: Standardize
>output format of insn_decode_test
>> date:   8 weeks ago
>> config: x86_64-randconfig-s2-02072130 (attached as .config)
>> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
>> reproduce:
>>         git checkout 10c91577d5e631773a6394e14cf60125389b71ae
>>         # save the attached .config to linux build tree
>>         make ARCH=x86_64
>>
>> All warnings (new ones prefixed by >>):
>>
>>    arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug,
>please report this.
>> >> arch/x86/tools/insn_decoder_test: warning: ffffffff810005ac:	0f ff e9
>	ud0    %ecx,%ebp
>
>Does UD0 really take an operand? Hmm, indeed, the latest Intel SDM (December2017)
>says
>
>NOTES:
>1. Some older processors decode the UD0 instruction without a ModR/M byte. As a
>result, those processors would deliver an invalid-
>opcode exception instead of a fault on instruction fetch when the instruction with a
>ModR/M byte (and any implied bytes) would
>cross a page or segment boundary.
>
>and older SDM (e.g. March 2017) says UD0 has no modrm byte.
>It is easy to change x86-opecode-map.txt, but this means this test may fail with older
>objdump...
>
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
>
>--
>Masami Hiramatsu <mhiramat@kernel.org>
>_______________________________________________
>kbuild-all mailing list
>kbuild-all@lists.01.org
>https://lists.01.org/mailman/listinfo/kbuild-all
