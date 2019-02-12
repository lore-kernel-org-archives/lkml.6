Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2015C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FDA214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqGMfKq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfBLOdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:33:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40128 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfBLOdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:33:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id q21so3241060wmc.5;
        Tue, 12 Feb 2019 06:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Avxomx1Az8M5EHN2sdyj06xmtx0wYvL0zluK5+/IMaI=;
        b=hqGMfKq1hZTg0gjddW4ba6k1iH9UAj09LJzc3tm6CRMYGh3jgEw3GCZUp6f2ZYmfiC
         IpoDhRCS6F0mlnAOdA6FGfKw6bDiPbhRxUNpQzp1yOjZUv2UqAVqbyuxyUsvr4JVi+PZ
         5VN0fbIzmBa4O41Dn+j/0zMAdVU07SQ6CQJherWx60U1QGVwDMCUPRQ7Xe7ivAXn0Zb5
         gDpgOa7Opzo2T1l/ZdsIXN7KBiVa6KDPP+qcrOaf1JOIBQ3mlN+GnLjabUSlCLvBgsGQ
         XbcXpTKk+2suL4rSi6ca/8zi8cfzNzYScF4PCH0521lFFPmCrKcjF/g2sHQdY4CNfa1K
         b6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Avxomx1Az8M5EHN2sdyj06xmtx0wYvL0zluK5+/IMaI=;
        b=At4s+hvL6tfJ64n8IXKHUuJ4vfcaKcU/TpPTGO/RqPsti9nrVcTGvEbvrfsICgeLis
         icGzrxwoimOMMDymuf4JKAqMBcj2cmMKRPsynwyZgGaiR6ARLLnrDWzG1jpen309aRgx
         jEO+KTLicDsyjJQ1YiZpD3Z9NzPTvkN0FbrMeQEyJ57BQPfr2U+DzfhyR5L0ogpne3eV
         fNXAivjdJfKfgGR084AUl+Tz1BZCjNapamAGXDt94B1UwN8FQ9d1eTiyyLo+ZwHnhV9x
         YcaTPlDVogZELQZkfg3riYgdOB3XuIBQ2j18huNe5t4b/q+PJXZHhNgIncSd8wg+G+XV
         Yw4Q==
X-Gm-Message-State: AHQUAubetgcJmN516RwPCnoXFdNGr0ZtzhuAdnnfKYaxBAMmzXBCWltf
        UvHMxFLKngmiALE7X/3QvWI=
X-Google-Smtp-Source: AHgI3IZx227cBTMcXkzNAA4Su+BjGjBWJ7tre6DYGxtyvKQa/Yv6G4D1JujTnFhchiot6tXkgOSSGQ==
X-Received: by 2002:a1c:cf82:: with SMTP id f124mr3229119wmg.95.1549981993880;
        Tue, 12 Feb 2019 06:33:13 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id 90sm22098998wrk.95.2019.02.12.06.33.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 06:33:13 -0800 (PST)
Subject: Re: Applied "spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver" to the spi tree
To:     Mark Brown <broonie@kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <20190212142236.2807D1128113@debutante.sirena.org.uk>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <4f91497a-96ee-4c10-436f-4d011edb3834@gmail.com>
Date:   Tue, 12 Feb 2019 15:33:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212142236.2807D1128113@debutante.sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 3:22 PM, Mark Brown wrote:
> The patch
> 
>    spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
> 
> has been applied to the spi tree at
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.  
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.

How did that happen when there were still comments and open topics ?

-- 
Best regards,
Marek Vasut
