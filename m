Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1303162-1524890158-2-17184064643352825576
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524890158; b=DJl/NtjNhA647OYPo++Zgd/k2Ff1pjrBfY0KrOUVGBQUCvYeOS
    gn4TjtpV0ytFVvdym2wHi0OilxUHI/UBa/XrPVaD8r+P5AnY+L7Ngvhig4q3Tjf0
    vNkkCLdfMxKRkzky/ppSUDfU4g7xYqtxE7I2WxA6MB9Grwrcb+Rir74ZKfDSSlT9
    wZXuExF79Lxs7x5i0Czw6mqnUFZZxLywFH3uE6YP6Ht1sEVULi8+dXVtKZOmhYd9
    KCTMwC3sGAFh/7SSQ9m2FgxzFKdh4LToGn8HozOa1KW38fDP2QsAZtDy6KWZ+1wX
    JjLa+MsBt0vGhDIToLOP5Q4BtAJ8FyjlAYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524890158; bh=3pgCu
    Gq41Gj6lj6Tdq1/fEeQV+ZWl4iCBYLnTuwWjOw=; b=MN9ozOAPcEC9MNPfVLXsZ
    U7AZEq+iwY96uGmCpBJiSx1WKBItk7a1NNURej7yQbfbCRn1SZhT6bQu3jBQd2jy
    c/ArdXaU6g+t8Y+kt6Kf828xgXZFKFIFcoRzGhmTy05/kJKjg0wWkoWbodAKY0tm
    O3XAbW3IHfGMr2K2uF2697tPCrGLP4wD9ZH5GnlHtynEAZoU4u9761zS+hlufAe9
    NEZ2V66Job/Ghsm9OXGlkdG9NZEF3R1T8aoxoTGi8MkpcSiibXYCNj9e+qG95sgI
    YexxRdSgiq2adSbtBTo7c0zV/rvf8HYgMhv2gcXwNzrr4IeOcsJhq6yWoNGPotUq
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RnBcUL99 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TZIkzsxc;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RnBcUL99 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TZIkzsxc;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHzQIqGEwJRyyP2ipyiSuXuA5KP4ldlNtIueD0rYvZSeOGhdhhpa6fE0LWx+AZBwKBKrq1EtRP/+pi16sMwd2WRUdW1gRUMXJzH99so7nj3em2jiAha4
    2C+nBBgf+GcSLpPs41nfDAjrWcFclV2bXRJlUYqmZh1eHlMyxB3/ahQAjoglojs3V+TP+dE/FUDQvUyXc/N8yYqCLGdhNR0kPg0B3XubNpd7TggjZTbo5NyK
    3BDJCbQ6Wm8L2qt7HUeLXA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=LxSDy4Xbj5AA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=hGDZC-2D4ysIxYB3-XQA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZo2i5o2IFieE0zt7oqdJDotMChWia/f+3eeTSXfBO4h7SoUDyG6LUOCzdlFWBVvXaNfApbWzg==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: hvaibhav.linux@gmail.com, johan@kernel.org, elder@kernel.org,
 gregkh@linuxfoundation.org
Subject: [PATCH v2] staging: greybus: Use gpio_is_valid()
Date: Sat, 28 Apr 2018 10:05:39 +0530
Message-Id: <5c8c96b1971bc09a2a2bfa62c343973ab986aec8.1524889296.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 2.7.4
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
Cc: devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace the manual validity checks for the GPIO with the
gpio_is_valid().

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Reviewed-by: Alex Elder <elder@linaro.org>
---
chnage in v2 :
             Returning invalid gpio as error instead of -ENODEV.

 drivers/staging/greybus/arche-platform.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index 83254a7..c3a7da5 100644
--- a/drivers/staging/greybus/arche-platform.c
+++ b/drivers/staging/greybus/arche-platform.c
@@ -448,7 +448,7 @@ static int arche_platform_probe(struct platform_device *pdev)
 	arche_pdata->svc_reset_gpio = of_get_named_gpio(np,
 							"svc,reset-gpio",
 							0);
-	if (arche_pdata->svc_reset_gpio < 0) {
+	if (!gpio_is_valid(arche_pdata->svc_reset_gpio)) {
 		dev_err(dev, "failed to get reset-gpio\n");
 		return arche_pdata->svc_reset_gpio;
 	}
@@ -468,7 +468,7 @@ static int arche_platform_probe(struct platform_device *pdev)
 	arche_pdata->svc_sysboot_gpio = of_get_named_gpio(np,
 							  "svc,sysboot-gpio",
 							  0);
-	if (arche_pdata->svc_sysboot_gpio < 0) {
+	if (!gpio_is_valid(arche_pdata->svc_sysboot_gpio)) {
 		dev_err(dev, "failed to get sysboot gpio\n");
 		return arche_pdata->svc_sysboot_gpio;
 	}
@@ -487,7 +487,7 @@ static int arche_platform_probe(struct platform_device *pdev)
 	arche_pdata->svc_refclk_req = of_get_named_gpio(np,
 							"svc,refclk-req-gpio",
 							0);
-	if (arche_pdata->svc_refclk_req < 0) {
+	if (!gpio_is_valid(arche_pdata->svc_refclk_req)) {
 		dev_err(dev, "failed to get svc clock-req gpio\n");
 		return arche_pdata->svc_refclk_req;
 	}
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
