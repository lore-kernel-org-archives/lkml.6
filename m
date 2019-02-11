Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E855C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3092186A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y0IxkrOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbfBKTgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:36:14 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34789 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfBKTgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:36:14 -0500
Received: by mail-vs1-f67.google.com with SMTP id e10so74261vsp.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LI9fHGq/+b5z36L07EeLPl6ayjNZtVzIXe1TIZuSKX4=;
        b=Y0IxkrOx9WCSO86JVmPYNfm5U/7Aq9LB0/3aoajLP4BxVYbN2N5LuGuJ1Bh2FEfit+
         OvRUT+En+6w4CjCo32zWbyiKEmhtzidKpbRvnlmo3H8HsL/TvPqHvRrc1yWLdtD8lw6Y
         XsB6Ex161rOfaWxHOiXO4dGGz+KZT6/cmVRqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LI9fHGq/+b5z36L07EeLPl6ayjNZtVzIXe1TIZuSKX4=;
        b=OGEh4WdGNx6yeql275/mzSVWeQEHGM+k4ZLhW79n0NHcMYsqsXtuu6FhickXJ0I2mj
         GaK7stq5lS+LvAHTxHaOlevj6vNdByh6ijLAosINBxz1jcWhv3+IxSQN7ueD3fwnrr34
         spIgxJZlD36CiQKjltCMqcZac6h78W+/IWjmAXeV8L70vkmu0pfA1A7Qpcno+EenKzue
         63EQPqOuFlMa6FA88eHjUNHd8kkA0HgGb7Nx72G6n73OFeTgJz1xMXWbNzxHq9l5kq6F
         WZVDV+kD3XYbdK5DlSYpGggkiMjumkO++X6hS+TZdZd8uqS9sUkRYskKbJFULDnf0j9v
         jDUw==
X-Gm-Message-State: AHQUAuZA8BWI7Ej0UBICJjRdaHs3MR0UrTq/DaJuLJM+7VX8EW4QdG9p
        +tdGdQcE5OI8lL3EQf77GRvORy7wdlI=
X-Google-Smtp-Source: AHgI3IaIwnHg7OXeUQFdVHmeicZp3poIFLQRR1GBT+5zDJrY4cBnbUf7+bcoKTLtN1wO7q9GYCBlFg==
X-Received: by 2002:a67:ed4b:: with SMTP id m11mr6557630vsp.67.1549913772896;
        Mon, 11 Feb 2019 11:36:12 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id 67sm12766726vko.0.2019.02.11.11.36.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:36:12 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id d2so34673ual.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:36:12 -0800 (PST)
X-Received: by 2002:ab0:60da:: with SMTP id g26mr14432446uam.104.1549913390968;
 Mon, 11 Feb 2019 11:29:50 -0800 (PST)
MIME-Version: 1.0
References: <20190211190019.171583-1-mka@chromium.org>
In-Reply-To: <20190211190019.171583-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Feb 2019 11:29:32 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UhbuaVkSgeXA75d7+Aw68cNaaiewaSZR+psqfUU+avTg@mail.gmail.com>
Message-ID: <CAD=FV=UhbuaVkSgeXA75d7+Aw68cNaaiewaSZR+psqfUU+avTg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845: Add dynamic CPU power coefficients
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 11, 2019 at 11:00 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Add dynamic power coefficients for the Silver and Gold CPU cores of
> the Qualcomm SDM845.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)

Matches the numbers I saw reported.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
