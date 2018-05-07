Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-474343-1525679028-2-4378378630639946580
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525679026; b=Pr2xWoMkmKJZS34RZRdSurv7d8wyMb9DBdoH8xYtfQNRp9AhaW
    zLbI+VxQ0M+ltvMMbl6R45kSGvwRawZC7+Fd+aozi0kYhPHQ0Fx8nkJ5TlwJDW2q
    qdIVwxi70UdigL30/IHaCgjgAosyh5fqfev6HXSxFv5UvC+QZgPpM0NFaPLplIKW
    82bPCpfz9zGjOCk4G2duCHRuuVhH7vBOnoXTe/YpPkB0udcWLy3k1ci/JgiSmhQ1
    7rT4NB38pgPpcAbPE1BeMS0Gb2pyN+42INzWE4KqE1hYrbgl3/tlg90SMv96VkOe
    uLx7KBkOm+Euxr/Rd2JrTbFimkG/o1g6AWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525679026;
    bh=FlMMbH/cUOmuq9kVLwCWVfFPknLVWq9kT2+8iKXtUGY=; b=D7JxKPA9sVL+
    EEpbpP1992fy1bQR5Vr2xcM3dRe5PRLCB/vt80g8FxWSzWcbP50FGWRCvNN5O6ra
    iYvkX0hiHNUPm9cc1I79TM2LMz2nSMZNU9Wliugbb92jYu1058jGEFHbB4lGc/Yz
    vMw4QMv6E+tEUaduJ0y9JTfFb96qmPZ4cIQEbInCebG0nkBm5pmmqpgZr6WrKeFZ
    sK1qSqTP82B5BLIuwgxKWK2mym3S39DZiQu7hikB75Aa4STN6HG2oR4ea3BbVB9I
    axdMzgi/uoHlWG9yyU/PsfyUhLESBOOMyKNLy0HumfNeZRNHOGt/p88867lA/s3L
    fN/1hWNdDg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfC7+6UEDvGx9xc0B+dhAegc9aSk9jdxYc1z3wnumdGcfOAF4/tYbeKosO9H19PGs9HVId5yk+b1jPANq1CZ41rruGbSxJtj2n+0f2t6HZyVVPsBCD4ue
    AEZ2gdcg8UEr5SxTvSmy+2Z8XZoNrQFr6M69/dZWzmJp0AQ54bgeSL8jjBSRseI0rHUq4Rqez6SzuEagm3jA4JnpE7pDfEql3wFXA0dmMCffWjFiBCEYAUKQ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=TIl4Hnxuo0HmVeGklr4A:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750904AbeEGHnp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 03:43:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44564 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750716AbeEGHno (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 7 May 2018 03:43:44 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        shortcircuit=ham autolearn=disabled version=3.4.0
Date: Mon, 7 May 2018 09:41:42 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org,
        stable@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: marvell: pass ms delay to wait_op
Message-ID: <20180507094142.756b70ad@bbrezillon>
In-Reply-To: <20180503022128.10702-1-chris.packham@alliedtelesis.co.nz>
References: <20180503022128.10702-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu,  3 May 2018 14:21:28 +1200
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> marvell_nfc_wait_op() expects the delay to be expressed in milliseconds
> but nand_sdr_timings uses picoseconds. Use PSEC_TO_MSEC when passing
> tPROG_max to marvell_nfc_wait_op().
> 
> Fixes: 02f26ecf8c772 ("mtd: nand: add reworked Marvell NAND controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Queued to mtd/fixes.

Thanks,

Boris

> ---
>  drivers/mtd/nand/raw/marvell_nand.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
> index 1d779a35ac8e..e4b964fd40d8 100644
> --- a/drivers/mtd/nand/raw/marvell_nand.c
> +++ b/drivers/mtd/nand/raw/marvell_nand.c
> @@ -1074,7 +1074,7 @@ static int marvell_nfc_hw_ecc_hmg_do_write_page(struct nand_chip *chip,
>  		return ret;
>  
>  	ret = marvell_nfc_wait_op(chip,
> -				  chip->data_interface.timings.sdr.tPROG_max);
> +				  PSEC_TO_MSEC(chip->data_interface.timings.sdr.tPROG_max));
>  	return ret;
>  }
>  
> @@ -1494,7 +1494,7 @@ static int marvell_nfc_hw_ecc_bch_write_page(struct mtd_info *mtd,
>  	}
>  
>  	ret = marvell_nfc_wait_op(chip,
> -				  chip->data_interface.timings.sdr.tPROG_max);
> +				  PSEC_TO_MSEC(chip->data_interface.timings.sdr.tPROG_max));
>  
>  	marvell_nfc_disable_hw_ecc(chip);
>  
