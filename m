Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1C4C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC6E2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHXOL5aE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC6E2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeLELuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:50:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:39412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbeLELuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:50:39 -0500
Received: from localhost (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84BB42082B;
        Wed,  5 Dec 2018 11:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544010639;
        bh=HiQaNxvdlv7UAs/OzeVYTHyUmBpW2uh+3BfD45ijsUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mHXOL5aE3e8P8JxaURT0xOC5QnUFG8Nb4PLfXdnfQlbESnr6HzKK89Tmt/OS9r+Tl
         3e1QIL4KX6PIQ56Su4MxvKNS7NfP144aaShbdlOukJFKgnDVtCy4TWvrrDo2ooOL27
         x8PpkcBFaoczA/INiQlei++OmdwkzAjRm8B7yMDI=
Date:   Wed, 5 Dec 2018 06:50:33 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 002/123] spi: uniphier: fix incorrect
 property items
Message-ID: <20181205115033.GA1992@sasha-vm>
References: <20181205093555.5386-1-sashal@kernel.org>
 <20181205093555.5386-2-sashal@kernel.org>
 <20181205113820.GB6205@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181205113820.GB6205@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 11:38:20AM +0000, Mark Brown wrote:
>On Wed, Dec 05, 2018 at 04:33:54AM -0500, Sasha Levin wrote:
>> From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
>>
>> [ Upstream commit 3511ba7d4ca6f39e2d060bb94e42a41ad1fee7bf ]
>>
>> This commit fixes incorrect property because it was different
>> from the actual.
>> The parameters of '#address-cells' and '#size-cells' were removed,
>> and 'interrupts', 'pinctrl-names' and 'pinctrl-0' were added.
>
>Not sure we should be backporting documentation changes like this to
>stable, especially not without accompanying code changes...

Dropped, thank you.

--
Thanks,
Sasha
