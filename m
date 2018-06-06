Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id p5ZZKlxuGFt2GgAAmS7hNA
	; Wed, 06 Jun 2018 23:30:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 649836089E; Wed,  6 Jun 2018 23:30:29 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="UBEB398k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lyciAezF"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CD7DF607E4;
	Wed,  6 Jun 2018 23:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD7DF607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932188AbeFFXa0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 19:30:26 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39491 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932100AbeFFXaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 19:30:25 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C893B21DE0;
        Wed,  6 Jun 2018 19:30:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 06 Jun 2018 19:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=G0VaqNWCx8vU+6PPKv3l1D8FBm0YrzTwnrhrZ1GizLY=; b=UBEB398k
        ttcGadKghy2CVZ9gnUtzgZNW17OuyHMESKS9JL5qAOhCCnYf9DsAdcCnns7vOBAw
        1toPHRKdkmYmQ8SXalhDF71HXrz9XwMkKs8pUBHFgtJx+mjGBW3M83X8Nap/OnSw
        ++/1uSrIYAd8W5ygAuLAhQW3oDH6LFEvur6FQsPusbfeAYcMz0yTWGRU/3eU8HGL
        M9rs0/1+eYBZxWLDX6RpPggVWeb3Yrhq737ypdFVXgiT6u8JFo0LKrIZPu/VUNXI
        cC/bdPEY8QykSpGTyccE9Lal6pVSiogRtWxa1zGqvdNClYA46RiEmltS/XNJkvYW
        OhobxI7HZJ5eKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=G0VaqNWCx8vU+6PPKv3l1D8FBm0Yr
        zTwnrhrZ1GizLY=; b=lyciAezFLG63JBQUj364R/1VoNScuEyj8RQhaOgzxi2tr
        eTTwyPjvvwRt2EcL3zkyodlOPf0sLtR837doxnNzHlPReww6BERhmXkGUTBXS20y
        6Lq+8Nh1/OPSXYX1L1s1irF40X7GgtMTjRwmioBkMXwjVVC6rJvC27qwxgBYbS6q
        GW1IE8BfKi/AOh4FjYCakjxeLBFpDcPWtLnsPGXuwHMx9+Oe3Xl5+X35+thRGIDN
        DimQ6M1edTJ0KXgKsBguumFkRx52E2VWtUJm0FM4JsxPcuznX8P6E1NNNgKYTPHC
        +ZYx2kqxExvI+WQL0azaS0orv4vmeIsEfj/59Iqpw==
X-ME-Proxy: <xmx:kG4YW-CdLDZ8PVCg29HEn8xre_sy2QFEvaeGV6myrkiHgvhinJkMug>
X-ME-Proxy: <xmx:kG4YW0_55dSHzx-SbDndetpNAh8ikxya-UCW22gFuoI8fnOBTaODGQ>
X-ME-Proxy: <xmx:kG4YW41rmqWCjEeOb7VnoQZ4UospRTklr0wZMHKRGPfOLYuDcn09Vw>
X-ME-Proxy: <xmx:kG4YWzSVsWjpf-neGPEq0NHSbDRt8jDZ8nYvB3XCpYI8ua2Q49GY2w>
X-ME-Proxy: <xmx:kG4YWzikfBduDfMV9VZD1GmCFLhp32oxhPknjkYld7vz3nTC2R2Ovg>
X-ME-Proxy: <xmx:kG4YW_Hd9wzvR3SXt2Or0-c2zq1M_8HwynseaBkKTaROIngf3gebPw>
X-ME-Sender: <xms:kG4YWwFykdXQUSIrtiRMjwQaOOfgK0XXxl6yTrTbJM06NOCQvKERVw>
Received: from localhost (124-169-155-53.dyn.iinet.net.au [124.169.155.53])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0D280E452C;
        Wed,  6 Jun 2018 19:30:23 -0400 (EDT)
Date: Thu, 7 Jun 2018 09:30:21 +1000
From: "Tobin C. Harding" <me@tobin.cc>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] enable early printing of hashed pointers
Message-ID: <20180606233021.GB21148@eros>
References: <1527472002-11571-1-git-send-email-me@tobin.cc>
 <alpine.DEB.2.21.1806061501130.1579@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806061501130.1579@nanos.tec.linutronix.de>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 03:02:20PM +0200, Thomas Gleixner wrote:
> On Mon, 28 May 2018, Tobin C. Harding wrote:
> 
> > Currently printing pointers early in the boot sequence can result in a
> > dummy string '(____ptrval____)' being printed.  While resolving this
> > issue it was noticed that we can use the hw RNG if available for hashing
> > pointers.
> > 
> > Patch one and two do the ground work to be able to use hw RNG removing
> > from get_random_bytes_arch() the call to get_random_bytes() and
> > returning the number of bytes of random material successfully returned. 
> > 
> > Patch three uses the hw RNG to get keying material if it is available.
> > 
> > Patch four further assists debugging early in the boot sequence for
> > machines that do not have a hw RNG by adding a command line option
> > 'debug_boot_weak_hash'.  If enabled, non-cryptographically secure hashing
> > is used instead of siphash so we can hash at any time. 
> > 
> > During the versions of this set I have been totally confused about which
> > patches go through which tree.  This version again puts all 4 patches
> > together in the hope they will go through Andrew's tree.
> > 
> > 
> > Steve,
> > 
> > Could you please take a quick squiz at the final 2 patches if you get a
> > chance.  I assumed we are in preemptible context during early_init based
> > on your code (and code comment) and called static_branch_disable()
> > directly if hw RNG returned keying material.  It's a pretty simple
> > change but I'd love to get someone else to check I've not noob'ed it.
> 
> early_initcalls() are not that early :) They run in thread context fully
> preemtible so calling static_branch_disable() is perfectly fine.

Thanks for the explanation.

	Tobin.
