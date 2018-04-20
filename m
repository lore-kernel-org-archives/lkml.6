Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeDTTEe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 15:04:34 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:47058 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbeDTTEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 15:04:32 -0400
X-Google-Smtp-Source: AB8JxZoG2hYArep+nvhaZCLeLZ2qb6i7pRaAfTGR8h0PWdb7Zx0nLkd7taNjTsI2VYjeXvGfnmFyS1OW32Nqsu1fslc=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180420174812.3sczwow3wg6alrcu@madcap2.tricolour.ca>
References: <08bd08ee9bc70f6e98b9e298ba6a2c0f4dcadb4b.1523372093.git.rgb@redhat.com>
 <CAHC9VhSxjEKNcdE2Mm-Vwef6RvTG2ykGFFmeAtVypAaPRvddmg@mail.gmail.com>
 <20180420134651.3badjswsokqs7hex@madcap2.tricolour.ca> <CAHC9VhQzsE1x33uvGkoioXcLvcmdOUUbajnyZ1-qw4xLjLj98Q@mail.gmail.com>
 <20180420174812.3sczwow3wg6alrcu@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Apr 2018 15:04:30 -0400
Message-ID: <CAHC9VhThAEVaersEApRys+DCYf3kRF-C0xN2wzd946Z_Fis-fA@mail.gmail.com>
Subject: Re: [PATCH ghak80 V1] audit: add syscall information to
 FEATURE_CHANGE records
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 1:48 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-04-20 11:58, Paul Moore wrote:
>> On Fri, Apr 20, 2018 at 9:46 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> > On 2018-04-17 18:06, Paul Moore wrote:
>> >> On Wed, Apr 11, 2018 at 8:46 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> >> > Tie syscall information to FEATURE_CHANGE calls since it is a result of
>> >> > user action.
>> >> >
>> >> > See: https://github.com/linux-audit/audit-kernel/issues/80
>> >> >
>> >> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>> >> > ---
>> >> >  kernel/audit.c | 5 ++---
>> >> >  1 file changed, 2 insertions(+), 3 deletions(-)
>> >> >
>> >> > diff --git a/kernel/audit.c b/kernel/audit.c
>> >> > index 8da24ef..23f125b 100644
>> >> > --- a/kernel/audit.c
>> >> > +++ b/kernel/audit.c
>> >> > @@ -1103,10 +1103,9 @@ static void audit_log_feature_change(int which, u32 old_feature, u32 new_feature
>> >> >  {
>> >> >         struct audit_buffer *ab;
>> >> >
>> >> > -       if (audit_enabled == AUDIT_OFF)
>> >> > +       if (!audit_enabled)
>> >>
>> >> Sooo, this is an unrelated style change, why?  Looking at the rest of
>> >> kernel/audit.c we seem to use a mix of "(!x)" and "(x == 0/CONST)" so
>> >> why are you adding noise to this patch?
>> >
>> > Ok, survey sez 25 instances of audit_enabled used as a boolean vs 7
>> > instances where it could be used as a boolean where the expression is
>> > made harder to read (in my opinion).  I thought it was worth changing to
>> > read the same way most of the other instances I've been reviewing are
>> > written.  There are only two where the non-boolean distiction with
>> > AUDIT_LOCKED is required.
>>
>> Thanks for the explanation.
>>
>> While I still believe this patch, and connecting records in general,
>> is the Right Thing To Do, I'm expecting there to be some hate mail on
>> this issue and I would like to keep the patch as small and as
>> straight-to-the-point as possible just so there is little confusion
>> about what is changing.
>>
>> Please respin this without the style change and I'll merge it as soon
>> as I see it.  Alternatively, give me the "ok" and I'll merge the patch
>> now and just drop the style change; after all we're talking about one
>> line in a five line patch ;)
>
> Go ahead and drop that style change line to simplify this patch and I'll
> submit another patch to clean them all up at the same time (probably the
> next time one of those changes).

Sounds good.

Merged.  Thanks Richard.

-- 
paul moore
www.paul-moore.com
