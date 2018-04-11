Return-Path: <edward.chang.mcs@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523428735; cv=none;
        d=google.com; s=arc-20160816;
        b=iZT5l1FZHUs7p+AjTUPaE9lW63S+/S9ycsSpkUOlfmzzvGs9zDyOlsWsz//3mtXDjk
         MDVrI1IMtyAeh2K3n0DgcZD/AlqaNx0TvsiW2KZsy5jP4ipa+Wgi3yvygslBoaA1IFTt
         P+jgyy0J44WfZx+tZUH48+piChlzed+qi99R5VqzuJvJZcb0wkUBH95dQ07KSTUYg106
         x6dB2e25fSV1S6w0bZmcqisCDxBeZ4PB6JIIQeI2PwCOQyBH72kiAEZ9xAgwgwEuH5Bv
         CWhxbgihfQA6cIUaqS5y+/BO4ntqDxYSoeK+47Enj7CemcYIF2Iif2sE2ZOyfbIP0OoA
         J1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=+UqLpToAxARE351WdQJa13Y4ytosOgnkpb/Y99Jr6fw=;
        b=n6remCVqmXXoWzdZHi1nDUP/jJbMFK1ykKfSaHt2AKCyPFRvTT7SRU4Z+GCbJeQZXU
         M8TZV5yqyPMLK+O/4pNaaOKL3IOfXrIMj4VDSapW6PaciAMJzmbImFJtMTq0NKOedo51
         KrwnBkiuV9NdGE7lb2mQTXXoVeshCuDmkSKaN1nx4hpRWXPcQZNv/c5ahkx3TSF+34e8
         ZlGF4/IpibeLwPSf3hbM9JHcdyNvmsKZjivlBrsbufkXFdGL09NlzK05c6koZzUA4RpL
         h9lK/SSRoPdXZmjrqvUDz+/ZZtQ+WEoRna8Ysv4RLUJiZBDMOG8MdP8rgkr4Opr9Nfig
         cMKw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pSyDlUFb;
       spf=pass (google.com: domain of edward.chang.mcs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=edward.chang.mcs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pSyDlUFb;
       spf=pass (google.com: domain of edward.chang.mcs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=edward.chang.mcs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/t4R+s8C75AQS1ILN2QM325J/b/hj/YSEPj9SRYjhZwfC4FKB2fU4sHrIAJDTNX9I0lQiNtA==
From: Edward Chang <edward.chang.mcs@gmail.com>
To: johan@kernel.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Edward Chang <edward.chang.mcs@gmail.com>
Subject: [PATCH] usb: serial: option: add HP LT4220 support
Date: Wed, 11 Apr 2018 14:36:52 +0800
Message-Id: <1523428612-2911-1-git-send-email-edward.chang.mcs@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597430809989446970?=
X-GMAIL-MSGID: =?utf-8?q?1597430809989446970?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds support for HP LT4220

Signed-off-by: Edward Chang <edward.chang.mcs@gmail.com>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index c3f2522..d866cc0 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1927,6 +1927,8 @@ static int  option_probe(struct usb_serial *serial,
 	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_6802, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_WMD300, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0x421d, 0xff, 0xff, 0xff) }, /* HP lt2523 (Novatel E371) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x03f0, 0x0857, 0xff), /* HP lt4220 */
+	  .driver_info = (kernel_ulong_t)&telit_le920a4_blacklist_1 },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
-- 
1.9.1
