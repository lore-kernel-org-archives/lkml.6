Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8C9C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC20208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="qLpMHlAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC20208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733007AbeHADtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 23:49:43 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43564 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732913AbeHADtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 23:49:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id f135-v6so12140016lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 19:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Tf3uWLSMshmVT6pnFzlm99zQ5m9Hv7XDpzhfJo14/7w=;
        b=qLpMHlACRlsdYeKzIDsQEQrMerzFjMNJfa8gFZd8WWgPMlq24lB7uxtX783lKKWCKy
         GwFuw0gH7Jx1MmjdKdRMTMWnNovjRuZUl/BgIn1P8uKlboZeE6CCJKSSZ39pxY400xu6
         PIaKOBC3hfErdKWwi8VGeHiv25G/n19i2HEYH2Hhn5WqOTRbTJfYnWtz5tj4Kn1OkW4L
         D/9DSE0A3T9crh5Ov086TzcGUdkCf6TaNpT7cE47FFdGm3CC457NWf3+AFaXO+NmIRdJ
         FXIxWIihF6lgxwr1h0Du+WFPonxRc8VoAUOKhIJ+BnYcQWCLM7IvkeLPCq99wsK6b3KD
         Copg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Tf3uWLSMshmVT6pnFzlm99zQ5m9Hv7XDpzhfJo14/7w=;
        b=NI2F7AvjYJsI3NLWZ6n4/rdF2nlSWADh7/3joejFfNnQ11jJh42xobEX/2QcyT+Cbu
         yYtu/lydU3ExcShX7Zc+8GhXHuLtjuTgkZyrYyrpOVXBMgQzPypq8jpEYFtQDCuOPLq5
         RKRyoCEcpZdwyjLmWiiCJfsYikUHlG1hEPF/ozXjtEKkEq/XSGaIlmpB4LaNpEcme06o
         /POud2ZF038PJR5d/zHLrI8NNPDclfwxg+pksN5WoVHjjR94qrQ1840f0THu2h5FQH53
         h/lYraH1CEbgfj7OrpUEA1dtOlMQkTO9vwHLO4rjHP8QOwh7tio6etvVO6ug/grFZ9Tn
         clAw==
X-Gm-Message-State: AOUpUlHXS5N9+Bfo9RVCcHaNeN7Ouu4MTMjChVfMelWOdptFN5BKhoyv
        HJxDGBFIcx8YRo+S68aIEZMDHGScxuAKZKC3cdE0vg==
X-Google-Smtp-Source: AAOMgpfdMsyp3fMYpurIMuOXTq/IIoBXM+ZVkoLbMf0ZL+orNB74SJZmdDenWVVzexQmBDuUq4GNmQ25DReUjlB+eYM=
X-Received: by 2002:a19:138b:: with SMTP id 11-v6mr14878587lft.74.1533089191997;
 Tue, 31 Jul 2018 19:06:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:fc1c:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 19:06:30
 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:180::1:f7e3]
In-Reply-To: <CAK7LNARSx1hSLQNCzAQyD74dvnHzVqkTFoWj6GL7_5+vZau7Uw@mail.gmail.com>
References: <CAK7LNAShLhWqCRR8RfuJ0xBJAFoj-S6WLcSdh9QShg8dGfq9RA@mail.gmail.com>
 <20180721212430.odjwcusbbihffo6l@localhost> <CAK7LNAQHL16vxv7twzy9PPkLLrbvzuAMa9QtOjSN3Z1KHWKG_Q@mail.gmail.com>
 <CAK7LNARSx1hSLQNCzAQyD74dvnHzVqkTFoWj6GL7_5+vZau7Uw@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 31 Jul 2018 19:06:30 -0700
Message-ID: <CAOesGMjBotm_SGL2U3aq+YNey5NODcMZwgt_Xj3os+BL1-GSFQ@mail.gmail.com>
Subject: Re: [GIT PULL 3/3] ARM: uniphier: UniPhier SoC updates for v4.19
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 31, 2018 at 1:39 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Olof,
>
>
> 2018-07-22 8:24 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> Hi Olof,
>>
>> 2018-07-22 6:24 GMT+09:00 Olof Johansson <olof@lixom.net>:
>>> On Thu, Jul 19, 2018 at 08:05:03AM +0900, Masahiro Yamada wrote:
>>>> Hi Arnd, Olof,
>>>>
>>>> Please pull UniPhier SoC changes for the v4.19 MW.
>>>>
>>>> Thanks!
>>>>
>>>>
>>>> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>>>>
>>>>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
>>>> tags/uniphier-soc-v4.19
>>>>
>>>> for you to fetch changes up to ae93e694440a454609fa40725e16619c5a781768:
>>>>
>>>>   ARM: uniphier: remove empty Makefile (2018-07-19 06:53:16 +0900)
>>>>
>>>> ----------------------------------------------------------------
>>>> UniPhier ARM SoC updates for v4.19
>>>>
>>>> - enable ethernet and thermal drivers from multi_v7_defconfig
>>>>
>>>> - select RESET_CONTROLLER
>>>>
>>>> - remove empty arch/arm/mach-uniphier/Makefile
>>>>
>>>> ----------------------------------------------------------------
>>>> Kunihiko Hayashi (1):
>>>>       ARM: multi_v7_defconfig: add CONFIG_UNIPHIER_THERMAL and CONFIG_SNI_AVE
>>>
>>> I renormalied multi_v7_defconfig for 4.18-rc3, so please base your branch
>>> on that to avoid conflicts.
>>>
>>> Also, we separate out defconfig updates to branches on their own. I can
>>> cherry-pick the branch apart but wanted to check with you before I do
>>> so in case it messes up your workflow. If it does, send a fresh pull
>>> request for SoC, and either one for the defconfig or just the patch and
>>> we can apply it directly.
>>>
>>
>> Can you do cherry-pick please?
>>
>
> Ping?
>
> You offered to cherry-pick the patches directly to your tree,
> and I asked you to do so.
>
>
>
> We do not have much time until the MW opens.
> Please cherry-pick the following four:

Done now, thanks!


-Olof
