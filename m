Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2209120-1525334479-2-12216373735551225277
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525334479; b=kFbHF4Lcc4VREtuzha1pk1zj+p5HqrJLHkCYtkakP+IEjhb/fI
    26btVTcCi7pXOylH8tR9syi2td/pQJjuG6rLe5SweDMxoFRPdduDZ9hiktdNPejM
    ae0O1pY/kADpMWgrSRl9PeO/Am9vYQ5gHc5ToXq78pFVDYZ/EOGgXRICt+adt2dw
    biY01HGMrq5SVSHRG5xXuE+YF4w1xeeWKiU9RRTpHRDzMvUCqdUu1wMz/nqRfYBR
    65OUStLVjgqGZBlhPEWqlwhgtmnkjKQQRQdaFvz+cb5Z8Ftd3iRJCJy1630Ng6y8
    d/bpOnJgwVTOiYkgd7PAPSAGFV0z+ySY79KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525334479;
    bh=gIps1eIEVxJ6EQPf2LPsT1xLDW5VH8V2pSWFaoXFt4w=; b=UghkY7fS09PX
    YYn5AMgAEe9MJtMl1N9Wzh81fQGrd2e6IMVNu+ZLmON6icpYiJyIqocYH8ksfUlY
    ekOubBzcZ4e4s7vkxY07C1HufZqWK4HTfK3JAR7sUg1hynYsyaUiAkwzHYlQ+nDw
    nG9uPcvCfMOeEvjn1ljSU9Pzj5suU79bFff89b3OdMfnH/YiYIVYWqNfk2iWfx76
    i0DHjT8op42IpeNRokE/14cAawr41NCMC4zdHeKvQDBgnoLnoSnGRhV+qZFVrTT5
    X+Gh7HOoZ80H+p+On6SqqIazh/IYspjBnc46Q7xkI/LZ0d44+j5nkRM5NYVDkom0
    FXaVuHo3Eg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHt6a/NewOHYB19zAnDMJsFUrHoNnEZshrIVZn7AyMpuSpaekhqfyKSeZ/Cj88xiIp9n0NMa7AxUubmRxITNMtKXW5m2OK7t4Oqw5NFPVJJk3BwdwYdm
    mYsSeCnXupxoORP7ELyK34FA2lln37zy7xA7HSSnmnjIF0qe1aH3i/H6KHVrEOKWttUJ6h+scDMKmoWwU7KIGLhQ7CVQGnc6UOuLMdjViY+EzqSPxAgf9Lac
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=P-IC7800AAAA:8 a=jklznHYkcgX2mWUPN8sA:9 a=QEXdDO2ut3YA:10
    a=d3PnA9EDa4IxuAV0gXij:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbeECIBR convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 3 May 2018 04:01:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44987 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbeECIBQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 3 May 2018 04:01:16 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT,
        URIBL_BLOCKED shortcircuit=ham autolearn=disabled version=3.4.0
Date: Thu, 3 May 2018 10:01:14 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Richard Weinberger <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: rawnand: marvell: pass ms delay to wait_op
Message-ID: <20180503100114.16d573dc@xps13>
In-Reply-To: <20180503090348.0c10b00f@bbrezillon>
References: <20180503022128.10702-1-chris.packham@alliedtelesis.co.nz>
        <a40b0454ea78494983c909fd6b2c08c8@svr-chch-ex1.atlnz.lc>
        <20180503090348.0c10b00f@bbrezillon>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Boris, Chris,

> > > diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
> > > index 1d779a35ac8e..e4b964fd40d8 100644
> > > --- a/drivers/mtd/nand/raw/marvell_nand.c
> > > +++ b/drivers/mtd/nand/raw/marvell_nand.c
> > > @@ -1074,7 +1074,7 @@ static int marvell_nfc_hw_ecc_hmg_do_write_page(struct nand_chip *chip,
> > >   		return ret;
> > >   
> > >   	ret = marvell_nfc_wait_op(chip,
> > > -				  chip->data_interface.timings.sdr.tPROG_max);
> > > +				  PSEC_TO_MSEC(chip->data_interface.timings.sdr.tPROG_max));
> > >   	return ret;
> > >   }
> > >   
> > > @@ -1494,7 +1494,7 @@ static int marvell_nfc_hw_ecc_bch_write_page(struct mtd_info *mtd,
> > >   	}
> > >   
> > >   	ret = marvell_nfc_wait_op(chip,
> > > -				  chip->data_interface.timings.sdr.tPROG_max);
> > > +				  PSEC_TO_MSEC(chip->data_interface.timings.sdr.tPROG_max));
> > >   

[...]

> > The old pxa3xx driver had hard coded 200ms delays. These delays now work 
> > out to 1ms which seems every bit as wrong as 600000000ms.  

When the 'keep-config' property is populated, the
->setup_data_interface() hook of the driver is not shown to the core,
which leads to not "updating" the timings like tPROG_max.

While it worked with the old driver that hardcoded this delay, this
might not work anymore with the current driver because it expects
timings.sdr.tPROG_max to be != 0 (and PSEC_TO_MSEC(0) also returns 0).

This is probably something to fix.

Regards,
Miquèl

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
