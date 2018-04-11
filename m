Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2791443-1523464186-2-5789028912825790133
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523464186; b=svF7dy7CbA/mNqp3fCPfJYBv9jvEK5K1DyDF/fb1HSd+uRq6p9
    w1FWoB5hhJ4eAAfaNNEEhrVOpkTNkq3+GfmbwnvLpaoS5V2TgWb8uW20H69z29Y0
    A2b2Da+ox5w3Wf+1sdjoyRxuDi0elWAEkr0reqAPjK7DK9tr2+FEt48KLOsQJmlR
    eZKrOABRXEs7P6tHGvfZqLA1TDKbNgTBUtnPDDl6mIdB/yw7+S+ohb1aEeXj1byW
    X7ayZ49VPsOmsl8NFjawlcrgqv+kzmmVc1111tOGRmFp7goaN1h8n+LS3BlS6ceK
    fMU6a+zW1V51ap8p9Aiqnxw9Ry0aIoK6w4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464186;
    bh=0kd3EiPjZUKsGjBR7JalkceCS/tpAXc0Xx+YtCEaiLo=; b=eNT4n99vjiI9
    sK+uRpzkQ22zKIvwAlNACGZrtap4IioS6DWph5XyvK9Zk6Xkoh8PJT6TLOUL1fcG
    rNw+O7uPyfp+9BrNJAEQfsCAsINtWrHTa8a0nA3Y5+cLZ+cE+OGMgr02gbfi+qND
    VJO80UEg9SO7XBaKgMAA33Lmmgz222gnjD5UwmBVe+89shnTuRck7/Ch2Q58Mcpl
    umvllsgso2tfX1yBQTAhPOBFe24dvDQboAV9uoIhI6KDoRgFm1oWJUFCbYOeYpCk
    M03HISoPw7uCW+zoGbTErFIYsLu1mniKXAcarLdpHaH2xJnqiF277KKzei5MVmgr
    AXHi2nX2nQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMxY77xRa7GobmOEIpDfK11mrIg2GQFVXucKCC5mOdEstu3voUfzKBwlRaPDz6s9mQUMteFrFZmm0Rkd58hp2RM9LCPFphaLS8ymksGeq7hC49NRGPOF
    0Ltb1cpLBatMRaGer84gWjnhfE+fSZEVlXC5dfS8SbyCFYB1mE8/UrTFPr+9nK7NVQ+RPr4F1K+ddW1XkTGLg0AWBJZ41fNQctpf9D0SsGMkTyj3tizoEnOq
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=9Rt4o3Z7AAAA:8 a=20KFwNOVAAAA:8 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8
    a=VwQbUJbxAAAA:8 a=38ZbNfqcS9544tlXEXsA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=jE01AiZSAJ7eki2zvjzZ:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754089AbeDKQZf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:25:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752804AbeDKQZd (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:25:33 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/24] uswsusp: Disable when the kernel is locked down
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:25:31 +0100
Message-ID: <152346393165.4030.14932574511330889453.stgit@warthog.procyon.org.uk>
In-Reply-To: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

uswsusp allows a user process to dump and then restore kernel state, which
makes it possible to modify the running kernel.  Disable this if the kernel
is locked down.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
Reviewed-by: James Morris <james.l.morris@oracle.com>
cc: linux-pm@vger.kernel.org
---

 kernel/power/user.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 75c959de4b29..959b336d8eca 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -52,6 +52,9 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	if (!hibernation_available())
 		return -EPERM;
 
+	if (kernel_is_locked_down("/dev/snapshot"))
+		return -EPERM;
+
 	lock_system_sleep();
 
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {

