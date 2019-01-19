Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3254AC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 05:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A7D2084F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 05:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="EKUexgRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfASF0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 00:26:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44209 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfASF0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 00:26:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so17431594wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 21:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S5WLHKm1UldARquTGB6XuPGzuMNSMkWoRTMN9CVKI/w=;
        b=EKUexgRxQOa3l+/0BWMsjZDhFsahNG3htOdWMBQshY+zSyrbzlNtNVuLI8l1NMF64f
         ZuI9t8ruKJ6eIB6sUfg3Fu1I1XGrEOitLDS/vEB0xEy3gpMSTF4Yi6oTZyyNnREehEWr
         yhxzE6Viob6I87vxJH8ssA4IWjfqieA//B9EC2QWcAcYnUvaWafo91M/rWjiwUhnqMJK
         ABbzoU5leiZkmBka2yAUBTgX2aabrK+bZqYHdPyCxYJpSYEa9KB/0MDmCTKKs3yvswP5
         55wCnt3VKdJhCQg3nn3LVnEdF2cZKtNOmrl9oys0wX73P5ibXAnriFnhT4a/cbsfi7Er
         qeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S5WLHKm1UldARquTGB6XuPGzuMNSMkWoRTMN9CVKI/w=;
        b=mDWMcJlhN+X6Jf87UglEXSUO/bt/OcIphLEenpfl/R9sGNEousClw4Gtg3kS0uNYhB
         QXXznBA51wo1nH3WJQFe2JctIHPTtw/15Pj64hnIrF2M8pymnVke+t0yz1CV8vDpi/3W
         92H+8deiPl7n7j5ye3okU/ZlK2OYR4lZum8IGv+GtTqhleHzFxIG8UKSiLT+VjiSsqk1
         UIDpakfAILaIUIrkrRpQ1LnpGxrlqu7GxqN9cLzKyW4ZCI1XS0sBA/i0lbILj4LeBp31
         vjZL0dlsLOI0Jrzg5Ors2QHqWw+raBxLjZdxDi/MnYTA6gmtdo1ZznEiQ3wK0wYhkBbO
         e48g==
X-Gm-Message-State: AJcUukfKb0lObuZTmpTI7IaUkpmR0C9xlfVoycmmXlMFP2obOQwgw/pH
        0OziDTQheXPkou5kL85CvrBcikZn1x5KlPJkldHdAA==
X-Google-Smtp-Source: ALg8bN5V+6YkMLC8pakrEPq8SJekNxg23yM0DzsOQo9orwLdyQ2JYB31GJ9nrRjDaMLL15Fy665TkIML85jGj1BAs7c=
X-Received: by 2002:adf:f5d1:: with SMTP id k17mr20570188wrp.59.1547875570759;
 Fri, 18 Jan 2019 21:26:10 -0800 (PST)
MIME-Version: 1.0
References: <20181227111821.80908-1-anup@brainfault.org> <20181227111821.80908-5-anup@brainfault.org>
 <20190115155600.GC13095@infradead.org>
In-Reply-To: <20190115155600.GC13095@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 19 Jan 2019 10:55:58 +0530
Message-ID: <CAAhSdy2Oe44Mw66rphPHGU69DN1bnyhXH3xjrQ6DvLNsVVqgSw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] irqchip: sifive-plic: Differentiate between PLIC
 handler and context
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 9:26 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Dec 27, 2018 at 04:48:20PM +0530, Anup Patel wrote:
> > We explicitly differentiate between PLIC handler and context because
> > PLIC context is for given mode of HART whereas PLIC handler is per-CPU
> > software construct meant for handling interrupts from a particular
> > PLIC context.
> >
> > To achieve this differentiation, we rename "nr_handlers" to "nr_contexts"
> > and "nr_mapped" to "nr_handlers" in plic_init().
>
> Not sure what this differenciates that we previously didn't.  As far
> as I can tell it just is a slight naming cleanup.

There is a disconnect between PLIC documentation and PLIC driver.

If we have 8 HARTs then we can have 16 PLIC contexts whereas PLIC
handlers (SW construct) are always same as number of HARTs. In other
words, there will be separate PLIC context for M-mode and S-mode of a
HART.

Linux runs in S-mode so we can only use PLIC context meant for S-mode.
This means per-CPU handlers in PLIC driver only handle PLIC S-mode
context of a HART.

This patch makes PLIC driver more readable and matching PLIC HW
documentation by differentiating between PLIC handler and PLIC
context.

Regards,
Anup
