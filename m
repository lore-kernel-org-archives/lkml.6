Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D5CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE2020665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE2020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbeJWT1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:27:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33024 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeJWT1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:27:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id y140-v6so11345217wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 04:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dZpi2PAKMui6UZJ1Ca/gUoDSheB0tXR0XKgFUOsa3S0=;
        b=SQZYmfTewc/Czjo4Pclf7R4zonFLrNFSpZt5eWazaYhiPWjSn9tD7bzXO2Kw6Lrtaz
         bksACSA/JisNUCqCQY/CTkm+7oQCaU3H5Wud6kdq7rBsx4/DQ2aqiIWlmyz+3kZmRkyO
         xEzH9PpOWqMtboa2wtHHP29FJg0WpSSx9tnUOmHzQRnyQta8aphCGoU7E/NprYZdwf98
         8KMlEj+YgtuE0s6L+5XPhH2piL8eCMoprFZLgtrNqgEWYdX2E6g0ibLrl1ihJOzxRv2c
         qOmxQxr8Zz6PaSUeBfCxwsE4og4r78/iP6N5+PrYzwPC3o1FS1tdPR50cjWvoa4xENR6
         v0xg==
X-Gm-Message-State: AGRZ1gKv/pR4y0SJy5Jro6wT0XuljQsXwRwhRD4PEcyVh1fboItwCGop
        BvsReC4AQj7qNpIHpxBOAZiRMw==
X-Google-Smtp-Source: ACcGV63mIHKBEG4+zHm4GQFpVsI0zyDkreAgKy/n6oUj16wy3qjVpERgwDtB9tI30jMTBEXTR48NYQ==
X-Received: by 2002:a1c:83d2:: with SMTP id f201-v6mr19130687wmd.107.1540292688536;
        Tue, 23 Oct 2018 04:04:48 -0700 (PDT)
Received: from localhost ([185.7.230.215])
        by smtp.gmail.com with ESMTPSA id c64-v6sm1165596wma.44.2018.10.23.04.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 04:04:46 -0700 (PDT)
Date:   Tue, 23 Oct 2018 12:04:45 +0100
From:   Moritz Fischer <mdf@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     Moritz Fischer <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "atull@kernel.org" <atull@kernel.org>
Subject: Re: [PATCH] zynq-fpga: Only route PR via PCAP when required
Message-ID: <20181023110445.GA1371@archbook>
References: <1540276279-2903-1-git-send-email-mike.looijmans@topic.nl>
 <20181023090119.GA2205@archbook>
 <1781ed23-e03c-f70a-ea8c-3e9fa6eec9d4@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1781ed23-e03c-f70a-ea8c-3e9fa6eec9d4@topic.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Tue, Oct 23, 2018 at 10:53:50AM +0000, Mike Looijmans wrote:
> On 23-10-18 11:01, Moritz Fischer wrote:
> > Hi Mike,
> > 
> > seems like a good usecase (though uncommon), question below
> 
> Usecases for ICAP:
> - It's considerably faster than PCAP
> - Self-repairing logic (e.g. single-event upsets)
> - Being programmed from a remote FPGA
> - Programming through another bus (e.g. PCIe)

Yeah, I wasn't saying it's a bad usecase, just not super common :)

> 
> 
> > 
> > On Tue, Oct 23, 2018 at 08:31:19AM +0200, Mike Looijmans wrote:
> >> The Xilinx Zynq FPGA driver takes ownership of the PR interface, making
> >> it impossible to use the ICAP interface for partial reconfiguration.
> >>
> >> This patch changes the driver to only activate PR over PCAP while the
> >> device is actively being accessed by the driver for programming.
> >>
> >> This allows both PCAP and ICAP interfaces to be used for PR.
> >>
> >> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> >> ---
> >>   drivers/fpga/zynq-fpga.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> >> index 3110e00..f6c205a 100644
> >> --- a/drivers/fpga/zynq-fpga.c
> >> +++ b/drivers/fpga/zynq-fpga.c
> >> @@ -497,6 +497,10 @@ static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr,
> >>   	int err;
> >>   	u32 intr_status;
> >>   
> >> +	/* Release 'PR' control back to the ICAP */
> >> +	zynq_fpga_write(priv, CTRL_OFFSET,
> >> +		zynq_fpga_read(priv, CTRL_OFFSET) & ~CTRL_PCAP_PR_MASK);
> >> +
> > 
> > Shouldn't that be after the below stanza that enables the clock?
> 
> I'm actually not sure, and I did not encounter any problems while testing 
> this, but it's easier to just move it than to find out, so I'll go for "yes, 
> let's enable the clock first".
> I'll await a bit more feedback and post a v2 for that.

Ok, I had suspected you tested it and probably didn't run into issues,
but just wanted to make sure we think about it. If you don't mind, swap
it around as I suggested just to be safe.

With that change feel free to add my Reviewed-by: Moritz Fischer
<mdf@kernel.org> in your v2.

Thanks for the patch,

Moritz
