Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C02C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE012681E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+rYMQiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE012681E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933972AbeFZJqD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:46:03 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37098 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933784AbeFZJqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:46:01 -0400
Received: by mail-wr0-f193.google.com with SMTP id k6-v6so16539028wrp.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UD9FtkEng4YlTZCunsv+U467EDujgl4hvt37g3gnNi8=;
        b=K+rYMQiW98OSj/d1A3xlQW4c1HluhUgHxYVCdEJZ/Yt9A2TxhWjRgpH54i/zYfkzjb
         eOgjYHOIbcBDt6CltXuuNGL/niOJgYUC7AolaEb9pVjN4X28fKQMqO1ZGn+rlnemPY2h
         gMD985y9GDA13gtr0A46Tgl1dI38oUecZZsnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UD9FtkEng4YlTZCunsv+U467EDujgl4hvt37g3gnNi8=;
        b=LaZLv7uOmmtsdFszh3rKFUrUf1LG132Dc7vQj5BCmqaA03pHaTyBPO+80+Q+3wVo7T
         nPk+skizfvr5kSFH1+PL2oZGRQnyQDfq6mycbWblzVMduULa5qQhEabXYZK966CmgTaA
         1Ws+HeqL6fqJEiN/viTHY/Q06n+t8wxsVFRJEQZ6Yp0DzkXyQQGYsmhRmMrC4mKLR5HX
         /X/dQ4DpqEoTpOyc3uFKt/Ml8VUao8bt2TupFpuluPyzemY7RNA+gXG+LjMnprlity1b
         9+chB3bp0GtrNaa1QKDRWZHuIcPc6sztA/JXNb8UKW85mWLne9dNx9HmOiiIKJGdsqmJ
         BMGw==
X-Gm-Message-State: APt69E1qc2T81XC09EORB6eydpMMvlsg25/765yxOio5TUSeN47C06Ca
        2Bc9L3Y85AeIhVp/PaF+R5BN1HPQiCw=
X-Google-Smtp-Source: AAOMgpdih2PKLsmmFVKTuJ3Q5bNFYBRdXTzsbZGppHNrlxxrOvwQ7/yaBRa+idwGTbrYjMK3438ThA==
X-Received: by 2002:adf:f98a:: with SMTP id f10-v6mr807020wrr.105.1530006359877;
        Tue, 26 Jun 2018 02:45:59 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id f81-v6sm2550915wmh.32.2018.06.26.02.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 02:45:59 -0700 (PDT)
Subject: Re: [PATCH v2 00/12] ASoC: qdsp6: Fix dt based module loading and
 minor fixes
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, tiwai@suse.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
 <20180626094307.GI25217@centauri.ideon.se>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <046a8178-3142-b566-74b9-c853c63d24f8@linaro.org>
Date:   Tue, 26 Jun 2018 10:45:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180626094307.GI25217@centauri.ideon.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/06/18 10:43, Niklas Cassel wrote:
> If the code is bisectable with the current ordering
> of the patches, then feel free to ignore this review
> comment.
Ofcourse the code is bisectable with the current series as it.

thanks,
srini

