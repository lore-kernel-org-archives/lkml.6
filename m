Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54293C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CA9206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546971131;
	bh=ycyEbDy7tDUV+zF8jQhABMpd4RbKVUFLuSCweXzfHaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vOmFFox0wBckjw0at0dVu3QmmwRLTPc/TI3dkk+LPUGT1MyMsG1or0roUYFgUdEyG
	 ej+ERpSTbbi0hPTt4FILHVdl6h1uFC34xXTlZNoz+P2sXJOmexcyrNKpsVXyeGzjoH
	 rmyNGcIwwKBwYrCz0LzYOicf3NAq2gQHdfFdnvYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfAHSMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:12:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:50898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbfAHSMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:12:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACBC12070B;
        Tue,  8 Jan 2019 18:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546971128;
        bh=ycyEbDy7tDUV+zF8jQhABMpd4RbKVUFLuSCweXzfHaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLxsFTEEJO9uZtKk+KgSyZzUu20ijjxL/7tVvCbm2Sw3RYPugjdQosgCJFyv6HLUA
         H01J49FkWLqZUHIFcEkAWM+iS79TtZekj6iBn0uGk+p8bLKZCEbtsBdVJsvQg9/JbU
         fPjm2jRfH2aumEnuhyJgIWC1Bn+eeym9KWwdcbI8=
Date:   Tue, 8 Jan 2019 19:12:06 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     James Morse <james.morse@arm.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] EDAC: add ARM Cortex A15 L2 internal asynchronous
 error detection driver
Message-ID: <20190108181206.GA3848@kroah.com>
References: <AM6PR0702MB379953E130CC1E1DEE18B79BFA8A0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
 <20190108104204.GA14243@zn.tnic>
 <e1458b95-6d17-21be-5dd8-ee7ff8d8b3fb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1458b95-6d17-21be-5dd8-ee7ff8d8b3fb@arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 05:57:24PM +0000, James Morse wrote:
> >> diff --git a/drivers/edac/cortex_a15_l2_async_edac.c b/drivers/edac/cortex_a15_l2_async_edac.c
> >> new file mode 100644
> >> index 000000000000..26252568e961
> >> --- /dev/null
> >> +++ b/drivers/edac/cortex_a15_l2_async_edac.c
> >> @@ -0,0 +1,134 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (C) 2018 Nokia Corporation
> 
> (boiler plate not needed with the SPDX header)

Not true at all.  Copyright is not the same thing as an SPDX license
identifier in any way, shape, or form.  As-is, this is just fine.

Now I will not go into the issues where a "Copyright..." line really
means nothing at all anymore, as lawyers like to cargo-cult worse than
programmers do, so it's good to have those lines there just to make them
happy :)

thanks,

greg k-h
