Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D8BECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7EB2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tQ8octNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7EB2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbeIRF3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:29:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39529 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeIRF3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:29:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so91268wrw.6;
        Mon, 17 Sep 2018 16:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mEKJcR9xaaRTbEwjpDmjATVR1LkW/BG0dgesARZOUk4=;
        b=tQ8octNfLsWrrGRT2965fB3fk3rcIogvYqVwyK9bNxKdRMiKnnSVCmRJcd3PGmXC9q
         hN7ZJcPeNxfV/ZNhZv7naa7aboeZfcG0lupZoWH6xsHZIOxlb0Av5pcH/T0XeYb3tIFB
         wAi9+MhhIFpBJf0V+1U/HA6eYnh+2/iXWScSgI4pt/YHFn/dKJa8bZ3ZYmxWc6NhHlpT
         IATpZSTrmTDoOxvEwvGCpxFeOs8UVMqAFz+K3rX/rOwRkPGmbg3cspR6p4GKHV9brj9b
         3YOic85Xczono+EQqiitQTTu1ADTPO+8IuVYcK/YDtdAVBGJGw+Y/HiZnm0M80BcnbAP
         uMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mEKJcR9xaaRTbEwjpDmjATVR1LkW/BG0dgesARZOUk4=;
        b=RG+lXr1XWprklcnjVbhkqg1x3TzK6rcCudQXuStddHiLNbn+9LsVaygQcwgRIDY32c
         mU4sb/Ej8wPOqCrOGri6xkd8/Esqa+4fO2C1x+BoOTCoj+hcQP/PDMFYZc8z9wU8H2bU
         seRueCc8KE1HZwicT5SGzIQbGh0+hVF0q1YHHb2L+v2SmnZM8aLrFGTgLazWaBcIb0ls
         4FREVAGqExSxGawaM0nQLQypFGQvRcObMqcTZU61xy5WsjojQrixg7rZ9wQjqnTVo3wq
         vuOfyNXTKPYRx7+jrU1d55AcXKFtpKs0LZwwx6fq9hHAY/iqiyKtXTfnr4XUXMLWWa8Y
         NsgA==
X-Gm-Message-State: APzg51B9li03gCwsAEfUCM7mM+wL4fPf0hcGEq88hLk78+d81je2Do6I
        +FUy7AiEhD9JmxsP84vYxHM=
X-Google-Smtp-Source: ANB0VdYHR4O7OI5vZNVtWf7itOI25nm4QzDmDJoZWaLdx5NEeTRKbbpNzpTUJxDixDfhNjIRJ2C+cg==
X-Received: by 2002:adf:8919:: with SMTP id s25-v6mr21226157wrs.89.1537228767169;
        Mon, 17 Sep 2018 16:59:27 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 1-v6sm569194wmf.47.2018.09.17.16.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 16:59:26 -0700 (PDT)
Date:   Mon, 17 Sep 2018 16:59:24 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/70] 4.9.128-stable review
Message-ID: <20180917235924.GB5879@flashbox>
References: <20180917211649.099135838@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 12:41:33AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.128 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep 19 21:16:09 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.128-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my OnePlus 6.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
