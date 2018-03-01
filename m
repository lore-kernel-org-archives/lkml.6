Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2732605-1519901908-2-4728036379642065731
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519901907; b=k27KVXhOlK1AN/FrG/JbNMNzB6bvwoO/2HlRrOZbi20GBOP
    KbMb+3Y3EPVEvy08YzDw4GCAaRctIYMlDErOezYXtGZ6J+gVmDVT+rg1Fv/IZxIv
    h0KQBKdDRzly3wCf3e5UwozqVsjGP7WIKWI0mco0WGrjf9lXdFYCq8gxT+2Br08F
    02Y5j366tzVgE1j11RwmhkGypucB+gy5IEI7uHOeLmmH91GPuUaCpGHZQNZqp+y6
    vSlD3684yAk69D/qVMN10yHLWex73nXhQzKwoCbSMBDHEH8NWcvtLK98ppx/sbUW
    GVXAnZeR7tGohbkT3hgqGiC9DTeHxs7PnZeXdaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519901907; bh=H
    TElJio1RDopCHiqO2pIq5k/pUJrA0uRBHd8M6sLl3Q=; b=CZ3qxs78bJfssPOn4
    vCjhAX+E3M+XEuX4V4m88hQ4Hsu4HvPu+nqXAf/HKAnioj9xl9TIYWx8lzZkaaHp
    qc8mmUfPfLki5WjONNbGNzkCgMNhWJR9y3YBmPk+yuIth182Pko5JRxoxqyDaoxB
    EBUVZngqBL8qsvAgnedY+25gYL6WnJYEWTS4HlvIjGZ4Grpg9CJUs70n0/ZQQJ/4
    +SvOGaYqJx6RypVoJcGoAMLndcg2gV0wF1yuZ9Q3bjp5+yy8NcwKOvgI1NqWY6yq
    DzlgaE4OIEwoHkyKd+0Vitc1+jFY96YsOtEhp61fb9HwMq4JSEiFTDvxIRU40JFK
    OpsSA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] staging: rts5208: rename SG_END macro
Date: Thu,  1 Mar 2018 11:31:29 +0100
Message-Id: <20180301105641.1650792-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180301105641.1650792-1-arnd@arndb.de>
References: <20180301105641.1650792-1-arnd@arndb.de>
X-Provags-ID: V03:K0:cI0d93eubJLITURSOemRuh3Nu/D6iqsMGATXWmFCSnyjTxEttgE
 ojHsP7ZVE1AmD5f2QYQQBe6dv81rFbb4mVHcNyKAwY5QdRm59wuuIg2e/P88A36qCXR8zh7
 MoCiKaOGayL6V6YYFofE38eMQWoI3tyPbuJNr5ER/bgykm+0Y4L0pTm8/kubYYbZnjLgc9j
 gKCsf2/LRj2ORJ7h9IkSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GKdY7W6/UtA=:y6s/qeB9Lg+msubeMzhdy/
 MBIyoCMa+/FDqLY8k7vtV6LQd1eM+xXc/i6iq3MIxVoziFs0J183CwDXnbRuWadQwAK1Xy2Py
 aH2HcSCVqeVerAjJrbhTiMHVeWgNvdMfkwcCatCtIYSWrkaGJRlLMxZWOSwyoJDrIoGI52Eav
 V8xqASMF9fN9yfn78Iort7Ag9vmloSpYWRPLXOfesvHda9TTMDcWhBrp1/VlR7UMnQXXwp+9e
 oZem7X/m7ljysX83873HDZAG3n1mzum7tegxBskkRPUBCpTfvMuZJDRQh1npy1wy2wnxYcI5F
 z7e8Byk7qaCeL40BCI4mnkhSU0LSZ8866HEPRX4vJDE6o1TW7qPgmmUD2n7NrL/sZhbfiItvT
 O5AeurPvUemnM/pN6LhyOM3FAr5BYvP8tALqHQiFpiBKemDVrGDtPstSzPrL8YXNLOJfXTAfc
 DhqPTcekcqnE5cIqzPGM4Qa81+1JkvswoNzGyIilW280Xd2nWeNiB5kR9+N40pfSHN4j+2SxV
 oTq4Px6uSoiRWsXjL068IXXX0fnzhbMA0SXxR50CgSetZ77RUMkeIuPvZtbfpdcwI/yOxw84z
 d13/9GLPGwnmde67ESXHFR+jHETVOI8pfSmBDVZg33Jq5FC4bqVVBbPxR9zWBWwH3YriyRMD3
 6pxEjqLW+LDLIBqfRD90+CuR/+EBCiGXGVfo8cAgrwBdb1SyIIpuMHGFE37U2E7htKuDmCt8v
 fkkp+VMsZXEPdUAqQHKXo6WlRovfjU7F0dZ6pA==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A change to the generic scatterlist code caused a conflict with
the rtsx card reader driver:

In file included from drivers/staging/rts5208/rtsx.h:180,
                 from drivers/staging/rts5208/rtsx.c:28:
drivers/staging/rts5208/rtsx_chip.h:343: error: "SG_END" redefined [-Werror]

This changes one instance of the driver to prefix SG_END and
related constants.

Fixes: 723fbf563a6a ("lib/scatterlist: Add SG_CHAIN and SG_END macros for LSB encodings")
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/rts5208/rtsx_chip.h      | 12 ++++++------
 drivers/staging/rts5208/rtsx_transport.c | 10 +++++-----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_chip.h b/drivers/staging/rts5208/rtsx_chip.h
index 4f6e3c1c4621..8a8cd5d3cf7e 100644
--- a/drivers/staging/rts5208/rtsx_chip.h
+++ b/drivers/staging/rts5208/rtsx_chip.h
@@ -339,13 +339,13 @@ struct sense_data_t {
 #define CHK_BIT(data, idx)	((data) & (1 << (idx)))
 
 /* SG descriptor */
-#define SG_INT			0x04
-#define SG_END			0x02
-#define SG_VALID		0x01
+#define RTSX_SG_INT		0x04
+#define RTSX_SG_END		0x02
+#define RTSX_SG_VALID		0x01
 
-#define SG_NO_OP		0x00
-#define SG_TRANS_DATA		(0x02 << 4)
-#define SG_LINK_DESC		(0x03 << 4)
+#define RTSX_SG_NO_OP		0x00
+#define RTSX_SG_TRANS_DATA	(0x02 << 4)
+#define RTSX_SG_LINK_DESC	(0x03 << 4)
 
 struct rtsx_chip;
 
diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 8b57e17ee6d3..716cce2bd7f0 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -308,7 +308,7 @@ static inline void rtsx_add_sg_tbl(
 	do {
 		if (len > 0x80000) {
 			temp_len = 0x80000;
-			temp_opt = option & (~SG_END);
+			temp_opt = option & (~RTSX_SG_END);
 		} else {
 			temp_len = len;
 			temp_opt = option;
@@ -407,9 +407,9 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
 			*index = *index + 1;
 		}
 		if ((i == (sg_cnt - 1)) || !resid)
-			option = SG_VALID | SG_END | SG_TRANS_DATA;
+			option = RTSX_SG_VALID | RTSX_SG_END | RTSX_SG_TRANS_DATA;
 		else
-			option = SG_VALID | SG_TRANS_DATA;
+			option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
 
 		rtsx_add_sg_tbl(chip, (u32)addr, (u32)len, option);
 
@@ -555,9 +555,9 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
 				(unsigned int)addr, len);
 
 			if (j == (sg_cnt - 1))
-				option = SG_VALID | SG_END | SG_TRANS_DATA;
+				option = RTSX_SG_VALID | RTSX_SG_END | RTSX_SG_TRANS_DATA;
 			else
-				option = SG_VALID | SG_TRANS_DATA;
+				option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
 
 			rtsx_add_sg_tbl(chip, (u32)addr, (u32)len, option);
 
-- 
2.9.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
