Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeFANel (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:34:41 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:47026 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbeFANeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:34:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Jun 2018 15:34:33 +0200
From: Stefan Agner <stefan@agner.ch>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pgaikwad@nvidia.com,
        dev@lynxeye.de, mirza.krak@gmail.com, benjamin.lindqvist@endian.se,
        pdeschrijver@nvidia.com, miquel.raynal@bootlin.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, jonathanh@nvidia.com,
        marek.vasut@gmail.com, thierry.reding@gmail.com,
        linux-mtd@lists.infradead.org, krzk@kernel.org, richard@nod.at,
        linux-tegra@vger.kernel.org, digetx@gmail.com,
        computersforpeace@gmail.com, dwmw2@infradead.org, marcel@ziswiler.com
Subject: Re: [PATCH v3 1/6] mtd: rawnand: add Reed-Solomon error correction
 algorithm
In-Reply-To: <20180601112506.2157e8b0@bbrezillon>
References: <20180531221637.6017-1-stefan@agner.ch>
 <20180531221637.6017-2-stefan@agner.ch> <20180601092600.03c14f53@bbrezillon>
 <20180601112506.2157e8b0@bbrezillon>
Message-ID: <18ce3100aabf42059dbd514fb8c93e84@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[22];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.2018 11:25, Boris Brezillon wrote:
> On Fri, 1 Jun 2018 09:26:00 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> 
>> On Fri,  1 Jun 2018 00:16:32 +0200
>> Stefan Agner <stefan@agner.ch> wrote:
>>
>> > Add Reed-Solomon (RS) to the enumeration of ECC algorithms.
>> >
>> > Signed-off-by: Stefan Agner <stefan@agner.ch>
>>
>> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
>>
>> > ---
>> >  drivers/mtd/nand/raw/nand_base.c | 1 +
>> >  include/linux/mtd/rawnand.h      | 1 +
> 
> Hm, you forgot to update Documentation/devicetree/bindings/mtd/nand.txt.
> 

Yeah I was not sure about that. Currently it says:

- nand-ecc-algo: string, algorithm of NAND ECC.                         
                                                                   
                 Supported values are: "hamming", "bch".

Is supported meant by software ECC here? I feel "supported" is a rather
strong word since it is clearly controller dependent whether it is
actually supported...

--
Stefan

>> >  2 files changed, 2 insertions(+)
>> >
>> > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
>> > index f28c3a555861..9eb5678dd6d0 100644
>> > --- a/drivers/mtd/nand/raw/nand_base.c
>> > +++ b/drivers/mtd/nand/raw/nand_base.c
>> > @@ -5744,6 +5744,7 @@ static int of_get_nand_ecc_mode(struct device_node *np)
>> >  static const char * const nand_ecc_algos[] = {
>> >  	[NAND_ECC_HAMMING]	= "hamming",
>> >  	[NAND_ECC_BCH]		= "bch",
>> > +	[NAND_ECC_RS]		= "rs",
>> >  };
>> >
>> >  static int of_get_nand_ecc_algo(struct device_node *np)
>> > diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
>> > index 5dad59b31244..6a82da8c44ce 100644
>> > --- a/include/linux/mtd/rawnand.h
>> > +++ b/include/linux/mtd/rawnand.h
>> > @@ -114,6 +114,7 @@ enum nand_ecc_algo {
>> >  	NAND_ECC_UNKNOWN,
>> >  	NAND_ECC_HAMMING,
>> >  	NAND_ECC_BCH,
>> > +	NAND_ECC_RS,
>> >  };
>> >
>> >  /*
>>
>>
>> ______________________________________________________
>> Linux MTD discussion mailing list
>> http://lists.infradead.org/mailman/listinfo/linux-mtd/
