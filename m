Return-Path: <tavery321@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519658878; cv=none;
        d=google.com; s=arc-20160816;
        b=rM26wwgRQMxZJ4tyXPk/GGmE2D/QAyhvrU7+uJlMOh5DkfxnQ/QwzNVjxzXS5jC3hN
         APy0RynA2drQjYAHj2dsRGDns9AFaiwry5o+CJJJVpLow9oThCkne4RmOeW4siLAI8aC
         ar6HTSwzAoNKUX4Lz9B5lgBPl71U96Ay+vNNu5lowPtOJaM3VDlHPxipUgNBJMOHrg05
         dbR68hI2IUZlGoCKvOwk5Jz5nsqaE3BMG4rT2SUlgpVHVbc+UlW7yk56BXlTqHubeAv5
         fBzy1uUcEywQV2oPhD9n8DgQN+Zp2crRSjMAQ9jRfUtL5yD30ToXgF+LtbRAbLbQkzPL
         oRHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=ggUZbI1N39Zfo8a6TZy9ojB5O8Beu5RUy5/lZFsn+hA=;
        b=sUvqV+uKPXe6y2fGodIopspxjyFfB8KpY7IxHz9+4wBd52XE5Gr8gN2aMaz3/vI+S9
         4R8ykm9ECjDqYY77rAPh/JR+2HsE/TzCWqCJ3v+HVzhASkiWRZO7tq4kZR+2ozCdHm//
         nyGVgD6tTqdkM7D4J6/aDybxeWEdLS00I9S2cWDsJJeEu5oeLcF+lWcp9Y94KGUTSLZy
         uJwKxjU6nVWZOMadHSbw0hPT5QTYq+U1slP8kEBcu39fR/AYyH8vzjCvvHMlRN4vttOl
         rIFiXo9EgQs0tajV7Py0+FbcipVi7Wnn+tTrBDts5hnMMeBgJuR4bWunFtdcSn93IdRE
         zDuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qhMOSaG7;
       spf=pass (google.com: domain of tavery321@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tavery321@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qhMOSaG7;
       spf=pass (google.com: domain of tavery321@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tavery321@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvqM3HEQZdf/PzyMFSUdtOs6HO7VEDBbTcCISV4fDpx7ZHwhF6ABt5X9jrIdHyD1aefJcdUaw==
Date: Mon, 26 Feb 2018 10:27:56 -0500
From: Thomas Avery <tavery321@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Drivers: Improve readability by removing warnings
Message-ID: <20180226152756.s2pr2et47lvjuphb@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593477827940732919?=
X-GMAIL-MSGID: =?utf-8?q?1593477827940732919?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix warning given when running checkpatch.pl, make line less than 80
characters 

---
 drivers/staging/vboxvideo/vbox_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vboxvideo/vbox_main.c b/drivers/staging/vboxvideo/vbox_main.c
index 973b3bcc04b1..eaa7e38c10fc 100644
--- a/drivers/staging/vboxvideo/vbox_main.c
+++ b/drivers/staging/vboxvideo/vbox_main.c
@@ -61,7 +61,8 @@ void vbox_enable_accel(struct vbox_private *vbox)
 		if (vbox->vbva_info[i].vbva)
 			continue;
 
-		vbva = (void __force *)vbox->vbva_buffers + i * VBVA_MIN_BUFFER_SIZE;
+		vbva = (void __force *)vbox->vbva_buffers + i *
+			VBVA_MIN_BUFFER_SIZE;
 		if (!vbva_enable(&vbox->vbva_info[i],
 				 vbox->guest_pool, vbva, i)) {
 			/* very old host or driver error. */
-- 
2.11.0
