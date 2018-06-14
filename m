Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BD52FC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67306208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O81aBG8V";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e3O7wUEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67306208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754614AbeFNGiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:38:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56666 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752797AbeFNGiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:38:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 353F8600D0; Thu, 14 Jun 2018 06:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528958292;
        bh=UhcTdRg82/g5IeE35uNtXd04mYUC0rRYQRLqay1cXQs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=O81aBG8V1WTCjtS1g3/SNHg3XJqltKD1MXZ4eYI69XbAAAtSvxY/GaEhvOjsg385z
         6gvsyg7p9jClWvxIqmG5+V1SFMkpfGUsDJudAXYiiBOgtsJ1oSMVGhd33A674ju4Ig
         aokUytwsx1D+sOlF/MtL1xU0hfXuQcSyY/Gifjfs=
Received: from mail-qt0-f180.google.com (mail-qt0-f180.google.com [209.85.216.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B6F3600D0;
        Thu, 14 Jun 2018 06:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528958291;
        bh=UhcTdRg82/g5IeE35uNtXd04mYUC0rRYQRLqay1cXQs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=e3O7wUEYPbsWhMklrIqRu99LbHmwEQh4tgxcrV5z+rrhXHrS7cltet31GO1PdpmGy
         9FXfpDM07ZjGF5fJ7XsG2MOrYMuylvVLJWACEvKwI+im1mPC2pNUrLEf2wOIlBWdq+
         xNwzGNX1IQSM3/NYGvXU/x1b7UK2lCl4kmZzE9CU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B6F3600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt0-f180.google.com with SMTP id l33-v6so4802857qta.11;
        Wed, 13 Jun 2018 23:38:11 -0700 (PDT)
X-Gm-Message-State: APt69E0m0bnHXP2dbwcIJZiQkVPGzq7Au26Y5tTwb/CX1OBfxh7C0czZ
        oTcCR4u0hLrdokYpKwQ+EjFXcqZjLx0cm/RiJqE=
X-Google-Smtp-Source: ADUXVKJj7qyO4xjnIFxjk7PgI+kXWMXXQuKFvCuokWWNL/EyAAN7PrDKBJHNbzwbn0jwH/dlNQv3JIjLFRGEQ7BU0lM=
X-Received: by 2002:ac8:720f:: with SMTP id a15-v6mr1055202qtp.243.1528958290848;
 Wed, 13 Jun 2018 23:38:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:1082:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 23:38:10
 -0700 (PDT)
In-Reply-To: <CAFp+6iFsLfKoLy+mzLP7-RGwSrkdA5sSt0UwNT7O6ehmn=VckQ@mail.gmail.com>
References: <20180613125401.11734-1-niklas.cassel@linaro.org>
 <20180613125401.11734-6-niklas.cassel@linaro.org> <CAFp+6iFsLfKoLy+mzLP7-RGwSrkdA5sSt0UwNT7O6ehmn=VckQ@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 14 Jun 2018 12:08:10 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEfd_iBCUtuYbe+vsc31BSC2UVee6YNNSGX5XxMMjJ=aA@mail.gmail.com>
Message-ID: <CAFp+6iEfd_iBCUtuYbe+vsc31BSC2UVee6YNNSGX5XxMMjJ=aA@mail.gmail.com>
Subject: Re: [PATCH 5/5] soc: qcom: Remove depends on ARCH_QCOM
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 12:05 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> On Wed, Jun 13, 2018 at 6:24 PM, Niklas Cassel <niklas.cassel@linaro.org> wrote:
>> Since commit cab673583d96 ("soc: Unconditionally include qcom Makefile"),
>> we unconditionally include the soc/qcom/Makefile.
>>
>> This opens up the possibility to compile test the code even when
>> building for other architectures.
>
> Why do we want to do this when all of it is qcom specific?
> Besides, wouldn't this increase the binary size for other platforms.

Sorry, my bad. Send the message without completing.

Besides above points, the COMPILE_TEST flag should allow you
to compile test all of these drivers. If COMPILE_TEST is missing
in some of the configs, we should try adding that.
Or, is there anything that I am missing here for the intention of this patch?

Thanks & Regards
Vivek

>
>>
>> Remove the depends on ARCH_QCOM for all Kconfigs, except for
>> two Kconfigs that depend on QCOM_SCM, since that triggers lots of build
>> errors in qcom_scm. However, that shouldn't stop us from removing
>> it from those where it is possible.
>>
>> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
>> ---
>>  drivers/soc/qcom/Kconfig | 10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 1d4a9f3ada8c..8c83025c466e 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -5,7 +5,7 @@ menu "Qualcomm SoC drivers"
>>
>>  config QCOM_COMMAND_DB
>>         bool "Qualcomm Command DB"
>> -       depends on (ARCH_QCOM && OF) || COMPILE_TEST
>> +       depends on OF || COMPILE_TEST
>>         help
>>           Command DB queries shared memory by key string for shared system
>>           resources. Platform drivers that require to set state of a shared
>> @@ -14,7 +14,6 @@ config QCOM_COMMAND_DB
>>
>>  config QCOM_GENI_SE
>>         tristate "QCOM GENI Serial Engine Driver"
>> -       depends on ARCH_QCOM || COMPILE_TEST
>>         help
>>           This driver is used to manage Generic Interface (GENI) firmware based
>>           Qualcomm Technologies, Inc. Universal Peripheral (QUP) Wrapper. This
>> @@ -32,7 +31,6 @@ config QCOM_GLINK_SSR
>>
>>  config QCOM_GSBI
>>          tristate "QCOM General Serial Bus Interface"
>> -        depends on ARCH_QCOM
>>          select MFD_SYSCON
>>          help
>>            Say y here to enable GSBI support.  The GSBI provides control
>> @@ -55,7 +53,7 @@ config QCOM_PM
>>
>>  config QCOM_QMI_HELPERS
>>         tristate
>> -       depends on ARCH_QCOM && NET
>> +       depends on NET
>>         help
>>           Helper library for handling QMI encoded messages.  QMI encoded
>>           messages are used in communication between the majority of QRTR
>> @@ -76,7 +74,6 @@ config QCOM_RMTFS_MEM
>>
>>  config QCOM_SMEM
>>         tristate "Qualcomm Shared Memory Manager (SMEM)"
>> -       depends on ARCH_QCOM
>>         depends on HWSPINLOCK
>>         help
>>           Say y here to enable support for the Qualcomm Shared Memory Manager.
>> @@ -85,7 +82,6 @@ config QCOM_SMEM
>>
>>  config QCOM_SMD_RPM
>>         tristate "Qualcomm Resource Power Manager (RPM) over SMD"
>> -       depends on ARCH_QCOM
>>         depends on RPMSG && OF
>>         help
>>           If you say yes to this option, support will be included for the
>> @@ -122,7 +118,6 @@ config QCOM_SMSM
>>
>>  config QCOM_WCNSS_CTRL
>>         tristate "Qualcomm WCNSS control driver"
>> -       depends on ARCH_QCOM
>>         depends on RPMSG
>>         help
>>           Client driver for the WCNSS_CTRL SMD channel, used to download nv
>> @@ -130,7 +125,6 @@ config QCOM_WCNSS_CTRL
>>
>>  config QCOM_APR
>>         tristate "Qualcomm APR Bus (Asynchronous Packet Router)"
>> -       depends on ARCH_QCOM
>>         depends on RPMSG
>>         help
>>            Enable APR IPC protocol support between
>> --
>> 2.17.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
