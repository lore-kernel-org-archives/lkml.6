Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF364C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9512080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LNh19b6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9512080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJ3PeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:34:01 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34333 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeJ3PeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:34:01 -0400
Received: by mail-qk1-f193.google.com with SMTP id a132so6597665qkg.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 23:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7qloMx7MXgZFHmdgEZeObmPnRUP6UEEAQkrGuSCTRkA=;
        b=LNh19b6Da6yHzj14njUwhlgDzBCiOpNPlQlOYfv6XXBKxZEhDygANuMrycyReb/kkV
         dhHLsnuAwhR4mRWg3M/lHPWr7pTsPtEySLQwVj0OpkYVU7Lf+N/GBo+DmixYZ+2oNv5N
         0M0NN4VHRQtMu8ajKEejtxhgf6TSP4Pb4KOFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7qloMx7MXgZFHmdgEZeObmPnRUP6UEEAQkrGuSCTRkA=;
        b=B+fzGT2VRr52f/YKEFSOmwJ/4ysEcLL5ung42O7o/AjaEN7HDjSoNols93MtH1w4/1
         fXbx9KRkzCCdAXkxf6mlU6N19q8BcSE7Qwc8/jBzg27fxbZPnu3keeRcuX5E0fym8tp4
         oKETSt/D6M+HviHDrjqsng8btGYj5meDRkbBOQ7WMytDVW90ikh7SDSeOTxYSPGiNAya
         svvw+qSqPyhsXfYtrJoE4jYvqNvf7RVNz0FXnRHLcsehfcv0tKwRKLYP6ltsz22Y0p2l
         9Kui6nh6U17U/mXAoVqHeAGrDlBySffT9Phq/AN3wgRVh+iYNMSU2hKXInvxEGBZViBD
         F9Jg==
X-Gm-Message-State: AGRZ1gLwbLZwV1lonYHQ598ouUHG1bOJjlO29R3F7p1P7UKjHJev5ou6
        F7pFbvqLlqrKrPO/2jWpKFYzWZ4+gJ2pImTo6CZqFQ==
X-Google-Smtp-Source: AJdET5csgB1WoVeILYpEUHAKTWxqjgrSLT7qAHgpVJyFfUBLd6mOLgBnv1dQlshl2U0BO+HF1Dugl7Xif6IsRImyhAk=
X-Received: by 2002:ae9:f106:: with SMTP id k6-v6mr15003814qkg.34.1540881707513;
 Mon, 29 Oct 2018 23:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <1540290081-15827-1-git-send-email-suganath-prabu.subramani@broadcom.com>
In-Reply-To: <1540290081-15827-1-git-send-email-suganath-prabu.subramani@broadcom.com>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Tue, 30 Oct 2018 12:12:42 +0530
Message-ID: <CA+RiK64Y=FLr=SZmxEoCvWCvZq8ppqFsL=q2L1Q7T5sZfDQfkQ@mail.gmail.com>
Subject: Re: [v6 0/4] mpt3sas: Hot-Plug Surprise removal support on IOC.
To:     helgaas@kernel.org, lukas@wunner.de, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, ruscur@russell.cc,
        sbobroff@linux.ibm.com, Oliver <oohall@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any update on this ?
In V6, I have posted has only defect fixes (Other than HBA Hot-Plug
Surprise remove support).

We are reworking and incorporating the suggestions from Bjorn.
And after covering tests, we ll post Hot-Plug Surprise removal patches.

Thanks,
Suganath Prabu
On Tue, Oct 23, 2018 at 3:51 PM Suganath Prabu
<suganath-prabu.subramani@broadcom.com> wrote:
>
> v6 Change set:
> Incorporated changes as suggested by Andy.
> In Patch 1 converted while loop to do while in
> function mpt3sas_wait_for_ioc_to_operational().
> And in patch 3 removed parentheses.
>
> V5 Change set:
> V5 post has only defect fixes.
> We are reworking and incorporating the suggestions from Bjorn.
> And after covering tests, we ll be post Hot-Plug Surprise
>  removal patches.
>
> V4 Change set:
> Reframe split strings in print statement, to avoid
>
> V3 Change Set:
> Simplified function "mpt3sas_base_pci_device_is_available" and
> made inline
>
> V2 changes:
> Replaced mpt3sas_base_pci_device_is_unplugged with
> pci_device_is_present.
>
> V1 changes:
> In Patch 0001 - unlock mutex, if active reset is in progress.
> Suganath Prabu (4):
>   mpt3sas: Separate out mpt3sas_wait_for_ioc_to_operational
>   mpt3sas: Fix Sync cache command failure during driver unload
>   mpt3sas:Fix driver modifying persistent data.
>   mpt3sas: Bump driver version to 27.100.00.00.
>
>  drivers/scsi/mpt3sas/mpt3sas_base.c      | 75 ++++++++++++++++++--------------
>  drivers/scsi/mpt3sas/mpt3sas_base.h      |  8 +++-
>  drivers/scsi/mpt3sas/mpt3sas_config.c    | 28 +++---------
>  drivers/scsi/mpt3sas/mpt3sas_ctl.c       | 21 ++-------
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 38 +++++++++++++++-
>  drivers/scsi/mpt3sas/mpt3sas_transport.c | 70 ++++++-----------------------
>  6 files changed, 106 insertions(+), 134 deletions(-)
>
> --
> 1.8.3.1
>
