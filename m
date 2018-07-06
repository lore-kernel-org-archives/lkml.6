Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E468C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA823218CC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="awQoMZ+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA823218CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934145AbeGFRvZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:51:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41476 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934089AbeGFRvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:51:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so4961035wrq.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=U7qF2scalQFfKpNBQ3FazB5jnOW/gnM7hikc1LAoUx8=;
        b=awQoMZ+1rZVKy2OKVyNundwzZSgoLFCD9WDpRNCJ9ZCTjmn2JTsuPOXlYPXX3zRdjR
         /b2NmeLKS4UyJXnMhhkdY0qhLZwT286/V6OhY4BGd9/p6GiGYREgd1Pjmm9A94wsL9gc
         PLEQ51LX+GCoXv7NoF3sxGH+y8Or7WWA98Eq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U7qF2scalQFfKpNBQ3FazB5jnOW/gnM7hikc1LAoUx8=;
        b=rpYdyVtqByRZDp79JPsl3WlUvRAitYG3+J/iH9najMFk9ZHhTEPF/LogkRhWi3B+ab
         CZZ1l4y3rTbCAAW5+4Lb7kK0AIh4FBGC3XFqk4PAcrNaawZrwxujm6ZBmrHbklL0VPtk
         dZqu7PH9eBJVWBbhhjXs7gnWO/xl3u8UklRCv7rhYt6CtFa7HJmuqm9JDrAIV64QBoPn
         jkc6kKXUWnkzXMD5Qk/rbIy3Hy/vpgV+AjPeZV470yzIiHRuQsyVDgwHgP2BUfRhCw7D
         /fVJCtlnxL7KNRvytY0KHz+dXqWFnu9C6tDYKS08xIvN/Q+hN38yAJeM7HR7kHItuY1w
         GSog==
X-Gm-Message-State: APt69E3HWsuI5G1gkG7r7bjCCXazvAIvZlcq8KPsIMDV2A/N/eDoI4pz
        eU4vgqdgBuYAHRHcnSIJPzlv4VtCNfo=
X-Google-Smtp-Source: AAOMgpdiJ4+ge6re8HHA+Llhgc8OD/A9ws83k/ubZLeljKz2r2tn11ALw1/jpqJQ5w69TKVIWbBjiA==
X-Received: by 2002:adf:e9c1:: with SMTP id l1-v6mr7741079wrn.14.1530899481688;
        Fri, 06 Jul 2018 10:51:21 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id 5-v6sm18759699wmv.48.2018.07.06.10.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 10:51:21 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] ASoC: qcom: Add support to parse common audio
 device nodes
To:     Rohit kumar <rohitkr@codeaurora.org>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-3-git-send-email-rohitkr@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <84b6f1f7-b9c1-fd0c-b684-1e07d35663ba@linaro.org>
Date:   Fri, 6 Jul 2018 18:51:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1530870195-13576-3-git-send-email-rohitkr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/07/18 10:43, Rohit kumar wrote:
> This adds support to parse cpu, platform and codec
> device nodes and add them in dai-links. Also, add
> API to add slave components associated with machine
> driver.
> 
> Signed-off-by: Rohit kumar<rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig  |   3 +
>   sound/soc/qcom/Makefile |   1 +
>   sound/soc/qcom/common.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/common.h |  14 +++++
>   4 files changed, 168 insertions(+)
>   create mode 100644 sound/soc/qcom/common.c

common.c seems to miss

MODULE_LICENSE("GPL v2");

this will be an issue for snd card module auto-loading!

Also patch 5/5 can go with this.

Other than that it looks good.

Once these 2 fixed you can add my Ack

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini

>   create mode 100644 sound/soc/qcom/common.h
