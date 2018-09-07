Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF82C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 02:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FB320857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 02:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="us5yOzYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FB320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbeIGG6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 02:58:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45448 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbeIGG6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 02:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mBvtgJByfl0qwj/AsjXENVBBq/mAnXYOYI4s7lPrtdc=; b=us5yOzYIpgOjtTq8p96jJD0rD
        UrIqsRRPpmbaCKassceJVHsQEZPqMjneaVEiAckQjhptH+uSNnZYipZFftqqSzWj5jpmKznEi4aRZ
        /tGBPzkKzfGa+P/f3isx+tCGlUbhmUoiXJE0EobWcFR/l+bJwyA1UNFDr1SkZRAgdiUrelQ4dPTI+
        wLcv/tmh3/MV7X17aTAOjaWeiORj6qp1H4AFZVAZ5mjzCtxldUXaAM2XBm762yqiEQglV8UQzHwQ/
        qtakG91RxTiAukGthAUqAhXLdc7aY+GZQ9MI/qqP5psv22vjkvb4v4BbjPnhenJ3oaK4ewHftDhuY
        v+z3ykWBQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fy6Mz-0005UQ-9H; Fri, 07 Sep 2018 02:19:37 +0000
Date:   Thu, 6 Sep 2018 19:19:37 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: Re: [LKP] 0a3856392c [   10.513760] INFO: trying to register
 non-static key.
Message-ID: <20180907021937.GA7440@bombadil.infradead.org>
References: <20180907010539.GB6655@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907010539.GB6655@shao2-debian>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 09:05:39AM +0800, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit 0a3856392cff1542170b5bc37211c9a21fd0c3f6
> Author:     Matthew Wilcox <willy@infradead.org>
> AuthorDate: Mon Jun 18 17:23:37 2018 -0400
> Commit:     Matthew Wilcox <willy@infradead.org>
> CommitDate: Tue Aug 21 23:54:20 2018 -0400
> 
>     test_ida: Move ida_check_leaf
>     
>     Convert to new API and move to kernel space.  Take the opportunity to
>     test the situation a little more thoroughly (ie at different offsets).
>     
>     Signed-off-by: Matthew Wilcox <willy@infradead.org>

Thank you test-bot.  Can you check if this patch fixes the problem?

diff --git a/lib/test_ida.c b/lib/test_ida.c
index 2d1637d8136b..b06880625961 100644
--- a/lib/test_ida.c
+++ b/lib/test_ida.c
@@ -150,10 +150,10 @@ static void ida_check_conv(struct ida *ida)
 	IDA_BUG_ON(ida, !ida_is_empty(ida));
 }
 
+static DEFINE_IDA(ida);
+
 static int ida_checks(void)
 {
-	DEFINE_IDA(ida);
-
 	IDA_BUG_ON(&ida, !ida_is_empty(&ida));
 	ida_check_alloc(&ida);
 	ida_check_destroy(&ida);

