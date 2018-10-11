Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA36C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6AF2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6AF2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=isi.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeJLDLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:11:20 -0400
Received: from vapor.isi.edu ([128.9.64.64]:59252 "EHLO vapor.isi.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbeJLDLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:11:19 -0400
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Oct 2018 23:11:15 EDT
Received: from jib.isi.edu (jib.isi.edu [128.9.136.190])
        by vapor.isi.edu (8.13.8/8.13.8) with ESMTP id w9BJapGT025584;
        Thu, 11 Oct 2018 12:36:51 -0700 (PDT)
Received: by jib.isi.edu (Postfix, from userid 1000)
        id 9845483C9B; Thu, 11 Oct 2018 12:36:51 -0700 (PDT)
Date:   Thu, 11 Oct 2018 12:36:51 -0700
From:   Craig Milo Rogers <rogers@isi.edu>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     hpa@zytor.com, linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: Insanely high baud rates
Message-ID: <20181011193651.GA11500@isi.edu>
References: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com> <20181010211717.30c1f052@alans-desktop> <16D6AB22-697E-498C-A5B2-3AD90B567E86@zytor.com> <20181011133134.085624af@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011133134.085624af@alans-desktop>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ISI-4-43-8-MailScanner: Found to be clean
X-MailScanner-From: rogers@jib.isi.edu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.11, Alan Cox wrote:
> I mean - what is the baud rate of a pty  ?

	Solaris made the distinction between B0, which means pty hangup mode,
and any other baud rate:

https://docs.oracle.com/cd/E88353_01/html/E37851/pty-4d.html

	But... why not implement a pty bandwidth limitation layer?  You say, I
need to justify it?  It's for, uh... protecting the system from unrestricted
pty usage DOS attacks!  Yeah.  That's what it's for.

					Craig Milo Rogers
