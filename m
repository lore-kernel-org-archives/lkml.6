Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32C0C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4D921477
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OML2LIxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4D921477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbeJSIYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:24:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39832 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSIYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:24:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id y144-v6so1996525wmd.4;
        Thu, 18 Oct 2018 17:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UnGJJN/s8Y+m1x0zzkDT/ZRrrJdFdL2YEEPEe8fuq9U=;
        b=OML2LIxCDVcupS1aH0FNaUWHTasngR+IPr/z/KWngHwW3cdz7XFPiGsaKBbfWeVeYq
         rO6Ah5j5x8Vf3sUQ/O1iT/Ev8fKpTjnUeTVyEK3QmHWB65TdW6Xb4WM4QvENblBT2qUq
         fjM/N2d6kQEsbdzJ/Tv0FUsBdbTkSL33TTphDxhdtNPFXCjONIb4f+URXx/5bIkHiiUF
         VLXCvdoxvKupvuxLiDZK2bsk1sdwVE7Yi2p05c8zt1ddeOImqB+xQUsx0D5Yb3pU4vUa
         vpW7C5gfPvvswmvSF/6KDr0NPQfmDtu8IgEVexhuR4+E8ZSmcu19UDPF4bJGO3CYI04V
         58Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UnGJJN/s8Y+m1x0zzkDT/ZRrrJdFdL2YEEPEe8fuq9U=;
        b=S0t/nCvraGEPmZ1WUBkd5BZ1dl9DMHGGOdbltTGvn2+qlHGtXitW8RIrfNZ1ycRd2E
         vC7iu8uDjiv+3APZ4JXSQCy+PTiGByUyrj6QQz7EQGCw4wPkgEu3xvssRBP2S4Hr7NUW
         ejYGtNdwIzIbTiLSJYXgWMRxQBIU2u5NIQqZ6xrI/bmkKLA9mctthzt5tU0sFTW4rMou
         y7AYrdHY2S2iJjSHA7jJmW83QxVALHdKQwiPrrrfGctLHdi8FDIN8Dd6pi48XL1eCc8K
         TqF/vPH0IAH4IaOWpLmnrpDkepJk9cscH1sPWsx2IySRSnjDJ72SOVhFfpg8GEzk1M4i
         BrKA==
X-Gm-Message-State: ABuFfohvElslb8jNIzUphd8A8u0AtzKYdSOWbKNFlpy8bObfhBh3+BD9
        O0YSkYZHFKjgd8+c4X8OtiU3qHaSjPFElQ==
X-Google-Smtp-Source: ACcGV60vXtTyUKzVYZilDYhYbngT+99kYR74J8S7gHUza09Yto3wXO4CCpbvxQpu91Hlr4LMVOJv4Q==
X-Received: by 2002:a1c:950f:: with SMTP id x15-v6mr2347289wmd.3.1539908479811;
        Thu, 18 Oct 2018 17:21:19 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id j2-v6sm16498480wrw.29.2018.10.18.17.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 17:21:19 -0700 (PDT)
Date:   Thu, 18 Oct 2018 17:21:17 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     David Miller <davem@davemloft.net>
Cc:     isdn@linux-pingi.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com
Subject: Re: [PATCH v2] isdn: hfc_{pci,sx}: Avoid empty body if statements
Message-ID: <20181019002117.GA10161@flashbox>
References: <20181017180657.9410-1-natechancellor@gmail.com>
 <20181018034935.16819-1-natechancellor@gmail.com>
 <20181018.154219.1246620018001438422.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018.154219.1246620018001438422.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 03:42:19PM -0700, David Miller wrote:
> From: Nathan Chancellor <natechancellor@gmail.com>
> Date: Wed, 17 Oct 2018 20:49:36 -0700
> 
> > @@ -228,8 +228,8 @@ typedef union {
> >  } fifo_area;
> >  
> >  
> > -#define Write_hfc(a, b, c) (*(((u_char *)a->hw.hfcpci.pci_io) + b) = c)
> > -#define Read_hfc(a, b) (*(((u_char *)a->hw.hfcpci.pci_io) + b))
> > +#define Write_hfc(a, b, c) (writeb(c, (a->hw.hfcpci.pci_io) + b))
> > +#define Read_hfc(a, b) (readb((a->hw.hfcpci.pci_io) + b))
> 
> This will add new kinds of warnings.
> 
> The problem is that readb/writeb/etc. take an __iomem pointer, but pci_io
> is declared as plain "unsigned char *".  It should be something like
> "void * __iomem" of similar.

Thanks for the review, I went ahead and compiled with the following diff
on top of v2 and got no warnings from Clang, GCC, or sparse, does this
seem satisfactory for v3?

Nathan

========================================================================

diff --git a/drivers/isdn/hisax/hfc_pci.c b/drivers/isdn/hisax/hfc_pci.c
index 7bcd104e9dfe..3dbaee8c604f 100644
--- a/drivers/isdn/hisax/hfc_pci.c
+++ b/drivers/isdn/hisax/hfc_pci.c
@@ -86,7 +86,7 @@ release_io_hfcpci(struct IsdnCardState *cs)
        pci_free_consistent(cs->hw.hfcpci.dev, 0x8000,
                            cs->hw.hfcpci.fifos, cs->hw.hfcpci.dma);
        cs->hw.hfcpci.fifos = NULL;
-       iounmap((void *)cs->hw.hfcpci.pci_io);
+       iounmap(cs->hw.hfcpci.pci_io);
 }
 
 /********************************************************************************/
@@ -1692,7 +1692,7 @@ setup_hfcpci(struct IsdnCard *card)
                printk(KERN_WARNING "HFC-PCI: No IRQ for PCI card found\n");
                return (0);
        }
-       cs->hw.hfcpci.pci_io = (char *)(unsigned long)dev_hfcpci->resource[1].start;
+       cs->hw.hfcpci.pci_io = (void __iomem *)(unsigned long)dev_hfcpci->resource[1].start;
        printk(KERN_INFO "HiSax: HFC-PCI card manufacturer: %s card name: %s\n", id_list[i].vendor_name, id_list[i].card_name);
 
        if (!cs->hw.hfcpci.pci_io) {
diff --git a/drivers/isdn/hisax/hisax.h b/drivers/isdn/hisax/hisax.h
index 338d0408b377..40080e06421c 100644
--- a/drivers/isdn/hisax/hisax.h
+++ b/drivers/isdn/hisax/hisax.h
@@ -703,7 +703,7 @@ struct hfcPCI_hw {
        unsigned char nt_mode;
        int nt_timer;
        struct pci_dev *dev;
-       unsigned char *pci_io; /* start of PCI IO memory */
+       void __iomem *pci_io; /* start of PCI IO memory */
        dma_addr_t dma; /* dma handle for Fifos */
        void *fifos; /* FIFO memory */
        int last_bfifo_cnt[2]; /* marker saving last b-fifo frame count */
