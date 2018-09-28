Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AAAC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA008215F0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Gq8U9rHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA008215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbeI1Nho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:37:44 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53086 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728813AbeI1Nho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:37:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 002E58EE267;
        Fri, 28 Sep 2018 00:15:22 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xYfAv1yIy9AE; Fri, 28 Sep 2018 00:15:21 -0700 (PDT)
Received: from [172.20.5.140] (unknown [46.218.58.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D9C928EE0CE;
        Fri, 28 Sep 2018 00:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1538118921;
        bh=hN0XTO1lKhzoem1eoE1Wjm8HabC9Uf9ZBsrLDrLVMdM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Gq8U9rHcGJ58nt/Gj92pVF0iGMhfnJxvzwulKrOA7n3iRMnsLM95xEM5mUyrVz7KU
         prvbNng897gAYWQy/EY4uTd3BCbXozWqNLIC9FhQhu5JktHEXS9DEdU0blFTnkpBwn
         AOG7054fWYnRQ1w8VcjNrqmygWtjWGNYEpihMuy4=
Message-ID: <1538118915.3593.4.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 3/7] drivers: parisc: Avoids building driver if
 CONFIG_PARISC is disabled
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>,
        lkcamp@lists.libreplanetbr.org
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Robert Richter <rric@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org
Date:   Fri, 28 Sep 2018 09:15:15 +0200
In-Reply-To: <20180928020816.11251-4-leobras.c@gmail.com>
References: <20180928020816.11251-1-leobras.c@gmail.com>
         <20180928020816.11251-4-leobras.c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-09-27 at 23:08 -0300, Leonardo Brás wrote:
> Avoids building driver if 'make drivers/parisc/' is called and
> CONFIG_PARISC is disabled.

Is that really a problem? The drivers/Makefile has this:

obj-$(CONFIG_PARISC)		+= parisc/ 
And you just overrode that by forcing the build.  It's not even clear
we should refuse the build in that case; how would we know you don't
have a legitimate reason for the override? 

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
> ---
>  drivers/parisc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/parisc/Makefile b/drivers/parisc/Makefile
> index 3cd5e6cb8478..80049d763aa0 100644
> --- a/drivers/parisc/Makefile
> +++ b/drivers/parisc/Makefile
> @@ -24,5 +24,5 @@ obj-$(CONFIG_EISA)		+= eisa.o
> eisa_enumerator.o eisa_eeprom.o
>  obj-$(CONFIG_SUPERIO)		+= superio.o
>  obj-$(CONFIG_CHASSIS_LCD_LED)	+= led.o
>  obj-$(CONFIG_PDC_STABLE)	+= pdc_stable.o
> -obj-y				+= power.o
> +obj-$(CONFIG_PARISC)		+= power.o

If we conclude the use case is legitimate, that's not enough: the two
inner symbols are PARISC only but CONFIG_EISA isn't.

James

