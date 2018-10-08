Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17ACC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71202075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL961gY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71202075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeJHWXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:23:53 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:39851 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeJHWXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:23:53 -0400
Received: by mail-wr1-f47.google.com with SMTP id 61-v6so20496532wrb.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 08:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=glNVUSV9JyCuEAUdOYffhrWxAdsuFEJYQLxmUlLtMv8=;
        b=kL961gY8r4GHoLt8YPQ8gSF0dPyI7o9S47Jn0Anu/AjhbVKcGqnxzyMMjZaL0vAziL
         v8flKyizBKAttHxo82Dt02cMjvZVqmdNGv4fTQI9xwIM9pYR56RjTPVNVDvS7sD//SU/
         Q0jZi0MjKTlk9s2CSd0k7iUsn+vyi/Uc6kG4ATtUDhONuLWmyBGPJemWMC5WiS7KgN+J
         I7IdYnSAealubITWnbJ++nlcRBrWj+KLcF/oEALn+UOmiqaAi0mpLSJnMY/hsr0W1Ydv
         plmkMmpWYntvO5CgRS4pIoKg6ReHArxpSpotITD/R9buNF8qeLl+SJESWyYZFRA8Bbh9
         2pYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=glNVUSV9JyCuEAUdOYffhrWxAdsuFEJYQLxmUlLtMv8=;
        b=p+/vjFuOdxpO/Ue39afKumGegM7tvz8GIocpyVDW2DVnrR0nIAG6usxTpHX1vPKH4F
         xOjBDWFNLo1yUdReawA6ekFD2+sVUnVfMWvcCWPkkCyIYjy6nQAOIPrE/UsIDRAAJh7a
         F5aYZo2MMAEb/rort3wW1yUcZtOwHRA3Y9ZA1vvOWG1BOidq3S67CFMtxjfeV8i7VIzp
         XEqV7oLFmr2kax+XuJGsWCG7ScZQaPhsKijWLm1uO0E0rfeiu4W7pm1JwduTe9XI38dq
         6UkhGEg/m6ZhYis+CzDs5z6k7jRkzzw05XtaWlY4kP2+/qU5AgXquOQw6cQY8q4+wcIw
         Dw8Q==
X-Gm-Message-State: ABuFfogUEgR2HQ6J69oxNHr+VWLTXd5dMc59cnkhiGRvJeVNWx2BdZQF
        RX5NWfiABVNY6bKriGScbgQ=
X-Google-Smtp-Source: ACcGV62aBUsA6T7rTMlW/eYnL84qUQYHiDocaQtzmw76+S6sAxtBhgnofuwXQwF9HeIGKgyNw+Etpw==
X-Received: by 2002:adf:8141:: with SMTP id 59-v6mr15777331wrm.127.1539011500623;
        Mon, 08 Oct 2018 08:11:40 -0700 (PDT)
Received: from gmail.com (net-31-156-131-143.cust.vodafonedsl.it. [31.156.131.143])
        by smtp.gmail.com with ESMTPSA id s1-v6sm12258498wrw.35.2018.10.08.08.11.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 08:11:39 -0700 (PDT)
Date:   Mon, 8 Oct 2018 17:11:38 +0200
From:   Paolo Pisati <p.pisati@gmail.com>
To:     James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: 4.19-rcX: WARN_ON() arch/arm64/kernel/setup.c:271
 reserve_memblock_reserved_regions
Message-ID: <20181008151138.GA19635@harukaze>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This on my dragonboard 410c:

...
[    0.170657] WARNING: CPU: 2 PID: 1 at arch/arm64/kernel/setup.c:271 reserve_memblock_reserved_regions+0xd4/0x150
[    0.170666] Modules linked in:
[    0.170680] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc7-dirty #3
[    0.170687] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    0.170696] pstate: 20000005 (nzCv daif -PAN -UAO)
[    0.170707] pc : reserve_memblock_reserved_regions+0xd4/0x150
[    0.170718] lr : reserve_memblock_reserved_regions+0xcc/0x150
[    0.170725] sp : ffff000008033d30
[    0.170731] x29: ffff000008033d30 x28: ffff000009048050
[    0.170744] x27: ffff000009048078 x26: ffff000008f871b0
[    0.170755] x25: 0000000000000000 x24: 0000000000488020
[    0.170767] x23: 00000000bfffffff x22: ffff000008f3ca28
[    0.170778] x21: ffff000008e61840 x20: ffff0000090e9000
[    0.170789] x19: ffff80003a218e00 x18: 0000000000000000
[    0.170800] x17: 0000000000000000 x16: 0000000000000000
[    0.170811] x15: 0000000000000000 x14: 0000000000000400
[    0.170822] x13: 0000000000000000 x12: 0000000000000028
[    0.170833] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
[    0.170844] x9 : 0000000000000000 x8 : ffff80003a218e80
[    0.170855] x7 : 0000000000000000 x6 : ffff80003d9ffc70
[    0.170866] x5 : 0000000000000000 x4 : 00000000bfffffff
[    0.170877] x3 : 00000000bff00000 x2 : 0000000000000000
[    0.170888] x1 : ffff800009ff0000 x0 : 0000000000000000
[    0.170899] Call trace:
[    0.170910]  reserve_memblock_reserved_regions+0xd4/0x150
[    0.170921]  do_one_initcall+0x58/0x170
[    0.170931]  kernel_init_freeable+0x1a4/0x264
[    0.170942]  kernel_init+0x10/0x108
[    0.170952]  ret_from_fork+0x10/0x18
[    0.170962] ---[ end trace c7ce9242331f7319 ]---
[    0.170974] name: reserved res: [mem 0xbff00000-0xbfffffff flags 0x200]
...

that memory region corresponds to the ramoops node:

        reserved-memory {
                ramoops@bff00000{
                        compatible = "ramoops";
                        reg = <0x0 0xbff00000 0x0 0x100000>;

                        record-size = <0x20000>;
                        console-size = <0x20000>;
                        ftrace-size = <0x20000>;
                };
        };

According to the comment in reserve_memblock_reserved_regions():

               /*
                 * We expected memblock_reserve() regions to conflict with
                 * memory created by request_standard_resources().
                 */

and the reserved-memory region evades this condition, but i'm not entirely sure how to
properly fix this - any idea?
-- 
bye,
p.
