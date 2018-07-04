Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9874AC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D2B246FD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpMej0iV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D2B246FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933028AbeGDENV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 00:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932188AbeGDENT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 00:13:19 -0400
Received: from localhost (unknown [171.76.122.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E74246FD;
        Wed,  4 Jul 2018 04:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530677598;
        bh=FZlBqTwZeA19DyjwsC/ZKYnnrySiT64JMQrzErt6CUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FpMej0iVZPgfK2esx3tntzSgk044ftK3pKNvwxJPU0PCCED9qYdIFwUxlpQUAgwat
         SPQy8fy8jYaeQlelm/+LcV2I+Q7DrpL4VmwvrJlcLY4hJ8aB2wzCvl+8KV0e6CzYjk
         mFWX167EqqZfFSI1k2F/ixBeP5kAc3qk+/Hif3jU=
Date:   Wed, 4 Jul 2018 09:43:10 +0530
From:   Vinod <vkoul@kernel.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v3 6/6] crypto: qcom: Add ACPI support
Message-ID: <20180704041310.GV22377@vkoul-mobl>
References: <20180703060434.19293-1-vkoul@kernel.org>
 <20180703060434.19293-7-vkoul@kernel.org>
 <28000d33-5321-76af-7985-94a564a75336@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28000d33-5321-76af-7985-94a564a75336@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-07-18, 11:08, Jeffrey Hugo wrote:
> On 7/3/2018 12:04 AM, Vinod Koul wrote:

> > +#if IS_ENABLED(CONFIG_ACPI)
> > +static const struct acpi_device_id qcom_rng_acpi_match[] = {
> > +	{
> > +		.id = "QCOM8160",
> > +	},
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(acpi, msm_rng_acpi_match);
> 
> qcom_rng_acpi_match?
> Looks like a copy/paste issue.  This causes a build failure for me.
> I'm trying to see if it works otherwise...

Ah sorry about that, I though I had fixed it, looks like I missed to
fold the fix.

Did it work for you?

-- 
~Vinod
