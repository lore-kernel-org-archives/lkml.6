Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8921AC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4593E20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="lSWTo/l5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4593E20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeKHMJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 07:09:23 -0500
Received: from imap.thunk.org ([74.207.234.97]:51768 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728611AbeKHMJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 07:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8LJupz1PryDoRgzkcUUNeXGuxp5H6fMM86vYXWhaDgQ=; b=lSWTo/l5w1/6Yi4f1StnO0F4oo
        PxWAZjlDGfgodpTyZ+72YW3XU1xU1Alch/o8QoUXCv6iFNXYrBepi4aCX0R5b+C0fNfKe5pZEmX0I
        2CH7MU2eXEjMaBApDXmNVYw5sDUWQrB/3ClqKum49g6+A5qN7D9LkvL+VQQ53VCay+QY=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gKaAy-0005Qj-RB; Thu, 08 Nov 2018 02:36:08 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4689E7A7D2C; Wed,  7 Nov 2018 21:36:07 -0500 (EST)
Date:   Wed, 7 Nov 2018 21:36:07 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [QUESTION] Microsoft, WSL, and the Linux trademark
Message-ID: <20181108023607.GA22459@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vito Caputo <vcaputo@pengaru.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20181108010608.mlcjfwwsdwt2nee5@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108010608.mlcjfwwsdwt2nee5@shells.gnugeneration.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 05:06:08PM -0800, Vito Caputo wrote:
> In reading the news today, I stumbled across an article talking about a
> $20 "linux-based distro" app for Windows 10.
> 
> This is just a bundled userspace for WSL, there is no actual Linux in
> this thing, yet the trademarked Linux name is used throughout.
> 
> Did Microsoft license the trademark or something?  Did I miss a memo?
> Does their joining the Linux Foundation as a Platinum member two years
> ago include such use of the trademark?
> 
> I'm confused by what seems to be total silence about what _appears_ to
> be an obvious large-scale trademark abuse in everything WSL-related.
> 
> Could somebody informed please shed some light on this?

For information about for the Linux Trademark, please see:

	https://www.linuxmark.org/

I'll note that while Microsoft's Subsystem for Linux does not
*contain* Linux, it certainly can run Linux binaries.  WSL is not
unique in that regard.  Google's gVisor, which is used[1] in Google
Compute Engine's App Engine is implemented in Go and is a Userspace
Kernel, that can also run Linux binaries.

[1] https://cloud.google.com/blog/products/gcp/introducing-app-engine-second-generation-runtimes-and-python-3-7

I can't speak to whether Microsoft registered and received a
sublicense for WSL, or not.  Per the FAQ[2] on the Linux Mark
Institute's web site, it would appear that anyone who wants to use
Linux in a product name, whether it's "Red Hat Enterprise Linux" or
"SuSE Linux Enterprise Server" must request a free sublicense and
agree to the terms of the Sublicense Agreement[3].  Technically,
"Windows Subsystem for Linux" is not product name, but a feature.  I'm
not a trademark lawyer, so I can't speak to whether this would be
required or whether it would fall under Fair Use of a trademark.  For
certain, it would appear to me that "WLinux", Microsoft's distribution
derived from Debian, would be much like "Red Hat Enterprise Linux" as
requiring a trademark sublicense.

If you have further questions that are not answered by the FAQ, the
web site directs people to send inquiries to
trademarks@linuxfoundation.org.

[2] https://www.linuxmark.org/programs/legal/trademark/faq
[3] https://www.linuxmark.org/programs/legal/trademark/sublicense-agreement

Cheers,

						- Ted
