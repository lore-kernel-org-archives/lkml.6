Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeEOVze (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbeEOVzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:55:32 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Dinh Nguyen <dinguyen@kernel.org>, linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525271313-24427-1-git-send-email-dinguyen@kernel.org>
Cc: dinguyen@kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org
References: <1525271313-24427-1-git-send-email-dinguyen@kernel.org>
Message-ID: <152642133142.237094.1180384414857609098@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] clk: socfpga: stratix10: use platform driver APIs
Date: Tue, 15 May 2018 14:55:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FLteS7029070

Quoting Dinh Nguyen (2018-05-02 07:28:32)
> -static int s10_clkmgr_init(struct device_node *np)
> +static int s10_clkmgr_init(struct platform_device *pdev)
>  {
>         struct stratix10_clock_data *clk_data;
>  
> -       clk_data = __socfpga_s10_clk_init(np, STRATIX10_NUM_CLKS);
> +       clk_data = __socfpga_s10_clk_init(pdev, STRATIX10_NUM_CLKS);
>         if (!clk_data)

And this needs to be updated to check for an error pointer, which I did.
