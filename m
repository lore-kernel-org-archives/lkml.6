Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1157863-1521145636-2-15165039530122957201
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='windows-1252'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521145635; b=Es44RG0xbjTtVyWA2cwYOtp1aCiR59hpyAnpPgqUBUQMLCL
    BjdZiD2PRd9PcnYTZ+79JaaALBsl1hNqjpec5KVz+e8xj4SGmk3zS3yKvfh0LhJ2
    o0fuOG2vxPEuHxI4qnnA2oGqJvoedLipzfLS/e6YJzm/BQB8ylCpD8GMEYh/rf2b
    zRga4JNGVuaWkme+lYmPxJG5ltaxWnuZ4X+i/BX3IQd0Vl8pBVisk0oDosC+OjnX
    jPhKJ/jWWknxfobQ/F641XxvfEbdzsuPYF5HeWrQ+TLM5Re/ZmVSZKifh8mMFCvY
    JMN83EfzZErcCdKIZh838HOU2ADtv3Rm7K7c6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :message-id:sender:list-id; s=arctest; t=1521145635; bh=COGSp/6X
    zQvWiQov3/UgdN3k3myIdU49Yay8riiN/fY=; b=j4JxW5fn+OshTSrr3g+YmLKz
    KccyUjuYLxloTlKVyRBEwPEZg249PsFoouVA9dtthkgnakLYFNWymAxKHNBdiMx1
    xv5xW/CsnO9PmCeKnYtEfzWRIdaL929hBo+VrfTSILKGvHcG7vDAdnAG09o20Rar
    jkPLaD0SSvCugcsnvvhgntOg0Dr9IBUdOvU23n+yUIchmzKDyRsOMA4A6DW7MaFV
    S/pWvk49FULy9pVTTQ2pRlUamudvu0JcLavUsN+tWVMsiuH85qhj8ajMI4Rxu/lO
    Oy1cCBAix1HDug/7R+X2B0bAKdiDV3C4Ag3vY/PMN7qrdbdBIlEOgrPhPxlebA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbeCOU1M (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 16:27:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752594AbeCOU1K (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Mar 2018 16:27:10 -0400
Subject: Re: [RFC PATCH V1 01/12] audit: add container id
To: Richard Guy Briggs <rgb@redhat.com>, cgroups@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
References: <cover.1519930146.git.rgb@redhat.com>
 <2e5d93ee46feca915a101c2fc3062da674a98223.1519930146.git.rgb@redhat.com>
Cc: mszeredi@redhat.com, luto@kernel.org, jlayton@redhat.com,
        carlos@redhat.com, viro@zeniv.linux.org.uk, dhowells@redhat.com,
        simo@redhat.com, trondmy@primarydata.com, eparis@parisplace.org,
        serge@hallyn.com, ebiederm@xmission.com, madzcar@gmail.com
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 15 Mar 2018 16:27:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <2e5d93ee46feca915a101c2fc3062da674a98223.1519930146.git.rgb@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18031520-0052-0000-0000-000002CA544F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008680; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003545; UDB=6.00510735; IPR=6.00782872;
 MB=3.00020055; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-15 20:27:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031520-0053-0000-0000-00005C0202B8
Message-Id: <216d1ab1-531b-9185-2e31-34f162f08aad@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-15_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803150222
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/01/2018 02:41 PM, Richard Guy Briggs wrote:
> Implement the proc fs write to set the audit container ID of a process,
> emitting an AUDIT_CONTAINER record to document the event.
>
> This is a write from the container orchestrator task to a proc entry of
> the form /proc/PID/containerid where PID is the process ID of the newly
> created task that is to become the first task in a container, or an
> additional task added to a container.
>
> The write expects up to a u64 value (unset: 18446744073709551615).
>
> This will produce a record such as this:
> type=UNKNOWN[1333] msg=audit(1519903238.968:261): op=set pid=596 uid=0 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 auid=0 tty=pts0 ses=1 opid=596 old-contid=18446744073709551615 contid=123455 res=0
>
> The "op" field indicates an initial set.  The "pid" to "ses" fields are
> the orchestrator while the "opid" field is the object's PID, the process
> being "contained".  Old and new container ID values are given in the
> "contid" fields, while res indicates its success.
>
> It is not permitted to self-set, unset or re-set the container ID.  A
> child inherits its parent's container ID, but then can be set only once
> after.
>
> See: https://github.com/linux-audit/audit-kernel/issues/32
>
>
>   /* audit_rule_data supports filter rules with both integer and string
>    * fields.  It corresponds with AUDIT_ADD_RULE, AUDIT_DEL_RULE and
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 4e0a4ac..0ee1e59 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2073,6 +2073,92 @@ int audit_set_loginuid(kuid_t loginuid)
>   	return rc;
>   }
>
> +static int audit_set_containerid_perm(struct task_struct *task, u64 containerid)
> +{
> +	struct task_struct *parent;
> +	u64 pcontainerid, ccontainerid;
> +	pid_t ppid;
> +
> +	/* Don't allow to set our own containerid */
> +	if (current == task)
> +		return -EPERM;
> +	/* Don't allow the containerid to be unset */
> +	if (!cid_valid(containerid))
> +		return -EINVAL;
> +	/* if we don't have caps, reject */
> +	if (!capable(CAP_AUDIT_CONTROL))
> +		return -EPERM;
> +	/* if containerid is unset, allow */
> +	if (!audit_containerid_set(task))
> +		return 0;

I am wondering whether there should be a check for the target process 
that will receive the containerid to not have CAP_SYS_ADMIN that would 
otherwise allow it to arbitrarily unshare()/clone() and leave the set of 
namespaces that may make up the container whose containerid we assign here?

> +	/* it is already set, and not inherited from the parent, reject */
> +	ccontainerid = audit_get_containerid(task);
> +	rcu_read_lock();
> +	parent = rcu_dereference(task->real_parent);
> +	rcu_read_unlock();
> +	task_lock(parent);
> +	pcontainerid = audit_get_containerid(parent);
> +	ppid = task_tgid_nr(parent);
ppid not needed...

> +	task_unlock(parent);
> +	if (ccontainerid != pcontainerid)
> +		return -EPERM;
> +	return 0;
> +}
> +
> +static void audit_log_set_containerid(struct task_struct *task, u64 oldcontainerid,
> +				      u64 containerid, int rc)
> +{
> +	struct audit_buffer *ab;
> +	uid_t uid;
> +	struct tty_struct *tty;
> +
> +	if (!audit_enabled)
> +		return;
> +
> +	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONTAINER);
> +	if (!ab)
> +		return;
> +
> +	uid = from_kuid(&init_user_ns, task_uid(current));
> +	tty = audit_get_tty(current);
> +
> +	audit_log_format(ab, "op=set pid=%d uid=%u", task_tgid_nr(current), uid);
> +	audit_log_task_context(ab);
> +	audit_log_format(ab, " auid=%u tty=%s ses=%u opid=%d old-contid=%llu contid=%llu res=%d",
> +			 from_kuid(&init_user_ns, audit_get_loginuid(current)),
> +			 tty ? tty_name(tty) : "(none)", audit_get_sessionid(current),
> +			 task_tgid_nr(task), oldcontainerid, containerid, !rc);
> +
> +	audit_put_tty(tty);
> +	audit_log_end(ab);
> +}
> +
> +/**
> + * audit_set_containerid - set current task's audit_context containerid
> + * @containerid: containerid value
> + *
> + * Returns 0 on success, -EPERM on permission failure.
> + *
> + * Called (set) from fs/proc/base.c::proc_containerid_write().
> + */
> +int audit_set_containerid(struct task_struct *task, u64 containerid)
> +{
> +	u64 oldcontainerid;
> +	int rc;
> +
> +	oldcontainerid = audit_get_containerid(task);
> +
> +	rc = audit_set_containerid_perm(task, containerid);
> +	if (!rc) {
> +		task_lock(task);
> +		task->containerid = containerid;
> +		task_unlock(task);
> +	}
> +
> +	audit_log_set_containerid(task, oldcontainerid, containerid, rc);
> +	return rc;
> +}
> +
>   /**
>    * __audit_mq_open - record audit data for a POSIX MQ open
>    * @oflag: open flag


