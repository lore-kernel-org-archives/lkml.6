Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DF3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D35208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="oMChO8Z+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D35208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbeGaNxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:53:10 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:35167 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732026AbeGaNxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:53:10 -0400
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com [209.85.217.173]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w6VCCxUH011889;
        Tue, 31 Jul 2018 21:12:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w6VCCxUH011889
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533039180;
        bh=WCJwdOkGiPJ9r/2cv1ndCjtsiAV+odem1RQ2lx2cbLg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=oMChO8Z+jA/6nUOhzSAa5CD5PXSyBw6WMiL7pYhFolAG8VXLkZORbsYyC5iZc1eQL
         RLfGloO3kGD6+bI6Wp04inNz58oLFVyRS/dUcSADoH+aSzgbzfGNF+SP3YHuIqlFD4
         bSSSL72zj6Pl18+0B986dzN8B8On8tKaZalIIeN/AHl5y0CeyNqOnPG498TDrf7e8J
         gzUD1ferX1tWsR7gAJ/FoCiUqGfP4FS7ng/7fDQeM1wnPEAbAWyrq+zuwJfwR9FAv8
         /hXkJz9TfCBBU+mhMbJHWGGrhf+vuIssIK64ea2VWNn3xPx8y0JSQ0ontj8w06Ybjq
         /STqbMF1OCTxA==
X-Nifty-SrcIP: [209.85.217.173]
Received: by mail-ua0-f173.google.com with SMTP id o11-v6so10096402uak.5;
        Tue, 31 Jul 2018 05:12:59 -0700 (PDT)
X-Gm-Message-State: AOUpUlE5BeYgkQsgQzt+2no4bvZLl6j1WdZ8EgAvQSDR8zAPbRJks5ED
        u9Qpo2xmCzGlcjiGnWjCjPYu2kjWzzq0TtpVbVU=
X-Google-Smtp-Source: AAOMgpeeyxhMhSSwSlGDU6K0pMAn37LKglGsOB/OxpRCxN2xJdL4fIpbQBQ543ZQMvOhmAujXcpTd1JHSq5IArGKrHs=
X-Received: by 2002:ab0:52f1:: with SMTP id w46-v6mr13042997uaw.52.1533039178387;
 Tue, 31 Jul 2018 05:12:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 05:12:18
 -0700 (PDT)
In-Reply-To: <CAPDyKFpK=UnwdNtb3XcgcRBJZeE0X5osM-tk8E85TCs3CeDq7Q@mail.gmail.com>
References: <1532575736-20138-1-git-send-email-yamada.masahiro@socionext.com>
 <1532575736-20138-2-git-send-email-yamada.masahiro@socionext.com> <CAPDyKFpK=UnwdNtb3XcgcRBJZeE0X5osM-tk8E85TCs3CeDq7Q@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 31 Jul 2018 21:12:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAScJFUPK=mMmNWYw-yJ9iaxaibituYRDU2x5kGpbsEd5A@mail.gmail.com>
Message-ID: <CAK7LNAScJFUPK=mMmNWYw-yJ9iaxaibituYRDU2x5kGpbsEd5A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: tmio: rename files and CONFIG options to have
 the same prefix
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-31 0:07 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 26 July 2018 at 05:28, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>> As commit b6147490e6aa ("mmc: tmio: split core functionality, DMA and
>> MFD glue") said, these MMC controllers use the IP from Panasonic.
>>
>> TMIO (Toshiba Mobile IO) MMC was the first upstreamed user of this IP.
>> The common driver code was split and expanded as 'tmio-mmc-core', then
>> it become historical misnomer since 'tmio' is not the name of this IP.
>>
>> I pointed out this [1], and suggested to re-organize the names in the
>> form of:
>>
>>   <IP-name>.c            (common code for this IP)
>>   <IP-name>_tmio.c       (Toshiba Mobile IO)
>>   <IP-name>_sdhi.c       (Renesas SDHI)
>>   <IP-name>_uniphier.c   (Socionext UniPhier)
>>
>> The <IP-name> in my mind was 'mnsd' because names of Panasonic chips
>> are prefixed with 'MN'.
>>
>> This is the naming scheme as we see in dw_mmc* and sdhci-*.
>>
>> In the discussion with Wolfram Sang, my suggestion was rejected
>> because it implied drastic function renaming, which is too invasive.
>>
>> Ulf Hansson was still happy with file renaming to clarify the
>> relationship between variants.  So, the accepted solution was:
>>
>>  - Make 'tmio_mmc' the _right_ core name
>>  - Align all variant files with the same prefix.
>>  - Do not rename functions
>>
>> This commit renames files as follows:
>>
>>   tmio_mmc_core.c              -> tmio_mmc.c
>>   tmio_mmc.c                   -> tmio_mmc_original.c
>>   renesas_sdhi_core.c          -> tmio_mmc_sdhi.c
>>   renesas_sdhi.h               -> tmio_mmc_sdhi.h
>>   renesas_sdhi_internal_dmac.c -> tmio_mmc_sdhi_internal_dmac.c
>>   renesas_sdhi_sys_dmac.c      -> tmio_mmc_sdhi_sys_dmac.c
>>
>> Also rename CONFIG options to match to the file names:
>>
>>   MMC_TMIO_CORE          -> MMC_TMIO
>>   MMC_TMIO               -> MMC_TMIO_ORIGINAL
>>   MMC_SDHI               -> MMC_TMIO_SDHI
>>   MMC_SDHI_SYS_DMAC      -> MMC_TMIO_SDHI_SYS_DMAC
>>   MMC_SDHI_INTERNAL_DMAC -> MMC_TMIO_SDHI_INTERNAL_DMAC
>>
>> I touched eseries_pxa_defconfig and pxa_defconfig in this commit
>> because they are inactive, but renaming of CONFIG options generally
>> takes some development cycles.  Old names will be kept until the
>> migration is completed, like Renesas folks did when they renamed
>> ARCH_SHMOBILE_MULTI to ARCH_RENESAS.
>>
>> [1] https://www.spinics.net/lists/linux-mmc/msg46952.html
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> I am awaiting some feedback from Wolfram before applying.



If this is not welcome, please feel free to throw away.
(then, I will name my driver 'uniphier-sd.c')

I am neutral about this renaming because it
is trying to make the wrong thing correct.


It will also produce a different inconsistency.
Even if we rename renesas_sdhi_core.c to tmio_mmc_sdhi.c ,
functions in it will be kept renesas_sdhi_*
I understand they want to keep the file name and function names consistent.


Thanks.




>> ---
>>
>>  MAINTAINERS                                        |    1 -
>>  arch/arm/configs/eseries_pxa_defconfig             |    2 +-
>>  arch/arm/configs/pxa_defconfig                     |    2 +-
>>  drivers/mmc/host/Kconfig                           |   25 +-
>>  drivers/mmc/host/Makefile                          |    8 +-
>>  drivers/mmc/host/tmio_mmc.c                        | 1415 ++++++++++++++++++--
>>  drivers/mmc/host/tmio_mmc_core.c                   | 1394 -------------------
>>  drivers/mmc/host/tmio_mmc_original.c               |  167 +++
>
> I think there should be another way to format the patch to get better diffstat.
>
> I guess it depends a bit on what version of git you are using, but
> trying the -M option may help.
>
>
>>  .../host/{renesas_sdhi_core.c => tmio_mmc_sdhi.c}  |    2 +-
>>  .../mmc/host/{renesas_sdhi.h => tmio_mmc_sdhi.h}   |    0
>>  ...ternal_dmac.c => tmio_mmc_sdhi_internal_dmac.c} |    2 +-
>>  ...as_sdhi_sys_dmac.c => tmio_mmc_sdhi_sys_dmac.c} |    2 +-
>>  12 files changed, 1518 insertions(+), 1502 deletions(-)
>>  delete mode 100644 drivers/mmc/host/tmio_mmc_core.c
>>  create mode 100644 drivers/mmc/host/tmio_mmc_original.c
>>  rename drivers/mmc/host/{renesas_sdhi_core.c => tmio_mmc_sdhi.c} (99%)
>>  rename drivers/mmc/host/{renesas_sdhi.h => tmio_mmc_sdhi.h} (100%)
>>  rename drivers/mmc/host/{renesas_sdhi_internal_dmac.c => tmio_mmc_sdhi_internal_dmac.c} (99%)
>>  rename drivers/mmc/host/{renesas_sdhi_sys_dmac.c => tmio_mmc_sdhi_sys_dmac.c} (99%)
>>
>
> [...]
>
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
