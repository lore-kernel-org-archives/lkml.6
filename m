Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B1FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E8E21927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="Yr6IWAM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbfBORuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:50:20 -0500
Received: from smtp113.ord1d.emailsrvr.com ([184.106.54.113]:57640 "EHLO
        smtp113.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729662AbfBORuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:50:19 -0500
Received: from smtp7.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
        by smtp7.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id 859BCC0402;
        Fri, 15 Feb 2019 12:43:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1550252614;
        bh=wI/1eLUIde9SYRNhrA2BCK1wURzJgUWYA5bGQdSo318=;
        h=Subject:To:From:Date:From;
        b=Yr6IWAM4pVvYSBacrTIdbFUH23MyTbNm2tfu8Z506h2/eLBK6LCDQwji/p7g6zBVr
         Cm8+em4mRIDGGCgpqwQSx6dUOhxcqgCWy4APSH48l7qJIGXXCvHn7jFw1fDRFcOQ5r
         FwMTgj7qdzgTVWm7c/JrpeW7590MTeHuvLefTVlc=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp7.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id BFCA9C045A;
        Fri, 15 Feb 2019 12:43:33 -0500 (EST)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.185] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 15 Feb 2019 12:43:34 -0500
Subject: Re: [PATCH] staging: comedi: ni_660x: fix missing break in switch
 statement
To:     Sasha Levin <sashal@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20190212180834.GA30653@embeddedor>
 <20190215154828.DE5DF222A1@mail.kernel.org>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <882253b4-10e0-0343-37d8-a97ffca0b4c5@mev.co.uk>
Date:   Fri, 15 Feb 2019 17:43:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190215154828.DE5DF222A1@mail.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2019 15:48, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: 58dd7c0a2a6e Staging: comedi: add ni_660x driver.
> 
> The bot has tested the following trees: v4.20.8, v4.19.21, v4.14.99, v4.9.156, v4.4.174, v3.18.134.
> 
> v4.20.8: Build OK!
> v4.19.21: Build OK!
> v4.14.99: Build OK!
> v4.9.156: Build OK!
> v4.4.174: Failed to apply! Possible dependencies:
>      01ead0ded315 ("staging: comedi: ni_660x: cleanup the NI660X_IO_CFG register helpers")
>      22acd860137a ("staging: comedi: ni_660x: change IOConfigReg() into a macro")
>      41014593caeb ("staging: comedi: ni_660x: cleanup the NI660X_GLOBAL_INT_{STATUS, CFG}")
>      502552e161ae ("staging: comedi: ni_660x: remove enum clock_config_register_bits")
>      518d38423b48 ("staging: comedi: ni_660x: tidy up ni_660x_select_pfi_output()")
>      9678b73e273a ("staging: comedi: ni_660x: tidy up ni_660x_write_register()")
>      aa94f2888825 ("staging: comedi: ni_660x: tidy up ni_660x_set_pfi_routing()")
>      ad98c18cb9de ("staging: comedi: ni_660x: tidy up ni_660x_read_register()")
>      cded944fa90c ("staging: comedi: ni_660x: Prefer kernel type 'u64' over 'uint64_t'")
>      fecf4cce0021 ("staging: comedi: ni_660x: cleanup the NI660X_DMA_CFG register helpers")
> 
> v3.18.134: Failed to apply! Possible dependencies:
>      01ead0ded315 ("staging: comedi: ni_660x: cleanup the NI660X_IO_CFG register helpers")
>      22acd860137a ("staging: comedi: ni_660x: change IOConfigReg() into a macro")
>      41014593caeb ("staging: comedi: ni_660x: cleanup the NI660X_GLOBAL_INT_{STATUS, CFG}")
>      502552e161ae ("staging: comedi: ni_660x: remove enum clock_config_register_bits")
>      518d38423b48 ("staging: comedi: ni_660x: tidy up ni_660x_select_pfi_output()")
>      9678b73e273a ("staging: comedi: ni_660x: tidy up ni_660x_write_register()")
>      aa94f2888825 ("staging: comedi: ni_660x: tidy up ni_660x_set_pfi_routing()")
>      ad98c18cb9de ("staging: comedi: ni_660x: tidy up ni_660x_read_register()")
>      cded944fa90c ("staging: comedi: ni_660x: Prefer kernel type 'u64' over 'uint64_t'")
>      fecf4cce0021 ("staging: comedi: ni_660x: cleanup the NI660X_DMA_CFG register helpers")
> 
> 
> How should we proceed with this patch?

Hi Sasha, the bug was introduced in v4.7 and hasn't been backported to 
any earlier stable kernels, so no need to do anything for v4.4.x or v3.18.x.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
