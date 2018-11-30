Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665C2C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAFC206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FAFC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeK3VzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:55:13 -0500
Received: from verein.lst.de ([213.95.11.211]:49517 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbeK3VzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:55:13 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 731A468BDF; Fri, 30 Nov 2018 11:46:20 +0100 (CET)
Date:   Fri, 30 Nov 2018 11:46:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Maximilian Heyne <mheyne@amazon.de>
Cc:     Christoph Hellwig <hch@lst.de>, Torsten Mehlan <tomeh@amazon.de>,
        Uwe Dannowski <uwed@amazon.de>, Amit Shah <aams@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>, stable@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk
Subject: Re: [PATCH v2] fs: fix lost error code in dio_complete
Message-ID: <20181130104620.GA26765@lst.de>
References: <20181108185835.17803-1-mheyne@amazon.de> <83319cde-9855-d544-8079-15e028f4458f@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83319cde-9855-d544-8079-15e028f4458f@amazon.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al, Jens,

can someone pick this up, please?

On Fri, Nov 30, 2018 at 10:02:22AM +0100, Maximilian Heyne wrote:
> On 11/8/18 7:58 PM, Maximilian Heyne wrote:
>> commit e259221763a40403d5bb232209998e8c45804ab8 ("fs: simplify the
>> generic_write_sync prototype") reworked callers of generic_write_sync(),
>> and ended up dropping the error return for the directio path. Prior to
>> that commit, in dio_complete(), an error would be bubbled up the stack,
>> but after that commit, errors passed on to dio_complete were eaten up.
>>
>> This was reported on the list earlier, and a fix was proposed in
>> https://lore.kernel.org/lkml/20160921141539.GA17898@infradead.org/, but
>> never followed up with.  We recently hit this bug in our testing where
>> fencing io errors, which were previously erroring out with EIO, were
>> being returned as success operations after this commit.
> I just wanted to follow up on this. Has anyone picked up this patch?
>
>
>
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrer: Christian Schlaeger, Ralf Herbrich
> Ust-ID: DE 289 237 879
> Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
>
---end quoted text---
