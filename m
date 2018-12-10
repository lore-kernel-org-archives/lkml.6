Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769B7C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BCD2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6Lw3Nve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BCD2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeLJMUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:20:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36163 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbeLJMUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:20:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id a18so11057395wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 04:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dFpbuq0ulV8OVvLVss/W51LDqN9dtTy0/RMmjeONnFg=;
        b=U6Lw3Nve638F4eL/Fjpf3rErRNpwi+jrV4PJyiUIk1L26zK3TZC02jHYt7EajMjdud
         7BIx+B1BRr2lErZqL32qcrKOWtaudoog1M64bdkQ7ikmGlhA/fqIJ9XwoFEdc5tKKSJJ
         gLVERcWuNVTsJbPHt90lYgv7RAR3M1PQHzv/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dFpbuq0ulV8OVvLVss/W51LDqN9dtTy0/RMmjeONnFg=;
        b=WDLfHVjz4Yj//kbv4yuKbs/aEdo8Bzl1f8K1dyPCi93UGTcK2wpq49x4Q4N7+53fCX
         PkhUVLjK6KpZuRzrro+oE/MD4sRs0PHqmK7bLPU9Z3p0V0AEQqeDp4hFjH1jKQ8VvSkw
         JKlHQpTnBvqCskQlwQTKOjtlYVAF/lT6UBsAQTUmbSeWgULMzr8rsKI1nKhtQjg3vghE
         a06huYyNTlfScWbT0rVkHsm8KTWOHZr0gFA2mWYznIZ5FtauAi3Xv2CVgpK18g174Dcj
         g4bavmXEC/3NDjEX0cFHTeBtu+L2pf89Em8h66gM+JuiOs4IZypb+YSz2shDXZ+/e0Qh
         346Q==
X-Gm-Message-State: AA+aEWYT8xeFOdtYRLUXKDaG6LysT2gj4EsSIq+rHWaJr9BtYl9JWtPU
        lB/YZViyqpcMNdwXS3RQ2938GQ==
X-Google-Smtp-Source: AFSGD/WmZvpe/89UmFKCkavxAA1K3KbmB66oX27OJgmSA2VOy/7wbhkQ+xNiaHJWk+KsOPWfHswR9Q==
X-Received: by 2002:a7b:c04e:: with SMTP id u14mr9498661wmc.133.1544444450156;
        Mon, 10 Dec 2018 04:20:50 -0800 (PST)
Received: from [192.168.27.209] (mx2.mm-sol.com. [217.18.243.227])
        by smtp.googlemail.com with ESMTPSA id k128sm17022687wmd.37.2018.12.10.04.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 04:20:49 -0800 (PST)
Subject: Re: [GIT PULL] Qualcomm Driver updates for 4.21 - Part 2
To:     Andy Gross <andy.gross@linaro.org>, arm@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Olof Johansson <olof@lixom.net>
References: <1544245994-4228-1-git-send-email-andy.gross@linaro.org>
 <1544245994-4228-2-git-send-email-andy.gross@linaro.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <c575fb97-4b19-5143-66f8-3a4874aa7c17@linaro.org>
Date:   Mon, 10 Dec 2018 14:20:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544245994-4228-2-git-send-email-andy.gross@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 12/8/18 7:13 AM, Andy Gross wrote:
> The following changes since commit b601f73130a375c912d9f2ec93c5f3cea5d6a3da:
> 
>   drm: msm: Check cmd_db_read_aux_data() for failure (2018-11-29 17:41:53 -0600)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.21-2
> 
> for you to fetch changes up to 92def04bd7b46f5b186f985d5c9d3804858c3c2f:
> 
>   MAINTAINERS: Change Todor Tomov's email address (2018-12-05 16:45:34 -0600)
> 
> ----------------------------------------------------------------
> Qualcomm ARM Based Driver Updates for v4.21 Part 2
> 
> * Fix MAINTAINERS email address for Todor
> * Fix SCM compilation error
> 
> ----------------------------------------------------------------
> Jonathan Marek (1):
>       firmware: qcom: scm: fix compilation error when disabled
> 
> Todor Tomov (1):
>       MAINTAINERS: Change Todor Tomov's email address

I saw this patch is applied also in media_tree.git, not sure that is
problem though.

-- 
regards,
Stan
