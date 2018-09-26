Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F5AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBA42083A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eB51twwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBA42083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeIZPUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:20:37 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39290 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbeIZPUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:20:37 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8Q98Ucf092407;
        Wed, 26 Sep 2018 04:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537952910;
        bh=4acAp7S6zl5uyRyY6gcP51OO50aOdhO61WMncehT44w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eB51twwEX3MqpqlQbit23Adrtl6JNc7NZ0SB1wCUHsfP0msmNMkoBfNv/Kqgp72rv
         koTZVGOKY5Ef2vtAiCFYPiMtSUkXHCYVOJWY4gFO4GddxiAsfpi33gWhBvRJX6F0T1
         +U4Xft7vFRy18xyy8YY9Q/E2cSQqVW52hKQ8jV5s=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8Q98UeK023006;
        Wed, 26 Sep 2018 04:08:30 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 26
 Sep 2018 04:08:30 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 26 Sep 2018 04:08:30 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8Q98S0a018389;
        Wed, 26 Sep 2018 04:08:28 -0500
Subject: Re: [PATCH] drm/omap: Use ERR_CAST directly instead of
 RR_PTR(PTR_ERR())
To:     zhong jiang <zhongjiang@huawei.com>, <airlied@linux.ie>
CC:     <sre@kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <afd@ti.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <1536666875-11252-1-git-send-email-zhongjiang@huawei.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <6e941d99-4e32-3ae0-31ed-402fba62f2a8@ti.com>
Date:   Wed, 26 Sep 2018 12:08:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536666875-11252-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/18 14:54, zhong jiang wrote:
> We prefer to use ERR_CAST to do so.
> The issue is detected with the help of Coccinelle.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/gpu/drm/omapdrm/dss/dss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dss.c b/drivers/gpu/drm/omapdrm/dss/dss.c
> index cb80dda..1fc46b2 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dss.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dss.c
> @@ -956,7 +956,7 @@ struct dss_debugfs_entry *
>  				&dss_debug_fops);
>  	if (IS_ERR(d)) {
>  		kfree(entry);
> -		return ERR_PTR(PTR_ERR(d));
> +		return ERR_CAST(d);
>  	}
>  
>  	entry->dentry = d;
> 

Thanks, picked this up.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
