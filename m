Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDDEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA2F20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FRdWWnSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA2F20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbeKAI6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:58:01 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41162 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeKAI6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:58:00 -0400
Received: by mail-vs1-f67.google.com with SMTP id t17so8049282vsc.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 16:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4fkjA/o9kGVGKxcv95a+tW102Loqcv+kDMuOIJ/wt5c=;
        b=FRdWWnSmM90+vCaUTwHb6acAC6qVYTfRM2gxXDz6N0HCQSbo4JLd4RiVIjjoSVvHuR
         WPYqDGgLJEd7UXjF/qDPgBJzLgpZCgzrem8qAVCJY7n4lKDqGQWtFf7z4pIHNRsL3iYw
         n+L95fRvfKUiHbOBKd+0K2gGsXNzPTBnhlcdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fkjA/o9kGVGKxcv95a+tW102Loqcv+kDMuOIJ/wt5c=;
        b=qGSXre7XqhnOHGfRjOOwgVBnHFNZL7w9PNHyc4IJxuP9G3CcZSzRxz0KoxL3gedF12
         bjn1pRZ1rsDYEJfnMVvCS4oXjpNDoBpT8RQKVn8ZSFI/wBD5ZcM1nEoqfuJfpsbWcPm4
         nZAmkNPYuKPUH0sHSZrsECXf2dcSeD7/kQpVNWXAzGymE0VcNCcTdApNS36XFI1l3Zpu
         f7jHKhH0XLCWeCjcOaUI6E7pdIwxbVP37T0xIzv3C74ELxgCnh6GGTi8ydxX1fBHfDx4
         LRTHiKzHWN6HCALxtkYm8Od92PI4Nsi3rAfQuP7rE5vUsVmdEWRA6ZBk01wwTou2tcRH
         8RMg==
X-Gm-Message-State: AGRZ1gIyW7qNRgbbdNC3ow9IgJCtHP1tJfM3UnQYrP4WduqYYfcUaaCp
        qFCQTLOEaCcVWt9oGkT5aFnZNc1+VEs=
X-Google-Smtp-Source: AJdET5eVhFgy8Lsnl3nuXlAL1AqZ3q7Xklz/k+LD01AYcGi5umKJTG9Kr2nBbwVXb5cJhA3KMDusfA==
X-Received: by 2002:a67:e892:: with SMTP id x18mr121862vsn.108.1541030253001;
        Wed, 31 Oct 2018 16:57:33 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id j196sm7907136vke.34.2018.10.31.16.57.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 16:57:31 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id q15so11228102vso.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 16:57:31 -0700 (PDT)
X-Received: by 2002:a67:7986:: with SMTP id u128mr2406101vsc.119.1541030251067;
 Wed, 31 Oct 2018 16:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <1540920209-28954-1-git-send-email-rplsssn@codeaurora.org>
In-Reply-To: <1540920209-28954-1-git-send-email-rplsssn@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 Oct 2018 16:57:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WeRRMDyjgMemtrVN88TODtk_kjTW-NZOV4hDGgSO9HVQ@mail.gmail.com>
Message-ID: <CAD=FV=WeRRMDyjgMemtrVN88TODtk_kjTW-NZOV4hDGgSO9HVQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: sdm845: Add PSCI cpuidle low power states
To:     Raju P L S S S N <rplsssn@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 30, 2018 at 10:23 AM Raju P.L.S.S.S.N
<rplsssn@codeaurora.org> wrote:
>
> Add device bindings for cpuidle states for cpu devices.
>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> ---
> Changes in v2
>  - Address comments from Doug
> ---
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 62 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)

I haven't been following all the discussion about idle states closely
enough to know if the contents of this patch is correct.  Thus I won't
provide my Reviewed-by since I expect Evan and/or Lina will provide
theirs again like they did on v1.  However, I'll mention that the nits
I had regarding v1 have been fixed so I'm happy with this patch
landing if others are.  ;-)

-Doug
