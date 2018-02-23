Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELucUYFjHGuLkCjrrZbe+D927bmN9MKuhFgqI+Dk5mOcwqWHv9JPQmgH6WY3nXoQV8iZvPXL
ARC-Seal: i=1; a=rsa-sha256; t=1519412302; cv=none;
        d=google.com; s=arc-20160816;
        b=d+a7lHGYJae+zSKoIgQkywpuwn1kNB+mLQiPPhH/FvoeM8MHoARXHwEL7P1j1GmUj3
         QmQR4RNYhjyA+ewuDtDnB/ZLe5QhSale7jJEbdpwb26g3bBCRmfJdkEY7Is4LXAN3jJ0
         PmXqzYVeyQKhyblBjfJvD1hCJXGFzEJ/xOKe8OPUtT8AAdKJLf/d56PvPVRVgEgwgvrG
         xfMU4Y9jE9CWh3U/kP0r/9Nx97tdZj8L/ckdz1/u/jmhkkAhSWVVRlSnqt8U6/fZczgn
         FjsTXkyM7bIi6ix/r6jZErJzgkftYsNKQYA5lr3Xm87O3+m3aY72WupRKFg5Lid7Tzbr
         ayuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bLriencpYwI7BehSnteXV65ONRdRhC34gQgFVAqo+ns=;
        b=n+DtnvHpxnQnEMwP7HWdEiPycSatu06QL6Gft0kJjEt9jJ1l9ZCujMwItml0uPuizT
         mFXseoh9k+d1M1WIv/mMRj1U/9sdHqr2Kf+abEPOgQVw7jJwNYEXNdQtO/tFUED2x58g
         P2JVsBF4OYUxMOOxXWCpmlLkj/KiwnEnhzRZ+Mqov3QN7H3AkVhK56Uv32/QH/nEpUq4
         YneBT8etfH1/EyR9Z8CAMdvhbrpeRm4CQUlyzIP4libEXUwEfem8XuoMZnuKy4Xju655
         sf8fj//3uZm4QFilXWqB9kuNbWLum76u0mJ4abhTWFPd6tHeliaXnDQ8iE9Xn6Ixfibt
         9fdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.15 25/45] video: fbdev/mmp: add MODULE_LICENSE
Date: Fri, 23 Feb 2018 19:29:04 +0100
Message-Id: <20180223170719.169963414@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217569293058738?=
X-GMAIL-MSGID: =?utf-8?q?1593219273954781524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit c1530ac5a3ce93a1f02adabc4508b5fbf862dfe2 upstream.

Kbuild complains about the lack of a license tag in this driver:

WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/mmp/mmp_disp.o

This adds the license, author and description tags.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/mmp/core.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/video/fbdev/mmp/core.c
+++ b/drivers/video/fbdev/mmp/core.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
+#include <linux/module.h>
 #include <video/mmp_disp.h>
 
 static struct mmp_overlay *path_get_overlay(struct mmp_path *path,
@@ -249,3 +250,7 @@ void mmp_unregister_path(struct mmp_path
 	mutex_unlock(&disp_lock);
 }
 EXPORT_SYMBOL_GPL(mmp_unregister_path);
+
+MODULE_AUTHOR("Zhou Zhu <zzhu3@marvell.com>");
+MODULE_DESCRIPTION("Marvell MMP display framework");
+MODULE_LICENSE("GPL");
