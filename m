Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760EDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268FD2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268FD2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390303AbeKQEp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:45:29 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:42458 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727462AbeKQEp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:45:29 -0500
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id wAGIVx0k030465
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 13:31:59 -0500
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id wAGIVsXu021743
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 13:31:59 -0500
Received: by mail-qk1-f198.google.com with SMTP id d196so53187684qkb.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 10:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=VycXzBO5NzrhP+5JdsiIbB3sP7KmxZuBqwxvpwLENMk=;
        b=ZsTxLIhVjivtWsLcqAGWCU657Gq38rRkEprX/2wKGNm8tTLUS3s+2XKNeUJimWdc9b
         TSd1+9QiUVJNyAt0nOsBvpQ5xOW3KRp83nUasMq13rzDm+kCHGpzEgWttccbdTDY4dQf
         hzf9KFMIHU1Mo2NIn3qVjWylKANWyEo0MR95CkFdGy9yQwDyD/a2GdILOkq3Yb2eYd+J
         vFANgQAHhPrVRTu7ryA7kCzlVY145HO+r9LyxiL0pZ69lV1eKJzv3YgwLnn8Yj+60RB7
         ZC6naafoYsbUQad0vJxPzwywP1bUlDFrEfO50jzf6ZCzgpYTdfQ6hXibo53QuHp/A9Jx
         AFLA==
X-Gm-Message-State: AGRZ1gJNWWHb1aNOv5h5v4Tr4NAXiarSjR/aXt+dWlDPAfwDDIlYkD/X
        kpyxnNkyqUnw63jnbIA45nBv9QWFjS7Txx/XBlQfnam8S7Ep5wcjRWCQVYp+DBNvOZa/Xva1OAC
        d5lu4751VmGBDbvtnGofdgS4f4x05+hHsx+I=
X-Received: by 2002:a37:324a:: with SMTP id y71mr11297249qky.291.1542393113713;
        Fri, 16 Nov 2018 10:31:53 -0800 (PST)
X-Google-Smtp-Source: AJdET5ffyQB5ptJVeH8J8dSDt6TqN7mHTIApKupTGspNcaR86uKRBAyJsucso/tXG1x4/al2qhFRRQ==
X-Received: by 2002:a37:324a:: with SMTP id y71mr11297226qky.291.1542393113405;
        Fri, 16 Nov 2018 10:31:53 -0800 (PST)
Received: from turing-police.cc.vt.edu (turing-police.cc.ipv6.vt.edu. [2001:468:c80:2103:f21f:afff:fe0c:8ada])
        by smtp.gmail.com with ESMTPSA id v2sm12952073qte.75.2018.11.16.10.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 10:31:52 -0800 (PST)
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
In-Reply-To: <CAOuPNLiX0zhxiRAx03YjVU6cocwWbgY9naxeYPRKmT+3PoGhRw@mail.gmail.com>
References: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com> <28496.1542300549@turing-police.cc.vt.edu> <CAOuPNLj8wj=tPJo8L3oS7o8iTQcyhZ0W-GH6xmP_GsG4r7YdAQ@mail.gmail.com> <49219.1542367988@turing-police.cc.vt.edu> <CAOuPNLg4tM6Cw8Yf9rdpkBOU=+Fh654yFQeAhJf1y88Gb3MAew@mail.gmail.com> <5997.1542386778@turing-police.cc.vt.edu>
 <CAOuPNLiX0zhxiRAx03YjVU6cocwWbgY9naxeYPRKmT+3PoGhRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1542393111_2640P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 16 Nov 2018 13:31:51 -0500
Message-ID: <15703.1542393111@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1542393111_2640P
Content-Type: text/plain; charset=us-ascii

On Fri, 16 Nov 2018 23:13:48 +0530, Pintu Agarwal said:
> On Fri, Nov 16, 2018 at 10:16 PM <valdis.kletnieks@vt.edu> wrote:

> > Congrats. You just re-invented DEBUG_STACK_USAGE, which just keeps a high-water mark
> > for stack usage.
>
> So, you mean to say, my implementation is good enough to get the
> irq_stack usage, from the interrupt handler ?

No - your code doesn't keep a high-water mark (which should probably be
hooked into the IRQ exit code.

> But my concern is that if I dump it from irq handler, I will get
> information only for the current cpu.
> How do I store and get the information for all the cpu from the boot time ?

Make the high-water mark a per-cpu variable.

> From where do I call my dump_irq_stack_info() [some where during the
> entry/exit part of the irq handler], so that I could dump information
> for all the handler at boot time itself ?

No, you don't do a dump-stack during entry/exit.  You just maintain a high-water
value in the exit, and then you create a /proc/something or similar that when
read does a 'foreach CPU do print_high_water_irq'.

> Like I would to capture these information:
> - What was the name of the handler ?
> - Which cpu was executing it ?
> - How much irq stack (max value, same like high water mark) were used
> at that time ?

First, do the easy part and find out if you even *care* once you see actual
numbers.  If your IRQ stack is 8K but you never use more than 2500 bytes,
do you *really* care about the name of the handler anymore?

Also, see the code for /proc/interrupts to see how it keeps track of the
interrupts per CPU - maybe all you need to do is change each entry from
a 'count' to 'count, highwater'.

--==_Exmh_1542393111_2640P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQEVAwUBW+8NF40DS38y7CIcAQLYigf6AquROVf8D2XZsVziGWixUOH/mFLhro6x
Ez3kExhZze5EHeWXkLumwNtbwnb8hPVaBM49eRfd9ZUnCJ9jDGaJ5pF+BghOfn92
232Lth60sLZlGiibXhiEiXX0Ok1/l5WtyzbKw8EOqcJnCPBxvCAziADeXenUciU0
UwWN/PHOnoRTHUacEXrMJUlAL9bZhJeOWukkYbmfo1ve2cHb3zWlWoUN209yZZ24
p7FGN5O3l2aJhwtmjOnd1QRb6/et1Fkbr5UEEnfsGcp28a8SFBKGwZDM39PPhB49
q4eazqIaoZrEPgDdGG8f9tgsh5wJ8mzsJXpamgRMy2Ye/DBaKCN36g==
=jztX
-----END PGP SIGNATURE-----

--==_Exmh_1542393111_2640P--
