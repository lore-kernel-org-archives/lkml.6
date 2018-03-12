Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932639AbeCLP4m (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:56:42 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43743 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932494AbeCLP4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:56:41 -0400
X-Google-Smtp-Source: AG47ELvyJY9F0xEE4JCTX/eOlf8UAl6q/CudFIp4626/hSuA/yDSOKWpzltiI+gDF/iRMEALEcUvZ5YZC5dV513jpAg=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180312153049.udobftmchbpb7lou@madcap2.tricolour.ca>
References: <cover.1520835596.git.rgb@redhat.com> <9ed76ccb239078ad5a2808d23c7b7f1738b0b2b8.1520835596.git.rgb@redhat.com>
 <CAHC9VhRDnd55em1YUkswOX4XmDP6xH5x005hcZnCZSRXz66exQ@mail.gmail.com> <20180312153049.udobftmchbpb7lou@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Mar 2018 11:56:38 -0400
Message-ID: <CAHC9VhSG__5ixkPQsmo+vT0uvKjSBnGX5v-Y5B349vh1ZYJv3Q@mail.gmail.com>
Subject: Re: [PATCH ghak21 V2 2/4] audit: link denied should not directly
 generate PATH record
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 11:30 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-03-12 11:05, Paul Moore wrote:
>> On Mon, Mar 12, 2018 at 2:31 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> > Audit link denied events generate duplicate PATH records which disagree
>> > in different ways from symlink and hardlink denials.
>> > audit_log_link_denied() should not directly generate PATH records.
>> > While we're at it, remove the now useless struct path argument.
>> >
>> > See: https://github.com/linux-audit/audit-kernel/issues/21
>> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>> > ---
>> >  fs/namei.c            |  2 +-
>> >  include/linux/audit.h |  6 ++----
>> >  kernel/audit.c        | 17 ++---------------
>> >  3 files changed, 5 insertions(+), 20 deletions(-)
>>
>> I have no objection to the v2 change of removing the link parameter,
>> but this patch can not be merged as-is because the v1 patch has
>> already been merged into audit/next (as stated on the mailing list).
>
> Yes, I self-NACKed that patch.
>
>         https://www.redhat.com/archives/linux-audit/2018-March/msg00070.html
>
> Is it not possible to drop it, or would you have to do a revert to avoid
> a rebase?

Yes, it is possible to drop a patch from the audit/next patch stack,
but dropping patches is considered *very* bad form and not something I
want to do without a Very Good Reason.  While the v2 patch is the
"right" patch, the v1 patch is not dangerous, so I would rather you
just build on top of what is currently in audit/next.

-- 
paul moore
www.paul-moore.com
