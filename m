Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519DFECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14AAA20B80
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AAA20B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbeGPJoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:44:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51353 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeGPJoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:44:12 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fezdG-0000BK-7i; Mon, 16 Jul 2018 11:17:26 +0200
Date:   Mon, 16 Jul 2018 11:17:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matthew Wilcox <willy@infradead.org>
cc:     Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Souptick Joarder <jrdr.linux@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Subject: Re: [PATCH 2/3] x86: Convert vdso to use vm_fault_t
In-Reply-To: <20180703123910.2180-2-willy@infradead.org>
Message-ID: <alpine.DEB.2.21.1807161116590.2644@nanos.tec.linutronix.de>
References: <20180703123910.2180-1-willy@infradead.org> <20180703123910.2180-2-willy@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018, Matthew Wilcox wrote:

> Return vm_fault_t codes directly from the appropriate mm routines instead
> of converting from errnos ourselves.  Fixes a minor bug where we'd return
> SIGBUS instead of the correct OOM code if we ran out of memory allocating
> page tables.
> 
> Signed-off-by: Matthew Wilcox <willy@infradead.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

