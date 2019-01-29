Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3990AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099372087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="asqtoNsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfA2Q6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:58:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33685 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfA2Q6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:58:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so13426337wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 08:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4g0QKmDsRFRscDMvzm+JploBlAovB0C3tea7QT0vqkk=;
        b=asqtoNsxo9PsGe3F6oiYa0pwAin7/AzCbr10NaEXA8HS+MvE9MU2TdqljmdoPTQ0kU
         jQKYfbMMYGOPTzZVyblRuOOUOvkZ+EFE2TbiZww2ducQVqfUbpKnC6qGKz/Qk4fHCxUl
         Rw9LBA2EFcR2rWNsqtmbCJRZYFkpGJ7XUi/WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4g0QKmDsRFRscDMvzm+JploBlAovB0C3tea7QT0vqkk=;
        b=r04nBGn6CUUCmZbo6GtYtthhf5TQxUxbWgpGfQE/PD4+KMvVwuS63Fl8gcd1ALrqgs
         0WKAPuPGV0RV+NirJIvY4GzvBRF4FqLl3AgE8SjGilte48a5/P0DNVx2QlfDmdakoda5
         sN9Ygj2j2jhewGFD8FI7ISuybbMJSqyn/OSRXRm4H4zMnDOcMHDPYyFdCfsZZqUfE4+1
         /vpvmRuXdgLy9m7yNIKNuCHO4uDMrvQor5pKTcpFy/VCpqLX8wWGHjepByxas7QOCLD3
         yTSGVc/yxmw+jYCG1gB1DoPNvdGuLLTZnh1WusBw7aTplkla1wahMdeFrbDzisZ6Z6E3
         qIaQ==
X-Gm-Message-State: AJcUukc/v9Ft309Hdda+a4YzmFR62lfT9DTFY0yMcy5VtUbZYwEHcPl7
        Fx1VojCe8XskIECPI0LwU35MxA==
X-Google-Smtp-Source: ALg8bN7McmaQTw6/z35pJ/y1ufDu7p4hgOA1Ox40moFhMzrG/l6ENmONFoUnbX9qJnM2uW9n0JKlSg==
X-Received: by 2002:a1c:cc2:: with SMTP id 185mr22755542wmm.1.1548781078192;
        Tue, 29 Jan 2019 08:57:58 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id 127sm5544506wmm.45.2019.01.29.08.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 08:57:57 -0800 (PST)
Subject: Re: linux-next: Tree for Jan 29 (SLIMbus & SND_SOC_WCD9335)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>
References: <20190129171143.3945af24@canb.auug.org.au>
 <2eaba760-96d5-5e0b-c1e6-c45fb24d89f2@infradead.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a849e598-da5b-bfc2-cd41-dab94fa79c87@linaro.org>
Date:   Tue, 29 Jan 2019 16:57:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2eaba760-96d5-5e0b-c1e6-c45fb24d89f2@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-5.1&id=a8233b6c1972e1959cf84a021aeb61ddcd23cc26

This should fix the issue! It should be in next today!

Thanks,
srini


On 29/01/2019 16:50, Randy Dunlap wrote:
> On 1/28/19 10:11 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20190125:
>>
> 
> on x86_64:
> 
> CONFIG_SND_SOC_WCD9335=m
> which selects REGMAP_SLIMBUS, but SLIMBUS is not set/enabled.
> 
> 
> ERROR: "slim_driver_unregister" [sound/soc/codecs/snd-soc-wcd9335.ko] undefined!
> ERROR: "__slim_driver_register" [sound/soc/codecs/snd-soc-wcd9335.ko] undefined!
> ERROR: "slim_read" [drivers/base/regmap/regmap-slimbus.ko] undefined!
> ERROR: "slim_write" [drivers/base/regmap/regmap-slimbus.ko] undefined!
> 
> 
> Full randconfig file is attached.
> 
