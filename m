Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9DCC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAA320818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="X30gQk+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfBECmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 21:42:35 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39788 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfBECme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 21:42:34 -0500
Received: by mail-ot1-f67.google.com with SMTP id n8so3424449otl.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 18:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rfn15K4SKn6z7MAcJdS3g8Bin1BXrlo6qteBzIkqqFY=;
        b=X30gQk+mVPiZC8PEeNhDZ10xEW7W/dLV45KwCy9tmdylQhyQoZu7LaQRJ1fjUOe49j
         L5pmr/AyDnWac6VH4/XZoCCrPvHLcq3n0bdwAa6rGJ/Qf/wz1v9Ue7JFbhkqYtUTGFWQ
         zicNmFlJ81MHlX/jQ7RgEve7uie1OAhbYoOVUk+5zfNFYAqWeqL7XX1ftMTIMsJZArkW
         ee3yDPxaGIk6QZM7TXWgW1rkP4Pe3UxMHdydQqQb8ZG1zGOFVapGt0vxz/ZmdYmpM1qb
         PFEtcFkZtfPM0vl6hF5roqWOLQrB1DlaiCWCNAkdGiQujW2SwvMOHHZw1HjsAdgxeuaU
         jR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rfn15K4SKn6z7MAcJdS3g8Bin1BXrlo6qteBzIkqqFY=;
        b=AMVZo2N8ktNH245TPI5y0XWV8FmoTrd+YyvrPVjW13Dbih9P80c6HlBrRnVApG40mY
         sOVSjAdVICCrWbR6H+w+N8rkTc9As9YVkC2vAsB3Kj30cd7OWZf5DOTwmuAZ5M6E2FxJ
         i5o3/hzaC+bf8I7bN5bQ4RoeSGpT9CNOMmPx0wsnQXHEkf4py0d4EON3phUcWfPkZOus
         y3DtXGkx26mZAfKLaDz8nhBi7o/66JVvWqU2oBX9BD0PmJ/L8CicFKigOPZjPsK4OlKE
         CbzVJAb3vQTr2UnX6LJ50ITa/nXpRaXbdA+CiRfgIb0Gi0nPtC8g8xOsDXwTS7ic0dKB
         KwDQ==
X-Gm-Message-State: AHQUAuYzIxrNInUNRqhf/ueETNuTMz/0ToAxDlbqIMSQWCCVE+K6tvKz
        UpfXuzWnxktID8xQjqq7uxRBxf7JO/80E/lEjv6PoQ==
X-Google-Smtp-Source: AHgI3IY0Ec3msV1jRHV+mqCoqQd6+PNY1gi3sB7M2PxNu9M17npQbLJmbIwPMuT2StdOxS2jyEvvT/aq6ftM0kqyMi0=
X-Received: by 2002:a9d:3a0a:: with SMTP id j10mr1354228otc.229.1549334554161;
 Mon, 04 Feb 2019 18:42:34 -0800 (PST)
MIME-Version: 1.0
References: <20190104192410.GA11084@jordon-HP-15-Notebook-PC>
 <20190114085839.GA13316@quack2.suse.cz> <CAPcyv4hV0VQv9bMz9FWW_n734KiHY-HfLMHW_atG8Wqbnrf34A@mail.gmail.com>
 <CAFqt6zYZdpckNPFGx2+nbNs=1UKSGtFvMc5YMvPEnmK4PJyGMQ@mail.gmail.com>
In-Reply-To: <CAFqt6zYZdpckNPFGx2+nbNs=1UKSGtFvMc5YMvPEnmK4PJyGMQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 4 Feb 2019 18:42:23 -0800
Message-ID: <CAPcyv4h819u1teAQrwJEbPUzucwTwOENYwi4nPHnGvvX3YSx5g@mail.gmail.com>
Subject: Re: [PATCH] fs/dax: Convert to use vmf_error()
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 6:33 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Hi Dan,
>
> On Tue, Jan 15, 2019 at 4:00 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Mon, Jan 14, 2019 at 12:59 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Sat 05-01-19 00:54:11, Souptick Joarder wrote:
> > > > This code is converted to use vmf_error().
> > > >
> > > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > >
> > > Dan, you are merging DAX patches these days. So probably you should add
> > > yourself to 'FILESYSTEM DIRECT ACCESS (DAX)' in MAINTAINERs.
> >
> > Sounds good, I'll merge this and get MAINTAINERs fixed up.
>
> This is not reflecting in linux-next. Is this queued for 5.1 ?

Thanks for the ping, I'll get it queued up shortly.
