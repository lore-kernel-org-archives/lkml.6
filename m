Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C33C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBF42086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B+UAC0cp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBF42086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbeLKVdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:33:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34679 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLKVdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:33:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id 17so7256237pgg.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:message-id:to
         :subject:from:user-agent:references:cc:date;
        bh=2y6SwtMX5SIXW5zBVJ61CYfaTRs7fsC5P8Axkq/zeNI=;
        b=B+UAC0cpoERMlhY2qX6w2VB8DX9MXPgOm3FtC8D+XBxI4TU1KGP9JVv0BAGuucbacl
         Ys1jFKh39XIuKzNAXjYiUQNWfeRcrCnTAjfiXqyI7FqNap8NNONc9g4+h4oPvFhqzR+W
         fDGoHciwe1u+sF8KBKYt2fR5SE2rXUUTBaLqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:message-id:to:subject:from:user-agent:references:cc
         :date;
        bh=2y6SwtMX5SIXW5zBVJ61CYfaTRs7fsC5P8Axkq/zeNI=;
        b=D9cW2USPL8YR5SgF5Vp6d6bABQDtvObDICH8DXzwDpsvMLNimCnQrpi8QG91jhDbQX
         W9USpemCa46yxIIrxsYRlnP4l2XuxctXRXZpqq+Hr7Kxq5sVkgszxjHU+8nJ2pKUkXPu
         pB0T5V2NH4fmuCw0Hbw4RKcicyT0k+BxPXKz+MFxIhMNfWO9ziyRnqrFmycYke1hcRZr
         GZU6iqwwxJASHcBGWNmNvLzkq/3cZJvTfEhLxgnJfOTpmUnj3jUXSF5rnttCR/5dxB6a
         ZRW0OSG3UTTULo1r4ePCgEt9mjd4oKp+qX7PCbLvOEbHD6kUJ5Tjln9szcGAxZsVz8VI
         xT7Q==
X-Gm-Message-State: AA+aEWb9cRtcJy+Nu2gxSSB+u1QPfNOHRpa/dLDJ2MSJxDr374MYZ9kv
        76QjRUzieTatLxA4g9+Ugj28dw==
X-Google-Smtp-Source: AFSGD/VNt4cHG5dgFHEwm+DX6/DJmcNAIRaMWs+Yo+joPpO2w3+Xm8SIJwiTwYuoS78FLuXLry3X8Q==
X-Received: by 2002:a63:b34f:: with SMTP id x15mr16327259pgt.243.1544564028683;
        Tue, 11 Dec 2018 13:33:48 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r130sm30011052pfr.48.2018.12.11.13.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:33:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181211094938.25086-9-rnayak@codeaurora.org>
Message-ID: <154456402728.17204.32625663426080532@swboyd.mtv.corp.google.com>
To:     Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Subject: Re: [PATCH v6 08/10] PM / Domains: Add a simple_opp_to_performance_state() helper
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.7
References: <20181211094938.25086-1-rnayak@codeaurora.org> <20181211094938.25086-9-rnayak@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Date:   Tue, 11 Dec 2018 13:33:47 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2018-12-11 01:49:36)
> Now that we have atleast 2 genpd providers, both using a simple
> routine to read a performance state value from device tree and
> return it, in order to implement the .opp_to_performance_state
> callback, add a simple_opp_to_performance_state() helper to do
> it, so it can be resued across all such genpd providers which
> just need to read the value from DT.
>=20
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

