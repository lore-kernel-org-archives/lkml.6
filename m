Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324025-2-14014912161696658437
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
    t=1518324024; b=xFClFb+CH7pEDeh0+rxTDajILW1JwoOcCXdZf2UT/XgulNE
    ffsZxexHCeLnpLWbFsitLwFSDlzL8AmGVPVgWN+3O0Dgj4JvXyOtMSbInw2v/6ea
    5zHLFpg897AkqPhC27pzuBVlCbODg7vx7QvaVUFW40CefVadrFGGglY1foPoQ8hp
    bCxCYDcQKLYQixk56RGZwrV/B7GDsaRtbUj++ZcaIjVutt8W+6AbRoLKoZDWz/Dt
    zxYqBcaYDysu5+PLfB/D1iVjntX42POn+Q5Ct+aOR5kXYLtwINzoqKlSz+CZLSCx
    uxVaJ9w7qDmT9nRJYCcKJcvsOJDgtoe2g1aHNDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324024; bh=+N/vwUSQmbDADgmkvbd
    z+vTnbZ85dYXd/yWfCa9RIVI=; b=tx+1v06p63UkhC8k3wmD8/62JVoeVkCuccg
    rpSNW65fPnTWZDkDhoV/J4f2c0rcW3sJPpkkhfUdsjlYMw1KE4BRD5RflS8jj+P/
    u+EV1Y7Thx5JFsO7vpCKNtnDbe2mk2UjEuQuWDgqGJ4L7z6Bk69Ekn9/A5Q9PZIJ
    eEM3/HxDnUuWviqV/JLWmDe0Re6wWvPr0uKym082XLSMyIU3onAUNLEfOpqkPDpz
    sNOtxHuKXZ2Tg82MyZ1ThPOyYMR7U7qSUsCJOetv+VMcfanRn5lltLJCE0B/3y0I
    vwxHtkbwis2b3KFYH+9ZPmzXR9R9A6K+ZJQAsL4RlMd9wtuYZqg==
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
        id S1752963AbeBKEi6 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:38:58 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41692 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752947AbeBKEeI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:08 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Arnd Bergmann" <arnd@arndb.de>,
        "Jan Kara" <jack@suse.cz>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.932086266@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 044/136] isofs: fix timestamps beyond 2027
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
