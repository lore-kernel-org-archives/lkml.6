Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1126C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D96B21829
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D96B21829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeHUXH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:07:56 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:48921 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeHUXH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:07:56 -0400
Received: from excalibur.cnev.de ([89.0.218.119]) by mrelayeu.kundenserver.de
 (mreue007 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0LrDwG-1fxjNb45nQ-0139zj; Tue, 21 Aug 2018 21:45:52 +0200
Received: from karsten by excalibur.cnev.de with local (Exim 4.89)
        (envelope-from <merker@debian.org>)
        id 1fsCb8-0007iU-J4; Tue, 21 Aug 2018 21:45:50 +0200
Date:   Tue, 21 Aug 2018 21:45:50 +0200
From:   Karsten Merker <merker@debian.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux@roeck-us.net, linux-riscv@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RISC-V Updates for the 4.19 Merge Window
Message-ID: <20180821194550.wrh3q2fkr6wmrovd@excalibur.cnev.de>
References: <20180818133759.GA20049@roeck-us.net>
 <mhng-d01c95f5-d4bb-49c5-addb-78b09911f6cd@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mhng-d01c95f5-d4bb-49c5-addb-78b09911f6cd@palmer-si-x1c4>
X-No-Archive: yes
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:cL4HX/1A+geVz8WKz2P/9oE8jZ6VppXNS6ivhEa6RTPssEm4IX0
 DlTrtfLSR0Qog/KrgPRK7tRUQR5u63BmK6HP0PkriSxLl0qbpH5hRMUtg9BgV+7/sunysPe
 lb7O0uHfSgCs65kPN47lOYGoOjv8f0/CdTUEFDAfG1b93DS+jdzF1GPoZs4Zsc2vtg2jnCT
 mLJ55nxovfuXt4jh+dSzQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p6mtv+1WAZY=:ogkem+MpiB0bX6sg1gNar3
 Z73DzQMU8JOAIyNgYTQf/Vc0x/aU6EsMaLTbQ9Yh9P+NTpy2oE4uWUp6BDvl4W0gUrWkOKJIf
 2GxkgWBt0o8T9eyWnR/n6vxgm0D2KJNm5k1e3a6O6mrVqjXe9rpdDdEphe1xaWfLyZdUVzzi2
 Xc4Jp9cBNFW5RaZEqvlmfI7lVGhRjz+EXZQJG7VaZuqzWdowKKgCwsy/B0CiPDABunTT3L220
 cOzgucZ6fDPTGpVnK+w0i1+JlC41qDka/Ieo5eMFVx7JBaxPIg+7SJqGQJI0BR7kmDPL9qcV7
 L3am4w2T9Cyn/tWiRmeerC2ZkOzQ8J9EEQhpMdGnN2/EM8A6f/RSIzb00BmkJ+GoFk5loy5bv
 FGvcT4gs+FxpKl7wPRR30CcjPvTUWQQGR73NC0WtUIpslUiSdqH0DQrl3dLkbDplMKuY5WcjD
 FPKhuRVw+oGmoVdN6EYhqlVJWnFnydveJ26ljtfIFPZhi1MlktaRyIIKuAm82/13YgDsy7F0l
 cNaRTGIQFbFBY2Gn5Ht0F6ziPX0W0G7mjvbozcEQYQE7qPF2qY3MeENG0KZy4Mwh303kMRJqY
 gS4WCJB7HEauWse4o8WNo9fGUtocKMIR+CPEXcLPDtZwt0N21zIqsZ0CGnQhVmNscvJZ7zjBd
 yzK4j2vIAzCU59xP/HLArb6ZMmre8l8hiGsJnqgp7eTHkRjwQgenlA7bf3n8PDaKMQv0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 11:31:48AM -0700, Palmer Dabbelt wrote:
> On Sat, 18 Aug 2018 06:37:59 PDT (-0700), linux@roeck-us.net wrote:
[...]
> > Do you have vmlinux embedded in bbl ?
> > 
> > With separate bbl and vmlinux, and the following qemu command line
> > (with qemu 3.0)
> > 
> > qemu-system-riscv64 -M virt -m 512M -no-reboot \
> > 	-bios bbl -kernel vmlinux \
> > 	-netdev user,id=net0 -device virtio-net-device,netdev=net0 \
> > 	-device virtio-blk-device,drive=d0 \
> > 	-drive file=rootfs.ext2,if=none,id=d0,format=raw \
> > 	-append 'root=/dev/vda rw console=ttyS0,115200' \
> > 	-nographic -monitor none
> > 
> > all I get is
> > 
> > rom: requested regions overlap (rom mrom.reset. free=0x000000000001cbe8, addr=0x0000000000001000)
> > 
> > However, the she system boots fine with the same qemu command line if I use qemu
> > built from https://github.com/riscv/riscv-qemu.git, branch qemu-for-upstream.
> 
> Yes, I have a vmlinux built into my BBL.  I didn't actually look closely at
> the command line I was copying and see that vmlinux in there, my guess would
> be that it's getting ignored.  I don't remember if upstream BBL actually
> works with the split bbl/vmlinux setup, I've kind of stopped paying
> attention to BBL as I'm just waiting for someone to tell me instructions as
> to how to use a real bootloader... :)

JFTR, upstream bbl supports the split bbl/vmlinux setup, it's just 
upstream qemu that lacks the support for now (qemu-riscv has it).

Regards,
Karsten
-- 
Gem. Par. 28 Abs. 4 Bundesdatenschutzgesetz widerspreche ich der Nutzung
sowie der Weitergabe meiner personenbezogenen Daten für Zwecke der
Werbung sowie der Markt- oder Meinungsforschung.
