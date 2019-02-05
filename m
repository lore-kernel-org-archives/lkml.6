Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2890AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B3A2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WF6UGjUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfBESTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:19:43 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44881 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfBESTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:19:43 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so3335163lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 10:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R2HTq1W5JdkaNVAIKLbyoKrZGXtJcW1hPRrcY8b6cH8=;
        b=WF6UGjUSIxGWh0KixGpHmUbklwMGf2HFzD6vbzlJ0th611gjAgPXag5eIAkO1b2jnt
         59IUwZMFclCSYzBdonTEz4+J5QcwN5PnHwCVtsmQ6eWAm8PV9p7Wq1naTpMg/lgC8zSw
         cs+hJXAmMK7oDtwM3Z2u2Xa2e7mEvyMfnAhvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R2HTq1W5JdkaNVAIKLbyoKrZGXtJcW1hPRrcY8b6cH8=;
        b=d2OeV4/iAGSTDomKt1wZqCO6T4EzA+kWtkrfM2NCoIeJBP6o1oz79gMdK3FnV+4E/7
         lNglBdC69E94oQwZLgCC7eJ2K2+ODZx3cW/D/MtUdUx6JKL3uJNM8pIUDG4Ymy63CnRE
         0vcabXI2pv/ItRxWFKLcoNDEA7C06UmbuE19i666UOLKpMITmkHMpJzv9DYBAK6+YWRa
         g43nPHaZELT1upX/nieyt6DESk02Leb9G5MSM1b67426ZMBjdC+HAMquo/2jCT6SOR+s
         zIleb8ZvT00w1hGdaJmISeVGvbgULEEqSEpdjjeibVyNscX/yT2fHf3iKodzf6CiCX3W
         Ic/g==
X-Gm-Message-State: AHQUAubuEE4xtcFwH+iVKK96b/S8GP8OYtz7LhBPY52mMab0dF1V/93D
        ZC5Vk4dwSe7QriXxNiAZNJ2BsYPIrhc=
X-Google-Smtp-Source: AHgI3IYqTITGFyJjaBRHo9x4f3ZLDa5clCHF4b0wn6KF/G5qohEIrcYk2tIxXMcoF2/aEIMeF7Nfqw==
X-Received: by 2002:a19:5510:: with SMTP id n16mr3798259lfe.68.1549390780682;
        Tue, 05 Feb 2019 10:19:40 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id q10-v6sm3582778ljh.72.2019.02.05.10.19.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 10:19:39 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id a16so3386008lfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 10:19:38 -0800 (PST)
X-Received: by 2002:a19:2d44:: with SMTP id t4mr3798012lft.90.1549390777906;
 Tue, 05 Feb 2019 10:19:37 -0800 (PST)
MIME-Version: 1.0
References: <e3c82a49-c601-effc-348f-f768656c659f@free.fr> <CGME20190204174549epcas4p4682667176f55101f69cc24cc455c9f3c@epcas4p4.samsung.com>
 <70618c25-83f0-b9db-51a3-c1d74b605a45@free.fr> <5f2a8378-1f22-6a52-356d-56d3b393ab1d@samsung.com>
 <05d2d193-4181-12ce-b4fb-4e8dec5aef27@free.fr> <7610c262-1451-9bb2-48a6-4daf6f534f6c@free.fr>
In-Reply-To: <7610c262-1451-9bb2-48a6-4daf6f534f6c@free.fr>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 5 Feb 2019 10:19:01 -0800
X-Gmail-Original-Message-ID: <CAE=gft5yAqLZDnYnjF2T1QbKfOKOagX+C1qQqD1DFU+2pr_WPw@mail.gmail.com>
Message-ID: <CAE=gft5yAqLZDnYnjF2T1QbKfOKOagX+C1qQqD1DFU+2pr_WPw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] Revert "scsi: ufs: disable vccq if it's not needed
 by UFS device"
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        SCSI <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 9:52 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> On 05/02/2019 18:24, Marc Gonzalez wrote:
>
> > /*** system hangs here for several seconds, then reboots ***/
>
> Silly me. The system crashes in ufshcd_dump_regs() which is a bug
> I fixed myself. Once I cherry-pick the appropriate fix, the board
> no longer reboots, but UFS init does fail.
>
> Full boot log here:
> https://pastebin.ubuntu.com/p/KwpRnWMFw5/
>
> In any case, it's obvious that disabling vccq on this system is
> a mistake. How would you solve the problem? (A quirk on top of a
> quirk sounds silly.)
>

I think Bjorn is right that this whole quirk seems to be compensating
for an incorrectly specified device tree (one that specifies
vccq-supply but that doesn't go anywhere).... though maybe this was
made to support boards with footprint-compatible UFS parts from
different vendors? Like the same DT is used for two different SKUs,
one which stamps down a UFS part that uses VCCQ, and another that
doesn't use it, though the wire is there.

But the revert itself shouldn't really fix anything for you Marc,
should it? It looks like this quirk turns on for Samsung and SKHynix
parts, which presumably just don't use VCCQ. So maybe your device tree
doesn't match your schematics, where the DT's vccq supply is actually
the vccq2 supply going into the UFS chip?
-Evan
