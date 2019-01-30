Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34773C282CD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8F221473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbfA3ESc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 23:18:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39944 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbfA3ESc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 23:18:32 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gohKW-00055H-4h; Wed, 30 Jan 2019 04:18:28 +0000
Date:   Wed, 30 Jan 2019 04:18:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] autofs: add ignore mount option
Message-ID: <20190130041827.GI2217@ZenIV.linux.org.uk>
References: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
 <154725123970.11260.6113771566924907275.stgit@pluto-themaw-net>
 <20190129171622.5b75f794d2b1e4d1055331eb@linux-foundation.org>
 <553f4a0daf09407371193d7d4782a759561a626a.camel@themaw.net>
 <804b86df6fd678147da816be038b11c87333b23f.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <804b86df6fd678147da816be038b11c87333b23f.camel@themaw.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 10:44:15AM +0800, Ian Kent wrote:

> Al,
> 
> On a different note the above request also raised another
> question about statvfs(3) automount behaviour.
> 
> In glibc statvfs(3) uses statfs(2) and translates the return
> to a statvfs structure.
> 
> I wasn't aware but apparently statvfs(3) (and presumably statfs(2))
> doesn't trigger an automount on Solaris whereas we do. I think
> statfs() is probably the only exception to the convention that
> stat family system calls don't trigger an automount.
> 
> So far I've said that this is a long standing behaviour in the
> Linux kernel and changing it could lead to unpleasant surprises
> for those that have come to expect this behaviour so such a change
> would not be well received.
> 
> But I do need to ask your opinion, so what are your thoughts about
> changing this?

Probably should've done it that way, but I'm afraid it's much too
late by now...
