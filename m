Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F47C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACFD20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhadhQ/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACFD20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeKJA2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:28:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:39528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbeKJA2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:28:18 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91D3320825;
        Fri,  9 Nov 2018 14:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541774844;
        bh=Kcaq68GWhflYELGuA9DICyOnJI5wZvywNYjAtFh7amA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZhadhQ/xSJysa+1uvYHdJUpCazjTEmTChLUYy561o8Cy7J3pWTNAyeENtV79pLLhF
         p7fsc4pigEJREmJlm1lWpsWLoEDA0QAhcUBzYKwConwnpOmJbpbAfcniDP3AHNWFDU
         dukNkY/20qPIss0HTk1VOH0G9lMRC7hC1bnSiZgU=
Date:   Fri, 9 Nov 2018 06:47:24 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     kbuild test robot <lkp@intel.com>, devel@driverdev.osuosl.org,
        tkjos@android.com, sabyasachi.linux@gmail.com,
        linux-kernel@vger.kernel.org, arve@android.com, kbuild-all@01.org,
        joel@joelfernandes.org, maco@android.com, jrdr.linux@gmail.com
Subject: Re: [PATCH] drivers/android/binder.c: Remove duplicate header
Message-ID: <20181109144724.GA20089@kroah.com>
References: <20181109041425.GA2950@hp-pavilion-15-notebook-pc-brajeswar>
 <201811092225.ABFKAgV4%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201811092225.ABFKAgV4%fengguang.wu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 10:40:14PM +0800, kbuild test robot wrote:
> Hi Brajeswar,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on staging/staging-testing]
> [also build test ERROR on v4.20-rc1 next-20181109]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Brajeswar-Ghosh/drivers-android-binder-c-Remove-duplicate-header/20181109-154717
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):

<snip>

Yeah, I was right :(

Always test-build your patches.

greg k-h
