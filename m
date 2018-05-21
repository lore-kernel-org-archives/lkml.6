Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1184171-1526930168-2-5441232767086935595
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526930167; b=PYPW4nzV+/osW63gM9gspi3GGeq97j0ZGLH1aTEgTVrzuZQlJ9
    wGaPrEwrHB4efXSa7yMtSqhWNxMqQPe6LGRJijV/6v7M0ViC7dIrLZP1MfxvGbv3
    PB2PGq6Tc0SPQZaWzsVNKpYo8wTzPbFkS7upcQ9j/+jvFq/H+9HbRhWMH2o8omuP
    k4Bi6YgR2NvIG/jeI58XNkOW+xm3wzAydVhKaF9StqqBnC/H1bfP7Y2xCrw7iOXD
    qUiw72oY3scxMflwbL/sxLH0J6CcB7LCUKrwZcEAvVvzkjb+UtCDMdiJeljQwhmc
    6BXHmsmhh4ccA8FZL73itoRr7q9WBaan4NfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=fm2; t=1526930167; bh=hgpm0RhgPn
    CylLl0O4MK0RaQG476PBsBpCdk0OpbM08=; b=NQNio1f9EwuXUvHRzPIBe1v6eq
    akbNT3pfFzLitUEK8lwlCWTWk+qFJyqx8hcBYt1Zk97NIbdG8SRtzMms/ClDeO1z
    6D4JaSN7oOcJzHXt+tkmWQETvF4yiD0NH0vzKCE3ITaWRLAgihxRLy8US3ZMn9uV
    +afRQ0t5W+ImWpery8WEhvL/4SdCTV9xG5o4Y1jm8IyWXC56CzBfUEVdLGTCW2w3
    OIiV/1DAha5eMr92VXMQ3Gr5eHqG3rcB3YiApEXu27e6DLhPS2JNeaIG1SzxuHcK
    rYYzIC+SaWWLyvuPdcqDQ+JZYTSfAHB6Xgwjep+MHbu1FOIXkzAiJHEJP7Zg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGpbsrwFi9RRFHkgQVw5aAcEqazZ21IGIUTmCgur9EtEl2zbfzQUQ/6OW2RVvjjkgTpBqSzRlpLD050kAlQpZkTtdh4Ji///m3C69GJEoUhcrc7u+pIY
    GA7a8DiFOurz51gxRaPWfA70oO81N5Xh3jkIER6BQTHPHCpJrQ/rJnp/OQRCUJK5V9K82ZrMmnLW5dF+ThuXPGbslmdRFWIQHiLOSe9rZLam2TqDLMjChJKw
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=3Vtnrq66yO5Y0IFr2f8A:9
    a=rFPMMf7fHNlETqqB:21 a=ATGjhGqymR9EzfW3:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751039AbeEUTQE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 15:16:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750970AbeEUTQD (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 21 May 2018 15:16:03 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: linux-audit@redhat.com
Cc: Richard Guy Briggs <rgb@redhat.com>, cgroups@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com, eparis@parisplace.org,
        serge@hallyn.com
Subject: Re: [RFC PATCH ghak32 V2 13/13] debug audit: read container ID of a process
Date: Mon, 21 May 2018 15:16:01 -0400
Message-ID: <3001737.MkQ41rgtZF@x2>
Organization: Red Hat
In-Reply-To: <1081821010c124fe4e35984ec3dac1654453bb7c.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com> <1081821010c124fe4e35984ec3dac1654453bb7c.1521179281.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Friday, March 16, 2018 5:00:40 AM EDT Richard Guy Briggs wrote:
> Add support for reading the container ID from the proc filesystem.

I think this could be useful in general. Please consider this to be part of 
the full patch set and not something merely used to debug the patches.

-Steve

> This is a read from the proc entry of the form /proc/PID/containerid
> where PID is the process ID of the task whose container ID is sought.
> 
> The read expects up to a u64 value (unset: 18446744073709551615).
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/proc/base.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 6ce4fbe..f66d1e2 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1300,6 +1300,21 @@ static ssize_t proc_sessionid_read(struct file *
> file, char __user * buf, .llseek		= generic_file_llseek,
>  };
> 
> +static ssize_t proc_containerid_read(struct file *file, char __user *buf,
> +				  size_t count, loff_t *ppos)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct task_struct *task = get_proc_task(inode);
> +	ssize_t length;
> +	char tmpbuf[TMPBUFLEN*2];
> +
> +	if (!task)
> +		return -ESRCH;
> +	length = scnprintf(tmpbuf, TMPBUFLEN*2, "%llu",
> audit_get_containerid(task)); +	put_task_struct(task);
> +	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
> +}
> +
>  static ssize_t proc_containerid_write(struct file *file, const char __user
> *buf, size_t count, loff_t *ppos)
>  {
> @@ -1330,6 +1345,7 @@ static ssize_t proc_containerid_write(struct file
> *file, const char __user *buf, }
> 
>  static const struct file_operations proc_containerid_operations = {
> +	.read		= proc_containerid_read,
>  	.write		= proc_containerid_write,
>  	.llseek		= generic_file_llseek,
>  };
> @@ -2996,7 +3012,7 @@ static int proc_pid_patch_state(struct seq_file *m,
> struct pid_namespace *ns, #ifdef CONFIG_AUDITSYSCALL
>  	REG("loginuid",   S_IWUSR|S_IRUGO, proc_loginuid_operations),
>  	REG("sessionid",  S_IRUGO, proc_sessionid_operations),
> -	REG("containerid", S_IWUSR, proc_containerid_operations),
> +	REG("containerid", S_IWUSR|S_IRUSR, proc_containerid_operations),
>  #endif
>  #ifdef CONFIG_FAULT_INJECTION
>  	REG("make-it-fail", S_IRUGO|S_IWUSR, proc_fault_inject_operations),
> @@ -3391,7 +3407,7 @@ static int proc_tid_comm_permission(struct inode
> *inode, int mask) #ifdef CONFIG_AUDITSYSCALL
>  	REG("loginuid",  S_IWUSR|S_IRUGO, proc_loginuid_operations),
>  	REG("sessionid",  S_IRUGO, proc_sessionid_operations),
> -	REG("containerid", S_IWUSR, proc_containerid_operations),
> +	REG("containerid", S_IWUSR|S_IRUSR, proc_containerid_operations),
>  #endif
>  #ifdef CONFIG_FAULT_INJECTION
>  	REG("make-it-fail", S_IRUGO|S_IWUSR, proc_fault_inject_operations),




