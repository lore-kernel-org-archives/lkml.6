Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607027; cv=none;
        d=google.com; s=arc-20160816;
        b=LZo2Ls/mIbHuGbrehtLSoMdAm1UffKsWXwfLFhCm2PuogOjwaQ8pFibLhZ3Pj9oX+n
         5U7hfFBZPMUf7YhCSaDhOyux/7HEOTfX/GzFoahjU3cyV8mLknczE7E/8TVXHN/iUS0q
         Tmh80fUEy/+T7FDKVxpDMn0GnCS817n2D/ZapStRQE4J9JfxMOrD6uOiAzPSolb7F3GH
         H35mG0Y7tytuI0ova1xbRgmvKsfKK3IcEwJ0O4JU89SgQR2VCHaDbtNFuM9hqWXBWhna
         vGJ72+OjtasD+JdiqbI6UW3qh4rW20PFWjl5b8EBqcNp2WeAS3Ix4PQZPZ9R+U3y/ld+
         A8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=vQR5gljnwr4aCOvufpueUZU1itTLbeOEfIMn7X2e+lg=;
        b=jlIviiNbY19G49lTxPvXcoscYfiqh8WZPYCK1JmbpQTlFUsek4OUpuryLafXRMT1BU
         n0irrWfixmjuD1pmGIHWKUlVAV6sBDK9bc6pB0EYncsfnRq4gbRiLSx9MPO7jxEmsccP
         rzkIWZjHDhIXaRuopnRSk7YanwGFrxDZ3DVe/Dc9Zh41Vg61R8mVK8lCaXSbAXP9qjPP
         g+YKphmdmBuNx7aEBlEE7HrTIqwciffpvj1V+jUVLKO6QSKKogZN4svAWeNXfnOrpa6I
         ofslQzjNUy15cAtKpaiyiSUPQ3kcFm3iMeUdE7iOzhwECj+fRBnz8D74ugh+ikhXcDjx
         wSCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=XZDZVI/N;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=XZDZVI/N;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELud03hBG+NqnQ83Hv7ry80UjUv7UvY838mn+LZhQ36zIrm5dCCQdzrvX/2Hyo2Xg/M+8ncfvA==
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Carlo Caione <carlo@caione.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	cphealy@gmail.com,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/25] nvmem: Document struct nvmem_config
Date: Fri,  9 Mar 2018 14:46:55 +0000
Message-Id: <20180309144719.29904-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472034648198957?=
X-GMAIL-MSGID: =?utf-8?q?1594472034648198957?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Add a simple description of struct nvmem_config and its fields.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: cphealy@gmail.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/linux/nvmem-provider.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 497706f5adca..a39f76ff2ccd 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -22,6 +22,28 @@ typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
 				 void *val, size_t bytes);
 
+/**
+ * struct nvmem_config - NVMEM device configuration
+ *
+ * @dev:	Parent device.
+ * @name:	Optional name.
+ * @id:		Optional device ID used in full name. Ignored if name is NULL.
+ * @owner:	Pointer to exporter module. Used for refcounting.
+ * @cells:	Optional array of pre-defined NVMEM cells.
+ * @ncells:	Number of elements in cells.
+ * @read_only:	Device is read-only.
+ * @root_only:	Device is accessibly to root only.
+ * @reg_read:	Callback to read data.
+ * @reg_write:	Callback to write data.
+ * @size:	Device size.
+ * @word_size:	Minimum read/write access granularity.
+ * @stride:	Minimum read/write access stride.
+ * @priv:	User context passed to read/write callbacks.
+ *
+ * Note: A default "nvmem<id>" name will be assigned to the device if
+ * no name is specified in its configuration. In such case "<id>" is
+ * generated with ida_simple_get() and provided id field is ignored.
+ */
 struct nvmem_config {
 	struct device		*dev;
 	const char		*name;
-- 
2.15.1
