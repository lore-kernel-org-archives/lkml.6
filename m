Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F80ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DF5208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DF5208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbeGPTrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:47:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52529 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbeGPTrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:47:08 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ff90k-0002jg-7E; Mon, 16 Jul 2018 21:18:18 +0200
Date:   Mon, 16 Jul 2018 21:18:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mukesh Ojha <mojha@codeaurora.org>
cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>, gkohli@codeaurora.org,
        cpandya@codeaurora.org, neeraju@codeaurora.org,
        Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v3] time: Fix incorrect sleeptime injection when suspend
 fails
In-Reply-To: <19b10a21-2636-49a9-2a1a-488f293aeb45@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1807162116180.1693@nanos.tec.linutronix.de>
References: <1530883047-17452-1-git-send-email-mojha@codeaurora.org> <CALAqxLVs=EbbJ83bw=YRb=1B7E2uLcnrUh+qWEjm9U3iYd7FAg@mail.gmail.com> <7e25b63e-cc9b-1f6d-e3d2-087dd484f631@codeaurora.org> <CALAqxLX=-ZZV=O7AAZwMYaXZ1s5h91BfFng4qbtgvkvrKtxgaw@mail.gmail.com>
 <45be9c4f-34fd-200a-df95-9c30b332a96b@codeaurora.org> <CALAqxLVtOv52O=PePEfMmTXeJ5ndkoG8DRwoRs0dxnu+QwqVXQ@mail.gmail.com> <CALAqxLXN9=KgGpG+qexBesn5A2OyszyyzatkP5z_wg1GbcMzQA@mail.gmail.com> <19b10a21-2636-49a9-2a1a-488f293aeb45@codeaurora.org>
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

On Tue, 17 Jul 2018, Mukesh Ojha wrote:
> On 7/16/2018 10:44 PM, John Stultz wrote:
> > > So, I think with the logic bug above it will work out properly, but
> > > let me know if I'm still missing something.
> 
> Please give it thought to a case where very first suspend fails with your
> logic.
> If i am not able to get your thought, please write a patch.

John wants you to invert the logic. i.e.

     true -> false
     false -> true
     if (var) -> if (!var)
     if (!var) -> if (var)

It's not that hard, right?

Thanks,

	tglx
