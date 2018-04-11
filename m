Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477450-2-10179382327425196555
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477450; b=L4HMZKrSfxGu8A8FUx09DuDYCErkDxRJQrGkiBV6lc5QxIYBs1
    HQ/MqnQ/lX22SzMPLElmiuwUJ50xeTe00jcTgU/dxSlmCMCgvMwn/URJOqUO39FN
    9alnP7QBZcqAI0kWqcJb5wkTlrj59yRkWX0ll5Y0Caaz9R0PEEly0F9BOBaoGjX7
    zO7YjtXYUe0O/0ofqy6KASLMhSn9UsgLFKmzONYYZs+nKT19Noer7XtaTsayx+D7
    UrGFtOefxFjSbkVp+Ay2J/oFMdtX/hJGbVtQdwz3bS7q9ZPM8HoCfuZ1i9tQddT7
    m5FYV6X8A9rojymch5yFVwIJYRNnWPVGUb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477450; bh=ZE5foLi+/0Ivobp6c6jIWsWpQF8UJQ
    x1YfMljfbJcAs=; b=as2IBHCZfLa4WIHnVLygCZAkwf4cyoOjuEHTbgtY8yMGTb
    jvRAOhCu6tobvuFTd3OWf07IcYbP/6qW/Fiw2M1HQ2tfRrG2xmOJ3vqxlMyw5WIh
    jTRkM+a/a/yoIercKdTAV6HfSTLbcE1qH7FbMhylb1jESz1fwAOS/yjIfSaG945m
    YraHTcPbp6Hdbpqs9LOELOuMd8ql4SCPgaV/OKWu8uX7deWY2cIrxZT98uziNCz1
    MlzN1lL0sXvqQxViJ6GmbOKzRYLZyxc8Ir76v9eNZwz8+WMJ/aFZsNdcQe961vLM
    q/rj9aKGyjkbQ46u+qdWhnpOSp5k4UcPG6YyIftQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfHzWZeXz/r+NLkHYdU+aEmm1BPeaH5fowDGGH6yzZYF8wDRswhzwWPxg5W5f1xVDpaqwiJym+zPa8YwSCmrfRX3UGkhfLyRd68JAyiHDNZF7wGyP8Iun
    pAmxhCan5hT4onbOyLFTqNB3hMEBPsAR5apE/qJ15ap3rdi2f74SL1hHqSKaQjrH4YV8NnumvV1cp3qb7Kadt1QyIWSAwqjOyUG/OCeVwqzDiACYQ1E5MoPr
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=JfrnYn6hAAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=xFwlslFXJhO3HYaR-E8A:9 a=QEXdDO2ut3YA:10
    a=1CNFftbPRP8L7MoqJWF3:22 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933504AbeDKSyb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:54:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34520 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933503AbeDKSya (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:54:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 047/310] x86/tsc: Provide tsc=unstable boot parameter
Date: Wed, 11 Apr 2018 20:33:06 +0200
Message-Id: <20180411183624.275257753@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>


[ Upstream commit 8309f86cd41e8714526867177facf7a316d9be53 ]

Since the clocksource watchdog will only detect broken TSC after the
fact, all TSC based clocks will likely have observed non-continuous
values before/when switching away from TSC.

Therefore only thing to fully avoid random clock movement when your
BIOS randomly mucks with TSC values from SMI handlers is reporting the
TSC as unstable at boot.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/tsc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -366,6 +366,8 @@ static int __init tsc_setup(char *str)
 		tsc_clocksource_reliable = 1;
 	if (!strncmp(str, "noirqtime", 9))
 		no_sched_irq_time = 1;
+	if (!strcmp(str, "unstable"))
+		mark_tsc_unstable("boot parameter");
 	return 1;
 }
 
