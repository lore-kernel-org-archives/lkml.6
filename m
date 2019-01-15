Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF194C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C7A20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfAOKNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:13:42 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41896 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbfAOKNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:13:40 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gjLio-0002AZ-Ty; Tue, 15 Jan 2019 11:13:27 +0100
Date:   Tue, 15 Jan 2019 11:13:26 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     peng.hao2@zte.com.cn
cc:     bp@alien8.de, dave.hansen@linux.intel.com, peterz@infradead.org,
        luto@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re:[PATCH]  x86/mm/mem_encrypt_identity : fix error useage to
 sizeof
In-Reply-To: <201901071946365174691@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1901151109070.1865@nanos.tec.linutronix.de>
References: 1546065252-97996-1-git-send-email-peng.hao2@zte.com.cn,20181229080013.GB15816@nazgul.tnic <201901071946365174691@zte.com.cn>
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

On Mon, 7 Jan 2019, peng.hao2@zte.com.cn wrote:

> >> Fix error usage to sizeof. It should not use sizeof to pointer.
> >
> >.... because?
> >
> >The commit message needs to explain what the potential issue could be
> >and why it doesn't matter in this case.
> I see the definition of pte_t may be more than sizeof(unsigned long).
> So I think sizeof(pte_t) is safer.

What exactly is the difference between:

	pte_t	*p;

	sizeof(*p)

and

	sizeof(pte_t)

and what is safer about the latter?

Answer: No difference and nothing is safer because it's exactly the same.

In general we use sizeof(*p) simply because when the data type of p changes
you don't have to update the code, it just works and stays correct.

Thanks,

	tglx
