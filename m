Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3721279-1520200574-2-8584818744607899860
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520200573; b=fTGxQMnW91gEBKA1JtFEFic83oTpq3Z2jraGxAJjR5eYddE
    WD983WlRfLhlgtaiW7VbsWW+4X1kIghNxbURYD5/KmaOkPov58yjUcBfVFRPIdFs
    0qVTgovNlcAu95KEicG3Vu6eC1SddlKnvTjQ4GFWcEnIweeW+ZMdl167Pv6YnVEs
    wDHvf+63Mjib/fAkzyvH7p+ySM6CAWin+MDgIaSDCyoGRFYH1EjO9ggVq4FO52UV
    6PaBWyC1pEqTdc70/ZQRw8a4Qon4NC8tZ5h74AcH/AAqTjNOr1vypcw0ZZZf6Tpm
    G3FfhsANvNmX36sChH67FGWx4SCt7axhURqfCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:in-reply-to
    :references:content-type:mime-version:content-transfer-encoding
    :message-id:sender:list-id; s=arctest; t=1520200573; bh=xzRLHvU4
    VQhOoYA66qNenxaZ0iYrRrLmC/HoTSPI1wE=; b=Uorho6jAAh9FGU6cNjcpHmsE
    t+7sJM+/HcQEt+p27ARQ1ZNFqaqpMUOUKwRNhl9AimhirACApK1iRuYmjbQU/mlC
    YxiJLZmm4X4+8iJhwLDjhwtiCDNKd8u/mUFVqM0DMo8zkOnmCWe2SUP9+kQiklXp
    3fNb7LtnL0KhStbmeGp0ZL3s/nP4TUJogJFUZFES3KORFFeAW3jpdcdLaL4Ff2CK
    AB7Jtvig/JQ076zFu053F30y4323asSEmAUE3ELpYkJzzFscsGBLd0sEir687+0G
    V9gKDw4Dr9d47cZyO/rMf9lPIheZkJZMYr+ZFNmfj0HLnwQtItTgTUpoCUZcTg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932206AbeCDV4J (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Mar 2018 16:56:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932298AbeCDV4J (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 4 Mar 2018 16:56:09 -0500
Subject: Re: [RFC PATCH V1 00/12] audit: implement container id
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Richard Guy Briggs <rgb@redhat.com>, cgroups@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Cc: mszeredi@redhat.com, ebiederm@xmission.com, simo@redhat.com,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, luto@kernel.org, eparis@parisplace.org,
        trondmy@primarydata.com, serge@hallyn.com
Date: Sun, 04 Mar 2018 16:55:57 -0500
In-Reply-To: <cover.1519930146.git.rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18030421-0040-0000-0000-0000041A9E37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030421-0041-0000-0000-0000261DAAC8
Message-Id: <1520200557.10396.257.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-04_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803040285
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-01 at 14:41 -0500, Richard Guy Briggs wrote:
> Implement audit kernel container ID.
> 
> This patchset is a preliminary RFC based on the proposal document (V3)
> posted:
> 	https://www.redhat.com/archives/linux-audit/2018-January/msg00014.html
> 
> The first patch implements the proc fs write to set the audit container
> ID of a process, emitting an AUDIT_CONTAINER record.
> 
> The second implements an auxiliary syscall record AUDIT_CONTAINER_INFO
> if a container ID is present on a task.
> 
> The third adds filtering to the exit, exclude and user lists.
> 
> The 4th, implements reading the container ID from the proc filesystem
> for debugging.  This isn't planned for upstream inclusion.
> 
> The 5th adds signal and ptrace support.
> 
> The 6th attempts to create a local audit context to be able to bind a
> standalone record with the container ID record.
> 
> The 7th, 8th, 9th, 10th patches add container ID records to standalone
> records.  Some of these may end up being syscall auxiliary records and
> won't need this specific support since they'll be supported via
> syscalls.
> 
> The 11th is a temporary workaround due to the AUDIT_CONTAINER records
> not showing up as do AUDIT_LOGIN records.  I suspect this is due to its
> range (1000 vs 1300), but the intent is to solve it.
> 
> The 12th adds debug information not intended for upstream for those
> brave souls wanting to tinker with it in this early state.
> 
> Feedback please!

Which tree can this patch set be applied to?

Mimi

> Here's a quick and dirty test script:
> echo 123455 > /proc/$$/containerid; echo $?
> sleep 4&  
> child=$!; sleep 1
> echo 18446744073709551615 > /proc/$child/containerid; echo $?
> echo 123456 > /proc/$child/containerid; echo $?
> echo 123457 > /proc/$child/containerid; echo $?
> sleep 1
> ausearch -ts recent |grep " contid=18446744073709551615"; echo $?
> ausearch -ts recent |grep " contid=123456"; echo $?
> ausearch -ts recent |grep " contid=123457"; echo $?
> echo self:$$ contid:$( cat /proc/$$/containerid)
> echo child:$child contid:$( cat /proc/$child/containerid)
> 
> containerid=123458
> key=tmpcontainerid
> auditctl -a exit,always -F dir=/tmp -F perm=wa -F containerid=$containerid -F key=$key || echo failed to add containerid filter rule
> bash -c "sleep 1; echo test > /tmp/$key"&
> child=$!
> echo $containerid > /proc/$child/containerid
> sleep 2
> rm -f /tmp/$key
> ausearch -ts recent -k $key || echo failed to find CONTAINER_INFO record
> auditctl -d exit,always -F dir=/tmp -F perm=wa -F containerid=$containerid -F key=$key || echo failed to add containerid filter rule
> 
> See:
> 	https://github.com/linux-audit/audit-kernel/issues/32
> 	https://github.com/linux-audit/audit-userspace/issues/40
> 	https://github.com/linux-audit/audit-testsuite/issues/64
> 
> Richard Guy Briggs (12):
>   audit: add container id
>   audit: log container info of syscalls
>   audit: add containerid filtering
>   audit: read container ID of a process
>   audit: add containerid support for ptrace and signals
>   audit: add support for non-syscall auxiliary records
>   audit: add container aux record to watch/tree/mark
>   audit: add containerid support for tty_audit
>   audit: add containerid support for config/feature/user records
>   audit: add containerid support for seccomp and anom_abend records
>   debug audit: add container id
>   debug! audit: add container id
> 
>  drivers/tty/tty_audit.c    |   5 +-
>  fs/proc/base.c             |  63 +++++++++++++++++++
>  include/linux/audit.h      |  36 +++++++++++
>  include/linux/init_task.h  |   4 +-
>  include/linux/sched.h      |   1 +
>  include/uapi/linux/audit.h |   9 ++-
>  kernel/audit.c             |  74 +++++++++++++++++++---
>  kernel/audit.h             |   3 +
>  kernel/audit_fsnotify.c    |   5 +-
>  kernel/audit_tree.c        |   5 +-
>  kernel/audit_watch.c       |  33 +++++-----
>  kernel/auditfilter.c       |  52 ++++++++++++++-
>  kernel/auditsc.c           | 154 +++++++++++++++++++++++++++++++++++++++++++--
>  13 files changed, 408 insertions(+), 36 deletions(-)
> 

