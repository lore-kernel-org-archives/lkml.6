Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F96ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE8A20854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="mOoiE35u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE8A20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbeGRPEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:04:43 -0400
Received: from imap.thunk.org ([74.207.234.97]:57080 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730123AbeGRPEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=PCBwdRZ1mcUvHLqdmdrQtlawWulAYCxtHc+C8zCeC9Y=; b=mOoiE35uSNXdjpyLqyDnO6La/6
        FeCPYM7PsBEbSRedjRj0WQuiPSc4QOlO3eExK1HIURJ/fbLhWywkCE9aa0Jc3jaTE/uadSzYL3gHx
        gwmcaPou/RIT0CCFfSdJO+AbgmSd+jo2mslqQTLbcJpNheMUQUAb034Dp/rYKHsEIii8=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1ffnPP-0003Jy-Nh; Wed, 18 Jul 2018 14:26:27 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 52BC77A6404; Wed, 18 Jul 2018 10:26:25 -0400 (EDT)
Date:   Wed, 18 Jul 2018 10:26:25 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Yann Droneaud <ydroneaud@opteya.com>
Cc:     linux-crypto@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        labbott@redhat.com
Subject: Re: [PATCH] random: add a config option to trust the CPU's hwrng
Message-ID: <20180718142625.GA5942@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Yann Droneaud <ydroneaud@opteya.com>, linux-crypto@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        labbott@redhat.com
References: <20180718014344.1309-1-tytso@mit.edu>
 <37046662f2b38f98854abfa1b5868a27c3fa0888.camel@opteya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37046662f2b38f98854abfa1b5868a27c3fa0888.camel@opteya.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 09:22:13AM +0200, Yann Droneaud wrote:
> 
> The text message should explain this is only relevant during
> initialization / early boot.
> 
> The config option name should state this.

There are other workarounds for hangs that happen after initialization
/ early boot, yes.  They are of varying levels of quality / safely,
but that's neither here nor there.

However, enabling config option means that the CRNG will be
initialized with potentially information available to the CPU
manufacturer and/or Nation States, and this persists *after*
initialization / early boot.  So to say, "we're perfectly safe after
we leave initialization / early boot" is not true.

So I'd much rather make it clear that we are trusting the CPU
manufacturer far more than just during early boot.

Cheers,

					- Ted
