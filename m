Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD02C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FA52098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="SHTUxUJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FA52098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbeIYVWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:22:10 -0400
Received: from imap.thunk.org ([74.207.234.97]:45336 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729171AbeIYVWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2W5HkU1o9nkh7mvJTPmBHSGL8GA5ZdDy7HSwsJ620Bk=; b=SHTUxUJIr67x7JNHWMvPD/BEHt
        4tpHsA780WKFM4nDTuWaUK922meYDCvoZSoojwsme4X7sI7rOEtw3zuHKiXe+BK7XUbcG8SuCD4BE
        Fo5Ik6YJ/w8xpvFSUw/A5cRoIw2gbrf26rleZssQwA5S1/MosetWYQ9wMBOmBO1uBg84=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g4p2M-0000ZX-Sh; Tue, 25 Sep 2018 15:14:06 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 264FE7A510B; Tue, 25 Sep 2018 11:14:06 -0400 (EDT)
Date:   Tue, 25 Sep 2018 11:14:06 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christoph Conrads <contact@christoph-conrads.name>
Cc:     Pavel Machek <pavel@ucw.cz>, Edward Cree <ec429@cantab.net>,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <20180925151406.GB2933@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christoph Conrads <contact@christoph-conrads.name>,
        Pavel Machek <pavel@ucw.cz>, Edward Cree <ec429@cantab.net>,
        Olof Johansson <olof@lixom.net>, Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net>
 <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net>
 <20180925112832.GA10951@amd>
 <20180925143645.af1457944142ecfec7199d80@christoph-conrads.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925143645.af1457944142ecfec7199d80@christoph-conrads.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 02:36:45PM +0200, Christoph Conrads wrote:
> The CoC is a political document:
> https://web.archive.org/web/20180924234027/https://twitter.com/coralineada/status/1041465346656530432
     ...
> Here is the author's post-meritocracy manifesto:
> https://postmeritocracy.org/

There have been those who have characterized the GPL as being more
than just a license, but also a political statement.  And yet, many
projects, include Linus, use the GPL without necessarily subscribing
to all of Richard Stallman's positions, political or otherwise.

As an example: while some Linux users and developers believe with
Stallman that the name Linux should not be used, but LiGNUx and
GNU/Linux instead, others think Linux/BSD/GNU/X/Perl/Python would be
more accurate, and still others thought Stallman's naming proposal was
just plain silly.  Most distributions, including Red Hat, SuSE, Arch,
Gentoo, and Ubuntu don't use GNU/Linux, with Debian being an
exception.

The Linux community is perfectly capable of forming its own political
beliefs, interpretations, and usage of the GPLv2 (including
EXPORT_SYMBOL_GPL), without Richard Stallman dictating his positions
and beliefs to us.  We don't use the GPLv3 for the Kernel, despite
Stallman's clearly stated preference that we do so.

The use of GPLv2 does not magically brainwash all of users of that
document to blindly follow its author.  The same is true of the CoC.

						- Ted
