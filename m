Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2432810-1521451807-2-9135787090787685694
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521451807; b=IFwkmO5KgXdE9vPEOyPWgSoL0uB0SINzSM1gGKJqPEuT6MN
    FnyJpIMS/z1LIhl1SYmAInY4EgQAHXzSZbvumapREXuYE9NWjd7UbyZdhTNd42mF
    0sH9pr+JOeeOvMIcOFLvzLOE76gHFwoYWEYpqBnL5MDeoaSAoakxSKj+P+2NUVcQ
    lsqkM+edNKw7en+KJbx2bhDPhZDon1IKDdFB/UF0qRkF+5l7OktBM+fp2RT/FKgT
    WYgWeYWkfWr0WMuCLZhi0KA54uv6gvKdPFm6qL02Ugz/s+S6J1gMWpmWJ0D67Fjq
    xS/Qb1oYhf690z/JxXSDVphOO9W1UkFu0qUnr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521451807; bh=tRfKKD9snMqQclgLwZ++8aFXzpEWVRpRGWSW93XIp/g=; b=n
    VdbKmAIOcOvY8ZNCvR2sfVWT7oQZNZMD6mBPTubJRgaCU8J3mWNuB5fd4jRgs00V
    z4PYYefwwATzZK5YmZqFweUpR3EDFEcX84UKKHcpQB7jyEB9t+aSOVTM44DGuL/N
    SKT7BCNBvQJ+aJH1GajKFbqr0o3DIVEEaTGN8p5po1xTxTiIMu1Cclj34cpRj+Xt
    xAtIcs0lPYUIKkBrULpWVTkM6UQ8Uv4HapOsrojCbLHJPzVj35i4a/1wCGLRfofK
    zyWnYFJzwsM40PHE/ARh2ex2+uSv5aWcw9Xsyj1/aft0r3/8Yl38IHmNDcOEMfgo
    QbzqBkgK73hze2+DdQVbA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddtudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhsphejsehtjeertdertddvnecuhfhrohhmpeeuohhrihhsuceurhgviihilhhlohhnuceosghorhhishdrsghrvgiiihhllhhonhessghoohhtlhhinhdrtghomheqnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdeifedrvdduiedrkeejnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfeehheehnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddtudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhsphejsehtjeertdertddvnecuhfhrohhmpeeuohhrihhsuceurhgviihilhhlohhnuceosghorhhishdrsghrvgiiihhllhhonhessghoohhtlhhinhdrtghomheqnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdeifedrvdduiedrkeejnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfeehheehnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932867AbeCSJaE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 05:30:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52354 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932787AbeCSJaD (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 05:30:03 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT,
        URIBL_BLOCKED shortcircuit=ham autolearn=disabled version=3.4.0
Date: Mon, 19 Mar 2018 10:30:00 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: OuYang ZhiZhong <ouyzz@yealink.com>
Cc: <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <boris.brezillon@free-electrons.com>, <marek.vasut@gmail.com>,
        <richard@nod.at>, <cyrille.pitchen@wedev4u.fr>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <oyzhizhong@gmail.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v4] mtdchar: fix usage of mtd_ooblayout_ecc()
Message-ID: <20180319103000.2c1902f7@bbrezillon>
In-Reply-To: <1520755147-4414-1-git-send-email-ouyzz@yealink.com>
References: <1520755147-4414-1-git-send-email-ouyzz@yealink.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 11 Mar 2018 15:59:07 +0800
OuYang ZhiZhong <ouyzz@yealink.com> wrote:

> Section was not properly computed. The value of OOB region definition is
> always ECC section 0 information in the OOB area, but we want to get all
> the ECC bytes information, so we should call
> mtd_ooblayout_ecc(mtd, section++, &oobregion) until it returns -ERANGE.

Applied.

Thanks,

Boris

> 
> Fixes: c2b78452a9db ("mtd: use mtd_ooblayout_xxx() helpers where appropriate")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: OuYang ZhiZhong <ouyzz@yealink.com>
> ---
>  drivers/mtd/mtdchar.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
> index de8c902..7d80a8b 100644
> --- a/drivers/mtd/mtdchar.c
> +++ b/drivers/mtd/mtdchar.c
> @@ -479,7 +479,7 @@ static int shrink_ecclayout(struct mtd_info *mtd,
>  	for (i = 0; i < MTD_MAX_ECCPOS_ENTRIES;) {
>  		u32 eccpos;
>  
> -		ret = mtd_ooblayout_ecc(mtd, section, &oobregion);
> +		ret = mtd_ooblayout_ecc(mtd, section++, &oobregion);
>  		if (ret < 0) {
>  			if (ret != -ERANGE)
>  				return ret;
> @@ -526,7 +526,7 @@ static int get_oobinfo(struct mtd_info *mtd, struct nand_oobinfo *to)
>  	for (i = 0; i < ARRAY_SIZE(to->eccpos);) {
>  		u32 eccpos;
>  
> -		ret = mtd_ooblayout_ecc(mtd, section, &oobregion);
> +		ret = mtd_ooblayout_ecc(mtd, section++, &oobregion);
>  		if (ret < 0) {
>  			if (ret != -ERANGE)
>  				return ret;



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
