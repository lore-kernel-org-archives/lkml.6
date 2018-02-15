Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164471AbeBOXQA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 18:16:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163785AbeBOXP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 18:15:58 -0500
Date: Thu, 15 Feb 2018 18:12:06 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Subject: Re: [RFC PATCH 2/3] fixup! audit: remove arch_f pointer from struct
 audit_krule
Message-ID: <20180215231206.4qlmjpninqedvan3@madcap2.tricolour.ca>
References: <cover.1518435853.git.rgb@redhat.com>
 <5f742621971f0267cf5854a6a5054746ef3ab95f.1518435853.git.rgb@redhat.com>
 <CAHC9VhRtgzBB0HCNjE--CiYfUSfBq5C2U767BbN=ecRc_dqSZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRtgzBB0HCNjE--CiYfUSfBq5C2U767BbN=ecRc_dqSZA@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-15 15:43, Paul Moore wrote:
> On Mon, Feb 12, 2018 at 7:29 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  kernel/auditfilter.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> I realize this is an RFC patchset, but considering recent patchsets I
> feel some clarification might be helpful to prevent future delays ...
> when submitting patchsets for merging please do not submit "fixup!"
> patches which fix problems in patches that are submitted earlier in
> the patchset, simply merge/squash the "fixup!" patches before
> submitting.

Yeah, the only reason this is a "fixup!" patch is to clearly show what
remedial step was (surprisingly) needed to fix the bug.

Same with the following "debug!" annotation.  Clearly not intended for
upstream to Linus.

> > diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> > index 3343d1c..48dcb59 100644
> > --- a/kernel/auditfilter.c
> > +++ b/kernel/auditfilter.c
> > @@ -221,11 +221,13 @@ static inline int audit_match_class_bits(int class, u32 *mask)
> >  static int audit_match_signal(struct audit_entry *entry)
> >  {
> >         int i;
> > +       u32 archval;
> >         struct audit_field *arch;
> >
> >         for (i = 0; i < entry->rule.field_count; i++)
> >                 if (entry->rule.fields[i].type == AUDIT_ARCH) {
> >                         arch = &entry->rule.fields[i];
> > +                       archval = arch->val;
> >                         break;
> >                 }
> >
> > @@ -238,7 +240,7 @@ static int audit_match_signal(struct audit_entry *entry)
> >                                                entry->rule.mask));
> >         }
> >
> > -       switch(audit_classify_arch(arch->val)) {
> > +       switch(audit_classify_arch(archval)) {
> >         case 0: /* native */
> >                 return (audit_match_class_bits(AUDIT_CLASS_SIGNAL,
> >                                                entry->rule.mask));
> > --
> > 1.8.3.1
> 
> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
