Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA871C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5562241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synesis-ru.20150623.gappssmtp.com header.i=@synesis-ru.20150623.gappssmtp.com header.b="Tr9F/gdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5562241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synesis.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbeKMCKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:10:47 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44658 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbeKMCKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:10:46 -0500
Received: by mail-oi1-f196.google.com with SMTP id p82-v6so7584134oih.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 08:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synesis-ru.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LcPRtZZv6rKs/BOykeACgr9FCLAs5Zf0D5AlPGCzhpE=;
        b=Tr9F/gdOLgQnRDoLU449pU9saMCf4gG2m4a6FIjkz7AK4MxwXE+n/iCBFtcAmtgR6V
         Qd8lGQXfivw6xX8KODxJWLFB5T5rxEiEQQfacKpK1zq+xhU73/nR7ZV9/dCBWZfk7nMb
         b4gopyhIqGB15frdDTHofn2yjoGfIQOxwmDKLu27VOUV2w2nxaBWs7OqGcreLt5Jn3+Y
         E7sjOy49E6eIHhNRLPUcPfrlrNiwd5h5eeFMPjacjqZHT7Dyu1nlwaz5yySiclXK4WMo
         3Kyuij/HattpJY2UwBrfhhWnV71uYkh0XosRHWUtnZoU7uEUFe0rdtXpcYWcQ6W0PSN7
         SVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LcPRtZZv6rKs/BOykeACgr9FCLAs5Zf0D5AlPGCzhpE=;
        b=grg+gTPxUhkkrXn2WJ/Zan/KiRYAZmDb9WWH6NkHf44kfnLeT3Iy6g327IA19KDsfb
         QymhQRrIpCI8tATioEQtjVtDMleqeRS0zylC70HdfsRFNuO2Rdj954ARyks6CPRkUf7r
         VJ9CtQcquPbCl8XtTIb6fKh/EXb9jxZP1LS4iyooaFL2xtXkxcBKb2JSnn1j6/IBdflK
         OwnS1CKpoM10bvkJPm7lco2hcmbFfhHyRSHerDacvwN8sylgDRGrb4G5d/2CC8T4/VQy
         xUiaMNTko/DRge6rIuIfbvxNS3K0dzdX+qP9y1IXy3kDD2b7+OoW9Fv8yJG1nChDWukf
         I+QA==
X-Gm-Message-State: AGRZ1gK0LJe+uDWj93WjNs7gtCtC4+J0HOcOROrp6RMOW6BkRiJv7huE
        TLtIXzN8qQgAiDwrUjRm2ovsZfJHTuoSIA==
X-Google-Smtp-Source: AJdET5fPm6Xdi9Nz8jIo/+aFvNszpTPJrQmJTAThuGvH008jcTTsTp2eA/PmprXeg44FvbihQtn2/A==
X-Received: by 2002:aca:6910:: with SMTP id e16-v6mr914656oic.117.1542039410325;
        Mon, 12 Nov 2018 08:16:50 -0800 (PST)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id e75-v6sm11831797oih.41.2018.11.12.08.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 08:16:48 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id c206so2054582oib.0;
        Mon, 12 Nov 2018 08:16:48 -0800 (PST)
X-Received: by 2002:aca:f40d:: with SMTP id s13-v6mr929111oih.102.1542039407789;
 Mon, 12 Nov 2018 08:16:47 -0800 (PST)
MIME-Version: 1.0
References: <20181111212610.25213-1-timofey.titovets@synesis.ru> <20181112035838.GF21824@bombadil.infradead.org>
In-Reply-To: <20181112035838.GF21824@bombadil.infradead.org>
From:   Timofey Titovets <timofey.titovets@synesis.ru>
Date:   Mon, 12 Nov 2018 19:16:11 +0300
X-Gmail-Original-Message-ID: <CAGqmi7610QBdEp=xUOgPEbMhfB11ZF6cFCBS-T3BoCb2Sbj1ug@mail.gmail.com>
Message-ID: <CAGqmi7610QBdEp=xUOgPEbMhfB11ZF6cFCBS-T3BoCb2Sbj1ug@mail.gmail.com>
Subject: Re: [PATCH v2] ksm: allow dedup all tasks memory
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D0=BD, 12 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 6:58, Matthe=
w Wilcox <willy@infradead.org>:
>
> On Mon, Nov 12, 2018 at 12:26:10AM +0300, Timofey Titovets wrote:
> > ksm by default working only on memory that added by
> > madvice().
> >
> > And only way get that work on other applications:
> >  - Use LD_PRELOAD and libraries
> >  - Patch kernel
> >
> > Lets use kernel task list in ksm_scan_thread and add logic to allow ksm
> > import VMA from tasks.
> > That behaviour controlled by new attribute: mode
> > I try mimic hugepages attribute, so mode have two states:
> >  - normal       - old default behaviour
> >  - always [new] - allow ksm to get tasks vma and try working on that.
> >
> > To reduce CPU load & tasklist locking time,
> > ksm try import VMAs from one task per loop.
> >
> > So add new attribute "mode"
> > Two passible values:
> >  - normal [default] - ksm use only madvice
> >  - always [new]     - ksm will search vma over all processes memory and
> >                       add it to the dedup list
>
> Do you have any numbers for how much difference this change makes with
> various different workloads?

Yep, i got some non KVM numbers,
Formulas:
 Percentage - (pages_sharing - pages_shared)/pages_unshared
 Memory saved - (pages_sharing - pages_shared)*4/1024 MiB

- My working laptop: 5% - ~100 MiB saved ~2GiB used
  Many different chrome based apps + KDE

- K8s test VM:  40% - ~160 MiB saved ~920MiB used
  With some small running docker images

- Ceph test VM: 20% - ~60MiB saved ~600MiB used
  With ceph mon, osd.

Develop cluster servers:
- K8s server backend: 72%, ~5800 MiB saved ~35.7 GiB used
  (With backend apps: C, java, go & etc server apps)

- K8s server processing: 55%, ~2600 MiB saved ~28 GiB used
  (90% of load many instance of one CPU intensive application)

- Ceph node: 2%, ~190 MiB saved ~11.7 GiB used
  (OSD only)


So numbers, as always depends on the load.

Thanks!
- - -
P.S.
On recent kernels (4.19) i see BUG_ON message, that ksmd scheduled
while in critical section/atomic context,
not sure how to properly fix that.
(If i understood correctly, i can use preempt_disable(); but that
looks more like hack, not a fix).

Any feedback are welcome.
