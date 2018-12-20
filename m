Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C63C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F2D21905
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545337567;
	bh=yO4dy+AX6VQ7Ihg7s5Rh1CcZrCQSSY4NXYnjlkhXVMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tUVkXINRRZCcn/02Gv+5XARuI6pcxzYBgGUn+2VHOVaYWalNgGJSoKQCnhf+2hJDs
	 kToNr9gnyiVcawZiey0iRyvON5P/P/Uzp6lPSuF3URRt402KGMsFacKk0bRIHFOMZ9
	 3R7XSOc5Oxk4v5qsvTXFmvBVtekY+kabpqeNmZjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389148AbeLTU0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:26:06 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40958 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732120AbeLTU0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:26:05 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so3600038ita.5;
        Thu, 20 Dec 2018 12:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8G0KYzIHv+RUJ0ji1PLz+66pQ5Esn66QVouITPflBxo=;
        b=OGloEE6bbbLee4zXfmGHazA5CfQmfPkqFRLvUkFuHKWX8IXR+5UEKmm9vfVMEfihJG
         49LbUfYmT0OzCGs7bOWUDvUmHWySrHCz6uA2FPk9a9qem3oKH5nyuLjxwrB3Z4bo14NV
         WsDTE9mGcQgzUS7I+ErprzlzPW4WRWNiIChHOKhVOaNVX9s16VF2z4gilI3tooqy7e+T
         YcKOkJjayAhprQCd8Mbxs9MKQ6esVgT7DFbbnxS+dnp3ko0v5VTVHQS7uUupO3+Ux1Ov
         79m5Hkq1E+sTkQZKV7DcD6tErZC0FST5vvzRcEK/33NqlCfzGPn98U7pMgwmTPefNBRi
         TchA==
X-Gm-Message-State: AA+aEWZ4Pv97i1nxP01821pFSgXyP3Mhot50nGBorzCElZ1ws3tEOAYj
        x8/L6tfVmkX/zYeTzMED+Q==
X-Google-Smtp-Source: AFSGD/UF/TgvcVb0i7dxE1MIBV4D30LZNUQIhUPxTk7VXlq9aHZ7rYcaQ0aEcEy4osAuV3hnJKuzEg==
X-Received: by 2002:a24:6c12:: with SMTP id w18mr147885itb.14.1545337564104;
        Thu, 20 Dec 2018 12:26:04 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id v19sm5545072itb.0.2018.12.20.12.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:26:03 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:26:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dianlong Li <long17.cool@163.com>
Cc:     robh@kernel.org, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dianlong Li <long17.cool@163.com>
Subject: Re: [PATCH 2/3] dt-bindings: rtc: sd3078: add device tree
 documentation
Message-ID: <20181220202601.GA3381@bogus>
References: <1544696030-17159-1-git-send-email-long17.cool@163.com>
 <1544696030-17159-2-git-send-email-long17.cool@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544696030-17159-2-git-send-email-long17.cool@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 18:13:49 +0800, Dianlong Li wrote:
> The devicetree documentation for the SD3078 device tree.
> 
> Signed-off-by: Dianlong Li <long17.cool@163.com>
> ---
>  Documentation/devicetree/bindings/rtc/rtc.txt |    1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
