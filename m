Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3520C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D6A2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="s3nqPXcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D6A2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbeKAHld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:41:33 -0400
Received: from imap.thunk.org ([74.207.234.97]:50456 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbeKAHld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=+L2vOxHMyCcInmLMMJQ8mkFn7YFTt/HYm447/fVC1R0=; b=s3nqPXcOPvr392mSFqhmsmlVeQ
        9Xx4YhyAQdMEf6m//qSx/LEW5Wj1xT7ElL4bXrABz2KULjVI49W7QsKS6Cnj8X0fU17MLI4emiAKX
        aBrVh+nvyHKQ6rBnNIBHgIX6MrbflJvMaxmr44QgTekyv0UX3os6t5U3VpF3mQKluSgY=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gHzAh-0008RI-Ot; Wed, 31 Oct 2018 22:41:07 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BB40B7A7B09; Wed, 31 Oct 2018 18:41:06 -0400 (EDT)
Date:   Wed, 31 Oct 2018 18:41:06 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc:     Kurt Roeckx <kurt@roeckx.be>, 912087@bugs.debian.org,
        "Package Development List for OpenSSL packages." 
        <pkg-openssl-devel@alioth-lists.debian.net>,
        linux-kernel@vger.kernel.org,
        Bernhard =?iso-8859-1?Q?=DCbelacker?= <bernhardu@mailbox.org>,
        pkg-systemd-maintainers@lists.alioth.debian.org,
        debian-ssh@lists.debian.org, 912087-submitter@bugs.debian.org
Subject: Re: Bug#912087: openssh-server: Slow startup after the upgrade to
 7.9p1
Message-ID: <20181031224106.GD6236@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        Kurt Roeckx <kurt@roeckx.be>, 912087@bugs.debian.org,
        "Package Development List for OpenSSL packages." <pkg-openssl-devel@alioth-lists.debian.net>,
        linux-kernel@vger.kernel.org,
        Bernhard =?iso-8859-1?Q?=DCbelacker?= <bernhardu@mailbox.org>,
        pkg-systemd-maintainers@lists.alioth.debian.org,
        debian-ssh@lists.debian.org, 912087-submitter@bugs.debian.org
References: <20181029223334.GH10011@roeckx.be>
 <20181030001807.7wailpm37mlinsli@breakpoint.cc>
 <20181030141544.GE15839@thunk.org>
 <20181030183723.GI10011@roeckx.be>
 <20181030205136.GB6236@thunk.org>
 <6BBD7CF1-696B-4B5E-ABD8-A30C2F15E5C5@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6BBD7CF1-696B-4B5E-ABD8-A30C2F15E5C5@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 11:21:59AM +0000, Sebastian Andrzej Siewior wrote:
> On October 30, 2018 8:51:36 PM UTC, "Theodore Y. Ts'o" <tytso@mit.edu> wrote:
> >
> >So it's complicated.  It's not a binary trusted/untrusted sort of
> >thing.  
> 
> What about RNDRESEEDCRNG? Would it be reasonable to issue it after writing the seed as part of the boot process?

No, that's for debugging purposes only.

When there is sufficient entropy added (either through a hw_random
subsystem, or because RDRAND is trusted, or the RNDADDENTORPY ioctl),
the crng is automatically reseeded by credit_entropy_bits().  So it's
not needed to use RNDRESEEDCRNG.

					- Ted
