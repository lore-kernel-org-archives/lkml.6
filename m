Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AA8C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079AC21741
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547022279;
	bh=1CV8lqUW6V5Qu2jI5sPFZ0ipAsiH5cyttOry22UZSDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1rxnSnn8KbKrUBvZWWhVYFk7WSNqCKrNUiXDYk3pn30c4oHrfncNrJbgBk1ylVs3f
	 tQZS3xjchiEH7LfNsfdbfeavvr4/wd6yLe77UZzPHrFM/sx5y3dXa++i7yx4ujvNcL
	 s7NXaXi3Vwo6ZkMoaAMLaBuanW2MvF3D752TTwAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfAIIYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:24:38 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:34827 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfAIIYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:24:37 -0500
Received: by mail-lf1-f46.google.com with SMTP id e26so4982595lfc.2;
        Wed, 09 Jan 2019 00:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vLanaI8a99gMLIUKf8jOB4ad4EZ0sLCvedts9QvaNnE=;
        b=YJPn2TZbD295LfZbMtu89jipZ4ktUokJtCckQ82w6YDvfXaC3Ew6Yo/BRFOS2qLILK
         Oc68hC8vYNyw2PcleZSqJemgghfHP8+bTwlqgA8LVa8Kbck4dlaI22NjMLp3nNOzpaj6
         xxlR/m+gYM6ciSyiNgPzM/cPvzQLFfPlAyyiJ5DLw2r5/o7+dWgqw+tS0fWWy18UDGCC
         KEPGhRDyFUGsY3klw+u/FVU8poX6K7bHBoaM9FfMysDIqnIvF7Dd40f6pClewhgIS0Hy
         Ru6k5YDXcsNwhddKNQEwbd8k5ZwtIPtg1aCgKdlfUhykSwOgluljAYb89l/xQYTvBU1D
         zX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vLanaI8a99gMLIUKf8jOB4ad4EZ0sLCvedts9QvaNnE=;
        b=R3NGaVN7bbPZiIz9FJjOsD/ftu8lBC5rdalfefMnAOO8Pqbr3+XJOnC10Lq3oaCYsV
         PzEG5GQpq88MOlQAr9ur0cBt9Vt9jJXBGKeA6UbxMPJtZ2wvjfVtpVd1+aQRxUDHnHkF
         cKW8savi4WTHc6LCcvOXNjMniY7kI53b2fdzLZf2dcS4MRGJygAFUvIiqwbCDnWm1ExM
         jeHk0dVbh7mTjkiF1qJ7tisbYPk/RRerPKvPRJ8qJZaaXyFM9C7nETRfbrP7C10H5ijk
         +/xP6YeIHSEyrEEMgnGPWFrWU4kWC1g435zF5+HIG14uDkfxlblqaXjXuu9IClfwH7Gk
         KvsQ==
X-Gm-Message-State: AJcUukcJqsrgxmzG4v6GWEcjnA75EoB2xiixcBVGpib3c3zthieniLyh
        bR4R6D391XRwwdqu8FeEfx4=
X-Google-Smtp-Source: ALg8bN7aUZcVGXkzsgV5E4WLftL1LpPpUvGDjlRd/Xgo1VtlrnbuKRubH01M9ig7qSQW9ViiwFWtzg==
X-Received: by 2002:a19:24c6:: with SMTP id k189mr2478278lfk.77.1547022273984;
        Wed, 09 Jan 2019 00:24:33 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id z6sm13701604lfd.50.2019.01.09.00.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 00:24:33 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gh9AD-00056L-FH; Wed, 09 Jan 2019 09:24:37 +0100
Date:   Wed, 9 Jan 2019 09:24:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Nikolaj Fogh <nikolajfogh@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.20 025/117] USB: serial: ftdi_sio: use rounding
 when calculating baud rate divisors
Message-ID: <20190109082437.GA3389@localhost>
References: <20190108192628.121270-1-sashal@kernel.org>
 <20190108192628.121270-25-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190108192628.121270-25-sashal@kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 02:24:53PM -0500, Sasha Levin wrote:
> From: Nikolaj Fogh <nikolajfogh@gmail.com>
> 
> [ Upstream commit 6abd837104a3a8e1cda64fc4d7675f6c3ece9d8b ]
> 
> Improve baud-rate generation by using rounding-to-closest instead of
> truncation in divisor calculation.
> 
> Results have been verified by logic analyzer on an FT232RT (232BM) chip.
> The following table shows the wanted baud rate, the baud rate obtained
> with the old method (truncation), with the new method (rounding) and the
> baud rate generated by the windows 10 driver. The numbers in parentheses
> is the error.
> 
> +- Wanted --+------ Old -------+------ New -------+------ Win -------+
> |    9600   |    9600 (0.00%)  |    9604 (0.05%)  |    9605 (0.05%)  |
> |   19200   |   19200 (0.00%)  |   19199 (0.01%)  |   19198 (0.01%)  |
> |   38400   |   38395 (0.01%)  |   38431 (0.08%)  |   38394 (0.02%)  |
> |   57600   |   57725 (0.22%)  |   57540 (0.10%)  |   57673 (0.13%)  |
> |  115200   |  115307 (0.09%)  |  115330 (0.11%)  |  115320 (0.10%)  |
> |  921600   |  919963 (0.18%)  |  920386 (0.13%)  |  920810 (0.09%)  |
> |  961200   |  996512 (3.67%)  |  956480 (0.49%)  |  956937 (0.44%)  |
> +-----------+------------------+------------------+------------------+
> 
> The error due to noise in the measurements is in the order of a few
> tenths of a %. As can be seen, the baud rate is significantly improved
> for some rates (e.g. 961200), and corresponds to the output given by the
> windows driver.
> 
> The theoretical baud rate has been calculated for all baud rates from 1
> to 3M, and as expected, the error is centered around 0, with a triangle
> shape instead of a sawtooth, so the maximum error is decreased to half.
> 
> Signed-off-by: Nikolaj Fogh <nikolajfogh@gmail.com>
> [ johan: edit commit message slightly ]
> Signed-off-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

The stable tag was left out on purpose for this one to avoid breaking
working setups which may have compensated and adapted to this driver
behaviour which has been there since the driver was merged ages ago.

Johan
