Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468FDC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB87C205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KhbXJ0Yr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB87C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeIABEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:04:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35008 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbeIABEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:04:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id 7-v6so1012530pgf.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 13:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oTeayu3un/Z3tpqC30gqE+gol6mrrB821j07SLAgYO4=;
        b=KhbXJ0Yr7ACCsXxHumT7A8jYajZuCotXq7OKoT8yi+ag+1RfFoclu5KmAjsllXvwka
         RH4MaUh16d+YGJxu2kgAUn588DsNY4Zbe7W/7sKWjyC4Tdg1WSfJFQ5H6EUIlGsJtE3g
         NehKhX/1PO6rxF6mMhAOeqaBsWtfKwykA+ac8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oTeayu3un/Z3tpqC30gqE+gol6mrrB821j07SLAgYO4=;
        b=boRzY8Cs1atUoWKZ23PZtJcbYwObTEdfvZ9V/gzknHuQtfzrktlgyODJtoG+Lp6zeM
         aWnsoWNKrzYJOqnTOLMxVfEfK74KcxX8OraYAVEVbgHh7f5gK3iLMvsALLus3Y4WyAUa
         0lggmOKML8/KrX9zx5Eu2CDGkGQHNoKGmQdxFEdz0G9g8q35D7w7HuDAhUoHxzM6OlmJ
         td+M/4+1hNPKMjh3FeMKsa1gwo2g4e9TJdSakELc4G9GIq6fO1gfftrw4YzqgaZ2goCS
         TfgFpssszn7dC/ujpRUga8Qjg3ju6yKW6Ze4crF8X7PuzJlvQ3Dlw53kbgGz9YMWr5ji
         Skng==
X-Gm-Message-State: APzg51BNHKe2IWqPogA/MmTzSfTUjHRHv3N4hdT/lEH7lVsCq9Le/jOJ
        tqGppY6bXGLd+FGefrh1DQ7awQ==
X-Google-Smtp-Source: ANB0VdaBm+NjNCTo7l1vSu9/wal0Lr2XJw3IFheNjj+gYBhQDdmQo8uXCF5Dpj0ifjZTNaVuB9SYKA==
X-Received: by 2002:a63:6ce:: with SMTP id 197-v6mr15740918pgg.338.1535748922166;
        Fri, 31 Aug 2018 13:55:22 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d24-v6sm11810527pgv.23.2018.08.31.13.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 13:55:21 -0700 (PDT)
Date:   Fri, 31 Aug 2018 13:55:19 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: Re: [PATCH v3] rpmsg: qcom_smd: Access APCS through mailbox framework
Message-ID: <20180831205519.GS2523@minitux>
References: <20180420011757.22389-1-bjorn.andersson@linaro.org>
 <c6e2e87c-e2fd-c0ea-dbb9-5246b8694272@gmail.com>
 <20180831040701.GR2523@minitux>
 <e7af3589-dce5-2ea8-3ce0-258ced4a2302@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7af3589-dce5-2ea8-3ce0-258ced4a2302@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 31 Aug 13:41 PDT 2018, Frank Rowand wrote:

> On 08/30/18 21:07, Bjorn Andersson wrote:
> > On Thu 30 Aug 20:57 PDT 2018, Frank Rowand wrote:
> > 
> >> Hi Bjorn,
> >>
> >>
> >> On 04/19/18 18:17, Bjorn Andersson wrote:
> >>> Attempt to acquire the APCS IPC through the mailbox framework and fall
> >>> back to the old syscon based approach, to allow us to move away from
> >>> using the syscon.
> >>>
> >>> Reviewed-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
> >>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >>> ---
> >>>
> >>> Changes since v2:
> >>> - Added comment about mbox_send_message() return value.
> >>>
> >>>  .../devicetree/bindings/soc/qcom/qcom,smd.txt      |  8 ++-
> >>>  drivers/rpmsg/Kconfig                              |  1 +
> >>>  drivers/rpmsg/qcom_smd.c                           | 67 ++++++++++++++++------
> >>>  3 files changed, 56 insertions(+), 20 deletions(-)
> >>
> >> This patch in the mainline Linux kernel as commit ab460a2e72dabecfdabd45eb7e3ee2d73fc876d4
> >> causes a problem with the APQ8074 Dragonboard.  The mmc device is not set up
> >> with the patch applied, thus I do not have the block device my root file system
> >> is located on.
> >>
> >> Testing on v4.18, if I revert this commit the mmc device is available.
> >>
> >> I'll reply to this email with the console messages for 4.18 and for 4.18 with
> >> this commit reverted.
> >>
> > 
> > The mmc device would fail to come up if the regulators didn't come up,
> > which would be the result of smd not working. But it should fallback to
> > the old mechanism if no mailbox is specified.
> > 
> > Can you double check that CONFIG_RPMSG_QCOM_SMD is still set in your
> > .config after applying and building with this commit included? And if
> > not, try to enable CONFIG_MAILBOX.
> 
> Thank you!
> 
> That is indeed the cause.  ab460a2e72da added a "depends on MAILBOX" to
> CONFIG_RPMSG_QCOM_SMD, so CONFIG_RPMSG_QCOM_SMD becomes unset since
> CONFIG_MAILBOX is not enabled in qcom_defconfig and is not otherwise
> selected for the dragonboard.
> 

Thanks for verifying this!

> Is there a config variable that should be selecting MAILBOX for a class
> of systems that would include the APQ8074 Dragonboard?  For my testing
> I added the "select MAILBOX" to CONFIG_ARCH_MSM8974, but I do not know
> what systems that includes, and whether it is appropriate to do the
> select for all of them.
> 

We typically don't use the CONFIG_ARCH_* to enable user selectable
config options, even if they serve a critical role in the system.

So minimum change would be to add CONFIG_MAILBOX to the qcom_defconfig
(and multi_v7_defconfig I presume). The fuller solution would be to add
qcom,msm8974-apcs-kpss-global (.data is 8) to the qcom-apcs-ipc-mailbox
list of compatibles and replace the syscon currently used, and then
enable these in the defconfigs.

Regards,
Bjorn
