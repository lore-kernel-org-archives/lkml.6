Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0F6C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755E520879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547140782;
	bh=I+gfHuWCzXq719YkgKdyRc3lMy2xfl0HZPTlG9AfVis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vr0gxZdFN8d6qTN8vGiNmYL5lXOoBVP4EDu37EEphYZCzE+qHLzc7+Fw8tJSSiID7
	 J5HGkF2xoWkKjvMNYu21p3+v4Y6ZzD64U9MdDa12L738+oqrAfhPQ0lKtRCF5kDjXF
	 JlL9+PEXoWapHxKiTLqfOqapu4NvSOs3fXw+zZJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfAJRTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:19:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:60376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729509AbfAJRTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:19:40 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26985214DA;
        Thu, 10 Jan 2019 17:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547140779;
        bh=I+gfHuWCzXq719YkgKdyRc3lMy2xfl0HZPTlG9AfVis=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hhE45B34CKEpW77DIe+7KhEb3T7JuJDFfP5D3RG2HjK8d5/Yvw61Ap3hlL+QXmt3x
         AMPzr2Lzneoxes6f6t8R3fhHiXfNirLsb7xFoUVPETPkiVeR4ORjJ92c9dj2a0rIp5
         qbIHZPSN9wSJcNDOv4+r0p4EmBpRoLebLwIe1SUM=
Date:   Thu, 10 Jan 2019 18:19:28 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marex@denx.de>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [GIT PULL] mtd: Fixes for 5.0-rc2
Message-ID: <20190110181928.0fba0019@bbrezillon>
In-Reply-To: <CAHk-=wgKMPd0R9dXkJ+49s-rt+=YHTKgBX2WhBieFzi88_=ZYQ@mail.gmail.com>
References: <20190110092531.766738a0@bbrezillon>
        <CAHk-=wgKMPd0R9dXkJ+49s-rt+=YHTKgBX2WhBieFzi88_=ZYQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 09:16:12 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Jan 10, 2019 at 12:25 AM Boris Brezillon <bbrezillon@kernel.org> wrote:
> >
> > MTD Fixes:
> > - Fix a bug introduced when exposing MTD devs as NVMEM providers and
> >   check for add_mtd_device() return code everywhere  
> 
> Ahh, and this should fix the reported NULL pointer thing in sysfs.

Exactly.

> 
> Thanks, pulled.
> 
>                Linus

