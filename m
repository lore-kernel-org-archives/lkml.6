Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3082590-1524140621-2-1087017740954948846
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524140620; b=E8Y4B7JCmvyksA/R35WxVG10XvbplPGdzd/fegCBmr9A0aRNdr
    m/cOJ1QaXMaPAk7Jucw8ncp0ZudJJw/X5xG0WOsixJAASA7uuU5rtEj2tC3MuB0K
    9aKCgItp/6VZ9xQuAaEaPEyJLw3VLIxLzOxRkWyi8+VmrYosKoNa4tLkvGPorylP
    pMmpH65mnahqHZgpbz9Y1cGN9PgiYejXNDB3g9/SlwiuwwpTfqNOd0qSVWUQTf1I
    3U9ej3OazIlOxSknK+a7Xlkw6Cx2TPnoMHtGEC6o34UCnZXXzsAvctsn117sjyQa
    pFy4xuWf3X8yIEs8UkHFfRZvly5TsZmQOrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524140620; bh=uC68PTSY+Ii4usWPbIdFBYEVh7ncCW
    +sEg37hNW9RCA=; b=fsii57CyIUl0jkUb54qObOVnTKCsx5jSlf9JOaN1UJkf5j
    CfDX8x2FvffrXGmIC8tUW8rdrZJsQFv1pGCtXhgyA2QFo9rBpZtATCeEKbwna85S
    XH6pMmw0a1nG8U2VmgwYOJTG4CBfAPY6PIVfgBId67TOUbZFadNsoOt9PR2VD3zb
    YOPjAgLoBUzR/eSI5GGtyGQF88+kdnb6eARKNGkSXlzF/0Wxq2YFnOHeEeZsOD2J
    ftyBWznft91AQWpq35KaltCcYJdLSfEtib8tmktpkVPNlvvVpWMqerM6x1iOTJTS
    MD6FHffSuqe2ND6qglbEDCVPg9Hl3q9b2TUhPFSw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE3w2p+q4xA1olSkeOljiHg1NVLTIE4zfwXnpHOpFK256L9bNUrNsg74s9L1eBgUrojZsaItEQskDUQoEUEhTYPYYIejOVJU6GPFsnPlBk2ibLlTtNOY
    AmNU0mvxL0EhzOn3xGRsuNMSJXGbmFfokcAZ496DPz5wk5sOr9NIpqWOL8E/xsTW8VPvr2zQcdop2ZlMLv5pvW/ncGkkM/UXtWDAfui7hx40d7k9pgFP68cC
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=_bkCVQ9zTIcGSsgJhOQA:9 a=CjuIK1q_8ugA:10 a=jDz1Lg8WPqQA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbeDSMXi (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 08:23:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752546AbeDSMXg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 19 Apr 2018 08:23:36 -0400
Date: Thu, 19 Apr 2018 08:17:38 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Subject: Re: [RFC PATCH ghak32 V2 04/13] audit: add containerid filtering
Message-ID: <20180419121738.ekiy27bpyel6o3zu@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com>
 <b933f93762435990e9b1e6d5aebf15f186ac8951.1521179281.git.rgb@redhat.com>
 <CAHC9VhRVGTCVJxG3Etcs-aOpr71A7xGsn5VPhskUG35rmQ7WUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRVGTCVJxG3Etcs-aOpr71A7xGsn5VPhskUG35rmQ7WUw@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-18 20:24, Paul Moore wrote:
> On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > Implement container ID filtering using the AUDIT_CONTAINERID field name
> > to send an 8-character string representing a u64 since the value field
> > is only u32.
> >
> > Sending it as two u32 was considered, but gathering and comparing two
> > fields was more complex.
> 
> My only worry here is that you aren't really sending a string in the
> ASCII sense, you are sending an 8 byte buffer (that better be NUL
> terminated) that happens to be an unsigned 64-bit integer.  To be
> clear, I'm okay with that (it's protected by AUDIT_CONTAINERID), and
> the code is okay with that, I just want us to pause for a minute and
> make sure that is an okay thing to do long term.

I already went through that process and warned of it 7 weeks ago.  As
already noted, That was preferable to two seperate u32 fields that
depend on each other making comparisons more complicated.  Using two
seperate fields to configure the rule could be gated for validity, then
the result stored in a special rule field, but I wasn't keen about that
approach.

> > The feature indicator is AUDIT_FEATURE_BITMAP_CONTAINERID_FILTER.
> >
> > This requires support from userspace to be useful.
> > See: https://github.com/linux-audit/audit-userspace/issues/40
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  include/linux/audit.h      |  1 +
> >  include/uapi/linux/audit.h |  5 ++++-
> >  kernel/audit.h             |  1 +
> >  kernel/auditfilter.c       | 47 ++++++++++++++++++++++++++++++++++++++++++++++
> >  kernel/auditsc.c           |  3 +++
> >  5 files changed, 56 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index 3acbe9d..f10ca1b 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -76,6 +76,7 @@ struct audit_field {
> >         u32                             type;
> >         union {
> >                 u32                     val;
> > +               u64                     val64;
> >                 kuid_t                  uid;
> >                 kgid_t                  gid;
> >                 struct {
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index e83ccbd..8443a8f 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -262,6 +262,7 @@
> >  #define AUDIT_LOGINUID_SET     24
> >  #define AUDIT_SESSIONID        25      /* Session ID */
> >  #define AUDIT_FSTYPE   26      /* FileSystem Type */
> > +#define AUDIT_CONTAINERID      27      /* Container ID */
> >
> >                                 /* These are ONLY useful when checking
> >                                  * at syscall exit time (AUDIT_AT_EXIT). */
> > @@ -342,6 +343,7 @@ enum {
> >  #define AUDIT_FEATURE_BITMAP_SESSIONID_FILTER  0x00000010
> >  #define AUDIT_FEATURE_BITMAP_LOST_RESET                0x00000020
> >  #define AUDIT_FEATURE_BITMAP_FILTER_FS         0x00000040
> > +#define AUDIT_FEATURE_BITMAP_CONTAINERID_FILTER        0x00000080
> >
> >  #define AUDIT_FEATURE_BITMAP_ALL (AUDIT_FEATURE_BITMAP_BACKLOG_LIMIT | \
> >                                   AUDIT_FEATURE_BITMAP_BACKLOG_WAIT_TIME | \
> > @@ -349,7 +351,8 @@ enum {
> >                                   AUDIT_FEATURE_BITMAP_EXCLUDE_EXTEND | \
> >                                   AUDIT_FEATURE_BITMAP_SESSIONID_FILTER | \
> >                                   AUDIT_FEATURE_BITMAP_LOST_RESET | \
> > -                                 AUDIT_FEATURE_BITMAP_FILTER_FS)
> > +                                 AUDIT_FEATURE_BITMAP_FILTER_FS | \
> > +                                 AUDIT_FEATURE_BITMAP_CONTAINERID_FILTER)
> >
> >  /* deprecated: AUDIT_VERSION_* */
> >  #define AUDIT_VERSION_LATEST           AUDIT_FEATURE_BITMAP_ALL
> > diff --git a/kernel/audit.h b/kernel/audit.h
> > index 214e149..aaa651a 100644
> > --- a/kernel/audit.h
> > +++ b/kernel/audit.h
> > @@ -234,6 +234,7 @@ static inline int audit_hash_ino(u32 ino)
> >
> >  extern int audit_match_class(int class, unsigned syscall);
> >  extern int audit_comparator(const u32 left, const u32 op, const u32 right);
> > +extern int audit_comparator64(const u64 left, const u32 op, const u64 right);
> >  extern int audit_uid_comparator(kuid_t left, u32 op, kuid_t right);
> >  extern int audit_gid_comparator(kgid_t left, u32 op, kgid_t right);
> >  extern int parent_len(const char *path);
> > diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> > index d7a807e..c4c8746 100644
> > --- a/kernel/auditfilter.c
> > +++ b/kernel/auditfilter.c
> > @@ -410,6 +410,7 @@ static int audit_field_valid(struct audit_entry *entry, struct audit_field *f)
> >         /* FALL THROUGH */
> >         case AUDIT_ARCH:
> >         case AUDIT_FSTYPE:
> > +       case AUDIT_CONTAINERID:
> >                 if (f->op != Audit_not_equal && f->op != Audit_equal)
> >                         return -EINVAL;
> >                 break;
> > @@ -584,6 +585,14 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
> >                         }
> >                         entry->rule.exe = audit_mark;
> >                         break;
> > +               case AUDIT_CONTAINERID:
> > +                       if (f->val != sizeof(u64))
> > +                               goto exit_free;
> > +                       str = audit_unpack_string(&bufp, &remain, f->val);
> > +                       if (IS_ERR(str))
> > +                               goto exit_free;
> > +                       f->val64 = ((u64 *)str)[0];
> > +                       break;
> >                 }
> >         }
> >
> > @@ -666,6 +675,11 @@ static struct audit_rule_data *audit_krule_to_data(struct audit_krule *krule)
> >                         data->buflen += data->values[i] =
> >                                 audit_pack_string(&bufp, audit_mark_path(krule->exe));
> >                         break;
> > +               case AUDIT_CONTAINERID:
> > +                       data->buflen += data->values[i] = sizeof(u64);
> > +                       for (i = 0; i < sizeof(u64); i++)
> > +                               ((char *)bufp)[i] = ((char *)&f->val64)[i];
> > +                       break;
> >                 case AUDIT_LOGINUID_SET:
> >                         if (krule->pflags & AUDIT_LOGINUID_LEGACY && !f->val) {
> >                                 data->fields[i] = AUDIT_LOGINUID;
> > @@ -752,6 +766,10 @@ static int audit_compare_rule(struct audit_krule *a, struct audit_krule *b)
> >                         if (!gid_eq(a->fields[i].gid, b->fields[i].gid))
> >                                 return 1;
> >                         break;
> > +               case AUDIT_CONTAINERID:
> > +                       if (a->fields[i].val64 != b->fields[i].val64)
> > +                               return 1;
> > +                       break;
> >                 default:
> >                         if (a->fields[i].val != b->fields[i].val)
> >                                 return 1;
> > @@ -1210,6 +1228,31 @@ int audit_comparator(u32 left, u32 op, u32 right)
> >         }
> >  }
> >
> > +int audit_comparator64(u64 left, u32 op, u64 right)
> > +{
> > +       switch (op) {
> > +       case Audit_equal:
> > +               return (left == right);
> > +       case Audit_not_equal:
> > +               return (left != right);
> > +       case Audit_lt:
> > +               return (left < right);
> > +       case Audit_le:
> > +               return (left <= right);
> > +       case Audit_gt:
> > +               return (left > right);
> > +       case Audit_ge:
> > +               return (left >= right);
> > +       case Audit_bitmask:
> > +               return (left & right);
> > +       case Audit_bittest:
> > +               return ((left & right) == right);
> > +       default:
> > +               BUG();
> > +               return 0;
> > +       }
> > +}
> > +
> >  int audit_uid_comparator(kuid_t left, u32 op, kuid_t right)
> >  {
> >         switch (op) {
> > @@ -1348,6 +1391,10 @@ int audit_filter(int msgtype, unsigned int listtype)
> >                                 result = audit_comparator(audit_loginuid_set(current),
> >                                                           f->op, f->val);
> >                                 break;
> > +                       case AUDIT_CONTAINERID:
> > +                               result = audit_comparator64(audit_get_containerid(current),
> > +                                                             f->op, f->val64);
> > +                               break;
> >                         case AUDIT_MSGTYPE:
> >                                 result = audit_comparator(msgtype, f->op, f->val);
> >                                 break;
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 65be110..2bba324 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -614,6 +614,9 @@ static int audit_filter_rules(struct task_struct *tsk,
> >                 case AUDIT_LOGINUID_SET:
> >                         result = audit_comparator(audit_loginuid_set(tsk), f->op, f->val);
> >                         break;
> > +               case AUDIT_CONTAINERID:
> > +                       result = audit_comparator64(audit_get_containerid(tsk), f->op, f->val64);
> > +                       break;
> >                 case AUDIT_SUBJ_USER:
> >                 case AUDIT_SUBJ_ROLE:
> >                 case AUDIT_SUBJ_TYPE:
> > --
> > 1.8.3.1
> >
> > --
> > Linux-audit mailing list
> > Linux-audit@redhat.com
> > https://www.redhat.com/mailman/listinfo/linux-audit
> 
> 
> 
> -- 
> paul moore
> www.paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
