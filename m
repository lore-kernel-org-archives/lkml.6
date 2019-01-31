Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ACFC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97A220B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hN+RZ1EJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbfAaJXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:23:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42435 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfAaJXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:23:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so1204041pfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 01:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hUUClduHDFLvjhzWWr5Z2jumM65YWSmAcxMAxvc6VCw=;
        b=hN+RZ1EJPfvjf7M54tbdbyrcBE7vHoOq36jMwrBvkORpiTfYPDehUwI+1U6b/10yWg
         YHYdWT7n98pfaVUgh7XFy7L6AyBGZYucKx0MeBl7Z42im+NW8Mh5HP5OONgt1zqK9FRu
         ymkttuH9TmYs4ZFyokNdpmNFntFeccxBIcyrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hUUClduHDFLvjhzWWr5Z2jumM65YWSmAcxMAxvc6VCw=;
        b=fEPJb2/+ILTxmRyjTvTqg0CN+TJA1lD9AKA1ePX6yph50gxS5BamRBFDFi7ASeTJ/h
         V2u/lmshTISj4GGGzRjeW/XRzvqHe6g301KXuNwAtrZLVyn40d/9G/qotPEc28tuRHIa
         alzFlwMKTANoBgYTM64oC6y/metJSmAmQVE1I/4dDSMTQWioTyfu3wzqgzRWPOW6H1BW
         nF8KAE4a5/rmGLjMfPpPd3ve6P3i5n5kpMKU5AzYZLrmTLfTDNpZyHq0I92bsaDLsji8
         N7hP+O/0+umpat3uiJM0Pa7eblNt7DZLmWdM6q0wsvX4z8t5fEZcgDgZQ8pfCu/OKjU3
         tT5A==
X-Gm-Message-State: AJcUukfkEmnV88DiWN2gXgFt0jvgDpf34p1WzGc9Q4/izPRekvp9Fvqa
        moN3V+j9XVAMSndw6T5fqOdfbw==
X-Google-Smtp-Source: ALg8bN5rx8S/iYpKWDFCS5iEHExcPQUHh9OJxCZKjGOIHyD3SxAW3SF99ughrKxo7rqeLUVwH6ltLw==
X-Received: by 2002:a62:cf84:: with SMTP id b126mr33720528pfg.98.1548926632708;
        Thu, 31 Jan 2019 01:23:52 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id t185sm4962883pgd.90.2019.01.31.01.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 01:23:51 -0800 (PST)
Date:   Thu, 31 Jan 2019 14:53:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>, mturquette@baylibre.com,
        grahamr@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        vincent.guittot@linaro.org
Subject: Re: [RFC/PATCH 0/5] DVFS in the OPP core
Message-ID: <20190131092349.fksfqemm23qddkhw@vireshk-i7>
References: <20190129015547.213276-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129015547.213276-1-swboyd@chromium.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding few folks to the thread who might be interested in this stuff.

On 28-01-19, 17:55, Stephen Boyd wrote:
> This patch series is an RFC around how we can implement DVFS for devices
> that aren't your typical OPPish device (i.e. GPU/CPU). They don't have a
> strict set of frequencies that they have been tested at to derive some
> operating performance point. Instead they have a coarser set of
> frequency max or 'fmax' OPPs that describe the maiximum frequency the
> device can operate at with a given voltage.
> 
> The approach we take is to let the devm_pm_opp_set_rate() API accept 0
> as a valid frequency indicating the frequency isn't required anymore and
> to make the same API use the clk framework to round the frequency passed
> in instead of relying on the OPP table to specify each frequency that
> can be used. Once we have these two patches in place, we can use the OPP
> API to change clk rates instead of clk_set_rate() and use all the recent
> OPP enhancements that have been made around required-opps and genpd
> performance states to do DVFS for all devices.

Generally speaking I am fine with such an approach but I am not sure
about what others would say on this as they had objections to using
OPP core for setting the rate itself.

FWIW, I suggested exactly this solution sometime back [1]

- Drivers need to use two API sets to change clock rate (OPP helpers)
  and enable/disable them (CLK framework helpers) and this leads us to
  exactly that combination. Is that acceptable ? It doesn't look great
  to me as well..

- Do we expect the callers will disable clk before calling
  opp-set-rate with 0 ? We should remove the regulator requirements as
  well along with perf-state.

- What about enabling/disabling clock as well from OPP framework. We
  can enable it on the very first call to opp-set-rate and disable
  when freq is 0. That will simplify the drivers as well.

> One nice feature of this approach is that we don't need to change the
> OPP binding to support this. We can specify only the max frequencies and
> the voltage requirements in DT with the existing binding and slightly
> tweak the OPP code to achieve these results. 
> 
> This series includes a conversion of the uart and spi drivers on
> qcom sdm845 where these patches are being developed. It shows how a
> driver is converted from the clk APIs to the OPP APIs and how
> enable/disable state of the clk is communicated to the OPP layer.
> 
> Some open topics and initial points for discussion are:
> 
> 1) The dev_pm_opp_set_rate() API changes may break something that's 
> relying on the rate rounding that OPP provides. If those exist,
> we may need to implement another API that is more explicit about using
> the clk API instead of the OPP tables.
> 
> 2) dev_pm_opp_set_rate(0) is an interesting solution to the problem of
> dropping the rate requirement. Is there anything better than this?
> 
> 3) How do we handle devices that already have power-domains specified in
> DT? The opp binding for required-opps doesn't let us specify the power
> domain to target, instead it assumes that whatever power domain is
> attached to a device is the one that OPP needs to use to change the
> genpd performance state. Do we need a
> dev_pm_opp_set_required_opps_name() or something to be explicit about
> this? Can we have some way for the power domain that required-opps
> correspond to be expressed in the OPP tables themselves?
> 
> 4) How do we achieve the "full constraint" state? i.e. what do we do
> about some devices being active and others being inactive during boot
> and making sure that the voltage for the shared power domains doesn't
> drop until all devices requiring it have informed OPP about their
> power requirements?
> 
> Rajendra Nayak (4):
>   OPP: Make dev_pm_opp_set_rate() with freq=0 as valid
>   tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state
>   spi: spi-geni-qcom: Use OPP API to set clk/perf state
>   arm64: dts: sdm845: Add OPP table for all qup devices
> 
> Stephen Boyd (1):
>   OPP: Don't overwrite rounded clk rate
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi  | 115 ++++++++++++++++++++++++++
>  drivers/opp/core.c                    |  26 ++++--
>  drivers/spi/spi-geni-qcom.c           |  12 ++-
>  drivers/tty/serial/qcom_geni_serial.c |  15 +++-
>  4 files changed, 155 insertions(+), 13 deletions(-)
> 
> For the interested, these patches are located here:
> 
>    https://github.com/rrnayak/linux/ v5.0-rc3/opp-corners-wip
> 
> I've generated these patches by cutting off the top of that tree and
> massaging the commit text a bit for the first patch.
> 
> base-commit: 49a57857aeea06ca831043acbb0fa5e0f50602fd
> prerequisite-patch-id: 9c3ee728603596b8b0ba06ffd66084bdc21b1271
> prerequisite-patch-id: f160e050bcd74f5de6fad66329381853869a6a97
> prerequisite-patch-id: aa23548d2b486c29489b4304d85799d08762254e
> prerequisite-patch-id: 40dd117c45fecb4308298352346546612db94b64
> prerequisite-patch-id: cd102fa42bab19897c2295e8b990b2156626054a
> prerequisite-patch-id: 3b9e5c8ed65ee96cc0f1c50166cf6bbb597ef582
> prerequisite-patch-id: 7e71b957b90ad51d0619944d5ebc859380e8e3e4
> prerequisite-patch-id: 5abd2bd6b3ae3e91551e2b8f9295169019ba82c7
> prerequisite-patch-id: 68bb3e44cf4e5dbd363a1a1750e4d378971ed393
> prerequisite-patch-id: 882b14ef9527b15d22cfddbb5fa2b9d43df1ff04
> prerequisite-patch-id: 6fc14ddeb074fb0826f1f40031e9d161f1361666
> -- 
> Sent by a computer through tubes

-- 
viresh

[1] https://lore.kernel.org/linux-clk/20180704065522.p4qpfnpayeobaok3@vireshk-i7/
