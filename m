Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518323906-2-7795432501301739294
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518323905; b=ZtOGD5/VRFE4Ic6L9Ep0t1NeN5wWa0VvelKywsSoIcgSeOR
    vqNkM2mzWW8RiWP9AOYLHZMr6FdOTp2zagvzpH4n3WO2d+Ai0ANS1uKlnOj1M/UY
    Q9oj3wTH3MxnNgTT/MHJ47Ct0rHSX9CeohNySYxn1KBl67tug+F7K7OvpT11vP97
    QmNH7NEnVQ5jT9HKvN7GGQDobOALlPz4vZPj86Y1s1jG2sy9gRMyA1HjOAEn07Ze
    0hVtpjQnPYswfm8J/gKrg+MH9J53y7C4+Z5rob7Z+HbvOOL8jOUMjQRN7aHQcm8n
    DRU0gx3OSM+BXez9zHXuUPdjs6YQWHH/gAyp2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323905; bh=bzW05FshcNxgsl347en
    GLz6Zu6fIyfpy/YXkgJjaawg=; b=N6Jqum1ePQlDxHlpPkPLiDWruvdCKStR+kp
    suowJrAV+28vfyyYgaoXyWlU3+pDOjSJd88Co3Ay96UPuSmYJ07/Mv26w7JraXS3
    7EvLfVrWMPnRC8+F88ZN2q5qj1/qMCLfcVur6vey4RlswF1onMc1t9i25T/nHtkI
    jCF1wDTd0rh2wfs0c4Y5Z1yGgAlu5uTf57OX05G5vwD9no/v5GgqZMOo9UngTzHt
    4LB8cK1obLWLHIPVberG0eAKOHSnCG2JeO8A8Au/PvBSo+U7dxLeSV62AzeR4kFX
    a+iqP2H3HMltuRIjMLDRcvNlojIl1EBj5RrVSwayo6zmwVikcjg==
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
        id S1752741AbeBKEhn (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:37:43 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41741 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752977AbeBKEeL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:11 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Markus Elfring" <elfring@users.sourceforge.net>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.300391949@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 051/136] platform/x86: sony-laptop: Fix error
 handling in sony_nc_setup_rfkill()
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Markus Elfring <elfring@users.sourceforge.net>

commit f6c8a317ab208aee223776327c06f23342492d54 upstream.

Source code review for a specific software refactoring showed the need
for another correction because the error code "-1" was returned so far
if a call of the function "sony_call_snc_handle" failed here.
Thus assign the return value from these two function calls also to
the variable "err" and provide it in case of a failure.

Fixes: d6f15ed876b83a1a0eba1d0473eef58acc95444a ("sony-laptop: use soft rfkill status stored in hw")
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lkml.org/lkml/2017/10/31/463
Link: https://lkml.kernel.org/r/<CAHp75VcMkXCioCzmLE0+BTmkqc5RSOx9yPO0ectVHMrMvewgwg@mail.gmail.com>
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/platform/x86/sony-laptop.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1654,17 +1654,19 @@ static int sony_nc_setup_rfkill(struct a
 	if (!rfk)
 		return -ENOMEM;
 
-	if (sony_call_snc_handle(sony_rfkill_handle, 0x200, &result) < 0) {
+	err = sony_call_snc_handle(sony_rfkill_handle, 0x200, &result);
+	if (err < 0) {
 		rfkill_destroy(rfk);
-		return -1;
+		return err;
 	}
 	hwblock = !(result & 0x1);
 
-	if (sony_call_snc_handle(sony_rfkill_handle,
-				sony_rfkill_address[nc_type],
-				&result) < 0) {
+	err = sony_call_snc_handle(sony_rfkill_handle,
+				   sony_rfkill_address[nc_type],
+				   &result);
+	if (err < 0) {
 		rfkill_destroy(rfk);
-		return -1;
+		return err;
 	}
 	swblock = !(result & 0x2);
 
