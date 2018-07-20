Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6487CECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B8920661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="Hf41RgK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B8920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbeGTPlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:41:24 -0400
Received: from imap.thunk.org ([74.207.234.97]:38568 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731792AbeGTPlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bplxIP+SLnBc1iadpefxLFf9wKLgwuSyI+4TCN0EdF4=; b=Hf41RgK1IdCGLVlVLx50Ue4E1K
        8UCgfZiI2OGBtiBnh2QiKoMRI0qvJ74vmIShkheXHtoIQT6oXcMzrqIUoVSOX9rAQl9G8T8koLoY2
        E8G8j7IsFfrK8hcl7KMqtPiGfMKELuqLODzez31AM/51LDtAG4IwfbpXo5/EdN355ZI8=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fgWlt-0004FW-36; Fri, 20 Jul 2018 14:52:41 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E79D57A6417; Fri, 20 Jul 2018 10:52:35 -0400 (EDT)
Date:   Fri, 20 Jul 2018 10:52:35 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Markus Heiser <markus.heiser@darmarit.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Sphinx version dependencies?
Message-ID: <20180720145235.GA27862@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Markus Heiser <markus.heiser@darmarit.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180719181556.GA21435@thunk.org>
 <20180719190400.GB4800@magnolia>
 <44d73cd9926f58976a1269ff3cd3afb845ec84fa.camel@darmarit.de>
 <20180720131206.GM30706@thunk.org>
 <d064f468ab9fc60a02242331e0dddc185d6556ba.camel@darmarit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d064f468ab9fc60a02242331e0dddc185d6556ba.camel@darmarit.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 03:45:37PM +0200, Markus Heiser wrote:
> Am Freitag, den 20.07.2018, 09:12 -0400 schrieb Theodore Y. Ts'o:
> > I'm not entirely sure what's the best approach.  Right now I just want
> > to understand --- do I have to make ext4.rst work against one, or many
> > versions of Sphinx?  And which version(s) of Sphinx do I need to
> > concern myself with?  If that turns out to be an onerous burden, I'm
> > sure I won't be the only person complaining.  :-)
> 
> In that case ...
> 
> > But when I did that, Sphinx had heartburn over the ext4.rst file.
> > 
> >     ./include/linux/spi/spi.h:373: ERROR: Unexpected indentation.
> >     /usr/projects/linux/ext4/Documentation/filesystems/ext4/ext4.rst:139: ERROR: Malformed table.
> >     Column span alignment problem in table line 5.
> 
> ... its clear; the table was malformed. A markup error which is not detected
> by older versions of docutils (very special case).

... except that newer verions are A-OK with it.  Apparently 1.3.x was
OK with it, and 1.6.x and 1.7.x were ok with it.  ***ONLY*** Sphinx
1.4.9 blew up on the "malformed table".

So in this case, Darrick has come up with a patch that is makes it OK
with 1.4.9 without breaking on 1.7.5 --- and obviously, doing
something that makes it broadly portable is the right thing.

I'm asking a larger question, which is moving forward, which is more
important?  Make it work with Sphinx 1.4.9?  Or making it Sphinx work
with Sphinx 1.7.5?

And should we change Documentation/sphinx/requirements.txt to require
something newer, such as Sphinx 1.7.5?  And should we require that
Ubuntu 18.04 which is using Sphinx 1.6.8 use a virtualenv and use
download Sphinx 1.6.8?

My understanding that the Sphinx developers make no guarantees that if
we follow some external, version-indepedent spec, that it will work on
Sphinx version N, as well as Sphinx version N+1.  (In the ideal world,
if there was such an independent spec for .rst format files, and a
compliant .rst file doesn't work for Sphinx version N, it's a bug, and
we should expect somebody --- perhaps the Distro's --- to backport the
fix from Sphinx version N+1 to Sphinx version N.)  E.g., is there an
equivalent for ANSI C 1999 standard for .rst files?

		       	      	   	    - Ted
