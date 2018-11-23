Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805B7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E14120865
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wZcgfLvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E14120865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502156AbeKWRek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 12:34:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393327AbeKWRek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 12:34:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAF4520685;
        Fri, 23 Nov 2018 06:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542955906;
        bh=Gnxi5So4Nawn40m7BcVmCbBtTtw3Y9cMqITZ2RxrscE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wZcgfLvD9Xm9yAR/KkW3Ybrr1DGJkf4b3oFVW3eaT0Yd/VN2Mtwde2K7Yh15a4hZm
         oyuKMJS/dFRPLDd+TFk+IHh5KY4Ueh5b0JyalQNdQJuXPyRie2aQ/kBfZgoek0PAJy
         fpGMxUQPHA1sEva6VVu26Eh0FHWeAQDiefnXU2wk=
Date:   Fri, 23 Nov 2018 07:51:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Voegtle <tv@lio96.de>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/42] 4.19.4-stable review
Message-ID: <20181123065143.GC23835@kroah.com>
References: <20181121183147.869199006@linuxfoundation.org>
 <alpine.LSU.2.21.1811222148260.12239@er-systems.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LSU.2.21.1811222148260.12239@er-systems.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 09:53:35PM +0100, Thomas Voegtle wrote:
> 
> Doesn't compile for me on OpenSuSE 15.0 (gcc 7.3.1):
> 
>   CALL    scripts/checksyscalls.sh
>   DESCEND  objtool
>   CHK     include/generated/compile.h
>   CC [M]  drivers/gpu/drm/i915/i915_gem_gtt.o
> drivers/gpu/drm/i915/i915_gem_gtt.c: In function ‘gen6_dump_ppgtt’:
> drivers/gpu/drm/i915/i915_gem_gtt.c:1771:41: error: format ‘%llx’ expects
> argument of type ‘long long unsigned int’, but argument 5 has type ‘long
> unsigned int’ [-Werror=format=]
>     seq_printf(m, "\t\t(%03d, %04d) %08llx: ",
>                                     ~~~~~^
>                                     %08lx
> cc1: all warnings being treated as errors

Warnings treated as errors?  That's rough, sorry, don't do that :)

I did see this, need to track it down, got distracted by other things...

thanks,

greg k-h
