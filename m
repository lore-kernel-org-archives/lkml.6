Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D70ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6BE21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6BE21525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbeITPLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:11:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35305 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeITPLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:11:34 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2vGS-0002qy-9G; Thu, 20 Sep 2018 11:28:48 +0200
Date:   Thu, 20 Sep 2018 11:28:47 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, mike.travis@hpe.com, sivanich@hpe.com
Subject: Re: [PATCH v3 1/2] x86/mm: Add an option to change the padding used
 for the physical memory mapping
In-Reply-To: <20180919141058.krruhvsjkm6hqgmf@gabell>
Message-ID: <alpine.DEB.2.21.1809201127210.3243@nanos.tec.linutronix.de>
References: <20180904151141.20264-1-msys.mizuma@gmail.com> <20180918133026.gzyix3oyrfcsrdcx@gabell> <20180919121720.GA47424@gmail.com> <alpine.DEB.2.21.1809191421500.18945@nanos.tec.linutronix.de> <20180919124806.GA48413@gmail.com>
 <20180919141058.krruhvsjkm6hqgmf@gabell>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018, Masayoshi Mizuma wrote:
> On Wed, Sep 19, 2018 at 02:48:06PM +0200, Ingo Molnar wrote:

> > - Add checking code to the later SRAT case to at least _detect_ bad
> >   padding after the fact.
> >
> >   We don't utilize RAM with bad padding until that, right?
> 
> I have an idea as following. Does that make sense?
> 
> Add a warning message which shows the padding size is not enough
> for the physical memory mapping and tell to the user about
> recommended padding size. User can change the padding size in next
> reboot to add the boot parameter.

Yes, that makes sense because silently failing is bad.

Thanks,

	tglx
