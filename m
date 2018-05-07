Return-Path: <j.neuschaefer@gmx.net>
X-Google-Smtp-Source: AB8JxZpxPKYlLFTPGz5R1VtirIIGym3wfskei8jBGST5ko4dGz7Myx0KMwronCBC6dF4PUVLGXtI
ARC-Seal: i=1; a=rsa-sha256; t=1525703233; cv=none;
        d=google.com; s=arc-20160816;
        b=O9Lhb0KCFk+dOVqlEPHdeaPA+x37kqObdpfRp409dk+ql75gv8YJr9q5mUJO6WrohU
         RDSWWe7rkuqyMbnKt1Sm5js78wB7mNg1pTAOSIgldAG6AIcyJYn1i2xuAer/DlxlBnkf
         kb39APZQSM76AoBzKlObHL0JpeSGXo4yA+6cJCERNWMoal4heMftJ7qs5AMlcX+xY4pT
         yVH9Q9IXSU4kTzMnsrzAFWTz0wX1iKGtaFJMfALlAUTnYPZB7TaBueyj8j5TjgEzxxja
         YTryytDojtfNUHgz4Q9OEdjnK6BIC0fph0PrPwEjY3dRcFj3xeUw+UJxdw5pYrxWEifw
         avHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=1T+CIUJqVAO8yjbvRkE1tUjjbcZpGnix1nt+skxiJCs=;
        b=Qi0o5NCs3enfgVOy5U9WJboNEG6hP5V3ICWmiPGiF9WgS3Fi4jpOhO+xW0mTnLatDy
         u/pGQHvd1W3obkzmXkoaksfIqo/ywczCpesmiATGCRT9mM+TRkCZw231ss8c0VMJOs8U
         XSm46BPq8n+bFC8v163RYVS7KzXHEJjd6hyrGR6PUTFzRUoUYSciThPxpA6sEh3Sa0Kp
         sllL+ggZEHc73Z1ll1PUyBpyiI6IAsF3FNEov+V08tQtKJFGdx1IuYDBM0ZIUjLmynvi
         ncBqXV4kShdjDH1WC6q1B/htDvVVO4Y3MEUKMAxlwuxnfkhdSS6TFnh84IemG79/BRqA
         hp9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.15.18 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.15.18 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Benjamin Gilbert <benjamin.gilbert@coreos.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] powerpc: wii_defconfig: Enable Wii SDHCI driver
Date: Mon,  7 May 2018 16:20:18 +0200
Message-Id: <20180507142019.32669-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180507142019.32669-1-j.neuschaefer@gmx.net>
References: <20180507142019.32669-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RdViI4pNs5wyTGA5a4KVMoafm7PaShTkJvP5KK99aoz5WI/JH1s
 wvGC4aQXVAjjuVNaeu0x4VUdSH62IAABCEMH7G1bfkFIZ/ilw/+1vpp47dnFyVaVCNiH2cZ
 ciLzR1V8ZlvU9Gln0mSkEnOpOqC1YSb4g6CxT0uAwvBSghX/Uj+vA/WAQiVsrMVhdr3+pic
 30p/zxu0M2iMe3K6HmEFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DWkLg39YQZc=:KR2DE9UB5owGZfPvFJcvCC
 ON+z9bs3j48+vhSF5xxleaZPgey/66DFgtTw3nOGDvXb/6ljbwEprugO1zDiphzQcUBfAPLap
 G1M0noMGccZSrrPxpYEQFEasJ+8udZwWG5v/mi5+piGwXe+55NAPKulRGFUxHx6g76I+3xS9k
 gW/VFg3Xkw0acrOJ3H/aMpzPgHSphd4FPFjkzDXBdzIWCFrm+71NUbYzt/DTu7PJaVjKeolx4
 CSM89NxCzUexKDTodmqYiDynXXGRbEsQnJyzkV70KpNXG1nReZFAKH66F+iqv5ONW2LbOymag
 qKXJvUdLSkieDntjwg0ASD1z+n8XSWG2k44Idl5aHAKfhMvSvnkNLBd13pEPh+OqGy6JDoJ6l
 tYaFZtPMfdExkxjJPWcopX2uJwqj2kHUUXhFlpft3AvyP0WW7KGkMcbXutLgcgfQxJ4WxzFrN
 Gau3w9RiM0c9hCukkySbGJndMdt6DsNJx8nssaiT1cy0k6xoi6HgtUMa7JNf+2lUiyBYu+riD
 FUDni/nJmwTSP8+XihxIDP6ZTdRxkfpoohDc5JVtPfkYUeotmNUKELBarsWj76MZBQnCqOnmm
 uLxbQnqT2DoWk2pr4idG08f8A3PxcOtfL7DiRZ8O9+N9j6h/wkqSUp/ghWH/WKw616VxPF/zQ
 vnuiSTnbV9VomzJjH5qrLWUKLL6QVcFJ4UfiqodxaO3DoYdKOCO1arcxg3Jvv4Ngg2ZuLiUIi
 9ZMs2rpBiLcajyvFJKWn/KXbNkwRK1JgVTd5pjBfMhoUuIoUDi9PcfP/1b83Ynw8K+QZZBQfH
 uI3qayL
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599815793281974776?=
X-GMAIL-MSGID: =?utf-8?q?1599815793281974776?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This allows access to the SD card and the BCM4318 Wifi module.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

Note that until some fixes in the interrupt controller drivers used on
the Wii, the SDHCI controllers will not be usable.

v2:
- Patch added to the series
---
 arch/powerpc/configs/wii_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index c5933a38e5ad..a674dd420f0f 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -93,6 +93,8 @@ CONFIG_HID_APPLE=m
 CONFIG_HID_WACOM=m
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_OF_HLWD=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-- 
2.17.0
