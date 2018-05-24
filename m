Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034167AbeEXRWk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:22:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53690 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031084AbeEXRWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:22:36 -0400
X-Google-Smtp-Source: AB8JxZoQ8ehFz1IfAanymEhTdFQb8BEkIKIwjm2wriUOfct+ZR/ErvfD6j3xHCMNAh/rablndXSzCw==
Date: Thu, 24 May 2018 12:22:32 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>, linux-kernel@vger.kernel.org
Subject: Re: [REVIEW][PATCH 2/6] vfs: Allow userns root to call mknod on
 owned filesystems.
Message-ID: <20180524172232.GS3401@ubuntu-xps13>
References: <87o9h6554f.fsf@xmission.com>
 <20180523232538.4880-2-ebiederm@xmission.com>
 <20180524135517.GQ3401@ubuntu-xps13>
 <87y3g92dta.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3g92dta.fsf@xmission.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 11:55:45AM -0500, Eric W. Biederman wrote:
> Seth Forshee <seth.forshee@canonical.com> writes:
> 
> > On Wed, May 23, 2018 at 06:25:34PM -0500, Eric W. Biederman wrote:
> >> These filesystems already always set SB_I_NODEV so mknod will not be
> >> useful for gaining control of any devices no matter their permissions.
> >> This will allow overlayfs and applications to fakeroot to use device
> >> nodes to represent things on disk.
> >> 
> >> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >
> > For a normal filesystem this does seem safe enough.
> >
> > However, I'd also like to see us allow unprivileged mounting for
> > overlayfs, and there we need to worry about whether this would allow a
> > mknod in an underlying filesystem which should not be allowed. That
> > mknod will be subject to this same check in the underlying filesystem
> > using the credentials of the user that mounted the overaly fs, which
> > should be sufficient to ensure that the mknod is permitted.
> 
> Sufficient to ensure the mknod is not permitted on the underlying
> filesystem.  I believe you mean.

Right, or in other words with the relaxed capability check a user still
could not use an overlayfs mount in a user namespace to mknod in a
filesystem when that user couldn't otherwise mknod in that filesystem.
Sorry if I wasn't clear.

> 
> > Thus this looks okay to me.
> >
> > Acked-by: Seth Forshee <seth.forshee@canonical.com>
> 
> Eric
> 
