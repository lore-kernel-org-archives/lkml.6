Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CB3C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23195218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Caxdk7DJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfBAO6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:58:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41874 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfBAO6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:58:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so7409402wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 06:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9RzvE6IlFkYH1zrjn7bEImSqNMwzq9ZsRxNJvpNEuk4=;
        b=Caxdk7DJUhkd1nDpmDcmemUBSg0+ZXIMkIkdBCBXDGkh9SSJxg/NQ4N6fP50oYjTD3
         tn1N4XkU5rXjWYepKglB4F/hIbEChttlsOiOERiLuLq38d0DVniP0x85VE/FO1aPnzOa
         jTvPHqlQTYqiVXK5lMDuDZqrkYHCvSME/rvbL8WtcrTjMKcfpdS7vexTT27nIjM692On
         KAMP4PEIfaJjzP8XmyES+3vXMdpNZ6viC944uxKehn+GSFssc2shzJLpy+D0fvmJ33ji
         wVDJ7XTFacGRjrfwD8a1uILFUCUffc3So4bAp9/fK/XoJt12ZzfCpSqoovSi0PJGKjN3
         GyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9RzvE6IlFkYH1zrjn7bEImSqNMwzq9ZsRxNJvpNEuk4=;
        b=T8Yw0W43tSpsmzrCcIjNKFPhndw+3bAuD5DpPVMtM99z/3Ikho1Zoj6VHFzCsV0Zkp
         qGJP3pBiw5ZsLZH3z6ywmCnfAtQ0djeI6yZlclBxRlKLcuk79F5V6iCEEWjMtn3Sgm51
         pJ3h1tYfN66UZonlCnWBTEDk1+Z11yeEsBCvBmARSCmtVRCQ/H85JOraQYOFgfk94yxg
         dQAR5HzpvLtEdOWdvLWnBDENOB4Pqocs8HAqeiHHk2QZlN+dkYwJcvHzrPVehjKQ674Z
         LA1gmOIvioJV4SvVEZdWkgHJAiMpOYVwflZbhWP0WyvfmK2Wb1Vsu+16BQmxS2OtJNDx
         G6lA==
X-Gm-Message-State: AJcUukeOGC5ZczBaORHP0UnkqqhZZ2WZgTvrp2QsE05UXFxJMxL/ShO6
        6YZD13g7IcRIM+gzJnS/GNwrHAWWQhZYuLKdM3Xn
X-Google-Smtp-Source: ALg8bN5ZbMBQ24Ydr2ksNjrjx6oGYv+O72uK0rsiynjl8Fw5H1z44oKwU9oCbRk/5DTpIszy/iNAAiKs91tZlBbRpAk=
X-Received: by 2002:adf:9484:: with SMTP id 4mr36667535wrr.98.1549033089851;
 Fri, 01 Feb 2019 06:58:09 -0800 (PST)
MIME-Version: 1.0
References: <20190201165130.1d9c9850@canb.auug.org.au>
In-Reply-To: <20190201165130.1d9c9850@canb.auug.org.au>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 1 Feb 2019 08:57:58 -0600
Message-ID: <CAErSpo7=GUvSpYWYKVBdH_ypoqOHyU7P_zq_QX_QYTx8ynvgiQ@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the pci-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:51 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Bjorn,
>
> Commits
>
>   f14bcc0add3a ("Revert "PCI: armada8k: Add support for gpio controlled reset signal"")
>   432dd7064aa1 ("ARM: cns3xxx: Use actual size reads for PCIe")
>   65dbb423cf28 ("ARM: cns3xxx: Fix writing to wrong PCI config registers after alignment")
>   a4ace4fa2007 ("PCI: imx: Fix checking pd_pcie_phy device link addition")
>   a6093ad7fc49 ("PCI: imx: Fix probe failure without power domain")
>
> are missing a Signed-off-by from their committer.

Dang, that's my fault.  They were originally commited by Lorenzo, but
instead of merging Lorenzo's branch directly, I cherry-picked the
commits into my for-linus branch so I could tweak a changelog.  I'd
fix it, but Linus has already pulled them.  Sorry, I'll try to
remember to do this right next time.

Bjorn
