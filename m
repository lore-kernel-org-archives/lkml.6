Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4103318-1526051207-5-7055810842934356454
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='fr', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526051207; b=XKZJNdc4nmRhA1l5TOys+zLLNb0Vd2WRBcrf5F0vHmYaTwnR4m
    M2eG2W/jr/at7RCLmNkd2MZq/4BBz08JpzLZuyfGv4sPY8bFOPWbooYuFyjcltfE
    4F0fy7ImJldaz4qqCA6hlf5bikMKr4I4BGs47sdALT7U+x+rEiyFHqyDPumr9fPo
    n3TfKnm9rk6l0WqvFzI2nBY0RVK8DLY9RIq7SCYLYSlCmv3th+WrS+Pw4gi92Gwk
    PO8fqt5GrQFapYSorVX43e3EomuHHdzAZE3Hz0PlYkc6C5pTfxzXXD71S30dzh5G
    0pM306gcy5psZsEsRZ4jDXuys1wUGZ64ANiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526051207; bh=hc6DV
    fayMivKJLrZcEHs3dB03JnRULBR4Hst50Z53RQ=; b=IEET6PnmSVHjqdreQx1N+
    OEmlv5ZotOCU2fynZ1BCXIteNf6vK3IEI4ZVDL2is31FK6NdVJLKTAnm08TKPpIe
    Ph6/PfoDwU4fYWKi0+32MM2JrU62eIC7om8E/9pRbbwHGCmHBZrZ5kXuDUb3rh/p
    +ywKEjrfq4QcT/VpnvBPwttUsSjfLGtBkj6QII7BtrfNegNW3ZBKEaaJgpn32DxK
    mESq0EbHB9TgM5ir2us1yuSv/9SYrHBYB5N1bSfLYxQRDsLS+i91jz90SwlTw/QM
    ksmoke39ABC9wdE6KwawPkP/x9I5+h4i+v9WH9Ej7162iT/RNjzJ2GEJGbX0chhK
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wanadoo.fr;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=wanadoo.fr header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=25 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wanadoo.fr;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=wanadoo.fr header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=25 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEl+RkbCxub5LxSYhAF/OwqHhHnjKWMUystd0k5mJ3K9rcRx9MWA7ZEk8gi5fKryFJhLyTPjvkhKwuHiRacL4r6i3/Qx4BFCqewM0nLPVXahoyer6NH6
    cBjBAxcc+oOMu4tqunZw8EGGcY95ZADv3jH0MgXXL+eqP2tTuubTgwOU5Xm3kC+VpLGOsPlgH4a6gN3HyRRQrnuKugSX/isyui8j3TKs3NvXIgBGSNTDT65V
    5QjZpqxWDRDrM+64asmb6Q==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8
    a=-ZeUwWfnL9UH0sAtyw8A:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-ME-Helo: ubuntu-CJ.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 11 May 2018 17:06:36 +0200
X-ME-IP: 86.244.116.1
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: alan@linux.intel.com, sakari.ailus@linux.intel.com, mchehab@kernel.org,
 gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
 chen.chenchacha@foxmail.com, keescook@chromium.org,
 arvind.yadav.cs@gmail.com
Subject: [PATCH 1/3] media: staging: atomisp: Return an error code in case of
 error in 'lm3554_probe()'
Date: Fri, 11 May 2018 17:06:16 +0200
Message-Id: <2eff9a8d6d67b60aed87277ab4f8b48b2251d559.1526048313.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1526048313.git.christophe.jaillet@wanadoo.fr>
References: <cover.1526048313.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1526048313.git.christophe.jaillet@wanadoo.fr>
References: <cover.1526048313.git.christophe.jaillet@wanadoo.fr>
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
Cc: devel@driverdev.osuosl.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If 'v4l2_ctrl_handler_init()' fails, we go to the error handling path, do
some clean-up and return err, which is known to be 0 (i.e. success).

Axe the 'ret' variable and use 'err' directly in order to return the error
code instead.
Also remove the initialization of 'err' which was hiding this issue.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/staging/media/atomisp/i2c/atomisp-lm3554.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c b/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
index 7098bf317f16..723fa74ff815 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
@@ -852,10 +852,9 @@ static void *lm3554_platform_data_func(struct i2c_client *client)
 
 static int lm3554_probe(struct i2c_client *client)
 {
-	int err = 0;
+	int err;
 	struct lm3554 *flash;
 	unsigned int i;
-	int ret;
 
 	flash = kzalloc(sizeof(*flash), GFP_KERNEL);
 	if (!flash)
@@ -868,10 +867,9 @@ static int lm3554_probe(struct i2c_client *client)
 	flash->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 	flash->mode = ATOMISP_FLASH_MODE_OFF;
 	flash->timeout = LM3554_MAX_TIMEOUT / LM3554_TIMEOUT_STEPSIZE - 1;
-	ret =
-	    v4l2_ctrl_handler_init(&flash->ctrl_handler,
-				   ARRAY_SIZE(lm3554_controls));
-	if (ret) {
+	err = v4l2_ctrl_handler_init(&flash->ctrl_handler,
+				     ARRAY_SIZE(lm3554_controls));
+	if (err) {
 		dev_err(&client->dev, "error initialize a ctrl_handler.\n");
 		goto fail2;
 	}
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
