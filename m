Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA1BC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E7221855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lgYFnazP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfAWUR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:17:59 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:37903 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfAWURz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:17:55 -0500
Received: by mail-lf1-f54.google.com with SMTP id a8so2573433lfk.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 12:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UBIM8l4T7TsyTUFSMT/M9lr2pdomzAnmzRMiTeWKafs=;
        b=lgYFnazPLUP63+rjgl9i2x5/dIa/YGSUCMzAGmhp5dUQJodiN+8GzCvHQDXE0MxFQr
         7vltsk6Ewb54Z6VeNQYLaA7iEqQVHo281AhNBdWx6gmrvbL61FrdsPwVuE5idaikkksY
         2iqeAN8emXHCK5T2cpDsJByKlopDgTiVDwQPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBIM8l4T7TsyTUFSMT/M9lr2pdomzAnmzRMiTeWKafs=;
        b=tUl8UUmHqAUSkuSWnAfLy2RGbnI5hqrojgzWR1EfqwvSpBDzluC6b2vDMKyapJ5jdf
         KRb/4Mpczjy8kQGCLtnwWGghKmVWCm2zYot9pTtCfzgdPsNFkRwuZQJrLoTm1hbFcy83
         OM/YuKFBJW+sLqVoSVQ9eHm+MKadrRFPrYsNMA/YF3fG+nnqgzTs/ChqdKmNUglYouL4
         R6UCEGnqIaLO7j+OB6MMkKYvxO+Afn3BbOQuY9Vbsh1cXT1QOzko12WvsXq3/1QpJrJ4
         S9Fz/tYVdb61aPCPxdboaFYSmi9cfEpREvy2b4d2F58DX79NlA2UiazcOYYefxfvsaTu
         Asjg==
X-Gm-Message-State: AJcUukcE0RSZIHFAiPVcfK4f6GPFU963ocByRWOu0MvW3ejKojKtU7wL
        GCPgDUk4N13YYJwQCbqxZfb6Blxm8M0=
X-Google-Smtp-Source: ALg8bN407MwtV5K6qVMCwEyyndgPDK4tGod5GeCvZ2ffoBRzlmLnczruCAFt8a2GOTc92n8lO7TPCA==
X-Received: by 2002:a19:2584:: with SMTP id l126mr3011998lfl.69.1548274672481;
        Wed, 23 Jan 2019 12:17:52 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id y1-v6sm672069ljh.39.2019.01.23.12.17.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:17:51 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id a16so2578365lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 12:17:50 -0800 (PST)
X-Received: by 2002:a19:d381:: with SMTP id k123mr2910395lfg.101.1548274669632;
 Wed, 23 Jan 2019 12:17:49 -0800 (PST)
MIME-Version: 1.0
References: <1548214955-19692-1-git-send-email-jshekhar@codeaurora.org> <1548214955-19692-3-git-send-email-jshekhar@codeaurora.org>
In-Reply-To: <1548214955-19692-3-git-send-email-jshekhar@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 23 Jan 2019 12:17:13 -0800
X-Gmail-Original-Message-ID: <CAE=gft5SQmuY_iUY+5qaL8iJDADYCJVfS_A1YTbeUgQUnTz-DQ@mail.gmail.com>
Message-ID: <CAE=gft5SQmuY_iUY+5qaL8iJDADYCJVfS_A1YTbeUgQUnTz-DQ@mail.gmail.com>
Subject: Re: [v6 2/3] drm/msm/dpu: Integrate interconnect API in MDSS
To:     Jayant Shekhar <jshekhar@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>, seanpaul@chromium.org,
        hoegsberg@chromium.org, abhinavk@codeaurora.org,
        jsanka@codeaurora.org, chandanu@codeaurora.org,
        nganji@codeaurora.org,
        Sravanthi Kollukuduru1 <skolluku@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 7:43 PM Jayant Shekhar <jshekhar@codeaurora.org> wrote:
>
> The interconnect framework is designed to provide a
> standard kernel interface to control the settings of
> the interconnects on a SoC.
>
> The interconnect API uses a consumer/provider-based model,
> where the providers are the interconnect buses and the
> consumers could be various drivers.
>
> MDSS is one of the interconnect consumers which uses the
> interconnect APIs to get the path between endpoints and
> set its bandwidth requirement for the given interconnected
> path.
>
> Changes in v2:
>         - Remove error log and unnecessary check (Jordan Crouse)
>
> Changes in v3:
>         - Code clean involving variable name change, removal
>           of extra paranthesis and variables (Matthias Kaehlcke)
>
> Changes in v4:
>         - Add comments, spacings, tabs, proper port name
>           and icc macro (Georgi Djakov)
>
> Changes in v5:
>         - Commit text and parenthesis alignment (Georgi Djakov)
>
> Changes in v6:
>         - Change to new icc_set API's (Doug Anderson)
>
> Signed-off-by: Sravanthi Kollukuduru1 <skolluku@codeaurora.org>

...weird that there's a 1 in your name.

> Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
