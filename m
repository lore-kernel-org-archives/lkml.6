Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbeDZASW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 20:18:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:57988 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750968AbeDZASV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 20:18:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,328,1520924400";
   d="gz'50?scan'50,208,50";a="35313928"
Date: Thu, 26 Apr 2018 08:18:17 +0800
From: kbuild test robot <lkp@intel.com>
To: "jacek.tomaka@poczta.fm" <jacek.tomaka@poczta.fm>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:x86/urgent 4/6] arch/x86/kernel/cpu/intel.c:839:31: error:
 expected '}' before string constant
Message-ID: <201804260815.LySheF90%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
head:   5a626a8dfb58a64a39f4351e3962e7320191f189
commit: 88ba3829dfd83219bb2b1954acb0c206a602ce83 [4/6] x86/cpu/intel: Add missing TLB cpuid values
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout 88ba3829dfd83219bb2b1954acb0c206a602ce83
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> arch/x86/kernel/cpu/intel.c:839:31: error: expected '}' before string constant
     { 0x6c, TLB_DATA_2M_4M,  128 " TLB_DATA 2 MByte or 4 MByte pages, 8-way associative" },
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +839 arch/x86/kernel/cpu/intel.c

   816	
   817	static const struct _tlb_table intel_tlb_table[] = {
   818		{ 0x01, TLB_INST_4K,		32,	" TLB_INST 4 KByte pages, 4-way set associative" },
   819		{ 0x02, TLB_INST_4M,		2,	" TLB_INST 4 MByte pages, full associative" },
   820		{ 0x03, TLB_DATA_4K,		64,	" TLB_DATA 4 KByte pages, 4-way set associative" },
   821		{ 0x04, TLB_DATA_4M,		8,	" TLB_DATA 4 MByte pages, 4-way set associative" },
   822		{ 0x05, TLB_DATA_4M,		32,	" TLB_DATA 4 MByte pages, 4-way set associative" },
   823		{ 0x0b, TLB_INST_4M,		4,	" TLB_INST 4 MByte pages, 4-way set associative" },
   824		{ 0x4f, TLB_INST_4K,		32,	" TLB_INST 4 KByte pages */" },
   825		{ 0x50, TLB_INST_ALL,		64,	" TLB_INST 4 KByte and 2-MByte or 4-MByte pages" },
   826		{ 0x51, TLB_INST_ALL,		128,	" TLB_INST 4 KByte and 2-MByte or 4-MByte pages" },
   827		{ 0x52, TLB_INST_ALL,		256,	" TLB_INST 4 KByte and 2-MByte or 4-MByte pages" },
   828		{ 0x55, TLB_INST_2M_4M,		7,	" TLB_INST 2-MByte or 4-MByte pages, fully associative" },
   829		{ 0x56, TLB_DATA0_4M,		16,	" TLB_DATA0 4 MByte pages, 4-way set associative" },
   830		{ 0x57, TLB_DATA0_4K,		16,	" TLB_DATA0 4 KByte pages, 4-way associative" },
   831		{ 0x59, TLB_DATA0_4K,		16,	" TLB_DATA0 4 KByte pages, fully associative" },
   832		{ 0x5a, TLB_DATA0_2M_4M,	32,	" TLB_DATA0 2-MByte or 4 MByte pages, 4-way set associative" },
   833		{ 0x5b, TLB_DATA_4K_4M,		64,	" TLB_DATA 4 KByte and 4 MByte pages" },
   834		{ 0x5c, TLB_DATA_4K_4M,		128,	" TLB_DATA 4 KByte and 4 MByte pages" },
   835		{ 0x5d, TLB_DATA_4K_4M,		256,	" TLB_DATA 4 KByte and 4 MByte pages" },
   836		{ 0x61, TLB_INST_4K,		48,	" TLB_INST 4 KByte pages, full associative" },
   837		{ 0x63, TLB_DATA_1G,		4,	" TLB_DATA 1 GByte pages, 4-way set associative" },
   838		{ 0x6b, TLB_DATA_4K,		256,	" TLB_DATA 4 KByte pages, 8-way associative" },
 > 839		{ 0x6c, TLB_DATA_2M_4M,		128	" TLB_DATA 2 MByte or 4 MByte pages, 8-way associative" },
   840		{ 0x6d, TLB_DATA_1G,		16,	" TLB_DATA 1 GByte pages, fully associative" },
   841		{ 0x76, TLB_INST_2M_4M,		8,	" TLB_INST 2-MByte or 4-MByte pages, fully associative" },
   842		{ 0xb0, TLB_INST_4K,		128,	" TLB_INST 4 KByte pages, 4-way set associative" },
   843		{ 0xb1, TLB_INST_2M_4M,		4,	" TLB_INST 2M pages, 4-way, 8 entries or 4M pages, 4-way entries" },
   844		{ 0xb2, TLB_INST_4K,		64,	" TLB_INST 4KByte pages, 4-way set associative" },
   845		{ 0xb3, TLB_DATA_4K,		128,	" TLB_DATA 4 KByte pages, 4-way set associative" },
   846		{ 0xb4, TLB_DATA_4K,		256,	" TLB_DATA 4 KByte pages, 4-way associative" },
   847		{ 0xb5, TLB_INST_4K,		64,	" TLB_INST 4 KByte pages, 8-way set associative" },
   848		{ 0xb6, TLB_INST_4K,		128,	" TLB_INST 4 KByte pages, 8-way set associative" },
   849		{ 0xba, TLB_DATA_4K,		64,	" TLB_DATA 4 KByte pages, 4-way associative" },
   850		{ 0xc0, TLB_DATA_4K_4M,		8,	" TLB_DATA 4 KByte and 4 MByte pages, 4-way associative" },
   851		{ 0xc1, STLB_4K_2M,		1024,	" STLB 4 KByte and 2 MByte pages, 8-way associative" },
   852		{ 0xc2, TLB_DATA_2M_4M,		16,	" DTLB 2 MByte/4MByte pages, 4-way associative" },
   853		{ 0xca, STLB_4K,		512,	" STLB 4 KByte pages, 4-way associative" },
   854		{ 0x00, 0, 0 }
   855	};
   856	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--45Z9DzgjV8m4Oswq
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AZnWFA+/x/3FzroKaQIftTuLT/8fhu1JReZXAAA=

--45Z9DzgjV8m4Oswq--
