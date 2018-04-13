Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523635906; cv=none;
        d=google.com; s=arc-20160816;
        b=CXdMpRF1X4eTV6N/mhq6B22Z5YZou05Vzdjr9hbV6jznzTUPHpuLDpKIvB8mWMSQ9K
         TJpwGo/djXZL4hL46TLwJaaS99MP/e5qDgUwFTOlAPsdilEHnTZmIRG8s+7begmoSu6I
         iQMfQujYCu5h9y7QVk9FQGceiox/zdZYTDBzYhzj2LUPCrK7ErPtHaiC5GdH1cixigPP
         5KUKrzVIuYiMUREFwCZAGeV8z65gzQE1fnQvKHBNbhYrVS9n7HDdCrxaMbZ1RkHQldLj
         Tpbk71OI/uxeIN8qlkI4i0qi5XObitNZnhjkfcoLiKUUBQfU0lTUSQ3FklNQ1I8Dc4L0
         sMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=jMr1I3eUkVg8qnKanM8D5fuJNU5fONOobV9ltM/bj+4=;
        b=fJE9mG3QpKTlOSK7uNBEt9b0K1oeAkNiosU7ETvPz4f6J1xdtLpkjU4xxWFf9hvD+l
         8YC6r6zygacAFoDBZMKcS/1cpoIvnGQkkULt702o31zOpt5Fx2p4YDZEBof8YGeoPp5J
         lLfLoNlfAmzCL3fe3doPvR5OgKN1I6bNlySMCnSBlfKt5xe9MSrl1I7m2gbAuaEE3Cvi
         BS50PSosJkrsioUomq/GpEZnzX+bTF6RlnnhLzMOEhgrkDV5LS7e4DrqWYE1fbgbPs+F
         Jvg5kuscqOE/73ekIOMMxPc5U8e9lkgrQBA5eKxOCikT1oitdRUCms+HfheGj2UdQ7et
         WRYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AIpwx48TlpT0udYgtID2YB/PtsXLF9LOGB7rBRyFFZvDrClWra0vx6EehczCkbWoCN9YE4bkGpKMjQ==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk,
	tglx@linutronix.de,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	pombredanne@nexb.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	serge@hallyn.com
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/6] statfs: handle mount propagation
Date: Fri, 13 Apr 2018 18:11:20 +0200
Message-Id: <20180413161126.31313-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597648043988742181?=
X-GMAIL-MSGID: =?utf-8?q?1597648043988742181?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hey,

This little series
- unifies the definition of constants in statfs.h and fs.h
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

The patchset was made against Al's vfs/for-next tree but they also apply
cleanly against current linus/master. So if they are deemed suitable for
inclusion in the current release that should work too.

Thanks!
Christian

Christian Brauner (6):
  fs: use << for MS_* flags
  statfs: use << to align with fs header
  statfs: add ST_UNBINDABLE
  statfs: add ST_SHARED
  statfs: add ST_PRIVATE
  statfs: add ST_SLAVE

 fs/statfs.c             | 16 +++++++++++++++-
 include/linux/statfs.h  | 30 +++++++++++++++++-------------
 include/uapi/linux/fs.h | 33 +++++++++++++++++----------------
 3 files changed, 49 insertions(+), 30 deletions(-)

-- 
2.17.0
