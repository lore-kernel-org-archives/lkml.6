Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F1DC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBB4222EB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfAEUp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:45:58 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35704 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfAEUp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:45:58 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gfspN-0003qm-69; Sat, 05 Jan 2019 20:45:53 +0000
Date:   Sat, 5 Jan 2019 20:45:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [git pull] vfs.git mount.part1
Message-ID: <20190105204552.GR2217@ZenIV.linux.org.uk>
References: <20190104192648.GO2217@ZenIV.linux.org.uk>
 <87ef9qdhpy.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ef9qdhpy.fsf@xmission.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2019 at 01:31:21PM -0600, Eric W. Biederman wrote:

> Not having had a chance to review this code I can't really comment on
> the quality of this code.  What I do know from a glance is that
> you have not removed FS_BINARY_MOUNTDATA.  Which is the root cause
> of some of the crazy security mount option processing, and is an if
> not greater mess than what the security options have been doing with
> mount options.
> 
> The FS_BINARY_MOUNTDATA flag is only relevant for coda and for nfs
> backwards compatiblity.  The FS_BINARY_MOUNTDATA flag is only set on
> btrfs to allow calling mount_subtree.

... and thus it can't be killed without having dragged the NFS pile
into the entire thing.

> I have a set of patches that is finally reasonablly stable and cleans up
> all of the mess in the current internal mount apis that should allow
> implementing the new mount api to be much less error prone.

Quick question: how do you deal with the differences in quoting for selinux
options and for everything else?

I've no problem with working with you, now that you've resurfaced.
Fair warning: no promises of accepting your solutions.  Along with
a promise to reject anything that breaks existing setups, which your
earlier proposals did.  With NFS among the victims, IIRC.
