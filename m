Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1387311-1523019813-2-15801463995368352954
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='ISO-8859-15'
X-Attached: 0011-vsprintf-Do-not-preprocess-non-dereferenced-pointers.patch
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523019812; b=LdOifDMMwc/bEnih232lk05GFFE2iOyzgAs4LpaQ4XURlD4CEm
    PLBTm+IqqJTDgJzSjTfxbm6I3n4TkRv+YJrz3Z9Ciqkf+OVxk+P+bipHTiMeTDiy
    8rTwHjXaAzqrnImtjiccfV0pAqwBCN+/+B0J67JSzUF72pTQ7nxVeO3JlMq59VnK
    JNzPICHPnpSjs/QoO2v57exP31OCeMQw9YWBIMkpY0QNQbfqwNWGIE0MPrM/njDE
    srxYOgQihegKxzSD2q8v9V1yIetEA2vcubZPwR1y2TlS8T96LENF3OEFGF2UVlGa
    L97k3p7SdJqPoPjp9RqpiFkw/xOvEv85AyGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:mime-version:content-type:sender:list-id; s=fm2; t=
    1523019812; bh=tLLc99fTyiBjSkQAqAh5g4JnoQubH+Uw3nOxad67DWA=; b=i
    PyQqUWn4cp+/sWjawA6nrqoYnquqol//n4RLbgsAsmZyCzEmdRTBKfWHRL/D+sV+
    VZDBjDjZE2LUEWKBBAuuJ/aX1GlPLoeVniIQ6hP46XSC15p+g2J5GMlQA8+s4tnU
    8d7LJfL0RCVO/jIgp07gly1i9kaJEprajPI3gUFHB5AboNzJOJ6u9dDp9rTWIfQA
    rIWkJH+rT+dKiJlGjPoP4Y/kqWR4VIr6wDK6ko5HvtMIzfJ30mUv3XY47ndlGdkW
    5M9hedpBFYXXNSeRYCn+iX5oje/LzIN9UFgL4QQGa3sCFbQSUfVcNC1eDYwlDn/C
    t7RgivkfGD15CY3g698OA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHYBV2ag9pcEBi+qwIYxpDRL9Zt5c1kDZLZ7t8IqG/Q9VpME2fwUq7da3I0sLA8EnDoPaFuwDjGOTCRKlPErVcBCGKQ72BnkqsjYznLKmdT607bbLpiq
    yd3jdQ3G3lVyvDq5vRD8mrVLkWk37yNXbYFBhyNXp3Q2KKeQ7SsiXIsNgacByIDf3B4yMN2Ff8CR/Zh4BteNHETXhOiAPAh97DxD/udLgO8+z78gnIMN28HT
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Q9fys5e9bTEA:10 a=Kd1tUaAdevIA:10
    a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8 a=NFQ9U7m0sfmIPZhrh8gA:9 a=PUjeQqilurYA:10
    a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeDFNCZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752737AbeDFNBP (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 09:01:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C1321834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180406130113.385364052@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 06 Apr 2018 09:00:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: [for-next][PATCH 11/18] vsprintf: Do not preprocess non-dereferenced pointers for bprintf
 (%px and %pK)
References: <20180406130035.400292196@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0011-vsprintf-Do-not-preprocess-non-dereferenced-pointers.patch
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Commit 841a915d20c7b2 ("printf: Do not have bprintf dereference pointers")
would preprocess various pointers that are dereferenced in the bprintf()
because the recording and printing are done at two different times. Some
pointers stayed dereferenced in the ring buffer because user space could
handle them (namely "%pS" and friends). Pointers that are not dereferenced
should not be processed immediately but instead just saved directly.

Cc: stable@vger.kernel.org
Fixes: 841a915d20c7b2 ("printf: Do not have bprintf dereference pointers")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 lib/vsprintf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d7a708f82559..89f8a4a4b770 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2591,6 +2591,8 @@ int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args)
 			case 's':
 			case 'F':
 			case 'f':
+			case 'x':
+			case 'K':
 				save_arg(void *);
 				break;
 			default:
@@ -2765,6 +2767,8 @@ int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
 			case 's':
 			case 'F':
 			case 'f':
+			case 'x':
+			case 'K':
 				process = true;
 				break;
 			default:
-- 
2.15.1
