Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-460763-1522314736-2-6054529809284396932
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522314735; b=Sx/PJ8AzfyUEUn6iIRRoO2l2BD65fTC3pbmNsJlVYr/Fq0SXta
    STinLw0BUpaCoq/EXiMb0Kc2aWd7eqLBwwkG4S7W/8Bon4a4lt01HFcZRY+xqql3
    0QJt0OSSNOmYDJ02zDYHizvYYqgw24J4p1aabjbqdpo/SnDiv49Z+UlUdxYVgvhJ
    rrpOY2Pfwbkxn8yQ3pnV7JoE+gppmFDuaZP60jmm1PrnQid+NQDCacx+eFsfnodO
    9SjQHdfN4dz1rKQapBrSNT/kwieUftlVo+TmFP99gTecLyCwckEoyIKaKtq8r224
    LXLvi2+QDcx7FPiTltb79Jv3mmRmBAi5F9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522314735; bh=R5H61
    dakSI5Sjrr+8x2DX7t9lHY4OadyafrhNi4TNSA=; b=fqDapeyoeFsd/4C9sX8kU
    eMjTw+owYtclzXG9RvRbTpOaM4iVCOAk+mQxOCG6klIYkHCgBcxXU7FbOGntZzIt
    PEEHLBifl9HZsGa49d2DBhcGTxpFwJiXUiQXMq9lZ8k05V/Zgq4WmFL8HsLyYZM8
    D0gMOObnHXFQadOyI3jXT8P9zQLtj3OLJu5b5/YBt5Db7DndR66OCj64LnITtNPH
    N32sVLAUOAmNNbKGp8QND0qCUSFTs+5doMwXxYPNuCTdttW0wpYaVH2MTRK1XEZg
    0kT24j9u27yHY1TmfsvDzeEFTy23SiYNi3jerSsV0A33Kydjll9Ej8H66k2BCSzW
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LDoKpA0W x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aV64JB83;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LDoKpA0W x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aV64JB83;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIaTcvyvd4wVvqoJEC06Fe/o6ErcBHPGznS6A2OUJab1pmpBbOCW2nnSrB7/oeRjElyKAixdvBuB5DYuL5w28MM4eS/DL8pn6YSrAZ3emNcfcG46n+WH
    N2+Y0No4O/SgK7BQaLXFVCz1m2xVu2ztVxj7ZfuY3naVh0w5WfNqhISEaVX8awFjoS0GjP9nEapuSMERH4KnAgE27IsunwZ1eQBFdKn51T6wEL+M96IhZBvH
    L5DSkruUBFx3aCNwa7hQ2Q==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=MsQ-QqnFFZYA:10 a=v2DPQv5-lfwA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=JHf-Q2MEFjrqOmt5BTgA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+nXicQCn2Rs4bslluL8miz9gDa7/XjSIKBwMDh3A2Y3ewgeicvYNY0KqgoUnRklPbMXPgCYg==
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, daniel.baluta@gmail.com
Subject: [PATCH v6 1/6] Staging: iio: adis16209: Indent the field definitions
Date: Thu, 29 Mar 2018 14:42:02 +0530
Message-Id: <508a70d5477067c083408fc81e58023c7e91bc95.1522306893.git.shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1522306893.git.shreeya.patel23498@gmail.com>
References: <cover.1522306893.git.shreeya.patel23498@gmail.com>
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
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Have indentation in field definitions to make them
clearly different from the register addresses.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

Changes in v5
  -Change some macro names and have indentation in the field
definitions.

Changes in v6
  -Have indentation in the field definitions and do not
change the names of the macros as the patch for changing 
the names has already been applied.

 drivers/staging/iio/accel/adis16209.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index a8453bf..0e6366a 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -71,13 +71,13 @@
 #define ADIS16209_STAT_REG			0x3C
 #define  ADIS16209_STAT_ALARM2			BIT(9)
 #define  ADIS16209_STAT_ALARM1			BIT(8)
-#define ADIS16209_STAT_SELFTEST_FAIL_BIT	5
-#define ADIS16209_STAT_SPI_FAIL_BIT		3
-#define ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
+#define  ADIS16209_STAT_SELFTEST_FAIL_BIT	5
+#define  ADIS16209_STAT_SPI_FAIL_BIT		3
+#define  ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
 /* Power supply above 3.625 V */
-#define ADIS16209_STAT_POWER_HIGH_BIT		1
+#define  ADIS16209_STAT_POWER_HIGH_BIT		1
 /* Power supply below 3.15 V */
-#define ADIS16209_STAT_POWER_LOW_BIT		0
+#define  ADIS16209_STAT_POWER_LOW_BIT		0
 
 #define ADIS16209_CMD_REG			0x3E
 #define  ADIS16209_CMD_SW_RESET			BIT(7)
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
