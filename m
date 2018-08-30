Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC52C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958FE2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="CgYayCDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958FE2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbeH3R4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:56:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33227 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbeH3R4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:56:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id v90-v6so8171877wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 06:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=juS6e871XZ58+LgUftX5PbjVfIUEn0MPCHMzjI2hmVk=;
        b=CgYayCDwAdjLogHg+phrmxhSs7T099L94TIfAQKWAB0cHEi+5JuCaYX0XZVD2HDEEn
         PwM2o4nhLPB8Hpgdi1x5L2hOK3wfxLrq+8IlGjKkLakmhQQMAR+I0J4nwFAtCZ/IoPu0
         /zxY17GqL5qjBYGDiKjFhu5575PofznUft2MyOtCSzFDpJV/AB7PMBQLUNb37PLRlLmc
         ElxQqNRcuSPqTw/nLuXcjpID4U/kCKIKVVzxY27BntetjfXOCbT4I9aDDM9qKOBQcwZQ
         0IgcCvBiV0Xa5KUVTuYbeizMVSweY+3OSzcQmHW0liGu33MjOtsO8Ag6lsqVTBmrcki5
         UeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=juS6e871XZ58+LgUftX5PbjVfIUEn0MPCHMzjI2hmVk=;
        b=WjHNts9AlIybvK+Nh7nVE7KgVSZNeLYbfbbVuJXHWUiwoAOKjuF9FN/VmE3enNFtmL
         TJlG6uYlZsNUAxa9YDyJTzqRbC/LR7bVO9qLeMqm+CdYgID/rl2qUav2Tg63R0rpy1ws
         srW6q4hRQgfwmh5lTjOkjRAV8zx/WwlHVE7jy1958iSRe87xND0zbHPQlUe2ojqhT6gg
         jvY1KpKZs3JB0iWUPJmUmOXzRwPkDWezrQf2jizapTM0ZvYn0DcN6A71xVy+AAR5KsH0
         CsR5Qb4qhpqE+Eb1IIAoF4VI3gA/fGKqcnTg8VvMqN4fi6v5AylPVgX/Hf6kCs2LPFBU
         CKcA==
X-Gm-Message-State: APzg51BRRv8MZvLz5dBFK6L7N5Vh0wYdcr1bSZ5bryYd0U1ZDM5R+umd
        xKS60mbsEoUqx+/etE0uR/3VGFsMnmvSD0uvAgF4/g==
X-Google-Smtp-Source: ANB0VdZodpgotpm3VF7twHt6qSMSv/aGyl0ovE92vYBy06N3pB73CvNuWaMB643RvV8zHv6Lo7Tkk8Ka76HGV2S9DGo=
X-Received: by 2002:adf:f5c9:: with SMTP id k9-v6mr7658286wrp.59.1535637231491;
 Thu, 30 Aug 2018 06:53:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 06:53:50
 -0700 (PDT)
In-Reply-To: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
References: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 30 Aug 2018 09:53:50 -0400
Message-ID: <CAAhSdy0=ROMqkbgqcKLSdM11TBOeD65GR42s0j_HOYd+y-=jmg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] RISC-V: Add new smp features
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 4:36 AM, Atish Patra <atish.patra@wdc.com> wrote:
> This patch series implements following smp related features.
> Some of the work has been inspired from ARM64.
>
> 1. Decouple linux logical cpu ids from hardware cpu id
> 2. Support cpu hotplug.
>
> Tested on QEMU & HighFive Unleashed board with/without SMP enabled.
>
> v1->v2:
>
> 1. Dropped cpu_ops patch.
> 2. Moved back IRQ cause definiations to irq.h
> 3. Keep boot cpu hart id and assign zero as the cpu id for boot cpu.
> 4. Renamed cpu id and hart id correctly.
>
> Atish Patra (3):
>   RISC-V: Add logical CPU indexing for RISC-V
>   RISC-V: Use Linux logical cpu number instead of hartid
>   RISC-V: Support cpu hotplug.
>

This series looks good to me.

FWIW,
Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
