Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16244C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83BC21924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="CtBA4i8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404398AbfBOQMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:12:14 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44374 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfBOQMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:12:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id v16so10887468wrn.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cJVNd2cFhHKd1BaGhm1R4fTgTH1p7FNdEJXadveVaMA=;
        b=CtBA4i8cjaryYwoKWOYOZcP3oK+/Ywa2vBuI1GgLP8DKO4KpCioR5yzbXLCtahNOOv
         5sgzaIA60D/mve1DKgufdkuQUz5s4FfIws4y5d1fqCkt/u55+zcrzIFf1geCYI5nXy/A
         y4NJgDB6ybsrPClAyFc86/3hrtPBZ4ipUjy+tChUq4e9Ccj+HUBxPdCHWv8SbkvP9Ugk
         9UwdvM1+QpQ2pnb6BdOTa/xTDnxsMH32ecTXGmNPsbXggbm9FhsWTBZkbHpknwowjivw
         iQQoOq7fTjD3q8ELhmXQvNPZbRR0BAFYPzxpZT0bj0Hj7r27T+fGbgrr8dBCfVlvyLR8
         NtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJVNd2cFhHKd1BaGhm1R4fTgTH1p7FNdEJXadveVaMA=;
        b=mEYURuxJQSsiI5vH7p2/TDu+aHqh58LHX+ntY4CDMMrtWsFY75srZ8mF1OHcLNVjsg
         G2W6+07U2qecNrulcaqA10IvHCXWtYOKqNQnyI/Lk6qvA81VOd9jpZYY4sBLBA++Hx73
         q4liqG+v90T80GjReLab8hkdZGtSn319EOG3o5W3Rhn7KJtMxJWPisVO6HBuZtHash1t
         d9b9TBZakNUb2Tm4PRa6LW3YwEOWjad6k5lz2tCmPF8clIdZpbNY3bJGOylZlfw9i3vs
         u+Myr3FuUSUPjdUlszqL1WNSL1+a9aptjrkT6FWnS+nPONVkMUWTdvKX/4mUegFh272i
         dEjg==
X-Gm-Message-State: AHQUAuaxhNoILxS4eYqPueOAHMIXFvDjSa/+mHDNRod2toe4zEnqt+dV
        i0KMvbR1bI81Hfc/Z6acPzNPTswbZ4yLNQYOZgDNJg==
X-Google-Smtp-Source: AHgI3IZ7AQIiaA6hKpK/jkgPagHXfTTFsSna7VeDENsjwahsWn/NvBX5ZSsLfbESuo5iA4sQpJf9F7S91+ITcpu5x7Q=
X-Received: by 2002:adf:9b11:: with SMTP id b17mr7489354wrc.168.1550247130390;
 Fri, 15 Feb 2019 08:12:10 -0800 (PST)
MIME-Version: 1.0
References: <20190215115421.4811-1-axel.lin@ingics.com> <20190215115421.4811-2-axel.lin@ingics.com>
In-Reply-To: <20190215115421.4811-2-axel.lin@ingics.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 15 Feb 2019 08:11:59 -0800
Message-ID: <CAJ+vNU2jRBbsSO4ujiQC-_YZ=zB-tq7t=V34+a8B4gyDM-1Z-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: ltc3676: Fix module description
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 3:54 AM Axel Lin <axel.lin@ingics.com> wrote:
>
> This driver is for LTC3676 rather than LTC1376.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/ltc3676.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
> index 549a1a243870..e6d66e492b85 100644
> --- a/drivers/regulator/ltc3676.c
> +++ b/drivers/regulator/ltc3676.c
> @@ -389,5 +389,5 @@ static struct i2c_driver ltc3676_driver = {
>  module_i2c_driver(ltc3676_driver);
>
>  MODULE_AUTHOR("Tim Harvey <tharvey@gateworks.com>");
> -MODULE_DESCRIPTION("Regulator driver for Linear Technology LTC1376");
> +MODULE_DESCRIPTION("Regulator driver for Linear Technology LTC3676");
>  MODULE_LICENSE("GPL v2");
> --

Acked-by: Tim Harvey <tharvey@gateworks.com>

Tim
