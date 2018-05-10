Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZqWUR/lrvDzQuqkOX1abZdUDhxx8+CZ13OOvlneL8c60FZhwGDj77vD/umkGNYHGYJjqDTF
ARC-Seal: i=1; a=rsa-sha256; t=1525982940; cv=none;
        d=google.com; s=arc-20160816;
        b=Q/EH7OhxsRClIgQD2mNttNmIvn4WQ+Pem/G4NgA69iVqVX+R9BNwztL4Yqvn4WarrC
         ZFLN4o1MfS/WbEPk4NW7Bp5zLI0qbTXnvfRbUouZY3Odli+zHO59S1gp7+L6834l6/W1
         /yraXwuL5D6PuugviIn+WUCyoXDbUcdlRA0cEY30pWnegde4WF5bfdi3BikWo46YRwTm
         NG0mfx3uaN+hKA84OdRef3smKqlS3ahGnhHn20UCZ1147VNvLfUkO55A/hG8YP1RfU3L
         e9xeRcP41XDanilxS6Cdk99iaI+080X0fyX5eCM5kgLDrNLYA37SR0vj6lNhnzXuDAV3
         JxrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=kCNo/ZLjAnK3VkdZf5rqX7ZN5Tnmwb9VZC4IVBhswWc=;
        b=FGyyJXDVlDtLJ1L/XC58z7jD/Ca34dA6SmI6PcUmDijRedRgGVdrVcUguVPONLhcAD
         JkStsMdO7gOdArQefic1J1YdWC2Ptjj5aNEwbzlC5ZJATXquHv7F0+ykMFK6eqw89pFz
         19jjKo8fN0If22dqduSq7belNjRbs1DMrA+UHCifqe9ymVmbDX4N1sFvYKBqSGiYUx7/
         MxamhCduyMYJt40nEtjxVRaRL+HA0PdCafVP46KwFMMJj3eiI4ZVTRt162YTN6EzmfID
         0mQMau/01uXpoTKoA8uJDHswY65cCdo53riqYDsXSryaF0kmSBBddXHaIYtbumgFdRo3
         cDug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=m84HTz8Z;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=m84HTz8Z;
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
	khc@pm.waw.pl,
	arve@android.com,
	tkjos@android.com,
	corbet@lwn.net,
	mchehab+samsung@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v7 04/14] firmware_loader: document firmware_sysfs_fallback()
Date: Thu, 10 May 2018 13:08:40 -0700
Message-Id: <20180510200850.5958-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510200850.5958-1-mcgrof@kernel.org>
References: <20180510200850.5958-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600109087744907232?=
X-GMAIL-MSGID: =?utf-8?q?1600109087744907232?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This also sets the expecations for future fallback interfaces, even
if they are not exported.

Reviewed-by: Kees Cook <keescook@chromium.org>
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
