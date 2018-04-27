Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524839901-2-16984554384855006282
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524839899; b=kngHeUhV0/A4ld2uCm8976oD1pIPeDepvypM+fpV5O2r+rXJMH
    EOX9C/buuZeFwQKoB0tKNeRQXYnJE2eWdpDz+Vq/fqCT92idNrjo888cJetzKJLe
    dwAsAQ3IyzFdTv3JXBpaZ6+Zx2+lJWC5LyuTIGW/nmWskN5Vh6O1ggFsYnfpuwyq
    +JaGZdBOk4g7MT4WK3qgIiLDuDkPhU8SFyNT6TZnQ4L/e/S78W7bGHw66pCPFs0k
    JCtXBwNDEI+cGdJZaO6Kid/sF/8K7ydGrFQUJtHx+WQIa6S6l4bql3a6iIX3y4Kf
    0y6v2yTzaK+0znK98WKmZ/lfQ7JF6dL7x7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839899; bh=kIsowGFlMMu9ruKLa4aXkSDBJdXE2Q
    64GkiZfwcsZZo=; b=PTfYXaWKVBV7IHiDa3ZcCUpYjf4Kx2zL4QEydeDzL0FKIh
    bUPhZ5jMYXcPQaefXBZo/uAXYqW43szIk6hFugwqc5Fi8z88opgjs40mAtDnSNeN
    1RMsHF7hQaJLskk1J6hJA2uec+XtEUQRV8oIHPVl1SM9cXMkjOoFKhy4ppuYpOS+
    XlQgBAcADLJDXNtpTQGnvh1cSaXAV3fyRe/P4PVD+HShSy9+4ZCy0cHfON/WCpaO
    rpTkLsvEXWf0afIDZSPrhXl82Xtw09YDQpd+vRSKPhOCGVlKxex9Qe2PIUPNnu38
    zCcsHVOksppOaD/SFMNioD5JyIvSxrqkkudNigFw==
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
X-CM-Envelope: MS4wfJw8e4mIO4ai5EnZelN5Cnrd7sOmExCP76kJWbcXAYbQvChjiMgvFSPiHxCjYU4hiHhewdV9HZV5jVZFPH5X63rM7MOwUkJv5SHbkNzLi1fqks2H7hLp
    leq23/Xzx5cHIbLC3WD3EXgcPGduOpG2ZpYfFgoqrsx7gtJ7ZUUmvVlkxCwWjdrFe1IjBhnsGoOOpVLFv0bBw4D+FWisb4jexekLGPocEzSxO+jH/BAXfDBe
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=ag1SF4gXAAAA:8
    a=1WiVrf-x3o_K6fboNOMA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=2JgSa4NbpEOStq-L5dxp:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934642AbeD0OiF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934403AbeD0OJS (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:09:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A61D21864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.14 76/80] tracing: Fix missing tab for hwlat_detector print format
Date: Fri, 27 Apr 2018 15:59:09 +0200
Message-Id: <20180427135736.867705890@linuxfoundation.org>
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

From: Peter Xu <peterx@redhat.com>

commit 9a0fd675304d410f3a9586e1b333e16f4658d56c upstream.

It's been missing for a while but no one is touching that up.  Fix it.

Link: http://lkml.kernel.org/r/20180315060639.9578-1-peterx@redhat.com

CC: Ingo Molnar <mingo@kernel.org>
Cc:stable@vger.kernel.org
Fixes: 7b2c86250122d ("tracing: Add NMI tracing in hwlat detector")
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_entries.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -356,7 +356,7 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
 		__field(	unsigned int,		seqnum		)
 	),
 
-	F_printk("cnt:%u\tts:%010llu.%010lu\tinner:%llu\touter:%llunmi-ts:%llu\tnmi-count:%u\n",
+	F_printk("cnt:%u\tts:%010llu.%010lu\tinner:%llu\touter:%llu\tnmi-ts:%llu\tnmi-count:%u\n",
 		 __entry->seqnum,
 		 __entry->tv_sec,
 		 __entry->tv_nsec,
