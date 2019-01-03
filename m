Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A7CC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928C420815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546543313;
	bh=qngNn7ve2PRmUcYsiisx2+tvw44iAFvd4QGzKLd9nr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zr/IFLDqD103BBEiubgSobIkBrBKMOac5HXQEusGbjFUnyKeHm6LcxEm31UYJaT7G
	 icdB7ex4Fy4XpJeNO1vQHUlkzM8ci89rI9el+irCk4AR1KHfjmeOUX9RDkq1ZqsyTH
	 Gn7G+D4qeS8BEkDAHkVpqZP4WZyH2lR3IDmkfrj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfACTVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:21:52 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46489 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfACTVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:21:52 -0500
Received: by mail-io1-f66.google.com with SMTP id v10so27826405ios.13;
        Thu, 03 Jan 2019 11:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dHR6P0IOq33ugUcuj7ppH3uYwROyKm6XyyQ9fiGwcTQ=;
        b=grcv4uoe/91daEjN5udAfLmTrI4p6/6d9ReBqvvSO1maddKlnNmnEuaLYhSlrVfQC0
         rTVjRE7kWGl4/mQ+ZXS+iUw3Y8ssVH2C1T1mbO9Yk0q7CNxa3FPpEauCG/ibRckv5k3Q
         XpDtiH0PGgLMBAU18+tb27Np7YDl57pDDwyYPSbMMfwONmLxMZO5f7JT9MIVCIf9i+e5
         9WXFa5d/a8qkOPrfau7VAbPxHU4uSS29ndJaq97lXzrrQJjWeI2w2la+ihYSx61S1TEg
         2ZCX2K20zDGkk2RJgEdKJjUPes+Oo3LRXU5wgkr7NuQa4HdShzdYjeiQzVgkFHqdoJ4h
         VwpA==
X-Gm-Message-State: AJcUukdaS0gNisyeN9LOBC+AP/qNWt2s6505QRnbUHs5sfNB+2yU+sdz
        H0Qfh4+4id7p3kdBtV5nbw==
X-Google-Smtp-Source: ALg8bN7be7bB/VxUgl8TszBC4rV4CMEArpP/+mYFjJAU4vVIDJPgTcZgLyFjPIPCgoBUMnWJBuTqtg==
X-Received: by 2002:a6b:1604:: with SMTP id 4mr32388753iow.29.1546543311444;
        Thu, 03 Jan 2019 11:21:51 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id m10sm11883234ioq.25.2019.01.03.11.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 11:21:50 -0800 (PST)
Date:   Thu, 3 Jan 2019 13:21:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     qii wang <qii.wang@mediatek.com>
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, leilk.liu@mediatek.com,
        qii.wang@mediatek.com, ryder.lee@mediatek.com
Subject: Re: [PATCH 1/6] dt-bindings: i2c: Add Mediatek MT7629 i2c binding
Message-ID: <20190103192150.GA16529@bogus>
References: <1545397111-24183-1-git-send-email-qii.wang@mediatek.com>
 <1545397111-24183-2-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545397111-24183-2-git-send-email-qii.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 20:58:26 +0800, qii wang wrote:
> Add MT7629 i2c binding to binding file.
> 
> Signed-off-by: qii wang <qii.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
