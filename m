Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0015C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AC92083F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AC92083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754645AbeGCI75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:59:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43052 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754382AbeGCI7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:59:55 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1faHA7-0005zN-BP; Tue, 03 Jul 2018 10:59:51 +0200
Date:   Tue, 3 Jul 2018 10:59:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc:     Benjamin Gilbert <bgilbert@redhat.com>,
        linux-x86_64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
In-Reply-To: <20180703083038.cxvyhq5vsxyeuyvu@black.fi.intel.com>
Message-ID: <alpine.DEB.2.21.1807031059250.1601@nanos.tec.linutronix.de>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com> <20180701213243.GA20180@trogon.sfo.coreos.systems> <20180702093450.h5tfjeynpi3nwjbo@black.fi.intel.com> <20180702190128.GA455@trogon.sfo.coreos.systems>
 <20180703083038.cxvyhq5vsxyeuyvu@black.fi.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018, Kirill A. Shutemov wrote:

> On Mon, Jul 02, 2018 at 07:01:28PM +0000, Benjamin Gilbert wrote:
> > On Mon, Jul 02, 2018 at 12:34:50PM +0300, Kirill A. Shutemov wrote:
> > > Could you check if you can trigger the issue with my changes to config and
> > > the way I run KVM?
> > 
> > Yes, the issue still triggers in that case.  I've also verified that the
> > kernel boots normally with your qemu command if the commit is reverted.
> 
> Hm. What toolchain do you use?

On Sun, Jul 01, 2018 at 05:15:59PM -0400, Benjamin Gilbert wrote:
> 4.17 kernels built with the CoreOS Container Linux toolchain and kconfig, 
