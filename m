Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06CBECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8890B20878
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jDm7JZp1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bAHp1j+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8890B20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbeGWL1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:27:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47478 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388065AbeGWL1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:27:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 83D9D605FD; Mon, 23 Jul 2018 10:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532341634;
        bh=g9oX/RN+C3jdSyckQhEW/WOOWqmV6ab67sbl0m+wTBw=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=jDm7JZp1kXm03iCl1P6qXvdyo9ypAJnSjxGxT97YtH2MaxDBp1ZOja9GZrgp+EjXb
         zZzLIdnP5PdgNddwqbQHCD6Rx6r7HaSMl9kUIqm7oq9UPlXIflZEEZ8mnGHrjzd0ic
         SNkfJc1nMB1x4KEzO5Cn7uNc4Uc/eXX1cGbvHIBk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E5331605A4;
        Mon, 23 Jul 2018 10:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532341625;
        bh=g9oX/RN+C3jdSyckQhEW/WOOWqmV6ab67sbl0m+wTBw=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=bAHp1j+qxKv3zHjZ+TAeJEOuWSkv1xUrOgAlgRgx7HXERNzSIbIdsWn2SMYDiUk2h
         ffucf7KyvJsjWNh5kqhU5lvd9/VLjvtqWxIHn0N8Ec6I4IKQkxuLRuhmpmrAXYi1rw
         +DfzkLfU+smhHjRzo6SRfw109DlHkvmEpszSVslE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Jul 2018 15:57:04 +0530
From:   dkota@codeaurora.org
To:     kbuild-all@01.org, timur@codeaurora.org, swboyd@chromium.org,
        broonie@kernel.org, mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>, alokc@codeaurora.org
Subject: Re: [PATCH V2] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
In-Reply-To: <201807210707.BLvlaScm%fengguang.wu@intel.com>
References: <1532087461-3474-2-git-send-email-dkota@codeaurora.org>
 <201807210707.BLvlaScm%fengguang.wu@intel.com>
Message-ID: <891441f9f95f5d1f387cb9ffb9df1515@codeaurora.org>
X-Sender: dkota@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-21 05:07, kbuild test robot wrote:
> Hi Girish,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on spi/for-next]
> [also build test ERROR on v4.18-rc5 next-20180720]
> [if your patch is applied to the wrong git tree, please drop us a note
> to help improve the system]
> 
> url:
> https://github.com/0day-ci/linux/commits/Dilip-Kota/spi-spi-geni-qcom-Add-SPI-driver-support-for-GENI-based-QUP/20180721-034916
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 
> for-next
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=ia64
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/spi/spi-geni-qcom.c:11:
>    drivers/spi/spi-geni-qcom.c: In function
> 'spi_geni_prepare_transfer_hardware':
>>> include/linux/qcom-geni-se.h:238:9: error: 'version' undeclared 
>>> (first use in this function); did you mean 'vm_region'?
>      step = version & HW_VER_STEP_MASK; \
>             ^~~~~~~
>    drivers/spi/spi-geni-qcom.c:256:3: note: in expansion of macro
> 'geni_se_get_wrapper_version'
>       geni_se_get_wrapper_version(se, major, minor, step);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/qcom-geni-se.h:238:9: note: each undeclared
> identifier is reported only once for each function it appears in
>      step = version & HW_VER_STEP_MASK; \
>             ^~~~~~~
>    drivers/spi/spi-geni-qcom.c:256:3: note: in expansion of macro
> 'geni_se_get_wrapper_version'
>       geni_se_get_wrapper_version(se, major, minor, step);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> --
>    In file included from drivers//spi/spi-geni-qcom.c:11:
>    drivers//spi/spi-geni-qcom.c: In function
> 'spi_geni_prepare_transfer_hardware':
>>> include/linux/qcom-geni-se.h:238:9: error: 'version' undeclared 
>>> (first use in this function); did you mean 'vm_region'?
>      step = version & HW_VER_STEP_MASK; \
>             ^~~~~~~
>    drivers//spi/spi-geni-qcom.c:256:3: note: in expansion of macro
> 'geni_se_get_wrapper_version'
>       geni_se_get_wrapper_version(se, major, minor, step);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/qcom-geni-se.h:238:9: note: each undeclared
> identifier is reported only once for each function it appears in
>      step = version & HW_VER_STEP_MASK; \
>             ^~~~~~~
>    drivers//spi/spi-geni-qcom.c:256:3: note: in expansion of macro
> 'geni_se_get_wrapper_version'
>       geni_se_get_wrapper_version(se, major, minor, step);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> vim +238 include/linux/qcom-geni-se.h
> 
> eddac5af Karthikeyan Ramasubramanian 2018-03-30  231
> eddac5af Karthikeyan Ramasubramanian 2018-03-30  232  #define
> geni_se_get_wrapper_version(se, major, minor, step) do { \
> eddac5af Karthikeyan Ramasubramanian 2018-03-30  233  	u32 ver; \
> eddac5af Karthikeyan Ramasubramanian 2018-03-30  234  \
> eddac5af Karthikeyan Ramasubramanian 2018-03-30  235  	ver =
> geni_se_get_qup_hw_version(se); \
> eddac5af Karthikeyan Ramasubramanian 2018-03-30  236  	major = (ver &
> HW_VER_MAJOR_MASK) >> HW_VER_MAJOR_SHFT; \
> eddac5af Karthikeyan Ramasubramanian 2018-03-30  237  	minor = (ver &
> HW_VER_MINOR_MASK) >> HW_VER_MINOR_SHFT; \
> eddac5af Karthikeyan Ramasubramanian 2018-03-30 @238  	step = version
> & HW_VER_STEP_MASK; \
> eddac5af Karthikeyan Ramasubramanian 2018-03-30  239  } while (0)
> eddac5af Karthikeyan Ramasubramanian 2018-03-30  240
> 
> :::::: The code at line 238 was first introduced by commit
> :::::: eddac5af06546d2e7a0730e3dc02dde3dc91098a soc: qcom: Add GENI
> based QUP Wrapper driver
> 
> :::::: TO: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> :::::: CC: Andy Gross <andy.gross@linaro.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology 
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel 
> Corporation


HI,

For now please ignore the PATCHSET 2. I will upload a new PATCHSET 
addressing all the comments of patchset 1 with detailed description.
Sorry for the inconvenience.

Regards,
Dilip
