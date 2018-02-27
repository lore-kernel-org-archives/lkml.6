Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x224lNQsD01s/+kIAf/eu2KseJxjNqFzfdbJwoyweOOvkR5dkxbc0R0IU6YXV6W9kexXxtgrr
ARC-Seal: i=1; a=rsa-sha256; t=1519773668; cv=none;
        d=google.com; s=arc-20160816;
        b=wG1BZqspWSTRqwcSmiHTB74tXyLqsluBQrErr7TcM1i2jNxNagSvRRNDqoaHN4vu95
         KAaNcp7tkkGt4uYMc5zESD+X9LoniCGtC/U0rlokhT6g5e/3gLI/+wSp0Wr2hZiifVJF
         RvLQLWQVayM5fayKdj1T1RzBLKDZ7hvydACGxO+gQSygE5RBDHs+LiLsxvDtVZ90MCPl
         VJ0k8MYEASzwEH6nsceqhw6CFmclO0heRC9ZpzuNSb5yO2AQ/RxSP/TpHiLHcKQWvyDp
         DIwLUz1xQoOl1+jPCsZF8nFtQX2B/vGUmHD1GnRKEAOxDxct/mMGxYVMvnCU9UYnvTww
         uefw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=jlB+M3zFO+R0GiAMpiMEPvtZfRQ02/v9XPmH/lU9U38=;
        b=z1kSpc7AefTWHFN0bC/2+e2+BXiPj24L/WK7xi/o6mnaormkdSHeBdoauEDWbjQXRs
         ODw5IphAdikPSKFH/0+ccWAH2w4uX2SsNeNl3Vt1rylijCyfXrdFIwOut1jt41Vou6/S
         /pCXhRzHC7jp6xJPj1BXSqtYrKCDA0ShyZ7G1r97Ln3wNCp/4QDnxTf+OWk1qxi5tND1
         cjsm8lt5nswSO7L1kGc2zFXw036N8Hqi4VvQyEEDsRe8IQg6CoetMuQG/YBSNFtL9eXf
         q13vRdu2Q/ml+ZDysnLTQiRQELg4+rbk1xjI3guxn5hRb7dN8qyzwPWMUV6uFl9kzBA5
         bucA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CAE217AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: cantabile.desu@gmail.com
Cc: kubakici@wp.pl,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	linux-wireless@vger.kernel.org,
	keescook@chromium.org,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	zohar@linux.vnet.ibm.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	stephen.boyd@linaro.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFT 1/7] rename: _request_firmware_load() fw_load_sysfs_fallback()
Date: Tue, 27 Feb 2018 15:20:55 -0800
Message-Id: <20180227232101.20786-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180227232101.20786-1-mcgrof@kernel.org>
References: <20180227232101.20786-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593598193855582168?=
X-GMAIL-MSGID: =?utf-8?q?1593598193855582168?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This reflects much clearer what is being done.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 Documentation/driver-api/firmware/fallback-mechanisms.rst | 2 +-
 drivers/base/firmware_fallback.c                          | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/firmware/fallback-mechanisms.rst b/Documentation/driver-api/firmware/fallback-mechanisms.rst
index 4055ac76b288..f353783ae0be 100644
--- a/Documentation/driver-api/firmware/fallback-mechanisms.rst
+++ b/Documentation/driver-api/firmware/fallback-mechanisms.rst
@@ -112,7 +112,7 @@ Since a device is created for the sysfs interface to help load firmware as a
 fallback mechanism userspace can be informed of the addition of the device by
 relying on kobject uevents. The addition of the device into the device
 hierarchy means the fallback mechanism for firmware loading has been initiated.
-For details of implementation refer to _request_firmware_load(), in particular
+For details of implementation refer to fw_load_sysfs_fallback(), in particular
 on the use of dev_set_uevent_suppress() and kobject_uevent().
 
 The kernel's kobject uevent mechanism is implemented in lib/kobject_uevent.c,
diff --git a/drivers/base/firmware_fallback.c b/drivers/base/firmware_fallback.c
index 13fa5ff2b46c..ce7ccfe82c69 100644
--- a/drivers/base/firmware_fallback.c
+++ b/drivers/base/firmware_fallback.c
@@ -536,7 +536,7 @@ fw_create_instance(struct firmware *firmware, const char *fw_name,
 }
 
 /* load a firmware via user helper */
-static int _request_firmware_load(struct fw_sysfs *fw_sysfs,
+static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs,
 				  unsigned int opt_flags, long timeout)
 {
 	int retval = 0;
@@ -621,7 +621,7 @@ static int fw_load_from_user_helper(struct firmware *firmware,
 	}
 
 	fw_sysfs->fw_priv = firmware->priv;
-	ret = _request_firmware_load(fw_sysfs, opt_flags, timeout);
+	ret = fw_load_sysfs_fallback(fw_sysfs, opt_flags, timeout);
 
 	if (!ret)
 		ret = assign_fw(firmware, device, opt_flags);
-- 
2.16.2
