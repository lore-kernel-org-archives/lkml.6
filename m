Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DBBC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB50224E01
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB50224E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbeFXHR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 03:17:29 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60418 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeFXHR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 03:17:27 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E93F913D398E2;
        Sun, 24 Jun 2018 00:17:21 -0700 (PDT)
Date:   Sun, 24 Jun 2018 16:14:11 +0900 (KST)
Message-Id: <20180624.161411.1560796210597132716.davem@davemloft.net>
To:     tglx@linutronix.de
Cc:     syzbot+a4eb8c7766952a1ca872@syzkaller.appspotmail.com,
        ast@kernel.org, daniel@iogearbox.net, hpa@zytor.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        mingo@redhat.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, x86@kernel.org,
        yoshfuji@linux-ipv6.org, peterz@infradead.org
Subject: Re: BUG: unable to handle kernel paging request in
 bpf_int_jit_compile
From:   David Miller <davem@davemloft.net>
In-Reply-To: <alpine.DEB.2.21.1806240849150.8650@nanos.tec.linutronix.de>
References: <000000000000d48c8e056f5b6c67@google.com>
        <alpine.DEB.2.21.1806240849150.8650@nanos.tec.linutronix.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 24 Jun 2018 00:17:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 24 Jun 2018 09:09:09 +0200 (CEST)

> I'm really tempted to make the BPF config switch depend on BROKEN. 

This really isn't necessary Thomas.

Whoever wrote the code didn't understand that set ro can legitimately
fail.

So let's correct that instead of flaming a feature.

Thank you.
