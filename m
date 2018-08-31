Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86DBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 05:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD5A20839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 05:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m1VwfAvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD5A20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeHaKAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 06:00:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeHaKAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 06:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q40mc9MuuTCiPg0gJiAB1KfnLL2TFyNGB+8HvdwE+PM=; b=m1VwfAvrH73/NvRt51LOQbwQr
        177gFW31YcnYZYkVGo9c3MVm+8WdrSWiriVfDV8zftrGnkfX4y9SRy9Ukp9mVMlDGvtIaQTO1kGJw
        yqkV0EfNA/Zuw/ENvJ2VwL0oqdmwdwufx5lY7LMJyHmltfgISTDU1YwgmtsJO/ra/MYfG9tLHh4Gd
        hOkBiRV2UGlZTk+GF6urTEIbdGYKtnRe0EBVQ+T5jK4SnfySxPh+z/ut65e4beEUlUMNzfW/XEqa1
        suIkXcHaLgQQOZPmpGb3Z5lxBr+ddeNTGUEec6p5Nls2zXoizcaWmX6iH90Yi+WyZIkJ9HXvYBXEm
        Io1bS6DJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvcOO-0004zj-7n; Fri, 31 Aug 2018 05:54:48 +0000
Date:   Thu, 30 Aug 2018 22:54:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dmitriy@oss-tech.org" <dmitriy@oss-tech.org>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH 5/8] RISC-V: Rename im_okay_therefore_i_am to
 found_boot_cpu
Message-ID: <20180831055447.GA18478@infradead.org>
References: <20180827184243.25344-1-palmer@sifive.com>
 <20180827184243.25344-6-palmer@sifive.com>
 <20180830144118.GA27233@infradead.org>
 <30229ef5-ce4e-e78b-32f9-7c563f63827b@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30229ef5-ce4e-e78b-32f9-7c563f63827b@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:11:11AM -0700, Atish Patra wrote:
> On 8/30/18 7:41 AM, Christoph Hellwig wrote:
> > >   	struct device_node *dn = NULL;
> > > -	int hart, im_okay_therefore_i_am = 0;
> > > +	int hart, found_boot_cpu = 0;
> > 
> > If you rename this anyway please switch to use a bool.
> > 
> 
> I can address the comment on this patch and fold it in my series to avoid
> unnecessary conflict.
> 
> @Palmer: You can drop this patch.

If Palmer is ok with it how about you include a respin of his whole
series?  There are some overlaps I think and having a single person
in charge might be helpful.

Btw, I've found your series in my linux-kernel folder, but it did
not make it to linux-riscv or my personal inbox despite the CC.
