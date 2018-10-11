Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE02CC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B2B2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg4Jmc8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B2B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeJLFQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:16:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41659 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbeJLFQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:16:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id m77-v6so5064218pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 14:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JhV7x8TISMO0HSJz1GMb0ApIKzKwFBG4TU1DR2PpBzM=;
        b=Kg4Jmc8E0vN38RWPYff2u36Et2iUKn1c5mjHkvBrMHJc1D/6im4YQsNwPEAcFKZtDF
         DdPcKP+0DuSOiM59RDQOCiVJllj4wKRS5O4bDR71B9NVBSFswsa2Q0ahcF79Dekcz708
         H95DV/5RD2z2yydDvLBnMDYwuc3mQDDC99nsVaVRdRYOK/znDWK++fKXiaRoWkRZd6pn
         ampNb8DWBHyeb2FxSONT+lKigueB67I+7tDtSv5/ls8Ya/W6GRhjNx6/L1leArETWAnA
         TUKb3tcl7hSYp8es2GsxLVBBA0VfA3W2YVS0PG2QhgpZfMRQJoNC7qPbp9YoHyahUI3r
         UMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JhV7x8TISMO0HSJz1GMb0ApIKzKwFBG4TU1DR2PpBzM=;
        b=nXU1p7+62Qra72T1rlM0UjcDtGvY3Vo4mmx7sg2KfVNZgV+YrsIlY4L52C22qq25Xl
         5C+iKGTN6fwKlXY/dSTabyX3lOVGVuchlDhSZTmvzk3tqRocnnkZvzz533IFUixxx+9J
         3Ifx6DBSP1bllhOD2V4HWHQuzrQiwpyvNMplaKLpWu5lHkC2vHHtgco1+Gy00q+TfdpO
         OxdePVOxm0OVhEXCp5R9YleOy6+qYC0sin46/gP9DIvqBDnRo0oW22v+abL/s2FzqdU8
         lCki7CUiNz4C1dL9A8NkjNe81jrZF4s6W4pPvmqH2p+WJf+QdccN3WJGtE9Pj0vo/Gzi
         KUkQ==
X-Gm-Message-State: ABuFfojVPswlqcAUfwsu0t/ctUZfocA7TaxsmolISyvxVkVnrklzlSwH
        55H/x5VQGytorBqLcdINBxkaX85r
X-Google-Smtp-Source: ACcGV60cd8SVDT5or06skr6Swo4kYMtr6aN6wE/wi6OO+5I3lE/nVlmtpEruaQK3NmXj2sYJgzuVxQ==
X-Received: by 2002:a63:f64f:: with SMTP id u15-v6mr3002412pgj.258.1539294443591;
        Thu, 11 Oct 2018 14:47:23 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z14-v6sm44838372pfi.4.2018.10.11.14.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 14:47:22 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:47:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: Re: [PATCH] ARCv2: build: use mcpu=hs38 iso generic mcpu=archs
Message-ID: <20181011214720.GA11172@roeck-us.net>
References: <20180912165817.GA5118@roeck-us.net>
 <4881796E12491D4BB15146FE0209CE646816FBF1@DE02WEMBXB.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4881796E12491D4BB15146FE0209CE646816FBF1@DE02WEMBXB.internal.synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On Thu, Oct 11, 2018 at 09:22:50PM +0000, Alexey Brodkin wrote:
> Hu Guenter,
> 
> > -----Original Message-----
> > From: linux-snps-arc [mailto:linux-snps-arc-bounces@lists.infradead.org] On Behalf Of Guenter Roeck
> > Sent: Wednesday, September 12, 2018 7:58 PM
> > To: Vineet Gupta <vineet.gupta1@synopsys.com>
> > Cc: linux-snps-arc@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] ARCv2: build: use mcpu=hs38 iso generic mcpu=archs
> > 
> > Hi,
> > 
> > On Fri, Sep 07, 2018 at 03:13:10PM -0700, Vineet Gupta wrote:
> > > helps gcc with better instruction selections such as 64-bit multiply MPYD
> > >
> > > before
> > > ------
> > > 82c34b58 <sched_clock>:
> > > 82c34b58:	ld	r2,[0x83068d00]
> > > 82c34b60:	add_s	r2,r2,0x7530
> > > 82c34b66:	mov_s	r0,0x989680
> > > 82c34b6c:	mpymu	r5,r2,r0
> > > 82c34b70:	mpy	r4,r2,r0
> > > 82c34b74:	mov_s	r0,r4
> > > 82c34b76:	j_s.d	[blink]
> > > 82c34b78:	mov_s	r1,r5
> > > 82c34b7a:	nop_s
> > >
> > > after
> > > ------
> > > 82c34b7c <sched_clock>:
> > > 82c34b7c:	ld	r0,[0x83064d00]
> > > 82c34b84:	add_s	r0,r0,0x7530
> > > 82c34b8a:	mpydu	r0,r0,0x989680
> > > 82c34b92:	j_s	[blink]
> > >
> > > Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> > 
> > This patch causes my arc2 test builds to fail
> > 
> > Building arc:axs103_defconfig ... failed
> > --------------
> > Error log:
> > 
> > standard input}: Assembler messages:
> > {standard input}:154: Error: inappropriate arguments for opcode 'st'
> > {standard input}:157: Error: Insn j_s has a jump/branch instruction j_s in its delay slot.
> > {standard input}:186: Error: inappropriate arguments for opcode 'st'
> > make[3]: *** [net/core/dev.o] Error 1
> > make[2]: *** [net/core] Error 2
> > 
> > Building arc:nsim_hs_smp_defconfig ... failed
> > --------------
> > Error log:
> > {standard input}: Assembler messages:
> > {standard input}:218: Error: inappropriate arguments for opcode 'st'
> > {standard input}:9329: Error: inappropriate arguments for opcode 'st'
> > 
> > Building arc:vdk_hs38_smp_defconfig ... failed
> > --------------
> > Error log:
> > 
> > {standard input}: Assembler messages:
> > {standard input}:9629: Error: inappropriate arguments for opcode 'st'
> > {standard input}:9883: Error: inappropriate arguments for opcode 'st'
> > 
> > I use a toolchain based on gcc 7.3.0 and binutils 2.30. What version
> > of gcc and binutils do I need for the builds to complete ?
> 
> I would strongly recommend to use GCC 8.2+ for ARC as there were
> quite some improvements and fixes done for ARC.
> 
> You may use master branch of Crosstool-NG for building uClibc multilib toolchain
> for ARC based on Binutils 2.31.1 and GCC 8.2.0.
> 

Yes, I had figured that out a couple of weeks ago and already switched
to those revisions.

Thanks,
Guenter
