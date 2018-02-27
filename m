Return-Path: <colin.king@canonical.com>
X-Google-Smtp-Source: AG47ELuvHDnks61j3FmytiyboS4h/yf6wiOwm6Eh9LtSbt4MUReDmITjSiY6EEyIlaFZ3NB/PJSM
ARC-Seal: i=1; a=rsa-sha256; t=1519748470; cv=none;
        d=google.com; s=arc-20160816;
        b=QW1sCIB3RP1FILCffh3jWQ5wwHnFc5VWZCvIBhcCxh1YplSsfCCugnIBarao0Kvc3B
         s/SJ2yVfEOGiPcjwZgWsB133FNa2XkfaNXD6D2ZIvYJ/kJCUHQ8wNh3dpJmLOfmzuksN
         jYarEHA/mxukeXdIEUd//ngMLycOB+rZbvOaszvDnKNW+4JEarsbc3NRWQWAqBOO1ou5
         /T59ygQVk/tr4+fuFnIrgk9I+MlyBK2qp7MkxJ0hiClmNxWySjjNneqMleymfGJhQN+W
         k30YTAaP5/l/sSJ8U/MSUZEh7B/2y4Rvn5LI7sFWo7JN9T7XInRVjIIAbNI+zVb69EC0
         QDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=LgpltOIsQIPWMW6zUIyLb/nKsY9La0C7qRjXvaDV95Y=;
        b=PSpv/W0mxjSXYoE7NWlWPAmXvJSQTiY0/rAbBzteK741EEqlQ9pEMWifNkpWa02WTx
         e7m9GSrBHE2XBtf+wxa4jXG2m4BDsszq/6iU+kDO2In5Qk2wsORwWsgRaNqAD7jRg+Mn
         qqb1XdFlUk43iN8Iuv6defBMEREoYj37YrJxPbum3Iq7tUT4pNA93FYldUOAgDV44XAO
         HwUOMUj36vQc9q3gYFmYT4bnHz7Gaa3iA4W1jdLzK1uT5WOOF1GzEPVJyumJomgeN/Ry
         imm23V5+Nf65yROdJ0yOf2p0IEcDekdELdyKL22Z+KujgncSYsOzS8V/FrRIUgrQ0W58
         uG0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Colin King <colin.king@canonical.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mei: remove dev_err message on an unsupported ioctl
Date: Tue, 27 Feb 2018 16:21:05 +0000
Message-Id: <20180227162105.14113-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593571772960941030?=
X-GMAIL-MSGID: =?utf-8?q?1593571772960941030?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Currently the driver spams the kernel log on unsupported ioctls which is
unnecessary as the ioctl returns -ENOIOCTLCMD to indicate this anyway.
I suspect this was originally for debugging purposes but it really is not
required so remove it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/misc/mei/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 758dc73602d5..7bb013644aeb 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -507,7 +507,6 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 		break;
 
 	default:
-		dev_err(dev->dev, ": unsupported ioctl %d.\n", cmd);
 		rets = -ENOIOCTLCMD;
 	}
 
-- 
2.15.1
