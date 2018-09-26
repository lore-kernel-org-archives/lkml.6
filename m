Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C98ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88049204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pdRGELZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88049204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeIZPJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:09:34 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38360 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeIZPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:09:33 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8Q8vagc089696;
        Wed, 26 Sep 2018 03:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537952256;
        bh=ykVXh65nAoBEpivZacGRlqK0lI61VLKIq07NeTiOe4c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pdRGELZABNpcnyjnCABBL6tRXmCxvf0/kPa85gqmGKDiAMsmBA3SWZODx6NC71dOa
         Q2NFzhzscFDAW1/Y8hlp7BDv692lsKbNwDRKiyVYqKTR/1XFC9ZQndmCwYs1Gqum98
         6Ft22JtGPEb0GxBVyx9ecBTDfJmOY/LfcSQaFv5Q=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8Q8vacK005978;
        Wed, 26 Sep 2018 03:57:36 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 26
 Sep 2018 03:57:36 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 26 Sep 2018 03:57:35 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8Q8vY5g014168;
        Wed, 26 Sep 2018 03:57:34 -0500
Subject: Re: [PATCH] drm: omap: remove unused header tcm-sita.h
To:     Corentin Labbe <clabbe@baylibre.com>, <airlied@linux.ie>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <1537902997-19949-1-git-send-email-clabbe@baylibre.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <40233339-0f6d-363a-0515-8d0f21bd044e@ti.com>
Date:   Wed, 26 Sep 2018 11:57:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537902997-19949-1-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/18 22:16, Corentin Labbe wrote:
> tcm-sita.h is unused since commit 0d6fa53fd805 ("drm/omap: Use bitmaps for TILER placement")
> Let's remove it.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/gpu/drm/omapdrm/tcm-sita.h | 93 --------------------------------------
>  1 file changed, 93 deletions(-)
>  delete mode 100644 drivers/gpu/drm/omapdrm/tcm-sita.h

Thanks, applied! Not sure how we've missed that.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
