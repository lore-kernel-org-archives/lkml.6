Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38E2C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788EF22458
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788EF22458
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934211AbeFVQSg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:18:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42258 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933995AbeFVQSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:18:35 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWOlU-0008Tu-34; Fri, 22 Jun 2018 18:18:24 +0200
Date:   Fri, 22 Jun 2018 18:18:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 7/7] x86/vdso: Move out the CPU number store
In-Reply-To: <80C1F514-1B4D-4CDC-BD46-6C3AA9601446@amacapital.net>
Message-ID: <alpine.DEB.2.21.1806221817280.2402@nanos.tec.linutronix.de>
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com> <1529536506-26237-8-git-send-email-chang.seok.bae@intel.com> <alpine.DEB.2.21.1806221714260.2402@nanos.tec.linutronix.de> <80C1F514-1B4D-4CDC-BD46-6C3AA9601446@amacapital.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1257834180-1529684304=:2402"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1257834180-1529684304=:2402
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 22 Jun 2018, Andy Lutomirski wrote:
> > On Jun 22, 2018, at 8:18 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> >> On Wed, 20 Jun 2018, Chang S. Bae wrote:
> >> 
> >> +#ifdef CONFIG_X86_64
> >> +static void setup_cpu_number(int cpu)
> > 
> > This function name is really misleading. vdso_setup_cpu_and_node() or
> > something like that clearly tells what this is about.
> > 
> Ah. The big secret is that it’s not just vDSO, or at lease hpa wants to
> start using it in the entry code.

Fair enough. Still setup_cpu_number() sucks.

Thanks,

	tglx
--8323329-1257834180-1529684304=:2402--
