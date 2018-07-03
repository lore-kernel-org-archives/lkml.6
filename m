Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14F6C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A793620855
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTikrSbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A793620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753611AbeGCXwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:52:43 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45283 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbeGCXwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:52:39 -0400
Received: by mail-oi0-f66.google.com with SMTP id m2-v6so7263328oim.12;
        Tue, 03 Jul 2018 16:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=by6w7PkL0fRtxy100ZXJ1bNcoqEvzq7TVQvUefzJhoM=;
        b=mTikrSbnhgGCuFZ6EBhw7ks/wneUXlhBCzRKfUv6fnetB58cNDEeyvyx0AmmDea8is
         VtI5KfOZgwBu5C0fI7FbyrXhk1rqfKVyXaEaHNJmhk/8i6oVxC/292Rbjp/msfNFLeoK
         9lHZ/qjAUHY2i5x/1pFMn+L0ZYpX/Y4xVzfFIENulpmc5JE98POxz1h7ND+/Cl3C0Jvm
         FW+jGEG7O9Be/HHDMIRGZmNgHZwlBfsMB8PLFZOMfJLgnStEweCFk76eAFie8srmHxxO
         ptbgk6GF2rUM6voDDDV7JP6H4b1GLO7s9tfcgBNweFVU0+sRmhj+aSdYFC1sj5Y79Fwv
         PqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=by6w7PkL0fRtxy100ZXJ1bNcoqEvzq7TVQvUefzJhoM=;
        b=lkay3RM/Z23xitEjw+SYYLGHniVs+Vq+2eXWKHLtm5yIGEeSy/RG77zDrJH1BuMtof
         HIgpHG8DZq6VV3/jsuGupNTsW3WOo9zIqJxMMPmjOEKSeEedNYBF9uWlW4LJcwzr0gHI
         0D7tEKhqx2TbOQybPZJ1UDLhZWnnyNbpIT0rfhqC/xngIOUzs4E2P2xKIhXPKCY+DU1l
         ic0Kn5EwzCmZSuPVpm2RhqOCT/SEOVwMEVOYlqiPOkNuO9nU/x8s7rSDv8ZFgHPgYe56
         EaEdusALynj/1J55C00MFh7HeB32An+0wovpYuKv0Hn5l3dHzIyxzFKM1BzJMR3WA3hg
         Xgag==
X-Gm-Message-State: APt69E0M8u1ZX1Xu2cPUKIqyWjgaC6hPBfrh/cvxg1lH8gTCKEy2pi6K
        G+gXXtWqkNVzpFLz2DDYeYrMWahp3zS1f/Xrm/E=
X-Google-Smtp-Source: AAOMgpcPVBDDB6jMgd8D42g6yHPLoQJRKk2DysOgqp8Vf8B7gujjdJ9Ixk5ETsm9Yx0ZVh4OIDSVIhYXRGW3fz3U/F8=
X-Received: by 2002:aca:4886:: with SMTP id v128-v6mr14585149oia.69.1530661958537;
 Tue, 03 Jul 2018 16:52:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 16:52:37 -0700 (PDT)
In-Reply-To: <c64cd9c9-3eb5-acbd-3578-b32ec39d3ea4@deltatee.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
 <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com> <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
 <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
 <CAOMZO5A4bsu9dXCPb4QeSbnnLi=pr1=WYWn8p2AfU3rEG=RWXg@mail.gmail.com>
 <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com> <CAOMZO5CJ_iG=p_+xL=Q_Rv3F5vtGggsgatar4XVTL+UFVnHBTA@mail.gmail.com>
 <7ddda181-6337-32cc-7a0d-43fc6a7ba78b@deltatee.com> <CAHp75VcN=pUkFK6=_7yErMRGNS3WsgBhkWMSwP0Cw_ZmGR=RJg@mail.gmail.com>
 <c64cd9c9-3eb5-acbd-3578-b32ec39d3ea4@deltatee.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 3 Jul 2018 20:52:37 -0300
Message-ID: <CAOMZO5CGT7TbpWEAWEA7qTxuGO1mog_QDhG-e0MuDDckUS2W3A@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-ntb@googlegroups.com,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 8:20 PM, Logan Gunthorpe <logang@deltatee.com> wrote:

> Oh. So some IO in some other place must have changed to trigger the BUG...

Yes, there are two 64-bit write operations inside caam_jr_init().

If I use the old 64-bit write function then things works fine:

--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -384,6 +384,17 @@ int caam_jr_enqueue(struct device *dev, u32 *desc,
 }
 EXPORT_SYMBOL(caam_jr_enqueue);

+static inline void wr_reg64old(void __iomem *reg, u64 data)
+{
+       if (!caam_imx && caam_little_end) {
+               wr_reg32((u32 __iomem *)(reg) + 1, data >> 32);
+               wr_reg32((u32 __iomem *)(reg), data);
+       } else {
+               wr_reg32((u32 __iomem *)(reg), data >> 32);
+               wr_reg32((u32 __iomem *)(reg) + 1, data);
+ }
+}
+
 /*
  * Init JobR independent of platform property detection
  */
@@ -434,8 +445,8 @@ static int caam_jr_init(struct device *dev)
  jrp->head = 0;
  jrp->tail = 0;

- wr_reg64(&jrp->rregs->inpring_base, inpbusaddr);
- wr_reg64(&jrp->rregs->outring_base, outbusaddr);
+ wr_reg64old(&jrp->rregs->inpring_base, inpbusaddr);
+ wr_reg64old(&jrp->rregs->outring_base, outbusaddr);
  wr_reg32(&jrp->rregs->inpring_size, JOBR_DEPTH);
  wr_reg32(&jrp->rregs->outring_size, JOBR_DEPTH);
