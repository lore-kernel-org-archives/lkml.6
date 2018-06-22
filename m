Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9DDC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF3224665
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X3uV005w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF3224665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754798AbeFVRFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:05:36 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35099 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754681AbeFVRF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:05:27 -0400
Received: by mail-pl0-f66.google.com with SMTP id k1-v6so3777875plt.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oojYCtlqfGgofVAl4JUaUHBzV145OsUX15+f0Wh1s6s=;
        b=X3uV005wF1fZa94HepkH+zj6lren+50DhjccLw6XMha6NndH/fvKW5f8ofiyKCN5gA
         tAmScptxJ6nC7mLwoMQ9R16Q6R7WEJDya9hLA1tZikDPElQMsHcMmUWytFeNDHMwHjFt
         8AwG2LhUrsFo39FbwMdxWwN1qtSx4vyyhM47Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oojYCtlqfGgofVAl4JUaUHBzV145OsUX15+f0Wh1s6s=;
        b=fcdZQPsDdbK32uO06PeUV742fJZBp+wd0b45wE0+QW4H9N/khXnzUZERJwbhh5LQu7
         WCaCze/E2Tl/vmhTa3N6C2pdxFFWB+dOiN0PKyXU/yB9ymYdi+IFjwmto6UF2h3ipQG5
         G9aohjFcoTxqrP4IpQtwwkE/gVwM576Le3ClWuw5GS6UvaeTsVV6U4zFiE9hIUrIwJg4
         H7feC/EF13kTDiJ531MvZOJHt4zjWVx25WqrmSWY9cMUD0IVwihucQVd/AWfzqJJ+ggV
         H850Q5tv8+0Aj4c0l8BDksWW60017YcDCqLJ6pdqfAzCTVqmKaYS64VZlDjdtnEnfHfx
         triQ==
X-Gm-Message-State: APt69E1Z8ECFWbPp+hZacdV7MthFksmhI6EnccjmQXPSnNuMvziXvrJn
        2xMwNLBvbUYGRw46v2j5aH9gAA==
X-Google-Smtp-Source: ADUXVKK1j2JBXmC8nWYwrVGXri1DHYEgyMW3nfmMrgAS6+p6l60gNFAGVJXPVR0c7yNILe2QkRY1Vw==
X-Received: by 2002:a17:902:22:: with SMTP id 31-v6mr2555032pla.332.1529687126415;
        Fri, 22 Jun 2018 10:05:26 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k10-v6sm22130712pfj.29.2018.06.22.10.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 10:05:25 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:05:23 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Raju P L S S S N <rplsssn@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, ilina@codeaurora.org
Subject: Re: [PATCH v13 00/10] drivers/qcom: add RPMH communication support
Message-ID: <20180622170523.GG10336@builder>
References: <1529501227-27163-1-git-send-email-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529501227-27163-1-git-send-email-rplsssn@codeaurora.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20 Jun 06:26 PDT 2018, Raju P L S S S N wrote:

> From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
> 

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Changes in v13:
> - Add missing Signed-off-by in commit text 
> 
> Changes in v12:
> - Rename ctrlr to client in rsc_drv
> - Fix Bot reported errors - 'err' may be used uninitialized
> - Rebase on top of v4.18-rc1 
> 
> Changes in v11:
> - move rpmh_request to rpmh-internal.h
> - Associate rpmh_ctrl to rsc_drv
> - Remove EXPORT_SYMBOL for rpmh_tx_done
> - Remove IS_ERR check for ctrlr
> - Remove rsc_drv instance from rpmh_ctrlr
> - Initialize cache & batch cache in probe
> 
> Changes in v10:
> - Remove export.h inclusion as suggested by Doug
> - Remove rsc_drv_list
> - Add EXPORT_SYMBOL
> - Remove wait_count as suggested by Doug
> - Free memory if cache_batch returns error as suggested by Doug
> - Add batch requests to list and simplify error handling as
> - return ERR_PTR if invalidate fails
> 
> Changes in v9:
> - Remove EXPORT_SYMBOL as suggested by Doug
> - Add Reviewed-by tags
> - Rename lock variable as suggested by Doug
> - Add WARN_ON if completion timeout occurs as suggested by Doug
> - Fix the bound checks as suggested by Matthias
> - Improve comments as suggested by Doug
> - Add check for freeing dynamically allocated request object
> - Rename label as suggested by Doug
> - Fix IS_ERR_OR_NULL check to IS_ERR as suggested by Doug
> - Add check to call rpmh_rsc_invalidate if -EAGAIN is retured
>   as suggested by Doug
> 
> Changes in v8:
> - Bounds check for cmd_cache
> - Describe interrupts to other DRVs in DT bindings
> - Rebase on top of 4.17-rc3
> 
> Changes in v7:
> - Rename 'm' and 'n' and use tcs_id and cmd_id instead
> - Bug fix in find_match() and other review comments from Matthias
> - Spinlock around get_rpmh_ctrlr()
> - DT documentation example fixes
> - Rebase on top of 4.16-rc2
> 
> Changes in v6:
> - Remove tasklet in rpmh-rsc.c
> - Remove rpmh_client and use struct device * instead
> - Variable changes and bug fixes
> - DT binding changes to describe all DRVs in the RSC
> - Documentation and comment fixes
> 
> Changes in v5:
> - Add Reviewed-by tags
> - Rebase on top of 4.16
> 
> Changes in v4:
> - Rename variables as suggested by Stephen and Evan
> - Lot of minor syntax and style fixes
> - Fix FTRACE compilation error
> - Improve doc comments and DT description
> 
> Changes in v3:
> - Address Steven's comments in FTRACE
> - Fix DT documentation as suggested by Rob H
> - Fix error handling in IRQ handler as suggested by Evan
> - Remove locks in rpmh_flush()
> - Improve comments
> 
> Changes in v2:
> - Added sleep/wake, async and batch requests support
> - Addressed Bjorn's comments
> - Private FTRACE for drivers/soc/qcom as suggested by Steven
> - Sparse checked on these patches
> - Use SPDX license commenting sytle
> 
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
> v11: https://lkml.org/lkml/2018/6/18/860
> v12: https://lkml.org/lkml/2018/6/19/535
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
>  drivers/soc/qcom/rpmh.c                            | 513 ++++++++++++++++
>  drivers/soc/qcom/trace-rpmh.h                      |  82 +++
>  include/dt-bindings/soc/qcom,rpmh-rsc.h            |  14 +
>  include/soc/qcom/rpmh.h                            |  51 ++
>  include/soc/qcom/tcs.h                             |  56 ++
>  10 files changed, 1663 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
>  create mode 100644 drivers/soc/qcom/rpmh-internal.h
>  create mode 100644 drivers/soc/qcom/rpmh-rsc.c
>  create mode 100644 drivers/soc/qcom/rpmh.c
>  create mode 100644 drivers/soc/qcom/trace-rpmh.h
>  create mode 100644 include/dt-bindings/soc/qcom,rpmh-rsc.h
>  create mode 100644 include/soc/qcom/rpmh.h
>  create mode 100644 include/soc/qcom/tcs.h
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
> 
