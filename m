Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbeBPS31 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 13:29:27 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36839 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbeBPS3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 13:29:24 -0500
X-Google-Smtp-Source: AH8x226F1p1CraLmLK1gqA8xcS7WWlw7vO/elapSOXw0mTR/DewVxQiBPAPgw8blpR7Ta3blHMkBRjIbZ66j1ai5jDA=
MIME-Version: 1.0
X-Originating-IP: [70.88.214.193]
In-Reply-To: <20180216082330.76obts2tvqwteqle@madcap2.tricolour.ca>
References: <cover.1518411444.git.rgb@redhat.com> <CAHC9VhRFKTPhQRjL5QhPiQPA7WfV+TsVLgoVptnhLggkfvu0Cg@mail.gmail.com>
 <20180216082330.76obts2tvqwteqle@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 16 Feb 2018 13:29:22 -0500
Message-ID: <CAHC9VhTD3hXfgKWTXG2mce7ZDTsOgv=3vcZsaHj3catrrTjE1A@mail.gmail.com>
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

On Fri, Feb 16, 2018 at 3:23 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-02-15 17:15, Paul Moore wrote:
>> On Mon, Feb 12, 2018 at 12:02 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> > More than one filesystem was causing hundreds to thousands of null PATH
>> > records to be associated with the *init_module SYSCALL records on a few
>> > modules with corresponding audit syscall rules.
>> >
>> > This patchset adds extra information to those PATH records to provide
>> > insight into what is generating them, including a partial pathname,
>> > fstype field, and two new filetypes that indicate the pathname isn't
>> > anchored at the root of the task's root filesystem.
>> >
>> > Richard Guy Briggs (3):
>> >   audit: show partial pathname for entries with anonymous parents
>> >   audit: append new fstype field for anonymous PATH records
>> >   audit: add new filetypes CREATE_ANON and PARENT_ANON
>>
>> The more I look at this, the more I prefer your original approach that
>> prefixed the relative pathname with the fstype.  Yes, I do realize
>> that you sort of work around that by including the fstype as a new
>> field in the PATH records, but we're still stuck with those odd
>> relative/un-rooted name fields.
>
> They are signalled as being unrooted by the ANON filetypes.  And now
> that you mention it, should fail the ausearch-test since it isn't a "full
> path", as claimed is necessary in ghak70 (so I don't see why the
> KERN_MODULE name= record/field fails that test).

Yes.  I still prefer your original approach.

>> Further, I don't recall ever hearing a good reason why the original
>> approach wasn't acceptable to Steve's userspace.  I know he did make
>> some very last minute hand-wavy comments, but none of those made any
>> sense to me; I don't understand why Steve's audit record parser is
>> even looking in the pathname string.
>>
>> I'm going to park these patches in limbo for the time being.
>
> Can you give me an idea how long that might be?

If you need an answer right now, consider it to be "indefinitely".

-- 
paul moore
www.paul-moore.com
