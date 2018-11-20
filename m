Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0360C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5931F206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5931F206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeKUFeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 00:34:18 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:57994 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726001AbeKUFeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 00:34:17 -0500
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id wAKJ3cxA019062
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 14:03:38 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id wAKJ3WDk004157
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 14:03:38 -0500
Received: by mail-qt1-f197.google.com with SMTP id b16so973213qtc.22
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 11:03:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=QTkKDErc6r689Sg9iRsb9haYyB+sFdp4VijLGNcLpCA=;
        b=hPgFOhz8kSq4BLPAhyYoZhseH8Kiu+9xW+dneZbaqTSHyWFKbW67Vf3yRHxigdUwoY
         TErX8pgcQrmKBLvC8OwvS1QDcYNVmT56Mp0IF1wm36BMfEPgo39O/oyIp97dYA5UHT6Y
         l3nH2XzPMQvkKhuVIk51A2fk0Jye/SrdHaEUHuywHn9SYq0YfJ+8qPAbdSry4W25X7fm
         0w8YF9vK2QxfssNWhXZDiBngIat7K+e4C3TenUNPDGjuMu0gN6eCVI+F44Qa47fv4zWx
         mVQ75wx/1BqAOvV6zjBgnPo/gZCcwwWgyjanxnRSN9x5achTas9M5th4qV8Li9UBfgtv
         kXqw==
X-Gm-Message-State: AA+aEWYLiVIfCIRdTp4lMOEx85Uy976m5zP9jFLrOEcSvUcRFxuhOMxO
        rsQ3EAPzkfUx0UIByWbQUuzapcSsJurzx/oY2ekVaiGg1MKsevPzOA1nJGJvo13Bs9lUNtOf4xS
        o9Ppunwwvjjddza/mhjPiIjDASsiG09eRKbY=
X-Received: by 2002:a37:6413:: with SMTP id y19mr2838294qkb.215.1542740612705;
        Tue, 20 Nov 2018 11:03:32 -0800 (PST)
X-Google-Smtp-Source: AFSGD/X1Ii3wjtsVtaXEdCog0VOZ69ACQZzKipZb18f8fCGvGLSPgvGaTfoAKx+DHxbx2ebGKsI0+w==
X-Received: by 2002:a37:6413:: with SMTP id y19mr2838277qkb.215.1542740612411;
        Tue, 20 Nov 2018 11:03:32 -0800 (PST)
Received: from turing-police.cc.vt.edu (turing-police.cc.ipv6.vt.edu. [2001:468:c80:2103:f21f:afff:fe0c:8ada])
        by smtp.gmail.com with ESMTPSA id n26sm7326271qkg.74.2018.11.20.11.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 11:03:29 -0800 (PST)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        kernelnewbies@kernelnewbies.org,
        Jungseok Lee <jungseoklee85@gmail.com>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        mark.rutland@arm.com, Sungjinn Chung <barami97@gmail.com>
Subject: Re: [ARM64] Printing IRQ stack usage information
In-Reply-To: <CAOuPNLgGuomqaQVtj=1O8tYV_Bq8cqf5HqCxJ-LSGeQOVffnzw@mail.gmail.com>
References: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com> <28496.1542300549@turing-police.cc.vt.edu> <CAOuPNLj8wj=tPJo8L3oS7o8iTQcyhZ0W-GH6xmP_GsG4r7YdAQ@mail.gmail.com> <49219.1542367988@turing-police.cc.vt.edu> <CAOuPNLg4tM6Cw8Yf9rdpkBOU=+Fh654yFQeAhJf1y88Gb3MAew@mail.gmail.com> <5997.1542386778@turing-police.cc.vt.edu> <CAOuPNLiX0zhxiRAx03YjVU6cocwWbgY9naxeYPRKmT+3PoGhRw@mail.gmail.com> <15703.1542393111@turing-police.cc.vt.edu> <CAOuPNLiJmtXft6g63oATMrrrcd3jQGCfxsAzXLx8Kz=_zsR4Kg@mail.gmail.com>
 <CAOuPNLgGuomqaQVtj=1O8tYV_Bq8cqf5HqCxJ-LSGeQOVffnzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1542740607_2819P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Tue, 20 Nov 2018 14:03:28 -0500
Message-ID: <38799.1542740608@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1542740607_2819P
Content-Type: text/plain; charset=us-ascii

On Tue, 20 Nov 2018 18:21:33 +0530, Pintu Agarwal said:

> + sp = current_stack_pointer;
> + if (on_irq_stack(sp, cpu)) {
> +         stack_start = (unsigned long)per_cpu(irq_stack, cpu);
> +         last_usage = per_cpu(irq_stack_usage, cpu);
> +         curr_usage = sp - stack_start;
> +         pr_info("cpu:%d : sp: %lu, stack_start: %lu, usage: %lu\n", cpu, sp, stack_start, (sp - stack_start));
> +         if (curr_usage > last_usage)
> +                 per_cpu(irq_stack_usage, cpu) = curr_usage;
> + }

This code only works if called from the function that uses the deepest
amount of stack, because curr_usage depends on the current stack
pointer.  If some other routine went 2,934 bytes further into the stack
and then returned, you'll never know.

What you want instead is a way to see what the deepest point reached during
the current call, and compare that to the previous low.

How to detect the used stack? Go look at how the code currently
detects how deep the kernel stacks reached. (Hint 1: look at check_stack_usage()
in kernel/exit.c and stack_not_used().  Hint 2: what other support code
is implied by the implementation of stack_not used()?

> Which is the best place to invoke this ?
> I have the following option:
> 1. kernel/softirq.c => __do_softirq()
> 2. arch/arm64/kernel/smp.c => handle_IPI()
> 3. kernel/softirq.c => irq_exit()
> 4. ???

Pondering the above, what other implementations might work? Hint: if
you have a similar irq_stack_not_used() function, do you need any
additional code in *any* of those 4 places?

(And yes, I could just splat out the needed code - but you'd learn nowhere
near as much that way.. :)




--==_Exmh_1542740607_2819P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQEVAwUBW/Raf40DS38y7CIcAQJlIAf/ZwgLssOW1kKbDHlhdiZqMxTkeroALLNs
PsLoezZywUY+BnN27zys0F6zRG6t11P29NhoI5sCMSHwRliulMmfFb2AABtlW93e
R2Y6YbgbI47wnZw4KUDB09ty14r+DlT7O1ETBqIsmtkeGx1JVBePnRGGiljGIJV4
Jfj8aGNzKPqt4X/nt/by2frSne7H6kkoCOjvcjKzCLFXkGTSuiiYxyq/ldu299nW
OR2+9XtfukCMe0jOvVdWagj70C4EkoLlAjjGOFvmX8ogBrtMkklgBkehaYBc99sL
JkrRRC8VZzTxzw1CQEh91DMrxtZaY7nSjSNSysMACB6U1fTOfywB7g==
=TbrW
-----END PGP SIGNATURE-----

--==_Exmh_1542740607_2819P--
