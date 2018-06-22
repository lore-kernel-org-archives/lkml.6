Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49486C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F64243DB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F64243DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933452AbeFVOnL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:43:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41870 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeFVOnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:43:10 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWNHC-0006jJ-Au; Fri, 22 Jun 2018 16:43:02 +0200
Date:   Fri, 22 Jun 2018 16:43:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
cc:     Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/7] x86/fsgsbase/64: Use FS/GS base helpers in core
 dump
In-Reply-To: <1529536506-26237-4-git-send-email-chang.seok.bae@intel.com>
Message-ID: <alpine.DEB.2.21.1806221637270.2402@nanos.tec.linutronix.de>
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com> <1529536506-26237-4-git-send-email-chang.seok.bae@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018, Chang S. Bae wrote:

> When new FSGSBASE instructions enabled, this read will
> become faster.

The point is that it replaces the open coded access, which prevents using
the enhanced FSGSBASE mechanism.

Please be more careful with your changelog wordings. They really should
explain stuff proper.

> Based-on-code-from: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Reviewed-by: Andy Lutomirski <luto@kernel.org>

Other than that:

      Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

