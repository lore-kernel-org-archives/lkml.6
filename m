Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F969C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA4A20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mjhp0j9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfANRIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:08:14 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42084 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANRIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:08:13 -0500
Received: by mail-vs1-f67.google.com with SMTP id b74so14094465vsd.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 09:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+hkFKGlMbvmrv7R/VgDdBqQimzNoMqJG+RMF85uG6Q=;
        b=mjhp0j9PsFLQ6CoZFgAa7ErKJVYsZhpJwFaIASsO8iCoN06sh4aAktDrQY5cbNL7jP
         vGh+20GUWqlpDFQx7s6uxMmAJ336k/cpVWmr0sq96awsF09TAqFjwbSCyMazBeJaAyfQ
         GuDjPa7n9NRMY6CRBbRQetT+HOXMJZ5jBuglw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+hkFKGlMbvmrv7R/VgDdBqQimzNoMqJG+RMF85uG6Q=;
        b=hj9MLA1qXcIYDZelpDwi3lNIXa+RF8IA8fBnbFEjQBGhFQYBC1UI2Z8w3RXXgQfrNP
         d1/hFDrsZ1H35tZLnP9L/BklBfnIv6U1PP6YbSLTbQSsI2O0OpzpmmMuncxh90/rzN+K
         yEGLjQgEmUhI+pS1jua/SNXl4dk4EEqLUg2Q8bPjAS0a4Cj7+UlELRm+0y/zh7w35QKJ
         W6rvZVVIiB4e7mGSkM5sq9nnR1Kh4DhRouw/Rwi+YIrMjWKyutmtoruunbyIAU6ESUep
         Psm8czK+arCaqa5UL3Xoy4nhxdknzhxarJOBQSKuVoC+cIvdznsFxtlXPPax8hAIG/BZ
         qo8w==
X-Gm-Message-State: AJcUukeQjgB8Gvq3PV6wDhNM0v7z3CgyIsfoJiFx4KieiqSsxg6vIL2V
        9PUnozMzyjPgMrCzCpNfLbCsUiWv4kE=
X-Google-Smtp-Source: ALg8bN5zjj0CcBXmhqVc/ervkUbCIir1rM4Kj8U2GkeU22QHrrtEhReB5jjBadpYTc4OwFuG/IyWqg==
X-Received: by 2002:a67:c202:: with SMTP id i2mr10004017vsj.11.1547485691838;
        Mon, 14 Jan 2019 09:08:11 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id p8sm45609023vke.27.2019.01.14.09.08.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 09:08:11 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id e16so7319068uam.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 09:08:10 -0800 (PST)
X-Received: by 2002:ab0:60da:: with SMTP id g26mr9510610uam.104.1547485690077;
 Mon, 14 Jan 2019 09:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20190111233159.218342-1-evgreen@chromium.org> <yq1imyuv95c.fsf@oracle.com>
In-Reply-To: <yq1imyuv95c.fsf@oracle.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 14 Jan 2019 09:07:57 -0800
X-Gmail-Original-Message-ID: <CAD=FV=ULU0JA1LAruHh2KyXOc0dzuQNZTjV0PAEX2J_Ra2=ZRw@mail.gmail.com>
Message-ID: <CAD=FV=ULU0JA1LAruHh2KyXOc0dzuQNZTjV0PAEX2J_Ra2=ZRw@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: Remove select of phy-qcom-ufs from ufs-qcom
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>, masneyb@onstation.org
Cc:     Evan Green <evgreen@chromium.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 11, 2019 at 7:37 PM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Evan,
>
> > CONFIG_SCSI_UFS_QCOM selects CONFIG_PHY_QCOM_UFS, assuming that
> > this was the only possible PHY driver Qualcomm's UFS controller
> > would use. But in SDM845, the UFS driver is bundled into phy-qcom-qmp,
> > and phy-qcom-ufs is unused.
> >
> > Remove the select, since for SDM845 it adds useless drivers to the
> > build.
>
> Applied to 5.1/scsi-queue.

Should this be accompanied by a change to arch/arm64/configs/defconfig
that sets 'CONFIG_PHY_QCOM_UFS=m'?  I don't personally have any
non-SDM845 devices to test on, but I'm sorta assuming they will all
break without the defconfig update?

Added a few more people (and linux-arm-msm list) to this thread in
case this matters to anyone.

-Doug
