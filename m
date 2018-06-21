Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545F5C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B2220875
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="gkB5pGmO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RET9ckmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B2220875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754698AbeFUDPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 23:15:12 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40711 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754678AbeFUDPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 23:15:10 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DC2C421BAD;
        Wed, 20 Jun 2018 23:15:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 20 Jun 2018 23:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=FZ7aVKGf328QsEcNs69IR9JPkPUOM8nA0xNfWCopSm0=; b=gkB5pGmO
        w/pk2PuepZkR5mbx78EuZ1gyyS7OzQEdTYPMyzZrv0nqaFV50VYzAcPSSiBOdJ/O
        W+hiihGus0Utqq5lhbYphDB3V3dkYrzj1uJTwPNTh9VFR2R1tZKgQZmxXcBiRKql
        dII35TTB54np1dZxH3TLCFSXekE2kh5QFZHzezQ2B/Vo5qe6xLzw3WYchz5oEp1o
        Qe9n8OdvQZOecGwi/b4pE0IPHeMaBZ0uG6BBAzY8WItw7nAsW/p0OSvTw8EE2Wvj
        p9Fkt56yBiDlsjQPbn+L6M5JroXvihc5A/yBS0xOKymXn8iJ876fbDoTNv0UHXYA
        d82mJXR/USAPog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=FZ7aVKGf328QsEcNs69IR9JPkPUOM
        8nA0xNfWCopSm0=; b=RET9ckmQXjPduVgM+T+g4H4tBCvdLWO9Zdg5luyGLIX25
        991EOMbDIaseV0LS60IDTBNbZ8edPA5RTdMLeKTgnxXEj6+eIGGwN2SVbnMy1V3O
        TiTP8n5M8P/GsNC2zTHnSxka6Dppm9JRQALnmEfyTIMkukU6MahgrKXwBOgNc+8G
        r0jO7rD5pCoTP20juRzFlvkrsu6knDbA/Cr75qqeTrQ9zPKuE5KioYHWRML/Se2T
        kqIbdUmuvhok54jInm/VXa9O7jY131UaBAgGtQjKOnOfN3fsh4Xmt1IN1qN2EsNn
        voMLi5U6M6KelaiLcDWd5AnSfihRNaiQGBKn3+QLw==
X-ME-Proxy: <xmx:PRgrWzhlMlvgTasrSCj1M9sVWGbrxGI3XkRIz798kI0ATK_Dn9kObA>
    <xmx:PRgrW4_my-QPpLudMB8RfYJDT3c7yRSDeogMdiYhBQsbzdBUZAjDgg>
    <xmx:PRgrW1CQYcdSXutRnjAVGXvOgEnOcGCj5tGU2xasG5EQpokpNVRZ_Q>
    <xmx:PRgrW9IEh9ELGSFrbkwLLE8tQKYYrkJ3nwMBPlLrW1imAu6il890YQ>
    <xmx:PRgrWwmxO8RenIbtZTt_YoPfsZfJf5RE075dij-LVijwp7pM5wBdmw>
    <xmx:PRgrW4GxjIM0LW5-2TbgPZc5tUvQk9kA4azHEYulYvPx7TIabCOCEg>
X-ME-Sender: <xms:PRgrW47bFFgDzz65-i-YQqg2fR1dLFo-AwsHtSeEgMEMepyt-nYy6w>
Received: from localhost (124-171-16-226.dyn.iinet.net.au [124.171.16.226])
        by mail.messagingengine.com (Postfix) with ESMTPA id 08AACE4270;
        Wed, 20 Jun 2018 23:15:08 -0400 (EDT)
Date:   Thu, 21 Jun 2018 13:15:05 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/4] vsprintf: Add command line option
 debug_boot_weak_hash
Message-ID: <20180621031505.GA18398@eros>
References: <20180620042046.30806-1-me@tobin.cc>
 <20180620042046.30806-5-me@tobin.cc>
 <e4f6bfb3-68c7-9f57-0d90-d68d0913234a@infradead.org>
 <20180620223014.GE11671@eros>
 <b472dca0-9bd0-caf3-efab-586b6ff32765@infradead.org>
 <20180620232233.GH11671@eros>
 <983177e0-8684-c7b8-4328-065be5c78e63@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <983177e0-8684-c7b8-4328-065be5c78e63@infradead.org>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 04:38:05PM -0700, Randy Dunlap wrote:
> On 06/20/2018 04:22 PM, Tobin C. Harding wrote:
> > On Wed, Jun 20, 2018 at 03:36:44PM -0700, Randy Dunlap wrote:
> >> On 06/20/2018 03:30 PM, Tobin C. Harding wrote:
> >>> On Wed, Jun 20, 2018 at 09:09:49AM -0700, Randy Dunlap wrote:
> >>>> On 06/19/2018 09:20 PM, Tobin C. Harding wrote:
> >>>>> Currently printing [hashed] pointers requires enough entropy to be
> >>>>> available.  Early in the boot sequence this may not be the case
> >>>>> resulting in a dummy string '(____ptrval____)' being printed.  This
> >>>>> makes debugging the early boot sequence difficult.  We can relax the
> >>>>> requirement to use cryptographically secure hashing during debugging.
> >>>>> This enables debugging while keeping development/production kernel
> >>>>> behaviour the same.
> >>>>>
> >>>>> If new command line option debug_boot_weak_hash is enabled use
> >>>>> cryptographically insecure hashing and hash pointer value immediately.
> >>>>>
> >>>>> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> >>>>> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >>>>> ---
> >>>>>  Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
> >>>>>  lib/vsprintf.c                                  | 17 +++++++++++++++++
> >>>>>  2 files changed, 26 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >>>>> index 638342d0a095..a116fc0366b0 100644
> >>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
> >>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >>>>> @@ -748,6 +748,15 @@
> >>>>>  
> >>>>>  	debug		[KNL] Enable kernel debugging (events log level).
> >>>>>  
> >>>>> +	debug_boot_weak_hash
> >>>>> +			[KNL] Enable printing pointers early in the boot
> >>>>> +			sequence.  If enabled, we use a weak hash instead of
> >>>>> +			siphash to hash pointers.  Use this option if you need
> >>>>> +			to see pointer values during early boot (i.e you are
> >>>>
> >>>> maybe:
> >>>> 			to see hashed pointer values
> >>>> i.e., not raw pointers.
> >>>
> >>> You cannot see 'raw pointers' anyways?
> >>
> >> only if using %px ?
> >>
> >> Maybe it's just terminology.  I don't consider a hashed value as a pointer value.
> >> It's just a key or handle or some other number, but it's not a pointer.
> >>
> >>>>
> >>>>> +			seeing instances of '(___ptrval___)').
> >>>>> +			Cryptographically insecure, please do not use on
> >>>>> +			production kernels.
> >>>
> >>> thanks for the review, I don't quiet see how to use your suggestion to
> >>> make the text clearer.  If you still feel this change is needed perhaps
> >>> you could write so I understand i.e 'Use this option if ...'
> >>
> >>
> >> OK, if you are good with it, I am too.  :)
> > 
> > I get you know.  I agree, how about this
> > 
> > 			[KNL] Enable printing pointers early in the boot
> > 			sequence.  If enabled, we use a weak hash instead of
> > 			siphash to hash pointers.  Use this option if you need
> > 			to print pointers with %px during early boot
> > 			(i.e you are seeing instances of '(___ptrval___)').
> > 			Cryptographically insecure, please do not use on
> > 			production kernels.
> 
> Sorry, I'm still confused by this paragraph.  It seems to say two different
> things.

My bad, I got totally confused myself.  After all this time you would
think I knew which specifier hashed and which didn't.  My apologies,
how about this:

 			[KNL] Enable printing [hashed] pointers early in
			the boot sequence.  If enabled, we use a weak hash
			instead of siphash to hash pointers.  Use this option if
			you are seeing instances of '(___ptrval___)') and need
			to see a value (hashed pointer) instead. Cryptographically
			insecure, please do not use on production kernels.
 			 			

thanks for your patience,
Tobin.
