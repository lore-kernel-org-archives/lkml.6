Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91824C282CD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608BD20820
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfA3E6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 23:58:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:55312 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbfA3E6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 23:58:13 -0500
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 516BF36FC;
        Wed, 30 Jan 2019 04:58:12 +0000 (UTC)
Date:   Tue, 29 Jan 2019 20:58:11 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ian Kent <raven@themaw.net>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pan Bian <bianpan2016@163.com>
Subject: Re: [PATCH 3/3] autofs: add ignore mount option
Message-Id: <20190129205811.2bd83d93dbc05325a8c55954@linux-foundation.org>
In-Reply-To: <553f4a0daf09407371193d7d4782a759561a626a.camel@themaw.net>
References: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
        <154725123970.11260.6113771566924907275.stgit@pluto-themaw-net>
        <20190129171622.5b75f794d2b1e4d1055331eb@linux-foundation.org>
        <553f4a0daf09407371193d7d4782a759561a626a.camel@themaw.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 10:07:15 +0800 Ian Kent <raven@themaw.net> wrote:

> On Tue, 2019-01-29 at 17:16 -0800, Andrew Morton wrote:
> > On Sat, 12 Jan 2019 08:00:40 +0800 Ian Kent <raven@themaw.net> wrote:
> > 
> > > Add an autofs file system mount option that can be used to provide
> > > a generic indicator to applications that the mount entry should be
> > > ignored when displaying mount information.
> > 
> > What is the reason for adding this feature?
> 
> In other OSes that provide autofs and that provide a mount list
> to user space based on the kernel mount list a no-op mount option
> ("ignore" is the one use on the most common OS) is allowed so that
> autofs file system users can optionally use it.
> 
> The idea is that it be used by user space programs to exclude
> autofs mounts from consideration when reading the mounts list.
> 
> Prior to the change to link /etc/mtab to /proc/self/mounts all
> I needed to do to achieve this was to use mount(2) and not update
> the mtab but now that no longer works.
> 
> I know the symlinking happened a long time ago and I considered
> doing this then but, at the time I couldn't remember the commonly
> used option name and thought persuading the various utility
> maintainers would be too hard.
> 
> But now I have a RHEL request to do this for compatibility for a
> widely used product so I want to go ahead with it and try and
> enlist the help of some utility package maintainers.
> 
> Clearly, without the option nothing can be done so it's at least
> a start.

OK.  I guess I can just paste the above into the changelog.

Also, Documentation/filesystems/autofs*.txt are owed an update?


