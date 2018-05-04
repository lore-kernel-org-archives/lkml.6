Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-616729-1525462090-2-14653609167483863203
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525462090; b=Rr0XNrbiwYT8I/6NrJXQjvDTfHnOXrCvJvegE6doHX+69h2AT8
    bHOjGia/Uy4X+zYL+z2fd1qp/asf7huQ5Iaf5crXLID+AQEP8iTXb0yDBcTIuSEk
    bb7pSfM/O0roV/hRWO6mZhy/zoEWyYrsVY8oFvKqw06S/K9zzpBI8Pb8esbQiV1k
    3lsOEAda1/lar2MjoF3145XJRKeAcNxEaY4GrHNzVOMKZuROWfo4uZZ9Lu22Tzz9
    hCeJ0TXymnPiLmoaKTbdCg5w5HD1kyPpTaakAO0T9yH5x6LiFh5Q5161PbmEw1R8
    Ud65c6YEECAo/vcwbTjkGNS5rl9DI3hvcfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=fm2; t=1525462090; bh=odBCgF32Yi
    TA4OZDiD5u2Hcu73NlxiJ8nzhqNiEJWi0=; b=JWN+ajhSsTnd0Ybg0YquNA08Hu
    UWf0miLBa53HWHmeE/CCPG/vNy3/OY2pN6EwGceWviAAkcRH1zxM/oOR878yPtcG
    KGp2QAEAmF/ToU+c24MvQPTTZJK23j3Gz5F7V9NHAM7Mcdhd/XHbLnLsdP5fbYre
    g9PC6tNKoXa+236idjnBKmhYdINVlEuqrNkDMnwkKxQ3kWO78hE4tRDarxg/N3Q9
    kGotC8S48eTGeeruDks+sC4PvwHQEv9kmJ7GoLQo/61TU2PWRSjm2Uw/cs06XMgJ
    FL5wAMDA4Nl2BzXYxILE7Ams2I0vTMafU5DC/u1YSE+T7QO7lfAydGsKfPHQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
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
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNoKvzZJt1NBt+1D3vhiMlSACIEwqJSGl5jacq/Ic4ew0B83gQBEUf/h+W84xUIQdnlqZyl1/bW2dMMf2GfABF0yod98587A2cZmUbbvpIh5RQoEKnNn
    9bSYb5koE9EnCRzBny3gDqSNj7xAb3iUDp/zqS2MZfqVF+PRztIBS7go2mxO8izGMVc8MGFx4GMKqjOIm4jOI89FPAa2nMMAvH3+pyMKvYH1iFMBkiCSto87
    Vb3Y0ORC2kZ/qXQ0hgsgXA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=AUx5IaqTLitQ4H-0lNMA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=rjTVMONInIDnV1a_A2c_:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751622AbeEDT2H (ORCPT <rfc822;linux@kroah.com>);
        Fri, 4 May 2018 15:28:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751558AbeEDT2G (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 May 2018 15:28:06 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: Tyler Hicks <tyhicks@canonical.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-audit@redhat.com,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 3/4] seccomp: Audit attempts to modify the actions_logged sysctl
Date: Fri, 04 May 2018 15:28:05 -0400
Message-ID: <4245752.EBNmQNxroQ@x2>
Organization: Red Hat
In-Reply-To: <1525396095-27737-4-git-send-email-tyhicks@canonical.com>
References: <1525396095-27737-1-git-send-email-tyhicks@canonical.com> <1525396095-27737-4-git-send-email-tyhicks@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thursday, May 3, 2018 9:08:14 PM EDT Tyler Hicks wrote:
> The decision to log a seccomp action will always be subject to the
> value of the kernel.seccomp.actions_logged sysctl, even for processes
> that are being inspected via the audit subsystem, in an upcoming patch.
> Therefore, we need to emit an audit record on attempts at writing to the
> actions_logged sysctl when auditing is enabled.
> 
> This patch updates the write handler for the actions_logged sysctl to
> emit an audit record on attempts to write to the sysctl. Successful
> writes to the sysctl will result in a record that includes a normalized
> list of logged actions in the "actions" field and a "res" field equal to
> 1. Unsuccessful writes to the sysctl will result in a record that
> doesn't include the "actions" field and has a "res" field equal to 0.
> 
> Not all unsuccessful writes to the sysctl are audited. For example, an
> audit record will not be emitted if an unprivileged process attempts to
> open the sysctl file for reading since that access control check is not
> part of the sysctl's write handler.
> 
> Below are some example audit records when writing various strings to the
> actions_logged sysctl.
> 
> Writing "not-a-real-action", when the kernel.seccomp.actions_logged
> sysctl previously was "kill_process kill_thread trap errno trace log",
> emits this audit record:
> 
>  type=CONFIG_CHANGE msg=audit(1525392371.454:120): op=seccomp-logging
>  actions=? old-actions=kill_process,kill_thread,trap,errno,trace,log
>  res=0
> 
> If you then write "kill_process kill_thread errno trace log", this audit
> record is emitted:
> 
>  type=CONFIG_CHANGE msg=audit(1525392401.645:126): op=seccomp-logging
>  actions=kill_process,kill_thread,errno,trace,log
>  old-actions=kill_process,kill_thread,trap,errno,trace,log res=1
> 
> If you then write "log log errno trace kill_process kill_thread", which
> is unordered and contains the log action twice, it results in the same
> actions value as the previous record:
> 
>  type=CONFIG_CHANGE msg=audit(1525392436.354:132): op=seccomp-logging
>  actions=kill_process,kill_thread,errno,trace,log
>  old-actions=kill_process,kill_thread,errno,trace,log res=1
> 
> If you then write an empty string to the sysctl, this audit record is
> emitted:
> 
>  type=CONFIG_CHANGE msg=audit(1525392494.413:138): op=seccomp-logging
>  actions=(none) old-actions=kill_process,kill_thread,errno,trace,log
>  res=1
> 
> No audit records are generated when reading the actions_logged sysctl.

This appears to cover all the corner cases we talked about. ACK for the 
format of the records.

Thanks,
-Steve
 
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
> ---
>  include/linux/audit.h |  5 +++++
>  kernel/auditsc.c      | 20 ++++++++++++++++++
>  kernel/seccomp.c      | 58
> +++++++++++++++++++++++++++++++++++++++++++-------- 3 files changed, 74
> insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 75d5b03..d4e35e7 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -233,6 +233,8 @@ extern void __audit_inode_child(struct inode *parent,
>  				const struct dentry *dentry,
>  				const unsigned char type);
>  extern void __audit_seccomp(unsigned long syscall, long signr, int code);
> +extern void audit_seccomp_actions_logged(const char *names,
> +					 const char *old_names, int res);
>  extern void __audit_ptrace(struct task_struct *t);
> 
>  static inline bool audit_dummy_context(void)
> @@ -502,6 +504,9 @@ static inline void __audit_seccomp(unsigned long
> syscall, long signr, int code) { }
>  static inline void audit_seccomp(unsigned long syscall, long signr, int
> code) { }
> +static inline void audit_seccomp_actions_logged(const char *names,
> +						const char *old_names, int res)
> +{ }
>  static inline int auditsc_get_stamp(struct audit_context *ctx,
>  			      struct timespec64 *t, unsigned int *serial)
>  {
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 4e0a4ac..5195a29 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2478,6 +2478,26 @@ void __audit_seccomp(unsigned long syscall, long
> signr, int code) audit_log_end(ab);
>  }
> 
> +void audit_seccomp_actions_logged(const char *names, const char
> *old_names, +				  int res)
> +{
> +	struct audit_buffer *ab;
> +
> +	if (!audit_enabled)
> +		return;
> +
> +	ab = audit_log_start(current->audit_context, GFP_KERNEL,
> +			     AUDIT_CONFIG_CHANGE);
> +	if (unlikely(!ab))
> +		return;
> +
> +	audit_log_format(ab, "op=seccomp-logging");
> +	audit_log_format(ab, " actions=%s", names);
> +	audit_log_format(ab, " old-actions=%s", old_names);
> +	audit_log_format(ab, " res=%d", res);
> +	audit_log_end(ab);
> +}
> +
>  struct list_head *audit_killed_trees(void)
>  {
>  	struct audit_context *ctx = current->audit_context;
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index b36ac1e..f5630d1 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1219,11 +1219,10 @@ static int read_actions_logged(struct ctl_table
> *ro_table, void __user *buffer, }
> 
>  static int write_actions_logged(struct ctl_table *ro_table, void __user
> *buffer, -				size_t *lenp, loff_t *ppos)
> +				size_t *lenp, loff_t *ppos, u32 *actions_logged)
>  {
>  	char names[sizeof(seccomp_actions_avail)];
>  	struct ctl_table table;
> -	u32 actions_logged;
>  	int ret;
> 
>  	if (!capable(CAP_SYS_ADMIN))
> @@ -1238,24 +1237,65 @@ static int write_actions_logged(struct ctl_table
> *ro_table, void __user *buffer, if (ret)
>  		return ret;
> 
> -	if (!seccomp_actions_logged_from_names(&actions_logged, table.data))
> +	if (!seccomp_actions_logged_from_names(actions_logged, table.data))
>  		return -EINVAL;
> 
> -	if (actions_logged & SECCOMP_LOG_ALLOW)
> +	if (*actions_logged & SECCOMP_LOG_ALLOW)
>  		return -EINVAL;
> 
> -	seccomp_actions_logged = actions_logged;
> +	seccomp_actions_logged = *actions_logged;
>  	return 0;
>  }
> 
> +static void audit_actions_logged(u32 actions_logged, u32
> old_actions_logged, +				 int ret)
> +{
> +	char names[sizeof(seccomp_actions_avail)];
> +	char old_names[sizeof(seccomp_actions_avail)];
> +	const char *new = names;
> +	const char *old = old_names;
> +
> +	if (!audit_enabled)
> +		return;
> +
> +	memset(names, 0, sizeof(names));
> +	memset(old_names, 0, sizeof(old_names));
> +
> +	if (ret)
> +		new = "?";
> +	else if (!actions_logged)
> +		new = "(none)";
> +	else if (!seccomp_names_from_actions_logged(names, sizeof(names),
> +						    actions_logged, ","))
> +		new = "?";
> +
> +	if (!old_actions_logged)
> +		old = "(none)";
> +	else if (!seccomp_names_from_actions_logged(old_names,
> +						    sizeof(old_names),
> +						    old_actions_logged, ","))
> +		old = "?";
> +
> +	return audit_seccomp_actions_logged(new, old, !ret);
> +}
> +
>  static int seccomp_actions_logged_handler(struct ctl_table *ro_table, int
> write, void __user *buffer, size_t *lenp,
>  					  loff_t *ppos)
>  {
> -	if (write)
> -		return write_actions_logged(ro_table, buffer, lenp, ppos);
> -	else
> -		return read_actions_logged(ro_table, buffer, lenp, ppos);
> +	int ret;
> +
> +	if (write) {
> +		u32 actions_logged = 0;
> +		u32 old_actions_logged = seccomp_actions_logged;
> +
> +		ret = write_actions_logged(ro_table, buffer, lenp, ppos,
> +					   &actions_logged);
> +		audit_actions_logged(actions_logged, old_actions_logged, ret);
> +	} else
> +		ret = read_actions_logged(ro_table, buffer, lenp, ppos);
> +
> +	return ret;
>  }
> 
>  static struct ctl_path seccomp_sysctl_path[] = {




