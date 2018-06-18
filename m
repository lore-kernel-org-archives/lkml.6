Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A465FC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569E020836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="voRBIwof";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q/yYtCGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569E020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935626AbeFRRma (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:42:30 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:41089 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934957AbeFRRm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:42:27 -0400
Received: by mail-ua0-f196.google.com with SMTP id a5-v6so11222153uao.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 10:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=taDeIYkXLzTePN98WcI5eMVcXoBA7KZ0Xynd5AkepUw=;
        b=voRBIwof4J5lZEFJwG8cqKr9C1CVa4PpqLr5x3GXTiqv8rWWDPT8Ju0ruw/9A7dhyB
         hcQqxT5IbfmIUJvu2RD16nWASqMbQjG0WnDKcm3tpHCta9PZxnmQie4JKzaqGLZnWr2o
         oKfX64i1Zd0QehfA0RcMHy/oviZKst3U+vIRd4bIfpMOg/7Rx2t4k6zYl1r9M1mI/Nbl
         ow5tCralMmcWYYRkIoN8nJdT+wQicCVNxv59+C3TyIgGJT4fes0E7ynMJM+noGj9QS1P
         zjyNHRoaaehg+1hiOUdh+lXpw40kbD8YJhoV5eZfTdTqTm6dU13Z5u+DF3rha8hhEtEV
         XnOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=taDeIYkXLzTePN98WcI5eMVcXoBA7KZ0Xynd5AkepUw=;
        b=Q/yYtCGMcYD6dJZouBRPZppJ27wuABNb2mT1lusamZx3ctP/rNsPwGcG20gDYV7eiK
         D4eeQxvFdLObv/cFgMK22I2wgbXRlQ29WKirE+rjVlbNvyufjMe71KZQlbwQWdPISSNw
         atpKTw2fd3do8k2KIV0MB4/v6MtgqB54AlfIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=taDeIYkXLzTePN98WcI5eMVcXoBA7KZ0Xynd5AkepUw=;
        b=Pzhd8jNfa6Mb5HzmaXtpd3k6IQMAC5blDyu6NObqKSRZuMUBDL3ZCDGYaOpLh8Fd7N
         Qr73oPXFkR2Qr1cRoAzdzklW7733J7PM5Nld/5HyhJVQvjRbOh/7SQs72OeZm49NtlWR
         N/HrM73CFeDNd+RqTHUA7GPjw+PLqv6m4qrogArfGyLB89rXmLcSPOuIQG/644ua+1rO
         L6i9A0qR1SZ1nfK0TFjUvfr6ISFtaANkXTQrttw7gWNcNVTTYOAGPyvGji8kdj0uQtW7
         2q+Og7xz5W+2lBGuhqeLVqaJPI8RxS/gfkbnybbueZkPz9bzkBAAdKbPHmON2l3+lJoT
         sZFQ==
X-Gm-Message-State: APt69E2clNmBFCIr4Qe5mOrV8FpPVv6mLHcqa4PPypAn81AFVlsg1zA4
        gz+znfx/Nu/VYCbS3Ki/fs+B3sp0sTxuUPR2JEWjJg==
X-Google-Smtp-Source: ADUXVKLXfC6OtoRaIqEYPprVKjSbUjrtNBBWDXIA35LTdXzgYq/ZyAO97DpPGS+3+69SHGO9mJ+q2+D9SC+08bEEUvs=
X-Received: by 2002:a9f:3b9b:: with SMTP id r27-v6mr8276774uah.191.1529343746056;
 Mon, 18 Jun 2018 10:42:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 10:42:25
 -0700 (PDT)
In-Reply-To: <1529329040-2606-1-git-send-email-rplsssn@codeaurora.org>
References: <1529329040-2606-1-git-send-email-rplsssn@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 Jun 2018 10:42:25 -0700
X-Google-Sender-Auth: P6uKGYtFcHvphoDXQBVnJ2ZRir8
Message-ID: <CAD=FV=WwTN_fswRcMLR3_=3_Sju50eV+LpDZsi+x5-7bu87Qew@mail.gmail.com>
Subject: Re: [PATCH v11 00/10] drivers/qcom: add RPMH communication support
To:     Raju P L S S S N <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>
Cc:     David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 18, 2018 at 6:37 AM, Raju P L S S S N
<rplsssn@codeaurora.org> wrote:
> From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>

[ ... ]

> This set of patches add the ability for platform drivers to make use of shared
> resources in newer Qualcomm SoCs like SDM845. Resources that are shared between
> multiple processors in a SoC are generally controlled by a dedicated remote
> processor. The remote processor (Resource Power Manager or RPM in previous QCOM
> SoCs) receives requests for resource state from other processors using the
> shared resource, aggregates the request and applies the result on the shared
> resource. SDM845 advances this concept and uses h/w (hardened I/P) blocks for
> aggregating requests and applying the result on the resource. The resources
> could be clocks, regulators or bandwidth requests for buses. This new
> architecture is called RPM-hardened or RPMH in short.
>
> Since this communication mechanism is completely hardware driven without a
> processor intervention on the remote end, existing mechanisms like RPM-SMD are
> no longer useful. Also, there is no serialization of data or is data is written
> to a shared memory in this new format. The data used is different, unsigned 32
> bits are used for representing an address, data and header. Each resource's
> property is a unique u32 address and have pre-defined set of property specific
> valid values. A request that comprises of <header, addr, data> is sent by
> writing to a set of registers from Linux and transmitted to the remote slave
> through an internal bus. The remote end aggregates this request along with
> requests from other processors for the <addr> and applies the result.
>
> The hardware block that houses this functionality is called Resource State
> Coordinator or RSC. Inside the RSC are set of slots for sending RPMH requests
> called Trigger Commands Sets (TCS). The set of patches are for writing the
> requests into these TCSes and sending them to hardened IP blocks.
>
> The driver design is split into two components. The RSC driver housed in
> rpmh-rsc.c and the set of library functions in rpmh.c that frame the request and
> transmit it using the controller. This first set of patches allow a simple
> synchronous request to be made by the platform drivers. Future patches will add
> more functionality that cater to complex drivers and use cases.
>
> Please consider reviewing this patchset.
>
> v1: https://www.spinics.net/lists/devicetree/msg210980.html
> v2: https://lkml.org/lkml/2018/2/15/852
> v3: https://lkml.org/lkml/2018/3/2/801
> v4: https://lkml.org/lkml/2018/3/9/979
> v5: https://lkml.org/lkml/2018/4/5/480
> v6: https://lkml.org/lkml/2018/4/19/914
> v7: https://lkml.org/lkml/2018/5/2/779
> v8: https://lkml.org/lkml/2018/5/9/729
> v9: https://lkml.org/lkml/2018/5/24/530
> v10: https://lkml.org/lkml/2018/6/11/542
>
> Lina Iyer (10):
>   drivers: qcom: rpmh-rsc: add RPMH controller for QCOM SoCs
>   dt-bindings: introduce RPMH RSC bindings for Qualcomm SoCs
>   drivers: qcom: rpmh-rsc: log RPMH requests in FTRACE
>   drivers: qcom: rpmh: add RPMH helper functions
>   drivers: qcom: rpmh-rsc: write sleep/wake requests to TCS
>   drivers: qcom: rpmh-rsc: allow invalidation of sleep/wake TCS
>   drivers: qcom: rpmh: cache sleep/wake state requests
>   drivers: qcom: rpmh: allow requests to be sent asynchronously
>   drivers: qcom: rpmh: add support for batch RPMH request
>   drivers: qcom: rpmh-rsc: allow active requests from wake TCS
>
>  .../devicetree/bindings/soc/qcom/rpmh-rsc.txt      | 137 +++++
>  drivers/soc/qcom/Kconfig                           |  10 +
>  drivers/soc/qcom/Makefile                          |   4 +
>  drivers/soc/qcom/rpmh-internal.h                   | 114 ++++
>  drivers/soc/qcom/rpmh-rsc.c                        | 682 +++++++++++++++++++++
>  drivers/soc/qcom/rpmh.c                            | 512 ++++++++++++++++
>  drivers/soc/qcom/trace-rpmh.h                      |  82 +++
>  include/dt-bindings/soc/qcom,rpmh-rsc.h            |  14 +
>  include/soc/qcom/rpmh.h                            |  51 ++
>  include/soc/qcom/tcs.h                             |  56 ++
>  10 files changed, 1662 insertions(+)

I haven't reviewed every last line of this patch series but IMHO it's
been floating around for quite some time and it seems like it might be
wise to land it and then continue to make incremental improvements
atop it as needed.  What do others think of this plan?  This would
allow us to have functioning regulators / clocks on sdm845 atop this
driver which would unblock a lot of other stuff.

Note that to address a piece of review feedback from Stephen Boyd I've
posted <https://patchwork.kernel.org/patch/10472383/> atop this
series.  Assuming others like that, we should probably pick that too,
then we can land future patches that remove the boilerplate code from
the regulator and clock driver.

-Doug
