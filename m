Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A948EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 23:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5260E2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 23:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5260E2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756905AbeFPXOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 19:14:05 -0400
Received: from smtprelay0158.hostedemail.com ([216.40.44.158]:40517 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754164AbeFPXOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 19:14:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 1595018028201;
        Sat, 16 Jun 2018 23:14:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fork01_7a6c7c0398a01
X-Filterd-Recvd-Size: 3394
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sat, 16 Jun 2018 23:14:01 +0000 (UTC)
Message-ID: <5ad0ea84d5b8733e7bb7a647e185f2577c073cf5.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8192u: fix line over 80 characters
From:   Joe Perches <joe@perches.com>
To:     valdis.kletnieks@vt.edu, Hyunil Kim <thtlwlsmsgkfla@gmail.com>
Cc:     gregkh@linuxfoundation.org, davem@davemloft.net,
        colin.king@canonical.com, johannes.berg@intel.com,
        Linyu.Yuan@alcatel-sbell.com.cn, keescook@chromium.org,
        tvboxspy@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Sat, 16 Jun 2018 16:13:59 -0700
In-Reply-To: <127735.1529176927@turing-police.cc.vt.edu>
References: <1909265.MoDodiKBI3@os-virtualbox>
         <127735.1529176927@turing-police.cc.vt.edu>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-06-16 at 15:22 -0400, valdis.kletnieks@vt.edu wrote:
> On Sat, 16 Jun 2018 15:00:31 +0900, Hyunil Kim said:
> > *fix checkpatch.pl warnings:
> >  WARNING: line over 80 characters
> > +		if (((ieee->wpa_ie[0] == 0xdd) &&
> > +		    (!memcmp(&(ieee->wpa_ie[14]), ccmp_ie, 4))) ||
> > +		    ((ieee->wpa_ie[0] == 0x30) &&
> > +		    (!memcmp(&ieee->wpa_ie[10], ccmp_rsn_ie, 4))))
> 
> Ouch. The && and || at ends of line mean a lot of parenthesis counting to
> figure out which goes with which.  Use additional indentation to help
> understanding.
> 
> +		if (((ieee->wpa_ie[0] == 0xdd) &&
> +			(!memcmp(&(ieee->wpa_ie[14]), ccmp_ie, 4))) ||
> +		    ((ieee->wpa_ie[0] == 0x30) &&
> +			(!memcmp(&ieee->wpa_ie[10], ccmp_rsn_ie, 4))))
> 
> Or perhaps
> 
> +		if (((ieee->wpa_ie[0] == 0xdd) &&
> +			(!memcmp(&(ieee->wpa_ie[14]), ccmp_ie, 4)))
> +		     || ((ieee->wpa_ie[0] == 0x30) &&
> +			(!memcmp(&ieee->wpa_ie[10], ccmp_rsn_ie, 4))))

Or perhaps refactor to something like:
---
 drivers/staging/rtl8192u/r8192U_core.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 8b17400f6c13..593ecc0ae1ae 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2039,20 +2039,18 @@ static bool GetNmodeSupportBySecCfg8192(struct net_device *dev)
 		   (strcmp(crypt->ops->name, "WEP") == 0));
 
 	/* simply judge  */
-	if (encrypt && (wpa_ie_len == 0)) {
-		/* wep encryption, no N mode setting */
+	/* wep encryption, no N mode setting */
+	if (encrypt && wpa_ie_len == 0)
 		return false;
-	} else if ((wpa_ie_len != 0)) {
-		/* parse pairwise key type */
-		if (((ieee->wpa_ie[0] == 0xdd) && (!memcmp(&(ieee->wpa_ie[14]), ccmp_ie, 4))) || ((ieee->wpa_ie[0] == 0x30) && (!memcmp(&ieee->wpa_ie[10], ccmp_rsn_ie, 4))))
-			return true;
-		else
-			return false;
-	} else {
+
+	if (wpa_ie_len == 0)
 		return true;
-	}
 
-	return true;
+	/* parse pairwise key type */
+	return (ieee->wpa_ie[0] == 0xdd &&
+		!memcmp(&ieee->wpa_ie[14], ccmp_ie, 4)) ||
+	       (ieee->wpa_ie[0] == 0x30 &&
+		!memcmp(&ieee->wpa_ie[10], ccmp_rsn_ie, 4));
 }
 
 static bool GetHalfNmodeSupportByAPs819xUsb(struct net_device *dev)

