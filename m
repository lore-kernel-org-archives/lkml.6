Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524840334-2-15161295521990391952
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
    1524840334; b=GowZbXO2ODx6Bz8QMmhrYXWroPXdK4x9XFOiUGiwzTLITK0HhU
    SR4KJLTgE1ZDohGvuxsBTSATzw6Qcqp6WScEvb2ICQhUcEDdFOq9lXYb3f+OslFE
    gEZnUE3kAIYjZNdF9b4HZ+WVWDm1Fx1S2+CG1v36eO4wMykdg+0bkgK56fOExEeY
    WewqDqmD5z93mwWQvX7iQUyCdJE6oObW+AU2zcikVF4f4S34fO1v13v/ydhCjueq
    Qp8zwWu7k0ic6AIbMH8H/OtMoWfNnnVe+MQA27b9BgB6O3zfzyNM7mthbMJ8W4U7
    ioTU4sP11pG3aGWWRJOiHYxcAkHdUCt26IjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524840334; bh=Hvw8CQUkRFbdIkEZxQMW9uXmgDHU0w
    lRkN/zn+nvax0=; b=ddQEgMH6sW2WtX0C3pxf8hJIp26r5nbxsCO2aPgerQ8BA8
    49GQBlwhQ6pUGiQpWTs6HurI/quL4u/9FvTtFJnj0wKUeQjvIGS61yjNiPBU8lIY
    o0OknqyX1wM1r4AbzuOiZtPawr5xHaE5dI1h8EsrxONmNxiUc4TxNsSXTMtn0bQ6
    1e3hWB5UKwa7+HUkQHFhO7HOMYATspUDgcikjywTHu7FZzz/t+gORtO/K6nsexcO
    XEkdgzbDv39GVrPipqZRkKHzDdFZSADA2XQMSnzF2iXQumNN2bcKmL7aHE1Ffxjg
    6Ulu2hAAy6F8iM3X9sx3q9fxhxNBWxCQ25kc92gw==
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
X-CM-Envelope: MS4wfJ2AC/5MgJdm7qJTLVeX9EXD8FeM1Ofnh3Sm7SSfLH5JIgCSR6UrcG6Q4RQpD/50bsfj4E+Re6mWdbV0ihq0CCa9micKvjtmrhWlw7ir6q8ZrGzTqorQ
    CVCWz++Ihoj+GP8WDwDXn+laUlnBc7HMy5nwSGx2BbfRuridOLbeQe7cVMbHIQgjWvYndtfGAI6TdOF0T3W7n8kIykH3kFsb8JvlvhK8BXq2nDrED4rLYIrd
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=XyMwAGQSYJT2K2sAP5MA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934457AbeD0OpS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934441AbeD0OIL (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:08:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C032521864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.14 57/80] s390: report spectre mitigation via syslog
Date: Fri, 27 Apr 2018 15:58:50 +0200
Message-Id: <20180427135735.841535906@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit bc035599718412cfba9249aa713f90ef13f13ee9 ]

Add a boot message if either of the spectre defenses is active.
The message is
    "Spectre V2 mitigation: execute trampolines."
or  "Spectre V2 mitigation: limited branch prediction."

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/nospec-branch.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -33,6 +33,16 @@ static int __init nospec_setup_early(cha
 }
 early_param("nospec", nospec_setup_early);
 
+static int __init nospec_report(void)
+{
+	if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable)
+		pr_info("Spectre V2 mitigation: execute trampolines.\n");
+	if (__test_facility(82, S390_lowcore.alt_stfle_fac_list))
+		pr_info("Spectre V2 mitigation: limited branch prediction.\n");
+	return 0;
+}
+arch_initcall(nospec_report);
+
 #ifdef CONFIG_EXPOLINE
 
 int nospec_disable = IS_ENABLED(CONFIG_EXPOLINE_OFF);
