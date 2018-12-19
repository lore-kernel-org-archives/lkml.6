Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B971C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BC82080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O1VKTJGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbeLSMms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:42:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55804 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbeLSMmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7JzD9sST2Ctdj4LajoZ1hDVLzXSxrurmQj26lZJofUA=; b=O1VKTJGYhEa0ieC0pklQkScBo
        stSDvmi87k+pg2ypTnu+tLyB+TSDo3hgMBjt0m3DRfj9LwRZDBol2d/VNskwyS4/whART4yj/BoFI
        PcV9hIuleX1IkyBiEg4dEU35WS6uYBmBnj/T1iQDFsP04GXdlNmEv6GItSN4b1QXWC+NICuMtDGVG
        Nd6WoadIUK81nRKp34pEnXGH64irxAqrU9A6Em6fFXzTyWC+Qs5sursJFX1CZVKDlN9LLp2H92oIx
        snAsUG/DfqCdTJVvQ4oUaWd5osA3UqOS+vkHmke8ybPV9eHhdpFDT0EE2mnh5UKEQvOndi7qbZ+MI
        g3dFRgiKQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZbBX-0007ro-CD; Wed, 19 Dec 2018 12:42:47 +0000
Date:   Wed, 19 Dec 2018 04:42:47 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: Re: [LKP] 5404a7f1c2 [ 90.902541] watchdog: BUG: soft lockup - CPU#0
 stuck for 22s! [swapper:1]
Message-ID: <20181219124247.GX10600@bombadil.infradead.org>
References: <20181218002028.GG23332@shao2-debian>
 <20181218121710.GT10600@bombadil.infradead.org>
 <38ee8a35-1bb3-7a63-8ef6-75f0ff46d198@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38ee8a35-1bb3-7a63-8ef6-75f0ff46d198@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 06:03:45PM +0800, Rong Chen wrote:
> On 12/18/2018 08:17 PM, Matthew Wilcox wrote:
> > On Tue, Dec 18, 2018 at 08:20:28AM +0800, kernel test robot wrote:
> > > Greetings,
> > > 
> > > 0day kernel testing robot got the below dmesg and the first bad commit is
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > 
> > > commit 5404a7f1c21cfda061712bedf2d06cc0f6c755e9
> > I feel like you're wasting my time.  This is the fourth time in a row
> > you've reported something I can't reproduce.  At least this time the
> > instructions work, but I've tried it a dozen times and it doesn't produce
> > the error you're showing.
> > 
> > $ git branch
> > * (HEAD detached at 5404a7f1c21c)
> > ...
> > [    0.000000] Linux version 4.20.0-rc1-00012-g5404a7f1c21c (willy@bobo) (gcc version 8.2.0 (Debian 8.2.0-9)) #4 Mon Dec 17 23:28:21 EST 2018
> > ...
> > [    9.848471] test_uuid: all 18 tests passed
> > [   11.019267] XArray: 19496249 of 19496249 tests passed
> > 
> > Your logs show it failing every time.  I can't help but wonder if it's
> > something else in your setup that's causing it to fail -- maybe the
> > machines doing the testing are overloaded?
> 
> Please accept my apologies for taking your time, it might be a false
> positive,
> we have uploaded the original bzImage(https://download.01.org/0day-ci/lkp-qemu/fbc/5404a7f1c21cfda061712bedf2d06cc0f6c755e9/)
> for your reference.

Yes, it doesn't fail here:

[    9.044254] test_uuid: all 18 tests passed
[   10.685486] XArray: 19496249 of 19496249 tests passed
[   10.794246] test_memcat_p: test passed

I notice your logs show it taking over 30 seconds to reach this same
point in boot, so I'm relatively confident in my diagnosis that your
testing machines are overloaded and that's inducing this problem.
