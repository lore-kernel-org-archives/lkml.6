Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2CEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623B420658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="SiUXC+8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623B420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbeIKBiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:38:11 -0400
Received: from imap.thunk.org ([74.207.234.97]:44920 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbeIKBiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lj/5WHdNGhoSJHTdcUGGhcfcUrbTMpQ/Biva2Qs3B2Y=; b=SiUXC+8rgLBAbhclXEflg2FLz1
        +RsdRY5uoTCicDVBqUh21Fge2HrKz0DaAra52vSHX7bRUcwUtksCHDS2B1P/YqjEhFPP07kkQGN8L
        Kf58OkS3VqEJbF+mp4nt3ACDi33o+Hh01QFAy5T7cmoihjr20mML2DE55DDHafYAJRmA=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fzT0m-0001Lm-5X; Mon, 10 Sep 2018 20:42:20 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6F5B57A56B4; Mon, 10 Sep 2018 16:42:19 -0400 (EDT)
Date:   Mon, 10 Sep 2018 16:42:19 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Meelis Roos <mroos@linux.ee>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>
Subject: Re: rng_dev_read: Kernel memory exposure attempt detected from SLUB
 object 'kmalloc-64'
Message-ID: <20180910204219.GG16557@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Meelis Roos <mroos@linux.ee>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>
References: <alpine.LRH.2.21.1809102006280.8926@math.ut.ee>
 <20180910195342.GD16557@thunk.org>
 <CAKv+Gu-GUdYgy=cJnD5-HB3c2vxv53YbzY10CATocqP2DQrAwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-GUdYgy=cJnD5-HB3c2vxv53YbzY10CATocqP2DQrAwg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 10:02:38PM +0200, Ard Biesheuvel wrote:
> >> [146535.257274] tpm tpm0: A TPM error (379) occurred attempting get random
> >> [146535.257304] usercopy: Kernel memory exposure attempt detected from SLUB object 'kmalloc-64' (offset 0, size 379)!
> 
> The TPM return code '379' is returned from rng_get_data(), and
> interpreted as a byte count rather than an error code.

So there are two bugs here.  Once is in the TPM hw_random driver; it
shouldn't be returning the TPM error code.  The second is that
rng_dev_read() should be more suspicious and validate the number of
bytes returned from the low-level hw_random driver for sanity.

      	       	    		  	    - Ted
