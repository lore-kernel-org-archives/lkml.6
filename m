Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753288AbeBUSgA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 13:36:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752146AbeBUSf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 13:35:59 -0500
Date: Wed, 21 Feb 2018 19:36:56 +0100
From: Eugene Syromiatnikov <esyr@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Linux 4.15-rc2
Message-ID: <20180221183656.GT4439@asgard.redhat.com>
References: <CA+55aFxPBszFBt91KRNBrsQdJ10b+6fh9ySNzSKSX7JOq4WRPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxPBszFBt91KRNBrsQdJ10b+6fh9ySNzSKSX7JOq4WRPw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2017 at 11:22:56AM -0500, Linus Torvalds wrote:
> 
> Linus Torvalds (6):
>       Rename superblock flags (MS_xyz -> SB_xyz)

This commit, while claims that it changes internal flags, also touches
an UAPI header (include/uapi/linux/bfs_fs.h), specifically, the macro
BFS_UNCLEAN.  I expect that either this macro should be in a private
header, or (if this check is expected to be available to the userspace)
at least SB_RDONLY should be also defined there.
