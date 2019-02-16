Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC0CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9B9222E6
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbfBPPVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 10:21:31 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47146 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfBPPVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 10:21:30 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gv1mS-0005mi-Ii; Sat, 16 Feb 2019 15:21:28 +0000
Date:   Sat, 16 Feb 2019 15:21:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        x86@kernel.org, "H . J . Lu" <hjl.tools@gmail.com>
Subject: Re: [PATCH] vfs: fix preadv64v2 and pwritev64v2 compat syscalls with
 offset == -1
Message-ID: <20190216152128.GO2217@ZenIV.linux.org.uk>
References: <20181206190534.16246-1-aurelien@aurel32.net>
 <20190112190713.GA21480@aurel32.net>
 <20190216151528.GA27079@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216151528.GA27079@aurel32.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 04:15:28PM +0100, Aurelien Jarno wrote:
> On 2019-01-12 20:07, Aurelien Jarno wrote:
> > On 2018-12-06 20:05, Aurelien Jarno wrote:
> > > The preadv2 and pwritev2 syscalls are supposed to emulate the readv and
> > > writev syscalls when offset == -1. Therefore the compat code should
> > > check for offset before calling do_compat_preadv64 and
> > > do_compat_pwritev64. This is the case for the preadv2 and pwritev2
> > > syscalls, but handling of offset == -1 is missing in their 64-bit
> > > equivalent.
> > > 
> > > This patch fixes that, calling do_compat_readv and do_compat_writev when
> > > offset == -1. This fixes the following glibc tests on x32:
> > >  - misc/tst-preadvwritev2
> > >  - misc/tst-preadvwritev64v2
> > > 
> > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > Cc: H.J. Lu <hjl.tools@gmail.com>
> > > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > > ---
> > >  fs/read_write.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > 
> > Any news about this patch?
> > 
> 
> Ping.

Applied
