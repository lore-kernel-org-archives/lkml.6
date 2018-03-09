Return-Path: <anholt@anholt.net>
X-Google-Smtp-Source: AG47ELuHWkVpy/IaYjvWRUrTr54r/COQpPhT9wqnNU6M2Hv3Gwc05s34jzulIgJcqAA7f2XaclIt
ARC-Seal: i=1; a=rsa-sha256; t=1520621065; cv=none;
        d=google.com; s=arc-20160816;
        b=fgOhlt32J4AF7Oe2gpMyPrG6gIfsQ0c5sxkPqfwdbIr9wZSFJ1H3DSNGFHwsjXRvTf
         Sf3DxPDFOpe7AL0AOJVjM0HpEUqIt2nndDRHJEJ+/FSdKbTjNhQGzVaz6TOGqWgjqplr
         EX1Eq9tFwaLUwQuvxM6tCUT6ArVWiLwkkhIin640a086oKpCPedWzuhfA/odec1Gq0Tf
         v8jtFpW1wk1LArcTdQijGpGklpXal37kz5FV11mYTh15hq2iU+uWmNYnFU14c+vHkS8h
         XM0Z+z2diQD2/V7NvojfRvqBJqy0SR/wA2jiBHksjujUVV3UBoPiB6+unPd3amrTy8Zr
         y2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=26fP4VgVcX6cEgW3teBx/xeK6mxqOyAaylDtqLPae6Q=;
        b=DUdZXZXKpHv3ZOtIsBDc5zmJq3UNG63zuYOr93lFjNmfqMhqqr5Ot1WR8Yiyavad6R
         n0Z8uor4cTGf++JkJez/6D27JXcNm6J3f/aKvaKYfrarbEuK5+7wsQJixrvW0XTUEaKn
         S08CVZixrvOY96pRip9tLg0Ean24ylKwYNc3uRO1JhzqtCJOC3/HfwPt4tZCUf3CoVho
         dXi89Ir/wkWQhLgDMUZboKHKe73X0WOK8Vpn8syl/k4eSYH6xe9/WZ2qnxXbMut7/ilm
         1LrUFrAT8Drs09GbECu2Gy+55PCKSMWnu1HsAUp/ZxQDUYNErqkRKff3aes3vOIwCBdu
         I19w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of anholt@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=anholt@anholt.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of anholt@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=anholt@anholt.net
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Phil Elwell <phil@raspberrypi.org>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Eric Anholt <eric@anholt.net>
Subject: [PATCH v3 6/6] staging: vc04_services: Remove vchiq_queue_bulk_{transmit,receive}.
Date: Fri,  9 Mar 2018 10:44:17 -0800
Message-Id: <20180309184417.23368-6-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309184417.23368-1-eric@anholt.net>
References: <20180309184417.23368-1-eric@anholt.net>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594486754141065715?=
X-GMAIL-MSGID: =?utf-8?q?1594486754141065715?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These are dead code, including in the downstream Raspberry Pi tree.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2-3: no changes

 .../vc04_services/interface/vchiq_arm/vchiq_arm.c    | 20 --------------------
 .../vc04_services/interface/vchiq_arm/vchiq_if.h     | 10 ----------
 2 files changed, 30 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 8068c0308b34..24d456b0a6f0 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -406,26 +406,6 @@ VCHIQ_STATUS_T vchiq_open_service(
 }
 EXPORT_SYMBOL(vchiq_open_service);
 
-VCHIQ_STATUS_T
-vchiq_queue_bulk_transmit(VCHIQ_SERVICE_HANDLE_T handle,
-	const void *data, unsigned int size, void *userdata)
-{
-	return vchiq_bulk_transfer(handle,
-		VCHI_MEM_HANDLE_INVALID, (void *)data, size, userdata,
-		VCHIQ_BULK_MODE_CALLBACK, VCHIQ_BULK_TRANSMIT);
-}
-EXPORT_SYMBOL(vchiq_queue_bulk_transmit);
-
-VCHIQ_STATUS_T
-vchiq_queue_bulk_receive(VCHIQ_SERVICE_HANDLE_T handle, void *data,
-	unsigned int size, void *userdata)
-{
-	return vchiq_bulk_transfer(handle,
-		VCHI_MEM_HANDLE_INVALID, data, size, userdata,
-		VCHIQ_BULK_MODE_CALLBACK, VCHIQ_BULK_RECEIVE);
-}
-EXPORT_SYMBOL(vchiq_queue_bulk_receive);
-
 VCHIQ_STATUS_T
 vchiq_bulk_transmit(VCHIQ_SERVICE_HANDLE_T handle, const void *data,
 	unsigned int size, void *userdata, VCHIQ_BULK_MODE_T mode)
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
index 0e270852900d..e4109a83e628 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
@@ -149,16 +149,6 @@ vchiq_queue_message(VCHIQ_SERVICE_HANDLE_T handle,
 		    size_t size);
 extern void           vchiq_release_message(VCHIQ_SERVICE_HANDLE_T service,
 	VCHIQ_HEADER_T *header);
-extern VCHIQ_STATUS_T vchiq_queue_bulk_transmit(VCHIQ_SERVICE_HANDLE_T service,
-	const void *data, unsigned int size, void *userdata);
-extern VCHIQ_STATUS_T vchiq_queue_bulk_receive(VCHIQ_SERVICE_HANDLE_T service,
-	void *data, unsigned int size, void *userdata);
-extern VCHIQ_STATUS_T vchiq_queue_bulk_transmit_handle(
-	VCHIQ_SERVICE_HANDLE_T service, VCHI_MEM_HANDLE_T handle,
-	const void *offset, unsigned int size, void *userdata);
-extern VCHIQ_STATUS_T vchiq_queue_bulk_receive_handle(
-	VCHIQ_SERVICE_HANDLE_T service, VCHI_MEM_HANDLE_T handle,
-	void *offset, unsigned int size, void *userdata);
 extern VCHIQ_STATUS_T vchiq_bulk_transmit(VCHIQ_SERVICE_HANDLE_T service,
 	const void *data, unsigned int size, void *userdata,
 	VCHIQ_BULK_MODE_T mode);
-- 
2.16.2
