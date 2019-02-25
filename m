Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5BAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968F820842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfBYGmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 01:42:54 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.3]:45675 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727089AbfBYGmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 01:42:51 -0500
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-central-1.aws.symcld.net id 42/86-17148-66E837C5; Mon, 25 Feb 2019 06:42:46 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRWlGSWpSXmKPExsVy8+3OTbppfcU
  xBkvXsVhMffiEzWL+kXOsFqe2NzFZfLvSwWRxedccNovZS/pZLJZev8hk0br3CLvF/iteDpwe
  a+atYfT49nUSi8fOWXfZPTat6mTzOH5jO5PH501yAWxRrJl5SfkVCawZuzevYirYz1axYdoRp
  gbGh6xdjFwcQgJPGSUuH9gI5HACORUSvY072EFsNgErid1rFrOA2CICyhJXv+8Fs5kFepkkpv
  4PB7GFBQIlpk4+zwZiswioSvyduAvM5hXwlTh8YB/YTAkBOYmb5zqZQWxOAT+J++e/s0AsnsA
  o0dZ2kBWiQVDi5MwnUAskJA6+eMEMcZCWxNV/B9khBilInFu/jQnCjpNYvOgkUD0HkK0p0fkg
  CyJsLzH9/VVmCNtQ4vusbywQtrnEvHtToOI2Eof+trJB2KYSm75OZ5vAKDYLyRWzkFyxgJFpF
  aNlUlFmekZJbmJmjq6hgYGuoaGxrpGuobmZXmKVbqJeaqlucmpeSVEiUFYvsbxYr7gyNzknRS
  8vtWQTIzBuUwqZNuxgfLYw/RCjJAeTkiivTW5xjBBfUn5KZUZicUZ8UWlOavEhRhkODiUJ3rg
  eoJxgUWp6akVaZg4wgcCkJTh4lER4k3qB0rzFBYm5xZnpEKlTjIpS4rz3QPoEQBIZpXlwbbCk
  dYlRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMG8jyBSezLwSuOmvgBYzAS3u+5IPsrgkESEl1
  cCYtI3ph3bEK/6A/R/k82TmavkeSGdV777o+7KE+7rMW/7p+/4prOlLf/ruudfqehHFna0NLR
  cWcthMll8VsG/N32taV67u69qWqXJ/r0vw+78vBY6ertGK7maz/LKUbXaxUgXzYtHuqhCuHxO
  OsCvtzPqyY/7cRy4LjHraZ/c+2ZFseuK9ouJ6JZbijERDLeai4kQAK4h/L1UDAAA=
X-Env-Sender: Christian.Hohnstaedt@wago.com
X-Msg-Ref: server-25.tower-223.messagelabs.com!1551076965!1517155!1
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2326 invoked from network); 25 Feb 2019 06:42:46 -0000
Received: from unknown (HELO mail.wago.com) (217.237.185.178)
  by server-25.tower-223.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 25 Feb 2019 06:42:46 -0000
Received: from lc010965.wago.local (10.1.101.138) by SVEX01011.wago.local
 (10.1.103.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Mon, 25 Feb
 2019 07:42:45 +0100
Received: by lc010965.wago.local (Postfix, from userid 11100404)
        id 28B5E1700210; Mon, 25 Feb 2019 07:42:45 +0100 (CET)
From:   Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
To:     Mark Brown <broonie@kernel.org>
CC:     J Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Lindgren <tony@atomide.com>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: regulator: add LS2 load switch documentation
Date:   Mon, 25 Feb 2019 07:41:05 +0100
Message-ID: <1551076866-12578-2-git-send-email-Christian.Hohnstaedt@wago.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551076866-12578-1-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1551076866-12578-1-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.101.138]
X-ClientProxiedBy: SVEX01010.wago.local (10.1.103.228) To SVEX01011.wago.local
 (10.1.103.229)
X-KSE-ServerInfo: SVEX01011.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 25.02.2019 03:58:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-PP-Proceessed: 7aa37ed7-add0-4ed7-8916-66d632c2b0a3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document device-tree settings of the load-switch LS2
in the tps65218 device.

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
---
 Documentation/devicetree/bindings/regulator/tps65218.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/tps65218.txt b/Documentation/devicetree/bindings/regulator/tps65218.txt
index 02f0e9b..b28e9bd 100644
--- a/Documentation/devicetree/bindings/regulator/tps65218.txt
+++ b/Documentation/devicetree/bindings/regulator/tps65218.txt
@@ -71,6 +71,11 @@ tps65218: tps65218@24 {
 		regulator-always-on;
 	};
 
+	ls2: regulator-ls2 {
+		regulator-min-microamp = <100000>;
+		regulator-max-microamp = <1000000>;
+	};
+
 	ls3: regulator-ls3 {
 		regulator-min-microvolt = <100000>;
 		regulator-max-microvolt = <1000000>;
-- 
2.7.4

