Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803F0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA3621841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MtJYfUQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390242AbfAKTGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:06:40 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33491 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732319AbfAKTGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:06:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so7384691pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 11:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=eoDCQv3vYmDCbPV3IbEiSrapWVSfAUycx8oHWiPv4iw=;
        b=MtJYfUQkSemIbiktQgm2wswJdo7xctBg1DjK+PzTozg7XHzoAIfqLV8Lvk3OVfajhy
         TJXew+4gJX+95RvgUSeju2x6/1hfY1hLYhgxA6z8Lru8jz6mGP4VU38SO0jRk7uFto/n
         gX9VLp8b7JOKAFRFzUTpxjb9WMmChOIfecnxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=eoDCQv3vYmDCbPV3IbEiSrapWVSfAUycx8oHWiPv4iw=;
        b=jo2mPCCS9qARx+/y5GxTbg0wk9eJ5zXjrEN2LWW6I2/k/NeaxJHGcBt5MtcLUwk6CN
         6RwOwyh0e/94T3mbAuyymHlRJ0yDuIsTO/vs9aln3k1zI7HfaoX0EjxZp5uyqVFwo88Z
         +Fzjx6QBDREW203B0ZNxXHBncKA0DwRmvbnjVJLztTYapKYftQ7Xb9np9qyfCkzEeMhC
         Mr4tCQRcRzbV8KBWVl/LV7ocyLqcY13bbaK8jVURohobu+IbuKeawmEDNMxQ4OJIyQ7h
         oDX5Hb8GV2Bt1XFF60/d0U30CW2e6g5rWXeKlCRoEGF959vkFOmM+RSC9Hw402quZ9bZ
         E95A==
X-Gm-Message-State: AJcUukeLrd075e9Ge7jCZSQUzc4+7PWSBQ1u36TaZz9WW0YCVaoTXTC6
        OkTdhuFipcUGgbysPH9ZmWYtlA==
X-Google-Smtp-Source: ALg8bN5BeP5KKwYruY/c9SvVsty8Ui4yuayOq/5xXccfUFyeBAdJCxRK5oXah45uxkW+CiS+UDr2qw==
X-Received: by 2002:a63:7c6:: with SMTP id 189mr4457341pgh.129.1547233599546;
        Fri, 11 Jan 2019 11:06:39 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j70sm113060576pfc.43.2019.01.11.11.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 11:06:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v11 2/9] OPP: Add support for parsing the 'opp-level' property
User-Agent: alot/0.8
In-Reply-To: <20190110040209.6028-3-rnayak@codeaurora.org>
References: <20190110040209.6028-1-rnayak@codeaurora.org> <20190110040209.6028-3-rnayak@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com,
        Rajendra Nayak <rnayak@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Message-ID: <154723359821.169631.14660165462556251824@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Fri, 11 Jan 2019 11:06:38 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2019-01-09 20:02:02)
> Now that the OPP bindings are updated to include an optional
> 'opp-level' property, add support to parse it from device tree
> and store it as part of dev_pm_opp structure.
> Also add and export an helper 'dev_pm_opp_get_level()' that can be
> used to get the level value read from device tree when present.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

