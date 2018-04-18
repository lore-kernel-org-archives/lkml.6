Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524043650; cv=none;
        d=google.com; s=arc-20160816;
        b=CB6T7ExN7JkkXtA1Ckkbrm7M3P7hciIiPl1wAUCwo2i0KfLclF3a7vtQxtO2LqgY87
         YBp5cAjHIhYq/wfC9RWDGJUQfctF3IT6N7JvCzFQ4hLvuiyofp9ai1qhD8WNMEa+t3hE
         n7e38wyeZ85ljQ4ibp4krPL0wBHIZ6U9N/NHx4p+t7VNjXPZlucb8Wvz8ijyOQaYeD8A
         TMEFtIPfbP6kmwJXrURz6yrMKb4jfDtRhsVzjkVRvGGdw8pvwJxCHpHJbY69ylM59h85
         e8VhCQRvQOpwf/RNDhH81HkPfnNamxJGWTOAd87Pi5s2KN8+AJS4+j+PZb1BSvlKADUe
         SIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=WSzaiK3OT99QuuBALKYbUGR3soGvOx2fkEygmhACZUo=;
        b=attmLA607hAb0MZhmzO2vtiInwxq/ZsUlQenYtRnvoXa+xjZgDyvGfE7g9ynwPt9Bw
         W7kbgICXUYtDjREGlyLw9Q1O1Xd/RkL45jQ+eH8Y6Kdql3mpQDuK5VGpGlojbzZ3tglz
         uw9MIEpG5s0FjW90GYlyyU++PXRmCmB93+e+cl1OYVtrSL9K6WpKLGRxJt+BQ8cZcdb5
         efLCCky1Yxc1jrOSFVjxAmyl57tCHvRdk1n9CjFcPnLqBJtYcjdG9bBPr3b2bQ84M1KC
         ctZ81ZnddCF7Ov/IXJ6lZleSBonocdj+3k6JHvFG7sqWr3i6CNrSKShpmZKtEDwX5VIw
         wmbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AIpwx4+/JD/iC1cdDhavG0zIVze4pQk/E9UAQuHxHswsGTllVKi9iloQ8x91nowAFqrypLWRAnPH7Q==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk,
	kstewart@linuxfoundation.org,
	tglx@linutronix.de,
	pombredanne@nexb.com,
	gregkh@linuxfoundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/6 RESEND] statfs: handle mount propagation
Date: Wed, 18 Apr 2018 11:27:16 +0200
Message-Id: <20180418092722.20136-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598075594839612012?=
X-GMAIL-MSGID: =?utf-8?q?1598075594839612012?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hey,

This is a resend of this to CC more people and because it seems to have
gotten lost in the prior merge window. I should've sent it afterwards
right away.

This series:
- unifies the definition of constants in statfs.h and fs.h
  Please note the comments by Greg and others on this part:
  https://patchwork.kernel.org/patch/10340403/
  https://patchwork.kernel.org/patch/10340379/
  I haven't yet changed the fs.h and statfs.h header changes to not
  bitshifts. I wanted to wait what Al would think of it.
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

The patchset was made against Al's vfs/for-next tree.

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
