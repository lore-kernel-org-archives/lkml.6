Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607028; cv=none;
        d=google.com; s=arc-20160816;
        b=cMpAH152RNBlClQNaZSbOMAYtxuCeb+dqqg4bX21D4bvjlbx7udiTxzvhPUcjltwOg
         h1cYUKj7cO7MWest+yYTqMueS47zzuagio042mBQddm0YS3U+mnjX+L7uBnC/bjdtu+K
         R8RPq3mDeEp+ZzXe4EwoWGBixSE5dwi6QpHTZDqEQS4sbUisQnliH238pZtNRpK5a5lq
         AM2xmchydxqdF79Cg+qmrdNKlZ7tc7C6fl4iMFxQkSC/eex06c8fRmyAfnjehx/mlk00
         C/zPRRlA46fdwRjlomd7ATehKe/H9ULF2s1krBnF5djaEbbhVY+VXIScYXrMvIKB0sLm
         H/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=mKP2TnGnWIK7Bi0xi2aUnSgI/KaYTC2r/mhx+bI51D4=;
        b=rmdewaNWPjQHhXLsZyDrUvVkeosh7DPPVYEgKy0uUmICg+BHtH0XfntQ/ZpiK+qLvO
         xToqKj2ZlAK2HQiywRdEoI0KLL9mmEQD1cKV86EvEtXpgGnxHpWGtPzB3KEXzY4UYN+3
         yvpDHDXRvzXVUokfC59XbocV/f3qBijPXAbrCl1stZjKsvChZj8eN4wNVsfKwk84dW9t
         1TbvEBgBInK2wISYXdi7c7/iGGVEa9i9HK7ksDdHp/jwRU+x0fTlv4jXBIEE16IeuOOt
         GAmMeyKsSzTIsPRudyQVyAuSZWlx3v3wMnNRmJVWzBShOxWiGICGa1tRJNHrPALwrFqv
         m2Tg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=e8TBcfp0;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=e8TBcfp0;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtba8Iayxc46r0Ggb6c3eLGZ8f8m57saq1hbR3NL0wIqgzXQpMoLdKEKrcYBKYmVDTgtFt7zQ==
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
Subject: [PATCH 02/25] nvmem: core: Allow specifying device name verbatim
Date: Fri,  9 Mar 2018 14:46:56 +0000
Message-Id: <20180309144719.29904-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472035588887358?=
X-GMAIL-MSGID: =?utf-8?q?1594472035588887358?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Add code to allow avoid having nvmem core append a numeric suffix to
the end of the name by passing config->id of -1.

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
 drivers/nvmem/core.c           | 11 ++++++++---
 include/linux/nvmem-provider.h |  3 +++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 35a3dbeea324..99e04cfcc723 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -473,9 +473,14 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->reg_read = config->reg_read;
 	nvmem->reg_write = config->reg_write;
 	nvmem->dev.of_node = config->dev->of_node;
-	dev_set_name(&nvmem->dev, "%s%d",
-		     config->name ? : "nvmem",
-		     config->name ? config->id : nvmem->id);
+
+	if (config->id == -1 && config->name) {
+		dev_set_name(&nvmem->dev, "%s", config->name);
+	} else {
+		dev_set_name(&nvmem->dev, "%s%d",
+			     config->name ? : "nvmem",
+			     config->name ? config->id : nvmem->id);
+	}
 
 	nvmem->read_only = device_property_present(config->dev, "read-only") |
 			   config->read_only;
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index a39f76ff2ccd..b00567a07496 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -43,6 +43,9 @@ typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
  * Note: A default "nvmem<id>" name will be assigned to the device if
  * no name is specified in its configuration. In such case "<id>" is
  * generated with ida_simple_get() and provided id field is ignored.
+ *
+ * Note: Specifying name and setting id to -1 implies a unique device
+ * whose name is provided as-is (kept unaltered).
  */
 struct nvmem_config {
 	struct device		*dev;
-- 
2.15.1
