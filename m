Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E87AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CFD20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CFD20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbeKTKho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:37:44 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:51034 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeKTKho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:37:44 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3A24472CA5E;
        Tue, 20 Nov 2018 03:11:29 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 288D97CD1FF; Tue, 20 Nov 2018 03:11:29 +0300 (MSK)
Date:   Tue, 20 Nov 2018 03:11:29 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Eric Paris <eparis@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Ley Foon Tan <lftan@altera.com>,
        Mark Salter <msalter@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-audit@redhat.com, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-riscv@lists.infradead.org,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        nios2-dev@lists.rocketboards.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/15] Prepare for PTRACE_GET_SYSCALL_INFO
Message-ID: <20181120001128.GA11300@altlinux.org>
References: <20181107042751.3b519062@akathisia>
 <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall_get_arch() is required to be implemented on all architectures
in order to extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO
request.

The primary intent is that the triple (audit_arch, syscall_nr, arg1..arg6)
should describe what system call is being called and what its arguments are.


Dmitry V. Levin (15):
  Move EM_HEXAGON to uapi/linux/elf-em.h
  Move EM_ARCOMPACT and EM_ARCV2 to uapi/linux/elf-em.h
  Move EM_UNICORE to uapi/linux/elf-em.h
  elf-em.h: add EM_NDS32
  elf-em.h: add EM_XTENSA
  m68k: define syscall_get_arch()
  arc: define syscall_get_arch()
  c6x: define syscall_get_arch()
  h8300: define syscall_get_arch()
  hexagon: define syscall_get_arch()
  nds32: define syscall_get_arch()
  nios2: define syscall_get_arch()
  riscv: define syscall_get_arch()
  unicore32: define syscall_get_arch()
  xtensa: define syscall_get_arch()

 arch/arc/include/asm/elf.h           |  6 +-----
 arch/arc/include/asm/syscall.h       | 10 ++++++++++
 arch/c6x/include/asm/syscall.h       |  7 +++++++
 arch/h8300/include/asm/syscall.h     |  5 +++++
 arch/hexagon/include/asm/elf.h       |  6 +-----
 arch/hexagon/include/asm/syscall.h   |  8 ++++++++
 arch/m68k/include/asm/syscall.h      | 12 ++++++++++++
 arch/nds32/include/asm/syscall.h     |  8 ++++++++
 arch/nios2/include/asm/syscall.h     |  6 ++++++
 arch/riscv/include/asm/syscall.h     | 10 ++++++++++
 arch/unicore32/include/asm/elf.h     |  3 +--
 arch/unicore32/include/asm/syscall.h | 12 ++++++++++++
 arch/xtensa/include/asm/syscall.h    |  7 +++++++
 include/uapi/linux/audit.h           | 15 +++++++++++++++
 include/uapi/linux/elf-em.h          |  7 +++++++
 15 files changed, 110 insertions(+), 12 deletions(-)
 create mode 100644 arch/m68k/include/asm/syscall.h
 create mode 100644 arch/unicore32/include/asm/syscall.h

-- 
ldv
