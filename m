Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbeC3Bc1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 21:32:27 -0400
Received: from imap.thunk.org ([74.207.234.97]:45040 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751209AbeC3BcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 21:32:25 -0400
Date: Thu, 29 Mar 2018 21:32:21 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: valdis.kletnieks@vt.edu, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: linux-next 20180327 - "SELinux: (dev dm-3, type ext4) getxattr
 errno 34"
Message-ID: <20180330013221.GD3790@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Stephen Smalley <sds@tycho.nsa.gov>, valdis.kletnieks@vt.edu,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov
References: <24018.1522346273@turing-police.cc.vt.edu>
 <db97ea5d-0925-63bd-6840-1364a7977a50@tycho.nsa.gov>
 <026f2dc7-1c9c-93ff-569c-87a77aad0ece@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <026f2dc7-1c9c-93ff-569c-87a77aad0ece@tycho.nsa.gov>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 02:35:44PM -0400, Stephen Smalley wrote:
> > 
> > broke a longstanding assumption by SELinux that it could call getxattr with a NULL buffer and 0 size to probe whether the filesystem supports the security xattrs at mount time.
> > 
> > Options for fixing:
> > - Revert or revise that patch to not return -ERANGE if buffer is NULL (prior behavior),
> > - Change SELinux sb_finish_set_opts() to treat -ERANGE as a non-error result.
> 
> Per https://bugzilla.kernel.org/show_bug.cgi?id=199185#c4, other callers besides SELinux are also broken by this change, so a revert or revision of the ext4 commit seems necessary regardless.

Yes, the breakage is my fault; my apologies.  The new version of the
patch is already posted in bugzilla (and on linux-ext4).  I'll be
pushing out a refreshed ext4.git branch shortly.

					- Ted
