Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519833269-2-9509078606678098494
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
    t=1519833268; b=IiK/QZFvRrZH7ND9SFYQz854qgnfZlqt1tZJb4euwqyGcao
    gblBfi6Zd3p4N+PkzGHSiEdVIyf3pJMhJkF2jUcK72ZlF5DorUWtCYRkZSn5YnhZ
    NlWnHrcWCPVwr8K60fk/DYvzCbavg2dPORFJ1SkR6kG1sUPL7y6mOWTqCfK2Zzaw
    R8Z3crhQ5XeHHpbIaYlx7IfUHHAb+DlXzy45aIWSoJZwlrpoqF7gTqP+ObS0HZ0p
    REXlr5nPZHnOEq2PsV8tr46s5yv3dhBaaQj/Qmeau72e+tHbzTxpkuEW1a+xawbD
    X1sW/ctL1Ou+SYZ5N1zFRnYaPslz9FsDFnKUSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833268; bh=bPsH81CTLd2Ze4BrH7W
    aplYfJ2LSB97QqrHMjVV8JO0=; b=uW+eg+3QxlKp0KSZhl20l8qC2SV8mlx5jUH
    vYOqBQUB6w3/p6j4kn46FZ7sChiimUJ7qzmvt/6BRlR+DG+GQrndU1c99i2o2+Je
    PdZCcsG1jnQn4e86PUr4BvabhkjqxNEPJGQT1U2ws83O7Rp3lvLaI90VYTuPC9VJ
    Ix53bOPYyUr8m3M+HJNEM14QdwboBSDdcsKA9EWx+p5Nk4PN5hlTJ7/doR0cLDTf
    pD77uMuk7i+4qtKQDJB7/+VvtSPIUQyBNM4Nt1d5cBhz/+2CT6m8HsvGnlmBwThC
    Yuoa+5KR68GkeXq6EiYZycNiEm7JwLdkHGus7ATlzWaaEzDtPNg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934031AbeB1Pxd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:53:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34458 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932678AbeB1Pxb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:53:31 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jerry Tang" <jtang@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Takashi Iwai" <tiwai@suse.de>, "Borislav Petkov" <bp@suse.de>,
        "Kees Cook" <keescook@chromium.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.540430918@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 121/254] ACPI: APEI / ERST: Fix missing error
 handling in erst_reader()
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit bb82e0b4a7e96494f0c1004ce50cec3d7b5fb3d1 upstream.

The commit f6f828513290 ("pstore: pass allocated memory region back to
caller") changed the check of the return value from erst_read() in
erst_reader() in the following way:

        if (len == -ENOENT)
                goto skip;
-       else if (len < 0) {
-               rc = -1;
+       else if (len < sizeof(*rcd)) {
+               rc = -EIO;
                goto out;

This introduced another bug: since the comparison with sizeof() is
cast to unsigned, a negative len value doesn't hit any longer.
As a result, when an error is returned from erst_read(), the code
falls through, and it may eventually lead to some weird thing like
memory corruption.

This patch adds the negative error value check more explicitly for
addressing the issue.

Fixes: f6f828513290 (pstore: pass allocated memory region back to caller)
Tested-by: Jerry Tang <jtang@suse.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/acpi/apei/erst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -1023,7 +1023,7 @@ skip:
 	/* The record may be cleared by others, try read next record */
 	if (len == -ENOENT)
 		goto skip;
-	else if (len < sizeof(*rcd)) {
+	else if (len < 0 || len < sizeof(*rcd)) {
 		rc = -EIO;
 		goto out;
 	}
