Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4803EC46462
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0C42086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntiWX33M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0C42086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJKAlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:41:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42385 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJKAlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:41:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id c8-v6so2837047plo.9;
        Wed, 10 Oct 2018 10:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+nf3Zatu1huzzxzWJO2lIiEmUWgNHHH+31zSfC22jpc=;
        b=ntiWX33MP5MauMPsU3Ua6KAJ9R3VHEGHu471uLOu45KnE0oi91HstPqZVT7X+qM+O0
         6Dyv8V1ND6J5au32OA1dcr1qWWW9tgDABVSpChwrTAAN2ciW2/MBN1p4RbFE8TOoOHnZ
         Ki/ke6uJ8mj+SHCzKJK1Hw1QPPWMgA17wWT9ATEfPo9AnkcRN90h9hAQ+dvphv5b8MWh
         agak6dfYZfK1hg6VvPme1vQ024MLtmM+zxCZUtWQKB6eV43vUNCcnyBrXQL7RRtyXeoV
         giBQLbpAWl0axhY1MBoS34bpNfOXoes5kMeunhymArPNaH1o9wNbQl5tpLHQq8+c3OS4
         KkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+nf3Zatu1huzzxzWJO2lIiEmUWgNHHH+31zSfC22jpc=;
        b=rO5auWK71zgr4Kp4Jm9kNKgNQxypS1IY2KHP1FVL6sFkmGowai9VrMF0bNPzHtcTyc
         izNKrmbtFvC4P/dMYncBJBGmDHx4ReZ3jIPcno+r2gL96V04pGMHbXmhRZYvBT/UTf68
         EDvRI7w4/wjPpxybnNFv6SY1Pkkng5BqrBbpsVcvuwm+D29nuv8cjRL6UAJvu6rqzmlz
         d3YeUHEnfpuCwazWUeaIsyziab2bQUi7XoL5bWlafYQr9d1eSC9QHcH6KIbaUo/RePAb
         ixf+7nad5DT0QazrsP2rW+GPwD725R5+9js+0QGHQ49U0XPhOsdmJRb8EA63PenFv8UA
         hYQg==
X-Gm-Message-State: ABuFfog/8yqxanymRdYzkgRqyYeplmcApGlzgIZ+MTDWOgJYLCiINdDX
        I6/hgx5haL43O9N4pjmdk9E=
X-Google-Smtp-Source: ACcGV63oJkCqJyBPr46sGAs351xGKfyDp2+ZgBS7nidF0n4Dry/u18KVgDte59+xF+orEP8iuwxDKA==
X-Received: by 2002:a17:902:223:: with SMTP id 32-v6mr2988804plc.112.1539191891732;
        Wed, 10 Oct 2018 10:18:11 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id l2-v6sm23340366pgp.20.2018.10.10.10.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 10:18:10 -0700 (PDT)
Date:   Wed, 10 Oct 2018 10:18:08 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 5/8] Input: olpc_apsp: depend on CONFIG_OF
Message-ID: <20181010171808.GF47260@dtor-ws>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181010142504.233467-6-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010142504.233467-6-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 04:25:01PM +0200, Lubomir Rintel wrote:
> This is a device-tree enabled driver. Moreover CONFIG_OLPC is specific
> to the x86 platform code, while the driver is for an ARM-based laptop.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/input/serio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> index d90d9f1098ff..a4f70021b53e 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -254,7 +254,7 @@ config SERIO_APBPS2
>  
>  config SERIO_OLPC_APSP
>  	tristate "OLPC AP-SP input support"
> -	depends on OLPC || COMPILE_TEST
> +	depends on OF

I do not see anything in the driver that depends on OF. If OLPC is not
right dependency, then let's drop the whole depends.

Are you going to be submitting DTS files for the platform?

Thanks.

-- 
Dmitry
