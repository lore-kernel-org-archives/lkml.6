Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E4CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FF3206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUa5K2/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30FF3206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeK2NgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:36:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45165 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbeK2NgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:36:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so221540pfd.12;
        Wed, 28 Nov 2018 18:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ly6p341eePfycK8xgoPA+gkH5QlCh1GYoI5eKaSBF/s=;
        b=QUa5K2/g0Q2MdBbv4qtrGXKOUOafz/xwaUxhqDUL+V8/loYqAhUHHbxSBV4HrLIidT
         YwYfJrvJHewnRKpahZnajFnkQfH/+fNgAgcYnvdPABePmR8lsLbBOUtb/73BUAheRORi
         hUjfCHStMR8+6fwJtJzzdqWfDUd49Ad60T9RDF1IRzFM4jNwt6J5KgqJ5KT8z0lOkLCa
         JAeujCBn1vAozGKxfgm7EMpbbFmeqb34MeOE1+28nNT5xbIeSSi49J4fJw4ptezPlAP1
         s4kgGVlBtj0Sx5BG8RIPDXTwYC+fkIuyV4OMMY1vAaNcN4BAexEE1w8T6nCkxm5wtek7
         dynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ly6p341eePfycK8xgoPA+gkH5QlCh1GYoI5eKaSBF/s=;
        b=Tdx5nvM7LsvqFkNygOTvsDsUfcHS+Iun31SGhbhsP6eHXbsmQMBaM6RNCpXPjnva5B
         sDMNEB74ezwSakYRLtszrZZbVSpz3e77Wyqsrh/08DnqPI1sWpPX/Xu9JO1vhJlhegFS
         3iLEDY0vrDV/1VSGJ/u1w8DBWGeWfAbjWmILxczGDit65cUz/qElNGuUDJ/fm5C+POdi
         sgJvRDT18OcPQj0C3Ydpf2upSxMni6w+RHyzmYT8XjbHYxN1TJP8ZNgDiMHuTJxS9zn9
         UmUJVn+Xf/HMRItlh+G+v1UplYu0SHEWbaV7X3hsGiSvk6uanwdHyAg0tuqX3fRNTrKD
         MhpA==
X-Gm-Message-State: AA+aEWaMvWycGi6TMUf8DleusvPovjTmzWSCCRbQSgU1V/lZ/M5wJ6ww
        tuke6h5PQchdUevvwpOxgBI=
X-Google-Smtp-Source: AJdET5ctRGqHpvG9VeSOILVNeDY4NjQU9DROKUDdgzM94TMo3Hl+arGNdT8SoR9llt0+BZNacpTbxA==
X-Received: by 2002:a63:4926:: with SMTP id w38mr33991354pga.353.1543458734628;
        Wed, 28 Nov 2018 18:32:14 -0800 (PST)
Received: from localhost ([175.223.15.27])
        by smtp.gmail.com with ESMTPSA id f62sm306996pgc.67.2018.11.28.18.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 18:32:13 -0800 (PST)
Date:   Thu, 29 Nov 2018 11:32:10 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 2/7] zram: fix double free backing device
Message-ID: <20181129023210.GC6379@jagdpanzerIV>
References: <20181127055429.251614-1-minchan@kernel.org>
 <20181127055429.251614-3-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127055429.251614-3-minchan@kernel.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/27/18 14:54), Minchan Kim wrote:
> If blkdev_get fails, we shouldn't do blkdev_put. Otherwise,
> kernel emits below log. This patch fixes it.
> 
> [   31.073006] WARNING: CPU: 0 PID: 1893 at fs/block_dev.c:1828 blkdev_put+0x105/0x120
> [   31.075104] Modules linked in:
> [   31.075898] CPU: 0 PID: 1893 Comm: swapoff Not tainted 4.19.0+ #453
> [   31.077484] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   31.079589] RIP: 0010:blkdev_put+0x105/0x120
> [   31.080606] Code: 48 c7 80 a0 00 00 00 00 00 00 00 48 c7 c7 40 e7 40 96 e8 6e 47 73 00 48 8b bb e0 00 00 00 e9 2c ff ff ff 0f 0b e9 75 ff ff ff <0f> 0b e9 5a ff ff ff 48 c7 80 a0 00 00 00 00 00 00 00 eb 87 0f 1f
> [   31.085080] RSP: 0018:ffffb409005c7ed0 EFLAGS: 00010297
> [   31.086383] RAX: ffff9779fe5a8040 RBX: ffff9779fbc17300 RCX: 00000000b9fc37a4
> [   31.088105] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffffff9640e740
> [   31.089850] RBP: ffff9779fbc17318 R08: ffffffff95499a89 R09: 0000000000000004
> [   31.091201] R10: ffffb409005c7e50 R11: 7a9ef6088ff4d4a1 R12: 0000000000000083
> [   31.092276] R13: ffff9779fe607b98 R14: 0000000000000000 R15: ffff9779fe607a38
> [   31.093355] FS:  00007fc118d9b840(0000) GS:ffff9779fc600000(0000) knlGS:0000000000000000
> [   31.094582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   31.095541] CR2: 00007fc11894b8dc CR3: 00000000339f6001 CR4: 0000000000160ef0
> [   31.096781] Call Trace:
> [   31.097212]  __x64_sys_swapoff+0x46d/0x490
> [   31.097914]  do_syscall_64+0x5a/0x190
> [   31.098550]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   31.099402] RIP: 0033:0x7fc11843ec27
> [   31.100013] Code: 73 01 c3 48 8b 0d 71 62 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a8 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 41 62 2c 00 f7 d8 64 89 01 48
> [   31.103149] RSP: 002b:00007ffdf69be648 EFLAGS: 00000206 ORIG_RAX: 00000000000000a8
> [   31.104425] RAX: ffffffffffffffda RBX: 00000000011d98c0 RCX: 00007fc11843ec27
> [   31.105627] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 00000000011d98c0
> [   31.106847] RBP: 0000000000000001 R08: 00007ffdf69be690 R09: 0000000000000001
> [   31.108038] R10: 00000000000002b1 R11: 0000000000000206 R12: 0000000000000001
> [   31.109231] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   31.110433] irq event stamp: 4466
> [   31.111001] hardirqs last  enabled at (4465): [<ffffffff953ebd43>] __free_pages_ok+0x1e3/0x490
> [   31.112437] hardirqs last disabled at (4466): [<ffffffff95201b7a>] trace_hardirqs_off_thunk+0x1a/0x1c
> [   31.113973] softirqs last  enabled at (3420): [<ffffffff95e00333>] __do_softirq+0x333/0x446
> [   31.115364] softirqs last disabled at (3407): [<ffffffff9527aee1>] irq_exit+0xd1/0xe0
> 
> Cc: stable@vger.kernel.org # 4.14+
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Good catch.

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
