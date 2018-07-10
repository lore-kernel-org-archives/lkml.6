Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D577DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E78B208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APezI6br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E78B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933342AbeGJMoN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:44:13 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52103 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754089AbeGJMoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:44:10 -0400
Received: by mail-it0-f65.google.com with SMTP id g4-v6so14230912iti.1;
        Tue, 10 Jul 2018 05:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7N3uYnA41BSFYTybGewvBNvShtl72Iv4E3n5vfzUXn4=;
        b=APezI6brzAbVSy0vb8Emw0M9CEMgTbf0yXCta5pLhaXCm/8j5b9wcUf7x4DZvmuIUn
         Eu/Ye+LAN7VEojE36OKT75tOU6bxWbYjHFFdocZz2v+jxBevVO0jRWh0VrFaGlKEum2Y
         gesQU69E99l+f6MuyvlhykM+LCGjKeWd2feP2TOK5W3jWiG+2Ft52QmnG5lG4heJ+9/L
         7sSy7MGSWAH2fYQcfK+Bn9ZbUswMtFMINz5L2wYQeWj3LHJPb2VKI9LzmJQ4/plPsfCY
         5T3Vs2yfi0skWMPwEG4fLs3SayBQWe7+JqCm2F0iOhO0P1T+F8z0Rfz0m/9vkN0qx0DZ
         Mc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7N3uYnA41BSFYTybGewvBNvShtl72Iv4E3n5vfzUXn4=;
        b=GPtttH61OCOy0f//1u3yeJwKvRJ/MSfUn8LBD+W8F4sHcacNQY4yq9z932HCs/9r9H
         I4wu+yFMgymihxxndUT9D7hf4LrRZVBgrdiKYV/Y5jtRGFryco20LZxsN/BLhfsn8+Dk
         uT8jKGqB8r12HJKaNOYFw1qMoSI+Ja9MA4OGXlTL6/29Q0vlYQy2lnlTLnHwrefKgtIV
         mv9tK3pH0FOLI970ZkLtxQCUsFLyMW4MZbQv6hqqYsSdc6DBrAalwucN4/kNB9Sel+Uj
         fawqaGqlVxPgcIATdnLjOKvzJK3iPr5L8imJ5preyldu4zFAblLhXFovjYeSZf8PpuPA
         dbBQ==
X-Gm-Message-State: APt69E21B4qgZSCMIyz8GATm1P61sZ+QeE8gXdV7TVmS7Tq4qaFNaA0w
        YcGOJQlW67AM4rHlq3RGW7RQqg5tS4P1SBqp9mU=
X-Google-Smtp-Source: AAOMgpd9CUHjzlDTbZbXTVFVFHVWN9mFzSAF9U6ySypKmbCX41VhjU8j+QetoDuExkmRynyNM7/a7WnzEffe9GKccPI=
X-Received: by 2002:a24:3243:: with SMTP id j64-v6mr19240323ita.23.1531226649328;
 Tue, 10 Jul 2018 05:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <1527081091-13389-1-git-send-email-ilialin@codeaurora.org>
 <1527081091-13389-3-git-send-email-ilialin@codeaurora.org> <20180710092900.GA26718@centauri.lan>
In-Reply-To: <20180710092900.GA26718@centauri.lan>
From:   Ilia Lin <ilia.lin@gmail.com>
Date:   Tue, 10 Jul 2018 15:43:57 +0300
Message-ID: <CA+5LGR36xwVWKytv=NGaeS+S7L3ryFgpWWz_dgqH3SHi9XCqaw@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] dt: qcom: Add qcom-cpufreq-kryo driver configuration
To:     niklas.cassel@linaro.org
Cc:     Ilia Lin <ilialin@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, robh@kernel.org,
        Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

The frequency list in the DT is correct, but the initial frequency for
the CPUs 0,1 is configured by the XBL, while the CPUs 2,3 stay at XO
rate. Both rates are unlisted in the DT and that's OK.

BR,
Ilia Lin

On Tue, Jul 10, 2018 at 12:29 PM Niklas Cassel <niklas.cassel@linaro.org> wrote:
>
> On Wed, May 23, 2018 at 04:11:31PM +0300, Ilia Lin wrote:
> > 1. Add NVMEM node for the speedbin
> > 2. Add definitions for all possible MSM8996 CPU OPPs.
> > The qcom-cpufreq-kryo driver will select the appropriate subset.
> >
> > Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/apq8096-db820c.dts |   2 +-
> >  arch/arm64/boot/dts/qcom/msm8996.dtsi       | 281 ++++++++++++++++++++++++++--
> >  2 files changed, 270 insertions(+), 13 deletions(-)
> >
>
> Hello Ilia, Viresh
>
>
> I tried this patch series (together with you cpu clock driver).
>
> The first problem is that the driver fails to create debugfs entries.
>
> The second problem appears to be that it runs on unlisted frequency.
> Is this simply because of missing entries in the opp table?
>
> [    4.538513] cpu cpu1: opp_list_debug_create_link: Failed to create link
> [    4.538567] cpu cpu1: _add_opp_dev: Failed to register opp debugfs (-12)
> [    4.544514] cpufreq: cpufreq_online: CPU0: Running at unlisted freq: 614400 KHz
> [    4.551441] cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed to: 652800 KHz
> [    4.563219] cpu cpu3: opp_list_debug_create_link: Failed to create link
> [    4.566937] cpu cpu3: _add_opp_dev: Failed to register opp debugfs (-12)
> [    4.573489] cpufreq: cpufreq_online: CPU2: Running at unlisted freq: 19200 KHz
> [    4.580368] cpufreq: cpufreq_online: CPU2: Unlisted initial frequency changed to: 307200 KHz
>
>
> Kind regards,
> Niklas
