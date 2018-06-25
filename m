Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB4FC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA4425E47
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="RxptM04g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA4425E47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754909AbeFYQbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:31:50 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:53272 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbeFYQbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JhgRNFvvLjWb6Ejg2M6VbLgR0Wn0I5og11R17sZO4fA=; b=RxptM04gk07+sN/eCnfOx1JyWa
        oVKDGQy5PtQZa1GwnNvrTt8JZLvv1Jpe4UFer8KiurdRbFa3nDM6W/WNLkpmLZJjKApCyglcadySE
        tiOx/m2vSgQVq0/K6mU7mAVmf4881/gl8Bwvtq/LVul3J+jNGGASzX36jQdq/75nt13dhnP0qCRg3
        uJRSgOXcM8KWr+r1Jo5amuISf4/kny9Fv+hLS1igITzZQeNZuDbE/7GVSvSajxLO8RW6ZDw4DmTSy
        yA9Cy9YLTp5Ij2qQTvnWSm685BJsQ7ZlcTuzfS3fcUt0WNYjp8lTVDeFpsh265LiIu+NtBJDEElzD
        mS+6GOFA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:46562 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fXUP6-00Ce35-21; Mon, 25 Jun 2018 16:31:48 +0000
Date:   Mon, 25 Jun 2018 09:31:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matteo Croce <mcroce@redhat.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: Build/qemu test results for v4.18-rc2
Message-ID: <20180625163147.GA7112@roeck-us.net>
References: <0ecc33a4-60c0-f978-f281-99844508d09a@roeck-us.net>
 <CA+55aFzhE2PQOM-pykY=GammunCLYhY37eS_UiYnXWXuSvHLZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzhE2PQOM-pykY=GammunCLYhY37eS_UiYnXWXuSvHLZQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
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

On Mon, Jun 25, 2018 at 03:17:47PM +0800, Linus Torvalds wrote:
> On Mon, Jun 25, 2018 at 12:25 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Build results:
> >         total: 134 pass: 113 fail: 21
> > Failed builds:
> >         i386:allyesconfig
> >         i386:allmodconfig
> 
> These seem to be due to the trial code to embed user modules in the
> netfilter modules to use bpf  to do netfilter (aka bpfilter). Right
> now that doesn't cross-compile right.
> 

Yes, looks like they tried again with c24fb5e68ebf ("bpfilter: fix user
mode helper cross compilation"), but it still doesn't work.

Build reference: v4.18-rc2-37-g6f0d349
gcc version: x86_64-linux-gcc.br_real (Buildroot 2017.02) 6.3.0

Building i386:defconfig ... passed
Building i386:allyesconfig ... failed

x86_64-linux-ld: i386:x86-64 architecture of input file
	`net/bpfilter/bpfilter_umh.o' is incompatible with i386 output

Guenter
