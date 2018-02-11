Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518325640-2-6061120518917589687
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
    t=1518325640; b=gkeowRyK0gR1/RlEO/y4D0b8nyyK6c4IvpJrHC2dgR9HIVX
    g4jLoeTCVQB1AJKotJAPFN90c310DZAsrPbuQ2RJLWeai5BGypOQ509auzBq7MMK
    MnFeMGk5j5DEW+XMfQUV8gmZIE0uuymJwRMfjy28/lzf16iIezKVlvk5b3MvugHh
    1b1wAoeNMMY8DdENLNTdK8mRQAjT3NqGK51+VN2BgyU8wKYBsrMNs2JS2CD4+7f1
    JK3fBbU+q1l17ZNbWNlUvxvjHRF0Q0PSngWZxEmBlRhvkjGDlVQViWumwNqHaBre
    WGTKT+KHNEx+2tKemMpIPXKd4p6LP49QlGSojiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325640; bh=nH4xG0+iAwsE85sl6iB
    gP91lkUteqiU7HqoE1RrlCts=; b=l0VyX2CWTeJuNPPLdnLLTqpDgsFy8WO/Afu
    1zXMOUaa/msMMzhAcC7iuv/M+ruT4Yo3RhcQFOKZ0g9ftzABlfDYhkQwRr5CxBO7
    yGQFFmeL20UVmZKK3a+GAElG8mgLS3G50Upmjviq/ZZWbn8fG2Sq+DL9QVZV0dyJ
    mCFfJFeDPtQnXUxhpOK7bTggIsemZrNmQVqkCxnJpA4slOjSwGVWV1f37cWmhujF
    IGtkpDsN5Yfu2bW8faEoY0pWcEsqAdJyj6+8TGcs75I4+76bOtRu5BRE5ySyUJ1r
    TPFEGWq88DysrditU2yKAC3sTBIn5g7fX3NdjU09EepgLEBgb0A==
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
        id S1753382AbeBKFFk (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:05:40 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41514 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752686AbeBKEdn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:43 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jan Kara" <jack@suse.cz>,
        "Arnd Bergmann" <arnd@arndb.de>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.181490138@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 24/79] isofs: fix timestamps beyond 2027
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 34be4dbf87fc3e474a842305394534216d428f5d upstream.

isofs uses a 'char' variable to load the number of years since
1900 for an inode timestamp. On architectures that use a signed
char type by default, this results in an invalid date for
anything beyond 2027.

This changes the function argument to a 'u8' array, which
is defined the same way on all architectures, and unambiguously
lets us use years until 2155.

This should be backported to all kernels that might still be
in use by that date.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/isofs/isofs.h | 2 +-
 fs/isofs/rock.h  | 2 +-
 fs/isofs/util.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/fs/isofs/isofs.h
+++ b/fs/isofs/isofs.h
@@ -103,7 +103,7 @@ static inline unsigned int isonum_733(ch
 	/* Ignore bigendian datum due to broken mastering programs */
 	return get_unaligned_le32(p);
 }
-extern int iso_date(char *, int);
+extern int iso_date(u8 *, int);
 
 struct inode;		/* To make gcc happy */
 
--- a/fs/isofs/rock.h
+++ b/fs/isofs/rock.h
@@ -65,7 +65,7 @@ struct RR_PL_s {
 };
 
 struct stamp {
-	char time[7];
+	__u8 time[7];		/* actually 6 unsigned, 1 signed */
 } __attribute__ ((packed));
 
 struct RR_TF_s {
--- a/fs/isofs/util.c
+++ b/fs/isofs/util.c
@@ -14,7 +14,7 @@
  * to GMT.  Thus  we should always be correct.
  */
 
-int iso_date(char * p, int flag)
+int iso_date(u8 *p, int flag)
 {
 	int year, month, day, hour, minute, second, tz;
 	int crtime, days, i;
