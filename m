Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82289C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 20:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B2420652
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 20:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NlZ50w6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B2420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbeJNEgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 00:36:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34134 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725734AbeJNEgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 00:36:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id l6-v6so16524664wrt.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 13:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DbVHarEArFZXREHui9m0MzS3JA4N9rB4MTcycF4Zjys=;
        b=NlZ50w6wogLE9dfqA5or/7qS3u0ZrIf5rEKwDRYcT6pyMKP52ih+7Aj7n5j8HqiDhn
         DWUK7iNRTRygGwV78c4QNkzeCg4o6EebwgDC4pB3kdxWGhV/f0R/a1RniD19SZa/BCtf
         pJZbERsAPTHGi6Ottx99PV/Wyt7UU1/Q8Abow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DbVHarEArFZXREHui9m0MzS3JA4N9rB4MTcycF4Zjys=;
        b=U2PW7U32Z7tJwF5FhOtBaUxXKyStDXU67prHWwb/eO5K76l7X54yb+EN26cjTyiFH4
         OfUvD5ANTNdmYxaKwGIPojVc4dqaa91gQGRdRimIMvq2mHPNvj8XUh0arT8wNQsC1Ol6
         irkxk/jlJwS875YEx1gNebqudxgbZScKsSXVP5Zo04mG7Zcn0h5yPmIvFGxEtkHt+trJ
         oJqCwH+pq9Qb2wTzNJgAJ/DPV74IfeQPFxje4o13871T9hS4ICiRv+CKblYVpTX8o+AO
         CFcxwk/A9L+ACHnaJQ0aCzs8I1Fy23mKxzfAJP+qbIhLt1MwiVtsEXfz/R+lNRDKJkGx
         F5LA==
X-Gm-Message-State: ABuFfoi9uOA6YJtUb/n7nAKj+dtPkUMgUHE7OT/2b3gLd+Fjn/H8YLIv
        08z/wOxeqkju8WjCEurKsvwJIA==
X-Google-Smtp-Source: ACcGV61kR/bvrLFZH7Wx9yHND/EZOURGseR0m6hLaKOuMhWjuUGYMNUgEzy+ISbZe9sYey4Xfdp/JQ==
X-Received: by 2002:a5d:5342:: with SMTP id t2-v6mr9114199wrv.257.1539464283863;
        Sat, 13 Oct 2018 13:58:03 -0700 (PDT)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id a1-v6sm4323334wrt.79.2018.10.13.13.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Oct 2018 13:58:03 -0700 (PDT)
Subject: Re: [PATCH] clocksource/timer-vt8500: remove duplicate function name
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Tony Prisk <linux@prisktech.co.nz>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20181013102222.GC16086@mwanda>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <47975e13-3952-946c-fbfa-c667210b3007@linaro.org>
Date:   Sat, 13 Oct 2018 22:58:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181013102222.GC16086@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2018 12:22, Dan Carpenter wrote:
> We print the function name twice in a row in the error message so I've
> removed one.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 

Applied, thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

