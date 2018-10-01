Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E24C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CA520C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7I0b0ag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CA520C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbeJAVY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:24:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46433 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbeJAVY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:24:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id z3-v6so14259488wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 07:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eoxhb/u1ABkEeGKBgjU+SEA4eNmMNvGNZZ5vElaWUW0=;
        b=V7I0b0agd77L2eEXiqK3PbgiB2qTil8ZHQ1GyJffTyH5mE5EgRxq4d0Gra6Ra2Gobv
         XKgI529TIFVl0gO25Cef2eGRw/thDh2DrajTa5TYp+8cXgcB91XZewTbUV7Gq7CgKkEW
         dCxPkvaiizOcGkU8ynwf4EL5+/QPAIamAH86Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eoxhb/u1ABkEeGKBgjU+SEA4eNmMNvGNZZ5vElaWUW0=;
        b=CsjbSlXOi7wu3ut3p7c8TyJXVZDJOe8mZX3d/Z7aMEycYXzGF/q7e1JxrQ/N3cWrcv
         6Ss0gl2gjaMbHIKjKRX0B6N2awdrpbIWO9OnTwHeSpxp0wmhSsqqHcyvmCTnnGooU+pH
         NuP0iKavwxPJFBk8maowUpa9TYR7dZMVQbg2kXgRkbduvM/k9ZK9aesc9yMnWpJPGokg
         BonBlKU4s+lH8MJb3gYKdJw9kl/2B02Godx2uQgVVPXveaRGdDqrwAJB0lTILfC527Un
         Mr12DRbTAfHZGaln0zYzK1tz/22BkYLhuOGo/z3zylWQ7xjH9D3Z4mHEj3Nk/h0WX+1b
         qB3A==
X-Gm-Message-State: ABuFfoiXTuyCXBh+69E71my//7XnaK3K2dAVJOOt9QR8blJ25cXfwXVO
        L6OXHoux4fuNYaWAt7HqJ78JHdmb0hQ=
X-Google-Smtp-Source: ACcGV63JNOKbfSAXsykGWEMZ6jaD2IgJkzaB0s5WwTjVuNb2yyGVDXqt3FS3PUcJLUhPy/GLBdUEIQ==
X-Received: by 2002:adf:f00d:: with SMTP id j13-v6mr6488706wro.88.1538405204954;
        Mon, 01 Oct 2018 07:46:44 -0700 (PDT)
Received: from [192.168.0.41] (3.230.136.77.rev.sfr.net. [77.136.230.3])
        by smtp.googlemail.com with ESMTPSA id z69-v6sm10609877wmz.18.2018.10.01.07.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 07:46:44 -0700 (PDT)
Subject: Re: [PATCH] cpuidle: menu: Replace data->predicted_us with local
 variable
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <2889908.NE4FqvqlhV@aspire.rjw.lan>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0b2fb127-b48e-e047-b5e3-4eb6107ec361@linaro.org>
Date:   Mon, 1 Oct 2018 16:46:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2889908.NE4FqvqlhV@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2018 11:56, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The predicted_us field in struct menu_device is only accessed in
> menu_select(), so replace it with a local variable in that function.
> 
> With that, stop using expected_interval instead of predicted_us to
> store the new predicted idle duration value if it is set to the
> selected state's target residency which is quite confusing.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

