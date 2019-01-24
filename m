Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C563BC41518
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B469218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548297149;
	bh=xMNcOlbl+2Kuj9GNXWp0XWbM0a57TgxgtsrzT66ucgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WSRX9AGO3+LnP3+MmOnnNFwGS0uajEvr+2V1V5atkAxXFQ+x2P7Qerxdqwb2PhAPG
	 GmEKwQ7fKUF2bmUy1ENShcLs+I88qjXaD9ySUGZJFiOZYiNACXGMu6tsE6G6gw/kA8
	 Chj7HpdMIGKrR5NJSlFwQSk2tDekJRofaNv3K/vY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfAXCc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 21:32:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbfAXCc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 21:32:26 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C86A82184C;
        Thu, 24 Jan 2019 02:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548297145;
        bh=xMNcOlbl+2Kuj9GNXWp0XWbM0a57TgxgtsrzT66ucgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YYldT0xRjEgfd7VNgxT/sLYQJpyP51FdK5D+0XHF71b/C8WBF4MbWIv7/ycoGW2nh
         8Sp8vsGNTclkpaqI/N8hWbG1et5ITbVdixdKPAnlqqskesgzQkuEqiOIB0VU+okWgy
         x8GM2ipLFj0f9ZrPa7uCgtUIEBs0nMXQTaVyO06k=
Date:   Thu, 24 Jan 2019 10:31:57 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, ren_guo@c-sky.com, mao_han@c-sky.com
Subject: Re: [PATCH] riscv: fixup max_low_pfn with PFN_DOWN.
Message-ID: <20190124023157.GA22934@guoren-Inspiron-7460>
References: <20190116010738.GA4817@guoren-Inspiron-7460>
 <mhng-7c486840-63d3-4645-84ff-8c89660fc552@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-7c486840-63d3-4645-84ff-8c89660fc552@palmer-si-x1c4>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 06:00:35PM -0800, Palmer Dabbelt wrote:
> On Tue, 15 Jan 2019 17:07:38 PST (-0800), guoren@kernel.org wrote:
> >Hi Christoph,
> >
> >I use PFN_DOWN() every where as possible and seems it's a habit
> >problem. So let risc-v maintainer to choose "PFN_DOW()" or
> >">> PAGE_SHIFT".
> >
> >Also the same with "end_of_DRAM & max_low_pfn".
> 
> PFN_DOWN makes sense to me, as that's what we're trying to do here (round a
> physical address down to page frame number).  Am a I misunderstanding
> something?
>
No, you got it :)

Best Regards
 Guo Ren
