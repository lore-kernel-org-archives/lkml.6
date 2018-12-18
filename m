Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE30C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9854214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bIB3b60/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbeLRACf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:02:35 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42805 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbeLRACe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:02:34 -0500
Received: by mail-vs1-f67.google.com with SMTP id b74so8898909vsd.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cps7q1gt0KIoGTt/u3zzUoFyefZOmClzVgwxqKj7S1M=;
        b=bIB3b60/q1gMWlLIjgNEYf9kY6byYpqlnkAXWJkajIhcD3x6B1143JBkXW2O/N5N9B
         XUI54PFTHpg4+pbSAMpVFskocRw4MUSdp2g6LED9YpL9aXVFik8m607nf+cCBBpmr2ih
         xEVlARFbdNOxyHMi1XIle0VopcpVeJSYhR6HY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cps7q1gt0KIoGTt/u3zzUoFyefZOmClzVgwxqKj7S1M=;
        b=Ldd6CxO443LBO/qYECF8YpDKGhPjjc/XpBetjE+Gg1bj6pwIOXl/rUctExe8d/isNZ
         fsW0qQ/8wFUJvdxC8SxTp8SWif6RlCVLU3tR8rD9TaPuJot/xI5Iq1LJdyBVhYr7n2sK
         3+HuQyNlTlqoXyE+NtbeAauugAgsl5t3r/5CRKxlAkPANGuKdJlnvZSMFWMNmqcMn5Af
         QHVfwwicxTppEkf+qO21tyZv1JTwCVqYmsK4R6L2MglSeEjX6wivj44yph99K8LhdFwp
         EzxZ8jjyzidMlce3kvZxgsv0XxVil/IMFPJ9J7n1D6Os2KinfCuTtc3VWePN6Az9e15M
         Mf3A==
X-Gm-Message-State: AA+aEWaG0TRYorJw7vLeUPmqmSBYwHQavIxG73cjHuhY2ewe8ZPd0m8J
        JZOIhz35xg6vuHS4YvULFgrtP78S4jA=
X-Google-Smtp-Source: AFSGD/WVEmCGzAotgzsLolKTFEz9BXKCdaREWZD2lBTCbzdNMk2rLW4O99x/1QjVV4WZPTNRxNfKRA==
X-Received: by 2002:a67:fa98:: with SMTP id f24mr1801503vsq.125.1545091353054;
        Mon, 17 Dec 2018 16:02:33 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id y78sm4568679vsc.6.2018.12.17.16.02.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 16:02:32 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id x64so8910829vsa.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:02:32 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr6575650vsv.20.1545091351487;
 Mon, 17 Dec 2018 16:02:31 -0800 (PST)
MIME-Version: 1.0
References: <20181217100724.4593-1-sibis@codeaurora.org> <20181217100724.4593-5-sibis@codeaurora.org>
In-Reply-To: <20181217100724.4593-5-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 17 Dec 2018 16:02:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X9KmE60vdkGahRGoEahr6Gufi1Qg0Qa+v6wQtdDVFvcQ@mail.gmail.com>
Message-ID: <CAD=FV=X9KmE60vdkGahRGoEahr6Gufi1Qg0Qa+v6wQtdDVFvcQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
To:     sibis@codeaurora.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 17, 2018 at 2:08 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> This patch adds Q6V5 MSS remoteproc node for SDM845 SoCs.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>
> v2:
>   * Fixed style changes
>   * Added missing clocks in the dt-bindings
>   * Split mss remoteproc node into a number of patches

I know there was some off-list suggestion to split this into a number
of patches, but to actually make that useful to anyone we'd actually
need to _also_ post up patches to make the driver probe / work without
these power domains.  ...and as per other discussions it's kinda
"lucky" that it happens to work without them and Bjorn wasn't
supportive of making this optional.

So I'd actually fold patch 6 into patch 5 and focus on getting the
"aoss_qmp_pd" landed sooner rather than later.


Keeping the "shutdown-ack" as a separate patch makes sense though
since the bindings currently list that as "optional" and I guess
things work OK w/out it.


Once patch #6 is folded into patch #5 feel free to add my Reviewed-by tag.
