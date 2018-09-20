Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF47ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B097621523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zeroaptitude.com header.i=@zeroaptitude.com header.b="pxfmjZaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B097621523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeroaptitude.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbeITVAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:00:54 -0400
Received: from delivery.mailspamprotection.com ([184.154.177.54]:36475 "EHLO
        delivery.mailspamprotection.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731025AbeITVAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:00:54 -0400
X-Greylist: delayed 9510 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Sep 2018 17:00:53 EDT
Received: from ns1.sgp61.siteground.asia ([109.199.119.161] helo=sgp61.siteground.asia)
        by se7.mailspamprotection.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <zero@zeroaptitude.com>)
        id 1g2yEK-0001kF-QR; Thu, 20 Sep 2018 07:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=zeroaptitude.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CdHPNJmgt5/7Kd2OpxaKwY07hlaVFvVF6Yl47Ekg+G0=; b=pxfmjZaA4QPFxyDneE/qNf3kbt
        ZBTxBhP50Sn6/mwSE4kBbUVXMRji7FekiKDq0MAHcPl9WDesnpkaxhVZMESMGzf+QMfF6bVoEpkvK
        sA0SfsTZDpwOzz3+AN4VMRWyACxzLCPixHzVKTHl09MmlsNC+Zvfsnd6fFvn9lwPyyE72EN+6YZAf
        ABw92aN1FL9zceF9p3GXotOgSVvW71fZ2aJkP4t0EwPuq32FYazpZuZO5v8OQmOmEolH8ZfkQdrgH
        9Q0I2r+0SB/QpYshTyO3kUdXCefVQzTVfztGR92x5DZppj8Kmkblsw6/kkaCrInpKnamJ9/swGgeU
        LexuK1VQ==;
Received: from [111.220.91.48] (port=56797 helo=localhost.localdomain)
        by sgp61.siteground.asia with esmtpa (Exim 4.89_34-9f6032f-XX)
        (envelope-from <zero@zeroaptitude.com>)
        id 1g2yEH-00084Y-Ee; Thu, 20 Sep 2018 20:38:45 +0800
From:   Aaron Williams <zero@zeroaptitude.com>
To:     johan@kernel.org
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Aaron Williams <zero@zeroaptitude.com>
Subject: [PATCH] staging: greybus: control.c: fixed some coding style issues
Date:   Thu, 20 Sep 2018 22:38:28 +1000
Message-Id: <20180920123828.22059-1-zero@zeroaptitude.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: 109.199.119.161
X-SpamExperts-Domain: sgp61.siteground.asia
X-SpamExperts-Username: 109.199.119.161
Authentication-Results: mailspamprotection.com; auth=pass smtp.auth=109.199.119.161@sgp61.siteground.asia
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00807821872984)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5igeySpuR11gqXQnXOZYDxd602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvOwB00JgJyahs3ou1Ha+bB0Dm4TvjgYLDs3y9X4XVPt9Oh9MnZwXbcSjZIuF4fUI+dUyH
 kn4qe7JABa5XMvXWBzhLZf5OB9DTecJP2xsL2BwdJ28EqMJxd59rZDN9BIGMhTQz+q8XWZU9pl0/
 tv0C0VCJ0yWEKej9CxhpOWHLLCQZdxU1yO1APIiuuu21fHUnxXhM5O3wUUhRkCCiJDTAVgXilbHt
 bFYVmmyNP/jzd7CCYD6LcQuHeZmYgZL1lPCTpgc/5tKAExU2r+RyE6bN79B4DqxxlnCnOQKjhagE
 KuLSpFcLxHSMmVCkv47x59CmBIeCSxLZ5vMkhIi5r4+dNkl+YkebNpvJ/YTk5oHVPSir3i4EXXSu
 eZzMCpX2tfOqKM5soQ0R2jS4GxDcxPFGC7+1wDMOc4H6q73RzbTUHzE3AgWWIbRc6VUWEu40CeT2
 M7d6BHJupOUg4HMDrxikwNFvUeASWefCYj15CRjPEXcLP1ktHytg2lIgWm9wFWwL0OWBOXp8nHKe
 0R+FkIqN7hkDkbRK+w5qy6qANfaJoljbLv/585O+pWpOKIzg2yRxxN7LZv6lKWVTb5pAPNgS+qtg
 5p66If/IR1kfxLX5OBwkpE84YZcdCDV+C9xsiqZaEq0jiD6XqsJZtjQxlyCdsezNcPIBOrFjnGZb
 eyjUiiL52m1Uc1eEzDwHrPwyt1XMQu8uqwe2Iy90SNEJyAtvSeI15dEIkxfV50ME3f3L5iqWuY4s
 txpPls1Er1Fd+rSqwQprbbfe3Nuw6HdOflw7V/k6F4SqckcKxahunkfsR5SoErJ4zpfKKGdL1g39
 tsgqmkoYL/weAHntnF3dF8a/atDqKKPY7qaFwHdN6xurv8x+neCXlHqB0YZSDlUMP/uyOaup5J18
 DQuCFPKf1ICSBBsXyH6oCYh8Mee/sWhDuT6YvAPup6PpoRJWyVq+/EEAOZ287+JBj+5jyVWeiZF6
 A4zGAd0eLDaFwTBeLI7axc5XUV8ShebT8U8Xw9HTDfreWfWVscuRAFcLveiVG5b0QiCbWEI8YG54
 p0VpNY/Y+rdgJNAx7tRR/SG95uGZgRdKDwjOc2TaJtvlglEh7THpgpcr8l1a+B3b8WJsR0wzQmfG
 LPYyO9zif/u02BzNWnd/HVQEXN7c0qpRMEIgggLrpscwbVA/fmexh8/zhz5EUrcqsffIXKYxtRnw
 8Szq26VFEK/193pfHkRgQH95xgUWht8=
X-Report-Abuse-To: spam@quarantine1.mailspamprotection.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed some "Alignment should match open parenthesis" checks.
Signing up for the kernel clean up crew while I learn C

Signed-off-by: Aaron Williams <zero@zeroaptitude.com>
---
 drivers/staging/greybus/control.c | 39 +++++++++++++++----------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/greybus/control.c b/drivers/staging/greybus/control.c
index 35f945a12b11..f8f0aee224c8 100644
--- a/drivers/staging/greybus/control.c
+++ b/drivers/staging/greybus/control.c
@@ -15,7 +15,6 @@
 #define GB_CONTROL_VERSION_MAJOR	0
 #define GB_CONTROL_VERSION_MINOR	1
 
-
 static int gb_control_get_version(struct gb_control *control)
 {
 	struct gb_interface *intf = control->connection->intf;
@@ -32,15 +31,15 @@ static int gb_control_get_version(struct gb_control *control)
 				sizeof(response));
 	if (ret) {
 		dev_err(&intf->dev,
-				"failed to get control-protocol version: %d\n",
-				ret);
+			"failed to get control-protocol version: %d\n",
+			ret);
 		return ret;
 	}
 
 	if (response.major > request.major) {
 		dev_err(&intf->dev,
-				"unsupported major control-protocol version (%u > %u)\n",
-				response.major, request.major);
+			"unsupported major control-protocol version (%u > %u)\n",
+			response.major, request.major);
 		return -ENOTSUPP;
 	}
 
@@ -48,13 +47,13 @@ static int gb_control_get_version(struct gb_control *control)
 	control->protocol_minor = response.minor;
 
 	dev_dbg(&intf->dev, "%s - %u.%u\n", __func__, response.major,
-			response.minor);
+		response.minor);
 
 	return 0;
 }
 
 static int gb_control_get_bundle_version(struct gb_control *control,
-						struct gb_bundle *bundle)
+					struct gb_bundle *bundle)
 {
 	struct gb_interface *intf = control->connection->intf;
 	struct gb_control_bundle_version_request request;
@@ -69,8 +68,8 @@ static int gb_control_get_bundle_version(struct gb_control *control,
 				&response, sizeof(response));
 	if (ret) {
 		dev_err(&intf->dev,
-				"failed to get bundle %u class version: %d\n",
-				bundle->id, ret);
+			"failed to get bundle %u class version: %d\n",
+			bundle->id, ret);
 		return ret;
 	}
 
@@ -78,7 +77,7 @@ static int gb_control_get_bundle_version(struct gb_control *control,
 	bundle->class_minor = response.minor;
 
 	dev_dbg(&intf->dev, "%s - %u: %u.%u\n", __func__, bundle->id,
-			response.major, response.minor);
+		response.major, response.minor);
 
 	return 0;
 }
@@ -112,7 +111,7 @@ int gb_control_get_manifest_size_operation(struct gb_interface *intf)
 				NULL, 0, &response, sizeof(response));
 	if (ret) {
 		dev_err(&connection->intf->dev,
-				"failed to get manifest size: %d\n", ret);
+			"failed to get manifest size: %d\n", ret);
 		return ret;
 	}
 
@@ -168,7 +167,7 @@ int gb_control_disconnecting_operation(struct gb_control *control,
 	ret = gb_operation_request_send_sync(operation);
 	if (ret) {
 		dev_err(&control->dev, "failed to send disconnecting: %d\n",
-				ret);
+			ret);
 	}
 
 	gb_operation_put(operation);
@@ -400,7 +399,7 @@ int gb_control_interface_hibernate_abort(struct gb_control *control)
 }
 
 static ssize_t vendor_string_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
+				struct device_attribute *attr, char *buf)
 {
 	struct gb_control *control = to_gb_control(dev);
 
@@ -409,7 +408,7 @@ static ssize_t vendor_string_show(struct device *dev,
 static DEVICE_ATTR_RO(vendor_string);
 
 static ssize_t product_string_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
+				struct device_attribute *attr, char *buf)
 {
 	struct gb_control *control = to_gb_control(dev);
 
@@ -455,8 +454,8 @@ struct gb_control *gb_control_create(struct gb_interface *intf)
 	connection = gb_connection_create_control(intf);
 	if (IS_ERR(connection)) {
 		dev_err(&intf->dev,
-				"failed to create control connection: %ld\n",
-				PTR_ERR(connection));
+			"failed to create control connection: %ld\n",
+			PTR_ERR(connection));
 		kfree(control);
 		return ERR_CAST(connection);
 	}
@@ -485,8 +484,8 @@ int gb_control_enable(struct gb_control *control)
 	ret = gb_connection_enable_tx(control->connection);
 	if (ret) {
 		dev_err(&control->connection->intf->dev,
-				"failed to enable control connection: %d\n",
-				ret);
+			"failed to enable control connection: %d\n",
+			ret);
 		return ret;
 	}
 
@@ -547,8 +546,8 @@ int gb_control_add(struct gb_control *control)
 	ret = device_add(&control->dev);
 	if (ret) {
 		dev_err(&control->dev,
-				"failed to register control device: %d\n",
-				ret);
+			"failed to register control device: %d\n",
+			ret);
 		return ret;
 	}
 
-- 
2.17.1

