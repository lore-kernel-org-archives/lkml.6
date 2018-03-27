Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-195729-1522173532-2-7690452208107439935
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522173531; b=aUu6QdpoHReOnnyIZyaYOyd740W8YDcNKJ5DReWQ9k+kQmO
    phZ0oXe/RBIZmRvkPssYaAGnInFxYW4aKPUz8PPnoJ/UAj8xlniF1EwYB/fGzN0o
    HVpX3AeHeScM7vDZ7cS7V2yksnLWVHOnBJlNeWTLxY4yg6qZXM2FplZqO2PFOiKz
    wWJLMFJret3sEC7RCMksXx9Tgdqid91HaKywRN4+mApTOBPY0lFGMsOnRv8Bo6qe
    aEvF6obJiyFnFj7YMBPeW4J1P7gRLofvU83LRZ9oDp5WNaBVL3RRgqq1pYGf8tHP
    WdZrex5MZPcUFPGKEGTbohHw0k7JjB3PHYBmSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522173531; bh=QfkhsSbC2ozTI2aSZVcOj/zGRP
    tLzYKl+NJi2po1Ov0=; b=KFfp641Ikvpkq4UHn2GEUHn95+tLuHMJZPA6YBkXKQ
    H8owxMUcS8md4cqeoaA0Y86TgNtDz2Zceo3YiHHNa5cKmNj4O8Z2/EAta4Nz7UdY
    IraMjF5vg9NELrtnEra11o7GmhTCjX8MV6H3f/eKk90JnJ1sFGi6kljkU2WSY8qn
    B4VmlhvAYZVuAO5fAJu5U9ZIdkfgnE11kTidKRpVJv2qRi5/PP2a9pNGtKz6J4De
    I9A1/yOm+ZZoP/jWfq0eUYYrdamYqqBWBvr/rlyqR3pYu76+Zo6kFGK7LFPw7Qi5
    zOsowYYaHnyUhrs3rV9mVOxsb4qsZSIB6cMTgIi4pAPg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDLFxkjcxTN0XN0zw8y2KFAZp0uKf8hREbKSVr/Whml29Wsh4jVI0SHFllOFo3075xOoIHGEMyuYKLjTdqUwGoa8R0//hr8Zip+6SQPkVzgmPK3ZiZnd
    zs/Gl6IxnLAol8aggJclwRoqm4NzdXK44+rgOKjxrGvl7PihG4XwmKITEm9w2Wxw3FIosBAtSDsQlwf3rKGJNfHDoR9CSznS4wE7grwVz5X7iP/KKvNvEaVt
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=1XWaLZrsAAAA:8 a=hWMQpYRtAAAA:8 a=ag1SF4gXAAAA:8 a=wSEHxrgEdzogoj8pM7IA:9
    a=QEXdDO2ut3YA:10 a=KCsI-UfzjElwHeZNREa_:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753095AbeC0Qae (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:30:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41982 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753090AbeC0Qad (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:30:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chenbo Feng <fengc@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.4 42/43] bpf: skip unnecessary capability check
Date: Tue, 27 Mar 2018 18:27:46 +0200
Message-Id: <20180327162718.745862535@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chenbo Feng <fengc@google.com>

commit 0fa4fe85f4724fff89b09741c437cbee9cf8b008 upstream.

The current check statement in BPF syscall will do a capability check
for CAP_SYS_ADMIN before checking sysctl_unprivileged_bpf_disabled. This
code path will trigger unnecessary security hooks on capability checking
and cause false alarms on unprivileged process trying to get CAP_SYS_ADMIN
access. This can be resolved by simply switch the order of the statement
and CAP_SYS_ADMIN is not required anyway if unprivileged bpf syscall is
allowed.

Signed-off-by: Chenbo Feng <fengc@google.com>
Acked-by: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/syscall.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -673,7 +673,7 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf
 	union bpf_attr attr = {};
 	int err;
 
-	if (!capable(CAP_SYS_ADMIN) && sysctl_unprivileged_bpf_disabled)
+	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	if (!access_ok(VERIFY_READ, uattr, 1))
