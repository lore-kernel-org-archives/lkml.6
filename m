Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57133C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 04:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20BB23D0B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 04:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuSOBEjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20BB23D0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751097AbeFVE2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 00:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751005AbeFVE15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 00:27:57 -0400
Received: from localhost (unknown [122.167.114.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D927023D0A;
        Fri, 22 Jun 2018 04:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529641676;
        bh=yVpGicJtV5lap3/IGg0wySoLxfLOSH0wEebOETA9+g4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZuSOBEjL22k0dGCcacZ17b1+CEDPVnAMepoZ26Cb70YvM+u5wAUxY6bdTUmc8i5gV
         SiF3eL8b7666Tc1ENctYLZGEGyCZmy85faKDuScJk9mOdlMkL+3dm+dHNrcaHy8DNu
         6A5pPE+XwkS2KaPXtxV9f3r5fapDpapwXdefa4aI=
Date:   Fri, 22 Jun 2018 09:57:47 +0530
From:   Vinod <vkoul@kernel.org>
To:     Timur Tabi <timur@codeaurora.org>
Cc:     linux-crypto@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2 0/2] hwrng: Add support for qcpm v2 hwrng
Message-ID: <20180622042747.GH27187@vkoul-mobl>
References: <20180619095430.26358-1-vkoul@kernel.org>
 <CAOZdJXUgYpLT=xMos4wKxMOTOZb8rV8is48YjGB8_9okZsuvhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOZdJXUgYpLT=xMos4wKxMOTOZb8rV8is48YjGB8_9okZsuvhQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-18, 10:17, Timur Tabi wrote:
> On Tue, Jun 19, 2018 at 4:54 AM, Vinod Koul <vinod.koul@linaro.org> wrote:
> > This series adds support for newer version of hwrng as found in
> > Qualcomm SoCs. To do that add new v2 compatible string and driver_data
> > values for v2.
> 
> It's amazing you're sending this now, because I also have a PRNG
> patchset that I'm sending out today that adds support for v2 chips on
> an ACPI platform.
> 
> I'll send my patches as-is, and we'll just have to work to resolve the
> merge conflicts.

I have checked the series.

I am not sure I follow that this is v2 and you read CONFIG register.
Apart from that other changes look mostly okay with few nitpicks :)

But there is a bigger concern raised by Herbert on this not being a true
RNG and thus should be moved to crypto/

I have the changes ready for that, I will test them later today and
share with you, ACPI addition should be easy on that driver

> I will probably need you to test my patches as my last day at Qualcomm
> is the 26th.

Sad to hear that and good luck in your new adventure

-- 
~Vinod
