Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF19C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C275121570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C275121570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeHTSLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:11:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55717 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeHTSLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:11:02 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1frla2-0007hF-Fa; Mon, 20 Aug 2018 16:54:54 +0200
Date:   Mon, 20 Aug 2018 16:54:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jan Beulich <JBeulich@suse.com>
cc:     the arch/x86 maintainers <x86@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Alok Kataria <akataria@vmware.com>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: [PATCH RESEND] x86-64: use RIP-relative calls for paravirt
 indirect ones
In-Reply-To: <5B73DFB602000078001DE35E@prv1-mh.provo.novell.com>
Message-ID: <alpine.DEB.2.21.1808201654230.1551@nanos.tec.linutronix.de>
References: <5B30C3F102000078001CD6F1@prv1-mh.provo.novell.com> <5B73DFB602000078001DE35E@prv1-mh.provo.novell.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2018, Jan Beulich wrote:

> This saves one insn byte per instance, summing up to a savings of over
> 4k in my (stripped down) configuration. No variant of to be patched in
> replacement code relies on the one byte larger size.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
