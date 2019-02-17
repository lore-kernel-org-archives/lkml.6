Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB87EC10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0402186A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXlk7uNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfBQVsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 16:48:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33182 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfBQVs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 16:48:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so16259848wrw.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 13:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3Ulo8XvsRN/4EFvyv9ZkpIMBsSSfHRzXFDGXuQ85ggE=;
        b=qXlk7uNubIi9Q4kfdP3tgElcV8gmyy9681yP0bYT9YpsxATtCIXAntiPjVWXdcP375
         7ppLbzsbFsTDjgA5ObybSEL297MBfOzpScfWm4RsDjOS/A/T/c4G0ricNP9CO3KwCzOq
         Ll0gZ+6fv1uAkkljbOECLl9EFCS/5ClC3liT/WnQLhqwj7BFaCp4x59IAQLJsD3majiT
         TTqxF/VhBYs1EyRiriY9TKTGEQ0WoOK00hOdirq79jtwUe0tikvvvXijXsRO4tRCFhcQ
         LQzU35BB53WNCEp0EmNb0fDAQRyx1rJKmYXBfNzyPNffQHkyp/ydGHGrMbGhRNxhvXOY
         d8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Ulo8XvsRN/4EFvyv9ZkpIMBsSSfHRzXFDGXuQ85ggE=;
        b=WCAVZ5+C6/7p8N215bQI/mYpVKxb949YHiMILo7DEButbyftToGGXhTAJUM6htcHbs
         Bq671Poa+X9hhlM78yLYFMETwoN05ctnJmpfFZUYTZL9+wWxqEHBwAdJ21DVl25Jd9do
         osgSoEVhLkaVP65mbYbVRTCKlN9Losh+SUHbaCYK4XykJ16w8QoER4hWZo06c6Fd4j8I
         e10/6ThFBYuqO8oLcK6h7J3QVo5bytep3Y9+wpm+yYvs8YMMBl8UDvPtgY7pHjJ5mQqv
         BzYaU8gTvM/15mGVuAvO6nLJEPkIVqYM7u424n5ioLTeljlFtM67suxqGO2m+7P6hw4a
         DpLw==
X-Gm-Message-State: AHQUAuYeWUP0/e1wsNLg8Zhtu2EVG2DiMnLfGoQ6PYYt7sjxFmM2Hr19
        x5tQ1kFPaWzSjOs1iE08IFEecw==
X-Google-Smtp-Source: AHgI3IZfI4mU0q2wzMbokm1soc542SgMf5MCPfS7OjSQetmIiKmDqUNnvTFj6YZpIW+xfU8nPZ+qhA==
X-Received: by 2002:a5d:4841:: with SMTP id n1mr13055272wrs.85.1550440107843;
        Sun, 17 Feb 2019 13:48:27 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id j15sm7497217wrt.1.2019.02.17.13.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 13:48:27 -0800 (PST)
Subject: Re: [PATCH 3/3] dt-bindings: timer: mediatek: update bindings for
 MT7629 SoC
To:     Ryder Lee <ryder.lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Weijie Gao <weijie.gao@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <56a2c38c9efa41be940858e19501fe07fbd5120e.1550233614.git.ryder.lee@mediatek.com>
 <b145be98c1bfa71d0b9609b80c20c37177f45d6a.1550233614.git.ryder.lee@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <05377892-7434-f74f-c28e-ebada2596b51@linaro.org>
Date:   Sun, 17 Feb 2019 22:48:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b145be98c1bfa71d0b9609b80c20c37177f45d6a.1550233614.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2019 14:50, Ryder Lee wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
> 
> Update the binding for MT7629 SoC, which uses fallback compatible to
> MT6765 SYST, so add more descriptions to distinguish it from the other
> SoCs that use GPT.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Applied for 5.1

Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

