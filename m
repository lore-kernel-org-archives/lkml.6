Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 59867C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB9D2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="Pxi/u1K2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RCqrDOMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB9D2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934626AbeFLVlw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:41:52 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36041 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932869AbeFLVlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:41:37 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 25FA821D44;
        Tue, 12 Jun 2018 17:41:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Jun 2018 17:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=GSGBhWLNEFfTZ8L9Bzcz/gAbY8BnjygY7AlDxtbphNs=; b=Pxi/u1K2
        KM4lXYT6ncpEwyoHaf0seEHhCXWBGsn+CwrsfVNzrQkd1P2BQnrftlzackrzl0mc
        PKilcDU98fw+EWCE61SQju2zMFuhpS+g94JRKhUl7SueoiNYyKyKwFsfTENrdHTb
        X0aeQYPnAQfBTqcyflqjifpo3PAb8viqdmwgN5EwNQT9Or1KPEUtYX+dd3eO44zT
        K9PEV7doFwWsF/tY+XVdw/O35Vc5I9dvrS2n1MDBiHVoshWGe0eRxcep1teNfayW
        2ptwslnluZZSAJD22lL6YkmQejexIVrPEWjkKu/o6sx4LaNNN8hIMS+6MsfrEaIG
        QgMOO/cnO3/SeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=GSGBhWLNEFfTZ8L9Bzcz/gAbY8Bnj
        ygY7AlDxtbphNs=; b=RCqrDOMcvZdoTlZXkUgdrKvD0K+SqR51i+6qYGM7liFVx
        J3L6gxQLwVJ3+dYR7QoBY6JaCXwTHeT0YIPETjGeVnh6L4vmq7Eesba2dP3C2/a1
        uYr0KtetW3GyOavK3JeVKsj3mZ+/dvkZ3h47GsfLZEprd7wgUXylj+6cL8cJ6nhL
        JUhS4i5QedwcUplreliexkU31nJjSA0UMOmKPFErZHsRFyLP3+8Y0AEO1tZpeq6N
        RO+u3cSzD2ZcMIGQctUYBpKKtH4JuhJ18H1N0rlkH1NvqwsT85ag9bGR7ECEk1MP
        zqZmPrxogcT1HzyueITMJeoJUzGRiqnRo1ZlNE+HQ==
X-ME-Proxy: <xmx:ET4gWxCzS7_yX2ooVCo-be7Idxulf1g0owEEAvGZij5A4zDROEI0dQ>
X-ME-Proxy: <xmx:ET4gW2wKtSpY3MmXQR-pW3ZRh8ig50cjYIUvts5U_y_BYwuy1Ilbhg>
X-ME-Proxy: <xmx:ET4gW8E8YkYdePkZ-ZCcxZU4BEsahTU4BXS1WAyTZKRUkRHpKtCtng>
X-ME-Proxy: <xmx:ET4gW07MtqYhUPjreH2PjZnGUPi5FvKzpIWcoRmX-V7GGffFuKgYCw>
X-ME-Proxy: <xmx:ET4gW56Lk0vnFBhsFY98uoaPrdsBwk8B1Mp7bdJrCBWxjgu5xx04LQ>
X-ME-Proxy: <xmx:ET4gW65Q5gNIPq_WinPME2mE0oeR0TYzSSn0b_bk2ROv_z4ostIFPg>
X-ME-Sender: <xms:ET4gW6uUaSDCgyGKZoONCWxqcSut8z7y5iTuhG0pjyhSm2t3Fpu-jA>
Received: from localhost (ppp118-211-220-95.bras1.syd2.internode.on.net [118.211.220.95])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3780FE4F68;
        Tue, 12 Jun 2018 17:41:35 -0400 (EDT)
Date:   Wed, 13 Jun 2018 07:41:32 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/4] vsprintf: Use hw RNG for ptr_key
Message-ID: <20180612214132.GA4528@eros>
References: <1528763954-27731-1-git-send-email-me@tobin.cc>
 <1528763954-27731-4-git-send-email-me@tobin.cc>
 <20180612144458.31930370@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612144458.31930370@vmware.local.home>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 02:44:58PM -0400, Steven Rostedt wrote:
> On Tue, 12 Jun 2018 10:39:13 +1000
> "Tobin C. Harding" <me@tobin.cc> wrote:
> 
> > Currently we must wait for enough entropy to become available before
> > hashed pointers can be printed.  We can remove this wait by using the
> > hw RNG if available.
> > 
> > Use hw RNG to get keying material.
> > 
> > Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks for reviewing this patch again Steve.  My mistake, I forgot to
add your reviewed-by from the last version.

thanks for your patience.

	Tobin
