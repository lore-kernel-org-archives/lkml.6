Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2142057-1525331113-2-10675784904037734230
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525331113; b=QAxQACwWipxTZ4VJR8kK0PLHxrGeWu4ltGmucOmcUKXUP42+z4
    tX1ri8JDLolQ3k7eBC3KIGm4pnJVYEToMJxGyfK7C8Te/Pv9nYF6LUCOn3RiVJ0A
    JXDjI4xkkCPwpmXplU/LaPXYZu0gBFftQp2XSVgqDDyifaffnsVBVPJdVw0FKQqb
    ex/Ds0tMLqlULTEM4RfWDiy/ZBdbQOFYgXmwRl2Ar0a3OQO7fyxX1zw00zvA6im2
    ZJGxCDfGzNhm3cwyL2JRPxO6KMdBwuFRFMPL9XKRGhMPjRHfng1M6r1ZjU13Ki41
    4ZUjQTe0AJw+s4qKlMEVD0c65cJzCYu/GtfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525331113;
    bh=HLi0/s1rnhWVKtk/k0NUtbixwfJ7Uf908G+0CajlAUg=; b=HLgbc+O9Rsfl
    MalAdQcG+yujCVQb7QZrLsF/6jDnBLLJhyNKu9uM2cx21sta3EOPoQwP9jlvPCUy
    d0/jTcM50446KJRleS2CU8g55iFwLWD+ro19YkAUNOxA/4IrewHIBorg1iLma5G5
    gS1iL7krcsssIOUYQ8F8xsYwQY84ZcVyGY7gS+pZbWcl9Rft16q0e+S9llEFWVmJ
    qA7YlM1itVzQ6IWpGLW7XXpPHDPhlijpsS0kiw4ZIW3sWdI2KZne2NTGLpF0o5T8
    JuwN7to8u4iYd0UYIL96U9OLnIJ13NBuhqTtFgIL+vtXrJVng7Q2WaqQpz7AUyHI
    XLkMa5oG9A==
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
X-CM-Envelope: MS4wfJ6xx1RGXwAPx7mzQlaMZSA5/uMIwKRNwsfBc2wfRL2lD4l7SMdI+I9JrsY6Ky8v9FBd7tgjGBntPqMzDrN8afNGezTM3ylwF0co8g4r0am8YeH+joZO
    6mXkUWgS++lOlyzeXFJaefWjdahaZKMtVcYA56lBAdZ/LHRJXguFiWyjm9o2QzhPczU+P7jkGJ2C23wUafto73UKE3AyHGRl5IVXkokDSwlYP9zFhPoG0juj
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=bKAFnZK0T5E61TdS9KAA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=d3PnA9EDa4IxuAV0gXij:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeECHFK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 03:05:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43369 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752001AbeECHFK (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 3 May 2018 03:05:10 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT,
        URIBL_BLOCKED shortcircuit=ham autolearn=disabled version=3.4.0
Date: Thu, 3 May 2018 09:05:07 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: rawnand: marvell: pass ms delay to wait_op
Message-ID: <20180503090507.4d190e08@xps13>
In-Reply-To: <a40b0454ea78494983c909fd6b2c08c8@svr-chch-ex1.atlnz.lc>
References: <20180503022128.10702-1-chris.packham@alliedtelesis.co.nz>
        <a40b0454ea78494983c909fd6b2c08c8@svr-chch-ex1.atlnz.lc>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Chris,

On Thu, 3 May 2018 05:28:32 +0000, Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:

> On 03/05/18 14:21, Chris Packham wrote:
> > marvell_nfc_wait_op() expects the delay to be expressed in milliseconds
> > but nand_sdr_timings uses picoseconds. Use PSEC_TO_MSEC when passing
> > tPROG_max to marvell_nfc_wait_op().
> > 
> > Fixes: 02f26ecf8c772 ("mtd: nand: add reworked Marvell NAND controller driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > ---
> >   drivers/mtd/nand/raw/marvell_nand.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
> > index 1d779a35ac8e..e4b964fd40d8 100644
> > --- a/drivers/mtd/nand/raw/marvell_nand.c
> > +++ b/drivers/mtd/nand/raw/marvell_nand.c
> > @@ -1074,7 +1074,7 @@ static int marvell_nfc_hw_ecc_hmg_do_write_page(struct nand_chip *chip,
> >   		return ret;
> >   
> >   	ret = marvell_nfc_wait_op(chip,
> > -				  chip->data_interface.timings.sdr.tPROG_max);
> > +				  PSEC_TO_MSEC(chip->data_interface.timings.sdr.tPROG_max));
> >   	return ret;
> >   }
> >   
> > @@ -1494,7 +1494,7 @@ static int marvell_nfc_hw_ecc_bch_write_page(struct mtd_info *mtd,
> >   	}
> >   
> >   	ret = marvell_nfc_wait_op(chip,
> > -				  chip->data_interface.timings.sdr.tPROG_max);
> > +				  PSEC_TO_MSEC(chip->data_interface.timings.sdr.tPROG_max));
> >   
> >   	marvell_nfc_disable_hw_ecc(chip);
> >     
> 
> Actually I'm not so sure about this patch. While passing the pico-second 
> value for tPROG_max is clearly wrong and leads to seemingly indefinite 
> hangs on some systems. Converting the times to micro-seconds leaves us 
> with delays that are far too short.

It is not micro but milli-seconds here.

> 
> The old pxa3xx driver had hard coded 200ms delays. These delays now work 
> out to 1ms which seems every bit as wrong as 600000000ms.

200ms is extremely long, I guess typical values are ~200-500us, so this
1ms timeout does not scare me :)

I'll let Boris conclude.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks.

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
