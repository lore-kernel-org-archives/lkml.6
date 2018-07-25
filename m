Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD87CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638D920856
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+vaDkAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638D920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeGYDP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:15:56 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44318 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbeGYDP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:15:56 -0400
Received: by mail-oi0-f67.google.com with SMTP id s198-v6so11111330oih.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 19:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/1rJF/h9VZOdaW8HjCqpMT8XkkqohXynHLdpZQrxFu4=;
        b=C+vaDkARp1qANIfNg540/FC4WGQj8ocQCU22GMjdSheebxT+/PBuniBDAch+JPBgwt
         pQJA60CU27GnVflLcXYOafhLUlEcof8iiiNR8HMBMVJin1JYTI44bMQwQi27JghOk/1B
         wXYh4UbQh7ROGCxqCYCkHyAErGxWscpDaGQZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/1rJF/h9VZOdaW8HjCqpMT8XkkqohXynHLdpZQrxFu4=;
        b=CaFYvN3MgS7HyIl2kkHDe7zbcyXvBLKgksUkdiFdBxJGrjxL/H9hZ2tny8BEh0vX1O
         xs+BTBchv1LfAYRbXBay0sycWodVaBCguoSMfF5xBhn5HHR54kJ5gTA5J2Sx3cNM+PTc
         Nk/8qNipvi8ud3xRuudCmb0fKuBwX5YGUk4j8PgswGZNU1rgsFtxtxzGdg1Mt7eOc7gz
         NpgdgOVw2Aa2aXLwXhe0bWIrUSTHJYiZ2JiVJI2dwLEylHqbx3TaasWjGzyVBeiEo97C
         6KIiUBf0CoCLWFgqlVsJte5aTKDTZWnfYrLlmvLV6EyRLG+oFAchsZZNVtLtCfb+idIZ
         lx5g==
X-Gm-Message-State: AOUpUlGGApzwEj6srWjuWsiPOPA1S9MhYBRDUmGsckWqdkJT1h7d2Y+8
        SufQBAFarR9H2+gCtnqI5ZBt6rtReypcngEvFk8mWw==
X-Google-Smtp-Source: AAOMgpfd4/YmkDfm11HU/pd5S10bFPiYGnLaChpbC3Vy2/vfigHBxNHBMWh5nNDILVEOnKexIOn8Rq1c/1muE4Qs3KE=
X-Received: by 2002:aca:a94c:: with SMTP id s73-v6mr1346045oie.68.1532484395718;
 Tue, 24 Jul 2018 19:06:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 19:06:35
 -0700 (PDT)
In-Reply-To: <CAK8P3a0xYSaGbtxGWN=3NmcBnQ3Fd6rnHXp=0D0_MLXaJKfS+w@mail.gmail.com>
References: <0ad306a7d410d3695c7869bf081efaa71e956ae4.1531826106.git.baolin.wang@linaro.org>
 <201807250052.6f8He2LR%fengguang.wu@intel.com> <CAK8P3a0xYSaGbtxGWN=3NmcBnQ3Fd6rnHXp=0D0_MLXaJKfS+w@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 25 Jul 2018 10:06:35 +0800
Message-ID: <CAMz4kuL+r8FU1Rb6i5-Q2aZyera68qP+WH3TwV-TLrVOB0u6SQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 4/4] sh: remove board_time_init() callback
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Brown <broonie@kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 25 July 2018 at 05:33, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Jul 24, 2018 at 7:07 PM, kbuild test robot <lkp@intel.com> wrote:
>> Hi Arnd,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on sof-driver-fuweitax/master]
>> [also build test ERROR on v4.18-rc6 next-20180724]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/sh-dreamcast-rtc-push-down-rtc-class-ops-into-driver/20180719-041209
>> base:   https://github.com/fuweitax/linux master
>> config: sh-rsk7264_defconfig (attached as .config)
>> compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         GCC_VERSION=7.2.0 make.cross ARCH=sh
>>
>> All errors (new ones prefixed by >>):
>>
>>    arch/sh/kernel/time.c: In function 'time_init':
>>>> arch/sh/kernel/time.c:42:2: error: implicit declaration of function 'timer_init'; did you mean 'time_init'? [-Werror=implicit-function-declaration]
>>      timer_init();
>>      ^~~~~~~~~~
>
> Hmm, I fixed it locally, but Baolin forwarded the version from the
> original submission that had the same bug (timer_init instead of timer_probe):
>
> https://www.spinics.net/lists/linux-sh/msg52798.html
>
> I'll just send the correct version once more.

I am sorry I missed your fixes, but thanks to resend them to remove
the last user of the obsolete read_persistent_clock().

-- 
Baolin Wang
Best Regards
