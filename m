Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753669AbeDSWXv convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 18:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753505AbeDSWXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 18:23:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26C9204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Message-ID: <152417662884.46528.2642186598358773095@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 00/61] tree-wide: simplify getting .drvdata
Date: Thu, 19 Apr 2018 15:23:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Dropping the bazillion lists)

Quoting Wolfram Sang (2018-04-19 07:05:30)
> 
> Here is the cocci-script I created (after <n> iterations by manually checking
> samples):
> 
> @@
> struct device* d;
> identifier pdev;
> expression *ptr;
> @@
> (
> -       struct platform_device *pdev = to_platform_device(d);
> |
> -       struct platform_device *pdev;
>         ...
> -       pdev = to_platform_device(d);
> )
>         <... when != pdev
> -       &pdev->dev
> +       d
>         ...>
> 
>         ptr =
> -       platform_get_drvdata(pdev)
> +       dev_get_drvdata(d)
> 
>         <... when != pdev
> -       &pdev->dev
> +       d
>         ...>
> 

Can you throw this into scripts/coccinelle/ so we can have the build
testers run this all the time?
