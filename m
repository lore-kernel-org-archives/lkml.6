Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BED2C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D912082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TsJEq255";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="epmax0uZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D912082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeJ2WTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:19:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33672 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbeJ2WTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:19:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EEA2F60792; Mon, 29 Oct 2018 13:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540819869;
        bh=UTXbnuN9i/rJ2HtSZNAr6K2f7eHoWK0n7gJL7vW8ATo=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=TsJEq255Y07EssVXu8XCvLLZqM8SHfp1D5Q35Phg7O9nZHpNRSziYtq5Yyz+SizwZ
         YQ6PWdtJFoLdC66r4rORJvXHoiLgvn+ZiixAPxMVAhhtPxZwn42DF5XGt30jfDBUiX
         cmVVA8pS125eZL3+6XpZMQY3vgFfIuuggM3GLL5Y=
Received: from [10.206.28.53] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anilc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F18866043F;
        Mon, 29 Oct 2018 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540819868;
        bh=UTXbnuN9i/rJ2HtSZNAr6K2f7eHoWK0n7gJL7vW8ATo=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=epmax0uZdmlnUAQgR5eY1RftiPuF3nXWq3IafMH9DIgbwlEtjmbyf3xbfwl3AY5ST
         pUTiHrGHOnW1lz/XVtHL8LfpwhzaJJb46OQTD66qsIehsFpUf6oPiQ+l1J9owC9O2e
         S7PSyXHpd+WdJC2bZZt4daeCGrFD5aL5d/jire2c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F18866043F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anilc@codeaurora.org
From:   AnilKumar Chimata <anilc@codeaurora.org>
Subject: Re: [PATCH 3/3] crypto: qce: ice: Add support for Inline Crypto
 Engine
To:     Rob Herring <robh@kernel.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1539789476-6098-4-git-send-email-anilc@codeaurora.org>
 <201810181902.44DQrfDL%fengguang.wu@intel.com>
 <d6f1930a618f6539a4c3e53d239fdd90@codeaurora.org>
 <20181025145841.GB30244@bogus>
Message-ID: <15fe7675-cef7-3e39-cedc-b09fbcf1a4af@codeaurora.org>
Date:   Mon, 29 Oct 2018 19:01:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181025145841.GB30244@bogus>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review,

On 2018-10-25 20:28, Rob Herring wrote:
> On Wed, Oct 24, 2018 at 04:44:37PM +0530, anilc@codeaurora.org wrote:
>> Hi,
>> 
>> Thanks for the comments, response inline.
> 
> FYI, this was from a bot.

I have realized after I sent the mail.

> 
>> 
>> Thanks,
>> AnilKumar
>> 
>> 
>> On 2018-10-18 17:13, kbuild test robot wrote:
>> > Hi AnilKumar,
>> >
>> > Thank you for the patch! Yet something to improve:
>> >
>> > [auto build test ERROR on cryptodev/master]
>> > [also build test ERROR on v4.19-rc8 next-20181018]
>> > [if your patch is applied to the wrong git tree, please drop us a note
>> > to help improve the system]
>> >
>> > url:
>> > https://github.com/0day-ci/linux/commits/AnilKumar-Chimata/firmware-qcom-scm-Update-qcom_scm_call-signature/20181018-182318
>> > base:
>> > https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
>> > master
>> > config: sh-allmodconfig (attached as .config)
>> > compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>> > reproduce:
>> >         wget
>> > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>> > -O ~/bin/make.cross
>> >         chmod +x ~/bin/make.cross
>> >         # save the attached .config to linux build tree
>> >         GCC_VERSION=7.2.0 make.cross ARCH=sh
>> >
>> > All errors (new ones prefixed by >>):
>> >
>> > > > drivers/crypto/qce/ice.c:1372:5: error: redefinition of
>> > > > 'qcom_ice_setup_ice_hw'
>> >     int qcom_ice_setup_ice_hw(const char *storage_type, int enable)
>> >         ^~~~~~~~~~~~~~~~~~~~~
>> >    In file included from drivers/crypto/qce/ice.c:25:0:
>> >    include/crypto/ice.h:60:19: note: previous definition of
>> > 'qcom_ice_setup_ice_hw' was here
>> >     static inline int qcom_ice_setup_ice_hw(const char *storage_type,
>> > int enable)
>> >                       ^~~~~~~~~~~~~~~~~~~~~
>> >
>> > vim +/qcom_ice_setup_ice_hw +1372 drivers/crypto/qce/ice.c
>> >
>> >   1371
>> > > 1372	int qcom_ice_setup_ice_hw(const char *storage_type, int enable)
>> >   1373	{
>> >   1374		struct ice_device *ice_dev = NULL;
>> >   1375		int ret = -1;
>> >   1376
>> >   1377		ice_dev = get_ice_device_from_storage_type(storage_type);
>> >   1378		if (ice_dev == ERR_PTR(-EPROBE_DEFER))
>> >   1379			return -EPROBE_DEFER;
>> >   1380
>> >   1381		if (!ice_dev)
>> >   1382			return ret;
>> >   1383
>> >   1384		if (enable)
>> >   1385			return enable_ice_setup(ice_dev);
>> >   1386
>> >   1387		return disable_ice_setup(ice_dev);
>> >   1388	}
>> >   1389
>> 
>> We will check and get back on the compilation. What is the idea behind 
>> for
>> this
>> effort, is this for testing the ICE driver?
> 
> The purpose is to make sure changes don't break builds that you likely
> haven't tested. Either different architectures or configurations.

Got the point, will try to avoid this in future.

> 
> Rob
