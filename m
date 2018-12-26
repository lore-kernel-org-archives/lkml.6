Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E755C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C752171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeLZG7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 01:59:03 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56712 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeLZG7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 01:59:03 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gc39W-0003aZ-L3; Wed, 26 Dec 2018 06:58:50 +0000
Date:   Wed, 26 Dec 2018 06:58:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Kangjie Lu <kjlu@umn.edu>, pakki001@umn.edu,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: proc: check status of register_filesystem
Message-ID: <20181226065850.GG2217@ZenIV.linux.org.uk>
References: <20181226030642.72757-1-kjlu@umn.edu>
 <20181226061856.GA2122@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226061856.GA2122@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 09:18:56AM +0300, Alexey Dobriyan wrote:
> On Tue, Dec 25, 2018 at 09:06:40PM -0600, Kangjie Lu wrote:
> > register_filesystem() could fail. The fix issues an error message if it
> > fails.
> 
> > -	register_filesystem(&proc_fs_type);
> > +	if (register_filesystem(&proc_fs_type))
> > +		pr_err("failed to register the filesystem.\n");
> 
> No, register_filesystem() should do it.

Folks, check when would it fail.  If we have something called "proc"
already registered by the time when proc_root_init() runs... might
as well have been a panic().
