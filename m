Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525275936; cv=none;
        d=google.com; s=arc-20160816;
        b=Lt6jAFFVzv1uNvLEiZUIyPoFL9LkXifuuGlVKuB5mo87v5nGL/gyp7uMI9BAq2+Yy+
         Y8mzaRO/LYK9yZi7r2mZNC86tBUnTB4/0VYShHCa4/WW/TZXk2vnKQ+BXmXizbRtDxHf
         Yo/BHopymERXYYpTXrwDs2B3Me8JNSdxStoS3QoQzH8rMwLvZcDoDjJS0NmV9xjnt95w
         WrLwqJSLVgt+tm6fXIy4Rzs281kkCo+9QIJmA+faeTxfxzWRlR6CeO9UI6+dI3NgOzQH
         cag3lKMsUWQ0SZajt4XK4WZqe+zzNdVVqRMiqu+YyXcHFk4DD23znD4fMGSLbSCIJ4DB
         8TwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=YSHR4mz100tqITQVjZB7GOSUUFz2JZ3qcD3oM9++yJQ=;
        b=yrsnb129xrUmgFsOaJ5lHbtEohhxmLLLNuJwGhqUO3HZLr1LaA80mHxgx3LPOMlvFQ
         E3oMry/5V2iwsU4TWTDn8vIuMuJrZC8AvVCXzpcqSOTO+8Y5KoqEAyM2lcJOzS3kCk63
         EqKDjyGJVrZK7oY0vqcfAGHLLJ4075qmLBC7qXnjC18d2RcTQWcZdI0mkV9PVUE6OcTC
         0DoWQRL8s5lY14c8VaWdygq5+wMM7Hm8o9yhsj6VVUnySVGvF3sZuh/bT8jWH1YTcxmx
         exXfCByXTZy6HuD/lln7+9p85xHxJJGP4M61Gx4M43oH57wlX3u+s3iNr6qqcha1LOuA
         AtXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AB8JxZpSqQC0NsaAk36g9xJ13n+ggPYaj+ByJs8pqaVUDrvLYzw4gbQB1c2Yuf1DMNbqIXil0QC9RQ==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk,
	torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@infradead.org
Cc: tglx@linutronix.de,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	pombredanne@nexb.com,
	Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/6 resend] statfs: handle mount propagation
Date: Wed,  2 May 2018 17:42:33 +0200
Message-Id: <20180502154239.14013-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599367740433603357?=
X-GMAIL-MSGID: =?utf-8?q?1599367740433603357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hey,

This is the second resend of this patchset. I'm not sure whether it has
simply been overlooked but the number of people get_maintainer.pl was
rather small and seemed a little random so I added Linus and Christoph,
two people I know that do look at VFS stuff at least from time to time,
although they weren't listed by get_maintainer.pl. I hope that's ok.

This little series
- unifies the definition of constants in statfs.h and fs.h
  *Note, that Andreas has expressed doubts whether this unification is
  useful. Please see https://lkml.org/lkml/2018/4/13/571 . I still think
  it is but I'm happy to drop these two patches if others agree.*
- extends statfs to handle mount propagation. This will let userspace
  easily query a given mountpoint for MS_UNBINDABLE, MS_SHARED,
  MS_PRIVATE and MS_SLAVE without always having to do costly parsing of
  /proc/<pid>/mountinfo.
  To this end the flags:
  - ST_UNBINDABLE
  - ST_SHARED
  - ST_PRIVATE
  - ST_SLAVE
  are added. They have the same value as their MS_* counterparts.

Thanks!
Christian

Christian Brauner (6):
  fs: use << for MS_* flags
  statfs: use << to align with fs header
  statfs: add ST_UNBINDABLE
  statfs: add ST_SHARED
  statfs: add ST_SLAVE
  statfs: add ST_PRIVATE

 fs/statfs.c             | 16 +++++++++++++++-
 include/linux/statfs.h  | 30 +++++++++++++++++-------------
 include/uapi/linux/fs.h | 33 +++++++++++++++++----------------
 3 files changed, 49 insertions(+), 30 deletions(-)

-- 
2.17.0
