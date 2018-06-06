Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id q5ZZKlxuGFt2GgAAmS7hNA
	; Wed, 06 Jun 2018 23:31:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 000B0607F7; Wed,  6 Jun 2018 23:31:11 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="NiE4+itT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dLVYekD9"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7785B607E4;
	Wed,  6 Jun 2018 23:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7785B607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752886AbeFFXbJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 19:31:09 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58769 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752056AbeFFXbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 19:31:08 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CC0FC21DBB;
        Wed,  6 Jun 2018 19:31:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 06 Jun 2018 19:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=
        content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=duk//5ESaSKD5rSyQ1KZSLAp4puVYw+U7k1kf3u1blM=; b=NiE4+itT
        QmJqK3Fp0xztWf2OtqCbt1aKDOlA+/vz6h1BJr6BMyEk8UwicCyfUxXJ+Qp6BlFZ
        hAN64D0YXgYSAOgj/wBJrmcP7/DylQ+i+FaiRIu35WOpIrLHxgfF5X/BdOJVmkt4
        lScwBgFHOrARzccBnWrleizX2vlHDQrJ+2RhZqufvHM2pETls2amWWwTeJATs3fr
        SCGlw3f4/IwMjJmfuZ/5Tq/Jvu+hQAxfLlA7lmyW/L0E61jR5BEtlUEe6RNb5TnT
        KiHxETVaJ/0LAGH5iGzDfIqFswJe1x6Sw4HZ/IEhnfKHzEWyu1TajyMp52jgartX
        YMSlv0Injq7OPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=duk//5ESaSKD5rSyQ1KZSLAp4puVY
        w+U7k1kf3u1blM=; b=dLVYekD9fV8G1BhAPjPpj92j19WKz/hjIxHbeOvUMhXPf
        3gKRIacxWQl4f5lcId6p+ZtCngF6AN+sL1rISYbTctr5pDqDsMG7ScP6ey2Ee1fv
        /0LzU9pvg+vgv2pN5IlrDyvgbcfw0EWJ9vDXm3qIrzNJ1n8a/p7LTmTzGL2q0nYj
        qHVy+xUY3lrbcjBbf1H05AS6iA3qES31vl0tNCqCh0yYTGIflwql3dYbartz9Ul6
        imZuRn+2xYP29e/EbMMpTZLW/RDxDGBWLPKW/VccG2Xq/c2MkbE2QX1reW6kPedK
        NVviPxUD5lfWCGMIC6Pr/D2TEXJ7pB9DB2XU9kRNw==
X-ME-Proxy: <xmx:u24YW9RGRS2LKAaq8_YAqYMKBHGQybaEFflyNZ_FKNoqMNjryon7Sw>
X-ME-Proxy: <xmx:u24YW97RsBqoMSnwtRfmJpHD__3LCm41gJ7Yar6xBXd5PD4T5MIJNg>
X-ME-Proxy: <xmx:u24YW1NMWSZBh0e89o1unc-3yO8AQeKpq_-qAzdT7vgcC2pVzuHBUA>
X-ME-Proxy: <xmx:u24YW-v7e6LxX8H-ngYL2Jq6bezlwo2oV650mKUTXHSFvpusj8GmSw>
X-ME-Proxy: <xmx:u24YW8ZZdX8dGZK_SonZAfWSeJ5ZXeABfYyFFIvRZDYId9N_LwX89w>
X-ME-Proxy: <xmx:u24YW8WiQwdDjcuuqdISCQfi-HfKrCekWBwcHD-mXaq0QADOM6mc3g>
X-ME-Sender: <xms:u24YW7-CRfwYh0687X6RQt1RLmYJNqw1ZRAP5pfNHnQltFEX69trnw>
Received: from localhost (124-169-155-53.dyn.iinet.net.au [124.169.155.53])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0E04DE43E8;
        Wed,  6 Jun 2018 19:31:06 -0400 (EDT)
Date: Thu, 7 Jun 2018 09:31:04 +1000
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
Message-ID: <20180606233104.GC21148@eros>
References: <1527472002-11571-1-git-send-email-me@tobin.cc>
 <20180528135915.GG4613@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528135915.GG4613@thunk.org>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 09:59:15AM -0400, Theodore Y. Ts'o wrote:
> On Mon, May 28, 2018 at 11:46:38AM +1000, Tobin C. Harding wrote:
> > 
> > During the versions of this set I have been totally confused about which
> > patches go through which tree.  This version again puts all 4 patches
> > together in the hope they will go through Andrew's tree.
> 
> I'm also happy to take the whole patch series through the random tree
> if everyone else is OK with it.
> 
> Thoughts?

Looks like every one is happy (or silent) now Ted, can you please take
this version through your tree.

thanks,
Tobin.
