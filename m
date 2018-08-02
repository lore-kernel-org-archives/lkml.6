Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB616C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A05C214FB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A05C214FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbeHBLjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:39:08 -0400
Received: from verein.lst.de ([213.95.11.211]:38865 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbeHBLjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:39:08 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8D07068D64; Thu,  2 Aug 2018 11:53:25 +0200 (CEST)
Date:   Thu, 2 Aug 2018 11:53:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "shorne@gmail.com" <shorne@gmail.com>
Subject: Re: [PATCH 7/9] irqchip: add a RISC-V PLIC driver
Message-ID: <20180802095325.GC14203@lst.de>
References: <20180726143723.16585-1-hch@lst.de> <20180726143723.16585-8-hch@lst.de> <1b3f6066-0c7c-a5f5-75ad-559fe81091ee@wdc.com> <dc69d688-f765-74cc-3234-563fecff6002@wdc.com> <20180731165712.GA2521@lst.de> <dcb17e67-9f83-0ff5-a2c6-a6dd1b4d9c0d@wdc.com> <20180801121656.GA25806@lst.de> <1b380e3c-e137-ebe9-4528-852062d2192e@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b380e3c-e137-ebe9-4528-852062d2192e@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 06:09:42PM -0700, Atish Patra wrote:
> On 8/1/18 5:12 AM, Christoph Hellwig wrote:
>> On Tue, Jul 31, 2018 at 05:38:01PM -0700, Atish Patra wrote:
>>> crash details are at
>>> https://paste.debian.net/1036078/
>>
>> Is this running without kallsyms?  It seems to lack useful symbols
>> and a backtrace unfortunately.
>>
> Yes. I checked the config. All KALLSYMS options and STACKTRACE are enabled
>
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
>
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_STACKTRACE=y
>
> Not sure if I missed something.

That should be all that is needed normally.
