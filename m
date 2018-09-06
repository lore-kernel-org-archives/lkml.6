Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C4DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B17220857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B17220857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbeIFPQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:16:51 -0400
Received: from smtprelay0077.hostedemail.com ([216.40.44.77]:58872 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727738AbeIFPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:16:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id CA1F545BC;
        Thu,  6 Sep 2018 10:41:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: humor71_4b7af303c3e0c
X-Filterd-Recvd-Size: 3639
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu,  6 Sep 2018 10:41:58 +0000 (UTC)
Message-ID: <f0dd985b91258f1990e77a2731a59e007dd8a0e0.camel@perches.com>
Subject: Re: [PATCH v2 1/2] staging: rtl8188eu: remove empty if statement in
 rtw_led.c
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 06 Sep 2018 03:41:57 -0700
In-Reply-To: <20180906103248.oxo655vyfmwgwgj4@mwanda>
References: <20180905184408.31175-1-straube.linux@gmail.com>
         <20180906103248.oxo655vyfmwgwgj4@mwanda>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-09-06 at 13:32 +0300, Dan Carpenter wrote:
> Thanks.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

Trivial, but these case statement blocks should prefer
unindented blocks instead of reformatting the test.

Perhaps similar to the below for each of the cases:
---
 drivers/staging/rtl8188eu/core/rtw_led.c | 53 ++++++++++++++++----------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c b/drivers/staging/rtl8188eu/core/rtw_led.c
index cbef871a7679..d9c19c1cda16 100644
--- a/drivers/staging/rtl8188eu/core/rtw_led.c
+++ b/drivers/staging/rtl8188eu/core/rtw_led.c
@@ -290,33 +290,34 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 		}
 		break;
 	case LED_CTL_SITE_SURVEY:
-		if ((pmlmepriv->LinkDetectInfo.bBusyTraffic) && (check_fwstate(pmlmepriv, _FW_LINKED))) {
-			;
-		} else if (!pLed->bLedScanBlinkInProgress) {
-			if (IS_LED_WPS_BLINKING(pLed))
-				return;
-			if (pLed->bLedNoLinkBlinkInProgress) {
-				del_timer_sync(&pLed->BlinkTimer);
-				pLed->bLedNoLinkBlinkInProgress = false;
-			}
-			if (pLed->bLedLinkBlinkInProgress) {
-				del_timer_sync(&pLed->BlinkTimer);
-				 pLed->bLedLinkBlinkInProgress = false;
-			}
-			if (pLed->bLedBlinkInProgress) {
-				del_timer_sync(&pLed->BlinkTimer);
-				pLed->bLedBlinkInProgress = false;
-			}
-			pLed->bLedScanBlinkInProgress = true;
-			pLed->CurrLedState = LED_BLINK_SCAN;
-			pLed->BlinkTimes = 24;
-			if (pLed->bLedOn)
-				pLed->BlinkingLedState = RTW_LED_OFF;
-			else
-				pLed->BlinkingLedState = RTW_LED_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
+		if (pmlmepriv->LinkDetectInfo.bBusyTraffic &&
+		    check_fwstate(pmlmepriv, _FW_LINKED))
+			break;
+		if (pLed->bLedScanBlinkInProgress)
+			break;
+		if (IS_LED_WPS_BLINKING(pLed))
+			return;
+		if (pLed->bLedNoLinkBlinkInProgress) {
+			del_timer_sync(&pLed->BlinkTimer);
+			pLed->bLedNoLinkBlinkInProgress = false;
+		}
+		if (pLed->bLedLinkBlinkInProgress) {
+			del_timer_sync(&pLed->BlinkTimer);
+			pLed->bLedLinkBlinkInProgress = false;
+		}
+		if (pLed->bLedBlinkInProgress) {
+			del_timer_sync(&pLed->BlinkTimer);
+			pLed->bLedBlinkInProgress = false;
 		}
+		pLed->bLedScanBlinkInProgress = true;
+		pLed->CurrLedState = LED_BLINK_SCAN;
+		pLed->BlinkTimes = 24;
+		if (pLed->bLedOn)
+			pLed->BlinkingLedState = RTW_LED_OFF;
+		else
+			pLed->BlinkingLedState = RTW_LED_ON;
+		mod_timer(&pLed->BlinkTimer, jiffies +
+			  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
 		break;
 	case LED_CTL_TX:
 	case LED_CTL_RX:

