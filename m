Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F73C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800A720883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="H5s1mfKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800A720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeKHHoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:44:14 -0500
Received: from imap.thunk.org ([74.207.234.97]:51162 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbeKHHoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3PHX28R6VeX1+w9Gna/v4Io1u+/VtHSvstl4AW246e0=; b=H5s1mfKX/xHV8by4Aw1H9d3Orb
        HFh7clDipRnWiSmIkFmOF2EC6QE+Uq3RE3Nki+0Urer8RJvEUajNlrh/gxguWhxvorsHfBrgjO64i
        c0Q4+9/n5XfLtwQBqPOl7alOqD75pZkzwQ5vPEgz38VncfPz7UnJR2OB/ggeUamKZCwE=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gKW3B-0003k8-Tl; Wed, 07 Nov 2018 22:11:49 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EB79B7A7D27; Wed,  7 Nov 2018 17:11:48 -0500 (EST)
Date:   Wed, 7 Nov 2018 17:11:48 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drivers/char/random.c: make primary_crng static
Message-ID: <20181107221148.GC17171@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20181102110447.23121-1-linux@rasmusvillemoes.dk>
 <20181102110447.23121-3-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102110447.23121-3-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 12:04:47PM +0100, Rasmus Villemoes wrote:
> Since the definition of struct crng_state is private to random.c, and
> primary_crng is neither declared or used elsewhere, there's no reason
> for that symbol to have external linkage.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Thanks, applied.

					- Ted
