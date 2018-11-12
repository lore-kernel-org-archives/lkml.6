Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F85C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87C02245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1DOncDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87C02245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbeKLXCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:02:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36690 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbeKLXCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:02:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id v70-v6so7654937wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 05:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fSU3bunvUbySDCcB/aKSXgrIf7ZK/I+/ewCLs05ilVE=;
        b=M1DOncDwyNPHjvmnRC5tLVarIjgNDiRsqIa9O7GO5Kud6bAQkGu3AVDft1nFC/GESq
         3VyYwpmpwyJhGXZqRvghJAcWYMAZtRdV+x1cLdzwwmQUwtRn/mxFF9wGmswf4E9ONpwW
         /1+A1WrdPU/vdbStdQfiuWKb53KOVZiKtizJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fSU3bunvUbySDCcB/aKSXgrIf7ZK/I+/ewCLs05ilVE=;
        b=mGHHdxj9eAFY8mUr598Yu04h6FDfvfwQNmOCbUWbtHDZ1ekmfdJMIyA8wIsELizKKl
         7f+wOzhpfxEuLPaKKfnHI5HaxKV6a1yGWE78d+oy8xBZCpr+i4tRXX6PinoMVxeRVISx
         ZHV5f3WKzZtAzOqH48rxYfbMdGKUpgHWHIA122dYjbgt2NVWc8jt0ja2toqVTeOgnzAm
         /M6cEcAb2fd6FHHbGJTkrPJTlLFyTReU1IysOc3bjFyU+AL3P4+IttSZcBfeEBD9YEMH
         zEWrcM1EVe+TN7C8nNKsgPEBxbynkpsb+/fod0oIT3mTb8SY/cFttZt6CxIeTLkhzH+i
         mhIw==
X-Gm-Message-State: AGRZ1gI7mK8U8SVU5DEKMMTcbn4qePeFSMnMnEgqZP4o2fnfmALRmN+y
        XYH2LRLS41FlkcjkSSKAOUNO7d++4SU=
X-Google-Smtp-Source: AJdET5d3+WEkE/Xi6uqvh0up0YDNDKo/1IAdwrTHBqqKLU29YVCZ0Gr0DwAzkR99Z/+se4+gZBT0hQ==
X-Received: by 2002:a1c:1383:: with SMTP id 125-v6mr7917059wmt.71.1542028139335;
        Mon, 12 Nov 2018 05:08:59 -0800 (PST)
Received: from [192.168.0.12] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id 11-v6sm16737054wmk.26.2018.11.12.05.08.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 05:08:58 -0800 (PST)
Subject: Re: [PATCH 1/4] nvmem: meson-efuse: add error message on user_max
 failure.
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181030102231.4851-1-jbrunet@baylibre.com>
 <20181030102231.4851-2-jbrunet@baylibre.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <419f8f2b-0677-a647-6f01-a1596f2a80cc@linaro.org>
Date:   Mon, 12 Nov 2018 13:08:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181030102231.4851-2-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/10/18 10:22, Jerome Brunet wrote:
> Add an explicit error message when SM_EFUSE_USER_MAX command fails
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   drivers/nvmem/meson-efuse.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Applied to nvmem for-next branch!

thanks,
srini
