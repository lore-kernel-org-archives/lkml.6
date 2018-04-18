Return-Path: <colin.king@canonical.com>
X-Google-Smtp-Source: AIpwx48f342v4+ywM7/euFN9e7GvOedbHqsAoUf9IJwimPjC5uULBigE5Kxc4wkv7PU2GTgjXriN
ARC-Seal: i=1; a=rsa-sha256; t=1524050469; cv=none;
        d=google.com; s=arc-20160816;
        b=G+Jp9udSMSZizeZSdsGsDPjAxLOBraVIHVszosbFRG9uYxBX4fCmccx8fEtOYu9IFc
         VvpZdKUrSDOYek/HIyI4qT6wSXNRkNmXn0C88in7dmvbzue0AGPEQfBxKhA2LaDE1vso
         /L31yQECm7fUituVlCZHI5u5FOChzc446bv7SpNv+bd0X+w6DAERRVoTOMpNdJImyjms
         YiAxb6J3Xjl3qn48A3nEN2Dtg8Erbl2sGnQmXGTr42uk2oIlxAWiFvETDhz9Ex2D0dnr
         Ur0fRgB5LtGYIwwEzQWTVg6weA9mTTd31TdCRTro1jfMx82Bzy7C6NE6AIme4PSINoqb
         XWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=JyCzWionmLIby3M9G4xRx9nVBZyD0xjwn+jMHWx29W8=;
        b=wfyo/9u1FGtV8hdpdNq8XvtMPOVpfSqYPaSFACHz12ObVZOoWef8pp8eUtY2YmUTRs
         2RRxaM1A52Cw/Vwue2++VojeB5Z/QnZs85dHEhOIXXSkAD1vnEPn0ej3YqbPKOJi0Lkz
         1Jkmu2OBoV8rYxV+ujYOExRV7c2pf+nIR5Z/2FhgIsCnKc7T5vnKfoIH8Dv8HiJdz2TA
         f/NBTi3na0uJmR/XXcw6VOYq+Z17n8ELBCsVPjrN5xSMITLymOMf4AcdJihc+1dNrXjp
         THSHhkBtdMQhm0vX0AVPfo5JEMgPI7iFuUB90pVm2S8CMCeuCiHFXd0WVcdiomVA+sJo
         1SbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Colin King <colin.king@canonical.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-integrity@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm/st33zp24: Fix spelling mistake in macro ST33ZP24_TISREGISTER_UKNOWN
Date: Wed, 18 Apr 2018 12:21:05 +0100
Message-Id: <20180418112105.894-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598082745288242263?=
X-GMAIL-MSGID: =?utf-8?q?1598082745288242263?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Fix spelling mistake, rename ST33ZP24_TISREGISTER_UKNOWN to
ST33ZP24_TISREGISTER_UNKNOWN

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/char/tpm/st33zp24/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
index 0fc4f20b5f83..d7909ab287a8 100644
--- a/drivers/char/tpm/st33zp24/spi.c
+++ b/drivers/char/tpm/st33zp24/spi.c
@@ -40,7 +40,7 @@
 #define ST33ZP24_OK					0x5A
 #define ST33ZP24_UNDEFINED_ERR				0x80
 #define ST33ZP24_BADLOCALITY				0x81
-#define ST33ZP24_TISREGISTER_UKNOWN			0x82
+#define ST33ZP24_TISREGISTER_UNKNOWN			0x82
 #define ST33ZP24_LOCALITY_NOT_ACTIVATED			0x83
 #define ST33ZP24_HASH_END_BEFORE_HASH_START		0x84
 #define ST33ZP24_BAD_COMMAND_ORDER			0x85
@@ -84,7 +84,7 @@ static int st33zp24_status_to_errno(u8 code)
 		return 0;
 	case ST33ZP24_UNDEFINED_ERR:
 	case ST33ZP24_BADLOCALITY:
-	case ST33ZP24_TISREGISTER_UKNOWN:
+	case ST33ZP24_TISREGISTER_UNKNOWN:
 	case ST33ZP24_LOCALITY_NOT_ACTIVATED:
 	case ST33ZP24_HASH_END_BEFORE_HASH_START:
 	case ST33ZP24_BAD_COMMAND_ORDER:
-- 
2.17.0
