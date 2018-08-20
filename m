Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1241C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0F22087F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0F22087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeHUAPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:15:19 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:43874 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbeHUAPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:15:18 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w7KKw5rM002794;
        Mon, 20 Aug 2018 21:58:05 +0100
Date:   Mon, 20 Aug 2018 21:58:04 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Alex Feinman <alex@alexfeinman.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Contiguous DMA buffer view for a custom device (Intel/x86)
Message-ID: <20180820215804.67c78e3d@alans-desktop>
In-Reply-To: <CAGXJtFFjVTqYraM0OFipYnNbdLt_BojP5U8WhJETLgw4XWehGQ@mail.gmail.com>
References: <CAGXJtFFjVTqYraM0OFipYnNbdLt_BojP5U8WhJETLgw4XWehGQ@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> b) IOMMU can solve this problem for me by providing a device-specific
> contiguous view of a fragmented physical memory allocation
> c) In order to enable IOMMU do the above, I need to allocate DRHDs and
> DMARs in BIOS initialization (I build my own BIOS)

Yes. The EDK2 firmware toolkit has all the bits you need in it I think.

https://firmware.intel.com/sites/default/files/Intel_WhitePaper_Using_IOMMU_for_DMA_Protection_in_UEFI.pdf

isn't quite on the topic you want but it does explain it fairly well in
passing.

https://software.intel.com/en-us/blogs/2009/03/02/intels-virtualization-for-directed-io-aka-iommu-part-1

is a bit out of date but may help too.

> Please, let me know if I am on the right track? Of course I realize that
> implementing SGDMA would be the best option, but short of that and blocking
> out some physical memory on boot, what are my options?

If performance is absolutely critical simply stealing a chunk of memory
in the firmware and describing it your device some other way is ugly, but
for a custom solution I guess anything goes 8)

Alan
