Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEF4C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A3220839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A3220839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeILCGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:06:23 -0400
Received: from smtprelay0194.hostedemail.com ([216.40.44.194]:38301 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726870AbeILCGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:06:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 372F4100E86C3;
        Tue, 11 Sep 2018 21:05:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crack73_84d81cde84109
X-Filterd-Recvd-Size: 2254
Received: from XPS-9350 (unknown [172.56.6.146])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 11 Sep 2018 21:05:12 +0000 (UTC)
Message-ID: <7a842c452d57684377eb3fb50984d130d7dc0401.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8188eu: change array type to u8
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180910203805.10342-1-straube.linux@gmail.com>
References: <20180910203805.10342-1-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date:   Tue, 11 Sep 2018 04:23:22 -0700
Mime-Version: 1.0
X-Mailer: Evolution 3.28.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-10 at 22:38 +0200, Michael Straube wrote:
> The the last two parameters of write_cam() have type u8.
> Change the type of the passed arrays from unsigned char to u8.
> Clears a line over 80 characters checkpatch warning.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
> index 3e0801858737..fb496ab5a862 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
> @@ -454,9 +454,9 @@ void write_cam(struct adapter *padapter, u8 entry, u16 ctrl, u8 *mac, u8 *key)
>  
>  void clear_cam_entry(struct adapter *padapter, u8 entry)
>  {
> -	unsigned char null_sta[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
> -	unsigned char null_key[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -				    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
> +	u8 null_sta[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
> +	u8 null_key[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +			 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};

static const

could also be written

	static const u8 null_sta[ETH_ALEN] = {};
	static const u8 null_key[16] = {};

>  
>  	write_cam(padapter, entry, 0, null_sta, null_key);
>  }
