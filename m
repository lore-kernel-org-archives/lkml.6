Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A166C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 04:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10FA20BF2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 04:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLWX4g3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10FA20BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeGKEMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 00:12:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbeGKEMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 00:12:07 -0400
Received: from localhost (unknown [49.207.53.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E41120BEC;
        Wed, 11 Jul 2018 04:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531282189;
        bh=KzKYSE+HQXqI7szvbBPQFvtFfyLPOVcUCBdY5Ml/8Y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cLWX4g3zv2w42a7BPWvThH5YNBxEBYFcNJejAgpLSyc9MAMehOQnBZIoqN16jO+wn
         NOCWHLyMYn+hxF1HdKORMKV3pZ4PrDPxdtvQrsVA+qOg0ron9Bn5YMcQn8NveQAu6t
         iMyDgBW0IBsuM/3YkKvkZV4mv47OdlyuhKKwCptc=
Date:   Wed, 11 Jul 2018 09:39:43 +0530
From:   Vinod <vkoul@kernel.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v5 6/6] crypto: qcom: Add ACPI support
Message-ID: <20180711040943.GJ3219@vkoul-mobl>
References: <20180709061925.20276-1-vkoul@kernel.org>
 <20180709061925.20276-7-vkoul@kernel.org>
 <2a678412-26d4-769e-ff6f-ace5d53e70b5@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a678412-26d4-769e-ff6f-ace5d53e70b5@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-07-18, 11:27, Jeffrey Hugo wrote:
> On 7/9/2018 12:19 AM, Vinod Koul wrote:
> > From: Timur Tabi <timur@codeaurora.org>
> > 
> > Add support for probing on ACPI systems, with ACPI HID QCOM8160.
> > 
> > On ACPI systems, clocks are always enabled, the PRNG should
> > already be enabled, and the register region is read-only.
> > The driver only verifies that the hardware is already
> > enabled never tries to disable or configure it.
> > 
> > Signed-off-by: Timur Tabi <timur@codeaurora.org>
> > [port to crypto API]
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> 
> Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>

Thanks Jeffrey.

-- 
~Vinod
