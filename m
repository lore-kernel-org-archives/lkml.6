Return-Path: <mathieu.malaterre@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525550059; cv=none;
        d=google.com; s=arc-20160816;
        b=GdCd5Fg+/DOVVWbpfIaom5S+lVBWR7FkO4FrhT2ngdg+a+KsDSg3RRg81LedKKkaex
         E8VsTYUF5nrVsRJfQ2H0t6pr1lGY+aQUVpvtK98DTvEjuNIfKGZBN9je+r6TfokK4fuu
         jfmgqdiBOgDvGX+5xia3hB925/DZ2c4LtA7d3K4Y+ycJ2FNLu35SG5i3bgjpu32CQXJW
         g3Tyamn4x71og1agfeoWgvtWTMm43qMXmDVKUePEfeYowJaaFZS6q5vmoay1g8XVCEy4
         qDzFLWH9P+YQcqClIYVcKJV1SrWRf7gE+dpq79t5aROSk1Ujov3v5x3llB3QU/++NIKU
         jtBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:dkim-signature:arc-authentication-results;
        bh=zBI64bkqcddHQR9XtBDxfMVAJYCF+LKUmKInADdSQbU=;
        b=z4h9O4UjvWE+mDpg9urwwdiRGsT4l4eBFGmHhZg7uvraNnJEhBxoIFAlKuHJtCLQWs
         FSgnGILYPeqWaEV/oC0h/FhV0eSZxdoUTo8YYF50Epe1rSDoTsr8kXSNmHwIKQkGL3yA
         U6aHUVXS0F0G7B7FoCekBxJmaBG48o3lCubbDkGUNdLII5JPlqvZDHSrt7TAVxq4stbn
         JvPpn4/2Y2+W+5PhnYXg2pX4Zh0NDkiyukNxOmCcdTVo15OiWMI2rfF31Xv/ucH0M8jn
         gmwA7ZR/I3Zyhs9VrSUXqfkMEc6B5kok5WYw7zXZz1YecNnZRvoHyW6PALjr0AehzoYY
         BVBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XmR+Vbeb;
       spf=pass (google.com: domain of mathieu.malaterre@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.malaterre@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XmR+Vbeb;
       spf=pass (google.com: domain of mathieu.malaterre@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.malaterre@gmail.com
X-Google-Smtp-Source: AB8JxZpXyiO+kUni9rEF7CBbxCC/3HrRd3WoOhWFQ8sWZWMpaS8tx/EHgAUnUip0Nz8lXXWwATxWNw==
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: David Airlie <airlied@linux.ie>
Cc: Mathieu Malaterre <malat@debian.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] agp: uninorth: make two functions static
Date: Sat,  5 May 2018 21:54:05 +0200
Message-Id: <20180505195405.6327-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599655179406531000?=
X-GMAIL-MSGID: =?utf-8?q?1599655179406531000?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Both ‘uninorth_remove_memory’ and ‘null_cache_flush’ can be made
static. So make them.

Silence the following gcc warning (W=1):

  drivers/char/agp/uninorth-agp.c:198:5: warning: no previous prototype for ‘uninorth_remove_memory’ [-Wmissing-prototypes]

and

  drivers/char/agp/uninorth-agp.c:473:6: warning: no previous prototype for ‘null_cache_flush’ [-Wmissing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/char/agp/uninorth-agp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index c381c8e396fc..79d8c84693a1 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -195,7 +195,7 @@ static int uninorth_insert_memory(struct agp_memory *mem, off_t pg_start, int ty
 	return 0;
 }
 
-int uninorth_remove_memory(struct agp_memory *mem, off_t pg_start, int type)
+static int uninorth_remove_memory(struct agp_memory *mem, off_t pg_start, int type)
 {
 	size_t i;
 	u32 *gp;
@@ -470,7 +470,7 @@ static int uninorth_free_gatt_table(struct agp_bridge_data *bridge)
 	return 0;
 }
 
-void null_cache_flush(void)
+static void null_cache_flush(void)
 {
 	mb();
 }
-- 
2.11.0
