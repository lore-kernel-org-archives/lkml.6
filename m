Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756182AbeBOWPJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 17:15:09 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36660 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbeBOWPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 17:15:08 -0500
X-Google-Smtp-Source: AH8x2276W9Sfe4JIJifA8vsMpqa3ZIpPB+PB4uoa3s3kmnuYcxJWN73X79RhiEUnTy49OfPDrJ7udjV2XHez7kjXiUo=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <cover.1518411444.git.rgb@redhat.com>
References: <cover.1518411444.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Feb 2018 17:15:05 -0500
Message-ID: <CAHC9VhRFKTPhQRjL5QhPiQPA7WfV+TsVLgoVptnhLggkfvu0Cg@mail.gmail.com>
Subject: Re: [PATCH ghak8 ALT4 V4 0/3] audit: show more information for
 entries with anonymous parents
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 12:02 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> More than one filesystem was causing hundreds to thousands of null PATH
> records to be associated with the *init_module SYSCALL records on a few
> modules with corresponding audit syscall rules.
>
> This patchset adds extra information to those PATH records to provide
> insight into what is generating them, including a partial pathname,
> fstype field, and two new filetypes that indicate the pathname isn't
> anchored at the root of the task's root filesystem.
>
> Richard Guy Briggs (3):
>   audit: show partial pathname for entries with anonymous parents
>   audit: append new fstype field for anonymous PATH records
>   audit: add new filetypes CREATE_ANON and PARENT_ANON

The more I look at this, the more I prefer your original approach that
prefixed the relative pathname with the fstype.  Yes, I do realize
that you sort of work around that by including the fstype as a new
field in the PATH records, but we're still stuck with those odd
relative/un-rooted name fields.

Further, I don't recall ever hearing a good reason why the original
approach wasn't acceptable to Steve's userspace.  I know he did make
some very last minute hand-wavy comments, but none of those made any
sense to me; I don't understand why Steve's audit record parser is
even looking in the pathname string.

I'm going to park these patches in limbo for the time being.

-- 
paul moore
www.paul-moore.com
