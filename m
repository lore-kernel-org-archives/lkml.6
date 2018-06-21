Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68837C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C4D20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MODlPu/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C4D20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754304AbeFULPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:15:24 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34344 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753906AbeFULPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:15:23 -0400
Received: by mail-lf0-f65.google.com with SMTP id e13-v6so4212811lfc.1;
        Thu, 21 Jun 2018 04:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xzemGuB2W+Ou6JWk4IiOFnFFJIvVVZ48ROthMTcNlo8=;
        b=MODlPu/sRb/Ax7PcKGhTTqBiK8m7fZXao2y2hydYg8uZca0R+kx0M5SaZBPopS56lc
         TVI+2c3dvzR1jhEPRbV+ULWysurfejBfiCeR62NJIRR3Xb5Bw574t6qv76VFMY7JKAox
         OU7Qyh6GRc7Yg2tqKkbARoVZ8CI+zcn7FQSw+Kwx+axrPs/93wuuTG3gasqtMGEXRKYb
         nsd35tRuZkablUYOE/iBPpvTBbxMik56t/NwUebRtCAKB1pLJB4YDZbTplMJEjjf7yp8
         6KkF6JvlyMz/ahI4vK9cHX8jEkCbxF4GXSJOxXG1zLmW3Ryaubm3JET3zjshOPMbhRHr
         QtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xzemGuB2W+Ou6JWk4IiOFnFFJIvVVZ48ROthMTcNlo8=;
        b=cgTAu8F7WItm3k2QoYrgffMUTRKp5rwl2YYKJnD5E9/HvGnXXdxDXrG61nMS8kqL4s
         uiJcyOChW9i9uFbiXLq8ihdkbu+Etck0buxicP8BuIeZQs4p06ydDi1ssFULgU3yJdqU
         V+dRCiSM8i4idN2KEldI3Pu5OULR781C7T3PpDdu8lNqWgcl3vPKw+K5L5fjkH9UHOFM
         w8ycCStlGZrSrMo92ZDH/PunmvNI4Rt6CqLECCfWhB2HPkZT4b09rxXKF5gJ1CH+5vdu
         lDkuO3730MUCHx4+P7Lm3kktZ6ygadp8a7M3EQ51ZHqSMygFj1kG2RXest48CsczwkkZ
         en/w==
X-Gm-Message-State: APt69E2VqnyUOV6tjKpj1mA7EjVUSD/Ss4zH22JKPTHNwGMxeYdYs3xN
        v4QGP70NRjcoC/MJHnwMnuySGOTNWDWlNU+jLBSC1w==
X-Google-Smtp-Source: ADUXVKJ7mJneCidreLrRIxFAuZfhE80tpP/1QxjsBVx9mV1e0aNt8SIRBR9wAVMhX8NqMRBTEtZZ1ahajqJLB4Ckfhk=
X-Received: by 2002:a2e:5d5d:: with SMTP id r90-v6mr16508814ljb.125.1529579721476;
 Thu, 21 Jun 2018 04:15:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:548b:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 04:14:41
 -0700 (PDT)
In-Reply-To: <1f3e7e87-be4e-37ab-af46-1c4e5dd79a1d@intel.com>
References: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
 <1529028255-6022-2-git-send-email-zhang.chunyan@linaro.org> <1f3e7e87-be4e-37ab-af46-1c4e5dd79a1d@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 21 Jun 2018 19:14:41 +0800
Message-ID: <CAAfSe-ug+M7DO7S1KKQ43FcrRgfGqEpikvivgjBjih8yuTU0sg@mail.gmail.com>
Subject: Re: [PATCH V2 1/7] mmc: sdhci: add sd host v4 mode
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 June 2018 at 18:49, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 15/06/18 05:04, Chunyan Zhang wrote:
>> For SD host controller version 4.00 or later ones, there're two
>> modes of implementation - Version 3.00 compatible mode or
>> Version 4 mode.  This patch introduces a flag to record this.
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 6 ++++++
>>  drivers/mmc/host/sdhci.h | 6 ++++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 2ededa7f..cf5695f 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -3302,6 +3302,12 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
>>       v = ver ? *ver : sdhci_readw(host, SDHCI_HOST_VERSION);
>>       host->version = (v & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
>>
>> +     if (host->version >= SDHCI_SPEC_400) {
>> +             if (sdhci_readw(host, SDHCI_HOST_CONTROL2) &
>> +                     SDHCI_CTRL_V4_MODE)
>> +                     host->v4_mode = true;
>> +     }
>
> At this point the host controller has just been reset which would mean it
> must be in version 3 compatibility mode, which would mean this code doesn't
> do anything.

Why is it version 3 mode at this point?

I've tested this code on the sd host controller which was introduced
in 6/7 in this patch-set, the result showed that it was v4_mode.
Moreover without this patch, the Spreadtrum's sdhci driver in patch
6/7 couldn't work.

Am I missing something here?

Best,
Chunyan

>
>> +
>>       if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
>>               return;
>>
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index c95b0a4..128b0ba 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -184,6 +184,7 @@
>>  #define   SDHCI_CTRL_DRV_TYPE_D              0x0030
>>  #define  SDHCI_CTRL_EXEC_TUNING              0x0040
>>  #define  SDHCI_CTRL_TUNED_CLK                0x0080
>> +#define  SDHCI_CTRL_V4_MODE          0x1000
>>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE        0x8000
>>
>>  #define SDHCI_CAPABILITIES   0x40
>> @@ -270,6 +271,8 @@
>>  #define   SDHCI_SPEC_100     0
>>  #define   SDHCI_SPEC_200     1
>>  #define   SDHCI_SPEC_300     2
>> +#define   SDHCI_SPEC_400     3
>> +#define   SDHCI_SPEC_410     4
>>
>>  /*
>>   * End of controller registers.
>> @@ -551,6 +554,9 @@ struct sdhci_host {
>>       u32                     sdma_boundary;
>>
>>       unsigned long private[0] ____cacheline_aligned;
>> +
>> +     /* Host Version 4 Enable */
>> +     bool                    v4_mode;
>>  };
>>
>>  struct sdhci_ops {
>>
>
