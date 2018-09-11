Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B52CC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F981206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F981206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeIKPeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:34:03 -0400
Received: from foss.arm.com ([217.140.101.70]:41882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbeIKPeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:34:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B9B17A9;
        Tue, 11 Sep 2018 03:35:19 -0700 (PDT)
Received: from e107155-lin (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79EA53F557;
        Tue, 11 Sep 2018 03:35:17 -0700 (PDT)
Date:   Tue, 11 Sep 2018 11:35:09 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        robert.walker@arm.com, devicetree@vger.kernel.org, robh@kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pierlisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] dts: juno: Enable coresight tmc scatter gather in ETR
Message-ID: <20180911103509.GA770@e107155-lin>
References: <1536655641-26192-1-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536655641-26192-1-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/18 09:47, Suzuki K Poulose wrote:
> We do not enable scatter-gather mode in the TMC-ETR by default
> to prevent malfunctioning of systems where the ETR may not be
> properly connected to the memory subsystem to allow for simultaneous
> READ/WRITE transactions when used in SG mode. Instead we whitelist
> the platforms where we know that it is safe to use the mode.
>
> All revisions of Juno have a proper ETR connection and hence
> white list them.
>

Applied conditionally, this conflicts with the patch Mathieu has in his
branch. He needs to drop that so that I can take both of them via ARM SoC.

--
Regards,
Sudeep
