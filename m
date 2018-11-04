Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504F7C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 21:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F328120854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 21:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F328120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeKEGWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 01:22:35 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33447 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeKEGWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 01:22:35 -0500
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gJPan-0002RU-FK; Sun, 04 Nov 2018 22:05:57 +0100
Date:   Sun, 4 Nov 2018 22:05:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Eial Czerwacki <eial@scalemp.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Shai Fultheim (Shai@ScaleMP.com)" <Shai@ScaleMP.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mhocko@suse.cz" <mhocko@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Oren Twaig <oren@scalemp.com>
Subject: Re: [PATCH v2] x86/build: Build VSMP support only if CONFIG_PCI is
 selected
In-Reply-To: <2130cd90-2c8f-2fc4-0ac8-81a5aea153b2@scalemp.com>
Message-ID: <alpine.DEB.2.21.1811042202530.10744@nanos.tec.linutronix.de>
References: <2130cd90-2c8f-2fc4-0ac8-81a5aea153b2@scalemp.com>
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

Eial,

On Thu, 1 Nov 2018, Eial Czerwacki wrote:

> Subject: x86/build: Build VSMP support only if CONFIG_PCI is selected

That's not what the patch does, right?

> vsmp dependency on pv_irq_ops removed some years ago, so now let's clean
> it up from vsmp_64.c.
> 
> In short, "cap & ctl & (1 << 4)" was always returning 0, as such we can
> remove all the PARAVIRT/PARAVIRT_XXL code handling that.
> 
> However, the rest of the code depends on CONFIG_PCI, so fix it accordingly.
> in addition, rename set_vsmp_pv_ops to set_vsmp_ctl.
> 
> Signed-off-by: Eial Czerwacki <eial@scalemp.com>
> Acked-by: Shai Fultheim <shai@scalemp.com>

Unfortunately that patch does not apply. It's white space damaged, i.e. all
tabs are converted to spaces.

Thanks,

	tglx
