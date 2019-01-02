Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67604C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F878218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546423130;
	bh=JVfm0e9f8sFy8Aq8EufyMjb0tL8LaDz8ziMhZ229JWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nv88qzL626ueXvq/kqLsfsLq429NnClW5couZ8bJWQvKOMmEZ5PI/iDvy1KJs4jJ8
	 Yz5CrVnueLSruIn+t4a+OXcIuqSUu2bojqc5BGac5uio5eSQqXc1IqfjW62boiohxr
	 xNmptAg9fcSxETRHhph6H1I2jFJNzVRFLJADeR7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbfABJ6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:58:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728832AbfABJ6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:58:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D3B82171F;
        Wed,  2 Jan 2019 09:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546423127;
        bh=JVfm0e9f8sFy8Aq8EufyMjb0tL8LaDz8ziMhZ229JWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a5aToShWvv9rN3mb7+qhOO2FqNHESADVHO7LEhDNhfXE1Q9Lc+VVcMCm9r4m5kKpW
         4Bv8RvjlXh0dHoWrQdO9YPMqONJ5LqWT8YVKO29cZpsLvIMDJ165h9nlvKmV7h+rW6
         ETIFKAqdwKISyjkLiHRlGQrm0OOdr5jLjb9L03Q4=
Date:   Wed, 2 Jan 2019 10:58:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>
Subject: Re: [LKP] bea5b158ff BUG: kernel reboot-without-warning in
 boot-around-mounting-root stage
Message-ID: <20190102095844.GB14448@kroah.com>
References: <20190102011512.GF17624@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102011512.GF17624@shao2-debian>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 09:15:12AM +0800, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit bea5b158ff0da9c7246ff391f754f5f38e34577a
> Author:     Rob Herring <robh@kernel.org>
> AuthorDate: Thu Aug 11 10:20:58 2016 -0500
> Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CommitDate: Wed Aug 31 15:13:55 2016 +0200
> 
>     driver core: add test of driver remove calls during probe
>     
>     In recent discussions on ksummit-discuss[1], it was suggested to do a
>     sequence of probe, remove, probe for testing driver remove paths. This
>     adds a kconfig option for said test.
>     
>     [1] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2016-August/003459.html
>     
>     Suggested-by: Arnd Bergmann <arnd@arndb.de>
>     Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Signed-off-by: Rob Herring <robh@kernel.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> cebf8fd169  driver core: fix race between creating/querying glue dir and its cleanup
> bea5b158ff  driver core: add test of driver remove calls during probe
> e1ef035d27  Merge tag 'armsoc-defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
> 6a1d293238  Add linux-next specific files for 20181224
> +----------------------------------------------------------------------+------------+------------+------------+---------------+
> |                                                                      | cebf8fd169 | bea5b158ff | e1ef035d27 | next-20181224 |
> +----------------------------------------------------------------------+------------+------------+------------+---------------+
> | boot_successes                                                       | 31         | 0          | 0          | 0             |
> | boot_failures                                                        | 0          | 11         | 11         | 7             |
> | BUG:kernel_reboot-without-warning_in_boot-around-mounting-root_stage | 0          | 11         | 11         | 7             |
> +----------------------------------------------------------------------+------------+------------+------------+---------------+
> 
> [   14.073515] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [   14.095297] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [   14.177113] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [   14.256672] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> [   14.278578] console [ttyS0] disabled
> BUG: kernel reboot-without-warning in boot-around-mounting-root stage
> 
> 
>                                                           # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
> git bisect start v4.9 v4.8 --

You are testing the 4.9 kernel release here?

A commit from 2016 is a "problem"?  Are you sure this is still an issue?

thanks,

greg k-h
