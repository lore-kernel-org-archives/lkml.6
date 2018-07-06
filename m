Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7319FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302D0215EB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IgXO3k8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302D0215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934085AbeGFRvT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:51:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38942 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933801AbeGFRvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:51:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so4951526wre.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ANAaaFRz4+g+wlahib1ZiLBlu5TPyTueNPb2xL+jR5E=;
        b=IgXO3k8vzMWFg0M4gzIdRvAnRUwHdsf/luAT77kma5RFVer++ypQHLCn3SbxNG1c5T
         viaeufx78+VMyGVEe588fHqb/f00DhUoKRECjUpMOXD7+nojQD5pR5NQ4G5gSWcv9/P0
         AfBOkQKFoY4SYiQ8OOMg3MeatgOoA1Uc/Pto4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ANAaaFRz4+g+wlahib1ZiLBlu5TPyTueNPb2xL+jR5E=;
        b=ryETvGe8wikdZVDXuOkQBBu8zawrMJN/8ZpiQtEErwhZq45hZA/uzwE/FC9i59adlp
         zZdwn4VrlnMbG/7GAUYMKNLKWw5rdxQ/zKZCx1djj7hpX0CZ1AOhC5hXoOmgX1v+mHRt
         LbsPReU/z4/Ypo61PDOPxfyosip+sNjxoKcORQTHPk66ZIaIaFJ+KoCO+F11xa1e93o+
         hsiA1B/ulUQ3oxQQwfYBND8BsMZNqkqd6FL5O2HNWxU3E4bK/vI5RST1SHnPQoTml0OY
         vcMJ3WmuqcMyZMLtSwP5qQAJyS4JoThUL+NK4PUnsnAWFJbVzd6vbU5uS4Y+RapzVKth
         kDeg==
X-Gm-Message-State: APt69E2JKVW82DuyuaJkdRJ7vka5AVaRPwJP7nBzQWYHQMV8UaReDu10
        WZxkq1rbtAQBWdx1drc837orlnVoNL8=
X-Google-Smtp-Source: AAOMgpfql+QMvqS0vRv+mu/RNuV6MnmqnvwVEXceDZQLXZn/4Dy9jkTsOfBh8kGCcNEss5oVfqKYWg==
X-Received: by 2002:adf:8acd:: with SMTP id z13-v6mr8060022wrz.22.1530899476733;
        Fri, 06 Jul 2018 10:51:16 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id b6-v6sm8998812wru.66.2018.07.06.10.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 10:51:16 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] ASoC: dt-bindings: Update dt binding name for
 apq8096
To:     Rohit kumar <rohitkr@codeaurora.org>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-5-git-send-email-rohitkr@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <cf28657d-3ca7-f0d6-8614-04d021ce909f@linaro.org>
Date:   Fri, 6 Jul 2018 18:51:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1530870195-13576-5-git-send-email-rohitkr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/07/18 10:43, Rohit kumar wrote:
> Remove qcom prefix from machine driver dt bindings of
> apq8096 SoC.
Yes, this is a good move to make everything inline!

> 
> Signed-off-by: Rohit kumar<rohitkr@codeaurora.org>
> ---
>   Documentation/devicetree/bindings/sound/qcom,apq8096.txt | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
