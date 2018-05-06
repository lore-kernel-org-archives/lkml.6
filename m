Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3852358-1525646983-2-1924933134026522755
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
    1525646983; b=deohr+sds0wV9OiMqJ5BZDvMhgr8lUYOUvHJWDw87kX+nMsard
    opBHQiFrNF3vtOdFvVl9pbdKBLpldvsScKYXUzdO09GKeivJKFqKpoZQqk65n04K
    X8wP/DJVGbFHH4SeenfTJWiu5xTNvdbxCXohkDDvwOANPV5DpOtpWR7V5RZ3jfMh
    C1dcHujj7I/NSwzUBZy500jOxQSK/JkWulPEY6vmy1Oxz2YVolAS/NJiElKHFBUY
    d/clxR7SxaFPSVfP0JRLeEoHYliC7zaX4OfmJpRtFrvtRTNk+Ryjy1Rfx0aWwEqT
    pl9jY/SXDqRPeiIobmSf7kuxTrAPSDJ7Puzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525646983; bh=
    pAPOvK954VlgV1CdJ0wwFLZevp/iys8sNuWvAq/7LRA=; b=GeRY5fDq26t18m2v
    ChaN2vqoYf9171kypmbmn8LPi7pYLWIPCI8yJhYhaMOJ/3jgkesOz5lmoDFPLqC4
    1j5L+rgoVqbmmQJf303ubPZV1jz2D+NOAuCpK9d2gYFK2IEo1sFQtkm171Bw7lqH
    A4d2kmYa9M4fsXLsXSlLp4E5Ijm7b1geIl56/n+8ipfnphSRdgk/l3ccR46IzTNm
    vTorgClWJ6fgt/5SdW2LUQS/39+t3/TKQbn7IoUn+drimhFmz0QhFu9YvxwBPGXh
    C+omk440N2jLgq9uhicy/KCjiU71tlATtUexlO/V3KYkp/Cnwm20G9D5Qu7BYKSX
    72Zv6A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ubuntu.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Ib/r8N15;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ubuntu.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ubuntu.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Ib/r8N15;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ubuntu.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKTLDOhfF+nyXnuVViomYvKPc8yXVWzzcYxWFf50wbC1sZI9ODmdp9al+19a0G9evo5XqtCMckwAB2KsoPzgVqjsOJN5VW+tFyrwwZ62cz21EbD1pDWN
    GVRreDeNCquYykJcjXtIhz5+5iwi8x4lPGsR9Xi5UwSKf9p6sqen2IlnklG59f3/UZD/6CApwWwY47ezM+5YfhHpyr2/3kP+UlsQpKWpHbvgaQzv2lX/Cm5u
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=fxJcL_dCAAAA:8 a=VwQbUJbxAAAA:8 a=V5zyGy9ClZnDF-sAG1AA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeEFWsp (ORCPT <rfc822;greg@kroah.com>);
        Sun, 6 May 2018 18:48:45 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36312 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbeEFWsP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 6 May 2018 18:48:15 -0400
X-Google-Smtp-Source: AB8JxZp22rxbpwd302zoMP2f/1QcbW41okTbS/fbqqIfwqor0EeTxj7gMWm3BYdomaAH5d92zD/VOQ==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, tglx@linutronix.de,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 6/6 v1] statfs: add ST_PRIVATE
Date: Mon,  7 May 2018 00:47:04 +0200
Message-Id: <20180506224704.14669-7-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180506224704.14669-1-christian.brauner@ubuntu.com>
References: <20180506224704.14669-1-christian.brauner@ubuntu.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently userspace can only determine whether a mountpoint is private
by parsing /proc/<pid>/mountinfo. It would be convenient to simply retrieve
this property with a statvfs() call.
This let's userspace avoid costly parsing, supports cases where /proc is
not mounted, and supports usecases where file descriptors to mountpoints
are passed between processes that are inspected via fstatvfs().
A mountpoint is considered ST_PRIVATE iff and it is neither ST_SLAVE nor
ST_SHARED.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
v0->v1:
* non-functional changes: extend commit message
---
 fs/statfs.c            | 2 ++
 include/linux/statfs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/statfs.c b/fs/statfs.c
index 35ad0402c9a3..899e899ee84c 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -58,6 +58,8 @@ static int calculate_f_flags(struct vfsmount *mnt)
 
 	if (IS_MNT_SLAVE(real_mount(mnt)))
 		flags |= ST_SLAVE;
+	else if (!(flags & ST_SHARED))
+		flags |= ST_PRIVATE;
 
 	return flags;
 }
diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index 048127effaad..663fa5498a7d 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -41,6 +41,7 @@ struct kstatfs {
 #define ST_NODIRATIME	(1<<11) /* do not update directory access times */
 #define ST_RELATIME	(1<<12) /* update atime relative to mtime/ctime */
 #define ST_UNBINDABLE	(1<<17)	/* change to unbindable */
+#define ST_PRIVATE	(1<<18)	/* change to private */
 #define ST_SLAVE	(1<<19)	/* change to slave */
 #define ST_SHARED	(1<<20)	/* change to shared */
 
-- 
2.17.0

