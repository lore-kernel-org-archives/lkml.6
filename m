Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321CFC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFA6206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFA6206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeIKV14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:27:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:57506 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbeIKV14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:27:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 71682ACEA;
        Tue, 11 Sep 2018 16:27:51 +0000 (UTC)
Date:   Tue, 11 Sep 2018 09:27:41 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Eugene Korenevsky <ekorenevsky@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v2] efi: take size of partition entry from GPT header
Message-ID: <20180911162741.GC3902@linux-r8p5>
References: <20180911161527.GA30689@vnote>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180911161527.GA30689@vnote>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Eugene Korenevsky wrote:

>Use gpt_header.sizeof_partition_entry instead of sizeof(gpt_entry)
>for GPT entry size.
>According to UEFI 2.7 spec 5.3.1 "GPT overview":, the size of a GUID Partition
>Entry element is defined in the Size Of Partition Entry field of GPT header.
>The GPT with entries sized more than sizeof(gpt_entry) is not illegal.
>OVMF firmware from EDK2 perfectly works with it, see edk2-tianocore source
>code.

But _why_ is this needed? Does this firmware need larger sized entries (ie: does
not work without it)?

Thanks,
Davidlohr
