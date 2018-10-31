Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1CEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A88620664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A88620664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbeKADva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:51:30 -0400
Received: from smtprelay0045.hostedemail.com ([216.40.44.45]:49955 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730097AbeKADva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:51:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 313681802A05F;
        Wed, 31 Oct 2018 18:52:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fire33_877ad5a36332b
X-Filterd-Recvd-Size: 3052
Received: from XPS-9350 (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed, 31 Oct 2018 18:52:10 +0000 (UTC)
Message-ID: <a54f58ee05b190ac66c9a1347027b8d006988b61.camel@perches.com>
Subject: Re: [PATCH] staging: vt6656: clean up few indentation issues
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 31 Oct 2018 11:52:09 -0700
In-Reply-To: <20181030111333.3181-1-colin.king@canonical.com>
References: <20181030111333.3181-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-30 at 11:13 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to clean up indentation issues
[]
> diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
> index ccafcc2c87ac..b613a1d113bb 100644
> --- a/drivers/staging/vt6656/main_usb.c
> +++ b/drivers/staging/vt6656/main_usb.c
> @@ -245,10 +245,10 @@ static int vnt_init_registers(struct vnt_private *priv)
>  		} else {
>  			priv->tx_antenna_mode = ANT_B;
>  
> -		if (priv->tx_rx_ant_inv)
> -			priv->rx_antenna_mode = ANT_A;
> -		else
> -			priv->rx_antenna_mode = ANT_B;
> +			if (priv->tx_rx_ant_inv)
> +				priv->rx_antenna_mode = ANT_A;
> +			else
> +				priv->rx_antenna_mode = ANT_B;
>  		}
>  	}

This one is perhap better resolved by moving
the inversion test after the block like:

---
 drivers/staging/vt6656/main_usb.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index ccafcc2c87ac..3830437e321a 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -227,29 +227,16 @@ static int vnt_init_registers(struct vnt_private *priv)
 	if (antenna == (EEP_ANTENNA_AUX | EEP_ANTENNA_MAIN)) {
 		priv->tx_antenna_mode = ANT_B;
 		priv->rx_antenna_sel = 1;
-
-		if (priv->tx_rx_ant_inv)
-			priv->rx_antenna_mode = ANT_A;
-		else
-			priv->rx_antenna_mode = ANT_B;
 	} else  {
 		priv->rx_antenna_sel = 0;
-
-		if (antenna & EEP_ANTENNA_AUX) {
+		if (antenna & EEP_ANTENNA_AUX)
 			priv->tx_antenna_mode = ANT_A;
-
-			if (priv->tx_rx_ant_inv)
-				priv->rx_antenna_mode = ANT_B;
-			else
-				priv->rx_antenna_mode = ANT_A;
-		} else {
-			priv->tx_antenna_mode = ANT_B;
-
-		if (priv->tx_rx_ant_inv)
-			priv->rx_antenna_mode = ANT_A;
 		else
-			priv->rx_antenna_mode = ANT_B;
-		}
+			priv->tx_antenna_mode = ANT_B;
+	}
+	if (priv->tx_rx_ant_inv) {
+		priv->rx_antenna_mode =
+			(priv->rx_antenna_mode == ANT_A) ? ANT_B : ANT_A;
 	}
 
 	/* Set initial antenna mode */



