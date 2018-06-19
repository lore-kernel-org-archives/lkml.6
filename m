Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB90C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204902083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="Hnfdz+UU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204902083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754115AbeFSWuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:50:19 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:51082 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753889AbeFSWuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Gy+X8szbqOPAEmpEyfLwO7Sv0DSnXakZUrFateeEttg=; b=Hnfdz+UU0WiJj7iXbhvcgUfCPg
        DiYoxlj8fG+4F2YtkRGUGMbJNswqKIWhNCEsKebmfVcPILJ5wbShEhkxflap6NQzkSMetwGLm/U5o
        tHamCCB4L60MEDOpLdkxq6gD8/hkRoBuaxZfaLkHczCxTrCf9dgK3YeCO0+APPDWtmhZF/L4kJ4qa
        drt+CHmlQJ449lO5woDWdTltUeUZMpyxlPBN8YwNj362QhBaLsLHEY1rf8gjLNce0xnkOexlcT56P
        vPckvzxsH558JK3Oafm91cn2Ue4LHO7XHi2nbIoxwhgJ+PyMPxK3A4b1uZDJQuGGDYoe+S9PNv1SR
        Xdo0Pkjg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:46884 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fVPRz-00DhYd-8N; Tue, 19 Jun 2018 22:50:11 +0000
Date:   Tue, 19 Jun 2018 15:50:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Make badr macro compatible with newer GAS versions
Message-ID: <20180619225010.GA740@roeck-us.net>
References: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
 <20180619203223.GA28370@roeck-us.net>
 <CAKv+Gu-RHM7HAmzWw9Ge+w21kWxKxLbJT7DD5huv-7WWOPUVWA@mail.gmail.com>
 <20180619204531.GB28370@roeck-us.net>
 <CAKv+Gu_zsSxb_8Ej-6QwZOW2X5VfgW0gnjpnHpi62L6nPALoHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_zsSxb_8Ej-6QwZOW2X5VfgW0gnjpnHpi62L6nPALoHQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=2.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:23:56AM +0200, Ard Biesheuvel wrote:
> 
> OK, so even the linker handling is inconsistent.
> 
> Working (binutils 2.30)
> 
> c0301164 <local_restart>:
> c0301164:       f8d9 a000       ldr.w   sl, [r9]
> c0301168:       e92d 0030       stmdb   sp!, {r4, r5}
> c030116c:       f01a 0ff0       tst.w   sl, #240        ; 0xf0
> c0301170:       d117            bne.n   c03011a2 <__sys_trace>
> c0301172:       46ba            mov     sl, r7
> c0301174:       f5ba 7fc8       cmp.w   sl, #400        ; 0x190
> c0301178:       bf28            it      cs
> c030117a:       f04f 0a00       movcs.w sl, #0
> c030117e:       f3af 8014       csdb
> c0301182:       f2af 1e83       subw    lr, pc, #387    ; 0x183
>                         c0301182: R_ARM_THM_ALU_PREL_11_0       .Lsym28
> 
> 
> Broken (binutils 2.26)
> 
> c0301184 <local_restart>:
> c0301184:       f8d9 a000       ldr.w   sl, [r9]
> c0301188:       e92d 0030       stmdb   sp!, {r4, r5}
> c030118c:       f01a 0ff0       tst.w   sl, #240        ; 0xf0
> c0301190:       d117            bne.n   c03011c2 <__sys_trace>
> c0301192:       46ba            mov     sl, r7
> c0301194:       f5ba 7fc8       cmp.w   sl, #400        ; 0x190
> c0301198:       bf28            it      cs
> c030119a:       f04f 0a00       movcs.w sl, #0
> c030119e:       f3af 8014       csdb
> c03011a2:       f2af 1ea2       subw    lr, pc, #418    ; 0x1a2
>                         c03011a2: R_ARM_THM_ALU_PREL_11_0       .Lsym30
> 
> 
> Note the even immediate in the subw instruction. So this is another
> dead end, unfortunately.
> 
Looks like someone is trying to make things really difficunt :-(.
I think I'll just stick with binutils 2.28.1. Not optimal, but
at least it works.

Something else: I can boot Cortex-M under qemu (-M mps2-an385). The only problem
I have is this:

/ # kill -1 1
[    3.806568] 
[    3.806568] Unhandled exception: IPSR = 00000006 LR = fffffffd
[    3.807221] CPU: 0 PID: 1 Comm: init Not tainted 4.18.0-rc1-00043-gba4dbdedd3ed #42
[    3.807590] Hardware name: MPS2 (Device Tree Support)
[    3.808162] PC is at   (null)
[    3.808374] LR is at 0x2170fc37
[    3.808549] pc : [<00000000>]    lr : [<2170fc37>]    psr: 60000000
[    3.808841] sp : 21761b90  ip : 21761f00  fp : 21758c04
[    3.809118] r10: 00000000  r9 : 00000000  r8 : 00000000
[    3.809329] r7 : 00000000  r6 : 00000001  r5 : 00000000  r4 : 2175452c
[    3.809565] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 00000001
[    3.809791] xPSR: 60000000
[    3.809926] CPU: 0 PID: 1 Comm: init Not tainted 4.18.0-rc1-00043-gba4dbdedd3ed #42
[    3.810179] Hardware name: MPS2 (Device Tree Support)
[    3.811246] [<2100bd8d>] (unwind_backtrace) from [<2100b13b>] (show_stack+0xb/0xc)
[    3.811656] [<2100b13b>] (show_stack) from [<2100b87b>] (__invalid_entry+0x4b/0x4c)

Everything else seems to work, just sending a signal to init causes it
to blow up. Any idea what might cause this ?

Thanks,
Guenter
