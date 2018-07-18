Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CBFECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3BC2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3BC2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbeGRBVH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:21:07 -0400
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:34907
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731205AbeGRBVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:21:07 -0400
X-ASG-Debug-ID: 1531874720-093b7e2c7ceb7a0001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id 76j2rpCd6dPCBz4N (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO); Wed, 18 Jul 2018 08:45:34 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.847.32; Wed, 18 Jul 2018 08:45:24 +0800
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1]) by
 HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1%12]) with mapi id
 15.00.0847.030; Wed, 18 Jul 2018 08:45:24 +0800
From:   "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Unify pci and normal dma direction definition
Thread-Topic: [PATCH] PCI: Unify pci and normal dma direction definition
X-ASG-Orig-Subj: Re: [PATCH] PCI: Unify pci and normal dma direction definition
Thread-Index: AQHUGnQj5uJVOoRz/US93mQBH05aAKSS8uKAgACzTYA=
Date:   Wed, 18 Jul 2018 00:45:24 +0000
Message-ID: <1531874719.3330.2.camel@hxt-semitech.com>
References: <1531463840-34651-1-git-send-email-shunyong.yang@hxt-semitech.com>
         <20180717140335.GA23500@infradead.org>
In-Reply-To: <20180717140335.GA23500@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.6.36]
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <5D273CFF8F94D242A7ABD8978D1167F2@hxt-semitech.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1531874734
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4394 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.53877
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christoph,

  I will send a v2 according to your comments.

Thanks.
Shunyong.

On Tue, 2018-07-17 at 07:03 -0700, Christoph Hellwig wrote:
> > 
> > diff --git a/include/linux/dma-direction.h b/include/linux/dma-
> > direction.h
> > index 3649a031893a..9d52716e9218 100644
> > --- a/include/linux/dma-direction.h
> > +++ b/include/linux/dma-direction.h
> > @@ -2,7 +2,7 @@
> >  #ifndef _LINUX_DMA_DIRECTION_H
> >  #define _LINUX_DMA_DIRECTION_H
> >  /*
> > - * These definitions mirror those in pci.h, so they can be used
> > + * These definitions mirror those in pci-dma-compat.h, so they can
> > be used
> >   * interchangeably with their PCI_ counterparts.
> >   */
> I think we can just drop this comment anymore.
> 
> > 
> > +#define PCI_DMA_BIDIRECTIONAL	(DMA_BIDIRECTIONAL)
> > +#define PCI_DMA_TODEVICE	(DMA_TO_DEVICE)
> > +#define PCI_DMA_FROMDEVICE	(DMA_FROM_DEVICE)
> > +#define PCI_DMA_NONE		(DMA_NONE)
> No need for the braces.
