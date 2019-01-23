Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A19C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EC4217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfAWCpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 21:45:41 -0500
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:58059 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726814AbfAWCpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 21:45:41 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C8203100E86C1;
        Wed, 23 Jan 2019 02:45:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: turn92_4e603386f7e36
X-Filterd-Recvd-Size: 1800
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed, 23 Jan 2019 02:45:38 +0000 (UTC)
Message-ID: <de570801f163a8d4972661ef794e910a8e1beed5.camel@perches.com>
Subject: Re: [PATCH] staging: ks7010: remove unnecessary parentheses
From:   Joe Perches <joe@perches.com>
To:     Matt McCoy <mattmccoy110@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Quytelda Kahja <quytelda@tamalin.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Tue, 22 Jan 2019 18:45:37 -0800
In-Reply-To: <20190123021816.GA3478@mmccoy>
References: <20190123021816.GA3478@mmccoy>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-22 at 21:18 -0500, Matt McCoy wrote:
> Remove unnecessary parentheses reported by checkpatch.
[]
> diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
[]
> @@ -171,7 +171,7 @@ int get_current_ap(struct ks_wlan_private *priv, struct link_ap_info *ap_info)
>  		   "- rate_set_size=%d\n",
>  		   ap->bssid[0], ap->bssid[1], ap->bssid[2],
>  		   ap->bssid[3], ap->bssid[4], ap->bssid[5],
> -		   &(ap->ssid.body[0]),
> +		   &ap->ssid.body[0],
>  		   ap->rate_set.body[0], ap->rate_set.body[1],
>  		   ap->rate_set.body[2], ap->rate_set.body[3],
>  		   ap->rate_set.body[4], ap->rate_set.body[5],

This bit:

[]
	netdev_dbg(priv->net_dev, "Link AP\n"
		   "- bssid=%02X:%02X:%02X:%02X:%02X:%02X\n"
[]
		   ap->bssid[0], ap->bssid[1], ap->bssid[2],

should instead use the vsprintf %pM extension

		"- bssid: %pM\n"
[]
		ap->bssid,


