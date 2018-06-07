Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gEr0BVg4GVvpeQAAmS7hNA
	; Thu, 07 Jun 2018 13:51:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EFD2D607DC; Thu,  7 Jun 2018 13:51:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a+pNcpby"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6AB8D601D2;
	Thu,  7 Jun 2018 13:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6AB8D601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932748AbeFGNvQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:51:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44120 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932246AbeFGNvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gcz4oM2AIzL6vsSBSuwthc6IbQXyVtQE8mm5jijtF5M=; b=a+pNcpbyNoOOVrYS/5dBLFuE2
        XuVWU9u9Yco5fC4UY23b3vifhhB1sonSPfP+ZUu781pWhS+6qaApeWgJcBSivcoPZ1OilOVSfStIk
        +HTTF6sot7iG3iEBqyyG6Lj5UmvPbELjKBFOCPYmOJaOL6QIOZuxCRFxMQqgNzfUv2kKdjDrwTXja
        GFHUy1PJSv4t1MBwRBNvtfj0uqr8uwVY/kYF5+p4+7g+IHlbFcPZ1mYglHyhbgHSkliSRnD5zFFb4
        T9PGnM+9H95VOVtlTNguaAqG5kGgMZLdFuzitjZI80McNqX27n11YlcoGg8VDDn4pmcKIXUhMN2Sv
        qhvhARhmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQvJi-0004i6-Ui; Thu, 07 Jun 2018 13:51:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE7A2201EA7B0; Thu,  7 Jun 2018 15:51:03 +0200 (CEST)
Date: Thu, 7 Jun 2018 15:51:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Luwei Kang <luwei.kang@intel.com>, kvm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, chao.p.peng@linux.intel.com,
        thomas.lendacky@amd.com, bp@suse.de, Kan.liang@intel.com,
        Janakarajan.Natarajan@amd.com, dwmw@amazon.co.uk,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, david@redhat.com,
        bsd@redhat.com, yu.c.zhang@linux.intel.com, joro@8bytes.org
Subject: Re: [PATCH v9 04/12] perf/x86/intel/pt: add new capability for Intel
 PT
Message-ID: <20180607135103.GN12198@hirez.programming.kicks-ass.net>
References: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
 <1526964735-16566-5-git-send-email-luwei.kang@intel.com>
 <20180607134051.rwu5pqtz45cgq7ve@um.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607134051.rwu5pqtz45cgq7ve@um.fi.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 04:40:51PM +0300, Alexander Shishkin wrote:
> On Tue, May 22, 2018 at 12:52:07PM +0800, Luwei Kang wrote:
> > CPUID(EAX=14H,ECX=0):EBX[bit 3] = 1 indicates support of
> > output to Trace Transport subsystem.
> > MSR IA32_RTIT_CTL.FabricEn[bit 6] is reserved if
> > CPUID.(EAX=14H, ECX=0):ECX[bit 3] = 0.
> 
> This should instead say:
> 
> This adds support for "output to Trace Transport subsystem" capability
> of Intel PT, as documented in IA SDM Chapter 36.x.y.z. It means that
> PT can output its trace to an MMIO address range rather than system
> memory buffer.

The $subject also needs attention.
