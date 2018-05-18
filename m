Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-287146-1526673991-2-16398178623566219155
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526673991; b=WQdRe5/fnSXYPHif9XTI27yy+ESSCcaoL2j8ymEwcfpGhk47rC
    iGR55gIpxjiX0aJqPvR1bGlrEGPu4k69SNn46ufBP4o3XiNkzXmdP7CI2NKZQu/B
    8VJfVywQ7LU3yFRRrgMt4D3LB9uWtzI5anCp4+InaAWfGx/2wn7wrlMrDFY5lRqp
    3hm8/tz+OfacW0nH9hzxFJSxpeNTCP3WdZkTdM1at5w5Hz51ABgn/R8fljaiYEoa
    wt9SJJp/XdijtcEvPJrr5os/XoKqKcyT6mpRi7w4AkAgvB186SWhpKbJBhz2CPEX
    HDGuBYICNOnK683cGBtO1PSseNJzsO4u3w/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526673991;
    bh=eBGBuSCNxKunko2ITG4BQFE6AQoKJ7YsO3v+Fm5mzZ4=; b=hhKjGNHKgo16
    LLYCsxg2SPST+efQclTi4nQnFHTHjPQKNuaUYF2Qs4ztDIwdCZuxcIIACn5LYfvL
    NE7iMiLzX44eSr3quyp99JkZtdrQlvForF5WYR5HYBCBrLL0Jxjm7nVihWH2v25J
    qB1A7DIho+sgxtXW1WZ3GRetadJ8/KTg8VBgUGbxQO7BvIsGiW+bu1DaqFuZqhhi
    FZaUa0a3GA63IlKM/WXgEid+0vZ35HNASMYDuZDrTUNmL6lKGQ4Wt6uVpEmCvtCt
    K5FwWdu1UjKFDz8v16wdBYU9INkSjR0cMpZbcR1p9D10EwSeGKvQedwOSC92dpW+
    VnWml/Y/jw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmx.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmx.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK2Y/8iwp6qmHY6yqajIxLp6qxz9sDXeyaQW4asJL2ZmNoEWieCBdqtDwNnGlptMKauXC0lCFHJZydn7/Ms5HGUiHFbkBQq49yTa4H72cBVopXa+nY11
    NcmETziHJBbq8lWXWEPSmFNO4nLOtSemV1crt4j/t+s8bbL794jDG6WzPH0I3TQnmbaK142lt+xWeonm7jMBycm2MO3k0Q6zxMZsKpBKuzzeB/VSNS57Qr47
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=EDXiTP7fMPgA:10
    a=VUJBJC2UJ8kA:10 a=z3VdpBj7Fy1TgC09ZSIA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbeERUG2 (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 16:06:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:60089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751156AbeERUG0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 May 2018 16:06:26 -0400
Subject: Re: [PATCH 02/20] dma-mapping: provide a generic dma-noncoherent
 implementation
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "hch@lst.de" <hch@lst.de>
Cc: "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
References: <20180511075945.16548-1-hch@lst.de>
 <20180511075945.16548-3-hch@lst.de>
 <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
From: Helge Deller <deller@gmx.de>
Message-ID: <0c5d27e9-2799-eb38-8b09-47a04c48b5c7@gmx.de>
Date: Fri, 18 May 2018 22:05:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dbWqGZkrneC2PXCfX6aBO4SyRmjNp/wfiM9LtaMukYwZXYlHQxv
 jz4n7wg5rGJtnaBkFZ03R0Tcq10Qaftrg1yaGhe+vKwpDliOtvDkMLP3jrubI3Pt5Q9A8hy
 ThSgsvAX/hZsL8sI6qZ218VFUwL8O1Y9YfPtHlEZYXejlqT3fb08NvgvazJRa78rNmIvmMe
 pojZopBZxyKl6TxHQ/C3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wJHJ2Ioh6vM=:9NoVMjYeCNBYtG9aazO7XR
 f2zt1tXloI3vYOqTqN7tOZVJqXc5LXciOLNKtNQZ0YSMsmKBG14L+WmbYuCeQlpfg/zXBOpLG
 TmjLUz3msEI2gShw8IebNUzfCjCyyV61N6OZqGE8XTcfgGFsIRIPHaqhpLSQEhZVUMqVpB/aO
 HCeulVegkInx+Af5TRkjlPaFq69qXJYvQjiVRzHdh26lS3oI1/ZFJs8Ww4ji+j0GjmMqSuVQQ
 +WUfdjVALVGHOMeN0sCrX6RQK3EIzqNaurcMa6JEXu4qHLjX3jXpNv7EmFxMU0JB3sCw5rGf7
 NVgDlzFbGWY3yuU9mbzKkxHQC+h885SUCEhh5zHKrArE8HoTOSMnfCHLp2DOLbRFmBQ1LTO1l
 YIai4pFYabrUyderIa45BVBQVXsDQpPnFa0GT7irJTt2LE430RS0//hWryC10qMB8jGnOH4jV
 7giHLCgtJ41H1IaJJjbBrkIQhi7ZOkjtAQGagbkObmmA6p2YhOso5hbp9z18QM1rOx09XCKHm
 LQIsIDmkdB4o+5I2hjkv5pbP3sCrx8fPSqCAsRbiMxRHiKarFXfWmfxG/KKomCH69UvSK/N4R
 FLldPcb7Lb/9b3Z8dfoZ2fK3/DINp5rs/HV/dhZIllKLL4vRaPnmBQJb/EO9i7mylik1nBHGo
 XvtexbgH+iWhshCmYX9MpTk2IV5OF8AvOw8HvjKGjlkF+Slt0Lk6ZDBOTndDlPXQGnHNDASNj
 0Ix5qzWSrOZpL7JRztJ5lKWK291WDRy/C3MFAXYvcohzIZvQdHNth0je/+RRJTppPdeBEI160
 kGe+/sm
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18.05.2018 15:03, Alexey Brodkin wrote:
> But the real fix of my problem is:
> ---------------------------------------->8------------------------------------
> --- a/lib/dma-noncoherent.c
> +++ b/lib/dma-noncoherent.c
> @@ -35,7 +35,7 @@ static dma_addr_t dma_noncoherent_map_page(struct device *dev, struct page *page
>  
>         addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
>         if (!dma_mapping_error(dev, addr) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> -               arch_sync_dma_for_device(dev, page_to_phys(page), size, dir);
> +               arch_sync_dma_for_device(dev, page_to_phys(page) + offset, size, dir);
>         return addr;
>  }
> ---------------------------------------->8------------------------------------
> 
> You seem to lost an offset in the page so if we happen to have a buffer not aligned to
> a page boundary then we were obviously corrupting data outside our data :)

Good.
This patch seems to fix the dma issues I faced on my 32bit B160L parisc box.

So it leaves only one open issue on parisc:
Now every 32 bit parisc system is unnecessarily non-coherent.

Helge
