Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFB7C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A907120898
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK2hWoW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A907120898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeH1Qdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:33:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42378 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH1Qdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:33:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id v17-v6so1439979wrr.9;
        Tue, 28 Aug 2018 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=frWhn4S9KCm1DSyV4+IQkgu7JU6rC2gg4yQa9wCMVrY=;
        b=QK2hWoW05SUggMhvfEkmKpBC0vDdlKj+wqRPoHh5btR1Nq+sDfQdAh69hpb4ahWMqK
         ip4vYFxqiFYqVaAwdzkdw7wCQyGfwx9iqPz4oe+Cr4XRw2EjPUBKWmx38qT5NlZ/Ijjz
         dEY0kRZeq8EjcP3ULvOaHOJTNvDNE0n/5SN8tRRuXUJximhPnnNNB2+iFKmTuJvyzx4I
         4AyGX7Jg/0Sa+zfWHTxLWVy+uu987Nl5djd/erRcekC/TaeyxEJkSazqzJA7aYQWmdMk
         6W7nMTAxlBTWncq2oOgbpvG+K16+7/6srxHu6GqL+a8FUt6FUSYdylT3MzrLk4YDVRpL
         W2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=frWhn4S9KCm1DSyV4+IQkgu7JU6rC2gg4yQa9wCMVrY=;
        b=K8dadmehWS342cYKYGKJJ+SoHno5Cpm9aeTIJwp4hgOhzXgHwsYXzQScN+Nb6RqSK6
         4qkcDVFgsy4Q49s06Dg/sXCNIDZx8VrTl7WuIJkxAXNy69kC6ZdbfcaMSURkVDksWahj
         Twgk0cZv47m/4u7m4q/LiKqJ1f8hQs1D1re1gKxAItHI430s8urzH5aSSFKHUtjJGEGC
         nwjub0ejLor5NhTd1yjv2hM8tMDxae1DxQp8/iVQOIeV4cil1eEeJ/kBaoxIcY6ZCC9w
         5QAyT8CQ30SltfQmHmECvIfhCHZ9xVFUhJimlLv7fWCWmyDI7BF9+Er9/2dL+ljCM6io
         NLLQ==
X-Gm-Message-State: APzg51AYkdZZ8gyfT2qPq+o/qwIpqiUcnip7LyDkBGlhhvTJK8bQkDkb
        3FivZkLFY+ocWhzJTygZn25cKwUHw+ko6edyQ2fFsggQ
X-Google-Smtp-Source: ANB0VdbgzIYiwZpB69DlNr+Vns0IEiRkSgbCpKa7eN35+1BMVEKDm0X21+X+aNj0ssyH/zKaCcdqmkP7DVSoj41wzQs=
X-Received: by 2002:a5d:61c1:: with SMTP id q1-v6mr1087855wrv.33.1535460141840;
 Tue, 28 Aug 2018 05:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-11-git-send-email-sunil.kovvuri@gmail.com> <CAK8P3a1Vdy-VsLWJMer-Z96E4Trhi0WJXJ3fTzyOGny2Mn6RAA@mail.gmail.com>
In-Reply-To: <CAK8P3a1Vdy-VsLWJMer-Z96E4Trhi0WJXJ3fTzyOGny2Mn6RAA@mail.gmail.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Tue, 28 Aug 2018 18:12:10 +0530
Message-ID: <CA+sq2Cf2BLKsV=gY-MPnygV1ufpvmnw6ETh90JX_uKQBk3Sduw@mail.gmail.com>
Subject: Re: [PATCH 10/15] soc: octeontx2: Reconfig MSIX base with IOVA
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, olof@lixom.net,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, Geetha sowjanya <gakula@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>, tglx@linutronix.de,
        Marc Zyngier <marc.zyngier@arm.com>, jason@lakedaemon.net,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 5:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Aug 28, 2018 at 12:58 PM <sunil.kovvuri@gmail.com> wrote:
> >
> > From: Geetha sowjanya <gakula@marvell.com>
> >
> > HW interprets RVU_AF_MSIXTR_BASE address as an IOVA, hence
> > create a IOMMU mapping for the physcial address configured by
> > firmware and reconfig RVU_AF_MSIXTR_BASE with IOVA.
> >
> > Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> > Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
>
> I think this needs some more explanation. What is the difference between
> the MSI-X support in this driver and every other one? Are you working
> around a hardware bug, or is there something odd in the implementation
> of your irqchip driver? Do you use a GIC to handle the MSI interrupts
> or something else?
>
>        Arnd

This admin function is a PCI device which is capable of provisioning
HW blocks to other PCIe SRIOV devices in the system. Each HW block
(eg memory buffer pools, NIC dewscriptors, crypto engines e.t.c) needs
certain no of MSIX vectors. Admin function has a set of 32K MSIX vectors
in memory (not on-chip) which based on HW block provisioning to a PCI device
attaches the required number of vectors to that device. Some part of this
configuration is done by low level firmware.

RVU_AF_MSIXTR_BASE points to the memory region allocated for 32K MSIX
vectors. If kernel is booted with IOMMU enabled and admin function device
is attached to SMMU, HW will go through translation to access this MSIX
vector memory region. Hence the mapping done in this patch.

Thanks,
Sunil.
