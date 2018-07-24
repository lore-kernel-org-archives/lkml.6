Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBFBC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF9D2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g/iX0mj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF9D2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbeGXM44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:56:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41829 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388248AbeGXM4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:56:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so3830282wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 04:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mkhmV/sXacH/rgGQgT7TWcjINdHZnByUHFGHPiR1eVo=;
        b=g/iX0mj0jPu2yks105/oCJz55XdX+SY0SndRi6eNMntPqr7inbH5GO2IVBTxP81uuu
         3dssU1hdyggk1VLcLv/RvH9lzSKAm2hrMAiMMzfBauMA+4xfuKxElGFv3WBG3EB53pTI
         7AuLxnNNWLjz2E0M8AAwuh/ZF3Bd3UYkb1+2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mkhmV/sXacH/rgGQgT7TWcjINdHZnByUHFGHPiR1eVo=;
        b=f7L7PM5c+9/Gor7p8oRBpTp4Rp/vb6VRkC9WYID7hfg8gpCt5on3XJgfRTshp3iXnl
         l1DeYna1J+Wu4RmuRim79oXsRSZftbtgQOlWINLI4mc97EfJ35ftFuj0ChgYtZG/Oeqw
         CYsojf2qxMdG+BIQKl0r1eeyaLo6qYNV9I0DyXuqJu4gkl2XuPKuZ6O95P/iRgVNCqdl
         m8uS8QqjXgbr4QZpmkcpnzf+IVn1Z49gL3HdHNDSocgKI7zRgJ38+qtdO2bjJCLawuLO
         HP2qK3OB6NYjcGcO4s/Eh+AB1Eli4lWIPg1OLyLa04Lmb2JaIWZ9db5m87lQIbd/wHdm
         2mhA==
X-Gm-Message-State: AOUpUlGbmN2917orNulkunlbJrpVu1ax6HxMSQ7eBHf63iIXJsu0YliM
        UIp0qNeo6pJne9+99SaqtFE/O40RJeI=
X-Google-Smtp-Source: AAOMgpduMEApn6zIWDUutA6XHtxaSRTCVt68MlsXmiDi4OZbDDq7BU7cXdyadsb68j777OsKw3MSig==
X-Received: by 2002:adf:d24a:: with SMTP id o10-v6mr11383201wri.229.1532433048472;
        Tue, 24 Jul 2018 04:50:48 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id w204-v6sm2871643wmw.5.2018.07.24.04.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 04:50:47 -0700 (PDT)
Subject: Re: [PATCH 01/12] mfd: dt-bindings: Add wcd9335 mfd bindings
To:     Vinod <vkoul@kernel.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
 <20180723155410.9494-2-srinivas.kandagatla@linaro.org>
 <20180724055620.GJ3219@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <12921bb5-4a69-274c-0735-beb9cc9f843b@linaro.org>
Date:   Tue, 24 Jul 2018 12:50:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180724055620.GJ3219@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/07/18 06:56, Vinod wrote:
> On 23-07-18, 16:53, Srinivas Kandagatla wrote:
>> Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC, supports
>> Qualcomm Technologies, Inc. (QTI) multimedia solutions, including
>> the MSM8996, MSM8976, and MSM8956 chipsets. It has in-build
> 
> in-built perhaps?
> 
Yep, will do that in next version as part of codec bindings!!

