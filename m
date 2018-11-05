Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC01C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2910720825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2910720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeKFIjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:39:54 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39763 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbeKFIjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:39:54 -0500
Received: by mail-ot1-f65.google.com with SMTP id g27so9734999oth.6;
        Mon, 05 Nov 2018 15:17:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bs1TI/nEAQymBtydlcsOxNd6DAC0V2fycpuQf2qgemw=;
        b=iDgA9/SFW8xcOAuyM/OPhlYECjuGvxnjb5+Yf97DmDs5im6X14a2T9d4uJqCbnNoh5
         8Krg7op02TgXXbgp9rfgcECat/YINYKJvjA7VpfKWcEA8BhLHvejFreqnTqu8nSgQZgz
         bfLn4shqTUsclPqiWAu3uRFTmZiCka2mqMCtcxmQkIbsreNGgDtBE++VCVN+nVTVhjyx
         x+NHgzxfVFinUuq7cUEyExCqbyUkLCdYbMF7KS17jrBqeR9MGxgJg9rvbk1Ljr1fEHkx
         B/MDTJGYwFwiDi/TxgdhV/nsk6Ah0WEhh4EXuJVoFgoYUUjRapOGqXaJCs7S0lfQxtr9
         WwVQ==
X-Gm-Message-State: AGRZ1gJIuLXGDi+frNt4zbZUTJ5zNDIblEdRIT0Fo8ftoZgBbgls0Vmy
        6PRRHoWQDA2zuwXIoZXSiQ==
X-Google-Smtp-Source: AJdET5cqrsI0oedIHRPprzB0CEs+bJ+UDvWiYuI8Wr7UlOiepzdaGIBAnvzHPzocS1Dqb/stSfW/6A==
X-Received: by 2002:a9d:1715:: with SMTP id i21mr10641221ota.149.1541459866576;
        Mon, 05 Nov 2018 15:17:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t43sm5719172oti.73.2018.11.05.15.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 15:17:46 -0800 (PST)
Date:   Mon, 5 Nov 2018 17:17:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] dt-bindings: opp: Extend qcom-opp bindings with
 properties needed for CPR
Message-ID: <20181105231745.GA25883@bogus>
References: <20180627045234.27403-3-rnayak@codeaurora.org>
 <20181015124749.27276-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015124749.27276-1-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 02:47:49PM +0200, Niklas Cassel wrote:
> Extend qcom-opp bindings with properties needed for Core Power Reduction
> (CPR).
> 
> CPR is included in a great variety of Qualcomm SoC, e.g. msm8916 and
> msm8996, and was first introduced in msm8974.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
> Hello Rob, Rajendra,
> 
> Sorry for not replying sooner.
> Since Rob wanted the binding to be complete before merging,
> this is my proposal to extend the OPP binding with properties
> needed to support CPR (both for msm8916 and msm8996).
> I've discussed the proposal with Viresh, and this proposal
> seems better than what I previously suggested here:
> https://lore.kernel.org/lkml/20181005204424.GA29500@centauri.lan/
> 
>  .../devicetree/bindings/opp/qcom-opp.txt      | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> index db4d970c7ec7..3ab5dd84de86 100644
> --- a/Documentation/devicetree/bindings/opp/qcom-opp.txt
> +++ b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> @@ -23,3 +23,22 @@ Required properties:
>  representing a corner/level that's communicated with a remote microprocessor
>  (usually called the RPM) which then translates it into a certain voltage on
>  a voltage rail.

I've lost the context here. Please send this all together.

> +
> +Optional properties:
> +- opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. Even
> +  though a power domain doesn't need a opp-hz, there can be devices in the
> +  power domain that need to know the highest supported frequency for each
> +  corner/level (e.g. CPR), in order to properly initialize the hardware.
> +
> +- qcom,fuse-level: A positive value representing the fuse corner/level
> +  associated with this OPP node. Sometimes several corners/levels shares
> +  a certain fuse corner/level. A fuse corner/level contains e.g. ref uV,
> +  min uV, and max uV.
> +
> +- qcom,fuse-level-<name>: Named qcom,fuse-level property. This is exactly
> +  similar to the above qcom,fuse-level property, but allows multiple
> +  fuse corners/levels to be provided for the same OPP. At runtime, the
> +  platform can pick a <name> and matching qcom,fuse-level-<name> property
> +  will be enabled for all OPPs. If the platform doesn't pick a specific
> +  <name> or the <name> doesn't match with any qcom,fuse-level-<name>
> +  properties, then qcom,fuse-level property shall be used, if present.

We've generally moved away from having variable property names (gpio and 
regulators are the big exceptions) as they are harder to parse.

I'm not clear why you'd need this. Just make qcom,fuse-level an array 
and search each 'qcom,fuse-level' for the matching level number.

Rob
