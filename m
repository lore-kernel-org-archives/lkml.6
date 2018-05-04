Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3535272-1525402454-2-15282095675489148191
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525402454; b=WwKaubpl/kpruz7dZ9P5krrOoThtIlLpYjVtn7eBvlWBrnrTMz
    ygql8N+T3IP5ceqxonmL8LfYsj0MqqF+FzPHzctb3rkCWoWoA1jYfw5QEAK1qGmw
    GVEPMQ3TOhQtTay1ey1OIkvMhid7mhwmifmR7MJwWFr41abnKtlL2jjnNaSW2n+t
    cZKQKoYc+bpg3qIUtk6xnuCbD8GJ198zeqV0uIWwk6YPHfHTPrHAVOXCT4YZmRFP
    s3estiiqgrV1ETS6W59sBa1RTEFgIuT0B5fh38gqm7xW+V+mlyysdqxNvU6bAu26
    aNJCI59LnhsrKLabrk+Q9E/og7lFGt6H/duA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525402454; bh=s/VcJ
    wwUPyrk7bdvuWIQ6jDcgogHs3jFXYAD2DoVKco=; b=d/NOvcpThOXDUVg1zs9to
    Lq2245+05YAQGiqAXXc5ZRBH0KrDqWbGkNLHu2ioaCcITdKcCpviRN0TowbQ1Agd
    uMoAQkd1yxH2I38Fb797lN78GF26tos+8fwjZI70RqcFjGFQjyk3FKbLvjs5I6Fo
    NU4mObuN3lqGJmLxKyAan0n00NhnZKeo5zgJ5zSHfzFO0Z5avGW0gkfzvwrCn3a3
    wnDLyizoUTAwNNlwCgXy5TEOdKcqgZcbgORg6/2fc80So4X2KsLOzuNItdi2aTgV
    /ZrLY+gchJbn7dLxjRBQGYtMYPYwOy7NfCwm2YpbLnVVGEvv5oD+ISzvJWKjKbvW
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=onstation.org header.i=@onstation.org header.b=OVER6x6+
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=onstation.org
    header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=onstation.org header.i=@onstation.org header.b=OVER6x6+
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=onstation.org
      header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNL4R+hIeCwbugn8T0RBcRxEOQr9CCTs1FXDqztNigKvojYbDnVDx7RQcvw/As3Zth+u8cnPxZbQs64UsZ+rNBAWCu36OqwfEivjTRxh49dunbXHtpV/
    ibcDy6Mub3GH8z32MkYA8e8ucNCUJd2e3CE0O3h3KQ6vSX4vZd7VgHzveECdBjFTqelJd/GxwTWFEQCAdL72T5zL7SpsxheA7Duup2duBwdThGQqt8IM0b8n
    bFIF5S/w1kgfORxVCzhdOA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=D50cekDjWgyzVIz5mnYA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 08/11] staging: iio: tsl2x7x: add device ids for code
 readability
Date: Thu,  3 May 2018 22:53:16 -0400
Message-Id: <20180504025319.28953-9-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180504025319.28953-1-masneyb@onstation.org>
References: <20180504025319.28953-1-masneyb@onstation.org>
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
 drew.paterson@ams.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds the device IDs to the device_channel_config array to
improve code readability.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index e3e37501829f..39de5e60fd33 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -273,16 +273,16 @@ enum {
 };
 
 static const u8 device_channel_config[] = {
-	ALS,
-	PRX,
-	PRX,
-	ALSPRX,
-	ALSPRX,
-	ALS,
-	PRX2,
-	PRX2,
-	ALSPRX2,
-	ALSPRX2
+	[tsl2571] = ALS,
+	[tsl2671] = PRX,
+	[tmd2671] = PRX,
+	[tsl2771] = ALSPRX,
+	[tmd2771] = ALSPRX,
+	[tsl2572] = ALS,
+	[tsl2672] = PRX2,
+	[tmd2672] = PRX2,
+	[tsl2772] = ALSPRX2,
+	[tmd2772] = ALSPRX2
 };
 
 static int tsl2x7x_read_status(struct tsl2X7X_chip *chip)
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
