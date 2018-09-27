Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE8AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2012159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X10WO7A7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2012159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeI1DNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:13:04 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41982 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbeI1DND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:13:03 -0400
Received: by mail-ot1-f66.google.com with SMTP id e18-v6so3929771oti.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 13:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5cQOptbLf3Q2CYqwnObZNKV+hFP0ddGzeW8BrA7m10s=;
        b=X10WO7A77E63RvnAKvvmLMU/KAbEKjjN71+c9KQo4P9bYGoeY58HtIL90DtKvKIZTo
         o9PYHvMNzZvigWcLTOiOER73ueRr724XYN9E5Sdy+71jXes4ElmrhTQFPuVXDSfCKa+3
         Ka3ZbLG+aqMvZwvbN9rovaNECPG5C/3rNYfrQ/S4WXAE9HLK/TWLu/LEVfZn04XxZ+zv
         nkkIwOGJbMeZ6ZC388sfv2YQ6sCzB9pApFfo7tLe21voneG3fJ+gejs7TRdwGXM66pVg
         AuWwIJyNupiHJHrXSrjI9os+7ijO0UaXl1zseFRi5TRMzmHg6ARSR5k8/2qboCHVXV5P
         iVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5cQOptbLf3Q2CYqwnObZNKV+hFP0ddGzeW8BrA7m10s=;
        b=QGVA7FIN1ausK+evDvDfDyqxQ55IahNfPdsDkbqubMk4Yy++lHgGm+g+f+hPu3RP+k
         Jc91aPr9G62jWtOIx1tx5gTSyeSvWxZSVcPFWuX26QwqFp4ZgRJijuZmJrSPq4tnv2H2
         4vWPPKj9WrC4lzoOlF+PKEIoaH3pKTa8u+7VffgY84cdWrd6LPQ6wYvtmiCv8dB0v9pl
         SX55688kmABiqTMQ4b8WQgTpZOe3OFFEy4a6JqWGw8KPWKupzUAC2wAGDUK9S+AWSyzF
         g1gsfa6YiXoZC2/osJspF81tOymxCB1kfLm5kqfdBN/8KqgkTujyrZ7liEQ34hDP/hw5
         wSEQ==
X-Gm-Message-State: ABuFfohk1r8aQjtMaq6qbZ/jIS3hxNPDhCwYaDPc0yfw1MIG6fFxhbbO
        VXcH7NqKxOoedAoNUpwM91vQkBCi
X-Google-Smtp-Source: ACcGV638qKaZ++2iSAABiBuTX563bvywpdhri+EeFT78YulNxfkNym4phfPAWkyXWoNhAU8cq2ZUbg==
X-Received: by 2002:a9d:3437:: with SMTP id v52-v6mr8413951otb.231.1538081574804;
        Thu, 27 Sep 2018 13:52:54 -0700 (PDT)
Received: from [192.168.1.107] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id h22-v6sm1674099otd.21.2018.09.27.13.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 13:52:54 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8188eu: Avoid null pointer arithmetic
To:     Aymen Qader <qader.aymen@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180927170408.4495-1-qader.aymen@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <96968145-e727-56ac-1a74-8458e479b7bf@lwfinger.net>
Date:   Thu, 27 Sep 2018 15:52:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180927170408.4495-1-qader.aymen@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/18 12:04 PM, Aymen Qader wrote:
> Avoid null pointer arithmetic in rtw_mlme_ext.c by skipping other field
> checks if the information element pointer is null.
> 
> Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
> ---
>   drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> index 834053a0ae9d..8a3a71456cd0 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> @@ -2971,8 +2971,10 @@ static unsigned int OnAssocReq(struct adapter *padapter,
>   	/*  checking SSID */
>   	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _SSID_IE_, &ie_len,
>   		pkt_len - WLAN_HDR_A3_LEN - ie_offset);
> -	if (!p)
> +	if (!p) {
>   		status = _STATS_FAILURE_;
> +		goto OnAssocReqFail;
> +	}
>   
>   	if (ie_len == 0) { /*  broadcast ssid, however it is not allowed in assocreq */
>   		status = _STATS_FAILURE_;

I do not think this patch avoids any pointer arithmetic. If p is NULL, then 
ie_len will be zero and the branch with the memcmp() call, where the pointer 
arithmetic is done, will be skipped.

That said, it is better to bail out with the first failure condition. I do not 
require the following, but the code would be even simpler if you test p and 
ie_len==0 in a single if statement and eliminate some code as in

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c 
b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 1115050077e4..71722cec84a0 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -2982,11 +2982,10 @@ static unsigned int OnAssocReq(struct adapter *padapter,
         /*  checking SSID */
         p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _SSID_IE_, &ie_len,
                 pkt_len - WLAN_HDR_A3_LEN - ie_offset);
-       if (!p)
-               status = _STATS_FAILURE_;

-       if (ie_len == 0) { /*  broadcast ssid, however it is not allowed in 
assocreq */
+       if (!p || ie_len == 0) { /*  broadcast ssid, however it is not allowed 
in assocreq */
                 status = _STATS_FAILURE_;
+               goto OnAssocReqFail;
         } else {
                 /*  check if ssid match */
                 if (memcmp((void *)(p+2), cur->Ssid.Ssid, cur->Ssid.SsidLength))


ACKed-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks,

Larry

