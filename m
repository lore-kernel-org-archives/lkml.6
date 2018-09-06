Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30699C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31052075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="An/LP6C+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31052075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeIFOLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:11:08 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:59052 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeIFOLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:11:08 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 2B4F525AD5C;
        Thu,  6 Sep 2018 19:36:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1536226591; bh=MiGDo05rXK3jbk3kzd16Qq4Z2YUnoY9JuYc52Zx47uY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=An/LP6C+v1LNJjoAib9CevtINoe4aolWkvxfifRX5tx0DPxajLI97bwzElwhgX3MP
         KhFkP+ZYSf0Jyr40vUDEqhds9X4+XCeXf49z4TsZrTEAyF4SCGDQn7SvS6Axe/nYsy
         3MJZykskDBpA6GxAqj1hZJXabXJy99CEZDm95utI=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 13D809404AF; Thu,  6 Sep 2018 11:36:29 +0200 (CEST)
Date:   Thu, 6 Sep 2018 11:36:28 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] ARM: dts: r9a06g032: Add pinctrl node
Message-ID: <20180906093628.e6v4pu3lpubf54e4@verge.net.au>
References: <1535634775-19365-4-git-send-email-phil.edworthy@renesas.com>
 <201808310827.o3GAs37i%fengguang.wu@intel.com>
 <TY1PR01MB1769AF7EB0152AF03B7B77C3F50F0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1769AF7EB0152AF03B7B77C3F50F0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 08:13:07AM +0000, Phil Edworthy wrote:
> 
> On 31 August 2018 01:51 kbuild test robot wrote:
> > Hi Phil,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on pinctrl/devel] [also build test ERROR on v4.19-rc1
> > next-20180830] [if your patch is applied to the wrong git tree, please drop us
> > a note to help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Phil-Edworthy/Renesas-
> > R9A06G032-PINCTRL-Driver/20180831-050708
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-
> > pinctrl.git devel
> > config: arm-mvebu_v5_defconfig (attached as .config)
> > compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-
> > tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.2.0 make.cross ARCH=arm
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> Error: arch/arm/boot/dts/r9a06g032.dtsi:93.23-24 syntax error
> >    FATAL ERROR: Unable to parse input tree
> 
> This error is because the patch depends on a patch from Geert:
> "ARM: dts: r9a06g032: Use r9a06g032-sysctrl binding definitions"
> https://patchwork.kernel.org/patch/10578707/

Thanks Phil,

got it. I would like to wait for the binding to be acked before
applying this patch.
