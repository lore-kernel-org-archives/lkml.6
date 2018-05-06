Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3852358-1525646925-2-7405679573913928826
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525646924; b=OYCAf7IHKJ6nvRxZNZNv0rUTefTqOnj59Beie1RNvvtBIo2GoS
    +qEBBjrGgyVnmpXkjSLG/5E2GN19IoIgmyTF0C2PKFCvfygfb1Xvqj1l0A5D28zT
    fShOTfp5I4i+4pnRr2k1KuGIQFSHWJB/0X8YVO4oi9L3kdCGvbfZzqijGhRBl2ww
    9f4WYLrphadPVg+RuVdYBG7gAmTVIk44TIt0mEoIBlmFE5+I67U8dh9TBu3uwuY9
    CDzTzwcy66GapuF9cBS7i0sF78MOc2rxvemYWjRWz+ENaFR0wLMfjqeDG6AgI5Sv
    jMjnEpQRRYRqwI/dlLMcj/n/xgX0apdMyWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525646924; bh=
    LVeEvf1xcn16f+aWE2DtJWJ9VPqrNzpFdm+Qq9TycXE=; b=BRtIiivuXj98XBrM
    /2nuBnNZBuhcUWaknWNjOj6fgIUsaUiDoZFXmS0uyI4oJeMu6q3idZGLHwKjeiHb
    2U2STD0Np2ns2tMiBHsFuphyPgAGGothuatDFBQDyHHHRSe1UL3GnCRavBkxLO9H
    dmycA9q784PzQsu86D3QYqIt/5vDnHcYpeyqefR2O0XMkKUz2B748VIetcxk6CSQ
    SrrepfMzMAdd1AKoKEVGorfFBu/3J+Nra0Ial0JrSlA6CYsZwJp3ODUATWaZ6Eb5
    WDXe0mnzNLpaChVD9/5lr3h+tfYXy0XwqsOSitkeZef1PSyyP8bJ3Jq91Ppf9MYt
    oPAI8g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ubuntu.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=g73AW1KA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ubuntu.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ubuntu.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=g73AW1KA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ubuntu.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAywjaMu45TBmmqKsBNIkc8rZZnliVIab1lD660GgnAPmhYW/c/XjjcRF6wHqZyKUWHIvnVFFWPt1WivrsjITIRfpc1q6zd+NLvlwwKxBohEZSx9OKm3
    eia8o1XmPT6dpK066Zhnr1g6Nhg1kPCFU/BRxXi6gJRRGukunX6kzi/qe/3QHooFc18u8h9G1wnicaBDW+EY7yldUk8YCAhfWHATq6g+N16uZN9r02n2CKwJ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=fxJcL_dCAAAA:8 a=VwQbUJbxAAAA:8 a=-dTaUF2OZTzjWLL8T4wA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeEFWsQ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 6 May 2018 18:48:16 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38355 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbeEFWsK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 6 May 2018 18:48:10 -0400
X-Google-Smtp-Source: AB8JxZrlFSZLaq29N1wzPorKWA1xGg/mGYgJoZx3m3F5jvEeR1TyizxtIHF02A54s8BEANmUuNjjOA==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, tglx@linutronix.de,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/6 v1] fs: use << for MS_* flags
Date: Mon,  7 May 2018 00:46:59 +0200
Message-Id: <20180506224704.14669-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180506224704.14669-1-christian.brauner@ubuntu.com>
References: <20180506224704.14669-1-christian.brauner@ubuntu.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The definitions for MS_* flags are currently a mixture between hex values
and bit-shifts. All higher values are already initialized with bit-shifts
for MS_* constants starting with (1<<16).
This patch switches the definitions for MS_* constants over to uniformly
use bit-shifts.
Note that the BIT() macro cannot be used as it is not exported to uapi
files as was pointed out by gregkh.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
v0->v1:
* non-functional changes: extend commit message
---
 include/uapi/linux/fs.h | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index d2a8313fabd7..9662790a657c 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -105,22 +105,23 @@ struct inodes_stat_t {
 /*
  * These are the fs-independent mount-flags: up to 32 flags are supported
  */
-#define MS_RDONLY	 1	/* Mount read-only */
-#define MS_NOSUID	 2	/* Ignore suid and sgid bits */
-#define MS_NODEV	 4	/* Disallow access to device special files */
-#define MS_NOEXEC	 8	/* Disallow program execution */
-#define MS_SYNCHRONOUS	16	/* Writes are synced at once */
-#define MS_REMOUNT	32	/* Alter flags of a mounted FS */
-#define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
-#define MS_DIRSYNC	128	/* Directory modifications are synchronous */
-#define MS_NOATIME	1024	/* Do not update access times. */
-#define MS_NODIRATIME	2048	/* Do not update directory access times */
-#define MS_BIND		4096
-#define MS_MOVE		8192
-#define MS_REC		16384
-#define MS_VERBOSE	32768	/* War is peace. Verbosity is silence.
-				   MS_VERBOSE is deprecated. */
-#define MS_SILENT	32768
+#define MS_RDONLY	(1<<0)	/* Mount read-only */
+#define MS_NOSUID	(1<<1)	/* Ignore suid and sgid bits */
+#define MS_NODEV	(1<<2)	/* Disallow access to device special files */
+#define MS_NOEXEC	(1<<3)	/* Disallow program execution */
+#define MS_SYNCHRONOUS	(1<<4)	/* Writes are synced at once */
+#define MS_REMOUNT	(1<<5)	/* Alter flags of a mounted FS */
+#define MS_MANDLOCK	(1<<6)	/* Allow mandatory locks on an FS */
+#define MS_DIRSYNC	(1<<7)	/* Directory modifications are synchronous */
+#define MS_NOATIME	(1<<10)	/* Do not update access times. */
+#define MS_NODIRATIME	(1<<11)	/* Do not update directory access times */
+#define MS_BIND		(1<<12)
+#define MS_MOVE		(1<<13)
+#define MS_REC		(1<<14)
+#define MS_VERBOSE	(1<<15)	/* War is peace. Verbosity is silence.
+				 * MS_VERBOSE is deprecated.
+				 */
+#define MS_SILENT	(1<<15)
 #define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
 #define MS_UNBINDABLE	(1<<17)	/* change to unbindable */
 #define MS_PRIVATE	(1<<18)	/* change to private */
-- 
2.17.0

