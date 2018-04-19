Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1625563-1524097491-2-11568661591247418067
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524097490; b=m55pMubaNldQ849A8oU70hyeyyTCmIxWVCGT8fpXkuydRcrnns
    aubWF4G441o81l8HCQt3n0g8khWzHgjx4COZa1V30DHg82fhwEEO38dv9geOEbpr
    GgRaQ9gjAuWR5hAPkfxHqrb5QDGNeQ/wISXerPQo+m4jzxUFS7qmrbXYFLJF0Fy0
    c/+y5gDm23JsiSjq8DCvrFfkdNZy1BxrHax8vDEwfbcrwUhhaeNQDz/EmNbt38KS
    HwhIWFGkYl9gcgJmx/bU7iCOQhOUjvtEJIDFVx0J0bEEqVyRbnzd9lkiCzZ/zwaE
    9tIi8bXgIrmbEQ+OHRdNo4cvOmtuv76XHOhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524097490; bh=RZ9BCbq3g1N+N3JRSBJVu9m6LggAomf+E0e3xAMwWv
    c=; b=VfEgBvb3Z1aCvLzTcON1zH1RXO9XQs1mfBw5axvd8dzAE+107j1FfC27PN
    G5aZpLUmqxCwleeAxyt+Hyir87P4utuYEnprnoVvNssVozeQJvZHNBPXOpTVDmf+
    dqA6pMwH21KqSOSmNyrNw9J9uOACZIWFaJCEvzvOfhhEHOI/N/nVtjKaQEZdQZBl
    taSv/x8FJHxBGkCVbeqrppIDOLQvO8NgsIoyA+t95FA6gePqG8VyPg5MwMs8nzq4
    xTQrGzxHMhMJe2CCsFIVPVNvrV7+T3F6l1aWG3rO+ltVbzpeHiAluM1tOaG/xH7U
    rIvd0N2/im6daBblekaiwMZl+gDg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=XrAujRAh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WA70Ky+Z;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=XrAujRAh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WA70Ky+Z;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJLHvVKPId7UexV3AoBkPyvAEJGBlzMn6GClZk1BHuVc6jaw4D9GAQv0NoJvJv5i/Q9yL6o9P0OI9mYmdX+JRp+nCpvMCdfqJmfDJmef8K8yHIxwACWJ
    8+kBQlaDvseb1ZzKfJtxQPELHVN0YIqKw0DL44rBqoLc92fgArYG1VnaRj6x0kL53BYmcVlnOoobBZBExi77VAjwu13azTkYQubKiO+QW1+xGbAs64wPPLXk
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=xVhDTqbCAAAA:8
    a=VwQbUJbxAAAA:8 a=tWMk3qCt3kxZRc3Z7rsA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeDSAYc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 20:24:32 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41933 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752532AbeDSAYa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Apr 2018 20:24:30 -0400
X-Google-Smtp-Source: AIpwx48nd708ztxsIjeaKPI+TvgJb8fErkAE6dC+wvRLkUi8E4/3mkDy79JyFoKpmTJy5naSiFxWZrHx6pYcS/LJwkY=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <b933f93762435990e9b1e6d5aebf15f186ac8951.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com> <b933f93762435990e9b1e6d5aebf15f186ac8951.1521179281.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Apr 2018 20:24:27 -0400
Message-ID: <CAHC9VhRVGTCVJxG3Etcs-aOpr71A7xGsn5VPhskUG35rmQ7WUw@mail.gmail.com>
Subject: Re: [RFC PATCH ghak32 V2 04/13] audit: add containerid filtering
To: Richard Guy Briggs <rgb@redhat.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Implement container ID filtering using the AUDIT_CONTAINERID field name
> to send an 8-character string representing a u64 since the value field
> is only u32.
>
> Sending it as two u32 was considered, but gathering and comparing two
> fields was more complex.

My only worry here is that you aren't really sending a string in the
ASCII sense, you are sending an 8 byte buffer (that better be NUL
terminated) that happens to be an unsigned 64-bit integer.  To be
clear, I'm okay with that (it's protected by AUDIT_CONTAINERID), and
the code is okay with that, I just want us to pause for a minute and
make sure that is an okay thing to do long term.

> The feature indicator is AUDIT_FEATURE_BITMAP_CONTAINERID_FILTER.
>
> This requires support from userspace to be useful.
> See: https://github.com/linux-audit/audit-userspace/issues/40
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h      |  1 +
>  include/uapi/linux/audit.h |  5 ++++-
>  kernel/audit.h             |  1 +
>  kernel/auditfilter.c       | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>  kernel/auditsc.c           |  3 +++
>  5 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 3acbe9d..f10ca1b 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -76,6 +76,7 @@ struct audit_field {
>         u32                             type;
>         union {
>                 u32                     val;
> +               u64                     val64;
>                 kuid_t                  uid;
>                 kgid_t                  gid;
>                 struct {
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index e83ccbd..8443a8f 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -262,6 +262,7 @@
>  #define AUDIT_LOGINUID_SET     24
>  #define AUDIT_SESSIONID        25      /* Session ID */
>  #define AUDIT_FSTYPE   26      /* FileSystem Type */
> +#define AUDIT_CONTAINERID      27      /* Container ID */
>
>                                 /* These are ONLY useful when checking
>                                  * at syscall exit time (AUDIT_AT_EXIT). */
> @@ -342,6 +343,7 @@ enum {
>  #define AUDIT_FEATURE_BITMAP_SESSIONID_FILTER  0x00000010
>  #define AUDIT_FEATURE_BITMAP_LOST_RESET                0x00000020
>  #define AUDIT_FEATURE_BITMAP_FILTER_FS         0x00000040
> +#define AUDIT_FEATURE_BITMAP_CONTAINERID_FILTER        0x00000080
>
>  #define AUDIT_FEATURE_BITMAP_ALL (AUDIT_FEATURE_BITMAP_BACKLOG_LIMIT | \
>                                   AUDIT_FEATURE_BITMAP_BACKLOG_WAIT_TIME | \
> @@ -349,7 +351,8 @@ enum {
>                                   AUDIT_FEATURE_BITMAP_EXCLUDE_EXTEND | \
>                                   AUDIT_FEATURE_BITMAP_SESSIONID_FILTER | \
>                                   AUDIT_FEATURE_BITMAP_LOST_RESET | \
> -                                 AUDIT_FEATURE_BITMAP_FILTER_FS)
> +                                 AUDIT_FEATURE_BITMAP_FILTER_FS | \
> +                                 AUDIT_FEATURE_BITMAP_CONTAINERID_FILTER)
>
>  /* deprecated: AUDIT_VERSION_* */
>  #define AUDIT_VERSION_LATEST           AUDIT_FEATURE_BITMAP_ALL
> diff --git a/kernel/audit.h b/kernel/audit.h
> index 214e149..aaa651a 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -234,6 +234,7 @@ static inline int audit_hash_ino(u32 ino)
>
>  extern int audit_match_class(int class, unsigned syscall);
>  extern int audit_comparator(const u32 left, const u32 op, const u32 right);
> +extern int audit_comparator64(const u64 left, const u32 op, const u64 right);
>  extern int audit_uid_comparator(kuid_t left, u32 op, kuid_t right);
>  extern int audit_gid_comparator(kgid_t left, u32 op, kgid_t right);
>  extern int parent_len(const char *path);
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index d7a807e..c4c8746 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -410,6 +410,7 @@ static int audit_field_valid(struct audit_entry *entry, struct audit_field *f)
>         /* FALL THROUGH */
>         case AUDIT_ARCH:
>         case AUDIT_FSTYPE:
> +       case AUDIT_CONTAINERID:
>                 if (f->op != Audit_not_equal && f->op != Audit_equal)
>                         return -EINVAL;
>                 break;
> @@ -584,6 +585,14 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
>                         }
>                         entry->rule.exe = audit_mark;
>                         break;
> +               case AUDIT_CONTAINERID:
> +                       if (f->val != sizeof(u64))
> +                               goto exit_free;
> +                       str = audit_unpack_string(&bufp, &remain, f->val);
> +                       if (IS_ERR(str))
> +                               goto exit_free;
> +                       f->val64 = ((u64 *)str)[0];
> +                       break;
>                 }
>         }
>
> @@ -666,6 +675,11 @@ static struct audit_rule_data *audit_krule_to_data(struct audit_krule *krule)
>                         data->buflen += data->values[i] =
>                                 audit_pack_string(&bufp, audit_mark_path(krule->exe));
>                         break;
> +               case AUDIT_CONTAINERID:
> +                       data->buflen += data->values[i] = sizeof(u64);
> +                       for (i = 0; i < sizeof(u64); i++)
> +                               ((char *)bufp)[i] = ((char *)&f->val64)[i];
> +                       break;
>                 case AUDIT_LOGINUID_SET:
>                         if (krule->pflags & AUDIT_LOGINUID_LEGACY && !f->val) {
>                                 data->fields[i] = AUDIT_LOGINUID;
> @@ -752,6 +766,10 @@ static int audit_compare_rule(struct audit_krule *a, struct audit_krule *b)
>                         if (!gid_eq(a->fields[i].gid, b->fields[i].gid))
>                                 return 1;
>                         break;
> +               case AUDIT_CONTAINERID:
> +                       if (a->fields[i].val64 != b->fields[i].val64)
> +                               return 1;
> +                       break;
>                 default:
>                         if (a->fields[i].val != b->fields[i].val)
>                                 return 1;
> @@ -1210,6 +1228,31 @@ int audit_comparator(u32 left, u32 op, u32 right)
>         }
>  }
>
> +int audit_comparator64(u64 left, u32 op, u64 right)
> +{
> +       switch (op) {
> +       case Audit_equal:
> +               return (left == right);
> +       case Audit_not_equal:
> +               return (left != right);
> +       case Audit_lt:
> +               return (left < right);
> +       case Audit_le:
> +               return (left <= right);
> +       case Audit_gt:
> +               return (left > right);
> +       case Audit_ge:
> +               return (left >= right);
> +       case Audit_bitmask:
> +               return (left & right);
> +       case Audit_bittest:
> +               return ((left & right) == right);
> +       default:
> +               BUG();
> +               return 0;
> +       }
> +}
> +
>  int audit_uid_comparator(kuid_t left, u32 op, kuid_t right)
>  {
>         switch (op) {
> @@ -1348,6 +1391,10 @@ int audit_filter(int msgtype, unsigned int listtype)
>                                 result = audit_comparator(audit_loginuid_set(current),
>                                                           f->op, f->val);
>                                 break;
> +                       case AUDIT_CONTAINERID:
> +                               result = audit_comparator64(audit_get_containerid(current),
> +                                                             f->op, f->val64);
> +                               break;
>                         case AUDIT_MSGTYPE:
>                                 result = audit_comparator(msgtype, f->op, f->val);
>                                 break;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 65be110..2bba324 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -614,6 +614,9 @@ static int audit_filter_rules(struct task_struct *tsk,
>                 case AUDIT_LOGINUID_SET:
>                         result = audit_comparator(audit_loginuid_set(tsk), f->op, f->val);
>                         break;
> +               case AUDIT_CONTAINERID:
> +                       result = audit_comparator64(audit_get_containerid(tsk), f->op, f->val64);
> +                       break;
>                 case AUDIT_SUBJ_USER:
>                 case AUDIT_SUBJ_ROLE:
>                 case AUDIT_SUBJ_TYPE:
> --
> 1.8.3.1
>
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit



-- 
paul moore
www.paul-moore.com
