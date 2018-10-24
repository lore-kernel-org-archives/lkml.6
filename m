Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3307C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779C82082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X1++C6TD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MasBYQYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779C82082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeJXTmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:42:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44992 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeJXTmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:42:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9E54C611F1; Wed, 24 Oct 2018 11:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540379678;
        bh=7s4If7GiKbGlZKWzHlk27ZK7BKpycVnco5G3+lPDQd4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X1++C6TDYx/3pwRBtDTw6jZzHUTOmismBgLoTcY3ikDbTbXeb11dnctnnGS4JnDEO
         m8seDhze6LOGrUejykACGeUHCagGblK5XV2e2PkDstm4f40BGrmI52Wf2Go5SQAM2S
         /0RYnOpipwafR8qtPqQFgMNpC9aSQkbolzjWTgbw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 70830606DC;
        Wed, 24 Oct 2018 11:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540379677;
        bh=7s4If7GiKbGlZKWzHlk27ZK7BKpycVnco5G3+lPDQd4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MasBYQYc50KA+aC/au/nn9w8P0crBfxR6Bb1NU6ur2SpsvAM0QwOux93w7BVq31lf
         GBakTm1dc+0dZadUIPd1VKXeFvrew6fX/4iqgNlwmwd/jCaPir40M4eBxmd/YJa09y
         i1RyF6ddS24YbizYF7kxYQS7qLboTBqP+0iR3VLY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 24 Oct 2018 16:44:37 +0530
From:   anilc@codeaurora.org
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, andy.gross@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] crypto: qce: ice: Add support for Inline Crypto
 Engine
In-Reply-To: <201810181902.44DQrfDL%fengguang.wu@intel.com>
References: <1539789476-6098-4-git-send-email-anilc@codeaurora.org>
 <201810181902.44DQrfDL%fengguang.wu@intel.com>
Message-ID: <d6f1930a618f6539a4c3e53d239fdd90@codeaurora.org>
X-Sender: anilc@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the comments, response inline.

Thanks,
AnilKumar


On 2018-10-18 17:13, kbuild test robot wrote:
> Hi AnilKumar,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on cryptodev/master]
> [also build test ERROR on v4.19-rc8 next-20181018]
> [if your patch is applied to the wrong git tree, please drop us a note
> to help improve the system]
> 
> url:
> https://github.com/0day-ci/linux/commits/AnilKumar-Chimata/firmware-qcom-scm-Update-qcom_scm_call-signature/20181018-182318
> base:
> https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> master
> config: sh-allmodconfig (attached as .config)
> compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=sh
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/crypto/qce/ice.c:1372:5: error: redefinition of 
>>> 'qcom_ice_setup_ice_hw'
>     int qcom_ice_setup_ice_hw(const char *storage_type, int enable)
>         ^~~~~~~~~~~~~~~~~~~~~
>    In file included from drivers/crypto/qce/ice.c:25:0:
>    include/crypto/ice.h:60:19: note: previous definition of
> 'qcom_ice_setup_ice_hw' was here
>     static inline int qcom_ice_setup_ice_hw(const char *storage_type,
> int enable)
>                       ^~~~~~~~~~~~~~~~~~~~~
> 
> vim +/qcom_ice_setup_ice_hw +1372 drivers/crypto/qce/ice.c
> 
>   1371
>> 1372	int qcom_ice_setup_ice_hw(const char *storage_type, int enable)
>   1373	{
>   1374		struct ice_device *ice_dev = NULL;
>   1375		int ret = -1;
>   1376
>   1377		ice_dev = get_ice_device_from_storage_type(storage_type);
>   1378		if (ice_dev == ERR_PTR(-EPROBE_DEFER))
>   1379			return -EPROBE_DEFER;
>   1380
>   1381		if (!ice_dev)
>   1382			return ret;
>   1383
>   1384		if (enable)
>   1385			return enable_ice_setup(ice_dev);
>   1386
>   1387		return disable_ice_setup(ice_dev);
>   1388	}
>   1389

We will check and get back on the compilation. What is the idea behind 
for this
effort, is this for testing the ICE driver? If so, this is not possible 
as  ICE
module is inline with storage controller and hence testing has to 
trigger from
Storage controller/driver. So testing crypto functionality (AES-XTS and 
AES-CBC)
with cryptodev is not possible with this driver.

> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology 
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel 
> Corporation
