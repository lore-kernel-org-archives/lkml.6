Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CC0C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB33206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ltVQibBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB33206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeJALsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 07:48:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54870 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbeJALsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 07:48:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9159NYo139656;
        Mon, 1 Oct 2018 05:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=r+9Hd56pwrxJM2XDwFAUl/yvzk8a/WzJjbqheREvFpg=;
 b=ltVQibBp4QGFAvTVY4rT3LVeQOVx+MKWWin6Upy16+QZ0AABNuQZlIxtFRyoPrDRY5jY
 4m4awsClUDE+bbc1xoUULYyW6a3aavrPs5z/4j2rXI7dEFI3If43z8haPn1WEhIRZPHk
 GdZeBJ7UfqqpwbSpzz6wAyob4tocYpZVlXS/AYceyHRQmg0Bc58cifmQLD9zNQmrmk1p
 Ud6BiC/zDqYuMYewLzoYKwsfy5lRQt8tQZLlnJeLaukCioH9wRY4P7FnmxlWjIN5KBcb
 MhRJ4MsIjeyFhzydsiWvBUzMDRkU/J9vgL5oLP1rtyirkCzmW3eYFHBMnUTCl96SDLJR hQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2mt1bpmpqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Oct 2018 05:12:20 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w915CIrA022587
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Oct 2018 05:12:19 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w915CItp031330;
        Mon, 1 Oct 2018 05:12:18 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 Sep 2018 22:12:17 -0700
Date:   Mon, 1 Oct 2018 08:12:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/19] staging: rtl8188eu: cleanup inconsistent indenting
Message-ID: <20181001051211.zdpy7otztjrg7gr6@mwanda>
References: <20180930195310.1531-1-straube.linux@gmail.com>
 <c9e0b48d829e9b598b7bb68d1152e56ef0c846f9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9e0b48d829e9b598b7bb68d1152e56ef0c846f9.camel@perches.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9032 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=641
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810010054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 01:30:11PM -0700, Joe Perches wrote:
> On Sun, 2018-09-30 at 21:52 +0200, Michael Straube wrote:
> > Cleanup all inconsistent indenting reported by smatch.
> 
> There are also some others like:
> 
> drivers/staging/rtl8188eu/core/rtw_mlme.c:1752: WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (8, 24)
> 1750:	if ((ndisauthmode == Ndis802_11AuthModeWPA) ||
> 1751:	    (ndisauthmode == Ndis802_11AuthModeWPAPSK))
> 1752:			authmode = _WPA_IE_ID_;
> 
> Perhaps smatch can be enhanced to find those too.
> 

Style issues are not something I want to get into...  I had hoped that
this test would find bugs, because stuff like this looks so suspicious:

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index 20f34d25c369..5c4ff81987bd 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -246,7 +246,7 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
                wireless_mode = pregistrypriv->wireless_mode;
        }

-               rtw_set_supported_rate(pdev_network->SupportedRates, wireless_mode);
+       rtw_set_supported_rate(pdev_network->SupportedRates, wireless_mode);

        rateLen = rtw_get_rateset_len(pdev_network->SupportedRates);

But I've never found even one bug with the inconsistent indenting
check.  The other related test about missing curly braces is pretty
useful though.

regards,
dan carpenter

