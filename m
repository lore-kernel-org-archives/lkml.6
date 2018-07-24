Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299E2C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8DE20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="JQ/ajZSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8DE20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388322AbeGXKMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:12:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33199 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388277AbeGXKMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:12:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id s12-v6so2943141ljj.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 02:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/0ZkL1X3kVQ2lK9hrFx5WRXojic5Sp7Z/BpPysytY54=;
        b=JQ/ajZSyTqRAeRmwrmTCVcmbBk6JJ+flYtk6TCLhKkDJHsqJxN6OhPw9I6Hxrl8PnG
         +7OOV0PlumdQGzlaWNP1Q5q+6WAdMGQevBBlBn3ZDWCFXEpFSM1cFSCkcxY9deXp2HAl
         /NnvrAF5NznjwJ7k6hGsWr0x5r2dyQPfMffjdIhx/PxgAFR2O97tKBt9FTjdcnY6jIZb
         7qz6T5aX0nWTS3Uad1HRjoYlSRFMI0vCuG35Kl/zt21uG7qyi6UCQ/MAEEDxaaT+InBJ
         g3E1XlM1OMTyem1cf2zi6MSCN2QC+VrHKaRP0V6QHXvUN/J+0EYk/+Z74vFpVcT2p0uY
         BojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/0ZkL1X3kVQ2lK9hrFx5WRXojic5Sp7Z/BpPysytY54=;
        b=qeSxqL+pEFnmfFONjGshr2uK3sVm/T0QTaAN0kEZbSpytkp6XD/q5whbIubjRHL3bd
         OmdR9ApoP//a5NbC4AhOeElivb6kAOdmjcsubp9tx22ISFPyMVnn0Xo8q+oHzijmnZtS
         acUhluPV/vi6Wr1vvI/BAHMPJ7lkENuNbtNYKazsxti6PwgPnG3+PkCoFl+Jd5m938K2
         NNQUetOnRAXCdbltjrpwgFxHyvGEEgdmNP0B73p4ZnaSTgsJN+s0XOV+j1OMnCL8LxsM
         BTX5bGkomSsNdpBVAXOdqRczGHKhZ777OdDkardmqwHyDHCtUG23XLUhAbeRGEmsQGJu
         0OEw==
X-Gm-Message-State: AOUpUlFAnjREtW6wKgZ0gqWscpzktIhtaznGA5DT4SrIgkuZfN3LlCBS
        3ljXjS0cDXPUzf0rEv2sG0EhXD+ma1I=
X-Google-Smtp-Source: AAOMgpe11sHjatDzrkoUx2i7/+SH4xYHnfWMyPWQ37+z6i0vNcehc9Lz2xkxvLMekIO2IfyM89WDkg==
X-Received: by 2002:a2e:429c:: with SMTP id h28-v6mr1589810ljf.67.1532423225706;
        Tue, 24 Jul 2018 02:07:05 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.87.47])
        by smtp.gmail.com with ESMTPSA id p84-v6sm2180845ljb.19.2018.07.24.02.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 02:07:04 -0700 (PDT)
Subject: Re: [PATCH] mwifiex: Fix skipped vendor specific IEs
To:     roman.stratiienko@globallogic.com, akarwar@marvell.com
Cc:     nishants@marvell.com, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1532352699-3232-1-git-send-email-roman.stratiienko@globallogic.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <c378bdc5-23f9-4eb2-948f-a5944f0a7136@cogentembedded.com>
Date:   Tue, 24 Jul 2018 12:07:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532352699-3232-1-git-send-email-roman.stratiienko@globallogic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 7/23/2018 4:31 PM, roman.stratiienko@globallogic.com wrote:

> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> Only microsoft specific IE is added by FW
> Let other IEs to pass from userspace

    "To" not needed here.

> 
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> ---
>   drivers/net/wireless/marvell/mwifiex/ie.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/ie.c b/drivers/net/wireless/marvell/mwifiex/ie.c
> index c488c30..c58b345 100644
> --- a/drivers/net/wireless/marvell/mwifiex/ie.c
> +++ b/drivers/net/wireless/marvell/mwifiex/ie.c
> @@ -353,8 +353,16 @@ static int mwifiex_uap_parse_tail_ies(struct mwifiex_private *priv,
>   		case WLAN_EID_HT_OPERATION:
>   		case WLAN_EID_VHT_CAPABILITY:
>   		case WLAN_EID_VHT_OPERATION:
> -		case WLAN_EID_VENDOR_SPECIFIC:
>   			break;
> +		case WLAN_EID_VENDOR_SPECIFIC:
> +			/* Skip only Microsoft IE that added by FW
                                                   ^^^^
    That's?

> +			 * Let other vendor specific IE to pass

    "To" not needed here as well...

[...]

MBR, Sergei
