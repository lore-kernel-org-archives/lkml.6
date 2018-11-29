Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECEAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE1920868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+o1KrXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE1920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeK3Fyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:54:49 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33803 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeK3Fyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:54:49 -0500
Received: by mail-it1-f194.google.com with SMTP id x124so8118716itd.1;
        Thu, 29 Nov 2018 10:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvjZP6sODa1JrTBOtvu8z7J0VX8KAt3vb7MIKHMy7O0=;
        b=F+o1KrXdybS/F2N20oAo/hhNYaqsKzEgnnhTKChjDYwWY3IikGFv9CBQcLrkbZleRi
         Q+LDvPfKkThLtaHa+UqfkQ6iyDiG9Wr5R80/p2kjWDcafIb0+zq1W+Kq4rpT3lvkISNQ
         1/r1TDOW/h6zcUZXpmovMWZC4SZ1t16c7VVqFlbVSF9DIowRSyFWw6h91MCs19XiFigr
         hdhuHYtQzRqlK0kdB35Ut2KT3NyM1ubztm3KgZbz7QJKDs8KoIXhEGxkzX1ItQnOrLpt
         3DJaeyArEofrTGOSeYu/Lg75Ytn9lRSa7qep0fOmiJIr5U5Cooqon3aLf56jmLkJH+Rw
         kyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvjZP6sODa1JrTBOtvu8z7J0VX8KAt3vb7MIKHMy7O0=;
        b=uR6tHQ7PS/LGERbDG/PTp0clWZ1SExie440U/QKSUAJSmdkgIenQ15LKie4M9/DoZ1
         o9UpkvUWPa980dbX7ymJ2WFJIjVBuLNp0i2jXbwbBCgoGaE4HDiIPDd28TC3E27jqEJJ
         mgGxz2q5/R7DyaOlGCRj411PERe16JI4wtCidFKJ1Wjq3TnIC6TkdPUSjG9uaS+gq/7o
         aLkbafxRX7i9gQEqp6QFyJ/6fboEtFk8Ysl6LkqbLEWWpOMLM5VLuZFCYKrW8un16bTj
         SDRqvOniqStbwnxS+y6ttwcNwtjGAjdw05aMEusq2RKRLoFUFAZgfMAEPyC8rN6ek+yh
         Hqyg==
X-Gm-Message-State: AA+aEWYCwbB/zJefMVywTkTimaT5BykhfrKbLedZY/vvWiCS8v+O3rGe
        6MxAFbNb9qhNtZIj4r7t09kS9ybYiBCvDSdio4w=
X-Google-Smtp-Source: AFSGD/XiaXWvVgQe0zNEAfWkz6nJvc9ZbSfto/1QrMzIcmwSuOYVEj/H3JTmURIilKUUrpNONFmhH0xMwzSA+p/SFsc=
X-Received: by 2002:a24:d84:: with SMTP id 126-v6mr2662618itx.163.1543517307231;
 Thu, 29 Nov 2018 10:48:27 -0800 (PST)
MIME-Version: 1.0
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
 <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
 <CAF6AEGu65Vvzpy6K7eF+Kk4YdYBPEKFX5ct8GxG0pw-KNwM5eA@mail.gmail.com> <20181129155418.GB26537@lst.de>
In-Reply-To: <20181129155418.GB26537@lst.de>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 29 Nov 2018 13:48:15 -0500
Message-ID: <CAF6AEGufdp5jRtUZ_+VRQg3ZXH36hNHvbWZQeJDArp8N5SZ3Lg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     hch@lst.de
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:54 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Nov 29, 2018 at 09:42:50AM -0500, Rob Clark wrote:
> > Maybe the thing we need to do is just implement a blacklist of
> > compatible strings for devices which should skip the automatic
> > iommu/dma hookup.  Maybe a bit ugly, but it would also solve a problem
> > preventing us from enabling per-process pagetables for a5xx (where we
> > need to control the domain/context-bank that is allocated by the dma
> > api).
>
> You can detach from the dma map attachment using arm_iommu_detach_device,
> which a few drm drivers do, but I don't think this is the problem.

I think even with detach, we wouldn't end up with the context-bank
that the gpu firmware was hard-coded to expect, and so it would
overwrite the incorrect page table address register.  (I could be
mis-remembering that, Jordan spent more time looking at that.  But it
was something along those lines.)

BR,
-R
