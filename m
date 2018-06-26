Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E352C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E548626D95
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjRqGdVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E548626D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeFZQHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:07:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35533 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbeFZQHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:07:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id i125-v6so9223502lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 09:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=64Yny3TqXwaa7mqIy2JDzaqluupIMk8XlR/3NcikW/A=;
        b=qjRqGdVEOSBUXq6HA5EsjRYNiCu0No5DClnGqGBDe8JBJmtSW/7ArfaYURfLMWL2Hd
         xxvUU03lMKSM6s1FupJQ4sG9kvI+uGL8KtKpuSaWcVExuEeKU8FpBdNSud86ql1uVLM2
         TOteBPfZcWGnHSaFFXRf2xQ3q29dM9VG9JLBauZuJ6sfEaZ/wfyu8l8wcTJshzHFCDEg
         wXnL7jSDpC3K6H37uN3kkjPaSKJ6HM0rKwa5OL5mQOQSgOeSR3vSK9EtUlBB2N+CHWrb
         LC/aPHwx/wJ65S/j84mBfrdqmEc8FemI9N9MA2xBmRS6Mnr561ZFAeEE3hM38CKORUJd
         jTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=64Yny3TqXwaa7mqIy2JDzaqluupIMk8XlR/3NcikW/A=;
        b=B2iEi1+lro11Zsgm7YSjfFpyu6MeEc4A/QDU58641YbBh+sLc1c4aE1x77Gk9Ao4+u
         8XIuV0KiFuVFT+2Z0x7D6W+sbA7xIjZMqDcWuttZdF/WwSZgRt+lgUGPon8uLVUjuGZ8
         o4p/7Y+weAkzolgOgocN+ZKmFNhcjk7FVPwTdW9959s2RYOhhUYP1WnFGVXTvOF1YhZi
         +H9rYCTVWq5HtM1o7HZyOAA86jWYueW0+ONYmO0TSGhY3FSPnouB+xAF3AEFFE8X52Ys
         McskIjgtCFy7Jo5jh+CKub8vbDoe8wDw3Q9MbM3WBchf96lhFghg9m6UVl/gyBRpChdq
         2o5g==
X-Gm-Message-State: APt69E25iJiYy0mbOx6ktJLn7p6jH7zpPVbDuuAX1lhyScV1jzKwuxv3
        A7vpfZt+6goiZHJ/E/fzvZfzVsFC0EFN1QP5eK4=
X-Google-Smtp-Source: AAOMgpepdfpdTRWcqc5XAcsMjQHoe+jsSfchRn72tfPRWtR5360jpuJzmUbJ+xEmyWchqh0d5fN+mMCjnS1oV8Qbnwg=
X-Received: by 2002:a2e:91d6:: with SMTP id u22-v6mr1652190ljg.64.1530029258320;
 Tue, 26 Jun 2018 09:07:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b43:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 09:07:37
 -0700 (PDT)
In-Reply-To: <20180626153740.GA17271@n2100.armlinux.org.uk>
References: <20180510150448.GA26306@jordon-HP-15-Notebook-PC>
 <20180511092205.GB16141@n2100.armlinux.org.uk> <CAFqt6zY2amJC4bkRZJgjs7=wCuTTxZbufk9cXcMZLE8VGh_dww@mail.gmail.com>
 <CAFqt6zYyL6YfvmiX90=Te3PQdcK32irdPPU0awEbp9Q16Bz9=w@mail.gmail.com>
 <CAFqt6zbQxx+20SNT8r1q2ZjtQZLTh=CC50s4LkHExkBju-1KJA@mail.gmail.com>
 <CAFqt6zacTP-HgQzkXS=d2w-+=QbhkPA0oH9X5Py_GJ0+8_PcYQ@mail.gmail.com> <20180626153740.GA17271@n2100.armlinux.org.uk>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 26 Jun 2018 21:37:37 +0530
Message-ID: <CAFqt6zYoTTBjeiprsoaEronQV_if+5bB=LWqo1A6QxYMtPJong@mail.gmail.com>
Subject: Re: [PATCH v2] gpu: drm: armada: Adding new typedef vm_fault_t
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 9:07 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Jun 19, 2018 at 10:42:15AM +0530, Souptick Joarder wrote:
>> On Mon, Jun 4, 2018 at 10:46 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> > On Wed, May 23, 2018 at 3:09 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> >> On Wed, May 16, 2018 at 10:05 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> >>> On Fri, May 11, 2018 at 2:52 PM, Russell King - ARM Linux
>> >>> <linux@armlinux.org.uk> wrote:
>> >>>> On Thu, May 10, 2018 at 08:34:48PM +0530, Souptick Joarder wrote:
>> >>>>> Use new return type vm_fault_t for fault handler in
>> >>>>> struct vm_operations_struct. For now, this is just
>> >>>>> documenting that the function returns a VM_FAULT
>> >>>>> value rather than an errno. Once all instances are
>> >>>>> converted, vm_fault_t will become a distinct type.
>> >>>>>
>> >>>>> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>> >>>>>
>> >>>>> Previously vm_insert_pfn() returns err which driver
>> >>>>> mapped into VM_FAULT_* type. The new function
>> >>>>> vmf_insert_pfn() will replace this inefficiency by
>> >>>>> returning VM_FAULT_* type.
>> >>>>>
>> >>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> >>>>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>> >>>>
>> >>>> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
>> >>>>
>> >>>> Thanks.
>> >>>
>> >>> If no further comment, we would like to get this patch in queue
>> >>> for 4.18.
>> >>
>> >> We would like to get this patch in queue
>> >> for 4.18.
>> >
>> > We  would like to get this patch in 4.18.
>>
>> Russell, This patch is not merged in 4.18-rc-1.
>
> Correct, I wasn't able to add it to my tree because David Airlie hadn't
> pulled the previous merge request, so it missed the 4.18 merge window.
>
> The reason for me acking the patch was so that /someone else/ could
> pick it up instead, and that obviously also didn't happen - maybe the
> drm-misc tree was closed for new work at the point you sent the patch.
>
> I've picked this patch up now, thanks.
>

Thanks. Queued for 4.19 merge window ?
