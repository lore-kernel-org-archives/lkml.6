Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2839749-1523464119-2-6536526217873504280
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523464119; b=WwXvKzQyKJ3omEEzAhc9sSgyE1FT5D6aHV9hzOe3VrupTaxGuz
    OOV4ZKk9I5IymLQohwbkGrh4zWW52r4FzDLvIVk80LrX+qa7TrVP+Fb116eM4bdJ
    vhF5uE7em/8kBtF0BUyqnrt6jG5XvQ3GamNOLmgmdCYwPHvHFgUUDGHTrTy+NATX
    jNOU2dPhFw60EH/vzVEsmfSJz2bLpV7jYDUj3O4/Ik6BUSBrPWduDPQVcDJW/uwN
    CYG3oxAzE8fFFV+oENGBaUNYCc2Ki8U+VWzZQ0xzxIb0mriGks/HaCRvqv/nXH2C
    FSfdkr1ZmMXkYMmMveKgvY6aSaBISPvNJVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464119;
    bh=WlA3ZJbd0Zlhi5ngVxkV6IG9G9F/L5xAnxIIpgVEqWU=; b=EwGJfoFAkd8n
    7NT05LQ5TyPVeTYq9IyxSivtqasOG0ZdqXjEd81NM+bvWue0PG0jCeMXEtd8PBNI
    dh+Iyf0P3Cp8e7LYrwNXaqYenmsPqOJgY3jdX3QSPRVUTS7XBwOqhTN97jzHygrU
    Dr9CEWP4yipoKfDSiqGWq9dkUxA4p/uyK2VG6nlpNnxQ1+lzqmYnHaKyCl9i4E5s
    8I3tpldL4juoMJ9vcJGCMQVHBtnEabpAKzGHDLCnc8YCV1hJUz9JMKl+HPg03kdF
    s6lUEYpnc+Q2op9HNqkvjBUTIUi+iJQiLAVVkBxX21H0oITfnSVZsDUQWarmfSnG
    DGh9kb+Wiw==
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
X-CM-Envelope: MS4wfBf1QfeFieNxHqJjCuprThjjk4qwzTpD6ND6+MfB6wKVPKbWlet/wC/YSqEzPPXgoV8IIsO2XX2lJRk4SPUdly+YLc8oWqhzuPc9FT9qCQcFn+iYp3cL
    hdVUfLuAg2Rs6en1EIE+s+PYMXdZpXhGQdg7/5V86IiGZy+S/xN1VpN3t62pP+ibhITauqDz57lklCqsloqtulV+n1sgtL0u+WhnUXVte3YVevQ09g1uQ0Ju
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=b3QJYkDzAAAA:8 a=20KFwNOVAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8
    a=OfGukBzStP2QZZTYFSsA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=ZYrClHXAzI6hOjfCDBRe:22 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754231AbeDKQ01 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:26:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753967AbeDKQ0Z (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:26:25 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 16/24] Prohibit PCMCIA CIS storage when the kernel is locked
 down
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:26:23 +0100
Message-ID: <152346398340.4030.1885177506676553618.stgit@warthog.procyon.org.uk>
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

Prohibit replacement of the PCMCIA Card Information Structure when the
kernel is locked down.

Suggested-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-pcmcia@lists.infradead.org
---

 drivers/pcmcia/cistpl.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index 102646fedb56..e46c948d7246 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -1578,6 +1578,9 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
 	struct pcmcia_socket *s;
 	int error;
 
+	if (kernel_is_locked_down("Direct PCMCIA CIS storage"))
+		return -EPERM;
+
 	s = to_socket(container_of(kobj, struct device, kobj));
 
 	if (off)

