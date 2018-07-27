Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7DBC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF8B208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="R84vw4aU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF8B208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388619AbeG0RnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:43:02 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:39100 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730510AbeG0RnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:43:02 -0400
Received: by mail-io0-f194.google.com with SMTP id o22-v6so4585142ioh.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 09:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DzwIaoBi5FScVR4kWAkUzcJlLG5TqlQmr14CoD+c6vo=;
        b=R84vw4aUfiZchFV+Vx0EJG8dmR4n8gmVzZyw9rTF2icRqbkpCFQRw7l1rtJuy7ntM0
         7EBxT6f1QN07kwctToG0sRF8F7bnzSyeljtKl1iurnbJE5gaPD2r6wbewTNStcmlfUrS
         JIi0S8l7BXcEYuJpEsZ4fyOAwxVwxP3NaTEvwP8mkWrUkEza6xWg6oHTc9wsNidFRYRk
         mDOj7oNHR9sqm0bIfpOAKdglqPlxPV1UZbWexk0eJQMlhqlixP6U1n3KpsHKrrVQ6UbL
         iONxi+bZV5SREuFWrqglayej/zWTsr3/CU54gw8ZOPqBd3aqxN6lzr3ysniHa2L2nECU
         xdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DzwIaoBi5FScVR4kWAkUzcJlLG5TqlQmr14CoD+c6vo=;
        b=NTrAO1LIt1WQhFv4/j/no4aDy9OtK8LNFuobFlfH8rjxYhsWpsid+SvpV89s4DY5TY
         ICc/m4hEyk4cvygW7YN0kG5KBCU3DYcsfM4GHlnSmAltioI04D50xdbI7qJ0XTn6Ebfx
         nrZVmEDkBuMP1SW1uMSTz1oggzZjMDP9qPd2w0l/Z3PnA6CdtR+Hh5pQ6QjGoPcuEnGc
         IJL5nN3VTg4wh23nfZbz8AvAWjExd7WPwmELruLxa1yLLwNRxKA7iloQHWRvRiIjzf2V
         R+/mu4foWdt60Rd9VO3VutttmdXbpxwRp2xAVbju2b5+Ll5OPDd9bTrcZofFl1LtN3AJ
         gdrw==
X-Gm-Message-State: AOUpUlFt481iJEpiR+LtAEkZNku9dj1dalh8zPSUSTFAEjmVLWLQ2o61
        aNn0/Eo+Qk9NJfvCCBbLNitFqA==
X-Google-Smtp-Source: AAOMgpfpfryGEh1IzEyrV6stSw5yRMHM8J9vSVkD9iA5fabdZwQtGV3DrGc1db8BzMXMGBH/gV3iRw==
X-Received: by 2002:a5e:d713:: with SMTP id v19-v6mr5583883iom.75.1532708424653;
        Fri, 27 Jul 2018 09:20:24 -0700 (PDT)
Received: from [192.168.43.158] ([172.58.139.52])
        by smtp.googlemail.com with ESMTPSA id c5-v6sm2342011itj.9.2018.07.27.09.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 09:20:24 -0700 (PDT)
Subject: Re: use the generic dma-noncoherent code for sh V2
To:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        iommu@lists.linux-foundation.org,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
References: <20180724120147.15096-1-hch@lst.de> <20180724202115.GA4685@lst.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <18df6608-61c1-963d-bb1a-d46320232f40@landley.net>
Date:   Fri, 27 Jul 2018 11:20:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180724202115.GA4685@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 03:21 PM, Christoph Hellwig wrote:
> On Tue, Jul 24, 2018 at 02:01:42PM +0200, Christoph Hellwig wrote:
>> Hi all,
>>
>> can you review these patches to switch sh to use the generic
>> dma-noncoherent code?  All the requirements are in mainline already
>> and we've switched various architectures over to it already.
>
> Ok, there is one more issue with this version.   Wait for a new one
> tomorrow.

Speaking of DMA:

I'm trying to wire up DMAEngine to an sh7760 board that uses platform data (and
fix the smc91x.c driver to use DMAEngine without #ifdef arm), so I've been
reading through all that stuff, but the docs seem kinda... thin?

Is there something I should have read other than
Documentation/driver-model/platform.txt,
Documentation/dmaegine/{provider,client}.txt, then trying to picking through the
source code and the sh7760 hardware pdf? (And watching the youtube video of
Laurent Pinchart's 2014 ELC talk on DMA, Maxime Ripard's 2015 ELC overview of
DMAEngine, the Xilinx video on DMAEngine...)

At first I thought the SH_DMAE could initialize itself, but the probe function
needs platform data, and although arch/sh/kernel/cpu/sh4a/setup-sh7722.c looks
_kind_ of like a model I can crib from:

A) "make ARCH=sh se7722_defconfig" results in a config with SH_DMA disabled??!?
(This is why I use miniconfig instead of defconfig format, I'm assuming that's
bit rot?)

B) That platform data is supplying sh_dmae_slave_config preallocating slave
channels to devices? (Does it have to? The docs gave me the impression the
driver would dynamically request them and devices could even share. Wasn't that
sort of the point of DMAEngine? Can my new board data _not_ do that? What's the
minimum amount of micromanaging I have to do?)

C) It's full of stuff like setting ts_low_shift to CHCR_TS_LOW_SHIFT where both
grepping Docuemntation and Google "dmaengine ts_low_shift" are unhelpful.

What I'd really like is a "hello world" version of DMAEngine somewhere I can
build and run on a supported qemu target, to set up _one_ channel with a block
device or something using it. I can't tell what's optional, or what the minimal
version of this looks like.

(Currently I've only managed to update this kernel to 4.14 because 4.15
introduced an intermittent data corruption bug in the flash, which takes long
enough to reproduce bisecting it is fiddly and ship deadlines are all blinky and
red. But next release should be current, _and_ with at least the 4.14 source
published so I can point people at it. Heck, maybe I can convince them to let me
port it to device tree next cycle, but I need to get it to _work_ first. And
doing PIO on a 100baseT controller, I.E. a ~200 mhz embedded CPU trying to copy
11 megabytes/second across a 16 bit bus with a for(;;) loop... bit of a
performance bottleneck even before you add https.)

Thanks,

Rob

>>
>> Changes since V1:
>>  - fixed two stupid compile errors and verified them using a local
>>    cross toolchain instead of the 0day buildbot
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> ---end quoted text---
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
