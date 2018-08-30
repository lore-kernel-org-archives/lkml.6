Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3819C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE9C2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="cFcbl+80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE9C2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbeH3SUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:20:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37339 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729046AbeH3SUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:20:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so2195317wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 07:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ujF2tz+qGiH1pTP0/tZsszCkehyGwb2Z4kX8SpVzqaw=;
        b=cFcbl+80fre2duMY+jc+hY8QBSHLGH+cBwYUdS3jlxLGKhjjba76V404fntP+DQ4kS
         W7DkbbqQEFRW2ct6Y1NriVgnLCpPKsz2+DdAM4PGb4Q0p3m8ODRc+EOypHnLLqj7jDMr
         CStEFC+KKFhBAcWyegzFZgj3cOWaW1Zli/Bq0JaiaQKSyjU9zKZ359LKQcQdcrS5xnNl
         LuHu7+Tsy9NXWMDSWx4y/UT70Jxq63+iqbW3hqI5JGRNFLnZtDtIXGzsUOG4skqFqDjq
         FI3HvvFJhVno7TX8HotwKOm/5mD5MipJY1UgAneqeCdEs3Moe3+9rAeUyOiUlWC48Jmv
         BJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ujF2tz+qGiH1pTP0/tZsszCkehyGwb2Z4kX8SpVzqaw=;
        b=OtQzWx42MevH2HOggBEhSmBVYwxbIXxnaiCNGcF7WF0ZmtCj/g2nJhwXcLpAm+big0
         xId8aH47bg90B08tfEFcWx5fb4sKfKXY8iHrrwSyrUhWGt8dFOYOH2feZQrhXm0NAGyz
         +rRUF9BVsujOFfNYAkbYdUWFpn5xO5mjBX993+07rQhS5fiP5n6Zaznq1CJkFAoO3cNg
         H4SGbf3dgpRMEaHZTjH083H3fV6RtVeDprpjOirnN1vvklINX6imEpAt7tEY0GRq1FC9
         p8vnyjXVpIPn40t52a7TGqkCrIY+/AQnGYjUnr7fBx5L4NjmauutZwFFNM/lU9cJ9UJl
         2ldg==
X-Gm-Message-State: APzg51B3hm/WrHPnzOndzq/X/QcGUgSZJ0F3j+JQk0dvV/fL9ZTPg+qm
        JAkyBD3oRI+DCbgZfu4vMpDgjG3Q33fUih8hSuxxew==
X-Google-Smtp-Source: ANB0VdbjD8Rkn4nXlB2BOZt0mfHcnDxFAc1aMh1qvl1jzAdRbbqP3UkK0ZoXXcB8ceESjkwx3CfmozFNqJKSji33AbU=
X-Received: by 2002:a1c:4c0e:: with SMTP id z14-v6mr2085723wmf.89.1535638697240;
 Thu, 30 Aug 2018 07:18:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 07:18:16
 -0700 (PDT)
In-Reply-To: <20180830141120.GA1724@infradead.org>
References: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
 <CAAhSdy0=ROMqkbgqcKLSdM11TBOeD65GR42s0j_HOYd+y-=jmg@mail.gmail.com> <20180830141120.GA1724@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 30 Aug 2018 10:18:16 -0400
Message-ID: <CAAhSdy2Ma6DXfVTYWpByvmKKbrdaAsyr_-b947+oNSgGVk4E5g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] RISC-V: Add new smp features
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Mark Rutland <mark.rutland@arm.com>, palmer@sifive.com,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 10:11 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Aug 30, 2018 at 09:53:50AM -0400, Anup Patel wrote:
>> > Atish Patra (3):
>> >   RISC-V: Add logical CPU indexing for RISC-V
>> >   RISC-V: Use Linux logical cpu number instead of hartid
>> >   RISC-V: Support cpu hotplug.
>> >
>>
>> This series looks good to me.
>
> Hmm, that series didn't make it to my inbox, neither directly, nor
> through the linux-riscv list.  Where did you see it?

Ahh, looks like some issue indeed. I am in TO list of patch series, thats why
I got the patch series.

--
Anup
