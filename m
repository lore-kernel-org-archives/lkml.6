Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A94C64EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E262082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E262082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeJCC1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:27:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60904 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeJCC1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:27:22 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7QYm-000270-Q5; Tue, 02 Oct 2018 21:42:20 +0200
Date:   Tue, 2 Oct 2018 21:42:20 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nikola Ciprich <nikola.ciprich@linuxbox.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Matt Rickard <matt@softrans.com.au>,
        Borislav Petkov <bp@alien8.de>,
        Jason Vas Dias <jason.vas.dias@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 4.14 114/165] x86/vdso: Fix vDSO build if a retpoline is
 emitted
In-Reply-To: <20181002114734.GA31855@pcnci.linuxbox.cz>
Message-ID: <alpine.DEB.2.21.1810022141350.1435@nanos.tec.linutronix.de>
References: <20180903165655.003605184@linuxfoundation.org> <20180903165701.245301231@linuxfoundation.org> <20181002080655.GV31855@pcnci.linuxbox.cz> <20181002114614.GA2581@kroah.com> <20181002114734.GA31855@pcnci.linuxbox.cz>
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

On Tue, 2 Oct 2018, Nikola Ciprich wrote:

> RHEL / centos 6: 
> 
> gcc-4.4.7
> 
> will check newer kernels too..

We upped the gcc minimal version in newer kernels to 4.6, so 4.4 wont work
at all.

Thanks,

	tglx
