Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3862925-1523498143-2-11570852205205322573
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='ISO-8859-15'
X-Attached: 0003-trace_uprobe-Use-lx-to-display-offset.patch
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523498142; b=CcGWhgUEHPhv0ftjT5Fd46LqXIDpq+Sgmd9re/Ce2I2eedgeAb
    7FExceVWWAjr4pUQNRg3mnqPNiw3kbQ7tlSuHmg5kEjK1OoS5Wr47tEGYyktDY0S
    wu3nzKiTUkg7vW/BsOJS7kyDmTOe17pg/2KhyW2G+fx/Y/F+DQTTsJeWBOMfi95t
    iXSEify6sStkiLPKRVpk9WYKb5kZGDWuc9pYsQjwmSSAtAIWrpV9FN500aLLmqrO
    1h9XwScOSjeFJwrVGweP4oxIPXP3/Oolq0JQnZNRqNVRqODQ9YyStOW3mtKmDTm2
    MZbORQDC6RDzWBBE1ix77KeCGQDB6i2zg1Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:mime-version:content-type:sender:list-id; s=fm2; t=
    1523498142; bh=GiHhZVQkIt7mQDgHXg6oD89AcCPBoRdSHQ4nlwYTpsU=; b=o
    BsLR/mONCavmQCTHekna3Uj//WIEmPwpH/SiCx+3rhnyzfCs9BeHs/w18XoqJhbv
    jlV5BTNSXUagysa1GKX2g5m7TZ+C3ya2lHAEY5WE6TnI7a47eLCfnV6wkwRguXEd
    OVgeina4VCVJdHzzw5Tzea4wzpnULZebfWN7VplRTqQKMxZP7VGvY+IjSxukZDCh
    +KG4xf8mv/l3hxN/QJ1bnY6lcIdATs5MGkmIOqioHUzbGaXGhl5Xol8Xb2634wQH
    U0s5Xlt+wTPRJd6e+WXoOSwNr+cn/g6dh+ubv0ezgmtKUohSMXPKIbSbNWEwNsyd
    BNXmuldHO7VRJUHzcHQ8A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfJ/6zKsBi65Vz1leKnXujkHi5CejlubULjrl0zRN9ZlQ0MK9kIB6Y8qq8VhEaQS4J68sbvBGeIqnBaBUpTzPvt/8UITDuQVFPpXHn/K9j7WESLJ5F0GE
    bG5wPYEuG9EjMRh8kDCkn7I69KaaVFimwkC7lxoBUUWqhSqwqOUQP0BDQ+JgUvZSCtmzbn94kLHE2uLdM23cWwULRGK5LWp2NNyn7Ug0WT+G/282PpNhC3GL
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Q9fys5e9bTEA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=meVymXHHAAAA:8
    a=Ne_ahmRzJ9bFwMNgNUAA:9 a=PUjeQqilurYA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=xmb-EsYY8bH0VWELuYED:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeDLByn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 21:54:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751845AbeDLBym (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 11 Apr 2018 21:54:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF838217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180412015440.763923904@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 11 Apr 2018 21:54:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 3/5] trace_uprobe: Use %lx to display offset
References: <20180412015359.244491749@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0003-trace_uprobe-Use-lx-to-display-offset.patch
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

tu->offset is unsigned long, not a pointer, thus %lx should
be used to print it, not the %px.

Link: http://lkml.kernel.org/r/20180315082756.9050-1-ravi.bangoria@linux.vnet.ibm.com

Cc: stable@vger.kernel.org
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 0e4d819d0893 ("trace_uprobe: Display correct offset in uprobe_events")
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_uprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 8b86d76c55ee..d7d3c9237f64 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -608,7 +608,7 @@ static int probes_seq_show(struct seq_file *m, void *v)
 
 	/* Don't print "0x  (null)" when offset is 0 */
 	if (tu->offset) {
-		seq_printf(m, "0x%px", (void *)tu->offset);
+		seq_printf(m, "0x%0*lx", (int)(sizeof(void *) * 2), tu->offset);
 	} else {
 		switch (sizeof(void *)) {
 		case 4:
-- 
2.16.3
