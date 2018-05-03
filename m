Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2142057-1525331035-2-4542941017450214102
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
    1525331034; b=NP+WMqXvTUuKByXavPbsgyyAYapm5ldXJ2psGVK0F+nMZhe3Jm
    epaOw4hiZ1gIGDuWPN+XBoA1/DtoU1QhiHVi2Y3XLmuOZV+piKucwlwE2bZK3BEL
    OpeN2KTpd8ltkRkaLiL0MItL3hNkX42yO6WVb6CQtasYjmt2s8xRYHVC5r70L50P
    pEQ4sGLmjrdn5wVyUcc7XhRKW7IcrHjvUZCFuKMWo2OypKw0ZN4yAOXkcH4MPapu
    n8tVe+8a2DGnrazvZWQ9kD3R7bOByyjeRwFcrEwlHNAvDHBwDoyZMSHeSyOZbP9L
    RZhzMC9aWYugeh9jcnrRjK1XJNVK29BrR1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525331034;
    bh=4XiLfZI9GtbJMtMNzJhUW79UcG1bHaCL1BXADSeKSUc=; b=iNVRWu4UsM+V
    A5L4eYUty86nd4zsjsAJxdx9hgoLbWBWbvXXOVbFpntOagHX9Drajxr3+64aYTl5
    8RwNk7QLYn7se99s12EW2dtEGV0MSVkumZjHvw/RhsEPiYTS7DpMO81zwLpLktvt
    qSOPrHL32OAzZrjjLxSLYPd4W9PxqfS4FiCK8ao61gbuZjCCPgyoXYI3x+0LzVry
    W/pkkxxMaHw6gq6WRYJRNMVLRGql9agiB1cCsVKcV1fgFSjIVCVbnMG9fnvqVKHW
    SxjOsI+snDLkfzU4S8G/xniw+zvJRentZkZdk0kvEmJs45eGU7jZYw4kL0KZZjLV
    Pbvs1/ONaA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfH4pzLVw4JA00BfF1NpHupKUKkli7SNm6VO7uQCOXeXhpuPCHSlE848hNwQ/xTH34TlJfi8B4JX8Xz3RMJTWFJ2Ty7IhtAgkSTgJ9neesrI18le2txz3
    KiR8HxM3tQZbfxawODwPNt5zKfFXJaHpEe/7uk38vyWMyKGoXlgr1EJ3n6IJ99sxyGH9xVFXTJzjuK2tHVBOOJflFTZdEoqR4kHsZQyWX/6SbjA5ff7aBK4X
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=bKAFnZK0T5E61TdS9KAA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeECHDw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 03:03:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43317 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751951AbeECHDv (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 3 May 2018 03:03:51 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        shortcircuit=ham autolearn=disabled version=3.4.0
Date: Thu, 3 May 2018 09:03:48 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: rawnand: marvell: pass ms delay to wait_op
Message-ID: <20180503090348.0c10b00f@bbrezillon>
In-Reply-To: <a40b0454ea78494983c909fd6b2c08c8@svr-chch-ex1.atlnz.lc>
References: <20180503022128.10702-1-chris.packham@alliedtelesis.co.nz>
        <a40b0454ea78494983c909fd6b2c08c8@svr-chch-ex1.atlnz.lc>
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

On Thu, 3 May 2018 05:28:32 +0000
Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:

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

What makes you think they are far too short?

> 
> The old pxa3xx driver had hard coded 200ms delays. These delays now work 
> out to 1ms which seems every bit as wrong as 600000000ms.

The old driver was indifferently waiting a huge amount of time no
matter how long the chip is supposed to stay busy for a specific
operation. Here we're using the value exposed by the chip itself, and
it's not a typical value, it's a max value, which means you should
never reach that in real life, and if you do that means your chip is
stuck for some reasons. Now, if you want to take extra safety margin,
you can multiply the value by 2 and that should be enough, but 200ms is
way too long.

Regards,

Boris
