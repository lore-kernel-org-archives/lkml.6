Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E0EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCBC20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iKHI3O8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCBC20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeKILfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 06:35:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56588 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeKILfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 06:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RG6RaekDd2Lt5YJR7bhlFE8zXN2KReUj4+YZ0MxjvTA=; b=iKHI3O8ax8+U0Ythn0upq+imb
        dOTioGMtW/ag+Uiot97Sv3avq/TWFJd5ZcBRr3C/UH8wFv9bFdmaZV2o0ag4jd35+H+bFdKhtlFx7
        dt20clT2IIhGdPvY6lqELARciyaGXz36vbrz6EJdiC2zfsx9baSaWzyQ/HuLEic84ImNzfRJeKCFB
        k9srqe0un5asMc4PQLPfEjuxkwTCVSlOgyibizGxvnTgI+KPm2oArgvNFnTEZOpz+jjd/EGNLjWPN
        JvKp1RQyM9ntk/Ea77m4OFmM3KFlAQOxXXXDz2wNGqCpesAmUlipE+2D2tyMylce+qDAy36T6nql7
        XbMhCLlPQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKw2u-0003bC-03; Fri, 09 Nov 2018 01:57:16 +0000
Subject: Re: drivers/acpi/pmic/intel_pmic_xpower.c:183: undefined reference to
 `iosf_mbi_block_punit_i2c_access'
To:     kbuild test robot <lkp@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <201811030142.IIRPWNE6%fengguang.wu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <82320bbc-7e74-558a-284d-5f37d6a4cda7@infradead.org>
Date:   Thu, 8 Nov 2018 17:57:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <201811030142.IIRPWNE6%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18 10:28 AM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d81f50bd34646d8373b989e55180c0fc9af94e0b
> commit: 3c670dba864d9ab0a23612a93b7d98700734bd44 ACPI / PMIC: xpower: Block P-Unit I2C access during read-modify-write
> date:   8 days ago
> config: x86_64-randconfig-s3-11022323 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 3c670dba864d9ab0a23612a93b7d98700734bd44
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/acpi/pmic/intel_pmic_xpower.o: In function `intel_xpower_pmic_update_power':
>>> drivers/acpi/pmic/intel_pmic_xpower.c:183: undefined reference to `iosf_mbi_block_punit_i2c_access'
>>> drivers/acpi/pmic/intel_pmic_xpower.c:200: undefined reference to `iosf_mbi_unblock_punit_i2c_access'

This happens because of
CONFIG_PMIC_OPREGION=y
CONFIG_XPOWER_PMIC_OPREGION=y
CONFIG_IOSF_MBI=m

where XPOWER_PMIC_OPREGION (bool) depends on IOSF_MBI (tristate, =m).

This build error could possibly be fixed by adding
	select IOSF_MBI
and dropping the "depends on" for XPOWER_PMIC_OPREGION, or by changing
the "depends on" like this:

 config XPOWER_PMIC_OPREGION
 	bool "ACPI operation region support for XPower AXP288 PMIC"
-	depends on MFD_AXP20X_I2C && IOSF_MBI
+	depends on MFD_AXP20X_I2C && IOSF_MBI=y



> vim +183 drivers/acpi/pmic/intel_pmic_xpower.c
> 
>    172	
>    173	static int intel_xpower_pmic_update_power(struct regmap *regmap, int reg,
>    174						  int bit, bool on)
>    175	{
>    176		int data, ret;
>    177	
>    178		/* GPIO1 LDO regulator needs special handling */
>    179		if (reg == XPOWER_GPI1_CTRL)
>    180			return regmap_update_bits(regmap, reg, GPI1_LDO_MASK,
>    181						  on ? GPI1_LDO_ON : GPI1_LDO_OFF);
>    182	
>  > 183		ret = iosf_mbi_block_punit_i2c_access();
>    184		if (ret)
>    185			return ret;
>    186	
>    187		if (regmap_read(regmap, reg, &data)) {
>    188			ret = -EIO;
>    189			goto out;
>    190		}
>    191	
>    192		if (on)
>    193			data |= BIT(bit);
>    194		else
>    195			data &= ~BIT(bit);
>    196	
>    197		if (regmap_write(regmap, reg, data))
>    198			ret = -EIO;
>    199	out:
>  > 200		iosf_mbi_unblock_punit_i2c_access();
>    201	
>    202		return ret;
>    203	}
>    204	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

cheers.
-- 
~Randy
