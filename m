Return-Path: <jmoreira@suse.de>
X-Google-Smtp-Source: AIpwx4+fJVxwU5Mlp71zi6FvuJ8SpZd4cEHsyURtwiqFVnp7fONMH8GRo8RZDPAfOsHnKuL71x5E
ARC-Seal: i=1; a=rsa-sha256; t=1523765759; cv=none;
        d=google.com; s=arc-20160816;
        b=rafrMxA3oCuc3Gz/nLoy/sXRAys72TQHxHf1WCn66aCl79/XSceeWqLNmCreft/th9
         LmXyNbb4C+hF2ZnpelzTaR6rZn6lU95iFK5uQdLCMRmQ7yLddAkWAPkkmCgqV5Hz6jwe
         UBYfBdXJYGm+aIGMdpSPymmsqOFeFtJEn3p5pUoXzK7T+Sby3nuIxRN1YXHNekBc+j17
         rXTc/vWhFLvEO57hMmbFNNe3BWhNPkfQKgouMZx7zeIzFdG+e/zJNyE6Kwmy77I6AzjF
         pyrnS3xJm0jFARc+mYOnQ5D9Flfydv+dmUli/oWPGHPkZ46SfHOEuZSf989dTlZ+QMr/
         wxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=gUfK/nIWH2WZ0cPWzHMVPOKuG2+XZpBJalyPPG4TMJ4=;
        b=kt3NloiVGluIPViKSP7yLPV/0w2CaDkEZMrDJWDMVVGBbzqZWtmS1LTDS74538ZlVO
         euUgpnk8zocqRWGpoiKmyy2bP7pHGUfBe5070zLv3N0SM2ler7vGbUTgd1e6aq1jtW+q
         XyNq9z/9QDRrVW6+Dhnz/NwbB7Zut0QFE2SmmY5+duJfL8nDu1lLLcOiSHXjXP7B4gn8
         wCaZV2I3CQOV+THapAwI9iP1A/llsEAqvbJXmKutUSGFt0nYrDWHfeKHQCWNMSYB/rX9
         vVm/eIUotKoB23DuksxH2TW17jf45Bh0uzkJsYOlsx9hf/gGAVYSX0N5hfWE6u8QqRFr
         WuHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jmoreira@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jmoreira@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jmoreira@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jmoreira@suse.de
From: Joao Moreira <jmoreira@suse.de>
To: kernel-hardening@lists.openwall.com
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	hpa@zytor.com,
	gregkh@linuxfoundation.org,
	keescook@chromium.org
Subject: [PATCH 2/4] x86/crypto: cast6: Fix function prototypes
Date: Sun, 15 Apr 2018 01:15:40 -0300
Message-Id: <20180415041542.5364-3-jmoreira@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180415041542.5364-1-jmoreira@suse.de>
References: <20180415041542.5364-1-jmoreira@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597784205440592889?=
X-GMAIL-MSGID: =?utf-8?q?1597784205440592889?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Convert the use of 'struct cast6_ctx *' to 'void *' in prototypes of
functions which are referenced through 'struct common_glue_func_entry',
making their prototypes match those of this struct and, consequently,
turning them compatible with CFI requirements.

Signed-off-by: João Moreira <jmoreira@suse.de>
---
 arch/x86/crypto/cast6_avx_glue.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/x86/crypto/cast6_avx_glue.c b/arch/x86/crypto/cast6_avx_glue.c
index 50e684768c55..f4e05388fbbb 100644
--- a/arch/x86/crypto/cast6_avx_glue.c
+++ b/arch/x86/crypto/cast6_avx_glue.c
@@ -41,20 +41,16 @@
 
 #define CAST6_PARALLEL_BLOCKS 8
 
-asmlinkage void cast6_ecb_enc_8way(struct cast6_ctx *ctx, u8 *dst,
-				   const u8 *src);
-asmlinkage void cast6_ecb_dec_8way(struct cast6_ctx *ctx, u8 *dst,
-				   const u8 *src);
-
-asmlinkage void cast6_cbc_dec_8way(struct cast6_ctx *ctx, u8 *dst,
-				   const u8 *src);
-asmlinkage void cast6_ctr_8way(struct cast6_ctx *ctx, u8 *dst, const u8 *src,
-			       le128 *iv);
-
-asmlinkage void cast6_xts_enc_8way(struct cast6_ctx *ctx, u8 *dst,
-				   const u8 *src, le128 *iv);
-asmlinkage void cast6_xts_dec_8way(struct cast6_ctx *ctx, u8 *dst,
-				   const u8 *src, le128 *iv);
+asmlinkage void cast6_ecb_enc_8way(void *ctx, u8 *dst, const u8 *src);
+asmlinkage void cast6_ecb_dec_8way(void *ctx, u8 *dst, const u8 *src);
+
+asmlinkage void cast6_cbc_dec_8way(void *ctx, u8 *dst, const u8 *src);
+asmlinkage void cast6_ctr_8way(void *ctx, u8 *dst, const u8 *src, le128 *iv);
+
+asmlinkage void cast6_xts_enc_8way(void *ctx, u8 *dst, const u8 *src,
+				  le128 *iv);
+asmlinkage void cast6_xts_dec_8way(void *ctx, u8 *dst, const u8 *src,
+				  le128 *iv);
 
 static void cast6_xts_enc(void *ctx, u128 *dst, const u128 *src, le128 *iv)
 {
-- 
2.12.0
