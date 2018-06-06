Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1owfIS1nGFs3ZgAAmS7hNA
	; Wed, 06 Jun 2018 22:59:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 803FA6089E; Wed,  6 Jun 2018 22:59:09 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rGvDps2A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y0nizlWL"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 010EB607E4;
	Wed,  6 Jun 2018 22:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 010EB607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbeFFW7H (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 18:59:07 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35654 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbeFFW7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 18:59:05 -0400
Received: by mail-vk0-f68.google.com with SMTP id o17-v6so4857745vka.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 15:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9/MCRAw6El6GMdHZ6B+DcFE8CdMu7X5TOUdkyX7zuP4=;
        b=rGvDps2AMj7hSpfBJswG0a5BxvLRr9LVUDOPC51TJHAJmqOZECEzDyPFee6Czf7Nrx
         h+pAXVhGTCBEDmS3bpRM+WcLOcHV+oaUFOTCgGlv61ViWcCjOm1i7jYeS0iYjuEOVN1o
         +XrnPbKlGgHoqgnO1Rn6JLxHDhI//+big2Xwl83guihC9wXczA90kReTTDDzOn0vteGB
         U4ygUjsDzODfB1Q9XvXRBT8RSUAPmUGRIwV4VKKbip6zDdwnYrW9W3ueK9jnr3xNpwWW
         rdAd2HzWKEKjZVJghP44+auoN9Wsz4bG/Rzq3X9L73k5YUV+GeZ7sJQGTvHkN0YjEFV1
         /3vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9/MCRAw6El6GMdHZ6B+DcFE8CdMu7X5TOUdkyX7zuP4=;
        b=Y0nizlWL7DoCsjxthzZJps2eHj49nDBAomdm96dFmzAiGU9NSGN4KSqd66rpVlwtOR
         TXTw/XN9YRzbQRZKKQbeBKYeeqnd2GRpwOadqvNqmiCHsBE+lWNTqfZy8HWaKD0AnsPg
         8z8WgE8cbIOxjQkXqS9Y0aUf+SoIwmRqZGfVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9/MCRAw6El6GMdHZ6B+DcFE8CdMu7X5TOUdkyX7zuP4=;
        b=jJBceK78vSB9eSxRtrLzxTG6UUjPTDJM9er+rAXcQ+Vp1DaIvoz30EWRjylBYVG1tJ
         +0bj4mt18rzsjqJDNc2ped8QeHK+lHsUHjCFfCjIgSwU5UOayU+gSL+Q2oyUcbsDcUxV
         IhM2o6f1VN8ilXOhUL50BV4M2/un/ycmnnezMu73hFSu+pkCSdkNs19P26GFpNwsDxZO
         21ADLtMRhoIUyxMqyjTLaV1OhzYztJPRH7J8y39wl0N/RXXGmM46maBJKKul7Pa8quDC
         RKUVO7ZJG1LO8ZyrvFiKxBvzZ34qH08gm/fx0cGg2oF4L1m/o1bcNmHUGAwSf8CFZGjH
         4VPQ==
X-Gm-Message-State: APt69E3Dm669f4hqvi52a6IJ5ZKkwVyHp4dZ5ywMo29HoiU5yRzeXInX
        2N4blnKK4BPtu2LsSmklMwa7VDaDmQaB/I63AcktFA==
X-Google-Smtp-Source: ADUXVKJlES1MXW7UYGgbp43kyV5svC0dbVlpjgDkmdsIosbvc5rBE0+DKuEo7rOVLwSolibKcjeuXhyJQ84gASAbg3g=
X-Received: by 2002:a1f:e92:: with SMTP id 140-v6mr3249735vko.90.1528325943758;
 Wed, 06 Jun 2018 15:59:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 15:59:02 -0700 (PDT)
In-Reply-To: <38cb1906c96504f74517018ca4e0aed63bb77356.1528138319.git.collinsd@codeaurora.org>
References: <cover.1528138319.git.collinsd@codeaurora.org> <38cb1906c96504f74517018ca4e0aed63bb77356.1528138319.git.collinsd@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 6 Jun 2018 15:59:02 -0700
X-Google-Sender-Auth: mvzh8eq0a49rEID1iJ8CERNe9Ms
Message-ID: <CAD=FV=X_b0nuGzccTg03WOaNQ81nCtJ2=98btoVf7AQ1W-mkMA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] regulator: dt-bindings: add QCOM RPMh regulator bindings
To: David Collins <collinsd@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 4, 2018 at 12:15 PM, David Collins <collinsd@codeaurora.org> wrote:
> Introduce bindings for RPMh regulator devices found on some
> Qualcomm Technlogies, Inc. SoCs.  These devices allow a given
> processor within the SoC to make PMIC regulator requests which
> are aggregated within the RPMh hardware block along with requests
> from other processors in the SoC to determine the final PMIC
> regulator hardware state.
>
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/regulator/qcom,rpmh-regulator.txt     | 160 +++++++++++++++++++++
>  .../dt-bindings/regulator/qcom,rpmh-regulator.h    |  36 +++++
>  2 files changed, 196 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
