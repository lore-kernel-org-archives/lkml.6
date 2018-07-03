Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27D9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44A4247C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44A4247C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753560AbeGCX6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:58:08 -0400
Received: from ale.deltatee.com ([207.54.116.67]:37892 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752387AbeGCX6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:58:06 -0400
Received: from s0106602ad0811846.cg.shawcable.net ([68.147.191.165] helo=[192.168.0.18])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1faVBF-0003lq-MD; Tue, 03 Jul 2018 17:57:58 -0600
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-ntb@googlegroups.com,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
References: <20180622194752.11221-1-logang@deltatee.com>
 <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
 <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com>
 <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
 <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
 <CAOMZO5A4bsu9dXCPb4QeSbnnLi=pr1=WYWn8p2AfU3rEG=RWXg@mail.gmail.com>
 <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com>
 <CAOMZO5CJ_iG=p_+xL=Q_Rv3F5vtGggsgatar4XVTL+UFVnHBTA@mail.gmail.com>
 <7ddda181-6337-32cc-7a0d-43fc6a7ba78b@deltatee.com>
 <CAHp75VcN=pUkFK6=_7yErMRGNS3WsgBhkWMSwP0Cw_ZmGR=RJg@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <991b2298-bb3f-dad3-c93b-b43ee5f372de@deltatee.com>
Date:   Tue, 3 Jul 2018 17:57:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcN=pUkFK6=_7yErMRGNS3WsgBhkWMSwP0Cw_ZmGR=RJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: davem@davemloft.net, herbert@gondor.apana.org.au, dan.douglass@nxp.com, horia.geanta@nxp.com, gregkh@linuxfoundation.org, arnd@arndb.de, linux-crypto@vger.kernel.org, linux-ntb@googlegroups.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, festevam@gmail.com, andy.shevchenko@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/07/18 04:21 PM, Andy Shevchenko wrote:
> It is an explicit call to BUG().
> That's why we see wrong instruction trap.

Ok, I think I see the problem... the code is rather confusing:

Prior to the patch, IOs were BE depending on caam_little_end but if
caam_imx was set, then it wrote two LE writes with the high one first.
After the patch, it writes two BE writes with the high one first.

To confirm, can you try the patch below?

If this is the case, we can either revert the commit or fold in this
patch depending on what others think is clearer.

Thanks,

Logan

--

diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index 5826acd9194e..5f70c460da25 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -138,10 +138,14 @@ static inline void clrsetbits_32(void __iomem
*reg, u32 clear, u32 set)
  */
 static inline void wr_reg64(void __iomem *reg, u64 data)
 {
-       if (!caam_imx && caam_little_end)
+       if (caam_imx && caam_little_end) {
+               iowrite32(data >> 32, reg);
+               iowrite32(data, reg + sizeof(u32));
+       } else if (caam_little_end) {
                iowrite64(data, reg);
-       else
+       } else {
                iowrite64be(data, reg);
+       }
 }

 static inline u64 rd_reg64(void __iomem *reg)
