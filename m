Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC25C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696E32229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z6HXJpwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391406AbfBNJO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:14:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51585 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfBNJO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:14:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so5459523wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 01:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IuDRH2Zrek2kUj5JwkJNJicQtZLeUEiGi9otZB0cur4=;
        b=Z6HXJpwmyX2YnhuZNopWJqoU1wyBXNdCvXZFBOiCMJdHL+gYco2vWE3dbJ84lFEMEH
         aZprU3WMQ7hLXZcvIP5Nw4mU7Xtj3VSnT32qqAXXndLJc3TOoa5ya9x55PB8rgvtNFeC
         sk2t4PlA71ibaCUvZRtMULZkxbmik+KiRuk0xntiJUsOUqOhVrWJ4wbzA22dTN7jC4TB
         5C6C7XYxCY/uJlMti+UljrkozRew+5X4A7KBL9hrR4k3k3Gmzi8LNt/iFoiFyTbUm0Tu
         HZxelvg93YUaeaVHiWQxtI3AedpUIXoOcYPDyUHlNpgrRW88Dnr6fEcagP4e7TBO0DCn
         7UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IuDRH2Zrek2kUj5JwkJNJicQtZLeUEiGi9otZB0cur4=;
        b=aapPnPcHHbBx27Q/6/wara3TxijQRC8ZpPk8Lst5ZmmRlOtLrhjvO6VD/J7I3ZJGkP
         TUrVrBNLKkz5yjAsyupY0AlY1bx6P2XNkDsl/ABUt51y2fvkANGPLOX0H4HMsmzam32f
         ci1GAXEDqiW+HoBSO+/wS7tWhhstNoXQ4lfVNGzTD05a354tOdbiT+rq9YXC/0C+DvqV
         4V7vVkgqFa2z1yQyt6UH8yInxHXfhUQF5HBIG1W89i8rWdZieA5uGUfEjkfqwRrV3ilr
         t0JzXODK0QhwVIJJ1ouzA7bziq5qZ4kUkKTbfB/MY3BjzvckL6qLXCSSaXdvIdBUcpqC
         Phtw==
X-Gm-Message-State: AHQUAuaYkl0WJIf3i5OBAjpLmUfLyw38lT2eIgPE3ij+5RxTBxqe5O7L
        qf02cpo3KTnV+regeQXBWwXZ0Q==
X-Google-Smtp-Source: AHgI3IYq8ebzJ2bwYZtrZx2IxIxNkx1RZMYPziNXdLx2CVdrcbx7+HluKeQToxolBJ6HPnwOsE4Ikg==
X-Received: by 2002:a05:600c:2255:: with SMTP id a21mr1919040wmm.31.1550135694869;
        Thu, 14 Feb 2019 01:14:54 -0800 (PST)
Received: from dell ([2a01:4c8:c:28c9:4c60:37da:d7a:230])
        by smtp.gmail.com with ESMTPSA id k20sm3526932wre.41.2019.02.14.01.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 01:14:54 -0800 (PST)
Date:   Thu, 14 Feb 2019 09:14:51 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2] mfd: sec-core: Cleanup formatting to a consistent
 style
Message-ID: <20190214091451.GB13737@dell>
References: <1549891223-14269-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1549891223-14269-1-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019, Krzysztof Kozlowski wrote:

> Cleanup the formatting to have consistent style across the file (only
> white-space issues).  No expected difference in code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Leave one-liners as is.
> ---
>  drivers/mfd/sec-core.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
