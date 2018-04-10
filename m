Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbeDJC7a (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 22:59:30 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:51862 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752472AbeDJC72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 22:59:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01429;MF=zoucao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0T-wYORb_1523329153;
From: zoucao@linux.alibaba.com
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] x86/boot/e820: add new chareater - to free BIOS memory in memmap bootargs
Date: Tue, 10 Apr 2018 10:59:11 +0800
Message-Id: <20180410025912.49830-1-zoucao@linux.alibaba.com>
X-Mailer: git-send-email 2.14.1.40.g8e62ba1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this is useing memmap=0x4101000-0x6aeff000 to free BIOS reserved memory
"6aeff000-6effffff : reserved":

	......
	00100000-6aefefff : System RAM
	01000000-0165537a : Kernel code
	0165537b-01a8873f : Kernel data
	01c31000-01f4efff : Kernel bss
	28000000-320fffff : Crash kernel
	6aeff000-6effffff : reserved       --> it is e820 reserved memory
	6f000000-78240fff : System RAM
	......


add bootargs memmap=0x4101000-0x6aeff000, to free memory region: 6aeff000-6effffff
then 6aeff000-6effffff will be merged into 00100000-78240fff.

new iomem:
	cat /proc/iomem:
	......
	00100000-78240fff : System RAM
	01000000-0165537a : Kernel code
	0165537b-01a8873f : Kernel data
	01c31000-01f4efff : Kernel bss
	......


V1>V2: fixed the wrong chareaters

zoucao (1):
      x86/boot/e820: add new chareater "-" to free BIOS memory in memmap bootargs

 7u/Documentation/kernel-parameters.txt | 6 ++++++
 7u/arch/x86/kernel/e820.c              | 3 +++
 2 files changed, 9 insertions(+)
