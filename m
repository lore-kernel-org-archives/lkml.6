Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB52C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849BC24181
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849BC24181
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753459AbeGEJiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:38:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49856 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbeGEJiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:38:18 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fb0iF-0007PC-HJ; Thu, 05 Jul 2018 11:38:07 +0200
Date:   Thu, 5 Jul 2018 11:38:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Tian, Baofeng" <baofeng.tian@intel.com>
cc:     "'mingo@redhat.com'" <mingo@redhat.com>,
        "'hpa@zytor.com'" <hpa@zytor.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'rostedt@goodmis.org'" <rostedt@goodmis.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Debug: Add cpu registers dump in case of kernel panic
In-Reply-To: <EEBA739CCF11FE49B73E1FB4690F5EE649E29D94@SHSMSX101.ccr.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1807051133240.1714@nanos.tec.linutronix.de>
References: <0038B620BAC72941BCBF48AEB892976C02CADD3F@shsmsx102.ccr.corp.intel.com> <EEBA739CCF11FE49B73E1FB4690F5EE649E1B316@shsmsx102.ccr.corp.intel.com> <EEBA739CCF11FE49B73E1FB4690F5EE649E29D94@SHSMSX101.ccr.corp.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1871442336-1530783487=:1714"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1871442336-1530783487=:1714
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 5 Jul 2018, Tian, Baofeng wrote:

> Resubmit again for review, this patch save register and used for RAM dump.

Please do not resubmit by replying to mail which got rejected by LKML in the first
place. Resubmit means to send the patch new and in proper form.

>  static atomic_t stopping_cpu = ATOMIC_INIT(-1);
>  static bool smp_no_nmi_ipi = false;
>  
> +static DEFINE_PER_CPU(struct pt_regs, cpu_regs);
> +
> +/* Store regs of this CPU for RAM dump decoding help */
> +static inline void store_regs(struct pt_regs *regs)
> +{
> +     struct pt_regs *print_regs;

And this still is white space damaged.....

See Documentation/process/email-clients.rst

If your MUA is not mentioned there, then a web search or asking your
colleagues should give you the hints.

Thanks,

	tglx


--8323329-1871442336-1530783487=:1714--
