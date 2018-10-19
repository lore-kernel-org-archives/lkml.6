Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AD3C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC072145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftQKc5Xu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC072145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbeJSJFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 05:05:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41917 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSJFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 05:05:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id q7-v6so7764225wrr.8;
        Thu, 18 Oct 2018 18:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M3p7lTqaldgTHkyl82htGyV+QEGCO0+FwJXRCHjYm2A=;
        b=ftQKc5Xum+GWzJeeqIm30FjxY7LUkgqTO38ZcYzPuQEQ+xfLfruUVw6iHjRlhFSxVG
         QdLwR0IRlMSlzdFNaeK1rS3ww9ZQHmm+tISH+gm6oF5GKHGHhviajyI97eWKK1ysV74P
         UznvmNhRteROeyPTBSjjEQR2FW6Wu7vNGaVGsqyoMXH/paEzwAKagXMLd2Or4n5zPbvc
         +IVF6cnDrodUkytd+4lZ7Rqbx8eZ76dl54lLQJumeEcW3/pWCeQEhx+iKIJEDYySr4k8
         idU+9yDp8toh2+pHBW/5eDGr0+/KgWZb6woRZVzxMHSixO2igEJLCwkUGAC3lk1Y9IY1
         +6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M3p7lTqaldgTHkyl82htGyV+QEGCO0+FwJXRCHjYm2A=;
        b=DPyPKe4EtZIR5uc2OtMHXU66z2eMinueLA+WX4Knp6wcD6upKtprEBDFoI2scAuK99
         UsE2gWzgucRHaxcmL2IDNGjD6212PLD7whJ3UWoy/Md+4cIROgwuXra7AaacFBcSGWaM
         auIF0eAXl2kmzWadB8gGKFcThkTmsCGEzXq/qKWKqKWxD0imYzmbk8vGo2Kl1k8IYkTc
         r87m2ZCPHEDoxG6+/6t/3ol11wlUx8Xd5UPYwS5czDSk9+ePQ80ZGcYgGkSXhZtuxktE
         Tmhz0zxeqPy8af3oKkYHuTYanzjcpWltenvqA3jrQJHgcX6paPQCSWw6yzVOU86jlnru
         BmZA==
X-Gm-Message-State: AGRZ1gLJr4KPX+PfyZTH6kX4HAsfxIW8qj1MA37jAnDUmqVEll5xB77c
        0K+i1/ZfAXov0HADPpur4vg=
X-Google-Smtp-Source: AJdET5fYlsGb4UL6Uff/p9PKGuw083oY3MXiLIk4D1m5Jx3FB6oY59aZhujQSoD9luof7xXuUXiyIA==
X-Received: by 2002:adf:9426:: with SMTP id 35-v6mr311965wrq.54.1539910896673;
        Thu, 18 Oct 2018 18:01:36 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id b139-v6sm2843198wmd.36.2018.10.18.18.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 18:01:36 -0700 (PDT)
Date:   Thu, 18 Oct 2018 18:01:34 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     David Miller <davem@davemloft.net>
Cc:     isdn@linux-pingi.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com
Subject: Re: [PATCH v2] isdn: hfc_{pci,sx}: Avoid empty body if statements
Message-ID: <20181019010134.GA30592@flashbox>
References: <20181019002117.GA10161@flashbox>
 <20181018.172310.35380794084221855.davem@davemloft.net>
 <20181019004251.GA28878@flashbox>
 <20181018.175058.827953425036498775.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018.175058.827953425036498775.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 05:50:58PM -0700, David Miller wrote:
> From: Nathan Chancellor <natechancellor@gmail.com>
> Date: Thu, 18 Oct 2018 17:42:51 -0700
> 
> > On Thu, Oct 18, 2018 at 05:23:10PM -0700, David Miller wrote:
> >> From: Nathan Chancellor <natechancellor@gmail.com>
> >> Date: Thu, 18 Oct 2018 17:21:17 -0700
> >> 
> >> > Thanks for the review, I went ahead and compiled with the following diff
> >> > on top of v2 and got no warnings from Clang, GCC, or sparse, does this
> >> > seem satisfactory for v3?
> >> 
> >> Well, one thing I notice.
> >> 
> > 
> >> > @@ -86,7 +86,7 @@ release_io_hfcpci(struct IsdnCardState *cs)
> >> >         pci_free_consistent(cs->hw.hfcpci.dev, 0x8000,
> >> >                             cs->hw.hfcpci.fifos, cs->hw.hfcpci.dma);
> >> >         cs->hw.hfcpci.fifos = NULL;
> >> > -       iounmap((void *)cs->hw.hfcpci.pci_io);
> >> > +       iounmap(cs->hw.hfcpci.pci_io);
> >> >  }
> >> 
> >> Driver uses iounmap().
> >> 
> >> > @@ -1692,7 +1692,7 @@ setup_hfcpci(struct IsdnCard *card)
> >> >                 printk(KERN_WARNING "HFC-PCI: No IRQ for PCI card found\n");
> >> >                 return (0);
> >> >         }
> >> > -       cs->hw.hfcpci.pci_io = (char *)(unsigned long)dev_hfcpci->resource[1].start;
> >> > +       cs->hw.hfcpci.pci_io = (void __iomem *)(unsigned long)dev_hfcpci->resource[1].start;
> >> >         printk(KERN_INFO "HiSax: HFC-PCI card manufacturer: %s card name: %s\n", id_list[i].vendor_name, id_list[i].card_name);
> >> 
> >> But does not use iomap().  You won't need any cast here if it did use
> >> iomap() properly.
> >> 
> >> Thanks.
> > 
> > So this?
> 
> That's definitely a lot better, yes!
> 
> I wonder what exactly it is checking there though.  I guess it wants to see if the
> resource->start value is zero and bail with an error it so.
> 
> Anyways, this code has been like this for ages and what you are proposing is
> definitely a significant improvement.
> 
> Thanks.

I was thinking the same thing. I think ioremap will still error out if
start is zero so this should be fine. I'll roll all of this up into v3,
thanks a lot for the review!

Nathan
