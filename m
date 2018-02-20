Return-Path: <Valentin.Vidic@carnet.hr>
X-Google-Smtp-Source: AH8x224KwMrVPHGnEXFTUEfo0ZqoLE4h86XlHktXXNUq2uReY0n4ui1lcEOdw8HLiQf95FeEmyuI
ARC-Seal: i=1; a=rsa-sha256; t=1519135992; cv=none;
        d=google.com; s=arc-20160816;
        b=qIcxLp+tZccfwvtyuG5YetPFGfwLOUg3XpphRqfBzfqP4z6OXbw0A4bEtBWlin6B5A
         GXhvIZFVjXd9jqEXuCKXSaWrBCyu+MHrZZ/7A12f7aP/ksJZRuX/sWZNPWPXT7ZV32ZX
         JzTpJQY6w7QDCeLNeqOwUAgFhffDVG/TNr/g8EZ4SATMlYFpR+t0yk+9RLUL88IynkD3
         vhzoYNnPrFMpth46ntRThmmW98MUFg4Csr76s26mJ7ks9/0xwuPsr2llPNN2Yx4XMaH1
         5MOp9eLs0W03AsDSsN8W7g0LHTkykswpdL7kzrgd/AnmZwja45vzbS9D04bdyrwGm1LN
         A7JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:message-id:date:cc:to:from:arc-authentication-results;
        bh=jLmppv+9LFVGtwIZB9w/EEL6O7cxlFfbaUtmheROCnY=;
        b=oNKFDMit0koig+NIZFi87neUOhANk3Oa2P+txURhAgXT5sc2bDHYZm7SWVZ3TvQJVM
         xk9gq63OAiv4HdW5gPQQLfxyjAODqnj+cmb0aJHWT2imOgadOJGH/VhuvuX8OIZ2zlfA
         e1AaHyEkVGnSyg0rNjGxuyM4mlcNL9p0SlM8ZKpIEPwLgYgQ79Kx2WwiCYrjvhC7jZ3z
         cybsnv7bjf/KKXGxQ1KMMsLHLkv8SUV/T2U9wLkO1l6Nu2msVLE9WFPqeq8JryoTwUVN
         8URBlJG1lwE5VTFPNmLgsmUgiggmxj+oyDqzx5EDGRNtvYQt6+340Da57fQyMViA0yyU
         oAfg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of valentin.vidic@carnet.hr designates 2001:b68:ff:2::6 as permitted sender) smtp.mailfrom=Valentin.Vidic@carnet.hr
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of valentin.vidic@carnet.hr designates 2001:b68:ff:2::6 as permitted sender) smtp.mailfrom=Valentin.Vidic@carnet.hr
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>,
	Marcus Wolf <linux@Wolf-Entwicklungen.de>,
	=?UTF-8?q?Luca=20S=C3=B6the?= <luca@acul.me>,
	Marcin Ciupak <marcin.s.ciupak@gmail.com>,
	Michael Panzlaff <michael.panzlaff@fau.de>,
	Derek Robson <robsonde@gmail.com>,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Valentin Vidic <Valentin.Vidic@CARNet.hr>
Date: Tue, 20 Feb 2018 15:13:07 +0100
Message-Id: <20180220141307.25494-1-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.16.1
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: [PATCH] staging: pi433: fix CamelCase for addressFiltering
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592929542694556577?=
X-GMAIL-MSGID: =?utf-8?q?1592929542694556577?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes checkpatch warning:

  CHECK: Avoid CamelCase: <addressFiltering>

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/staging/pi433/pi433_if.c  | 4 ++--
 drivers/staging/pi433/pi433_if.h  | 2 +-
 drivers/staging/pi433/rf69.c      | 4 ++--
 drivers/staging/pi433/rf69.h      | 2 +-
 drivers/staging/pi433/rf69_enum.h | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index e8ddc924bb04..aad1debd34a2 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -230,8 +230,8 @@ rf69_set_rx_cfg(struct pi433_device *dev, struct pi433_rx_cfg *rx_cfg)
 		if (ret < 0)
 			return ret;
 	}
-	ret = rf69_set_adressFiltering(dev->spi,
-				       rx_cfg->enable_address_filtering);
+	ret = rf69_set_address_filtering(dev->spi,
+					 rx_cfg->enable_address_filtering);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
index 22c1631d0bf0..b3fa4fe64c5c 100644
--- a/drivers/staging/pi433/pi433_if.h
+++ b/drivers/staging/pi433/pi433_if.h
@@ -125,7 +125,7 @@ struct pi433_rx_cfg {
 	/* packet format */
 	enum option_on_off	enable_sync;
 	enum option_on_off	enable_length_byte;	  /* should be used in combination with sync, only */
-	enum addressFiltering	enable_address_filtering; /* operational with sync, only */
+	enum address_filtering	enable_address_filtering; /* operational with sync, only */
 	enum option_on_off	enable_crc;		  /* only operational, if sync on and fixed length or length byte is used */
 
 	__u8			sync_length;
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 91c834059710..b2cea5f52eea 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -684,9 +684,9 @@ int rf69_disable_crc(struct spi_device *spi)
 	return rf69_clear_bit(spi, REG_PACKETCONFIG1, MASK_PACKETCONFIG1_CRC_ON);
 }
 
-int rf69_set_adressFiltering(struct spi_device *spi, enum addressFiltering addressFiltering)
+int rf69_set_address_filtering(struct spi_device *spi, enum address_filtering address_filtering)
 {
-	switch (addressFiltering) {
+	switch (address_filtering) {
 	case filteringOff:
 		return rf69_read_mod_write(spi, REG_PACKETCONFIG1, MASK_PACKETCONFIG1_ADDRESSFILTERING, PACKETCONFIG1_ADDRESSFILTERING_OFF);
 	case nodeAddress:
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index 21d7034e2c79..cf89b556cb00 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -53,7 +53,7 @@ int rf69_set_sync_values(struct spi_device *spi, u8 sync_values[8]);
 int rf69_set_packet_format(struct spi_device *spi, enum packetFormat packetFormat);
 int rf69_enable_crc(struct spi_device *spi);
 int rf69_disable_crc(struct spi_device *spi);
-int rf69_set_adressFiltering(struct spi_device *spi, enum addressFiltering addressFiltering);
+int rf69_set_address_filtering(struct spi_device *spi, enum address_filtering address_filtering);
 int rf69_set_payload_length(struct spi_device *spi, u8 payload_length);
 int rf69_set_node_address(struct spi_device *spi, u8 nodeAddress);
 int rf69_set_broadcast_address(struct spi_device *spi, u8 broadcastAddress);
diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
index 478e3a4c4948..cba3c5b3995c 100644
--- a/drivers/staging/pi433/rf69_enum.h
+++ b/drivers/staging/pi433/rf69_enum.h
@@ -128,7 +128,7 @@ enum tx_start_condition {
 	fifo_not_empty
 };
 
-enum addressFiltering {
+enum address_filtering {
 	filteringOff,
 	nodeAddress,
 	nodeOrBroadcastAddress
-- 
2.16.1
