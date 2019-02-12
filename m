Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491EDC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E862217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbfBLPZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:25:46 -0500
Received: from verein.lst.de ([213.95.11.211]:36067 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbfBLPZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:25:46 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1358A68DDC; Tue, 12 Feb 2019 16:25:45 +0100 (CET)
Date:   Tue, 12 Feb 2019 16:25:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20190212152543.GA24061@lst.de>
References: <20190204123852.GA10428@lst.de> <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de> <20190206151505.GA31065@lst.de> <20190206151655.GA31172@lst.de> <61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de> <7c1f208b-6909-3b0a-f9f9-38ff1ac3d617@xenosoft.de> <20190208091818.GA23491@lst.de> <4e7137db-e600-0d20-6fb2-6d0f9739aca3@xenosoft.de> <20190211073804.GA15841@lst.de> <820bfeb1-30c0-3d5a-54a2-c4f9a8c15b0e@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <820bfeb1-30c0-3d5a-54a2-c4f9a8c15b0e@xenosoft.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 01:42:56PM +0100, Christian Zigotzky wrote:
> On 11 February 2019 at 08:38AM, Christoph Hellwig wrote:
>> On Sun, Feb 10, 2019 at 01:00:20PM +0100, Christian Zigotzky wrote:
>>> I tested the whole series today. The kernels boot and the P.A. Semi
>>> Ethernet works! :-) Thanks a lot!
>>>
>>> I also tested it in a virtual e5500 QEMU machine today. Unfortunately the
>>> kernel crashes.
>> This looks like a patch I fixed in mainline a while ago, but which
>> the powerpc tree didn't have yet.
>>
>> I've cherry picked this commit
>> ("swiotlb: clear io_tlb_start and io_tlb_end in swiotlb_exit")
>>
>> and added it to the powerpc-dma.6 tree, please retry with that one.
>>
> Hello Christoph,
>
> Have you added it to the powerpc-dma.6 tree yet? The last commit was 4 days 
> ago.

I added it, but forgot to push it out.  It is there now, sorry:

http://git.infradead.org/users/hch/misc.git/commitdiff/2cf0745b7420af4a3e871d5a970a45662dfae69c
