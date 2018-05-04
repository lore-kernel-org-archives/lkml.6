Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZq8LXR4d7Qt7X7A6TScAqK+21Um1JOtil2ZJ9a1O6M7N8kauNPeAhPkvIhkitSUcvAFOv4T
ARC-Seal: i=1; a=rsa-sha256; t=1525455845; cv=none;
        d=google.com; s=arc-20160816;
        b=o24PgHch0sIV7iOtfLla3pic6CViGa4TcYf4yEKKEtH/xN5wtE2K3RDFv/fyxPvRg2
         ub3/k/gwYUdYuf3/pVKDkp8fo/SHK2czGA298vrc57vyv3WB2kg3fTNbPRs8QhXQeBNt
         KGNozK6My3jfcZp1ac+gPWnsEZH+cyJHicvgjxHJa5RWmT81dAUw8qQxRNhsiAzenQCB
         slMB5QTXuHJ8vQjmBqyfbyM2SwkdcfGMxpaqAJnbJuhrvpkH2FbCNtP/o58EX5M9yflg
         v4WY2uLaNZxC2Kza1RHPV2DmrcL/Ljpun7EiWaOZAdxnMAmARRMl1TrS2mM956Dv30W4
         oscw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=N2w39fn0qSCONAahVlt03Xn4D3c00ai389PcHOx8/pA=;
        b=0ICf58NjpZvOreKvmZ2Ysfw8sdUKH4hf1n+jsixRbkjlVzALrrki0st9k0QzICQHTm
         IL1Jnj6zDr4sApYWOc4VADQYwtuBaW4Wwqth7sR9qK+Wgs9UJd8/fsCZciWdFicMWvyO
         dQXg8lzUHDxmX3S6ll1uo4+TUYuVuTpLL9aH0XG7xbDMGQrca3gXcxgjtpzIMU41nNM/
         2w/VoOdl4eV5/KOfdTCADUI6HW7bAvkw1lYERbgUvT8X+r5TqL2qCrfoLGQrBmasLvER
         rEBOcQVtFzIUkwCG7vhkNJzeM5Kg8cQpbtcMd5kSQx+nwXEtrFGIRrcuNLpgiwpjYZaI
         M+GQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ipVHdk/6;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ipVHdk/6;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	keescook@chromium.org,
	josh@joshtriplett.org,
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
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	cantabile.desu@gmail.com,
	ast@fb.com,
	hare@suse.com,
	jejb@linux.vnet.ibm.com,
	martin.petersen@oracle.com,
	khc@pm.waw.pl,
	davem@davemloft.net,
	maco@android.com,
	arve@android.com,
	tkjos@android.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v5 4/6] firmware_loader: document firmware_sysfs_fallback()
Date: Fri,  4 May 2018 10:43:53 -0700
Message-Id: <20180504174356.13227-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504174356.13227-1-mcgrof@kernel.org>
References: <20180504174356.13227-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599556389324801881?=
X-GMAIL-MSGID: =?utf-8?q?1599556389324801881?=
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
