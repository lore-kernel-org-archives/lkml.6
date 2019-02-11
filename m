Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5162AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2068921479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549877832;
	bh=foRBQeHEiCaO/EPmDxfskAi6Llu5UW+RE10OU2iH/SI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bpXwona9qGGcEq28YbNvHforDWJjxOjzVs4SuWkh5WHNkK1iKpKsr9DJNfca8m29Q
	 qbJGHPfdJccAuICKnDM3kPxCeLmBDfzSJie60+CRG0D0bU0CxGtlWJemJ47KKB3GJU
	 8LWEBzU/SmhquDetu1poTVOqJZ4lRroPqRl3+rF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfBKJhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:37:10 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39565 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKJhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:37:10 -0500
Received: by mail-lf1-f68.google.com with SMTP id m11so7182359lfc.6;
        Mon, 11 Feb 2019 01:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iKJSIi4ha1RcuzlzV4L/+DQ0YNPmUYrwe7zDcZIVfNw=;
        b=J659PnKUmf5dd2/ZvMJ3+EnvyH/9+yP/RuPYINetG8Sbl7SIygSkOC/IZT1+iOJ1hz
         EAjpCZoW8MqJqWVXiGRKU9D1v0wfGFT6U8+rnyOfOt02+iFRwusxehdBCy3x0/ia2/7r
         ESlUDPgNNFf1PSs8vVqgn2AYRb6/OzorvCGGOjC7NP0i63w9YwLxb/wydBJ/RauPvA0U
         C1TdN7N3swB6A1dhkzemT6reqHuMSS44IzKBgE2IEUTyXpk/WXHQZP+ZB05rLVIxy7H1
         vF90KTQ1zXgJvMspWpTTo4adxDoL+8fR+ZpS5VBvrQ6MHtZi7dlrtFCviIc8RqT6f/1Y
         fHEQ==
X-Gm-Message-State: AHQUAuaEkGGb69ClWJzGTRatctT271F/XaCLrwgWd/VCPLKERg9hXQHc
        B9ib/lXxg3BKA12rA8E9aaA=
X-Google-Smtp-Source: AHgI3IZZGJDvlZZsWcIi9WL8bI2ob+5KNpy3ecqkGhOraPn6LwvFNNohCwHl1vXaq3XkvEZ9xO1EYg==
X-Received: by 2002:a19:5504:: with SMTP id n4mr4899227lfe.43.1549877827786;
        Mon, 11 Feb 2019 01:37:07 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id h22-v6sm2178325lji.45.2019.02.11.01.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 01:37:06 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gt81N-0005DJ-I1; Mon, 11 Feb 2019 10:37:01 +0100
Date:   Mon, 11 Feb 2019 10:37:01 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] arm64: dts: msm8996: fix blsp2_uart1 4-pin pinconfig
Message-ID: <20190211093701.GX4686@localhost>
References: <20181220161750.12587-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220161750.12587-1-johan@kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 05:17:50PM +0100, Johan Hovold wrote:
> Fix "gpiio5" typo in the (currently unused) blsp2_uart1 4-pin sleep
> config.
> 
> Fixes: 22e6789f9493 ("arm64: dts: msm8996: add blsp2_uart1 pinctrl")
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

I can't seem to find this one in your tree (or linux-next), Andy. Lost
or simply not applied yet?

Johan
