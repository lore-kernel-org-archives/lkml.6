Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1156C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA43620645
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m5OiRxIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfANSmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:42:24 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35417 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfANSmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:42:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so58410ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 10:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vVB1DILAKbvLonh3NQAAphM1XDF2/wNMQUrNj/QPbtk=;
        b=m5OiRxIfBf1TNb/WOI5Cxq+5/d/i4Ha9+lyIHO/g+xT5suC5ta2jCCZSwj+j1Exek6
         zvOfBm4Cgi3UjB+yZRUTdtnuQTGatjh29x0mGuZ96pknNccB3VXzIHpJ6uQDKnBc8r8F
         RgpKyTtnAjbcmqxEet136Mp/Z+Wr5eQmiEON0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVB1DILAKbvLonh3NQAAphM1XDF2/wNMQUrNj/QPbtk=;
        b=cmNQfVVqhzVPlEOSL5RswwJ94rQasfWLb1E0kDvazEeG8aQcgTPA00933M6BXc5eKN
         z/wx27jYyYc5rP03tsu226sgrro61a1dOI3iAINYZhmIAXrYXdg7jvuunyJ3BtqGBSy0
         dkzfyYCh1J64rdqQos1FOD1RcgjQY6PpYjiDjJYc8pHbHzgvIEZukontCSw6ttFRf/g6
         Ds/EyUI5GeThO7w0/NCvksqoirzE0qcRPejbVzGElIdvV7l9nnTiOl8JLcFSyMk7kBLK
         IZDKiONd5Jnas3XH80QDovSsYOwmUsAWOUWi4WSB8W8fnTsx+eQIsZJtli6f3KWBL6sn
         kSlQ==
X-Gm-Message-State: AJcUukcNRjH9NDrg1obVDC4I8RjfwDK0V9eFa/17M+7YBVxM/ieQ4Rjg
        m1Kj+637NHKWD/8sOMx2leiF8BHcOzQ=
X-Google-Smtp-Source: ALg8bN5WDzlPxoEwmhIvwp0e5Q36gUq0/WWelS2x8EBllwCKtUQ3LsQd/eSC9RbbxH+IHqK+/7mZ9A==
X-Received: by 2002:a2e:612:: with SMTP id 18-v6mr15029873ljg.125.1547491340934;
        Mon, 14 Jan 2019 10:42:20 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id c5-v6sm202818lja.62.2019.01.14.10.42.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 10:42:20 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id u89-v6so61853lje.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 10:42:19 -0800 (PST)
X-Received: by 2002:a2e:8446:: with SMTP id u6-v6mr17329495ljh.74.1547491339523;
 Mon, 14 Jan 2019 10:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20190111233159.218342-1-evgreen@chromium.org> <yq1imyuv95c.fsf@oracle.com>
 <CAD=FV=ULU0JA1LAruHh2KyXOc0dzuQNZTjV0PAEX2J_Ra2=ZRw@mail.gmail.com>
In-Reply-To: <CAD=FV=ULU0JA1LAruHh2KyXOc0dzuQNZTjV0PAEX2J_Ra2=ZRw@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 14 Jan 2019 10:41:43 -0800
X-Gmail-Original-Message-ID: <CAE=gft7OhomkDT7pMBbRRgKK89CVhmigbebgqiDEqTZtjeXhcg@mail.gmail.com>
Message-ID: <CAE=gft7OhomkDT7pMBbRRgKK89CVhmigbebgqiDEqTZtjeXhcg@mail.gmail.com>
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

On Mon, Jan 14, 2019 at 9:08 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Jan 11, 2019 at 7:37 PM Martin K. Petersen
> <martin.petersen@oracle.com> wrote:
> >
> >
> > Evan,
> >
> > > CONFIG_SCSI_UFS_QCOM selects CONFIG_PHY_QCOM_UFS, assuming that
> > > this was the only possible PHY driver Qualcomm's UFS controller
> > > would use. But in SDM845, the UFS driver is bundled into phy-qcom-qmp,
> > > and phy-qcom-ufs is unused.
> > >
> > > Remove the select, since for SDM845 it adds useless drivers to the
> > > build.
> >
> > Applied to 5.1/scsi-queue.
>
> Should this be accompanied by a change to arch/arm64/configs/defconfig
> that sets 'CONFIG_PHY_QCOM_UFS=m'?  I don't personally have any
> non-SDM845 devices to test on, but I'm sorta assuming they will all
> break without the defconfig update?

Right, thanks for pointing that out. I'll send out another patch to
tweak the defconfig.
-Evan
