Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsAJS5odZwKZz3efx7CPTBNljO+VAsZY0i/W00wer1WMfiUYNb9Gi6y3ZWI4yMRyLBIdJXC
ARC-Seal: i=1; a=rsa-sha256; t=1519410814; cv=none;
        d=google.com; s=arc-20160816;
        b=pd6KvWZbCB4BlbFRctjZjhgJO24jgaXAD2hSVM8RSEZvI9NpP879wXEzfVz5bnCc22
         i2Zs0+ZtwBdMYJ+1r0CB9glKuZDxlsAm/qVxkyjzoNeYEaKKbeUPYzicKaqG3UMj1L2e
         f2heoNbMTi4W6lfWVz2AKSVZAaU3yQMM4RB8bS5t37Eaf/tesurNlJFj7O7joY1hDpFv
         gjVrmuynHBiKbDTpMDZn+WoDhDgQy/YRmOYm3UasyXkLijkNWOacHg38NsjoL9h1P1Na
         7Bk8iRg3Kj05jcreKhIQGdTc+81guDv09JhiZHLJoj3Hclqwrx4azHdHD9ZcU9lEdYNf
         DkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=b3BLo0BXGzSGZ8JdyEAHPiCVKbUIQGxRwFWxCZldZN0=;
        b=DJ5X4IvzYDEis5s0xkspHtrYJfXJ7llP4ISKq5G6YmFM35q2yKmsxD+ckQnZwKvkmv
         XF58KHtpjJfV7U2JtT7fOjHIdgl92eNYjVZeqK/eYxJz4Eu8NJrMp7QoDZXIH8fsyYrT
         vIOjFCrqYSQU9Ozs+y9lizXGyLJGLph6bbPpoU/e9EzPrxYzgmM5nXI8u3GHsUx33HrR
         idQ3yJXMtOy2x80W9AiB1aNqzsTcqjGGTRaNH8+mTKf1SllfxVY1RiqUBQB+ov8nko25
         v5Vzn/5PFGZahmxacD3lxWnBtfmEiW3JrEO6GE4pDh2t3aDrR9Ruh6ir7pwxiMJ6LEJ5
         MUEA==
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
Subject: [PATCH 4.4 022/193] video: fbdev/mmp: add MODULE_LICENSE
Date: Fri, 23 Feb 2018 19:24:15 +0100
Message-Id: <20180223170329.553594881@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217569293058738?=
X-GMAIL-MSGID: =?utf-8?q?1593217713748098491?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
