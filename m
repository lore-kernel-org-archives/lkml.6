Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B200C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26FA20846
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="l8BgFBvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26FA20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbeGKJK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:10:27 -0400
Received: from onstation.org ([52.200.56.107]:38584 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbeGKJK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:10:26 -0400
Received: from localhost (c-98-236-77-125.hsd1.wv.comcast.net [98.236.77.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id ABE1411;
        Wed, 11 Jul 2018 09:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1531300027;
        bh=3t86zNmKhiDESpFDVD610QUx6egdIxNaRb1msVd8w0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l8BgFBvcl2hE/gzwRUCYJZ7u1PIs7y9l0O5GumS2iAl2mPMg0x64jrs2/4wupefL2
         pjOGNnUC8SjyypDxLLLlI9vXbFS388yM/enW6j3hjbgTVxXyGy+8Eoy8JDNGNmnZKa
         dVKuHu8EmDhqIod+bwklhIHlGWoV87pnqHlatncg=
Date:   Wed, 11 Jul 2018 05:07:06 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, jic23@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com
Subject: Re: [PATCH 2/3] iio: imu: mpu6050: add support for regulator
 framework
Message-ID: <20180711090706.fqflz4nzpypuwywj@d08157822050>
References: <20180711010932.20313-3-masneyb@onstation.org>
 <201807111656.iDIpGrc7%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201807111656.iDIpGrc7%fengguang.wu@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 04:50:22PM +0800, kbuild test robot wrote:
> Hi Brian,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on iio/togreg]
> [also build test ERROR on next-20180710]
> [cannot apply to v4.18-rc4]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Brian-Masney/iio-imu-mpu6050-add-support-for-6515-variant/20180711-092023
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: x86_64-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: "inv_mpu_core_remove" [drivers/iio/imu/inv_mpu6050/inv-mpu6050-spi.ko] undefined!
> >> ERROR: "inv_mpu_core_remove" [drivers/iio/imu/inv_mpu6050/inv-mpu6050-i2c.ko] undefined!

This patch applies cleanly against the iio/testing branch.

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing

Brian
