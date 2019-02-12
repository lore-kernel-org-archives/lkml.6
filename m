Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B05C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50244222BE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lpecQ634"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfBLXcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:32:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53762 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729398AbfBLXcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 18:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aMVLouYIhbmpAd2Yv4R1qNXiKROvi/qGYmK7GAWsdz4=; b=lpecQ634nXwlWT8lgDtfqYLYk
        +SKSp+p9OnB9WWBFZpChYvTXq5OWyGkUqJK+TfdcgoOBrAU6xVBqlWssB4AZFXedpZJAinEDzbI7V
        lXzEoe2lOQi70ImU4Y//OW/yXWcw4mxxBi/pcDh6AGCnElATsslSgZmiRvwh9ki+gahq0hOiQTuvI
        qxAiguvLSw4+22dLapykKU0kxdMhkJsw7Kgbipii0NdTiJcop78VtEA3u2HevLR9oG9FJhdbqYQAV
        De2xCCB3LTGN4EG89VVYEGPCS9w3J28alCEDYpqAwTg8yPjJ5mEzHhsGxEYj4EbiQbSkqyEQ8/E2p
        obMcmU9Vw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gthWx-0003tW-Ou; Tue, 12 Feb 2019 23:32:01 +0000
Subject: Re: linux-next: Tree for Feb 12 (chrome/wilco_ec/)
To:     Nick Crews <ncrews@chromium.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>
References: <20190212175059.1ea4c16c@canb.auug.org.au>
 <94edf49b-6b37-2dac-a2db-ad454b105fd1@infradead.org>
 <CAHX4x87=Myx45wBYtFY=rwz8jVmYY-tYVQjnzod-V8HaWJSy+g@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <341fc51d-aa50-6f8e-1c03-e6a0edfe4905@infradead.org>
Date:   Tue, 12 Feb 2019 15:31:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAHX4x87=Myx45wBYtFY=rwz8jVmYY-tYVQjnzod-V8HaWJSy+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 3:26 PM, Nick Crews wrote:
> Hi Randy,
> 
> This looks like we have a bad dependency structure in our Kconfig. I'll figure it out, and then where should I send the patch?

AFAICT, all drivers/platform/chrome/ patches go to its maintainers (& to
linux-kernel@vger.kernel.org):

CHROME HARDWARE PLATFORM SUPPORT
M:	Benson Leung <bleung@chromium.org>
M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
S:	Maintained
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
F:	drivers/platform/chrome/


> Nick
> 
> On Tue, Feb 12, 2019 at 9:44 AM Randy Dunlap <rdunlap@infradead.org <mailto:rdunlap@infradead.org>> wrote:
> 
>     On 2/11/19 10:50 PM, Stephen Rothwell wrote:
>     > Hi all,
>     >
>     > Changes since 20190211:
>     >
> 
> 
>     on i386 or x86_64:
> 
>     ld: drivers/platform/chrome/wilco_ec/core.o: in function `wilco_ec_remove':
>     core.c:(.text+0x46): undefined reference to `cros_ec_lpc_mec_destroy'
>     ld: drivers/platform/chrome/wilco_ec/core.o: in function `wilco_ec_probe':
>     core.c:(.text+0x285): undefined reference to `cros_ec_lpc_mec_init'
>     ld: core.c:(.text+0x39a): undefined reference to `cros_ec_lpc_mec_destroy'
>     ld: drivers/platform/chrome/wilco_ec/mailbox.o: in function `wilco_ec_transfer':
>     mailbox.c:(.text+0x26): undefined reference to `cros_ec_lpc_io_bytes_mec'
>     ld: mailbox.c:(.text+0x47): undefined reference to `cros_ec_lpc_io_bytes_mec'
>     ld: mailbox.c:(.text+0x242): undefined reference to `cros_ec_lpc_io_bytes_mec'
> 
> 
>     Full randconfig file is attached.
> 
>     -- 
>     ~Randy
> 


-- 
~Randy
