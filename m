Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4142037-1524312676-2-6577489048033288901
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524312675; b=lfRec0CIGWrblFLcCY8LDCKbSnfqUn/jailcXJw6B9O/Wqbkkm
    YK7vo6mdAfy7vlAAUFIkdmLaDiYqBuKnOngnMab38fzCnbNXiKwMrPJTfQuStPdw
    lp/WbQHpdj6LGtLeV0WZp4VDDnbQY39NzIEk2IKTOJvUWw6iKg8Lz15Ry4LC9FRU
    WMEErRuy/fSvrpjoxlkw5yKJb4IFuLplWpj55T5B02Fbn1YOibAITGrceCMnfLLA
    1Y+SEYTx+aKAhksAhCUKWDKpu+aEEnnGpZTo0BxQ5pTwqa1p5dXGiUaf0c9oJFaO
    Pjlr/DHiKNvmqYst2SfHZ8dKRAoyM4E6rORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524312675;
    bh=VgFbn4MraDrJ48yXXiX7O8XjVJiySQQznPJyC1/Q9TY=; b=PRmEgKe7x5lX
    T/iUSYomeXcxjfOTBBKwY2PnUks1EC6w0ihDtazoOlc1m/yNHDWWK+XNqdbq1iIF
    xavx62+s0NW+7IjDJU7kC9W542Vw1Cin35574icSXqaUehaW73Z/q3g1Km++bb3r
    TSucQD2K3ykt0ZpkD2ipq2vuQ4bBydIzVQQd/3u2Tqq3T4MXfflqYCaC4NPSUChN
    iDR8YuzricoMBmI4udLIw8TGkWsgh8qGBXh6g047f8wjfqNk1f7qN2xMckaaFjBR
    r+UVhX6j+3uqMwvaZrz/fwe8UJdriFEfwx5yKH9LqZQD03/ymcuG70HDfkSK0Gm+
    7Fzipl0xng==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=K+Hsg/h+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RRIb/2c2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=K+Hsg/h+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RRIb/2c2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKQi22eis6tQpuqA7YssZZU+X3b6fEVWLUVTrr3qnAzaEnLE8QSTYmiU3Tnm+nGLQOemiHQVaMTWnC7oJhtECzxQVctWLaflyqv6KOPqQTpAr2q/swCR
    9TrMcGEpG+Hk5RAjOa4PrEJfX8DIpqUlyfgbd016euoOPGT5JH/7g8OF/B12mcatVvm+qCnnwP4MlgOK7CmEBZS3C1YUhyzWelbdBno9Zu48+yc3DKGGyifD
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=HRwMqi8-0pf5HcEizSAA:9 a=CjuIK1q_8ugA:10 a=jDz1Lg8WPqQA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeDUMKz (ORCPT <rfc822;greg@kroah.com>);
        Sat, 21 Apr 2018 08:10:55 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38384 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752478AbeDUMKw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 21 Apr 2018 08:10:52 -0400
X-Google-Smtp-Source: AIpwx49eSClyz2QbqNQJ+43+lL8TjGvdpBGRQncqmtbzSdJym1s9hdlJdLuuJ4GV0nj2D0C77SRF9A==
From: Paul Moore <paul@paul-moore.com>
To: Richard Guy Briggs <rgb@redhat.com>
CC: <simo@redhat.com>, <jlayton@redhat.com>, <carlos@redhat.com>,
        <linux-api@vger.kernel.org>,
        <containers@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>, <dhowells@redhat.com>,
        "Linux-Audit Mailing List" <linux-audit@redhat.com>,
        <ebiederm@xmission.com>, <luto@kernel.org>,
        <netdev@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <serge@hallyn.com>,
        <viro@zeniv.linux.org.uk>
Date: Sat, 21 Apr 2018 08:10:46 -0400
Message-ID: <162e81d2170.280e.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <20180420204225.iik2lgtj6gx2ep4w@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com>
 <11b43a498e768a14764594c808a96b34d52be0af.1521179281.git.rgb@redhat.com>
 <CAHC9VhRkstDMjd5T3w+iOUDjzDAs1AOm0xd3p6v_xn6fNGYQhA@mail.gmail.com>
 <20180420200226.7tyxzuovdbgclw3m@madcap2.tricolour.ca>
 <CAHC9VhTOYUAyCJidm99som6FVmjouQUGsEHarQ4h_NhwJxQQfw@mail.gmail.com>
 <20180420204225.iik2lgtj6gx2ep4w@madcap2.tricolour.ca>
User-Agent: AquaMail/1.14.2-840 (build: 101400201)
Subject: Re: [RFC PATCH ghak32 V2 11/13] audit: add support for containerid to network namespaces
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On April 20, 2018 4:48:34 PM Richard Guy Briggs <rgb@redhat.com> wrote:
On 2018-04-20 16:22, Paul Moore wrote:
On Fri, Apr 20, 2018 at 4:02 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
On 2018-04-18 21:46, Paul Moore wrote:
On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
Audit events could happen in a network namespace outside of a task
context due to packets received from the net that trigger an auditing
rule prior to being associated with a running task.  The network
namespace could in use by multiple containers by association to the
tasks in that network namespace.  We still want a way to attribute
these events to any potential containers.  Keep a list per network
namespace to track these container identifiiers.

Add/increment the container identifier on:
- initial setting of the container id via /proc
- clone/fork call that inherits a container identifier
- unshare call that inherits a container identifier
- setns call that inherits a container identifier
Delete/decrement the container identifier on:
- an inherited container id dropped when child set
- process exit
- unshare call that drops a net namespace
- setns call that drops a net namespace

See: https://github.com/linux-audit/audit-kernel/issues/32
See: https://github.com/linux-audit/audit-testsuite/issues/64
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
include/linux/audit.h       |  7 +++++++
include/net/net_namespace.h | 12 ++++++++++++
kernel/auditsc.c            |  9 ++++++---
kernel/nsproxy.c            |  6 ++++++
net/core/net_namespace.c    | 45 ++++++++++++++++++++++++++++++++++++++++++=
+++
5 files changed, 76 insertions(+), 3 deletions(-)

...

diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index f6c5d33..d9f1090 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -140,6 +140,7 @@ int copy_namespaces(unsigned long flags, struct task_st=
ruct *tsk)
struct nsproxy *old_ns =3D tsk->nsproxy;
struct user_namespace *user_ns =3D task_cred_xxx(tsk, user_ns);
struct nsproxy *new_ns;
+       u64 containerid =3D audit_get_containerid(tsk);

if (likely(!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
CLONE_NEWPID | CLONE_NEWNET |
@@ -167,6 +168,7 @@ int copy_namespaces(unsigned long flags, struct task_st=
ruct *tsk)
return  PTR_ERR(new_ns);

tsk->nsproxy =3D new_ns;
+       net_add_audit_containerid(new_ns->net_ns, containerid);
return 0;
}

Hopefully we can handle this in audit_net_init(), we just need to
figure out where we can get the correct task_struct for the audit
container ID (some backpointer in the net struct?).

I don't follow.  This needs to happen on every task startup.
audit_net_init() is only called when a new network namespace starts up.

Yep, sorry, my mistake.  I must have confused myself when I was
looking at the code.

I'm thinking out loud here, bear with me ...

Assuming we move the netns/audit-container-ID tracking to audit_net,
and considering we already have an audit hook in copy_process() (it
calls audit_alloc()), would this be better handled by the
copy_process() hook?  This ignores naming, audit_alloc() reuse, etc.;
those can be easily fixed.  I'm just thinking of ways to limit our
impact on the core kernel and leverage our existing interaction
points.

The new namespace hasn't been cloned yet and this is the only function
where we have access to both namespaces, so I don't see how that could
work...

I'll take another, closer look, with v3.


paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635


--
paul moore
www.paul-moore.com



