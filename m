Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92949C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F7E20897
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN4XQDqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F7E20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeH2PhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:37:00 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44878 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbeH2Pg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:36:59 -0400
Received: by mail-lf1-f66.google.com with SMTP id g6-v6so4000010lfb.11;
        Wed, 29 Aug 2018 04:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O6nPK4MQRv489teoD6NAtY0Cincq038TN6BWCgLw7dI=;
        b=IN4XQDqevk5NgZ1FtUoE5C6xHGaJcjIIr1tzoWok7bHqq3YqR+weVaKDGmrqQub/oG
         qJ5My3EuL6/+Pl25K3FBWmcss5KVD4WRIqEWtf1vfMENgK7k5U1NuqGsfD9a1dpylOiA
         Hgx+Kv1GudoFM4cTKgHz+soBNHZNyVz2tdaqlGit7kUn5vcWU21iSKvaYLSbZ9gwp6Me
         IkLY6ttjOAuEoTholf2htvnwprDPh/RR3N4cGz9YHK1KrNw7+EgUGKzn7O++M9y4mQBu
         2t9XtH1c57TXwBulwY5RyIZasn4i0qndNvE9yLB7gMsaF6X2YEq6Zv/1gB0RiHmwmJs9
         LTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O6nPK4MQRv489teoD6NAtY0Cincq038TN6BWCgLw7dI=;
        b=ht1YyAR4ZxASw1LNHOTgEZyvuOJjGMSx6BjxCRmhPCMSSsndIRg5B8qR2fRlV+k/1D
         hYM4UWcxwcYjREi/OXVYttFje7WXP2ZUJfy8zVCbsYRidN8DiDWG18CBpvDSdwXZYbi1
         FaSt5XYuc900/iC9tZGEOHl88UBc/upEQG7R/WqUCaYQNX+cYFisaU4QLe22zzuCjBoY
         7Ofg0uu5+Op5q5YVN+oKiyDKRy8Hie/8Lyv67VqyhQXawVE1ppRp8dU1HKfdJgMMQ1Y/
         EFh5rAo7ab2yYjQzBZ8YNXUB5lFOU+M1ONwZdWysbfVoQGtQBVW4Zkoytt6KFgRuWTQ/
         HLww==
X-Gm-Message-State: APzg51BjNNTRJGy3n6NJSUOJKiZqP0NVtkM1exfxEfFUNsJUE38JC/MJ
        1X2DaHPG06ZpEBwCQoYqvAk2I8IxnQuu9YeyQs4=
X-Google-Smtp-Source: ANB0VdYs9DKVpN1sF78T67LWlAvPgi1Uf8saI8CFjdENHtu6eNqWuQw1YWrLiG0fLnuHz/S5lCVrom169uteQqfPGJ4=
X-Received: by 2002:a19:9355:: with SMTP id v82-v6mr4038700lfd.134.1535542828071;
 Wed, 29 Aug 2018 04:40:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:6318:0:0:0:0:0 with HTTP; Wed, 29 Aug 2018 04:39:47
 -0700 (PDT)
In-Reply-To: <a38f8d87-a373-5de4-c3b5-bba68f8ffeec@intel.com>
References: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
 <1535526184-32718-8-git-send-email-zhang.chunyan@linaro.org> <a38f8d87-a373-5de4-c3b5-bba68f8ffeec@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 29 Aug 2018 19:39:47 +0800
Message-ID: <CAAfSe-s-W467D2dk-_7AWQz9ZaysROf5otoN-o-yu3Eu5ZVC4g@mail.gmail.com>
Subject: Re: [PATCH V7 7/9] mmc: sdhci: SDMA may use Auto-CMD23 in v4 mode
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 August 2018 at 18:59, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 29/08/18 10:03, Chunyan Zhang wrote:
>> When Host Version 4 Enable is set to 1, SDMA uses ADMA System Address
>> register (05Fh-058h) instead of using register (000h-004h) to indicate
>> its system address of data location. The register (000h-004h) is
>> re-assigned to 32-bit Block Count and Auto CMD23 argument, so then SDMA
>> may use Auto CMD23.
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 62d843ac90..ac92e0f 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -3834,10 +3834,14 @@ int sdhci_setup_host(struct sdhci_host *host)
>>       if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
>>               host->flags |= SDHCI_AUTO_CMD12;
>>
>> -     /* Auto-CMD23 stuff only works in ADMA or PIO. */
>> +     /*
>> +      * For v3 mode, Auto-CMD23 stuff only works in ADMA or PIO;
>
> ; -> .
>
>> +      * For v4 mode, SDMA may use Auto-CMD23 as well.
>> +      */
>>       if ((host->version >= SDHCI_SPEC_300) &&
>>           ((host->flags & SDHCI_USE_ADMA) ||
>> -          !(host->flags & SDHCI_USE_SDMA)) &&
>> +          (!host->v4_mode && !(host->flags & SDHCI_USE_SDMA)) ||
>> +          (host->v4_mode && (host->flags & SDHCI_USE_SDMA))) &&
>>            !(host->quirks2 & SDHCI_QUIRK2_ACMD23_BROKEN)) {
>
> This is over complicated.  We can use auto-CMD23 if not using SDMA or if in
> v4_mode i.e.
>
>         if (host->version >= SDHCI_SPEC_300 &&
>             (!(host->flags & SDHCI_USE_SDMA) || host->v4_mode) &&
>             !(host->quirks2 & SDHCI_QUIRK2_ACMD23_BROKEN)) {
>

So no matter whether SDHCI_USE_ADMA is selected, right?

>>               host->flags |= SDHCI_AUTO_CMD23;
>>               DBG("Auto-CMD23 available\n");
>>
>
