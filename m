Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A5CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66E02145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbeLQQvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:51:01 -0500
Received: from ale.deltatee.com ([207.54.116.67]:33222 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbeLQQvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:51:01 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gYw6H-0002lM-Kq; Mon, 17 Dec 2018 09:50:38 -0700
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Stephen Bates <sbates@raithlin.com>,
        Zong Li <zong@andestech.com>, Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Clark <michaeljclark@mac.com>,
        Christoph Hellwig <hch@lst.de>
References: <20181015175702.9036-1-logang@deltatee.com>
 <20181015175702.9036-7-logang@deltatee.com>
 <4b591ba933363e29392dba218ef63267@mailhost.ics.forth.gr>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5fd0880c-5896-ffee-4d3c-4fce1649382e@deltatee.com>
Date:   Mon, 17 Dec 2018 09:50:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <4b591ba933363e29392dba218ef63267@mailhost.ics.forth.gr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, michaeljclark@mac.com, akpm@linux-foundation.org, olof@lixom.net, zong@andestech.com, sbates@raithlin.com, palmer@sifive.com, arnd@arndb.de, andrew@sifive.com, aou@eecs.berkeley.edu, robh@kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, mick@ics.forth.gr
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 6/6] RISC-V: Implement sparsemem
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-12-17 7:59 a.m., Nick Kossifidis wrote:
> Having memory blocks of a minimum size of 1GB doesn't make much sense. 
> It makes it harder to implement hotplug on top of this since we'll only 
> able to add/remove 1GB at a time. ARM used to do the same and they 
> switched to 27bits (https://patchwork.kernel.org/patch/9172845/), ARM64 
> still uses 1GB, x86 also uses 27bits and most archs also use something 
> below 30. I believe we should go for 27bits as well or even better have 
> this as a compile time option.

Thanks, that makes sense. I'll make the change for the next time we submit.

> BTW memblocks_present is on master now (got merged 3 days ago).

Great! We'll send an updated patch set after the merge window.

Logan
