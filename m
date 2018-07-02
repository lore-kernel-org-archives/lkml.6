Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59907C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06126244FC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ov/WWxc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06126244FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753310AbeGBR6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:58:20 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:57330 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbeGBR6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:58:01 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id BA65924E01DF;
        Mon,  2 Jul 2018 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1530554281; bh=NdfXQKYMi+wVRuJUxi52R4DGYPXYLHveQ7SxZD9XFsk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Ov/WWxc82565j22nuUOI5uX1+y3UqQFRqnsHs/KwfXkLu4O8HnMFCEeu14VtSRX02
         M4L5xp/ZsJvBdkMSkf6GfqsMPj5JoPCeV5PJYy/RH9ofaY16u64v75f/B1UrPEY3bf
         /xudY/nIhFmadV7zxisBl9xTKzZUeSdwgu0B68GeCqwoRt/J15krCQJj/xGBkI/wQM
         Jm1ARnMDGGzcIyLVtbFuQ05qpJrD5LlRHEWiHTZWSrepmblA3oNjJmATjIOGVSBYre
         u8TuZEo4IUwQkaiyy7Yz1e9a0Ov8EUzBYg2nH4D/0sdibPJ/CPdSoFVw/v6DJ5PFeF
         UaPDlWokDbLww==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 070C931AB;
        Mon,  2 Jul 2018 10:58:00 -0700 (PDT)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 2 Jul 2018 10:57:59 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 2 Jul 2018 23:27:56 +0530
Received: from [10.10.161.98] (10.10.161.98) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 2 Jul 2018 23:27:56 +0530
Subject: Re: [PATCH] ARC: prevent showing irrelevant exception info in signal
 message
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
References: <20180629193907.17227-1-Eugeniy.Paltsev@synopsys.com>
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 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
 i91ThhqBJlyU6MVUa6vZNv8E
Message-ID: <924308fe-efb3-45f7-b5cb-45d876021f32@synopsys.com>
Date:   Mon, 2 Jul 2018 10:57:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180629193907.17227-1-Eugeniy.Paltsev@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.10.161.98]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Al

On 06/29/2018 12:39 PM, Eugeniy Paltsev wrote:
> We process signals in the end of syscall/exception handler.
> It the signal is fatal we print register's content using
> show_regs function. show_regs() also prints information about
> last exception happened.
>
> In case of multicore system we can catch the situation when we
> will print wrong information about exception. See the example:
> ______________________________
> CPU-0: started to handle page fault
> CPU-1: sent signal to process, which is executed on CPU-0
> CPU-0: ended page fault handle. Started to process signal before
>        returnig to userspace. Process signal, which is send from
>        CPU-0. As th signal is fatal we call show_regs().
>        show_regs() will show information about last exception
>        which is *page fault* (instead of "trap" which is used for
>        signals and happened on CPU-0)
>
> So we will get message like this:
>     /home/waitpid02
>   potentially unexpected fatal signal 8.
>   Path: /home/waitpid02
>   CPU: 0 PID: 100 Comm: waitpid02 Not tainted 4.10.0-rc4 #2
>   task: 9f11c200 task.stack: 9f3ae000
>
>   [ECR   ]: 0x00050200 => Invalid Write @ 0x00000000 by insn @ 0x000123ec
>   [EFA   ]: 0x00000000
>   [BLINK ]: 0x123ea
>   [ERET  ]: 0x123ec
>     @off 0x123ec in [/home/waitpid02]
>     VMA: 0x00010000 to 0x00016000
>   [STAT32]: 0x80080882 : IE U
>   BTA: 0x000123ea  SP: 0x5ffd3db0  FP: 0x00000000
>   LPS: 0x20031684 LPE: 0x2003169a LPC: 0x00000006
>   [-----other-info-----]
>
> This message is confusing because it show information about page fault
> ( [ECR   ]: 0x00050200 => Invalid Write ) which is absolutely irrelevant
> to signal.

Agreed this is misleading. @Al, is there a way to identify process termination
from signals because it did something wrong vs. say unhandled signal. For former,
we want to dump additional info in show_regs() such as PC / Fault addres etc and
not in other scenario.

> This situation was reproduced with waitpid02 LTP test.
> _____________________________
>
> So remove printing information about exceptions from show_regs()
> to avoid confusing messages. Print information about exceptions
> only in required places instead of show_regs()
>
> Now we don't print information about exceptions if signal is simply
> send by another userspace app. So in case of waitpid02 we will print
> next message:
> _____________________________
>     ./waitpid02
>   potentially unexpected fatal signal 8.
>   [STAT32]: 0x80080082 : IE U
>   BTA: 0x20000fc4	 SP: 0x5ff8bd64	 FP: 0x00000000
>   LPS: 0x200524a0	LPE: 0x200524b6	LPC: 0x00000006
>   [-----other-info-----]
> _____________________________

The prints I'm seeing now, for a segv from NULL pointer access is even more
confusing !
There's a mixup of prints....

-------------------->8--------------------
Path: /segv
CPU: 0 PID: 70 Comm: segv Not tainted 4.17.0+ #412

[ECR   ]: 0x00050200 => Invalid Write @ 0x00000000 by insn @ 0x000103ac
[EFA   ]: 0x00000000
[BLINK ]: 0x20047bb0
[ERET  ]: 0x103ac
    @off 0x103ac in [/segv]
    VMA: 0x00010000 to 0x00012000

potentially unexpected fatal signal 11.
[STAT32]: 0x80080882 : IE U    
BTA: 0x00010398     SP: 0x5fc95e1c     FP: 0x5fc95e20
LPS: 0x20039ffc    LPE: 0x2003a000    LPC: 0x00000000
r00: 0x00000001    r01: 0x5fc95e94    r02: 0x00000000   
r03: 0x00000064    r04: 0x80808080    r05: 0x2f2f2f2f   
...
-------------------->8--------------------

and for the process killed by signal 8, we get below.

-------------------->8--------------------
[ARCLinux]# kill -8 71
[ARCLinux]# potentially unexpected fatal signal 8.
[STAT32]: 0x80080882 : IE U    
BTA: 0x20020660     SP: 0x5fbcddec     FP: 0x5fbcde1c
LPS: 0x20039ffc    LPE: 0x2003a000    LPC: 0x00000000
r00: 0xfffffdfc    r01: 0x5fbcddf0    r02: 0x00000000   
r03: 0x00000008    r04: 0x80808080    r05: 0x2f2f2f2f   
r06: 0x7a2f5f4a    r07: 0x00000000    r08: 0x00000065   
...


[1]+  Floating point exception   ./sleep
-------------------->8--------------------

I'm not sure whats the improvement here vs. the status quo.

For signal based kill, we don't want to dump the extra registers and if any, we
might still want to print the PC where the process was last seen in user mode to
give user of idea what it was doing at the time.

-Vineet
