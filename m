Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755479AbeE3FPH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 01:15:07 -0400
Received: from imap.thunk.org ([74.207.234.97]:43418 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755330AbeE3FPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 01:15:01 -0400
Date: Wed, 30 May 2018 01:14:58 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: prefer strlcpy to strncpy
Message-ID: <20180530051458.GB27959@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1527574913-10561-1-git-send-email-nick.desaulniers@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527574913-10561-1-git-send-email-nick.desaulniers@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 11:21:53PM -0700, Nick Desaulniers wrote:
> Fixes a stringop-truncation warning from gcc-8.
> 
> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>

I'll note that the ext4 superblock fields are *not* guaranteed to be
NULL terminated.  Code that references them must, and do, deal with
this appropriately.  See for example:

https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/tree/lib/e2p/ls.c#n436

GCC-8 may whine about it, but the whine is, in fact, not correct.
It's making assumptions about all strings being null terminated, which
is often, but not always, the case.

Cheers,

						- Ted
