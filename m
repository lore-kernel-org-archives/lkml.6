Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D408DC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B24420831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LeGR96u5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B24420831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbeKUAx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:53:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKUAx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qM4ROx8wkWbiAUSfunuU1hqMWpWVCzJbFm6Pskark0A=; b=LeGR96u5ZEL1gcWm5p0KyT71A
        Ng7aCwiz4jyGoa2JSjKwgFcjJpVaIo3FkYO4xgeYy6gqIUd29hiYJZIfFBxoL3+J29HoMCwnTXwRZ
        0VUjx99T48ak9IV0mqfggUhJx11tf6bBdrp/iGLpTp+UEbA+yeUE5cdrDeAUDH2kdTcMqWlDHkEhd
        m2OcBnoa5gv5s4xtenZPZPKX6efqE3Va86gHPocdrt6taSLZBYru1fSz53hkZQT9C0ZtffhT1Ooo4
        yIb+EOiQi7N3HsKO7IKATZPtEKNK+JVUKQ1l0kyeqB6Zo5RBVeqlUjaqyqxMT+irl8PKWiR71sn1c
        xF64oGAPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP6wx-0006uM-Jd; Tue, 20 Nov 2018 14:24:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FD262029F87F; Tue, 20 Nov 2018 15:24:22 +0100 (CET)
Date:   Tue, 20 Nov 2018 15:24:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 21/25] procfs: Use vtime aware kcpustat accessor
Message-ID: <20181120142422.GY2131@hirez.programming.kicks-ass.net>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
 <1542163569-20047-22-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542163569-20047-22-git-send-email-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 03:46:05AM +0100, Frederic Weisbecker wrote:
>  		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */

Just a note to let you know the current minimum GCC version is 4.6 :-)
