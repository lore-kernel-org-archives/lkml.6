Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDAAC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 04:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B0420821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 04:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtUrEgaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfBEEzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 23:55:18 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38881 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbfBEEzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 23:55:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so964989pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 20:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Pj29ZP53jXH3k34XhVa5Kv7d7T0KHRmwkYPC25H6maI=;
        b=GtUrEgaZgCXKg6irY0VrzPG+p4ZCyRvQ2NjMRs+NabyR9G6/hUNxjQUlfzI5Mukl6J
         Dzn27FCI4MaunKw8W5WZA2bWzEdXIJJcT/6L66necL5Ypb38D4KxjPBocy6GXPHp2y7g
         ZFEICyBaxiCeq03Iw4xawYbDDUCzIIuoK3msM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Pj29ZP53jXH3k34XhVa5Kv7d7T0KHRmwkYPC25H6maI=;
        b=qGdLq8XSThoZAmfgCzJQEAoQjQIVVnrn50XhG0MPzw7EjmksUaoWdrxn+Eojax73d/
         FCpl7MuCWzJMjXernDgHNfNcO7F/sAPhvgwGMbD+r3OFe77rufLcWDl/EoMWhlXZxXGT
         K9FT8lWLkoFhgN0L/dVKhT4VbGfrp0mpNUCmx423S8snIMNKACLCZVDK5xcibpaOIm1W
         EUuZyfEwoDtCHPvrCghu3BUtkdcdK3/KvNzWs0JRbtozrTXnoaTHV/hz55IYDSe9kDfM
         JWSjaL1auGBFZ30ujllHeQur8hjby+FfHtTyy1yTcRwjnrJ4rs8jif5ZhrN79/85ZVWv
         eMlQ==
X-Gm-Message-State: AHQUAuZ8G0tnGe6z0Z4tqv5p9tRuAT5juL5mTL/IenAFLjUjLTOX2x6+
        jds66FmmuJvquOxfVRMUODdKsw==
X-Google-Smtp-Source: AHgI3IYW1/4douBppUhRF/OoyBCckP25XlC7Is6qmjf7KrqFcvc+4c59iKTrvM+amQbB/u9gHh37ug==
X-Received: by 2002:a62:444b:: with SMTP id r72mr3132836pfa.184.1549342517262;
        Mon, 04 Feb 2019 20:55:17 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id 184sm2211166pfe.106.2019.02.04.20.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 20:55:15 -0800 (PST)
Date:   Tue, 5 Feb 2019 10:25:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     sudeep.holla@arm.com, rjw@rjwysocki.net, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v4 0/5] Register an Energy Model for Arm reference
 platforms
Message-ID: <20190205045513.p4ljxgsnvmk3fzgw@vireshk-i7>
References: <20190204110952.16025-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190204110952.16025-1-quentin.perret@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-02-19, 11:09, Quentin Perret wrote:
> The Energy Model (EM) framework feeds interested subsystems (the
> scheduler/EAS as of now) with power costs provided by drivers. Yet, no
> driver is actually doing that upstream yet. This series updates a set of
> CPUFreq drivers in order to register power costs in the EM framework for
> some of the Arm reference platforms for EAS: Hikey960, Juno and TC2.
> 
> The series is split as follows:
>  - Patch 01 introduces in PM_OPP a helper function which estimates the
>    CPU power using the P=CV²f equation also used by IPA. It should be
>    noted that this introduces duplicate code with IPA, which will
>    eventually be fixed by migrating IPA to using PM_EM. The ideal plan
>    would be to do so later, in a separate patch series. I would indeed
>    prefer to keep the thermal and CPUFreq discussion separate at this
>    stage, if deemed acceptable.
>  - Patches 02-04 make use of that PM_OPP helper function from the
>    following CPUFreq drivers: cpufreq-dt, scpi-cpufreq and
>    arm_big_little.
>  - Patch 05 modifies the SCMI cpufreq driver to pass the power costs
>    obtained from firmware to PM_EM. This patch is independent from the
>    rest of the series.
> 
> 
> Changes since v3 (20190201093101.31869-1-quentin.perret@arm.com)
>  - Moved the OPP count inside dev_pm_opp_of_register_em() (Matthias,
>    Sudeep)

Applied. Thanks.

-- 
viresh
