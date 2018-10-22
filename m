Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5745C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A504B20651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/Rfrpva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A504B20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbeJWDtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 23:49:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42660 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbeJWDtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 23:49:16 -0400
Received: by mail-qk1-f196.google.com with SMTP id u20-v6so11550243qkk.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=USlzlTTWgH41VD76JmkTFX00jbW7+YWwdD09EG7j5f0=;
        b=p/RfrpvaRS6wOd11cGDWPAFP3WiagJ58VmqlklD2FtDXDkM08s25wJjdiq37dpBT1k
         8JzJlu9fDeEkNfi+ibFyBvfJDqdBxeAzJhHPWXy8Ily4/dE6LIba54jjypIk/sWng9F/
         2/n6gPanh2QWzjFy1/bcI4ZQsppib4zPRDGwt4nh8LdYzgXWSzTKtT4INV75yvoRHUk5
         r3oU21m8TJOzUEhHv6qkEFuNolw7PickMCTowkfLAwkt2PGxa9iux46ukJH6pnIKKvnl
         79NZ8npNVmGAkjheNOXgzEIqMSaY2EUj4s5TOaGKuhRcXQ2A7uVZ/Yy0aX3UX3kkRXyo
         1xPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=USlzlTTWgH41VD76JmkTFX00jbW7+YWwdD09EG7j5f0=;
        b=jcgHN2hliGxBdCjNdC+uRz/1OmBYtprWAXLLAYR1Vs2ZaUnsCwwkjR2Vv2MoKKnCrg
         UQaawM3NNYzgwPs20zm187h9CTexOPk0RqkhQ1T6uRD5trtkWmVqX86bd2K0nFye+StH
         +7Tt0XeZxiGONJpWJKC/xPaW3TRbDJtYULbcX0jZHknKkonZq9yRs9POUBIeEw+IOQ6t
         F5bIBhbLhhFT7PAYv4wcsMBQbE9rXhqla4xSenTCub8xHlRRqdae5zQOIdoZQytBKysH
         e1cIxs1yOYZ00ZquFacBecVXqKT3Mk8kWQgSQGDK9W0A6DKmbr2Xf+APobrtZgrsCQsC
         W98A==
X-Gm-Message-State: AGRZ1gJ3gZ7R2B0vwiGl7zEEfr/vXdY9cCo7Tswr868S9/OdAcntc216
        y7q/JuoSgaEiYGEPafddPmg=
X-Google-Smtp-Source: AJdET5e6yrIemESEzGvdTm6Asl9lmt7rBKvaMRJWC3x54m91F8jseKMNwChS6rlYFLg8xO22OCCq6Q==
X-Received: by 2002:a37:cc05:: with SMTP id r5-v6mr8396825qki.7.1540236566684;
        Mon, 22 Oct 2018 12:29:26 -0700 (PDT)
Received: from dhcp-10-175-29-12.vpn.oracle.com (209-6-36-129.s6527.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.36.129])
        by smtp.gmail.com with ESMTPSA id d124-v6sm2732271qkf.85.2018.10.22.12.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 12:29:25 -0700 (PDT)
Date:   Mon, 22 Oct 2018 15:29:23 -0400
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     He Zhe <zhe.he@windriver.com>
Cc:     konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/dma: Fix panic caused by passing swiotlb to
 command line
Message-ID: <20181022192921.GA20677@dhcp-10-175-29-12.vpn.oracle.com>
References: <1537154831-447363-1-git-send-email-zhe.he@windriver.com>
 <c3536f4f-9bde-4f7f-a180-aa569d4e786d@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3536f4f-9bde-4f7f-a180-aa569d4e786d@windriver.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 08:56:58PM +0800, He Zhe wrote:
> May I have your input?

Alternatively would it make more sense for it to assume some default
value?
> 
> Thanks,
> Zhe
> 
> On 2018年09月17日 11:27, zhe.he@windriver.com wrote:
> > From: He Zhe <zhe.he@windriver.com>
> >
> > setup_io_tlb_npages does not check input argument before passing it
> > to isdigit. The argument would be a NULL pointer if "swiotlb", without
> > its value, is set in command line and thus causes the following panic.
> >
> > PANIC: early exception 0xe3 IP 10:ffffffffbb9b8e9f error 0 cr2 0x0
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc3-yocto-standard+ #9
> > [    0.000000] RIP: 0010:setup_io_tlb_npages+0xf/0x95
> > ...
> > [    0.000000] Call Trace:
> > [    0.000000]  do_early_param+0x57/0x8e
> > [    0.000000]  parse_args+0x208/0x320
> > [    0.000000]  ? rdinit_setup+0x30/0x30
> > [    0.000000]  parse_early_options+0x29/0x2d
> > [    0.000000]  ? rdinit_setup+0x30/0x30
> > [    0.000000]  parse_early_param+0x36/0x4d
> > [    0.000000]  setup_arch+0x336/0x99e
> > [    0.000000]  start_kernel+0x6f/0x4e6
> > [    0.000000]  x86_64_start_reservations+0x24/0x26
> > [    0.000000]  x86_64_start_kernel+0x6f/0x72
> > [    0.000000]  secondary_startup_64+0xa4/0xb0
> >
> > This patch adds a check to prevent the panic.
> >
> > Signed-off-by: He Zhe <zhe.he@windriver.com>
> > Cc: stable@vger.kernel.org
> > Cc: konrad.wilk@oracle.com
> > Cc: hch@lst.de
> > Cc: m.szyprowski@samsung.com
> > Cc: robin.murphy@arm.com
> > ---
> >  kernel/dma/swiotlb.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 4f8a6db..46fc34e 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -109,6 +109,11 @@ static int late_alloc;
> >  static int __init
> >  setup_io_tlb_npages(char *str)
> >  {
> > +	if (!str) {
> > +		pr_err("Config string not provided\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	if (isdigit(*str)) {
> >  		io_tlb_nslabs = simple_strtoul(str, &str, 0);
> >  		/* avoid tail segment of size < IO_TLB_SEGSIZE */
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
