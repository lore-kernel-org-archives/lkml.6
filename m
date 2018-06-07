Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UUr4I0ylGVu3AQAAmS7hNA
	; Thu, 07 Jun 2018 21:36:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 74C2D6074D; Thu,  7 Jun 2018 21:36:12 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="m1aG0ExP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K1PAEPkh"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0BD51601B4;
	Thu,  7 Jun 2018 21:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0BD51601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeFGVgI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 17:36:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37715 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752561AbeFGVgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 17:36:07 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9643C21C66;
        Thu,  7 Jun 2018 17:36:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 07 Jun 2018 17:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=
        content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Vr6UyETABVf0TwAYiTTT4ztgMJs93OUC1Eiaj9r/IvA=; b=m1aG0ExP
        ME6y72uRC2METmymE8fYaoFqELq4aRpdpXpDqMkp5WmcR3EYA//aL+SopHONyCad
        tu9ci2g8Rc0QPoWdRtaTclFhTYQZPJIA7KHMn4s4B9dKbl4sKzU8B9grqwSdz9A+
        Qy2nfaOXg0HCYb4rUBHuOH8by/cIiQdeekXtfUwG70JaGtIrN+9w3x/lAOWL4ueR
        QzRnzaPx6qacLScZmDgvm5GSluson7498VTn/tkXxYmGoZrYcIyb/9Yitimr3MQj
        qvc8NKC4EYsQtG6OqLqsZdZ9/F9FOd6vRV9Xp1sLomkLW/BMNI++Xy5T827Ivu7a
        Cv1WoHk21fVNEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=Vr6UyETABVf0TwAYiTTT4ztgMJs93
        OUC1Eiaj9r/IvA=; b=K1PAEPkhLMPyXCtrEdylNxn9ds4QFDutSyri5eNs4IHQQ
        lWnsZBkHrLo2/dK6lwQL8fHXNp7Hx0hVlnEVyJNp83FHTDJdwkWx33KGWxS0+4NI
        H77tVqL7A9P5A3URDevtv+7BIK70piyzEPncYxxKhxTerI1NKHKySatQaepcwdaN
        yYWzGztdtTU3qfpdSCRGkzR+zDYSspkvGW4MPKFYHMe9gjI0ab46TvJWNmL+cBFV
        gYE6cWalw06bDhW7B+eBjsZVQumSG8vt4fT8uKvLai6TgGyFdn+SYIIAXtwim4ot
        SOFGLOX7HtJng66PE47uZ4hIpTdOdx0XVPFuekQtA==
X-ME-Proxy: <xmx:RqUZW-iSNAOWWrPA-woz9BSvE9kR088PxpYnAYxx4wjc1pS_qrkUNg>
X-ME-Proxy: <xmx:RqUZW-nm-RtVJHbM3bAuWRLBwsffcA4RymxOd8NuPopHcCCiMbYqGQ>
X-ME-Proxy: <xmx:RqUZW_cq9NdU0w3vpEs69eiVnH04SmtPKihdkzKbXplZlA1cfc6Iug>
X-ME-Proxy: <xmx:RqUZWwGdqUuvXDNILbDgp7HaSHZXPP9VInpc9oaq8UC9BxRvCqp2UQ>
X-ME-Proxy: <xmx:RqUZW5efOqN62Ro2wJfHtfYL2oqoLNSH4WT7iYVqDgMSg-tCMvkzmQ>
X-ME-Proxy: <xmx:RqUZW2VutSs8E-LoRAhxC5uv72Rn2AfA3AETwbDbdarviMimhlAf1Q>
X-ME-Sender: <xms:RqUZW2zemFuwqgkKx3Uhz_5RxuzY7glLJPBoIulf8x_EQ6MizwmX7g>
Received: from localhost (ppp121-45-176-183.bras1.syd2.internode.on.net [121.45.176.183])
        by mail.messagingengine.com (Postfix) with ESMTPA id 82ED21025C;
        Thu,  7 Jun 2018 17:36:05 -0400 (EDT)
Date: Fri, 8 Jun 2018 07:36:02 +1000
From: "Tobin C. Harding" <me@tobin.cc>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] enable early printing of hashed pointers
Message-ID: <20180607213602.GD4934@eros>
References: <1527472002-11571-1-git-send-email-me@tobin.cc>
 <20180528135915.GG4613@thunk.org>
 <20180606233104.GC21148@eros>
 <20180607140002.GA5103@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607140002.GA5103@thunk.org>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 10:00:02AM -0400, Theodore Y. Ts'o wrote:
> On Thu, Jun 07, 2018 at 09:31:04AM +1000, Tobin C. Harding wrote:
> > > I'm also happy to take the whole patch series through the random tree
> > > if everyone else is OK with it.
> > 
> > Looks like every one is happy (or silent) now Ted, can you please take
> > this version through your tree.
> 
> Ok, it's now on the random.git tree.  I'm going to give it a few days
> of soak time in linux-next, and then I'll push it to Linus before the
> end of the merge window.

Great, thanks.

	Tobin.
