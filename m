Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F6BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D3821571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxFcLykr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D3821571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbeI1DdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:33:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54220 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbeI1DdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:33:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id b19-v6so218972wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 14:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=94jf4jMsAlSUxK1ho48R+3/pZWxZZCO1NRsXTs0bpdM=;
        b=oxFcLykr6OxOW+vk7orFIYdauEn5PtB9sfNWpcHx2aY18fnbFtbogwjP3rlOikj+7V
         ECiTYLc/7Mq1hNoyV+sFnYzBzV0ulmXUSouNIoCKk0YLE/xi6cTpvAERjXca6iRxc1gt
         Lq4k8Kixkm4mEZydKflDdqDCH7Yyrl8GM/Hp/JbDVvIFF9Z26mcKeG8ZvLlDYLhmCVuM
         RLgHFXxOM/h48qhw8H0mobIQ5SkC5d154z7zGa9cyJ9hUQ4EHjH6KqbEalNjG6Fum2an
         VSapVlwfECxVdkOVyN4kLSHFMNxCgvbY9k79fOGzUzEGMxN19uuAwtmyb8ZN2ai/j1yZ
         XB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=94jf4jMsAlSUxK1ho48R+3/pZWxZZCO1NRsXTs0bpdM=;
        b=FCMcevEa+R/D0OkvFnKjFKlGG+N90pRocWYY1LinXiU0iYCHitBTrjGps+88+LU5+z
         1lP/xKuiAkQmQirrh76J1bM/3DBz8fTOudY2fOAubWhIRiRgMP+md/0UWj2atRopBwZF
         XRZtt07pcb9hvtxjZ7nZdRcCX+8GTiaUoxP9pVAeVFkzJmGHuTBnofWIiKPpHoNXdaXO
         OhjLUPVVlG/jMm96lp/Ih7G/VgyXia1Wx/HLelFI+neqh7tw6Z5JijHbPg8SyMBNzZRD
         VkvChQWChYwGc08sBRSQqJwwyZcnyVQjf04V0PLcASO/FqlLZRywdULlUvgsKt8uvF37
         j/Cw==
X-Gm-Message-State: ABuFfoikiKHH0lWLqlKGZ74bz0S8ALw4Saozm0gWla67kQwFmPHcrSlf
        BSGQ3x3Zxc6MvtvQQ0ZeH1k=
X-Google-Smtp-Source: ACcGV61LskvSZbkT5fWpkfvEI3TVo4tPX4t8rqxt+ASoyNoS70Sx0kyWjNcEZvPhijrdfos3A7v6ZA==
X-Received: by 2002:a1c:f53:: with SMTP id 80-v6mr240646wmp.58.1538082777123;
        Thu, 27 Sep 2018 14:12:57 -0700 (PDT)
Received: from localhost.localdomain ([2a01:388:3ce:110::1:5])
        by smtp.gmail.com with ESMTPSA id 75-v6sm225053wml.21.2018.09.27.14.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 14:12:56 -0700 (PDT)
Date:   Thu, 27 Sep 2018 22:12:54 +0100
From:   Aymen Qader <qader.aymen@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Avoid null pointer arithmetic
Message-ID: <20180927211254.v2s7hdfubjird376@localhost.localdomain>
References: <20180927170408.4495-1-qader.aymen@gmail.com>
 <96968145-e727-56ac-1a74-8458e479b7bf@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96968145-e727-56ac-1a74-8458e479b7bf@lwfinger.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 03:52:53PM -0500, Larry Finger wrote:
> On 9/27/18 12:04 PM, Aymen Qader wrote:
> > Avoid null pointer arithmetic in rtw_mlme_ext.c by skipping other field
> > checks if the information element pointer is null.
> > 
> > Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
> > ---
> >   drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> > index 834053a0ae9d..8a3a71456cd0 100644
> > --- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> > +++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> > @@ -2971,8 +2971,10 @@ static unsigned int OnAssocReq(struct adapter *padapter,
> >   	/*  checking SSID */
> >   	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _SSID_IE_, &ie_len,
> >   		pkt_len - WLAN_HDR_A3_LEN - ie_offset);
> > -	if (!p)
> > +	if (!p) {
> >   		status = _STATS_FAILURE_;
> > +		goto OnAssocReqFail;
> > +	}
> >   	if (ie_len == 0) { /*  broadcast ssid, however it is not allowed in assocreq */
> >   		status = _STATS_FAILURE_;
> 
> I do not think this patch avoids any pointer arithmetic. If p is NULL, then
> ie_len will be zero and the branch with the memcmp() call, where the pointer
> arithmetic is done, will be skipped.
I'm sincerely sorry, you're completely right--that was a bad oversight
from me, I should have checked more thoroughly.

> 
> That said, it is better to bail out with the first failure condition. I do
> not require the following, but the code would be even simpler if you test p
> and ie_len==0 in a single if statement and eliminate some code as in
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> index 1115050077e4..71722cec84a0 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> @@ -2982,11 +2982,10 @@ static unsigned int OnAssocReq(struct adapter *padapter,
>         /*  checking SSID */
>         p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _SSID_IE_, &ie_len,
>                 pkt_len - WLAN_HDR_A3_LEN - ie_offset);
> -       if (!p)
> -               status = _STATS_FAILURE_;
> 
> -       if (ie_len == 0) { /*  broadcast ssid, however it is not allowed in
> assocreq */
> +       if (!p || ie_len == 0) { /*  broadcast ssid, however it is not
> allowed in assocreq */
>                 status = _STATS_FAILURE_;
> +               goto OnAssocReqFail;
>         } else {
>                 /*  check if ssid match */
>                 if (memcmp((void *)(p+2), cur->Ssid.Ssid, cur->Ssid.SsidLength))
> 

Yep, I understand that would be a lot better. If it's alright, I'll send
this in with a v2 (w/ a more appropriate commit message).

> 
> ACKed-by: Larry Finger <Larry.Finger@lwfinger.net>
> 
> Thanks,
> 
> Larry
> 

Kind regards,
Aymen
