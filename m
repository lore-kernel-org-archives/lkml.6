Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC12DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C39F2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JJ1AIGhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfAOMQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:16:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32912 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbfAOMQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:16:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so904004wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 04:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F8IsAruX63J0gvKiKSyGO89h1QwaCt0EX3fhyWAjg1U=;
        b=JJ1AIGhD5gFbjfcqRgkrHzHCsFs04Ql+RmXXZ4T4pjBVNbG1Bm9JP95EeDK2vaWkX+
         HKH/ltSIxOFbRfJ2OmyuFE+asT7zBDRRPGURssEgG/Loo5f4IxOmhEGR/mtmiBGUlYmk
         nqIo0AJU6OZ8AkNshrRbioryDuMwCk30xQgPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F8IsAruX63J0gvKiKSyGO89h1QwaCt0EX3fhyWAjg1U=;
        b=NoZm3edRvFswwuyCnpkCIYdn/v2m9xbe/VuBukDJI+lRdsQnKb2dYmQGNx33l9RoOJ
         beJbQIl4MaeXGIS9VsTtPh9vHfIqmVXWftgZ3HeB03XmR8Jog6roCEMAvCClpLpumib/
         T23Rf5OcfrWJoeWVwqKLml7xP7OaZfMOZqwQgY4VEDInEI57Xv2Au0ml16XWZMLkOTy1
         m3okMHnG6xG5TrUc3QtBSid6gKqhYhFRlb9qFD5EvNL33IXe6Pi9Ez1fOjrZ+1y1R+1j
         zT57Gv9KTf20gA7u1WrFWYmiix8lEe/KE0rnGQtVzGLNCgEWofEpEBR8K0xHykmhpWin
         RQ8g==
X-Gm-Message-State: AJcUukeSHUEj2OfqII6oRrsSJw97hjJDEd/PBgralWkYgXZtFtjWk7uM
        IPQICeMB41ZuR7lJxlIf8M3xog==
X-Google-Smtp-Source: ALg8bN5snGWAD2kJryTOzv4QdqzserEHHrdYF9ygWHQt+d1BsVujRgjuuNaHFSfinqiagc9GfxAl9g==
X-Received: by 2002:a1c:bc82:: with SMTP id m124mr3083525wmf.77.1547554612321;
        Tue, 15 Jan 2019 04:16:52 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id l14sm156094056wrp.55.2019.01.15.04.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 04:16:51 -0800 (PST)
Subject: Re: [PATCH 1/2] nvmem: imx-ocotp: add i.MX7ULP support
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1544777136-9195-1-git-send-email-Anson.Huang@nxp.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4a1f2741-cb03-9f72-8039-1f82eb854b2c@linaro.org>
Date:   Tue, 15 Jan 2019 12:16:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544777136-9195-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/12/2018 08:51, Anson Huang wrote:
> i.MX7ULP is a new SoC of i.MX family which has 8 kbit eFuse OTP,
> enable ocotp driver support for this SoC.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>   drivers/nvmem/imx-ocotp.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
Thanks Applied both patches!

--srini
