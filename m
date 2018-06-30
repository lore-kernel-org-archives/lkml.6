Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE90C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC3925709
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC3925709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030320AbeF3KIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 06:08:30 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:41743 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934077AbeF3KI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 06:08:29 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41Hq3H1H8kz1qtGx;
        Sat, 30 Jun 2018 12:08:26 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41Hq3G20bKz1rZLp;
        Sat, 30 Jun 2018 12:08:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id LHbVgFkdZK6i; Sat, 30 Jun 2018 12:08:25 +0200 (CEST)
X-Auth-Info: OlqHQ4+C+0NtIWHsUcuc1FjfnIC1a++yIx6VfquZWUECkPYhCWoUGbiK1u+Tui+P
Received: from linux.local (ppp-188-174-148-26.dynamic.mnet-online.de [188.174.148.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 30 Jun 2018 12:08:25 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
        id D7BE11E587F; Sat, 30 Jun 2018 12:08:24 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix comparsion to true/false and brace issues
References: <20180630100252.572-1-straube.linux@gmail.com>
X-Yow:  Now I need a suntan, a tennis lesson, Annette Funicello and two dozen
 Day-Glo orange paper jumpsuits!!
Date:   Sat, 30 Jun 2018 12:08:24 +0200
In-Reply-To: <20180630100252.572-1-straube.linux@gmail.com> (Michael Straube's
        message of "Sat, 30 Jun 2018 12:02:52 +0200")
Message-ID: <m2tvpkegdj.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 30 2018, Michael Straube <straube.linux@gmail.com> wrote:

> @@ -115,11 +115,10 @@ s32 rtw_btcoex_IsBTCoexCtrlAMPDUSize(struct adapter *padapter)
>  
>  void rtw_btcoex_SetManualControl(struct adapter *padapter, u8 manual)
>  {
> -	if (true == manual) {
> +	if (manual)
>  		hal_btcoex_SetManualControl(padapter, true);
> -	} else{
> +	else
>  		hal_btcoex_SetManualControl(padapter, false);
> -	}

aka. hal_btcoex_SetManualControl(padapter, manual);

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
