Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ADAC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3549221855
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hR99KKpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeLRMRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:17:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47988 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeLRMRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XVg3WEDVJwS+Rc6X2CzYpeS0uGqDf8NasynHCDL2EA4=; b=hR99KKpRXaL7XZtqhFu7d93RE
        D6XVma6SrP1Qi5kG2e7xkg2MiA2UOMv8w8DCmjvifIACM0s45rW01et7J99fFiv3uPRoMqoUM03Y4
        MNWBVzgrzpHCz2wBa+iB1KYHSzmjGdCm2ZPlb3gYp8BDuKA2yM6w7jpx2RpOxyKJsQ46rN4jZlrLF
        wg4nT3WiF+Bg9Cr/ZmN6NP86KdqouqoOBcyH5PsR+2thKFr2z8hvmhJ5QM0TYifm6lqeLzqqnq3Xc
        XT/sOQ5pqw1E4LX21AkQiQiZekpYlHUIAvRXYq+HeIXLfUewyZ7TGiGNWDSnzQaWE0GuHan+UICPI
        al/F3DZmg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZEJD-0004vz-0h; Tue, 18 Dec 2018 12:17:11 +0000
Date:   Tue, 18 Dec 2018 04:17:10 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: Re: [LKP] 5404a7f1c2 [ 90.902541] watchdog: BUG: soft lockup - CPU#0
 stuck for 22s! [swapper:1]
Message-ID: <20181218121710.GT10600@bombadil.infradead.org>
References: <20181218002028.GG23332@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218002028.GG23332@shao2-debian>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 08:20:28AM +0800, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit 5404a7f1c21cfda061712bedf2d06cc0f6c755e9

I feel like you're wasting my time.  This is the fourth time in a row
you've reported something I can't reproduce.  At least this time the
instructions work, but I've tried it a dozen times and it doesn't produce
the error you're showing.

$ git branch
* (HEAD detached at 5404a7f1c21c)
...
[    0.000000] Linux version 4.20.0-rc1-00012-g5404a7f1c21c (willy@bobo) (gcc version 8.2.0 (Debian 8.2.0-9)) #4 Mon Dec 17 23:28:21 EST 2018
...
[    9.848471] test_uuid: all 18 tests passed
[   11.019267] XArray: 19496249 of 19496249 tests passed

Your logs show it failing every time.  I can't help but wonder if it's
something else in your setup that's causing it to fail -- maybe the
machines doing the testing are overloaded?
