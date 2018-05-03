Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1890012-1525325320-2-309954295071193911
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='nz',
  MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525325319; b=kNjxsoQcixtVpIdv7PfsJF6iM/xPHXAlFthLSMQ6TYdIyDTyB6
    utxHbCQuVLIaPzE+Ob8MPgvKvN5bbzI6AM/Jd0+xEOG4OqtB4dsn+G0nao6CQN1b
    Zq2NbhRZtW1wG07hER2tFPL9+EIXcx7lO8jWOF+MT8EINq9O+p3DkGQVWdRtkRJH
    OjDpKgaFuCJR6oHgr/7OTqR72BKy4KBh/FhEanhO6xTch+/ILCmOIEFVVgX/ZqMN
    CK7ein9HETvN+bTWp9vzTd3WVFXjuROI3Tx8s1hF8j6+cGzWaFUgdeX8tbmFf1y6
    4kfuySWpBjbtO8jncGuv4Lxe4sMO6joDJyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:content-type:content-transfer-encoding:mime-version
    :sender:list-id; s=fm2; t=1525325319; bh=c8AC+WnEgd6cQnZLZcJoaQM
    HG5JkGNEIADpcBcTLFaA=; b=M0UIUCeGrJQ5SkwyD60gk8vx9igQjKtgjHPWE2j
    qKfLeDUIQG3Lkpkf8BMN/qZhFXtHuFUXXRidCPaTbk+clcSA2RQFq1qBqbZqtJrC
    oxBzlgwtaDgzn3E2xcLKPaV+ITEsShIfIUxkL5HW6tJ7HOnbynRc6AVTyPczkKPV
    P3zgTqL473EqAKJ0MkXe5NgJkUjFZneUA4UVNVFQPkC3C0GFAyke1sYT7zmua5rJ
    EuC2TO8F1yzdpiCIl3wC612SLHmsQrFyNAmGPA3rIIEK+7+wbhS9lOVafoZQp6p7
    lXy0dU5A8JLZplbfhug4zJiMrtvmaiFQOr6Dp2raD+2dWpA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=alliedtelesis.co.nz
    header.i=@alliedtelesis.co.nz header.b=Rgtc4iaR x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none)
    header.from=alliedtelesis.co.nz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=alliedtelesis.co.nz header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-74 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=alliedtelesis.co.nz
      header.i=@alliedtelesis.co.nz header.b=Rgtc4iaR x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none)
      header.from=alliedtelesis.co.nz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=alliedtelesis.co.nz header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-74 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJodFuu95sqdsmzq9rMEksj1hvXI7qfu09/LcE7lmk/E239jblAovF+Q3D/RgXdij1bgUFrFinD3tpAsemt0ALeyrgWZnBd2ShkFqlvrcqL5NpKeZKPy
    n+BsUjj4+eXXYnX4EHj4Wv5Tl6WWYv0GldZEh37pmZoJ6cXucSq983d5cXhb09Qtw63s7pbfnB+mK3nwshASS0JjGeweYvxQHFO6aKQWnFWkXGEjjmDNIDvl
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=TIl4Hnxuo0HmVeGklr4A:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeECF2f (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 01:28:35 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47511 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbeECF2e (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 3 May 2018 01:28:34 -0400
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>
CC: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: rawnand: marvell: pass ms delay to wait_op
Thread-Topic: [PATCH] mtd: rawnand: marvell: pass ms delay to wait_op
Thread-Index: AQHT4oV62h526cMoz0uIXW1ERTIqCw==
Date: Thu, 3 May 2018 05:28:32 +0000
Message-ID: <a40b0454ea78494983c909fd6b2c08c8@svr-chch-ex1.atlnz.lc>
References: <20180503022128.10702-1-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/18 14:21, Chris Packham wrote:=0A=
> marvell_nfc_wait_op() expects the delay to be expressed in milliseconds=
=0A=
> but nand_sdr_timings uses picoseconds. Use PSEC_TO_MSEC when passing=0A=
> tPROG_max to marvell_nfc_wait_op().=0A=
> =0A=
> Fixes: 02f26ecf8c772 ("mtd: nand: add reworked Marvell NAND controller dr=
iver")=0A=
> Cc: stable@vger.kernel.org=0A=
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
> ---=0A=
>   drivers/mtd/nand/raw/marvell_nand.c | 4 ++--=0A=
>   1 file changed, 2 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/m=
arvell_nand.c=0A=
> index 1d779a35ac8e..e4b964fd40d8 100644=0A=
> --- a/drivers/mtd/nand/raw/marvell_nand.c=0A=
> +++ b/drivers/mtd/nand/raw/marvell_nand.c=0A=
> @@ -1074,7 +1074,7 @@ static int marvell_nfc_hw_ecc_hmg_do_write_page(str=
uct nand_chip *chip,=0A=
>   		return ret;=0A=
>   =0A=
>   	ret =3D marvell_nfc_wait_op(chip,=0A=
> -				  chip->data_interface.timings.sdr.tPROG_max);=0A=
> +				  PSEC_TO_MSEC(chip->data_interface.timings.sdr.tPROG_max));=0A=
>   	return ret;=0A=
>   }=0A=
>   =0A=
> @@ -1494,7 +1494,7 @@ static int marvell_nfc_hw_ecc_bch_write_page(struct=
 mtd_info *mtd,=0A=
>   	}=0A=
>   =0A=
>   	ret =3D marvell_nfc_wait_op(chip,=0A=
> -				  chip->data_interface.timings.sdr.tPROG_max);=0A=
> +				  PSEC_TO_MSEC(chip->data_interface.timings.sdr.tPROG_max));=0A=
>   =0A=
>   	marvell_nfc_disable_hw_ecc(chip);=0A=
>   =0A=
=0A=
Actually I'm not so sure about this patch. While passing the pico-second =
=0A=
value for tPROG_max is clearly wrong and leads to seemingly indefinite =0A=
hangs on some systems. Converting the times to micro-seconds leaves us =0A=
with delays that are far too short.=0A=
=0A=
The old pxa3xx driver had hard coded 200ms delays. These delays now work =
=0A=
out to 1ms which seems every bit as wrong as 600000000ms.=0A=
=0A=
