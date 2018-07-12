Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D34C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E00320842
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="iwzkq4qz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OpBpL1Et"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E00320842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732497AbeGLRX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:23:29 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:46293 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732446AbeGLRX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:23:29 -0400
Received: by mail-vk0-f68.google.com with SMTP id b14-v6so16738774vke.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 10:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=D2czzQbCr/f80xVTW+vQ/jfpnt0soYiRbB2OPBxh7eE=;
        b=iwzkq4qzfqbtms0ALXxzKLvDBDDeRKCxqWtS6G0hUvLh2egNFNos56lAUcHNAaOD7Z
         dJfWm01P34ES9f48nFXy0wETrUs4bIEQU+k3a73EJ8MTbiAE6pOx4np7YnYcvNJ3dfEy
         ilvv5V8/Bd+AjWCRvvnUzTc+dCAlgGWRu6IVX6NFjGdkH3y4GnEPOKAh0G6Oi7wx15pd
         g+b/AOxdInE9CTdNj+SJwMZ6i8JNruw7jjPd+HK6wqC5RixA4nkamCY4cXXSArLIZMZN
         cblKToJTwoNRrBe+qOiRpBX17j2DVKFhy/wnXHjt0xvixQhuDcCPmsV9rXwTGYftCkJw
         Hv2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=D2czzQbCr/f80xVTW+vQ/jfpnt0soYiRbB2OPBxh7eE=;
        b=OpBpL1EtTFmysCElATGJwEXZLJCaxnYFyU4mnENRpOvn9WFm/by0zKkpdp5awlxyd3
         bp6ItsMpilQBSb8K7MXtIX+Ww8xLBLUPLp2WDuFd6APpmplF5wWeFo4k9bx8oL1YhMwn
         ZwJS8VuybVt2GI5dbPskjl7aaIiAKN6nw+UFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=D2czzQbCr/f80xVTW+vQ/jfpnt0soYiRbB2OPBxh7eE=;
        b=f2HR8A65lJZkguVPFabyT6y7j1KrxEDXSxb9h1mBihFGjtdqUcJbHjzsG5dAlraSFd
         i1eQjvhWFc0fhqqjSB6N3gulBAsvO19xDNA2i+hscuT4TSRMcuc59sN3T3oRfZRsVoO0
         Ipq1wLFpz0d+m+g+PJzK3Z/8aAQR/cvOlBYkWc4Hv0d+7sie0Jpzp5yQG1DVhYFTVjWo
         W5yXvu4YxDR+gfdk0r7ZmLx1SBH5ZMwqceo5ZUt4AIcpDfhcK3eXwH131NH3ikXpILN6
         exRtjY71NYWBTX8EKEKnD9BBtyWW0amrFnnapYYadBLRF+6J9ONPv+Po/M/1HG8m/WFW
         7tpg==
X-Gm-Message-State: AOUpUlG3fx/7+lhBTkkyAT9VnzrhrIV1yBiFyZ/leVcdzy04zoUJBS4T
        e/l0QjjqEkf8lbsSSoxXV+kxUKZy4/m6iVdY4fwPoQ==
X-Google-Smtp-Source: AAOMgpdrDAmBFYiEeKzxD6dQcaVIvjv0Y7nK1Ht8DqCU4oH7JWPiDFKhWqeaRpY8fsWJoISKVmT7c1/OtZUAlEp+0QM=
X-Received: by 2002:a1f:c014:: with SMTP id q20-v6mr1867155vkf.144.1531415580935;
 Thu, 12 Jul 2018 10:13:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 10:12:59
 -0700 (PDT)
In-Reply-To: <8f833fee80565c4dfd381697e47f99fb5f9e65d3.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org> <8f833fee80565c4dfd381697e47f99fb5f9e65d3.1531384019.git.amit.kucheria@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 Jul 2018 10:12:59 -0700
X-Google-Sender-Auth: qb1FLtCQ73lfO6FciD52uOr9bgg
Message-ID: <CAD=FV=Xk9uxo2CLBnnji4+hv14jBpkhAYVFtduK8+6dwJyrjpQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] thermal: tsens: Add support to split up register
 address space into two
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 12, 2018 at 1:39 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> There are two banks of registers for v2 TSENS IPs: SROT and TM. On older
> SoCs these were contiguous, leading to DTs mapping them as one register
> address space of size 0x2000. In newer SoCs, these two banks are not
> contiguous anymore.
>
> Add logic to init_common() to differentiate between old and new DTs and
> adjust associated offsets for the TM register bank so that the old DTs will
> continue to function correctly.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/thermal/qcom/tsens-8996.c   |  4 ++--
>  drivers/thermal/qcom/tsens-common.c | 12 ++++++++++++
>  drivers/thermal/qcom/tsens.h        |  1 +
>  3 files changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
