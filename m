Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F06C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F52220874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545079551;
	bh=zFhlol2RYnv9YeSCekgqVKEY6E1R9bc6C2CDB3pDIfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w4Mzy5iRd3gKqSOv6Si2/y5WazxL2+cuIVhkbSb1vckvfN6pX+AYT1J59zvaf//kC
	 4sMpDvxTozmiJMSurPdXm0Wu322UWm26536bIIH7UqI7EVLR0KYPQUOEmFlAnAgAPd
	 h0WYim6j1jYtDsjvEZrS3V7srrkok6m0sfHYmeVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732530AbeLQUpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:45:50 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33784 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeLQUpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:45:50 -0500
Received: by mail-oi1-f195.google.com with SMTP id c206so166089oib.0;
        Mon, 17 Dec 2018 12:45:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M5p71EtpntXIgt/gN3vi/B7x5YnhnbF5jHALytV+kt8=;
        b=dTCFT4QY749uETSE2CtKAuqCR9xH/qR+fIS4+OmgFs7/3qb0zWgmcQAJWBHBtGWwnS
         //4YT//Vjg4QQf/76v/2KZKPs8R34vDdactJmvHI+UbOPjjt072nQuEXp9gW4PdxsVX3
         w21p7iMMxFrC9aB2L718Dlp3p/sIWIcQPt2IVuMeT/MF0+kmOq6rHBD0WpXyxxRnetbt
         TXVLRPQDOiTA62/VM8zMgf1UobawNV+Q5t2sPlsj7+LZKJyN3jj4rjA5dn10qmogCdcC
         ehkVJoXZu9JF1bfNFfgAwTC9e/jteBIF+whEaZR8LbDpHNW5Z7QHMGnL7iQAZG+ZA5ez
         pOSg==
X-Gm-Message-State: AA+aEWYwVXbnAdceo4z+/k/Ib9Rk2ueUHBrRxZu/5D4qRtX27NvWLsM7
        2zmrA1AWxcaL/ZSNQI31Ow==
X-Google-Smtp-Source: AFSGD/Wft+Mp4wnLM/8J1XRwMjzB1U3tt+gH5NTVP+NrrI84w8eKUY1eba8q+UwqbX5+J5f8NNxAKg==
X-Received: by 2002:aca:ac97:: with SMTP id v145mr5942206oie.354.1545079548815;
        Mon, 17 Dec 2018 12:45:48 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com. [70.114.214.127])
        by smtp.gmail.com with ESMTPSA id 102sm7778324otj.65.2018.12.17.12.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 12:45:48 -0800 (PST)
Date:   Mon, 17 Dec 2018 14:45:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, evgreen@google.com,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v13 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
Message-ID: <20181217204547.GA11590@bogus>
References: <1544760624-12874-1-git-send-email-tdas@codeaurora.org>
 <1544760624-12874-2-git-send-email-tdas@codeaurora.org>
 <154476557998.19322.11977618193120872801@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154476557998.19322.11977618193120872801@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 09:32:59PM -0800, Stephen Boyd wrote:
> Quoting Taniya Das (2018-12-13 20:10:23)
> > Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> > SoCs. This is required for managing the cpu frequency transitions which are
> > controlled by the hardware engine.
> > 
> > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> > ---
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> 
> except one question below for Rob.
> 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > new file mode 100644
> > index 0000000..33856947
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > @@ -0,0 +1,172 @@
> > +Qualcomm Technologies, Inc. CPUFREQ Bindings
> > +
> > +CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
> > +SoCs to manage frequency in hardware. It is capable of controlling frequency
> > +for multiple clusters.
> > +
> > +Properties:
> > +- compatible
> > +       Usage:          required
> > +       Value type:     <string>
> > +       Definition:     must be "qcom,cpufreq-hw".
> > +
> > +- clocks
> > +       Usage:          required
> > +       Value type:     <phandle> From common clock binding.
> > +       Definition:     clock handle for XO clock and GPLL0 clock.
> > +
> > +- clock-names
> > +       Usage:          required
> > +       Value type:     <string> From common clock binding.
> > +       Definition:     must be "xo", "alternate".
> > +
> > +- reg
> > +       Usage:          required
> > +       Value type:     <prop-encoded-array>
> > +       Definition:     Addresses and sizes for the memory of the HW bases in
> > +                       each frequency domain.
> > +- reg-names
> > +       Usage:          Optional
> > +       Value type:     <string>
> > +       Definition:     Frequency domain name i.e.
> > +                       "freq-domain0", "freq-domain1".
> > +
> > +- #freq-domain-cells:
> 
> I still wonder if this should be #qcom,freq-domain-cells, but if Rob is
> OK I won't complain.

Probably should be. Though I did give my R-by without.

Rob
