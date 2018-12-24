Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23E4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A0B218D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545639651;
	bh=7nTD/VmCGxv8j1N3pMXBHDnrt1z7geoIlhxxNJx+Hi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uQzpLL82pIQntBi0o6sq81O8pTTEOqOmXrmrpWz9D+yja8Nhms1XFSHcYLwFN9c5A
	 JkNHxVpIREbYQ/jJOJECSjaM9VEqbQD4TPrEt3jEx7mOiATJ3i9KBwlfDvjf8UILq8
	 wZ6DtOOjbGE/x9X/L1lc7/5z/lZtrlFbQQzNpuyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeLXIUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:20:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbeLXIUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:20:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E7F02171F;
        Mon, 24 Dec 2018 08:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545639649;
        bh=7nTD/VmCGxv8j1N3pMXBHDnrt1z7geoIlhxxNJx+Hi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JWL+qSWKztne1JWsnuF/FABQjwyXBsuHdo/iASK7YAzli1+Ub2jo/McnTt+1brke3
         jrxgSdQ/RqKFFat0+2/hF1qb20nrbpDyZ/GLeslcqroD8Z5WVH0CNgEuM6yzKiryJV
         FBu84TrQAv0sml2tZkj2aihGiOJPFajoG1kCNyQQ=
Date:   Mon, 24 Dec 2018 09:20:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
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
        Wen He <wen.he_1@nxp.com>, Peng Ma <peng.ma@nxp.com>,
        Vinod Koul <vkoul@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: linux-next: Tree for Dec 21
Message-ID: <20181224082046.GD19684@kroah.com>
References: <20181221193244.3a6ed685@canb.auug.org.au>
 <20181221162149.GA32500@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221162149.GA32500@roeck-us.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 08:21:49AM -0800, Guenter Roeck wrote:
> ---
> [5]:
> 
> The bisect is old, but still applies. Revering the offending patch fixes the problem.
> 
> # bad: [8c9733fd9806c71e7f2313a280f98cb3051f93df] Add linux-next specific files for 20181123
> # good: [9ff01193a20d391e8dbce4403dd5ef87c7eaaca6] Linux 4.20-rc3
> git bisect start 'HEAD' 'v4.20-rc3'
> # good: [34c2101b4f765edf1b91c2837da9c60fbf9f6912] Merge remote-tracking branch 'spi-nor/spi-nor/next'
> git bisect good 34c2101b4f765edf1b91c2837da9c60fbf9f6912
> # good: [15367a0657fc8027ff3466bf0202bde9f270259b] Merge remote-tracking branch 'kgdb/kgdb-next'
> git bisect good 15367a0657fc8027ff3466bf0202bde9f270259b
> # bad: [d29686ab179c34c5dbaac067a9effbeeb6a8073e] Merge remote-tracking branch 'soundwire/next'
> git bisect bad d29686ab179c34c5dbaac067a9effbeeb6a8073e
> # good: [7cd63670817c236ccaf21ffe9d7b4921afeab130] Merge remote-tracking branch 'tip/auto-latest'
> git bisect good 7cd63670817c236ccaf21ffe9d7b4921afeab130
> # good: [597140853698c0dc174b93eb534406a40e467375] Merge remote-tracking branch 'rcu/rcu/next'
> git bisect good 597140853698c0dc174b93eb534406a40e467375
> # good: [acb97a35ae6d363144f4e3916bff5284a5a03d01] Merge remote-tracking branch 'phy-next/next'
> git bisect good acb97a35ae6d363144f4e3916bff5284a5a03d01
> # bad: [3f45b9087678824f50a34783db5a519f0d4d5e03] Merge remote-tracking branch 'tty/tty-next'
> git bisect bad 3f45b9087678824f50a34783db5a519f0d4d5e03
> # good: [61e169ee7683630ee0276dd5dcb5599976757770] serial: fsl_lpuart: fix the typo: UARTCR1_PE -> UARTCTRL_PE
> git bisect good 61e169ee7683630ee0276dd5dcb5599976757770
> # good: [646097940ad35aa2c1f2012af932d55976a9f255] serial: set suppress_bind_attrs flag only if builtin
> git bisect good 646097940ad35aa2c1f2012af932d55976a9f255
> # bad: [d6e1935819db0c91ce4a5af82466f3ab50d17346] serial: core: Allow processing sysrq at port unlock time
> git bisect bad d6e1935819db0c91ce4a5af82466f3ab50d17346
> # bad: [6d11023c345e369bcb9d5a68b271764e362c1f6e] serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250
> git bisect bad 6d11023c345e369bcb9d5a68b271764e362c1f6e
> # good: [347a28b586802d09604a149c1a1f6de5dccbe6fa] writeback: don't decrement wb->refcnt if !wb->bdi
> git bisect good 347a28b586802d09604a149c1a1f6de5dccbe6fa
> # first bad commit: [6d11023c345e369bcb9d5a68b271764e362c1f6e] serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250

Ok I have now reverted this patch, hopefully that resolves the issue.

thanks, and sorry it took this long to revert.

greg k-h
