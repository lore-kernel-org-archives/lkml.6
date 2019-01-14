Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F90C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E622086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DJ0JDd8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfANOzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:55:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37167 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfANOzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:55:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so9123850wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 06:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oa9ke6JR5IcUazwBQMrR9QMWQ3XVe7RBZF7trgI7iVU=;
        b=DJ0JDd8HYbdNbxN1AjTIWsrsLsYeJ3l3XOqzi2h7kLLlJNA1D2h6B0l34wsLR0ixtc
         RadMx5HEPKGsTMA7ZSbKVktU+m5Uor+kxFN03DWLyxqKPH44/wc4OcdGCuTfOl9+1s/+
         gAqz3SLQU0GlNPUYk5lgJJm1QDWoijo451Jrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oa9ke6JR5IcUazwBQMrR9QMWQ3XVe7RBZF7trgI7iVU=;
        b=uU8nRMzVElDRL+r1yBFv7/Zpj7SPVTlQD3GxuOlL4ha6zlm20y95xxTSC3zBRLp3LX
         7c3uYSMfEcIapRIFheWOf0SZu/zz0hP/6nmMiH9EfTRJAtrdbl8PGrr4pjIRreagkL30
         O3Vn0Ulsg2iCoacWiPvoqqbOTvfOcKWZvsTqyiPvGabY5V8Fp0yKhI2YYzst038w4xKk
         AuzxZ40YHhovxlJEeKt2Leughj+N4tQYCuMXtlwGJfoMJSCnefYljP4v2RArDKw+djw1
         kvFep1q2gkkxxPiSBizEkM2tmdSVLkA036X9slOqQAXMqm5HfnhxO/VI2BLZ0Cj0ogem
         lxzg==
X-Gm-Message-State: AJcUukfJSBNfj5doS/WeGiR9Dbr1wCygzlm4aPFLxAGth2GwkLWVF7ub
        Cgx2KR1CoLWz0Hagf/m2OACGeQ==
X-Google-Smtp-Source: ALg8bN4O3p/yvd3yDjXKfKiFDtJX5uWEefM/ynAcJwhodRPPywTCZiHzJvlRcmzSv1w842fQSLbt8w==
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr11278981wmt.99.1547477712134;
        Mon, 14 Jan 2019 06:55:12 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id l6sm74443760wrv.70.2019.01.14.06.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 06:55:11 -0800 (PST)
Subject: Re: [PATCH 0/4] slimbus: minor fixes.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org
References: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
 <20190114145311.GA14821@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e5b0551f-e737-642f-621d-e110298e19da@linaro.org>
Date:   Mon, 14 Jan 2019 14:55:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114145311.GA14821@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/01/2019 14:53, Greg KH wrote:
> Should all of these go into 5.0-final?  backported to any older releases
> as well?  Or can we wait until 5.1-rc1?

We can wait until 5.1-rc1

thanks,
srini
> 
> thanks,
