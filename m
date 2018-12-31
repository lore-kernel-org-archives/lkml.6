Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7959C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 22:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9556521720
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 22:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeLaWyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 17:54:15 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56420 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbeLaWyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 17:54:14 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 5A16C29C55;
        Mon, 31 Dec 2018 17:54:12 -0500 (EST)
Date:   Tue, 1 Jan 2019 09:54:09 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v8 00/25] Re-use nvram module
In-Reply-To: <alpine.LNX.2.21.1812301430221.215@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1901010947180.574@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au> <CAK8P3a3yF+CkvQS_funp4BPhi-10N4yse2oAeWAcWR+Ty5Pxmg@mail.gmail.com> <alpine.LNX.2.21.1812301051280.215@nippy.intranet> <alpine.LNX.2.21.1812301430221.215@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Dec 2018, I wrote:

> 
> The rationale for the ops struct was that it offers introspection.
> 
> [...] those platforms which need checksum validation always set 
> byte-at-a-time methods to NULL.
> 
> [...] The NULL methods in the ops struct allow the nvram.c misc device 
> to avoid inefficient byte-at-a-time accessors where possible, just as 
> arch/powerpc/kernel/nvram_64.c presently does.
> 

Hopefully my message makes more sense with the tangential irrelevancies 
removed. I will document these considerations in nvram.h for the next 
revision.

-- 
