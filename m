Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZpuXLDKFUGt6ZFrxfC+88TYsLuKWgvuNGRBoOOKUd9oE7G32Xt64KYljziJELx8ePldViAk
ARC-Seal: i=1; a=rsa-sha256; t=1525803177; cv=none;
        d=google.com; s=arc-20160816;
        b=S618vbUEKnFGwfmbyhJgfQfTwHziQ6naksl1tgjh8FKv0tWmmfBQdcU5632JCaJYUR
         G+eLApi9KKgxPt4Yv8zabQkcvtFs1ghZvQ8XSHM8Yci5wQmvB3HErip3wB/jqvArf8mk
         hF+90i+4wm1CViiCylo0582j09uIwpN/huL2P2prnJPBeVcQ5Q+2wErOMQs3SiCJ2ErK
         UN6xYZa9f3J7hTJBRnZcZZO4J6vv1PovuLsGU5JXaPd4jM8T9CX4GVWtyOOgmfNKz9qY
         hTcBeEZVVy5DjPSCypa8nF/7f0HZJpFMB90oWcDcQJJo03Eo1yVWVVjdSc9a+vKU/vhv
         Fekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=N2w39fn0qSCONAahVlt03Xn4D3c00ai389PcHOx8/pA=;
        b=eM+QMt+2xmVy72XhuHg2M/0OG0LzZjly58ux/Z0eT72pYA2/S5AxD2r9Sd4YWzZlnG
         MeSFUEq5naboHu/1nJwlOxZsj5dRBXWxxEDL6KZ9a48fKrgGh4NslT/sRGYUYvtmUjbB
         ymP2lcfHPavcevHxPT6z4W04c5obn3aYqRyBYHTDoPkByLGphYmTVn9NME7OfV5REQz9
         06/H6ABIoThgPfNUI0J1fXG6V9mZwx9SAtlDRjVYJPfeF6RipKQ/kdFc/RJY7zJDB2fd
         zeLZU5mjWBNIHs+aqwTDtxvrU1rqVwcu6dcAPrXTPAx7BzNV+n833FSrH/G8Oj+1hcLN
         ZW9g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=AnLD/m8g;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=AnLD/m8g;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	keescook@chromium.org,
	josh@joshtriplett.org,
	maco@android.com,
	andy.gross@linaro.org,
	david.brown@linaro.org,
	bjorn.andersson@linaro.org,
	teg@jklm.no,
	wagi@monom.org,
	hdegoede@redhat.com,
	andresx7@gmail.com,
	zohar@linux.vnet.ibm.com,
	kubakici@wp.pl,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	cantabile.desu@gmail.com,
	ast@fb.com,
	hare@suse.com,
	jejb@linux.vnet.ibm.com,
	martin.petersen@oracle.com,
	khc@pm.waw.pl,
	davem@davemloft.net,
	arve@android.com,
	tkjos@android.com,
	corbet@lwn.net,
	mchehab+samsung@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 04/13] firmware_loader: document firmware_sysfs_fallback()
Date: Tue,  8 May 2018 11:12:38 -0700
Message-Id: <20180508181247.19431-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508181247.19431-1-mcgrof@kernel.org>
References: <20180508181247.19431-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599920593079167983?=
X-GMAIL-MSGID: =?utf-8?q?1599920593079167983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This also sets the expecations for future fallback interfaces, even
if they are not exported.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/fallback.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 3db9e0f225ac..9169e7b9800c 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -662,6 +662,26 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_flags)
 	return fw_force_sysfs_fallback(opt_flags);
 }
 
+/**
+ * firmware_fallback_sysfs() - use the fallback mechanism to find firmware
+ * @fw: pointer to firmware image
+ * @name: name of firmware file to look for
+ * @device: device for which firmware is being loaded
+ * @opt_flags: options to control firmware loading behaviour
+ * @ret: return value from direct lookup which triggered the fallback mechanism
+ *
+ * This function is called if direct lookup for the firmware failed, it enables
+ * a fallback mechanism through userspace by exposing a sysfs loading
+ * interface. Userspace is in charge of loading the firmware through the syfs
+ * loading interface. This syfs fallback mechanism may be disabled completely
+ * on a system by setting the proc sysctl value ignore_sysfs_fallback to true.
+ * If this false we check if the internal API caller set the @FW_OPT_NOFALLBACK
+ * flag, if so it would also disable the fallback mechanism. A system may want
+ * to enfoce the sysfs fallback mechanism at all times, it can do this by
+ * setting ignore_sysfs_fallback to false and force_sysfs_fallback to true.
+ * Enabling force_sysfs_fallback is functionally equivalent to build a kernel
+ * with CONFIG_FW_LOADER_USER_HELPER_FALLBACK.
+ **/
 int firmware_fallback_sysfs(struct firmware *fw, const char *name,
 			    struct device *device,
 			    enum fw_opt opt_flags,
-- 
2.17.0
