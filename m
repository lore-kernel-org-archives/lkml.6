Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1150850-1526930365-2-10303184091817778790
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
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
    1526930364; b=BdmTu8TY2iO2eYbVknDjqTVnjdHh7WhBgAkSNHAPkFLwU8jSqr
    dCLBXOPXSpjrPTMECWSoWbUY2sV8UHdZa2lbhzAs/oRKaTJKLK0DOtgYh8ttNN8Y
    3iiHkHVtJChbUo3M2HS0yx4w5dJyaZYf/M6qCKRlqGhkHSdTGH34zYKJL7g6VZZs
    8NPeSrJSH5r+iA/LLxnbDGrI1PGPIvxVlyiTH1azO008FpZnNvPUevD255pRLOFG
    mPItqoLYtMdJyxvVVrZaMh5MhEbz03hNU4tJoJqNGLUejPz9dInTsSd0j05zwb4W
    +vDQhasR+6qFZjraABQUOb++8KxWQVnyClBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=fm2; t=1526930364; bh=+nPhZRRPu5
    PRQeOLzhdGkTGsUc29nY5WqTimJNl4EjM=; b=MPnwdXQQRPpp8UFyFcsXDHbmLE
    5CJOCNs9ft9Ml2u2jd6aISOBhLhdx0mJxioTZikQYDSYozHer9BccPDbd3TUGuOT
    aZY24vk5s5zmdr1sYkSVVKvJaiVxUvDfFyv5vr+h+t4n3En45C5EOBPqL7QNlr1j
    IuJwvjTJdtb96R+pEtWRbck2oYohOdIPEFlKg6S8rOAj1JlkhRfjgvj15HFpEmvc
    QZnmwt6SbpFCSLzCOfG2ePhDZmO/nHQOhlGBGoM41dfmmhaNmeJ5rRyApRpiiLf/
    HAPMsbBv8gwOIKRTBci2SVrxzTXeNfQ4eAVQBAz5YA+eCjFNOpcsPmmXRkog==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMnGy89WmC4cZdAbdQ9EUf/4AjGRkKcRWrjEJP0Ej2RpU4j1fSEmjN7u4q9e/bAEPeTDnDe+Aoi+EMwi+gvcjdvBTuN7w6tZCIbsbApFE49f+yKQnuWv
    YTIsE7aFYl06viqB1ePjkboHu+TU8xq2MFKfnsjGcs/DxpNrLtZbsKFvzxQACmqnuTTykgeMx9N7U8adxWOos+MQiQ9d52j5ydr8UCTlmlcb9vJc0D6QLA3Q
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=bhM9tIYIJ_OL1OFAETcA:9
    a=CjuIK1q_8ugA:10 a=jDz1Lg8WPqQA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbeEUTTN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 15:19:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750773AbeEUTTM (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 21 May 2018 15:19:12 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com, eparis@parisplace.org,
        serge@hallyn.com
Subject: Re: [RFC PATCH ghak32 V2 03/13] audit: log container info of syscalls
Date: Mon, 21 May 2018 15:19:10 -0400
Message-ID: <41282003.Hb38ry776C@x2>
Organization: Red Hat
In-Reply-To: <20180517214102.qhg4gofwrbsn2eru@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com> <20180517170907.3d9f7c1a@ivy-bridge> <20180517214102.qhg4gofwrbsn2eru@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thursday, May 17, 2018 5:41:02 PM EDT Richard Guy Briggs wrote:
> On 2018-05-17 17:09, Steve Grubb wrote:
> > On Fri, 16 Mar 2018 05:00:30 -0400
> > 
> > Richard Guy Briggs <rgb@redhat.com> wrote:
> > > Create a new audit record AUDIT_CONTAINER_INFO to document the
> > > container ID of a process if it is present.
> > 
> > As mentioned in a previous email, I think AUDIT_CONTAINER is more
> > suitable for the container record. One more comment below...
> > 
> > > Called from audit_log_exit(), syscalls are covered.
> > > 
> > > A sample raw event:
> > > type=SYSCALL msg=audit(1519924845.499:257): arch=c000003e syscall=257
> > > success=yes exit=3 a0=ffffff9c a1=56374e1cef30 a2=241 a3=1b6 items=2
> > > ppid=606 pid=635 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0
> > > sgid=0 fsgid=0 tty=pts0 ses=3 comm="bash" exe="/usr/bin/bash"
> > > subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > > key="tmpcontainerid" type=CWD msg=audit(1519924845.499:257):
> > > cwd="/root" type=PATH msg=audit(1519924845.499:257): item=0
> > > name="/tmp/" inode=13863 dev=00:27 mode=041777 ouid=0 ogid=0
> > > rdev=00:00 obj=system_u:object_r:tmp_t:s0 nametype= PARENT
> > > cap_fp=0000000000000000 cap_fi=0000000000000000 cap_fe=0 cap_fver=0
> > > type=PATH msg=audit(1519924845.499:257): item=1
> > > name="/tmp/tmpcontainerid" inode=17729 dev=00:27 mode=0100644 ouid=0
> > > ogid=0 rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0
> > > nametype=CREATE cap_fp=0000000000000000 cap_fi=0000000000000000
> > > cap_fe=0 cap_fver=0 type=PROCTITLE msg=audit(1519924845.499:257):
> > > proctitle=62617368002D6300736C65657020313B206563686F2074657374203E202F7
> > > 46D702F746D70636F6E7461696E65726964 type=CONTAINER_INFO
> > > msg=audit(1519924845.499:257): op=task
> > > contid=123458
> > > 
> > > See: https://github.com/linux-audit/audit-kernel/issues/32
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > > 
> > >  include/linux/audit.h      |  5 +++++
> > >  include/uapi/linux/audit.h |  1 +
> > >  kernel/audit.c             | 20 ++++++++++++++++++++
> > >  kernel/auditsc.c           |  2 ++
> > >  4 files changed, 28 insertions(+)
> > > 
> > > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > > index fe4ba3f..3acbe9d 100644
> > > --- a/include/linux/audit.h
> > > +++ b/include/linux/audit.h
> > > @@ -154,6 +154,8 @@ extern void
> > > audit_log_link_denied(const char *operation, extern int
> > > audit_log_task_context(struct audit_buffer *ab); extern void
> > > audit_log_task_info(struct audit_buffer *ab, struct task_struct *tsk);
> > > +extern int audit_log_container_info(struct task_struct *tsk,
> > > +				     struct audit_context *context);
> > > 
> > >  extern int		    audit_update_lsm_rules(void);
> > > 
> > > @@ -205,6 +207,9 @@ static inline int audit_log_task_context(struct
> > > audit_buffer *ab) static inline void audit_log_task_info(struct
> > > audit_buffer *ab, struct task_struct *tsk)
> > > 
> > >  { }
> > > 
> > > +static inline int audit_log_container_info(struct task_struct *tsk,
> > > +					    struct audit_context
> > > *context); +{ }
> > > 
> > >  #define audit_enabled 0
> > >  #endif /* CONFIG_AUDIT */
> > > 
> > > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > > index 921a71f..e83ccbd 100644
> > > --- a/include/uapi/linux/audit.h
> > > +++ b/include/uapi/linux/audit.h
> > > @@ -115,6 +115,7 @@
> > > 
> > >  #define AUDIT_REPLACE		1329	/* Replace auditd
> > > 
> > > if this packet unanswerd */ #define AUDIT_KERN_MODULE
> > > 1330	/* Kernel Module events */ #define
> > > AUDIT_FANOTIFY		1331	/* Fanotify access decision
> > > */ +#define AUDIT_CONTAINER_INFO	1332	/* Container ID
> > > information */ #define AUDIT_AVC		1400	/* SE
> > > Linux avc denial or grant */ #define AUDIT_SELINUX_ERR
> > > 1401	/* Internal SE Linux Errors */ diff --git
> > > a/kernel/audit.c b/kernel/audit.c index 3f2f143..a12f21f 100644
> > > --- a/kernel/audit.c
> > > +++ b/kernel/audit.c
> > > @@ -2049,6 +2049,26 @@ void audit_log_session_info(struct
> > > audit_buffer *ab) audit_log_format(ab, " auid=%u ses=%u", auid,
> > > sessionid); }
> > > 
> > > +/*
> > > + * audit_log_container_info - report container info
> > > + * @tsk: task to be recorded
> > > + * @context: task or local context for record
> > > + */
> > > +int audit_log_container_info(struct task_struct *tsk, struct
> > > audit_context *context) +{
> > > +	struct audit_buffer *ab;
> > > +
> > > +	if (!audit_containerid_set(tsk))
> > > +		return 0;
> > > +	/* Generate AUDIT_CONTAINER_INFO with container ID */
> > > +	ab = audit_log_start(context, GFP_KERNEL,
> > > AUDIT_CONTAINER_INFO);
> > > +	if (!ab)
> > > +		return -ENOMEM;
> > > +	audit_log_format(ab, "contid=%llu",
> > > audit_get_containerid(tsk));
> > > +	audit_log_end(ab);
> > > +	return 0;
> > > +}
> > > +
> > > 
> > >  void audit_log_key(struct audit_buffer *ab, char *key)
> > >  {
> > >  
> > >  	audit_log_format(ab, " key=");
> > > 
> > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > index a6b0a52..65be110 100644
> > > --- a/kernel/auditsc.c
> > > +++ b/kernel/auditsc.c
> > > @@ -1453,6 +1453,8 @@ static void audit_log_exit(struct audit_context
> > > *context, struct task_struct *ts
> > > 
> > >  	audit_log_proctitle(tsk, context);
> > > 
> > > +	audit_log_container_info(tsk, context);
> > 
> > Would there be any problem moving audit_log_container_info before
> > audit_log_proctitle? There are some assumptions that proctitle is the
> > last record in some situations.
> 
> I see no problem doing that.

Actually...just leave it as is. I have to fix things for simple events and 
they do not have a proctitle record. So, leave it as you intended and I'll 
work around this on my end.

Thanks,
-Steve

> > >  	/* Send end of event record to help user space know we are
> > > 
> > > finished */ ab = audit_log_start(context, GFP_KERNEL, AUDIT_EOE);
> > > 
> > >  	if (ab)
> 
> - RGB
> 
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635




