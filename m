Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D358BC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 01:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2A62086B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 01:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="cNFKmP78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2A62086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeIIGC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 02:02:56 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45051 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbeIIGC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 02:02:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id g6-v6so14767855lfb.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 18:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cdcUOO0Nq3wPIcS6LuDJRDk9QguwA/uxfsC+xEanEeY=;
        b=cNFKmP78uEmiZeyp69i+a2S1wfJtTh3yoepKSCnyOYerJjSudEDx4zlr8LYynu6s3j
         O7psMsUJJ5zjtsGsGaQZANmPq3LSj3qVnX3L5oJ3TVwGUsc/19toNTG7tD/VubyI2mf9
         krjdBfKBoEgp642pbyPIBJTku6D4sQZMIvAtdkKZiR80fRXKBv/vQy3xpcxxs/faUENp
         xpSHBOOHmpVpoozb6yr13IKSnOBHmbxcFMuCA7IIfbL//9GgzgU+bLOPekQiBML7e3L5
         BlJjsuxGCkKL64qoLWV4CK1knF4TJ3EB1SFNWmLTe/5Tv8lCrZ7mkkXya65zOoCWPGW8
         4Oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cdcUOO0Nq3wPIcS6LuDJRDk9QguwA/uxfsC+xEanEeY=;
        b=Sdm3xdYdgETF9xrycd7ECe7Cn11Ij4xOck0XD5JToN/Y/KJfiWZU04MVr/5l2yN1JZ
         O8ECbHMFMv6Eujn3JoHhhymNSyX2y8OPwvm0Uxil6bIpnFdijRZEDDDynFKi5gLQ7iOU
         ZQbpgrSJ30No2DEAk8s4J4aywrcXM4ER2m0hSZW9VflB8kb1VbSM0nHWUC3YEUlpin5n
         MYE/Kxchf1sKpFW53AFjLpgZiJyR9L04ZSTRsK/kWBWyuh4odquc8vXp880Ti8pMO8I0
         eodZ+rziwPNsgbb0hXlRNW4xAnPrD7oDW9sEoxVSwGru8URtNZIpQQjnyVk5WXhgvzeb
         xAdw==
X-Gm-Message-State: APzg51DCD7Rxzkn1onI8mgvrmFJfc68VyXoD0raCykApe+XOMaQlrUL/
        +Pti0ADJOgO80HwdWA8tu/QkF/tAIVSmpX5GSz5FFw==
X-Google-Smtp-Source: ANB0VdbA6kankzKs5QZuYTCYVe6NHL+aiGUCdRQSfm3GF9qcXp9tYD1tLVD81y/wSiy36JcZHYX6QhPOmOLmBdyO0PQ=
X-Received: by 2002:a19:d38b:: with SMTP id k133-v6mr8692189lfg.43.1536455712490;
 Sat, 08 Sep 2018 18:15:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:6413:0:0:0:0:0 with HTTP; Sat, 8 Sep 2018 18:15:11 -0700 (PDT)
X-Originating-IP: [99.152.116.91]
In-Reply-To: <1533318808-10781-9-git-send-email-jollys@xilinx.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com> <1533318808-10781-9-git-send-email-jollys@xilinx.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Sat, 8 Sep 2018 18:15:11 -0700
Message-ID: <CAOesGMjMcznFAQj0L-=J5+gJ5ENsdejqP2SdYomu=C9bJqG+YQ@mail.gmail.com>
Subject: Re: [PATCH v11 08/11] firmware: xilinx: Add debugfs for query data API
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matt@codeblueprint.co.uk, Sudeep Holla <sudeep.holla@arm.com>,
        hkallweit1@gmail.com, Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>, rajanv@xilinx.com,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed the below when I was reviewing the code for merge into
arm-soc. Would you mind following up with an incremental patch? I
don't think we need to ask Michal to respin for this:

On Fri, Aug 3, 2018 at 10:53 AM, Jolly Shah <jolly.shah@xilinx.com> wrote:
> From: Rajan Vaja <rajanv@xilinx.com>
>
> Add debugfs file to query platform specific data from firmware
> using debugfs interface.
>
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp-debug.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
> index fc11db9..4532bd0 100644
> --- a/drivers/firmware/xilinx/zynqmp-debug.c
> +++ b/drivers/firmware/xilinx/zynqmp-debug.c
> @@ -33,6 +33,7 @@ static char debugfs_buf[PAGE_SIZE];
>  static struct pm_api_info pm_api_list[] = {
>         PM_API(PM_GET_API_VERSION),
>         PM_API(PM_IOCTL),
> +       PM_API(PM_QUERY_DATA),
>  };
>
>  /**
> @@ -105,6 +106,32 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
>                         sprintf(debugfs_buf, "IOCTL return value: %u\n",
>                                 pm_api_ret[1]);
>                 break;
> +       case PM_QUERY_DATA:
> +       {
> +               struct zynqmp_pm_query_data qdata = {0};
> +
> +               qdata.qid = pm_api_arg[0];
> +               qdata.arg1 = pm_api_arg[1];
> +               qdata.arg2 = pm_api_arg[2];
> +               qdata.arg3 = pm_api_arg[3];

This is usually a pattern we try to avoid (having full code blocks in
a switch statement, and local variables).

Please move the declaration of qdata to the top of the function so you
can drop the braces.

> +
> +               ret = eemi_ops->query_data(qdata, pm_api_ret);
> +               if (ret)
> +                       break;
> +
> +               if (qdata.qid == PM_QID_CLOCK_GET_NAME)
> +                       sprintf(debugfs_buf, "Clock name = %s\n",
> +                               (char *)pm_api_ret);
> +               else if (qdata.qid == PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS)
> +                       sprintf(debugfs_buf, "Multiplier = %d, Divider = %d\n",
> +                               pm_api_ret[1], pm_api_ret[2]);
> +               else
> +                       sprintf(debugfs_buf,
> +                               "data[0] = 0x%08x\ndata[1] = 0x%08x\n data[2] = 0x%08x\ndata[3] = 0x%08x\n",
> +                               pm_api_ret[0], pm_api_ret[1],
> +                               pm_api_ret[2], pm_api_ret[3]);

If you anticipate more qids here later, a switch could be nicer than a
sequence of if/else.



-Olof
