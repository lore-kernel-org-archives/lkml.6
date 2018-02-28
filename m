Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-438867-1519832326-2-2391966550573586850
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519832326; b=WwrNKKEZAdZq5MjvrlmfyvS2pW8lAlFoaB7VHZhfWUZ3A98
    Ys5r+lr4SWYo1eMyH9N+rEzmsEb827fdftahBquaClZyMHmgWNnc5xIrR6Z8uFtE
    nXXMsRGX8ktEZT2GPgevcrMLf492T3ZPs7BBsEfUixOymh17mA47EpQ16ZxNyZws
    ksl/KG46I7bTVJU0M/Fz/oiwTHj+oreVrSIM+TmjaqaZ65nzCW+sxvli1dVjkASd
    /uCBYaQ4rxqThIA04sPxRcyHSzQLKMPfR+KZ+cGS403Ws9SegF58Ff2CF4JKGrCW
    FXPL/vuFIi/9ljXEKCWcxLHroSx9Io1vFMNVmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832326; bh=8VagLMTB6fDlA7mVVzd
    V6nyBROe677KHHEYB5uqLA4k=; b=Gx3F+tUKBRhAIyoeNe22h5PlsW+wZGBv2at
    oViqc/7cHU5h/JThSsaeA9bultspzPMnOZtDFCwW0xZylgdsRg6qdd2bbDF1xXbA
    1WBpGo6GrP92btRf2mw6JDtANLBi4JLEyDZQubQwg0BqBvvB9p+fW5NSaH0d7DVi
    3cod51rVSPtDmalGyZJMi5VhUNMhT90Uk8ynut7PM2hO0vssdbzFwxwYYL+b9e1B
    +ev0YjsvymcaLfao2uzZr0DyhHd0NKbNyUTuuB/MMTAubDc2mQfVnfT8Q9FIXd/f
    NSJKdj8gbILB5/jB7U0rFvpo4thUcC2nnThKI3X25p+ghnEhJzw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933101AbeB1Pgj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:36:39 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33277 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752777AbeB1PWe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:34 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Daniel Thompson" <daniel.thompson@linaro.org>,
        "Jason Wessel" <jason.wessel@windriver.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.350066723@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 033/140] kdb: Fix handling of kallsyms_symbol_next()
 return value
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Thompson <daniel.thompson@linaro.org>

commit c07d35338081d107e57cf37572d8cc931a8e32e2 upstream.

kallsyms_symbol_next() returns a boolean (true on success). Currently
kdb_read() tests the return value with an inequality that
unconditionally evaluates to true.

This is fixed in the obvious way and, since the conditional branch is
supposed to be unreachable, we also add a WARN_ON().

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/debug/kdb/kdb_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -349,7 +349,7 @@ poll_again:
 			}
 			kdb_printf("\n");
 			for (i = 0; i < count; i++) {
-				if (kallsyms_symbol_next(p_tmp, i) < 0)
+				if (WARN_ON(!kallsyms_symbol_next(p_tmp, i)))
 					break;
 				kdb_printf("%s ", p_tmp);
 				*(p_tmp + len) = '\0';
