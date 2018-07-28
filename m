Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069FEC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 07:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909D320842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 07:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909D320842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbeG1Iss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 04:48:48 -0400
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:57982 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbeG1Isr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 04:48:47 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp2.it.da.ut.ee (Postfix) with ESMTP id 713379001B;
        Sat, 28 Jul 2018 10:23:15 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id 57D87220922; Sat, 28 Jul 2018 10:23:13 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id 5870B220905;
        Sat, 28 Jul 2018 10:23:13 +0300 (EEST)
Date:   Sat, 28 Jul 2018 10:23:13 +0300 (EEST)
From:   mroos@linux.ee
To:     Wang YanQing <udknight@gmail.com>
cc:     daniel@iogearbox.net, ast@kernel.org, davem@davemloft.net,
        illusionist.neo@gmail.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, netdev@vger.kernel.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        arnd@arndb.de
Subject: Re: [PATCH] bpf, x32: Fix regression caused by commit 24dea04767e6
In-Reply-To: <20180725164611.GA12441@udknight>
Message-ID: <alpine.LRH.2.21.1807281017420.16256@math.ut.ee>
References: <20180725164611.GA12441@udknight>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Commit 24dea04767e6 ("bpf, x32: remove ld_abs/ld_ind")
> removed the 4 /* Extra space for skb_copy_bits buffer */
> from _STACK_SIZE, but it didn't fix the concerned code
> in emit_prologue and emit_epilogue, and this error will
> bring very strange kernel runtime errors.
> 
> This patch fix it.

For the record:

Tested it on top of 4.18.0-rc6-00192-g864af0d40cdc on the affected
machine and it worked.

-- 
Meelis Roos (mroos@linux.ee)
