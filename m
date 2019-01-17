Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29335C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C5720856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LdjU7yEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfAQSFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:05:08 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43918 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfAQSFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:05:07 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so4764511pgk.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 10:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=7U/nsRFPVTPZDZZemdQdKQ3Mc/Z2r9c4acHjZBXMUVw=;
        b=LdjU7yEoEd+LjlyxZdRbSy7WIzy4lgct4eSNhadn/fRJyRT82AaIc4U47w6xxx0Ojl
         +gt9GgCgGBzrcK6joSkcUzBGY1XrzpUCZdUeWqgG68z+5rvBDYrJju8JC0W+GlhASk4i
         UR4vzJbSESnwqGAAyAu1R+UuSYgw6rxFHFb+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=7U/nsRFPVTPZDZZemdQdKQ3Mc/Z2r9c4acHjZBXMUVw=;
        b=fFu7fTRWkhIydTQjvneqZvYN46+j1ICMSnwJf7GltioTIejchyObhHZ/cJQa+tYqSY
         l/2xZRSYI/v0flCNImkbaaJwx1wEXfIE8qY33kS9BaECZ1by/h2pAMsrbq1ncFoAEl8e
         +BEEXngaGpsor+t3mgk6+s4pPHqztH6IlWsi+u9DQWB27ZW0xg0YQHGNlfrAXw+gd1+S
         6i4P/UvUrmBcX1RGmJdlReVS2MT8+wEBa6u/1S8X1gDzAuabnAhAYMfhtjYXl5S+JNQi
         g+lCEX7+NZvqtYMjHHOl1ViqObmH2dZ63WyLpvhvp/CZDs8jdIe8ZNbnSkPMiuygzL5k
         drOw==
X-Gm-Message-State: AJcUuketu0DWDjW5ffZPZEDkvKYlLLIUEnXeCib47QuyTMVv8a3EGfXl
        R6n281K1hX4svBEQhx9ZB2CRKA==
X-Google-Smtp-Source: ALg8bN4vZlGN9Go8mOHsufcVSXwo4OEgkaHC50c49fSwZFnDrasq5JwBSYQ2M+o4nBqdCD0cFfQRow==
X-Received: by 2002:a63:f006:: with SMTP id k6mr14349879pgh.259.1547748307066;
        Thu, 17 Jan 2019 10:05:07 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p67sm3547724pfg.44.2019.01.17.10.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 10:05:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: sdm845: Increase address and size cells for soc
User-Agent: alot/0.8
In-Reply-To: <20190117042940.25487-2-bjorn.andersson@linaro.org>
References: <20190117042940.25487-1-bjorn.andersson@linaro.org> <20190117042940.25487-2-bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Message-ID: <154774830553.169631.17749173860111529783@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Thu, 17 Jan 2019 10:05:05 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-01-16 20:29:39)
> The busses on SDM845 provides 36 address bits, extend the address and
> size cells to make it possible to describe this in "ranges" and
> "dma-ranges".
>=20
> While touching all reg properties, addresses are padded to 8 digits.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

