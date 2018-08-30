Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623E0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C2F205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C2F205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbeH3ScH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:32:07 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50365 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeH3ScH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:32:07 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fvNx4-0005Rr-T3; Thu, 30 Aug 2018 16:29:39 +0200
Date:   Thu, 30 Aug 2018 16:29:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     John Crispin <john@phrozen.org>
cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] nohz: Fix missing tick reprog while interrupting inline
 timer softirq
In-Reply-To: <20180830141043.8169-1-john@phrozen.org>
Message-ID: <alpine.DEB.2.21.1808301629050.1210@nanos.tec.linutronix.de>
References: <47d2416d-6359-1f48-311d-404fb5bfa3a8@ti.com> <20180830141043.8169-1-john@phrozen.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018, John Crispin wrote:

> > Sry, that disturbing you all, but what are the conclusion here for 4.14.y?
> > - take Thomas's patch https://lore.kernel.org/patchwork/patch/969521/#1162900
> > - revert commit 2d898915ccf4838c04531c51a598469e921a5eb5
> 
> Hi Frederic,
> 
> I reported this very issue to tglx last night and he asked me to verify his
> proposed patch which i just did. I can confirm the the patch fixes the issue
> on 4.14.67 and Greg should add it to the stable queue please.
> 
> Tested-by: John Crispin <john@phrozen.org>

Let me whip up a proper patch with changelog.

Thanks,

	tglx
