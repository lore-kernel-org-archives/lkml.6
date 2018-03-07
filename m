Return-Path: <anholt@anholt.net>
X-Google-Smtp-Source: AG47ELtBTjok65jTtFMxV11gD5m98vqYKBbBgt4vvRs1Ixv4H2G6RYGxvSgPz4mhb2tEqphWCEPj
ARC-Seal: i=1; a=rsa-sha256; t=1520449044; cv=none;
        d=google.com; s=arc-20160816;
        b=L7kCMCOupU72CW3mn5yF6p7yACFatM4c2gKm7HaLk8MoQ0iG2mRh/IIpG6XUiPRU2Y
         4qQMlCxsjJ1OVEpH21/j7gok29gIyi9qA8ItamhzySXxzd/+9ZiE+59UoHZX/FMplsZB
         oexMtSr1gGVtVYygkAjOw+Rn6zm77ao2OiWZNk/VBlUgtcFXbl2zNqNJs3jXrXvipnzL
         7XMTXVasDrILIi0Pw9qNSuzdRFeMpB7thFJP1eOyDO/PYfQHBxqEKqn3H6YxnRP0zOwY
         GaNEQevfBDjzF5HDxTlbgyznBdV8uZ78DTAwUHPmuVXwh2aKMjFGHex6clUD0Pspx4HY
         EoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=JQY3o8jzxrbq8UB405mu45aCZYCGtgTwVb/W47QBJY0=;
        b=VieEDdSiFRxK95tPltR/pPCO7UF3XTevsZf40Uvo5pqAySg+cBr6DDmnZ5rqAN3MYS
         T1gNHl85ZN/KwJFt9g3tBlUxMVqC63THXNQapqmUXL0LvcJj1U92+Qz3UDva25VrY79A
         ayJi5A4eggDYEcDHFOxCmZgDYHmIHVoaebZ+Wxa8ouURydOnuACBOmILz6St2kKzIUDk
         ePkUxYoSMwPUnkASJjAT//lwp7RaM0GhCqkwERJmBwqlPos2AgET6jULVeWK/2S/El8a
         CCTmdPfMTTMlD+uj6XripqeiFWi108zAAYzM7gq/qw4dYbnHwOx2t8GkVG3mvTsOQrga
         VyFA==
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
Subject: [PATCH v2 6/6] staging: vc04_services: Remove vchiq_queue_bulk_{transmit,receive}.
Date: Wed,  7 Mar 2018 10:57:16 -0800
Message-Id: <20180307185716.17449-6-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307185716.17449-1-eric@anholt.net>
References: <20180307185716.17449-1-eric@anholt.net>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594306377648584033?=
X-GMAIL-MSGID: =?utf-8?q?1594306377648584033?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These are dead code, including in the downstream Raspberry Pi tree.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
v2: new patch while I was looking around the code.

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
