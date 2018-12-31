Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39015C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 14:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0105821783
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 14:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546264965;
	bh=3x9mb5ryyL1feNZb/qDAjW6KrqqmuXGogkdLD6HHPc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V1gkP8F3WZBMB53VQyL9N7tGhWB3l678CgS+3xtVMVn1tm+PfdbP1qXn+O3o/ADxG
	 WzcRF2JA+gjSBL6roEYMXAsv9NWFqvwH1yi7rxif1VdRLVSRcQd77YnBVH9Q6/YG2Y
	 zJ9uyNY9dJxdCss7hNMMqA8oUiUUqfQ+p0y11JCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbeLaOCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 09:02:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:52438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbeLaOCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 09:02:42 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D44AF2133F;
        Mon, 31 Dec 2018 14:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546264961;
        bh=3x9mb5ryyL1feNZb/qDAjW6KrqqmuXGogkdLD6HHPc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nTCBreADI6qK66uizn9o2B+KcJPDfSHKx1L8kXSjtu/vOWaRuQl0dH4OLe5wYPTx2
         P2klI+1TLwaECstF5wKfGvcuYGjt86IzBliTOfM9QophxK0OV4p5RRRHdBRQLLNBR1
         YZT2J6IkNzuwT87QUs8l0JoOLulI3wte0x+dFwFE=
Date:   Mon, 31 Dec 2018 19:31:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>, Peng Ma <peng.ma@nxp.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sinan Kaya <okaya@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Theodore Ts'o <tytso@mit.edu>, Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wen He <wen.he_1@nxp.com>, Palmer Dabbelt <palmer@sifive.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: linux-next: Tree for Dec 21
Message-ID: <20181231140102.GC7581@vkoul-mobl>
References: <20181221193244.3a6ed685@canb.auug.org.au>
 <20181221162149.GA32500@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221162149.GA32500@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-12-18, 08:21, Guenter Roeck wrote:
> On Fri, Dec 21, 2018 at 07:32:44PM +1100, Stephen Rothwell wrote:

> [6]:
> 
> Build failure.
> 
> # bad: [340ae71f9dd421227a58c14a909b63033745dca4] Add linux-next specific files for 20181221
> # good: [7566ec393f4161572ba6f11ad5171fd5d59b0fbd] Linux 4.20-rc7
> git bisect start 'HEAD' 'v4.20-rc7'
> # good: [9f3de88514b2b5666214f0be3bc98d4e7136a7f1] Merge remote-tracking branch 'mtd/mtd/next'
> git bisect good 9f3de88514b2b5666214f0be3bc98d4e7136a7f1
> # good: [f4dd556a2cc77f672b9ba585aaad094a6fe09cf7] Merge remote-tracking branch 'spi/for-next'
> git bisect good f4dd556a2cc77f672b9ba585aaad094a6fe09cf7
> # good: [75f0840128c421df5e1741f5df22a34409bb5d72] Merge remote-tracking branch 'char-misc/char-misc-next'
> git bisect good 75f0840128c421df5e1741f5df22a34409bb5d72
> # bad: [4faff5eba474594068ea7f4542af209ab3e66911] Merge remote-tracking branch 'scsi/for-next'
> git bisect bad 4faff5eba474594068ea7f4542af209ab3e66911
> # good: [e894075934a44ef66413fd1046808542011d8552] staging: mt7621-mmc: Fix incompletely removed #if 0 block in sd.c
> git bisect good e894075934a44ef66413fd1046808542011d8552
> # good: [c1b104755b0b11579e292aa153c0605264c81648] scsi: smartpqi: add support for huawei controllers
> git bisect good c1b104755b0b11579e292aa153c0605264c81648
> # good: [695e62f9d1350169ed2bb6c5f164a6a1b1aaae50] Merge remote-tracking branch 'icc/icc-next'
> git bisect good 695e62f9d1350169ed2bb6c5f164a6a1b1aaae50
> # bad: [2b4b64840d7f6929213c0abce72eec7b7b784949] Merge branch 'topic/fsl' into next
> git bisect bad 2b4b64840d7f6929213c0abce72eec7b7b784949
> # good: [c03ec9cbc1c18058d5175998dffec24e40cb709f] Merge branch 'topic/dw' into next
> git bisect good c03ec9cbc1c18058d5175998dffec24e40cb709f
> # good: [1fa4ce0b2caccfd5fb0a37a03cade2ee1dbb0452] Merge branch 'topic/dmatest' into next
> git bisect good 1fa4ce0b2caccfd5fb0a37a03cade2ee1dbb0452
> # good: [531971231dac0edf17af32b06f09681f6506c0a1] dmaengine: sprd: Add me as one of the module authors
> git bisect good 531971231dac0edf17af32b06f09681f6506c0a1
> # bad: [b1bd47b638d4d304b98f68abfee9ee897c1a1939] dt-bindings: fsl-qdma: Add NXP Layerscpae qDMA controller bindings
> git bisect bad b1bd47b638d4d304b98f68abfee9ee897c1a1939
> # bad: [68997fff94afa51b5f74dd90aceec74ce13b3253] dmaengine: fsldma: Adding macro FSL_DMA_IN/OUT implement for ARM platform
> git bisect bad 68997fff94afa51b5f74dd90aceec74ce13b3253
> # good: [ca4f826040111c6746e2378dc45d9c0af3991a09] dmaengine: fsldma: Replace DMA_IN/OUT by FSL_DMA_IN/OUT
> git bisect good ca4f826040111c6746e2378dc45d9c0af3991a09
> # first bad commit: [68997fff94afa51b5f74dd90aceec74ce13b3253] dmaengine: fsldma: Adding macro FSL_DMA_IN/OUT implement for ARM platform

Dropping these

-- 
~Vinod
