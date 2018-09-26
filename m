Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82823C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C28208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C28208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sf-tec.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeIZNob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:44:31 -0400
Received: from mail.sf-mail.de ([78.47.74.12]:40757 "EHLO mail.sf-mail.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbeIZNoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:44:30 -0400
Received: (qmail 14520 invoked from network); 26 Sep 2018 07:26:14 -0000
Received: from mail.sf-mail.de ([::ffff:78.47.74.12]:60248 HELO webmail.sf-mail.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.34dev) with (DHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA
        for <leobras.c@gmail.com>; Wed, 26 Sep 2018 09:26:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 26 Sep 2018 09:26:09 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>
Cc:     lkcamp@lists.libreplanetbr.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Robert Richter <rric@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-parisc-owner@vger.kernel.org
Subject: Re: [PATCH 6/7] drivers: oprofile: Avoids building driver from direct
 make command
In-Reply-To: <20180926015305.GA14994@WindFlash>
References: <20180926015305.GA14994@WindFlash>
Message-ID: <bf054e64b8284ce5da5f0c361fbb3ee6@sf-tec.de>
X-Sender: eike-kernel@sf-tec.de
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leonardo Brás wrote:
> Creates new Makefile to avoid building driver if
> 'make drivers/oprofile/' is called directly.
> 
> This driver is usually built from arch/$ARCH and seems to have
> no meaning building alone.
> 
> Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
> ---
>  drivers/oprofile/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 drivers/oprofile/Makefile
> 
> diff --git a/drivers/oprofile/Makefile b/drivers/oprofile/Makefile
> new file mode 100644
> index 000000000000..6b36c93e9762
> --- /dev/null
> +++ b/drivers/oprofile/Makefile
> @@ -0,0 +1 @@
> +#Does nothing, since the source is called from arch/$ARCH/ tree.
> \ No newline at end of file
     ^^^^^^^^^^^^^^^^^^^^^^^^^

Is that intentional or bogus?

Eike
