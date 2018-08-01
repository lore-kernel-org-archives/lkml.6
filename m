Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28454C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE959208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L88W5WLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE959208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbeHAIlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 04:41:11 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41918 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbeHAIlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 04:41:10 -0400
Received: by mail-oi0-f65.google.com with SMTP id k12-v6so32702026oiw.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 23:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ukydBWjyHY0DwPsPBiOpFOz/dMQ3YjGz4iJzNERWkTQ=;
        b=L88W5WLYa/DWGfjLXZR2dfG7mQ/NA5u1yXfW7SGtaJ/CESjtqBI7pFzpzhRbi/ObCp
         JtRU/LSJgZqIirhtNbNhxQY5kRjQEOZkTE94BYcZtLekaM4kVUaXIGyLSwGdq44sJJRS
         js7x5vAM7FeshkVtzuRoqc6CgPwOeshssSegQRrcQoWgXsgvKhCOWlBCr/jdPyFhzF7h
         r9szDJlYdfoJJWxE1o6ElWalUnAh9NlHhSz5FIpd5mF35K9lV2BbEQTPtXabmK5/JQ2o
         Lu28VztQ9TplWLGtDMW4wLaDKf+OBrdlKuBnFAVCd3l1AFtg+9C9jF3vODQFLAhnkbpz
         1RoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ukydBWjyHY0DwPsPBiOpFOz/dMQ3YjGz4iJzNERWkTQ=;
        b=gF4aAQh5ss397WV6mx1vq9Nq8qzSa2GH8kGlwO/sf1Y4KkD/NHPMMsAx7DRKyzOAmp
         WyTcw21cYe6DrJZlVN5w+Hh5DTROOBnM2eXTWWOJAbVwawquJj6wUCAc/SgEDx6+jpKb
         U+y17fZc2offtDiCpl2h/34QO0fCoA2lLhCbistZm5PINN6vwGwme+YnFQdywzan++d2
         SRheAO8HLhxI4hJ9wrZkc9pcm1vZHCt1DOJkafnuzIUcUqptiCvp6ENv4+a3pJtjD+Dr
         l9xHcxqd/hLCwLhRINWNTi1hvned7PCCN7zVAGNAR4bLLk6a0w65qcKdzCSo2frMYghE
         fXQA==
X-Gm-Message-State: AOUpUlHRTxvqNMrmFhrSV3s+4b+rNhXcBW/FVrrYI1Iu6ZfEQVWEGbFl
        bgL6dWjwrDOrUQHpeL1j4uO2bM/ebh6BMqCfW3CT+w==
X-Google-Smtp-Source: AAOMgpdDzGBO8g3Qsv2cbBUNz5aQagEXnRrjscA/In+DA/NvDm80b1WCWyapRCXK/NC8YsnamM5DJmQ0iX2RQzv5RMk=
X-Received: by 2002:aca:c692:: with SMTP id w140-v6mr2172187oif.284.1533106619011;
 Tue, 31 Jul 2018 23:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180724203615.5770-1-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20180724203615.5770-1-jae.hyun.yoo@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 31 Jul 2018 23:56:48 -0700
Message-ID: <CAFd5g44L+-6wtV4+Kn5-j8zRXA1aNamR2pV0EaFpcoshgQ4bTQ@mail.gmail.com>
Subject: Re: [PATCH i2c-next v2] i2c: aspeed: Add an explicit type casting for *get_clk_reg_val
To:     jae.hyun.yoo@linux.intel.com
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com, james.feist@linux.intel.com,
        vernon.mauery@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 1:39 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> This commit fixes this sparse warning:
> drivers/i2c/busses/i2c-aspeed.c:875:38: warning: incorrect type in assignment (different modifiers)
> drivers/i2c/busses/i2c-aspeed.c:875:38:    expected unsigned int ( *get_clk_reg_val )( ... )
> drivers/i2c/busses/i2c-aspeed.c:875:38:    got void const *const data
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
> Changes since v1:
> - Fixed title and added Reported-by tag.
>
>  drivers/i2c/busses/i2c-aspeed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index efb89422d496..a4f956c6d567 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -872,7 +872,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
>         if (!match)
>                 bus->get_clk_reg_val = aspeed_i2c_24xx_get_clk_reg_val;
>         else
> -               bus->get_clk_reg_val = match->data;
> +               bus->get_clk_reg_val = (u32 (*)(u32))match->data;
>
>         /* Initialize the I2C adapter */
>         spin_lock_init(&bus->lock);
> --
> 2.18.0
>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
