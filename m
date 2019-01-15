Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D31C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4350620645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547574232;
	bh=F5g0m1FjNxGCGlJ1/nYqQv6oCvm1jvy2NdDg9MKYOlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yYWe6RjY5OBih6KZoiK9upVE4DolSP0AJdEJOpLh8gJNlrIm8BQkVCSBfuL7hgQYA
	 JKUA979NzNmwfwnkDM89kbBbJYmAB00pBrWJhkGeoppAgKSbapWBMWAzKSyqDpG/L6
	 qzU0FrLyS1DEaoIQUVkfsPZSJcYogTpw/vVjC8gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbfAORnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:43:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:58220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbfAORnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:43:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADA0E20645;
        Tue, 15 Jan 2019 17:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547574229;
        bh=F5g0m1FjNxGCGlJ1/nYqQv6oCvm1jvy2NdDg9MKYOlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCRH09RK/GbcmkrvYSVceR4ipncE4Ap/A7hRVj2qow/fZ80JmHZDOe6bLjD7K6G5u
         nMuR3V3IwfAanBKP6jGWsySRBninuD6divaFQPh3xXHG9QkUtEVRkObHhot9YI97/k
         fYrM+eeHQ7JojxCMyB+0f1Abp5glH2F3RkNii71Y=
Date:   Tue, 15 Jan 2019 18:43:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     George Hilliard <thirtythreeforty@gmail.com>
Cc:     devel@driverdev.osuosl.org, NeilBrown <neil@brown.name>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: Mediatek: Use individual config flags in
 Makefile
Message-ID: <20190115174346.GA11832@kroah.com>
References: <20190115172009.GB30853@kroah.com>
 <20190115172916.26937-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190115172916.26937-1-thirtythreeforty@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:29:18AM -0700, George Hilliard wrote:
> These drivers can be useful on other MT76xx SoCs, which have compatible
> peripherals.  The drivers were selectable in Kconfig, but they were
> quietly excluded from the build because the SOC_MT7621 chip was not
> selected.  So, make the Makefiles use the same flags as Kconfig for
> these drivers.
> 
> mt7621-dma and mt7621-dts are left alone because they truly do require
> that SoC.
> 
> I have personally confirmed that the mt7621-spi driver works on the
> MT7688, which was what prompted this change.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: devel@driverdev.osuosl.org
> Cc: NeilBrown <neil@brown.name>
> Cc: sergio.paracuellos@gmail.com
> Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
> ---
> Changes in v2..v4:
>   - Also use individual flags for mt7621-pci and the new mt7621-pci-phy
>   - Slightly revise commit message

You also rebased this patch, right?

Anyway, applying this patch, I get the following build error:

  CC [M]  drivers/staging/mt7621-mmc/sd.o
  CC [M]  drivers/staging/mt7621-mmc/dbg.o
drivers/staging/mt7621-mmc/sd.c:48:10: fatal error: asm/mach-ralink/ralink_regs.h: No such file or directory
 #include <asm/mach-ralink/ralink_regs.h>
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.build:277: drivers/staging/mt7621-mmc/sd.o] Error 1
make[3]: *** Waiting for unfinished jobs....
drivers/staging/mt7621-mmc/dbg.c: In function ‘msdc_debug_proc_write’:
drivers/staging/mt7621-mmc/dbg.c:237:12: warning: unused variable ‘size’ [-Wunused-variable]
  int mode, size;
            ^~~~
drivers/staging/mt7621-mmc/dbg.c:237:6: warning: unused variable ‘mode’ [-Wunused-variable]
  int mode, size;
      ^~~~
make[2]: *** [scripts/Makefile.build:492: drivers/staging/mt7621-mmc] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [scripts/Makefile.build:492: drivers/staging] Error 2
make[1]: *** Waiting for unfinished jobs....

So I can't take this patch as is, sorry.

Please fix.

thanks,

greg k-h
