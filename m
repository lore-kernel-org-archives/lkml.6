Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6271AC67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA9920C0E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+0h/xzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA9920C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeJSIqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:46:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35265 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeJSIqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:46:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id w5-v6so35563212wrt.2;
        Thu, 18 Oct 2018 17:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OXb89f1IGdtgSlefq0AQ1SPhDz/M09nFhlYfzUCCQpA=;
        b=S+0h/xzbfyLTsf8Yp+kXR8gCtZn1ZIsJtwE9rWUCipsiTiRNbojbYciclDqWGB0ml8
         AnbEDUA0tehQQHa1DL6y1ewsCAPozDtD6pXgK+50UHj9X07w11CTYC2j8MiBGGr2OLXe
         i0nJ47C6jAUZfmMeSySpyU+fU0aWE+SaL/JcO2Mx3O3i9MHGYrakfY3YCW79mUjJsZR5
         j1+AayX+0AMx3Vu7MuJzqi4HIet4HSj6B28vyd+T4Bl91nhSfQjASW3R2Vt0fs6OWzbi
         sjUQ65i1AV/PtTD+pYxzPlCunIYiH/oOLeAVp7GMEm5kSzYojPoFCSFXYMSOIxNx1t7m
         cvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OXb89f1IGdtgSlefq0AQ1SPhDz/M09nFhlYfzUCCQpA=;
        b=RCYUWFD7Q+PeLBsFkAsvGQ08XoX7MzdR7o0KcH1GLtzs9E4l+EqkKeDM0oMiapbucM
         kvlHAGv8xVGEe2PX686u5vNoe7JVQFmwtq+G57MRSaOjf1yleCPFtF9T2UYXilL8VVQN
         2t5Ebyk2PqmVYcJtmEnrQNn/nr3657d7Ur5M3qQJhILF5WuFYvKbCU+7+66auSECXria
         WATh5hpU/xfJIOafLGLEhX0v9wFkG/kDTjepP+Ja5CM+xWdJWTbmvU3VM5AqmmTJU3Np
         yVqqSGULfMDy7KSGl7dagfn1imVB67ijKjCSv64tjDxpStMXPOrOcmwXvYh+Zq6y9lmJ
         NJ8w==
X-Gm-Message-State: ABuFfojhejn61wYdG9b4NtBhhu38gqJDfa7GjNa0b5SjXxe53BAddQPp
        w+bUyRRz/D93yf624EWLTVI=
X-Google-Smtp-Source: ACcGV63h2HHtIebC5Nc62xkMIQFBLkiIk2QjLeqwh2imjEutmzuvcWKcjAKelHk+18MSuS2R29eePw==
X-Received: by 2002:adf:8347:: with SMTP id 65-v6mr30910476wrd.264.1539909774463;
        Thu, 18 Oct 2018 17:42:54 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id l67-v6sm3778363wma.20.2018.10.18.17.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 17:42:53 -0700 (PDT)
Date:   Thu, 18 Oct 2018 17:42:51 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     David Miller <davem@davemloft.net>
Cc:     isdn@linux-pingi.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com
Subject: Re: [PATCH v2] isdn: hfc_{pci,sx}: Avoid empty body if statements
Message-ID: <20181019004251.GA28878@flashbox>
References: <20181018034935.16819-1-natechancellor@gmail.com>
 <20181018.154219.1246620018001438422.davem@davemloft.net>
 <20181019002117.GA10161@flashbox>
 <20181018.172310.35380794084221855.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018.172310.35380794084221855.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 05:23:10PM -0700, David Miller wrote:
> From: Nathan Chancellor <natechancellor@gmail.com>
> Date: Thu, 18 Oct 2018 17:21:17 -0700
> 
> > Thanks for the review, I went ahead and compiled with the following diff
> > on top of v2 and got no warnings from Clang, GCC, or sparse, does this
> > seem satisfactory for v3?
> 
> Well, one thing I notice.
> 

> > @@ -86,7 +86,7 @@ release_io_hfcpci(struct IsdnCardState *cs)
> >         pci_free_consistent(cs->hw.hfcpci.dev, 0x8000,
> >                             cs->hw.hfcpci.fifos, cs->hw.hfcpci.dma);
> >         cs->hw.hfcpci.fifos = NULL;
> > -       iounmap((void *)cs->hw.hfcpci.pci_io);
> > +       iounmap(cs->hw.hfcpci.pci_io);
> >  }
> 
> Driver uses iounmap().
> 
> > @@ -1692,7 +1692,7 @@ setup_hfcpci(struct IsdnCard *card)
> >                 printk(KERN_WARNING "HFC-PCI: No IRQ for PCI card found\n");
> >                 return (0);
> >         }
> > -       cs->hw.hfcpci.pci_io = (char *)(unsigned long)dev_hfcpci->resource[1].start;
> > +       cs->hw.hfcpci.pci_io = (void __iomem *)(unsigned long)dev_hfcpci->resource[1].start;
> >         printk(KERN_INFO "HiSax: HFC-PCI card manufacturer: %s card name: %s\n", id_list[i].vendor_name, id_list[i].card_name);
> 
> But does not use iomap().  You won't need any cast here if it did use
> iomap() properly.
> 
> Thanks.

So this?

diff --git a/drivers/isdn/hisax/hfc_pci.c b/drivers/isdn/hisax/hfc_pci.c
index 3dbaee8c604f..ea0e4c6de3fb 100644
--- a/drivers/isdn/hisax/hfc_pci.c
+++ b/drivers/isdn/hisax/hfc_pci.c
@@ -1692,7 +1692,7 @@ setup_hfcpci(struct IsdnCard *card)
                printk(KERN_WARNING "HFC-PCI: No IRQ for PCI card found\n");
                return (0);
        }
-       cs->hw.hfcpci.pci_io = (void __iomem *)(unsigned long)dev_hfcpci->resource[1].start;
+       cs->hw.hfcpci.pci_io = ioremap(dev_hfcpci->resource[1].start, 256);
        printk(KERN_INFO "HiSax: HFC-PCI card manufacturer: %s card name: %s\n", id_list[i].vendor_name, id_list[i].card_name);
 
        if (!cs->hw.hfcpci.pci_io) {
@@ -1716,7 +1716,6 @@ setup_hfcpci(struct IsdnCard *card)
                return 0;
        }
        pci_write_config_dword(cs->hw.hfcpci.dev, 0x80, (u32)cs->hw.hfcpci.dma);
-       cs->hw.hfcpci.pci_io = ioremap((ulong) cs->hw.hfcpci.pci_io, 256);
        printk(KERN_INFO
               "HFC-PCI: defined at mem %p fifo %p(%lx) IRQ %d HZ %d\n",
               cs->hw.hfcpci.pci_io,



Full context before the above diff should it be needed:


        cs->hw.hfcpci.pci_io = (void *)(unsigned long)dev_hfcpci->resource[1].start;
        printk(KERN_INFO "HiSax: HFC-PCI card manufacturer: %s card name: %s\n", id_list[i].vendor_name, id_list[i].card_name);

        if (!cs->hw.hfcpci.pci_io) {
                printk(KERN_WARNING "HFC-PCI: No IO-Mem for PCI card found\n");
                return (0);
        }

        /* Allocate memory for FIFOS */
        cs->hw.hfcpci.fifos = pci_alloc_consistent(cs->hw.hfcpci.dev,
                                                   0x8000, &cs->hw.hfcpci.dma);
        if (!cs->hw.hfcpci.fifos) {
                printk(KERN_WARNING "HFC-PCI: Error allocating FIFO memory!\n");
                return 0;
        }
        if (cs->hw.hfcpci.dma & 0x7fff) {
                printk(KERN_WARNING
                       "HFC-PCI: Error DMA memory not on 32K boundary (%lx)\n",
                       (u_long)cs->hw.hfcpci.dma);
                pci_free_consistent(cs->hw.hfcpci.dev, 0x8000,
                                    cs->hw.hfcpci.fifos, cs->hw.hfcpci.dma);
                return 0;
        }
        pci_write_config_dword(cs->hw.hfcpci.dev, 0x80, (u32)cs->hw.hfcpci.dma);
        cs->hw.hfcpci.pci_io = ioremap((ulong) cs->hw.hfcpci.pci_io, 256);


Thanks,
Nathan
