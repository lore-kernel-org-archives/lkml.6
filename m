Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C35C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BFC2190C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFd9/Uwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389763AbfBOPzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:55:48 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35233 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbfBOPzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:55:48 -0500
Received: by mail-lf1-f67.google.com with SMTP id v7so7557819lfd.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 07:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o54ghrc2l/jNafhiTYiDZA2Ao93S8rZIOFd+ui3neas=;
        b=SFd9/Uwg4IsR0lDAfwNPX2Z7SSXbwNN2gTapYP+NZVnTDgssqXeNCPpq2KUo0nbhEc
         dvl5Nqx5aGEROxnG1/QDuctsWGmjlvRrHxeiaBneIbqvN0Ck0t+9PmCHnISvrst+5vhG
         KYNlPZpWC1FZNX27xh3ARtrd5OG8rjrr8UuYNw2nIXHIoVNV0/0jRHdHfVRl3h3gTDBP
         +VeydePpymdtW8v6AItOfrto5tjA5wY5REWiZOrGSKaOMDTxI8GqKWmHuEpOQALNc5et
         EEIr00xfI6ZELz4BQZvQ/lbCUaEGiRWplr8JH9bz0zOJV2gWudAFgjdeNy/YhQHPmG9U
         eLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o54ghrc2l/jNafhiTYiDZA2Ao93S8rZIOFd+ui3neas=;
        b=fsJfpgVIeHGwTBW6ym2ag4Q0xszdF1NbYxfWEDFsudQXNPD4H60VokGw5yulF4i3J9
         sB64Qdhp/C9mC7B5r7BpkwVDc0k42CMnTzbk+KJ+MrRNRCmkHsa2mLjdCYwPlTLXvrxj
         iWXbVwcoe/F/N0naz8OvXtOHC0FT4aje38IDRvXd0c7zYzsnl3OIBPWFhA/Xy8SyoyPW
         FWpxtBNPhlbSg98okwDFDMZwVckbmaAKb6kC7A8orvzrnqREVsjf2rmj1MB5VjLnRu3p
         0SXf9S6e5VpjsEW5hhik6DcszKy25/E5iYjk4Y2VOh7EzhLrhpE+g6KNraNdMyTdMmAZ
         7RdA==
X-Gm-Message-State: AHQUAuZfADvLx0LQfhF2v3NVrTTsMc8C31mLzAOUlR+t4wYhu2Vf0Ue3
        d6iV5PglpJrx2znjALQrH7w2i8pA0mZaymf26ls=
X-Google-Smtp-Source: AHgI3IaQPBuZLa3/pDfjze6E2jAZMpSWiVp6RPmtEg8iFSOVFYAS0YRKAtJWqbMWNP0loiAG9J7l3OCkVvU/O59JhhQ=
X-Received: by 2002:ac2:5624:: with SMTP id b4mr6275872lff.41.1550246145818;
 Fri, 15 Feb 2019 07:55:45 -0800 (PST)
MIME-Version: 1.0
References: <1550222224-26475-1-git-send-email-Sanju.Mehta@amd.com>
In-Reply-To: <1550222224-26475-1-git-send-email-Sanju.Mehta@amd.com>
From:   Allen Hubbe <allenbh@gmail.com>
Date:   Fri, 15 Feb 2019 10:55:34 -0500
Message-ID: <CAJ80sas1Aryeo14JnTKS3NXL7wov6KPHaUrSzvNyTO=Qa=Mv2g@mail.gmail.com>
Subject: Re: [PATCH 0/4] bug fixes in ntb_hw_amd and ntb_perf
To:     "Mehta, Sanju" <Sanju.Mehta@amd.com>
Cc:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 4:17 AM Mehta, Sanju <Sanju.Mehta@amd.com> wrote:
>
> From: Sanjay R Mehta <sanju.mehta@amd.com>
>
> Add bug fix for ntb_perf and ntb_hw_amd
>
> Sanjay R Mehta (4):
>   NTB: ntb_perf: Increased the number of message retries to 1000
>   NTB: ntb_perf: Disable NTB link after clearing peer XLAT registers
>   NTB: ntb_perf: Clear stale values in doorbell and command SPAD
>     register
>   NTB: ntb_hw_amd: set peer limit register

This series,
Acked-by: Allen Hubbe <allenbh@gmail.com>

>
>  drivers/ntb/hw/amd/ntb_hw_amd.c |  8 ++++----
>  drivers/ntb/test/ntb_perf.c     | 14 +++++++++++---
>  2 files changed, 15 insertions(+), 7 deletions(-)
>
> --
> 2.7.4
>
