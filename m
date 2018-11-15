Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07A3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA3420858
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA3420858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389061AbeKPHHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 02:07:35 -0500
Received: from foss.arm.com ([217.140.101.70]:41362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbeKPHHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 02:07:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78C50EBD;
        Thu, 15 Nov 2018 12:58:09 -0800 (PST)
Received: from [192.168.45.248] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 206683F5BD;
        Thu, 15 Nov 2018 12:58:09 -0800 (PST)
Subject: Re: move the arm arch_dma_alloc implementation to common code
To:     Will Deacon <will.deacon@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org
References: <20181105121931.13481-1-hch@lst.de>
 <20181109075238.GA27578@lst.de> <20181115195041.GC4535@brain-police>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b3267453-0c2d-4bda-2122-d6212967dafc@arm.com>
Date:   Thu, 15 Nov 2018 12:58:04 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115195041.GC4535@brain-police>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-15 11:50 am, Will Deacon wrote:
> On Fri, Nov 09, 2018 at 08:52:38AM +0100, Christoph Hellwig wrote:
>> Can I get a quick review from the arm64 folks?  I think it should
>> be fine there as it basically is a code move, but an additional pair
>> or two of eyes always helps to weed out bugs.
> 
> I reviewed the arm64 parts, but it would be ideal if Robin could have a look
> as well.

Yup, from a quick skim the general shape of the whole series looks 
pleasing, but I've been holding off going through it in detail until 
I've figured out what's up with the last thing I thought I'd reviewed 
exhaustively...

Either way I'll make some time for a proper look next week once I'm back.

Robin.
