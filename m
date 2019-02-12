Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F89C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DAA21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WysnHriJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfBLIGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:06:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33049 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfBLIGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:06:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so1610863wrw.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AJmpfojvh+1XOq1HugVrXUYHf2/f6xZ6EA5g4sPH8/Y=;
        b=WysnHriJgt9VT5Ki6lX6mClco6PdK6J7OeYXZUwabRUK5GjosWXqHf4osZhrhwH+BW
         zFub/CIjCvQN7ePdJ3t5Bf+g/hEbq20t9jJ2uSvmT1AhhA2QTmbNSea9X0H4Or/qxY9T
         zqdva796omypBrnLWJbDa5cihxA2VPaAF9SSFFJqtSxg4kdvqsHjecZu79t5jkbgJZk7
         8dm2XEmEt9ysqKmdnHhieBMay8RH+403tF+LaexAr6HC3rkpt4kPsnUlcvCCtho2in7Q
         ehJ9xNK4QdDUeGJqsPqhTbx3xbg6JGIfI8izGctMY0eXVen4e5TFwUU42Rp3E09iHkp8
         3/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AJmpfojvh+1XOq1HugVrXUYHf2/f6xZ6EA5g4sPH8/Y=;
        b=jKBbicJHMLtqtvzqI11M7xChvgyAjY8tpMvW69yxn/zywvKMW3ZSPbNZAbcVx9R3DC
         9uvcxJOlzXnN3VQeA4f77265oyHy65B/9ehThS6G2c2uSYkil2TCwYmGKe1sUTXnDrKG
         4HV8aCYlcAFqjH3HSGqxfL+eMq/XJEZJwUyTw0QqMqfzlS4tdOVK8ruAU6a96d6GL+u0
         vcQ2BgBDrWYMzEUmNyKmDLdgyl1SQqeHuBSxji7YThHcrQtKffa+rKJvVj2UoqozA031
         UWAveq4Mn6uiijl2YzpVGuAZtxIytni9AHYoGYdZfaf7eRcyVHotO5ZEHAtZ1w2Ds5Nf
         ysRw==
X-Gm-Message-State: AHQUAuZW2N6/54BybwI7W2BQf0uNQYBpRkYKyFhuKJVfVqIF3pBFWmbk
        O/BvirSjI8tJytNvJ9loDfHcBw==
X-Google-Smtp-Source: AHgI3IZ+X+bRntRA5FhugsZ9a19mz6BiY3STjeCeUeq9Olmi4SEeEGddKvdgasX+JIsn4y6b/qzK7A==
X-Received: by 2002:adf:f4c8:: with SMTP id h8mr1942102wrp.6.1549958773387;
        Tue, 12 Feb 2019 00:06:13 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id q21sm3399484wmc.14.2019.02.12.00.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 00:06:12 -0800 (PST)
Date:   Tue, 12 Feb 2019 08:06:11 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Zhang <markz@nvidia.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>
Subject: Re: [PATCH v3 1/4] mfd: max77620: Add backup battery charger support
Message-ID: <20190212080611.GM20638@dell>
References: <20190212064353.7451-1-markz@nvidia.com>
 <20190212064353.7451-2-markz@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212064353.7451-2-markz@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019, Mark Zhang wrote:

> Add PMIC configurations for backup battery charger, which
> is a constant voltage and constant current style charger
> with a series output resistance.
> 
> The max77620 register CNFGBBC(addr: 0x04) defines the
> parameters of backup battery charger. This patch adds
> support for it.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Signed-off-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
> Signed-off-by: Mark Zhang <markz@nvidia.com>
> ---
>  drivers/mfd/max77620.c | 80 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)

My previous review comments still apply.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
