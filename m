Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42B7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EE520652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dSWzbnBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfAQRrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:47:32 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36145 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfAQRrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:47:32 -0500
Received: by mail-vs1-f65.google.com with SMTP id v205so6766544vsc.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MBef/doDSOAMP9wXyEDzqga+vsHU8sCYSuC9Cg5601w=;
        b=dSWzbnBMerk5t52BJPWS10ZjvkzD7tw1CPsOJcHRSDg6kMBOHhY2h9y1JhAiDfqtVy
         0TohTC9dJ4WcJ1otTH8PUYBjU5yn4bBZHespd+RYwnjNjfaraWSTCUx91jwyoATIFeZJ
         sPXmtRINAXDFwmGKUmKYkFO8ncFy5/YAuyYU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MBef/doDSOAMP9wXyEDzqga+vsHU8sCYSuC9Cg5601w=;
        b=GHkC1I8asd0MQdkrSMSZ2xGMY51BXzFRVZJVvOG1ZGeJvB3d3NaWKdIoi+zmSEKLCg
         bnTXwtqG0wB434Gdqb9FJzg3uGJy2y9iSIgar95hYK8Wla+78IA09CicC/o1mY2OTag+
         TVpY92KLQXwxkrON2rrHlnxlJ7E2mBK3jF/YyqVvQortLeHJ1OnmxU+j7EoAoT1rLtp1
         MJhCwr0OiV54FGEk4j91nlq5hfxfMjIpsRXy4D+/fHztP8ZQwYyrlyC96PGiOa7dERmR
         bvD6LdTVb5wcOV8pEDm44KFogMUKNqE2ga0ojJpBqP0bVrIX9sJ19jmNSlniRjgZSBgX
         +X5g==
X-Gm-Message-State: AJcUukdXCoXn7dYd0lDMwyQX9klb8OSVA52f2PLhsrnbEfay0Kq+3xVJ
        0vqnyV+INsR9J9bSjCi3KEn70FJSJFQ=
X-Google-Smtp-Source: ALg8bN7/jUb9Oe0fyFces2d9XC14up5PfUi+iQG6v21X5/scGIdWnV08Y6icHhaC/018pt7k/xGdwA==
X-Received: by 2002:a67:f696:: with SMTP id n22mr6944156vso.175.1547747249850;
        Thu, 17 Jan 2019 09:47:29 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id q193sm2558714vsd.0.2019.01.17.09.47.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 09:47:29 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id z3so6747181vsf.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:47:28 -0800 (PST)
X-Received: by 2002:a67:f943:: with SMTP id u3mr6569270vsq.149.1547747248524;
 Thu, 17 Jan 2019 09:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20190117042940.25487-1-bjorn.andersson@linaro.org> <20190117042940.25487-2-bjorn.andersson@linaro.org>
In-Reply-To: <20190117042940.25487-2-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Jan 2019 09:47:16 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UPwHux1nBm_eO3Uida6hSZLrOwdMpjMQQb5daa3USpqg@mail.gmail.com>
Message-ID: <CAD=FV=UPwHux1nBm_eO3Uida6hSZLrOwdMpjMQQb5daa3USpqg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: sdm845: Increase address and
 size cells for soc
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 16, 2019 at 8:30 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The busses on SDM845 provides 36 address bits, extend the address and
> size cells to make it possible to describe this in "ranges" and
> "dma-ranges".
>
> While touching all reg properties, addresses are padded to 8 digits.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v3:
> - Split out address-cells/size-cells change
> - Rewrote commit message from scratch
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 300 +++++++++++++--------------
>  1 file changed, 150 insertions(+), 150 deletions(-)

It was "fun" trying to apply this patch since you now based it on
Andy's for-next branch plus outstanding patches.  I suppose that's my
fault for suggesting that, but maybe next time it would be helpful if
you could publish a branch somewhere that provided your basis?

NOTE: my tree also has "qcom,sdm845-lpasscc" so I had to manually fix
that last address too.  I believe you left this out of your tree
because it was causing you trouble on MTP.  That's fine and upstream
can fix it up when it lands.

In general everything here looks good though and I'd suggest landing
it  (and the patches it depends on) ASAP because otherwise we'll keep
fighting conflicts.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
