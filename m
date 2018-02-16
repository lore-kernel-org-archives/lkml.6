Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754480AbeBPI1Z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 03:27:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754456AbeBPI1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 03:27:23 -0500
Date: Fri, 16 Feb 2018 03:23:30 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Subject: Re: [PATCH ghak8 ALT4 V4 0/3] audit: show more information for
 entries with anonymous parents
Message-ID: <20180216082330.76obts2tvqwteqle@madcap2.tricolour.ca>
References: <cover.1518411444.git.rgb@redhat.com>
 <CAHC9VhRFKTPhQRjL5QhPiQPA7WfV+TsVLgoVptnhLggkfvu0Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRFKTPhQRjL5QhPiQPA7WfV+TsVLgoVptnhLggkfvu0Cg@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-15 17:15, Paul Moore wrote:
> On Mon, Feb 12, 2018 at 12:02 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > More than one filesystem was causing hundreds to thousands of null PATH
> > records to be associated with the *init_module SYSCALL records on a few
> > modules with corresponding audit syscall rules.
> >
> > This patchset adds extra information to those PATH records to provide
> > insight into what is generating them, including a partial pathname,
> > fstype field, and two new filetypes that indicate the pathname isn't
> > anchored at the root of the task's root filesystem.
> >
> > Richard Guy Briggs (3):
> >   audit: show partial pathname for entries with anonymous parents
> >   audit: append new fstype field for anonymous PATH records
> >   audit: add new filetypes CREATE_ANON and PARENT_ANON
> 
> The more I look at this, the more I prefer your original approach that
> prefixed the relative pathname with the fstype.  Yes, I do realize
> that you sort of work around that by including the fstype as a new
> field in the PATH records, but we're still stuck with those odd
> relative/un-rooted name fields.

They are signalled as being unrooted by the ANON filetypes.  And now
that you mention it, should fail the ausearch-test since it isn't a "full
path", as claimed is necessary in ghak70 (so I don't see why the
KERN_MODULE name= record/field fails that test).

> Further, I don't recall ever hearing a good reason why the original
> approach wasn't acceptable to Steve's userspace.  I know he did make
> some very last minute hand-wavy comments, but none of those made any
> sense to me; I don't understand why Steve's audit record parser is
> even looking in the pathname string.
> 
> I'm going to park these patches in limbo for the time being.

Can you give me an idea how long that might be?

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
