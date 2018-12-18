Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64070C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB44214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IvnMYime"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeLRAC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:02:58 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40398 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbeLRAC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:02:57 -0500
Received: by mail-vs1-f65.google.com with SMTP id z3so8893486vsf.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UKz98X88wWtfeef1wceeSVvlOPemRta0LHzIPR4H0co=;
        b=IvnMYimew4ul7RGmgcb5fVwFenzS/c7A1nVnpRAF0pnDptkt51Vc/mVx/BK5n5PfSB
         /bmtpg3t4wDddNW5Q4HHMtbp5xKKRcLX46CJsOVlzb5xQ66WSFJyeTfYUJIAci0Q657X
         urU2WZAnuaHL6yqwP+SndxDvWvUOmQq8K0D+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UKz98X88wWtfeef1wceeSVvlOPemRta0LHzIPR4H0co=;
        b=mksHOnpzXpJV71/oMNxnwLCoWx9D+NUZJOkID/45qFiqKXAjdB+ONclqaUOyWU3/20
         CoQl5WXJvsZFVqv6XTO25GCGfobxJapmIcTe5oTK/aVfu/p3lvn3eTkqhAj7zhujo+Mi
         5RRwuFppE5dgVHm+Yz+vfo0DyNwZW+Zlg2sz1PFu6VOJRThG8e/d6fMDE7FND9nf0iTL
         2RgTAaHB2BMg1FtgjpGawul7sIupNPkqdUq3/8zOze0wvymUQx7SdLMTilwkZiH8jjXq
         0cPGVVE4UOORACThoPGUmt09O6SPb3se/CJzOQ1g1nFK+vHQvC5t6mlOf7otyOxgBFex
         RWiA==
X-Gm-Message-State: AA+aEWYW2CiYWuBLinjfJ1tKkW9uRIKXOupEcwF2253yMtOq46t0rK3F
        1/5PSc2IbQ4VR8+zXipaSCfxSQPZvmk=
X-Google-Smtp-Source: AFSGD/Wli8i9O4UWsYA+2UA88dMNBMtH/qthp3bNcPvlDzBJPmUxaB99BQPMsQeNiA828ly9p9RsIA==
X-Received: by 2002:a67:b904:: with SMTP id q4mr6871937vsn.148.1545091376024;
        Mon, 17 Dec 2018 16:02:56 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id l22sm6772800vsa.25.2018.12.17.16.02.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 16:02:55 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id n126so3272053vke.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:02:55 -0800 (PST)
X-Received: by 2002:a1f:e807:: with SMTP id f7mr6720607vkh.16.1545091374529;
 Mon, 17 Dec 2018 16:02:54 -0800 (PST)
MIME-Version: 1.0
References: <20181217100724.4593-1-sibis@codeaurora.org> <20181217100724.4593-7-sibis@codeaurora.org>
In-Reply-To: <20181217100724.4593-7-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 17 Dec 2018 16:02:43 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WYda6Th_bjoYsnkzUjcYj7uGb0=3Be-EVu4VHvzxNymQ@mail.gmail.com>
Message-ID: <CAD=FV=WYda6Th_bjoYsnkzUjcYj7uGb0=3Be-EVu4VHvzxNymQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: sdm845: Add shutdown-ack for
 Q6V5 MSS node
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
> Add shutdown-ack smp2p interrupt for Q6V5 MSS node.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>
> This patch depends on:
> https://patchwork.kernel.org/patch/10691213/ - shutdown-ack dt bindings
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
