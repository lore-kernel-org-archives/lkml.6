Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2893CC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 22:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC950222CF
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 22:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolivas-org.20150623.gappssmtp.com header.i=@kolivas-org.20150623.gappssmtp.com header.b="LSkl+e3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfAEWCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 17:02:18 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45231 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfAEWCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 17:02:17 -0500
Received: by mail-io1-f68.google.com with SMTP id c2so9990882iom.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 14:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kolivas-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DmRVZBZmsTHVFdd46v+Um/GFIoz26g8IV9CwUqNwG/Y=;
        b=LSkl+e3XmUQBJ/pXDY8K5MBL6SD2hskzrJ7D8Po4q0ImKQuRFKTKPOZ7N7dqY494Vd
         Jesb/5HfuD+JrRofHiOUTgVWiUo6oRXH6LcA7YV6LOQ89JMEn719X/RNEgEkgkhLEdoW
         JrASAYPRbgRxifo7EbWQ6KSKCR/WaXxC32T55BBnSoIzDhcNObLaOmMWyzDB07t2OFBj
         JHHOKtRoeYOhoCi7vWOEm9DPCqhSFH7yBowxvQDL0XakJ8ESYWybGwwK/4D6nSbMr+o7
         3RbUvBZRNXNUJe4BYuXkca1OkM+RV/c7aVp0L5DGo6Fac6Z4YPA/fR9izQublQpdPKsF
         6NFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DmRVZBZmsTHVFdd46v+Um/GFIoz26g8IV9CwUqNwG/Y=;
        b=rWXu5mb0CgLL66YGlsolbeKpuAelksPozVcs1sxCPe69QtJATU6M5/yEfv3FSfWXJ6
         s5GNi9tmuWZjFsZ8CQdo+EkESSxZU0MfBZBQU1LHDXONdlzTR9C1/QL20QkzRK5jMYPt
         s/LN2Y5vx/qLkJi91mndkfWVHiHXUSP/3QcfQ371g6DG+lnvqP3l5osHC34og1knJjrA
         CQ2RQyQjlwKP4BCkV4J1dDFR04Ciw2Hm3tGbDJn4FQEpWuG9dTiAWERgLNU43WOOzw2E
         IUJwzdGIu1fnLpqILHEHmxPYbMbQ8wKhJJD0ENgjSlOnjYjWafXPj/WSRX3X5b28+BKk
         4Z4A==
X-Gm-Message-State: AJcUukdfnuX6a/PkcKb4ObFVJ1i1FrET5fFhXye6Q9gwBlKuEiFcmCNz
        LxgVrD762D+630DOPqqZ2GzwWz2c32KobtD0ar8CTA==
X-Google-Smtp-Source: ALg8bN6i/WFVWzGCpZllAjJqZ6af4jNN7RgYS6YlFy5qjdXE6rBd7v6IjVicbGFqH7Tdk71xQXaPIUhhPS6jvuu8NPA=
X-Received: by 2002:a6b:7d42:: with SMTP id d2mr40056094ioq.150.1546725736452;
 Sat, 05 Jan 2019 14:02:16 -0800 (PST)
MIME-Version: 1.0
References: <CABqErrHKFshAMBPHJp2vmGFE6k1GL1oDMSMbDRcBJNfUSxt9KQ@mail.gmail.com>
 <1546709942-28634-1-git-send-email-saranya.gopal@intel.com>
In-Reply-To: <1546709942-28634-1-git-send-email-saranya.gopal@intel.com>
From:   Con Kolivas <kernel@kolivas.org>
Date:   Sun, 6 Jan 2019 09:02:05 +1100
Message-ID: <CABqErrEyF0Fr57gk12_XNNhLdQX0A9b9OPyGeVfGVh1dvHhRrw@mail.gmail.com>
Subject: Re: [PATCH V2] usbcore: Select only first configuration for non-UAC3
 compliant devices
To:     "Gopal, Saranya" <saranya.gopal@intel.com>
Cc:     gregkh@linuxfoundation.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>, felipe.balbi@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saranya

On Sun, 6 Jan 2019 at 04:41, <saranya.gopal@intel.com> wrote:
>
> From: Saranya Gopal <saranya.gopal@intel.com>
>
> In most of the UAC1 and UAC2 audio devices, the first
> configuration is most often the best configuration.
> However, with recent patch to support UAC3 configuration,
> second configuration was unintentionally chosen for
> some of the UAC1/2 devices that had more than one
> configuration. This was because of the existing check
> after the audio config check which selected any config
> which had a non-vendor class. This patch fixes this issue.
>
> Fixes: f13912d3f014 ("usbcore: Select UAC3 configuration for audio if present")
> Reported-by: Con Kolivas <kernel@kolivas.org>
> Signed-off-by: Saranya Gopal <saranya.gopal@intel.com>>

I can confirm the above patch fixes my problem.
Tested-by: Con Kolivas <kernel@kolivas.org>

Thanks!
Con
