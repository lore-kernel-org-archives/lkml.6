Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7260C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0AD20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Szsq2CvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0AD20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeLKVxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:53:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39591 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeLKVxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:53:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so7547756pld.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:message-id:to
         :subject:from:user-agent:references:cc:date;
        bh=ajn9n/zfE+h5ltelimETBP75iHPSzvnmxsltyMwfgqU=;
        b=Szsq2CvUDGBfpyrEnpS9Lry+ZbbGlpvFYg02vLI4VTLb6h1xh6HK02WbqmNcuffyNz
         9KgxmMHmwTUnzFG+309a7epLDoNAQ9tQ0edC3G0ZsPfOBDMcbXnDHGJVBdQGjrYOSGk0
         LHP9YaIAI2IKQ4hlEVSG69uGTRy/HVHDMsI8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:message-id:to:subject:from:user-agent:references:cc
         :date;
        bh=ajn9n/zfE+h5ltelimETBP75iHPSzvnmxsltyMwfgqU=;
        b=YrWNpahy2xinJkpmZgCk062GGZvjE6AC6hYiBJOGAaGIlll4KtF4DPiwEETzk/2QAE
         DZ+cojcg6O+M5zlxix3HeK2usMcYPdLj46RvyKOu4fUk3oImDGv2nZuEzOk0F8w9rSzg
         Yrmf2DvBN6HlIuNZIQl4l3thAunlpuMpSJaUDbalIhmDViVVZNsdSd23G0Vuc9YfOM7L
         uzbsN51AN5fJKC3cwlHfTAZOCl09iOsmkuAXBnxa2/3UyGfBJiFRDS6MCFnNpyA5KS3v
         wFEJfqnZiZlLHaFeucDHpo1O25zbk6zgs/tHNZT5ZcDddOL1gpEOag99GZJiFZEttjol
         fUdg==
X-Gm-Message-State: AA+aEWaJ6H9it6UXtFsFqUeGj6jss0iqO9QEv+5lB7KWP6QH+GJ1enHg
        sqEtV5KjLQtytUQoDnuj7udQxw==
X-Google-Smtp-Source: AFSGD/UWJ7jS3P2ZRHL9q6Auf4wEFSN/nGp2NE5APmKfkXo1OpncydDE7bIgxIYDh5vcDfMCDww+cg==
X-Received: by 2002:a17:902:48:: with SMTP id 66mr17135040pla.68.1544565224406;
        Tue, 11 Dec 2018 13:53:44 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w128sm24652550pfw.79.2018.12.11.13.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:53:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181211094938.25086-6-rnayak@codeaurora.org>
Message-ID: <154456522303.17204.12219752202510349550@swboyd.mtv.corp.google.com>
To:     Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Subject: Re: [PATCH v6 05/10] arm64: dts: msm8996: Add rpmpd device node
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.7
References: <20181211094938.25086-1-rnayak@codeaurora.org> <20181211094938.25086-6-rnayak@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Date:   Tue, 11 Dec 2018 13:53:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2018-12-11 01:49:33)
> Add rpmpd device node and its OPP table
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

