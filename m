Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E0BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9608920779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6dkKRN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9608920779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbeGWIsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:48:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35576 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387964AbeGWIsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:48:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so16883485wrt.2;
        Mon, 23 Jul 2018 00:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KJNVR9w2lPahYh39mXM1RqJL2WmBQoQ/lrKXrATSte0=;
        b=B6dkKRN8yhWEY4d3spWIEUG7Z8L7BqrtIyHNga4SukYZWOgQxXrmNbvi/xZQLDtdPA
         59COfHywlH3gEuoHBcG3o8uFp/m99bJPFd+5+XELK4RPJiDlT8gjM6QWgVNsWRYb8DTX
         sglf+lB0pCZKwCLUuiihFtPuCleYkKmHhd1bMDO6LhOrVsgW+H+f/LmJ7zSRQPCkaMI0
         yPxU68IJ7AotjdtssYYj/LOAek5zBdjLlO5C2e4nPf044/5CKu2V9CmszWEpqc12Lvz7
         kX8Ywr4oKlU7VzNVO/Mu9Bg7GvHP766yCy/YFGmPx2VfkQBvjojzdnV+YFGrGlSFj21u
         d4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KJNVR9w2lPahYh39mXM1RqJL2WmBQoQ/lrKXrATSte0=;
        b=o/StFrr4U68dp+6+FNRvN0Hu/3EOVvv9383JF+lS/2ibHgOPpr0w8jyfsPowcZHMur
         tY0mu1A300z8A9Qwn3oT4udc+uhh1poy2e2d7VazyraOlux1TDF7ycHjN53fMyOJipuJ
         54LDpn3A+E0W2WPzNL+S/waXB+dLB69LCl8lyokcXf9bgkJn94pEJQKm4AJ2tR7kKAPU
         7kNfLJqbIWeNQUBlCHYcrDQfwzmViLzwDu5fo84alGsNvlsCFqlMO1n2aLt+3Homp/hv
         rZrKHZOduCZ/JTIv1R2nDop2flx9JEurPpeRtEjeumfGmGR+a1ZM3Mj524fkiBOiWWen
         1MPw==
X-Gm-Message-State: AOUpUlGLHFJsoBiHizbVX6HAhpWFLqSRWFYZcJLsZiYJQFlgHnBOw63m
        oaUSKAi0EVG9CvW6w0nGXb4=
X-Google-Smtp-Source: AAOMgpexP9bM8RGH2jsSuxLmNZVUA3QiVxYOTpTTV37RQA1DCPtWgQ30TOiE8W0kZuYBe+zt95RH4w==
X-Received: by 2002:a5d:52c4:: with SMTP id r4-v6mr7257359wrv.98.1532332129994;
        Mon, 23 Jul 2018 00:48:49 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id l6-v6sm6644870wmh.41.2018.07.23.00.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 00:48:49 -0700 (PDT)
Date:   Mon, 23 Jul 2018 09:48:48 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Liu Xiang <liu.xiang6@zte.com.cn>
Cc:     afd@ti.com, sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuxiang_1999@126.com
Subject: Re: [PATCH] power: supply: bq27xxx: Update comments
Message-ID: <20180723074848.sk2vykrsa3vrhqm3@pali>
References: <1532253504-17563-1-git-send-email-liu.xiang6@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1532253504-17563-1-git-send-email-liu.xiang6@zte.com.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 July 2018 17:58:24 Liu Xiang wrote:
> The URL of bq27441-g1 and bq27426 are missing and bq27520-g4 is duplicated.
> 
> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>

Looks good, you can add my:

Reviewed-by: Pali Rohár <pali.rohar@gmail.com>

> ---
>  drivers/power/supply/bq27xxx_battery.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index d44ed8e..f022e1b 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -26,7 +26,6 @@
>   * http://www.ti.com/product/bq27510-g1
>   * http://www.ti.com/product/bq27510-g2
>   * http://www.ti.com/product/bq27510-g3
> - * http://www.ti.com/product/bq27520-g4
>   * http://www.ti.com/product/bq27520-g1
>   * http://www.ti.com/product/bq27520-g2
>   * http://www.ti.com/product/bq27520-g3
> @@ -40,7 +39,9 @@
>   * http://www.ti.com/product/bq27545-g1
>   * http://www.ti.com/product/bq27421-g1
>   * http://www.ti.com/product/bq27425-g1
> + * http://www.ti.com/product/bq27426
>   * http://www.ti.com/product/bq27411-g1
> + * http://www.ti.com/product/bq27441-g1
>   * http://www.ti.com/product/bq27621-g1
>   */
>  

-- 
Pali Rohár
pali.rohar@gmail.com
