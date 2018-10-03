Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1560DC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0A421470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0A421470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeJDERD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:17:03 -0400
Received: from smtprelay0236.hostedemail.com ([216.40.44.236]:32862 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726182AbeJDERD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:17:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 854B2180A8150;
        Wed,  3 Oct 2018 21:26:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shock83_21f3ca6ed728
X-Filterd-Recvd-Size: 1793
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Wed,  3 Oct 2018 21:26:54 +0000 (UTC)
Message-ID: <a32b932c97fcc110c25a4ff5b809174cb29a0b69.camel@perches.com>
Subject: Re: [PATCH 1/3] staging: rtl8188eu: fix line over 80 characters -
 style
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Wed, 03 Oct 2018 14:26:53 -0700
In-Reply-To: <20181003204359.30676-1-straube.linux@gmail.com>
References: <20181003204359.30676-1-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-03 at 22:43 +0200, Michael Straube wrote:
> Line break array declaration to clear a 'line over 80 characters'
> checkpatch warning. For consistency replace 0x0 with 0x00.
[]
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
[]
> @@ -39,7 +39,10 @@ extern unsigned char REALTEK_96B_IE[];
>  /********************************************************
>  MCS rate definitions
>  *********************************************************/
> -unsigned char	MCS_rate_1R[16] = {0xff, 0x00, 0x0, 0x0, 0x01, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0};
> +unsigned char MCS_rate_1R[16] = {
> +	0xff, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +};

Might as well make this const u8.

Here and as well the extern declarations in
	drivers/staging/rtl8188eu/core/rtw_mlme.c
and
	drivers/staging/rtl8188eu/include/rtw_mlme.h


