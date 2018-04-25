Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-558212-1524653073-2-4185848786566949348
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES daen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653072; b=U71QQ2hSSnIAvLRmqLYVMRr4k7tyEl6z9agZEpjA9u/VR7WuTQ
    VSsdLKY3TyWRuO865vRouBnFKADq4F3xLo+Rz6Q5IF/lQNykKYL/BbD6jJja7EKP
    nzqIQ4JXqFeC5vLKs05A0S7SJ6wnWDN0teiggUdjhdSKM7FyrfqP6dU6Duvpp+aE
    ee46sUv8KYs5ydkdNm+fEMB+gdZ6965YJc1MEiNV/e1qOqTrKRUO6NZoO6v2fAaN
    FofWRXl0MQdhRoKn6I0T6MSMOUTlgHl6vMgquRJIyFvWbQxfjGNmsOqoeIyMBIqb
    BKbyRw4Du8V02wW8if3DWczHl+Zff1Z2e/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653072; bh=drlntcuTymZJXwbcI85YIY14MExcpz
    R7upshc23f8y0=; b=nrIGjskTSLhIhBcHImWjjvBrI2ZUE9wSyk7EOTE7l5fv68
    2DjO2yhL+IfxAl+fbt4wclN2TLI2B0qcfzF1x/3EjchZ/sUlvVYv3jQMX1FKhUND
    a1AMTuyVBLih2cei+/MxwMvWn1+VtLIJRHVU6QPxR/awG8U3/P8ff6nbOqS0K48A
    ymPXhr1rcoL6ygG/OjWcOUK6uRoRCA2TKDBC4QAJZ3I6gDKabWPv51JvPL1g5CJQ
    N35l4hEZcuGv/Gpd90cc/QbFykLV3nE3ksIPwi3h9Ok8Tv+H6Gdk1GkUwEZ2WxUB
    D/TFAQJxeFNu6mudWmyJ1ZXaLkUuZSdaLCb2vncg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfJYrGIbYxzoJ05l6EPxNIDBntjgMDC+IL0rr0Fe/eJl277YE8nTuJo/ULV/C/4HvS1A6PbcYu18Q2czR+qcmnq58PG6BREoVHwAiC97+EwoQkBh0qMbd
    ohzm36o4XZkSeSwh5HzcZrDytR97wVgjADBruJcPZIGjP28HGGe2hYydyaPb0PcD6yilo03prJDv1N/M2ijzeUo62+4sxaktA0D82iqFSdDILJgLcIk6OPoU
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=UqCG9HQmAAAA:8 a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8
    a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=30ouwem8p7Oa7RGj-EIA:9 a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754375AbeDYKo2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:44:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53308 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754340AbeDYKoY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:44:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <fengguang.wu@intel.com>,
        Michael Kelley <mhkelley@outlook.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kys@microsoft.com,
        martin.petersen@oracle.com, mikelley@microsoft.com,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 170/183] cpumask: Make for_each_cpu_wrap() available on UP as well
Date: Wed, 25 Apr 2018 12:36:30 +0200
Message-Id: <20180425103249.347516890@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
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

From: Michael Kelley <mhkelley@outlook.com>


[ Upstream commit d207af2eab3f8668b95ad02b21930481c42806fd ]

for_each_cpu_wrap() was originally added in the #else half of a
large "#if NR_CPUS == 1" statement, but was omitted in the #if
half.  This patch adds the missing #if half to prevent compile
errors when NR_CPUS is 1.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Michael Kelley <mhkelley@outlook.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kys@microsoft.com
Cc: martin.petersen@oracle.com
Cc: mikelley@microsoft.com
Fixes: c743f0a5c50f ("sched/fair, cpumask: Export for_each_cpu_wrap()")
Link: http://lkml.kernel.org/r/SN6PR1901MB2045F087F59450507D4FCC17CBF50@SN6PR1901MB2045.namprd19.prod.outlook.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/cpumask.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -165,6 +165,8 @@ static inline unsigned int cpumask_local
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
 #define for_each_cpu_not(cpu, mask)		\
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
+#define for_each_cpu_wrap(cpu, mask, start)	\
+	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)(start))
 #define for_each_cpu_and(cpu, mask, and)	\
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)and)
 #else
