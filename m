Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523021487-2-2336574123987354091
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021487; b=D2C67+AaP+9YX03kdp9XrDY4Gk3/LvBLRPggCPJwuYozIrWrwV
    wiZ82wd8xl7jbkiUAN4qTez9t0ZZTxjgu67+XkBV5SyKmj97dfWJZ+7TcrhVoUci
    o9tNRe3b+vFGLHaMjdkus+0VGWlCpMsk+KxMSSnp7VB9FuKrV6SRUZzT9bWccYF/
    TZTj6xd+ajzmJeFT9mLZK3pMNE0eKKgab73tUk2Lqxv/Hqq56QlJ5W7fVebGeNGy
    M3Fl9WkfK/1pbXkIrDqc2/U5woZRhwAO4N3LOUzSzxPv6vhcnpSAKJ9Fdby1bL/E
    rQu3qQkfFtAXmc3CU66gfJfYPNbwYwMAF91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021487; bh=6Pv7pLhTBUT+Oy+X5WM6JKm+tKuGM8
    RXqg6NCuY6+xw=; b=YYMOxyWcQGJ1DH7UL8NfxJGUJFOqH9J11gv4mvT0VhDeQ3
    BpjnsUdf23rktzFfqqTHy4jVh56FlPp80ZYnfBWc6Gtnc0NoOJTpKKs0+u+MMwsB
    ecgF/9H2erLxiBjyWeoa3tZWZunZGDKe7CHVSPAHLc0rnN3yaIWxpsqLpRuEgZje
    OZmmXDVE3HFF6dN5IWiWDV5ZZSBs4u4mlDdC0q9qVaH9U1nOWGlThjtTWX01oYNn
    TH4KNJoYB7xEZxSkcZaxnWsXJSFLAuEtGoXF6s3zFlz/7tP33glx44+wS6lip2GL
    C7zh0swp+U9XQlWQQUe6FmGl4dHLxGwv3oQBLtJQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfCedmsbg2FpT7CQ1dp++Ma9bDaIoa8wYY/saLzgIPT21Se0fCriYUVcR1/ptoGHochcUQ5RG4lMeajHJ2tJLxDH8gWjQrCScCpDHLQISTkWAqWWZSlF0
    Q7RtCa6Gls4iD8THCLBipeHntUCRilxOLx9JnTSIZqU90sq5iPKCl3rCUqzG4ehQYTm1Bl4h2CQapXWhhM7nGGj5sqKbGV46s2MjO0JuVZqbrn6HiWswHj+O
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=Tty9oNO6AAAA:8 a=1XWaLZrsAAAA:8 a=Z4Rwk6OoAAAA:8
    a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8 a=hIIM-oSruWPZWbErBs4A:9
    a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22 a=Bts-Es6F1CBXvF7u4C_G:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755115AbeDFNbU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:31:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56420 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755084AbeDFNbR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:31:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Grant Grundler <grundler@chromium.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Greg Hackmann <ghackmann@google.com>,
        Michael Davidson <md@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 18/72] genirq: Use cpumask_available() for check of cpumask variable
Date: Fri,  6 Apr 2018 15:23:19 +0200
Message-Id: <20180406084306.580335855@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
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

From: Matthias Kaehlcke <mka@chromium.org>

commit d170fe7dd992b313d4851ae5ab77ee7a51ed8c72 upstream.

This fixes the following clang warning when CONFIG_CPUMASK_OFFSTACK=n:

kernel/irq/manage.c:839:28: error: address of array
'desc->irq_common_data.affinity' will always evaluate to 'true'
[-Werror,-Wpointer-bool-conversion]

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Cc: Grant Grundler <grundler@chromium.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: Michael Davidson <md@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/20170412182030.83657-2-mka@chromium.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/irq/manage.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -836,7 +836,7 @@ irq_thread_check_affinity(struct irq_des
 	 * This code is triggered unconditionally. Check the affinity
 	 * mask pointer. For CPU_MASK_OFFSTACK=n this is optimized out.
 	 */
-	if (desc->irq_common_data.affinity)
+	if (cpumask_available(desc->irq_common_data.affinity))
 		cpumask_copy(mask, desc->irq_common_data.affinity);
 	else
 		valid = false;
