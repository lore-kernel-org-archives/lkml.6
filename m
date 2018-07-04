Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30125C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82A224711
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wgo1jaXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82A224711
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753606AbeGDDDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 23:03:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34668 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752990AbeGDDDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 23:03:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id c12-v6so3101071ljj.1;
        Tue, 03 Jul 2018 20:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wrnEyjyi0XNNznX+XVukf/huBHa/DWcaEZJWR26H0YI=;
        b=Wgo1jaXqbsMbaXgNRPJlnmJny388QdFU2tTEmmA0d2XzvrpvftmMY9K/sTyQsLVLj8
         VX/yx1kHZwcrfPLay0bCPmvAPCrHORsAaPxHaAlrZJDqx4i8RwdIqv2DYWbpw0/i5vgp
         AFYxgJZd6iuoRRkP0giHoRge5fMUJokhURyg/ScCxKykS84n5B1y7ItHQlyZhgXR2/Sx
         Rg+H4/KxZDxCmhmo741kwvoglPvm2Fy1xDgBOwm0XaeDw06CrZlMCJHBzgD6PSdgqeAt
         pRdALxOBFCEm6OyktU62mIxGtt4DfK0zOwaNzh3LNykK/6mWU5EsVkXQo2o+NwL0Ppxa
         Bi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wrnEyjyi0XNNznX+XVukf/huBHa/DWcaEZJWR26H0YI=;
        b=UalJ41u1OAkcws87WzoEJUP1vxyn848txdqGusC5fcm2Lv1aL6ol8R3Bw3RDmh5X0G
         5OTd3C7PaTOXLkrjSw+La0FFsg6av/9qr6FIVoTQ6GLq2spcF/fkl1w6VYbZXjmldOJS
         s0Vww1UWeanh19wtQiTwjyQRqDGjpM4BZp4A7KO+olQM+iqe5KsRXDVzvXZhB/sMbqll
         QN+nUjPARPPrlbMTBByx7qXM7Ot1sVf9gPrvYvUJnloaFt/wnp0E9oobwcajkJBiZcQ/
         zYL+3odl+zcS5HdY/ecY1o0iP0F4xRynGksCef1A+yibuTeRGfi3eqVmix3jikih8jcv
         V8vA==
X-Gm-Message-State: APt69E29go8E4RVSDzW0YfkhnzvwUhAzRHqCxdnDBPHR1+ED5164+GIV
        33L3PqJ4CE8bpFsbV07e/x25u3PcVcY8YQIxIos=
X-Google-Smtp-Source: AAOMgpdDxv/WECGXbiQIoxaSxMBfEPEXxWKDLzmcJS9w65vpmSJeZQI3hddHkeEqtORTLQQAhh5Z0+pLFksXiwtjCjE=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7-v6mr130356ljj.142.1530673392410;
 Tue, 03 Jul 2018 20:03:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:1796:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 20:02:31 -0700 (PDT)
In-Reply-To: <38c47bf5-d320-7767-59c1-958d1bbb6dc9@intel.com>
References: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
 <1529028255-6022-2-git-send-email-zhang.chunyan@linaro.org>
 <1f3e7e87-be4e-37ab-af46-1c4e5dd79a1d@intel.com> <CAAfSe-ug+M7DO7S1KKQ43FcrRgfGqEpikvivgjBjih8yuTU0sg@mail.gmail.com>
 <38c47bf5-d320-7767-59c1-958d1bbb6dc9@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 4 Jul 2018 11:02:31 +0800
Message-ID: <CAAfSe-vfcWU+ewD1KCumQx6OBmLiJ7U5hTO_9J9PgkhxF4ZuBg@mail.gmail.com>
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

On 21 June 2018 at 21:15, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 21/06/18 14:14, Chunyan Zhang wrote:
>> On 21 June 2018 at 18:49, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 15/06/18 05:04, Chunyan Zhang wrote:
>>>> For SD host controller version 4.00 or later ones, there're two
>>>> modes of implementation - Version 3.00 compatible mode or
>>>> Version 4 mode.  This patch introduces a flag to record this.
>>>>
>>>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>>>> ---
>>>>  drivers/mmc/host/sdhci.c | 6 ++++++
>>>>  drivers/mmc/host/sdhci.h | 6 ++++++
>>>>  2 files changed, 12 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index 2ededa7f..cf5695f 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -3302,6 +3302,12 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
>>>>       v = ver ? *ver : sdhci_readw(host, SDHCI_HOST_VERSION);
>>>>       host->version = (v & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
>>>>
>>>> +     if (host->version >= SDHCI_SPEC_400) {
>>>> +             if (sdhci_readw(host, SDHCI_HOST_CONTROL2) &
>>>> +                     SDHCI_CTRL_V4_MODE)
>>>> +                     host->v4_mode = true;
>>>> +     }
>>>
>>> At this point the host controller has just been reset which would mean it
>>> must be in version 3 compatibility mode, which would mean this code doesn't
>>> do anything.
>>
>> Why is it version 3 mode at this point?
>
> According to the specification, reset clears RW fields to zero.
>
>>
>> I've tested this code on the sd host controller which was introduced
>> in 6/7 in this patch-set, the result showed that it was v4_mode.
>> Moreover without this patch, the Spreadtrum's sdhci driver in patch
>> 6/7 couldn't work.
>>
>> Am I missing something here?
>
> It seems the Spreadtrum controller doesn't clear the "Host Version 4 Enable"
> bit upon software reset for all.
>
> Also this seems the wrong way around.  The driver should decide whether or
> not to use V4 mode and then the "Host Version 4 Enable" bit should be set
> accordingly.
>
> V4 has been around so long that we can't just enable all supporting hardware
> without risking the possibility it will break some platform.  So I suggest

Ok, understand.

> adding a function sdhci_enable_v4_mode() which is called during probe.

Ok, will do, that is more a safe way.

>
>>
>> Best,
>> Chunyan
>>
>>>
>>>> +
>>>>       if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
>>>>               return;
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>>> index c95b0a4..128b0ba 100644
>>>> --- a/drivers/mmc/host/sdhci.h
>>>> +++ b/drivers/mmc/host/sdhci.h
>>>> @@ -184,6 +184,7 @@
>>>>  #define   SDHCI_CTRL_DRV_TYPE_D              0x0030
>>>>  #define  SDHCI_CTRL_EXEC_TUNING              0x0040
>>>>  #define  SDHCI_CTRL_TUNED_CLK                0x0080
>>>> +#define  SDHCI_CTRL_V4_MODE          0x1000
>>>>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE        0x8000
>>>>
>>>>  #define SDHCI_CAPABILITIES   0x40
>>>> @@ -270,6 +271,8 @@
>>>>  #define   SDHCI_SPEC_100     0
>>>>  #define   SDHCI_SPEC_200     1
>>>>  #define   SDHCI_SPEC_300     2
>>>> +#define   SDHCI_SPEC_400     3
>>>> +#define   SDHCI_SPEC_410     4
>>>>
>>>>  /*
>>>>   * End of controller registers.
>>>> @@ -551,6 +554,9 @@ struct sdhci_host {
>>>>       u32                     sdma_boundary;
>>>>
>>>>       unsigned long private[0] ____cacheline_aligned;
>>>> +
>>>> +     /* Host Version 4 Enable */
>>>> +     bool                    v4_mode;
>>>>  };
>>>>
>>>>  struct sdhci_ops {
>>>>
>>>
>>
>
