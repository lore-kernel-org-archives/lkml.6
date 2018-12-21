Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A052C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A6D218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Chxjaf7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbeLUHmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:42:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37049 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730712AbeLUHmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:42:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so4167822wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 23:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=V6/xVn1rH9uow9smIFQ9843dnftOHQUVwhBIp6DVG0g=;
        b=Chxjaf7GcVMs+S/thtBYNCJ6kU3BqCZ+/tz1+Vl2D4eMstnUPtXL1RJ1uxHKrK/mfF
         QjhlS1ixWuDXoERwblwAmvc5M0J4cIKAAyvpBY5zEs0HMc5OL+dU8DC5b+Fe5yfsdK0M
         cufeVuXsD8Jy+nmVCn/SVkwFa6T549VXImvlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=V6/xVn1rH9uow9smIFQ9843dnftOHQUVwhBIp6DVG0g=;
        b=QFfiC6kZR0zmVc+XdWpQ7DVGh6cuyFXQfDQddjX5DOT+mchylFCjBVhIF6akjvrbOd
         5e8SeifF+eEOuTRKnkNwJFIDWZlY5dcRUTL9ETHs5I5/ZV5FqG4XXPjbYDeiQ9ewLjqL
         VZl09b6gxjQaDt6ArSJ+X7Mi54NmF/GXrmjJIVaLvm5TgKbT1qbEXjy0pN+fbtMEDYef
         E20Tl2LuJ2SkgEFuoKlaO6IqL89HxfR5g34vE9odBUS0pcEHIERQGG3t79bTRtVyx9NB
         XS8ydAY0pgxMIM2zj0ukVWgmZA3E/U/uRZxyqHFdLZnGbgVPoi7FeNt8053wKXYF50ml
         UN0Q==
X-Gm-Message-State: AJcUukcaN5X4NSAi3tILif2ld2728ZKeAnVuVVPzS+01Inv37t/GE8lS
        bFdyu/PZNdDipqCZh+l7ZnjV4Q==
X-Google-Smtp-Source: ALg8bN6QBXQcULbfbkisoOrAbIFLDq02368RTxxG+pqSlbUz40YR5IzmRxadmacLfL10uJRrahd1gw==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr417981wrr.155.1545378125924;
        Thu, 20 Dec 2018 23:42:05 -0800 (PST)
Received: from [192.168.1.2] (119.red-79-146-81.dynamicip.rima-tde.net. [79.146.81.119])
        by smtp.gmail.com with ESMTPSA id v1sm11670753wrw.90.2018.12.20.23.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 23:42:05 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY
 bindings
To:     Rob Herring <robh@kernel.org>
Cc:     gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawn.guo@linaro.org,
        vkoul@kernel.org
References: <1544176558-7946-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1544176558-7946-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20181220095245.GA7783@igloo> <20181220170727.GB19862@bogus>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <f75d9c76-23c3-ed2d-9e5a-9706a0b45eb1@linaro.org>
Date:   Fri, 21 Dec 2018 08:42:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220170727.GB19862@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 18:07, Rob Herring wrote:
> On Thu, Dec 20, 2018 at 10:52:45AM +0100, Jorge Ramirez-Ortiz wrote:
>> On 07/12/18 10:55:57, Jorge Ramirez-Ortiz wrote:
>>> Binding description for Qualcomm's Synopsys 1.0.0 super-speed PHY
>>> controller embedded in QCS404.
>>>
>>> Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
>>> definitions.
>>>
>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>>> Reviewed-by: Vinod Koul <vkoul@kernel.org>
>> any follow up on this patchset?
> Check DT patchwork[1] if you want to know where you are in the queue.
> Just so happened to get to it now.

thanks for the info Rob. I honestly didnt know it operated in order! my 
fault

>
> Rob
>
> [1] https://patchwork.ozlabs.org/project/devicetree-bindings/list/
>

