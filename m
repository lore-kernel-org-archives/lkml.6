Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D866ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 22:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C09D20848
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 22:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C09D20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbeJ1Hk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 03:40:28 -0400
Received: from smtprelay0136.hostedemail.com ([216.40.44.136]:55966 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729065AbeJ1Hk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 03:40:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id CD1CB18029592;
        Sat, 27 Oct 2018 22:57:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: apple36_b0a5ec48f913
X-Filterd-Recvd-Size: 1524
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sat, 27 Oct 2018 22:57:55 +0000 (UTC)
Message-ID: <bcb65c2930ae7efd78183f744059f2d29a743b88.camel@perches.com>
Subject: Re: [PATCH 4/5] staging: rtl8188eu: change return type of
 rtw_hal_xmit()
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sat, 27 Oct 2018 15:57:54 -0700
In-Reply-To: <20181027202850.25636-4-straube.linux@gmail.com>
References: <20181027202850.25636-1-straube.linux@gmail.com>
         <20181027202850.25636-4-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-10-27 at 22:28 +0200, Michael Straube wrote:
> The function rtw_hal_xmit() returns true or false.
> Change the return type from s32 to bool.
[]
> diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
[]
> @@ -598,7 +598,7 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt,
>   *	true	dump packet directly
>   *	false	enqueue packet
>   */
> -s32 rtw_hal_xmit(struct adapter *adapt, struct xmit_frame *pxmitframe)
> +bool rtw_hal_xmit(struct adapter *adapt, struct xmit_frame *pxmitframe)
>  {
>  	s32 res;

Does "s32 res" need changing to bool too?


