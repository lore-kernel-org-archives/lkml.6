Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D990C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEA72152A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEA72152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeI0UqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:46:04 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40665 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbeI0UqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:46:04 -0400
Received: by mail-oi1-f196.google.com with SMTP id j68-v6so2313431oib.7;
        Thu, 27 Sep 2018 07:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A+fxqrdhGjsSvR0U2nmMm7zHy+fn4lKay1VsHft6GBk=;
        b=sFZ24+9cY054VztzUgtk7g8B4rhtG+8dg3d+zqmK86Ur2LBTiu4QsXMm7uVqVsJEhQ
         zXCDssGyG44L6kIETZFB5N2MJbIq9TlBbPBWVBs8vXwHNBbALaxEfM1kzDZJEYg0ptRM
         gB8G1XcvMbv+tc44kJ7sAD6jwrUX/0uULZdeiAbGHNPglEiDHjA2eOl02hvI9QKUKQSV
         89r1CkEThMpTP2Mv0c/pJEIdvEp64klbVky1kmc2GBRxmVrKyUGLo3Cmer86s0kAcpWZ
         v0ryCOmZa7oszIYgETgwPGwLomIqyhSNm0aFEuimeK3YnsBqS8Nb3UgRu4Gec48hZAYC
         CQow==
X-Gm-Message-State: ABuFfohflqEwT3j2Z65GzlCb6zKJrYPpmmk9ekNLZlbUGZHp2IoSUSJx
        /XhS4VwvD3uXjTC2InnOKw==
X-Google-Smtp-Source: ACcGV63PregxNzVKnE22rzK1muw0DDpnuOIUpx0oCP+msf6GT29tID28AQcAzeAlblKmm9MdTELBBg==
X-Received: by 2002:aca:120b:: with SMTP id 11-v6mr3107008ois.151.1538058452021;
        Thu, 27 Sep 2018 07:27:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z41-v6sm922652otc.13.2018.09.27.07.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 07:27:31 -0700 (PDT)
Date:   Thu, 27 Sep 2018 09:27:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] of: unittest: Disable interrupt node tests for old
 world MAC systems
Message-ID: <20180927142730.GA27916@bogus>
References: <1537934784-19819-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537934784-19819-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 09:06:24PM -0700, Guenter Roeck wrote:
> On systems with OF_IMAP_OLDWORLD_MAC set in of_irq_workarounds, the
> devicetree interrupt parsing code is different, causing unit tests of
> devicetree interrupt nodes to fail. Due to a bug in unittest code, which
> tries to dereference an uninitialized pointer, this results in a crash.
> 
> OF: /testcase-data/phandle-tests/consumer-a: arguments longer than property
> Unable to handle kernel paging request for data at address 0x00bc616e
> Faulting instruction address: 0xc08e9468
> Oops: Kernel access of bad area, sig: 11 [#1]
> BE PREEMPT PowerMac
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Not tainted 4.14.72-rc1-yocto-standard+ #1
> task: cf8e0000 task.stack: cf8da000
> NIP:  c08e9468 LR: c08ea5bc CTR: c08ea5ac
> REGS: cf8dbb50 TRAP: 0300   Not tainted  (4.14.72-rc1-yocto-standard+)
> MSR:  00001032 <ME,IR,DR,RI>  CR: 82004044  XER: 00000000
> DAR: 00bc616e DSISR: 40000000
> GPR00: c08ea5bc cf8dbc00 cf8e0000 c13ca517 c13ca517 c13ca8a0 00000066 00000002
> GPR08: 00000063 00bc614e c0b05865 000affff 82004048 00000000 c00047f0 00000000
> GPR16: c0a80000 c0a9cc34 c13ca517 c0ad1134 05ffffff 000affff c0b05860 c0abeef8
> GPR24: cecec278 cecec278 c0a8c4d0 c0a885e0 c13ca8a0 05ffffff c13ca8a0 c13ca517
> 
> NIP [c08e9468] device_node_gen_full_name+0x30/0x15c
> LR [c08ea5bc] device_node_string+0x190/0x3c8
> Call Trace:
> [cf8dbc00] [c007f670] trace_hardirqs_on_caller+0x118/0x1fc (unreliable)
> [cf8dbc40] [c08ea5bc] device_node_string+0x190/0x3c8
> [cf8dbcb0] [c08eb794] pointer+0x25c/0x4d0
> [cf8dbd00] [c08ebcbc] vsnprintf+0x2b4/0x5ec
> [cf8dbd60] [c08ec00c] vscnprintf+0x18/0x48
> [cf8dbd70] [c008e268] vprintk_store+0x4c/0x22c
> [cf8dbda0] [c008ecac] vprintk_emit+0x94/0x130
> [cf8dbdd0] [c008ff54] printk+0x5c/0x6c
> [cf8dbe10] [c0b8ddd4] of_unittest+0x2220/0x26f8
> [cf8dbea0] [c0004434] do_one_initcall+0x4c/0x184
> [cf8dbf00] [c0b4534c] kernel_init_freeable+0x13c/0x1d8
> [cf8dbf30] [c0004814] kernel_init+0x24/0x118
> [cf8dbf40] [c0013398] ret_from_kernel_thread+0x5c/0x64
> 
> The problem was observed when running a qemu test for the g3beige machine
> with devicetree unittests enabled.
> 
> Disable interrupt node tests on affected systems to avoid both false
> unittest failures and the crash.
> 
> With this patch in place, unittest on the affected system passes with
> the following message.
> 
> 	dt-test ### end of unittest - 144 passed, 0 failed
> 
> Fixes: 53a42093d96ef ("of: Add device tree selftests")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Do not use goto to skip tests.
>     Provide test log in commit message.
> 
>  drivers/of/unittest.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)

Applied.

Rob
