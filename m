Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EA5C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F2C20818
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KV/4yrAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfAaKxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:53:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52672 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfAaKxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:53:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so1983204wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K/XJt+FgoZelF5h0y9SPcpkQhs62ZwwyZVe9oTkHuxQ=;
        b=KV/4yrANtCYdHeMfDNxvkyslBjCz1lkZqxDZ7J1DngT1QFnYiMdWWCAbAH4ZP33Npk
         X7eNtL3kf9/suDdu6nKYvQKWo3vFwHKuhbXwCxZI1mCCWcLcb5oMIET9uJoAJPPTUuA1
         WjFteUQDDH3kmbv5grMM6JSi42P5wEJmgK2Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K/XJt+FgoZelF5h0y9SPcpkQhs62ZwwyZVe9oTkHuxQ=;
        b=ZeL8qZuPWxF4oHXonwgwwBvK9+VJehsxhqbALkiiOlF4QJ8eQsHe8gcb6/0nDzbyOW
         8U7dNvVLmc3NLtV+OSyxYbt46dzL89x+PY0u8ZhpQcDfSRePjpW6nJppKK5xHOa4L+oc
         ml+zSWcR+gcCQRq1GesmhB2k9hE63E2cQEL+RKQEW9flHSfzlZeBSGiPr58d6UW+zUbi
         GLgmwEHvQw/qYWKKyFsrob6VgpCy7MbcGNo+ttocksiN+VTPpcvF81D2axvoG5kDisMn
         IUxK0fZBIWti9Qo7kl8SoBaQi3lfDkZpAYgtip12yNZiVnEV3VkwUmYYQJC0tgBTxkNi
         CrBA==
X-Gm-Message-State: AJcUukdUjLaHz/OTifNgZJLbBIxg83HQR/U6zbQ8JC1eLu7x9ri/K3UP
        2VHUcvm9n7clkBhGHk3XpCvIEnUrO4U=
X-Google-Smtp-Source: ALg8bN76tjybM8o8Og178F12kcpPdV4I0an17QKL8TZgZfl6I0+qIsRFA4YzljcSYoEhJIuQPNc25Q==
X-Received: by 2002:a1c:2408:: with SMTP id k8mr28254200wmk.110.1548932027349;
        Thu, 31 Jan 2019 02:53:47 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id r9sm9119897wmb.27.2019.01.31.02.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 02:53:46 -0800 (PST)
Subject: Re: [PATCH] wcd9335: Remove unnecessary null checks in
 wcd9335_set_channel_map
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190129214847.6341-1-natechancellor@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <eac1b134-8d9e-21d4-d749-b40b98348eff@linaro.org>
Date:   Thu, 31 Jan 2019 10:53:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129214847.6341-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch!

On 29/01/2019 21:48, Nathan Chancellor wrote:
> Clang warns:
> 
> sound/soc/codecs/wcd9335.c:2004:11: warning: address of array
> 'wcd->rx_chs' will always evaluate to 'true' [-Wpointer-bool-conversion]
>          if (wcd->rx_chs) {
>          ~~  ~~~~~^~~~~~
> sound/soc/codecs/wcd9335.c:2012:11: warning: address of array
> 'wcd->tx_chs' will always evaluate to 'true' [-Wpointer-bool-conversion]
>          if (wcd->tx_chs) {
>          ~~  ~~~~~^~~~~~
> 2 warnings generated.
> 
> Fixes: 20aedafdf492 ("ASoC: wcd9335: add support to wcd9335 codec")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
