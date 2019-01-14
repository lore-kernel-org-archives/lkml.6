Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF2EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C39320659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IHJuPRO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfANTLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:11:50 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41513 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfANTLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:11:48 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so85466lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qsCTTx0oFensVFkkXkJGLtB8gGuyhNbRv5xayXdo3HQ=;
        b=IHJuPRO4X81fGl5zruwPNqJ3KKUbtPiuFqXdMbsbTAXmoVjdZbQ3YFQxoO43Q+9XQY
         MjxI0EuChCqrYOZ0j0b4oLoh9garSQpxUI6fMZlHL8gGiRkFGs1/sMstOx9m0sWIERZR
         2ECfhfOkUT0obgorusS28fB/9uQFE5jU9YSfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qsCTTx0oFensVFkkXkJGLtB8gGuyhNbRv5xayXdo3HQ=;
        b=fITbOMlwHWVvl0DXGg9RTQyM5nEffoB0Dz8SpMZ4r+A3Wqwz5QLVMkv6eTD4t1AeWQ
         g48MjhM6gA6n17c/jmHHE+UTLWBaAa5CYmn4TVJ7aDRb62KBDTy9HutxOhLkqY419Rhv
         8S48rSCyENV5ukvEMgicnJt+OK4mgUUkXz/VgnVuJ6VwbDHxaKerBEX7qeaS88J95Lkp
         3cx9cZBhfaDTng81qUFdlCsUo9fPF8br3KIFPZT80iyU7AtWZ1Nduw5SpZGNhYmnfpHv
         IQTezSBKiRfLIXpj1i3PuKRTwuiXWv8k1hDOgQS+4bA/aRtumuxVokCPTfy8goUYqqCC
         olvA==
X-Gm-Message-State: AJcUukcFNgmhV5nC7S9AFj60jJGPGXRFfuuvyWvgOgk95+RIqcuvUvoL
        QtpM0lYD+IdeUJiaIhV+c5mX1ZRBeB8=
X-Google-Smtp-Source: ALg8bN5ue2yuexf88UihQax2D/HD+4URGWUMhmZuxCKJ5Et4ALR15gcebVt5zPcQfxtGPhPCkMChTA==
X-Received: by 2002:a19:9a8c:: with SMTP id c134mr13962240lfe.152.1547493106036;
        Mon, 14 Jan 2019 11:11:46 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id p186sm218659lfd.83.2019.01.14.11.11.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 11:11:45 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id z13so71100lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:11:44 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr6125lff.16.1547493103716;
 Mon, 14 Jan 2019 11:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20190111233159.218342-1-evgreen@chromium.org> <yq1imyuv95c.fsf@oracle.com>
 <CAD=FV=ULU0JA1LAruHh2KyXOc0dzuQNZTjV0PAEX2J_Ra2=ZRw@mail.gmail.com> <CAE=gft7OhomkDT7pMBbRRgKK89CVhmigbebgqiDEqTZtjeXhcg@mail.gmail.com>
In-Reply-To: <CAE=gft7OhomkDT7pMBbRRgKK89CVhmigbebgqiDEqTZtjeXhcg@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 14 Jan 2019 11:11:07 -0800
X-Gmail-Original-Message-ID: <CAE=gft5ThU-hrbfV5bubZeU9okeZjvjbf3+7vGi_hS9k0ekx3Q@mail.gmail.com>
Message-ID: <CAE=gft5ThU-hrbfV5bubZeU9okeZjvjbf3+7vGi_hS9k0ekx3Q@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: Remove select of phy-qcom-ufs from ufs-qcom
To:     Doug Anderson <dianders@chromium.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>, masneyb@onstation.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 10:41 AM Evan Green <evgreen@chromium.org> wrote:
>
> On Mon, Jan 14, 2019 at 9:08 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Fri, Jan 11, 2019 at 7:37 PM Martin K. Petersen
> > <martin.petersen@oracle.com> wrote:
> > >
> > >
> > > Evan,
> > >
> > > > CONFIG_SCSI_UFS_QCOM selects CONFIG_PHY_QCOM_UFS, assuming that
> > > > this was the only possible PHY driver Qualcomm's UFS controller
> > > > would use. But in SDM845, the UFS driver is bundled into phy-qcom-qmp,
> > > > and phy-qcom-ufs is unused.
> > > >
> > > > Remove the select, since for SDM845 it adds useless drivers to the
> > > > build.
> > >
> > > Applied to 5.1/scsi-queue.
> >
> > Should this be accompanied by a change to arch/arm64/configs/defconfig
> > that sets 'CONFIG_PHY_QCOM_UFS=m'?  I don't personally have any
> > non-SDM845 devices to test on, but I'm sorta assuming they will all
> > break without the defconfig update?
>
> Right, thanks for pointing that out. I'll send out another patch to
> tweak the defconfig.

Sent out at:
https://lore.kernel.org/lkml/20190114190112.167922-1-evgreen@chromium.org/T/#u
