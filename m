Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5A7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467C4213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ftNbi+h2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfBZSve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:51:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfBZSve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:51:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zr86ervjjN0kTxtbCNxhF19WxQUCXtp23i2Q0cKcQWU=; b=ftNbi+h25/VQXK/d8pYxpz4jS
        CeH8pim2r9ds6lHO+D0St+q41p4wCJ6m+PR6kUbbcRe73OfyNOeDVQxKUCGHBnybqR6YC+Y/vYk8E
        Hcmhr9KR667xBOonC9Tqrd4MMpUCF7HKDEWFhMqKpwHnJdjAGYtrG4+c7AJxucuQAZGgCPV+rPC2F
        0BnNkTfJghNBKBMUoNaTyYsqiY8+lNiCmZTsCm3szAe6S+TtmSXYXJsYArqTwjcJQw5Ym9JJLbpWh
        WZjq/l+UCPw9LS2TdbSWfu4aR4WcYr10vfS5VCEBWDSk3kMrjIjaDy2Q3HfxHyczohWotYgDBw3WC
        GD87j/ctA==;
Received: from [188.207.104.89] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyhpF-0005hI-IW; Tue, 26 Feb 2019 18:51:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 95C40984351; Tue, 26 Feb 2019 19:51:31 +0100 (CET)
Date:   Tue, 26 Feb 2019 19:51:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Len Brown <lenb@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/14] v2 multi-die/package topology support
Message-ID: <20190226185131.GP2861@worktop.programming.kicks-ass.net>
References: <20190226062012.23746-1-lenb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226062012.23746-1-lenb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 01:19:58AM -0500, Len Brown wrote:
> Restored sysfs core_siblings, core_siblings_list
> 
> 	v1 proposed re-defining this existing attribute to
> 	be the threads in a die, rather than in a package.
> 
> 	For compatibility, decided rather to keep this
> 	attribute unchanged, for now, even though
> 	its name makes little sense, and it makes
> 	no sense in a multi-die system.

So why do things that make no sense? What breaks?
