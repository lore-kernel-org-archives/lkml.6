Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74556C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F8A2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="09vZJyLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F8A2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeJ3PZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:25:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbeJ3PZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:25:57 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0509E2082D;
        Tue, 30 Oct 2018 06:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540881226;
        bh=X+ZQEgQW1dlB6+sS1QOs3d1MGyFA9c4IjXWjMre3tUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=09vZJyLRbl2jEydlVRIgvqLPoDWAPdGATxZqwHfYSkQ3MC91qbV6HKas3yaQ/s2fU
         SHSa6be5jaULZR/XT1DrdTehd2FP066jHvwCBLpuE6G0U29p5Xwy4dxIK6sQJZEM3M
         ZuWeaQ/D3+gP5Xrcjd+s1CywBrd5lZoo+VOGg1H4=
Date:   Tue, 30 Oct 2018 07:34:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Praneeth Bajjuri <praneeth@ti.com>
Subject: Re: [PATCH v2] codafs: Fix build using bare-metal toolchain
Message-ID: <20181030063408.GA26627@kroah.com>
References: <20181029200311.16947-1-semen.protsenko@linaro.org>
 <CAKaJLVvpNZW2a+3xc7PE0+iU1nm39A7PEjCu8F9ijrT+wEXOag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKaJLVvpNZW2a+3xc7PE0+iU1nm39A7PEjCu8F9ijrT+wEXOag@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:05:49PM +0200, Sam Protsenko wrote:
> Hi Greg,
> 
> On Mon, Oct 29, 2018 at 10:03 PM, Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> > The kernel is self-contained project and can be built with bare-metal
> > toolchain. But bare-metal toolchain doesn't define __linux__. Because of
> > this u_quad_t type is not defined when using bare-metal toolchain and
> > codafs build fails. This patch fixes it by defining u_quad_t type
> > unconditionally.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> 
> Can you please pull this one, if this applicable? I sent it a while
> ago, but I guess it got lost in mailing list. It might be also
> applicable to stable branch (as it fixes allmodconfig build for ARM
> with bare-metal toolchain).

Why are you asking me?  I'm not the maintainer of this file :(

confused,

greg k-h
