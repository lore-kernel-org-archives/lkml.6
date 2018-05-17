Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2752395-1526591368-2-669756506217857378
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526591367; b=K9npcPpMuJ0YyeC+STy900/RQi53us1IYHY78FAtJ9V6BkgNDA
    h+YoddezXDvHmBWA5zk9qN46MimtI25PyM0dhZZX7utgroNDQsCYpDODz4Ok3W4D
    wphq1xy6DDKOVyY4gDfdjoyEZodYNK40qWxYXHVM3N/4rGa9d5seFHnK1a/gDh0Q
    ZV/V0U5aTKDWfwVHS4KjsS2zKqMnggHNBompxkCVewoBPjiQzOPboRHPuC6wAsw0
    QCwtp6+6SN1gn0YZNBOaaNwlbORGLvZFYAVSPkNA2dPswX9VCvlHE4C3peb8YPVZ
    tVepD4x0eVtMWOvifsPFGgrg5FgQuCGN552A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526591367;
    bh=t9rI4VEwxwJrD1AgXsB5HiWrHbFSJu3GIQMtCX1OGgE=; b=iujd+U7klUFF
    GPdqm4IFPuQdK4psZoaCUeOclXznrMP1Ikw8YWsi2vTOmbjcenE8nLrNEAlnR72P
    IQ3c/Dbu3WHujldfoDJ2uL5X2qhZxfBG872cORegtJ1b6rHhtw1LJOWxX5LEPgdk
    DTCgyVLooHD7LhaWLE8JNgZDwtj0t0eAiNw0oiAtisN94bgzr+oTTEnz+X5gQJ/h
    zeF2DMpJtqyfo0j4flA3NI8POasWB9vUtrxqslUb0HHH5uNcZaW/6bcLzeD6ofwe
    loY4sV/X4vEZepBxMgpVzHihk6s1WLtUo4UE8j0MsWnhhEFZpmGKT4Guq22vu9DY
    H9BwAUjkpg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfDCXxZM45VJagDWdYJCiqiamWEMDeTFePxHL2m0KjiYJe+mE3CrZdYzxCFadhT82LjkTIH/ITSwpPPjucmCfHtZU7gOJAeBOnmqC4S9p8xDMSq69V6La
    Anf5Z2yC1eiJ593Uukhdp6O6FBt3eBTS5W2HeKPBM571rdPCuxv2u00VKNiHtxtDYXyqWQ2ISVrBdZ7Le28CZ3VJKwCdcXY3k2T8PRxu+Jnby4lQ8IbwJ9yX
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=oZ9bPDa-HcgmmhBSxHIA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbeEQVJZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 17:09:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751734AbeEQVJX (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 17 May 2018 17:09:23 -0400
Date: Thu, 17 May 2018 17:09:07 -0400
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
Subject: Re: [RFC PATCH ghak32 V2 03/13] audit: log container info of
 syscalls
Message-ID: <20180517170907.3d9f7c1a@ivy-bridge>
In-Reply-To: <6768d20c636df65534f8d325529669bb30a58382.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com>
        <6768d20c636df65534f8d325529669bb30a58382.1521179281.git.rgb@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Mar 2018 05:00:30 -0400
Richard Guy Briggs <rgb@redhat.com> wrote:

> Create a new audit record AUDIT_CONTAINER_INFO to document the
> container ID of a process if it is present.

As mentioned in a previous email, I think AUDIT_CONTAINER is more
suitable for the container record. One more comment below...

> Called from audit_log_exit(), syscalls are covered.
> 
> A sample raw event:
> type=SYSCALL msg=audit(1519924845.499:257): arch=c000003e syscall=257
> success=yes exit=3 a0=ffffff9c a1=56374e1cef30 a2=241 a3=1b6 items=2
> ppid=606 pid=635 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0
> sgid=0 fsgid=0 tty=pts0 ses=3 comm="bash" exe="/usr/bin/bash"
> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> key="tmpcontainerid" type=CWD msg=audit(1519924845.499:257):
> cwd="/root" type=PATH msg=audit(1519924845.499:257): item=0
> name="/tmp/" inode=13863 dev=00:27 mode=041777 ouid=0 ogid=0
> rdev=00:00 obj=system_u:object_r:tmp_t:s0 nametype= PARENT
> cap_fp=0000000000000000 cap_fi=0000000000000000 cap_fe=0 cap_fver=0
> type=PATH msg=audit(1519924845.499:257): item=1
> name="/tmp/tmpcontainerid" inode=17729 dev=00:27 mode=0100644 ouid=0
> ogid=0 rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0
> nametype=CREATE cap_fp=0000000000000000 cap_fi=0000000000000000
> cap_fe=0 cap_fver=0 type=PROCTITLE msg=audit(1519924845.499:257):
> proctitle=62617368002D6300736C65657020313B206563686F2074657374203E202F746D702F746D70636F6E7461696E65726964
> type=CONTAINER_INFO msg=audit(1519924845.499:257): op=task
> contid=123458
> 
> See: https://github.com/linux-audit/audit-kernel/issues/32
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h      |  5 +++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 20 ++++++++++++++++++++
>  kernel/auditsc.c           |  2 ++
>  4 files changed, 28 insertions(+)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index fe4ba3f..3acbe9d 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -154,6 +154,8 @@ extern void
> audit_log_link_denied(const char *operation, extern int
> audit_log_task_context(struct audit_buffer *ab); extern void
> audit_log_task_info(struct audit_buffer *ab, struct task_struct *tsk);
> +extern int audit_log_container_info(struct task_struct *tsk,
> +				     struct audit_context *context);
>  
>  extern int		    audit_update_lsm_rules(void);
>  
> @@ -205,6 +207,9 @@ static inline int audit_log_task_context(struct
> audit_buffer *ab) static inline void audit_log_task_info(struct
> audit_buffer *ab, struct task_struct *tsk)
>  { }
> +static inline int audit_log_container_info(struct task_struct *tsk,
> +					    struct audit_context
> *context); +{ }
>  #define audit_enabled 0
>  #endif /* CONFIG_AUDIT */
>  
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 921a71f..e83ccbd 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -115,6 +115,7 @@
>  #define AUDIT_REPLACE		1329	/* Replace auditd
> if this packet unanswerd */ #define AUDIT_KERN_MODULE
> 1330	/* Kernel Module events */ #define
> AUDIT_FANOTIFY		1331	/* Fanotify access decision
> */ +#define AUDIT_CONTAINER_INFO	1332	/* Container ID
> information */ #define AUDIT_AVC		1400	/* SE
> Linux avc denial or grant */ #define AUDIT_SELINUX_ERR
> 1401	/* Internal SE Linux Errors */ diff --git
> a/kernel/audit.c b/kernel/audit.c index 3f2f143..a12f21f 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2049,6 +2049,26 @@ void audit_log_session_info(struct
> audit_buffer *ab) audit_log_format(ab, " auid=%u ses=%u", auid,
> sessionid); }
>  
> +/*
> + * audit_log_container_info - report container info
> + * @tsk: task to be recorded
> + * @context: task or local context for record
> + */
> +int audit_log_container_info(struct task_struct *tsk, struct
> audit_context *context) +{
> +	struct audit_buffer *ab;
> +
> +	if (!audit_containerid_set(tsk))
> +		return 0;
> +	/* Generate AUDIT_CONTAINER_INFO with container ID */
> +	ab = audit_log_start(context, GFP_KERNEL,
> AUDIT_CONTAINER_INFO);
> +	if (!ab)
> +		return -ENOMEM;
> +	audit_log_format(ab, "contid=%llu",
> audit_get_containerid(tsk));
> +	audit_log_end(ab);
> +	return 0;
> +}
> +
>  void audit_log_key(struct audit_buffer *ab, char *key)
>  {
>  	audit_log_format(ab, " key=");
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index a6b0a52..65be110 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1453,6 +1453,8 @@ static void audit_log_exit(struct audit_context
> *context, struct task_struct *ts 
>  	audit_log_proctitle(tsk, context);
>  
> +	audit_log_container_info(tsk, context);

Would there be any problem moving audit_log_container_info before
audit_log_proctitle? There are some assumptions that proctitle is the
last record in some situations.

Thanks,
-Steve

>  	/* Send end of event record to help user space know we are
> finished */ ab = audit_log_start(context, GFP_KERNEL, AUDIT_EOE);
>  	if (ab)

