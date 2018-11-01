Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002B5C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 06:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21602064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 06:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrudeERs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21602064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeKAPil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 11:38:41 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:41387 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbeKAPik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 11:38:40 -0400
Received: by mail-lj1-f173.google.com with SMTP id z80-v6so11027913ljb.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 23:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y3EURPBITa/7Xrwe8CUXUVVmetubAdcqXGGetNrxcSk=;
        b=ZrudeERsDhu77dMfjc2vuLVzhAiukqjBexDjwmgasHx4Wta25nkCALfOb14UyBa1LX
         WCEy6DLlS8M+0OhvAkZ1fL7AccNPF/0tqzK8Mrmiru6zATUBbKOwxFZqYe4ula66M8R+
         89QQX3Mzs5MwB9V7pEH4W/zm3rv8/Ll3E2yzE6rNufRaHptDhSXNYGyYVsdY7GMbbgF4
         Mz+bSLmifjTlYifA7j3wKQNn2QlE8gwDNJn0sY8NIgfMhJ7tftR4Vn0jRliteus3hLdb
         Fc5iEyMV4QRF5oKlLuL9GyGIBOOzaJK6INXX2wMYankAbyXjbkLc/KD8m+aL+5hd/bFM
         Agrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3EURPBITa/7Xrwe8CUXUVVmetubAdcqXGGetNrxcSk=;
        b=S5IQI1T6u0Efsd9+ph71t/7JuvQrmUL/GCRlukIQ9t4biXy7ydxyPKT1gFV1WOcjws
         oQCoxRFq4kP/b9Uh0+c+LRzvUhx7zCIT2YB1R3+bLEYDT0p3Rxb+6Q4Un43x02c9HbGu
         CnoK0Co8356M2u9Ec6wbforCR7A+/fEDx81GPdCObPjaixPaqKMatrPxN/HKoGgk6Q4A
         k3JOBKt8o+H08mkkAXxER+RqUhxQPR2CBaEdXvWyv1TyrFISGe3VAv0SzsFW4Zg07qHK
         K+iC7/lAdjcZIgxXvtFyG9/XGNkj3aPhQ4TLNquIYMTSXhz9uhMZB2CmDcodYRh9ghye
         Bkeg==
X-Gm-Message-State: AGRZ1gJhJ+ty1JQ2TdWnWNmMWZswEtaUx04szOuc9+w6am5Gyn3DX1Ay
        np4hBdz+Ki8v+av4f6haH+GeHtbHdMZVsePu7Aqs9g==
X-Google-Smtp-Source: AJdET5fvq0c/nMsB8Ke4Wvi00ccALnHtNx7XaiBKt27nRM3hwpj1PFQNgB1dMxB4Eomk0FttBtnWl0KQM2Bw3EBCb/s=
X-Received: by 2002:a2e:45d:: with SMTP id 90-v6mr4023580lje.110.1541054221477;
 Wed, 31 Oct 2018 23:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <1539854253-4784-1-git-send-email-chunyan.zhang@unisoc.com>
In-Reply-To: <1539854253-4784-1-git-send-email-chunyan.zhang@unisoc.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 1 Nov 2018 14:36:25 +0800
Message-ID: <CAAfSe-v47=pr9pCoM_mATbd0sRApU+TjB8L_e01TwAibn2Qj9g@mail.gmail.com>
Subject: Re: [GIT PULL] sprd dts for kernel v4.20-rc1
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     "arm@kernel.org" <arm@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

I guess you may have missed this pull request.

Thanks,
Chunyan
On Thu, 18 Oct 2018 at 17:19, Chunyan Zhang <chunyan.zhang@unisoc.com> wrote:
>
> Hi Arnd,
>
> For 4.20-rc1 there's one patch only for sprd devicetree, please pull from my git tree:
>
> https://github.com/lyrazhang/linux.git m-v4.19-rc1
>
> Please let me know if there's some problem.
>
> Thanks,
> Chunyan
>
> ----------------------------------------------------------------
>
> Suzuki K Poulose (1):
>   arm64: dts: sc9836/sc9860: Update coresight bindings for hardware
>     ports
>
>  arch/arm64/boot/dts/sprd/sc9836.dtsi |  78 +++++++------
>  arch/arm64/boot/dts/sprd/sc9860.dtsi | 215 ++++++++++++++++++-----------------
>  2 files changed, 151 insertions(+), 142 deletions(-)
