Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 152AFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EE620891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r7i+mPns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EE620891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933640AbeFLUOT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:14:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47742 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932768AbeFLUOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=edz73lJtyFma03ptPwbjaKspQQtNh4UpeT69geOGlyc=; b=r7i+mPns48RfDigqLFfgQ7rQD
        hY2oLEkfuOv3P4D2dJecJC2EuxbqFKB5fhspSQ2e5tMPOYEMuuRuqHiZI+V1DFf7RSlQ+7B0G2tLC
        /FqkirdEel9iH1aVSCPUPRhMxdasg9n+w6QRBpgVX29tjjgpSRSpdFdsDBHP4k1eSWpjFnDP6XMx7
        a8KF7IxiSAoUEAYfRlmpM/uv1b6I4R5Epy7WgW6+aJ8LEnQSJronRueDQEVTPXXozF1jSc4Jd5aGQ
        SqixYgsZnBhiRlsA6YZ1rZ+CxAQoOENb/zlq5VJ+aJs/UTMVpwVlsZv14IH7q/6rbLpNyOv3uSddH
        O2IK7bjJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSpgE-0007KH-61; Tue, 12 Jun 2018 20:14:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9077201EA7A3; Tue, 12 Jun 2018 22:14:11 +0200 (CEST)
Date:   Tue, 12 Jun 2018 22:14:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 0/3] Introduce atomic_dec_and_lock_irqsave +
 refcount_dec_and_lock_irqsave()
Message-ID: <20180612201411.GU12198@hirez.programming.kicks-ass.net>
References: <20180612161621.22645-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612161621.22645-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 06:16:18PM +0200, Sebastian Andrzej Siewior wrote:
> This patchset introduces atomic_dec_and_lock_irqsave() and
> refcount_dec_and_lock_irqsave(). The individual user are not part of
> this series.
> The custom Alpha implementation of atomic_dec_and_lock() is removed
> because the decrement operation is not a RELEASE operation (pointed out
> by Peter Zijlstra).

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
