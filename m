Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88928C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083EC21714
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ch7oW1Lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083EC21714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeI1EYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:24:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38924 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeI1EYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:24:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id c12-v6so4114894otl.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oqgMJbhcO2IglCnCbVStRcsqcUrZkhWEcfQJTNfl9OE=;
        b=Ch7oW1Lu3ZVtUCKuEfiVd+2IpB0+RY7ZIXhoLo60etP8s8uwnCpArUWqDPJ+xvbzas
         TUKbgR4Qo7S73ljdQVR7GviMkkAG4RAuzr6aCXW0HzwsXi8i+m/2EDTUv9LI7ZjMAAjw
         diQ6Nxso3KSs4mhAQXkJ+DhSx141S4JOyxezMxc/bRPrinh/Al98K80nj68Gxt3XMSRg
         66jlxD75jPf9nEl6aQQr3Ejif5ZIjnMloBJL1thamRJyGd1awlgi6QDgh6/8hqnWre5S
         pManAI4yVr2gUrcmkWUq8dH13FOv+gSLZ+Zk1mYkYFr7eXVAhvIi6GUOSExlw0etoj/v
         zqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oqgMJbhcO2IglCnCbVStRcsqcUrZkhWEcfQJTNfl9OE=;
        b=WU7NwuEWwsBYPPBI75yhFEYFBZ45ogfbA/RIYABCBOtsBbhcmX9mvtoQuC1J61PWe4
         FCGHSWWx1GnsatqKa9vYuByHUiUilL0aGnBAy9+Ha7+74y13MuauENIEbYipuWszWMEZ
         lkn9hMeY3vXMOrXdBIQByapYpaHaEjKC0xfVYEcThV2mX2bgG8YPcWOq6Aea0DgUHN3D
         s0XlLriklH42f8DjvFTEZmwr/CskJAISOgrv+6yKvzy+u/NNbWS5PUXjuAVZUapPdKlK
         LM0NYgeHfc0dY4zTvlrwfthcpPF5sZORUHWq5MUwg7g93TKbkZmw61BR4T7mjTAl6InY
         EAEQ==
X-Gm-Message-State: ABuFfohhPBPgP80j6lB5IEaAdaSNSVQXWl0yFHQqHMhqAFxnVugyHIdH
        fvr5xtVboFESqvWRsz/HmxSDyj1V
X-Google-Smtp-Source: ACcGV63zPaAWLJLEsqZocJr6Cc/1NTCjYpjm9jJ+JzWwMLNBzMUX22Q7mCD00EhA70fPfJBDQiKTPg==
X-Received: by 2002:a9d:6253:: with SMTP id i19-v6mr372otk.185.1538085855860;
        Thu, 27 Sep 2018 15:04:15 -0700 (PDT)
Received: from [192.168.1.107] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id s21-v6sm1081795otk.7.2018.09.27.15.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 15:04:15 -0700 (PDT)
Subject: Re: [PATCH v2] staging: rtl8188eu: Skip unnecessary field checks
To:     Aymen Qader <qader.aymen@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180927211911.26484-1-qader.aymen@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <ac8995c8-0dee-6f55-fdb7-a1cb9328d364@lwfinger.net>
Date:   Thu, 27 Sep 2018 17:04:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180927211911.26484-1-qader.aymen@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/18 4:19 PM, Aymen Qader wrote:
> Skip unnecessary request field checks when the information element
> pointer is null.
> 
> Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
> ---
> v2: combine pointer check and length check & change commit message to be
> more appropriate
> 
>   drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> index 834053a0ae9d..4d55bbdf8fb7 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> @@ -2971,11 +2971,11 @@ static unsigned int OnAssocReq(struct adapter *padapter,
>   	/*  checking SSID */
>   	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _SSID_IE_, &ie_len,
>   		pkt_len - WLAN_HDR_A3_LEN - ie_offset);
> -	if (!p)
> -		status = _STATS_FAILURE_;
>   
> -	if (ie_len == 0) { /*  broadcast ssid, however it is not allowed in assocreq */
> +	if (!p || ie_len == 0) {
> +		/*  broadcast ssid, however it is not allowed in assocreq */
>   		status = _STATS_FAILURE_;
> +		goto OnAssocReqFail;
>   	} else {
>   		/*  check if ssid match */
>   		if (memcmp((void *)(p+2), cur->Ssid.Ssid, cur->Ssid.SsidLength))
> 

ACKed-by: Larry Finger <Larry.Finger@lwfinger.net>


