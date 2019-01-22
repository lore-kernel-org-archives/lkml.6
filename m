Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53333C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8E9218D9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="du3MVWKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfAVJ0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:26:32 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58104 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfAVJ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0ZboY0ZOPY5NRmUJpEeX7C8MEb6oU8DVQqtFVVjDqNA=; b=du3MVWKqmHsdf3DhGvsPai4EA
        3cpTGOZq7lFzZ45B+593seGKoqyr6TdL03QFqXitgiEOu6Cj4U+dUrixzX0iKbVxosMDTGHN40PAx
        K1WgkWTDskxcFA2BtzdP4Jm/B9PSelFmivKAff59Lg4MQCu68u5G+BA7DB1wBKWaWhJG+nLaeyB+E
        3W+HFGYieg61HQsrQzL8tt/O7TiaeVqoiKt+W6/rF3UlexxvDlZAdT4SkvDszUJEmIpKpKOMegTYD
        QWAat5VVY/67vr2FGq25QaVfdHc4+nfPHzhBfQAqV3u6RmbVcxL7CLZzTCbqYTbkrPgZdQP3CXh/g
        qnCZfIPuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glsK1-00076Q-S0; Tue, 22 Jan 2019 09:26:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58A94200C07BD; Tue, 22 Jan 2019 10:26:16 +0100 (CET)
Date:   Tue, 22 Jan 2019 10:26:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH 2/5] sched: convert signal_struct.sigcnt to refcount_t
Message-ID: <20190122092616.GF13777@hirez.programming.kicks-ass.net>
References: <1547814450-18902-1-git-send-email-elena.reshetova@intel.com>
 <1547814450-18902-3-git-send-email-elena.reshetova@intel.com>
 <20190121172822.GB8088@redhat.com>
 <2236FBA76BA1254E88B949DDB74E612BA4B8B877@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4B8B877@IRSMSX102.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 09:11:42AM +0000, Reshetova, Elena wrote:
> Will you be able to take this and the other scheduler
> patch to whatever tree/path it should normally go to get eventually 
> integrated? 

I've queeud them up.
