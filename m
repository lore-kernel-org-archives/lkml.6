Return-Path: <tavery321@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519658696; cv=none;
        d=google.com; s=arc-20160816;
        b=I2p4KZNMKlZWzAIF10vMHuwtaFxCoi8Vh+fCgZihqcHPP4mqbGKLNhDoXb1OeCMLI/
         hjjVpeNErCnKTpPGaO81DmK0FA4aLw/OKDwg3zDhvNPH6RDoWs4EuanDc2p7VtU5LXYl
         qrCaXT1aHxMG16IO4821EpnaX9gPQzOU1kfMjJVd5d68OCvf+FV0AEIAoS8FP5EnkL0x
         5B7ZvtB2gxfNLT+va0j8gmQTxhOGLcuTZH1jVaPBElCi8i4uz/WyyDo7CVN6HIq2kZbj
         MgYM17dGxF+xwcBl5bMJvOJmIbjkYiw7xifMGH5yTZDspJD7cmO9/6V6Yw9vkYz0KXd9
         /G+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=ggUZbI1N39Zfo8a6TZy9ojB5O8Beu5RUy5/lZFsn+hA=;
        b=CTKDJKEc5KnnNy+o2briILaGgIpY52mKKL9BJs/trIqQs/pD2pdmHba61JNew3qlvy
         bihJQaVso/IkDJkjtiAOVFuHmurIn6nA8tuHIZiDwN6uWCezD5DkSpF9MY071NiIYrOn
         feJlRIJiBi4mSyEtC8UGLVXSKH0bzW72IiUddQjOPaz3zKOEgdbw00URkjbT5flMZ0Cj
         tl1C26MbhWlyeC+7cbr5DSmmlKoVDyfS3ZahCcvjOGJBAwi0N1wp2sJq67OQBchRpqJb
         ReDjxHnDbLv3MWL/qno1LPZ+IlTTV4r9T6L2XcEuhp8ENsX5GGGtWeUpc35nI13mTc37
         sfJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U1UCSzJU;
       spf=pass (google.com: domain of tavery321@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tavery321@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U1UCSzJU;
       spf=pass (google.com: domain of tavery321@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tavery321@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELu1OLGA03Lj3spl0fQDs4YFocvqHaQ0DIXLgQoEm1Hkwca+Jkd05NQ7Yop/b6AhO//1LaOI5Q==
Date: Mon, 26 Feb 2018 10:24:53 -0500
From: Thomas Avery <tavery321@gmail.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.ousosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Drivers: Improve readability and remove warning errors
Message-ID: <20180226152453.2glbzgb6kzi4cxel@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593477637509999247?=
X-GMAIL-MSGID: =?utf-8?q?1593477637509999247?=
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
