Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6426DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7EE2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WiazKc/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7EE2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbeIYCuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:50:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43107 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeIYCuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:50:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id m84-v6so19519421lje.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Es2GCsBeoh0xgffgDVOhXtfOFaUe/MI/pWXbJZRzYZQ=;
        b=WiazKc/8llqj6/24IEifkY8EyS47SF0Ib25upzvMmlkdpAeTg5OPgch7wKdEXHkd6e
         dUTxbfxPCz5TzUymXYMXlCYbQhk6hcmdjhMkZGNZ+CvQoYS5W0CYe+sUqkmlL3g9F520
         P6MlCeJ75FZTJauW1qUwAtlAKRfWVXtFNqahI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Es2GCsBeoh0xgffgDVOhXtfOFaUe/MI/pWXbJZRzYZQ=;
        b=HeWfnRpSWCOh5o+KagczswoUc0Q4vp+8c2q3dhkKdPmhMrr1hLM6Z5+JA1BBfmRFQp
         b+3665PcJ86HmyRTYBHqH8vnx01AoFKyXQPkHbOHZse7kqsvI/Rd9vZ2zOroFO0+HTAi
         ttzelUMd7xhzaAXa5rL8yU2Nu3KRJGX2GiFW9PRNJakW7G1yMkRVc54z3r+6dHOeHQSD
         yeXwA1xoHqN9IfiqQ/AAoMi51J5FLNGwz/sxAZ9U5vN80jYDnY++6lNjuyNPQOgYG4EM
         iy7NmKB7Vb5TOq8IhM38Cjdj9qlxYVmUgqmv78cWQ6mGfXDesKKu1qQEDYSmVgue4vTc
         MX4A==
X-Gm-Message-State: ABuFfoi0JxYDfro0BjJGSVk9BZVOq2NtoV5tCpyAKvzc/L7C4SDgBq8Y
        mpplc9+c0X1uiZOu3RtfVcab11QqrMo=
X-Google-Smtp-Source: ACcGV63/2WZ+c0tFXbJ5zLB5XRZolwRcRZsu/ZkfTtP8/0Yl/QL86cO2nrVXOVDW++EkfGfkdRGNqQ==
X-Received: by 2002:a2e:2ac3:: with SMTP id q186-v6mr331650ljq.123.1537821974603;
        Mon, 24 Sep 2018 13:46:14 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id f4-v6sm58752lfa.9.2018.09.24.13.46.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 13:46:14 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id x24-v6so17938489lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 13:46:14 -0700 (PDT)
X-Received: by 2002:a19:2bcb:: with SMTP id r194-v6mr316705lfr.147.1537821566621;
 Mon, 24 Sep 2018 13:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <1537770516-28410-1-git-send-email-sayalil@codeaurora.org> <1537770516-28410-3-git-send-email-sayalil@codeaurora.org>
In-Reply-To: <1537770516-28410-3-git-send-email-sayalil@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 24 Sep 2018 13:38:48 -0700
X-Gmail-Original-Message-ID: <CAE=gft5k-rC=EJrz06Oh8BdNfcKF5ukavGzDqvYHOVTf84AyUg@mail.gmail.com>
Message-ID: <CAE=gft5k-rC=EJrz06Oh8BdNfcKF5ukavGzDqvYHOVTf84AyUg@mail.gmail.com>
Subject: Re: [PATCH V14 2/2] scsi: ufs: Add configfs support for UFS provisioning
To:     sayali <sayalil@codeaurora.org>
Cc:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, adrian.hunter@intel.com,
        Joel Becker <jlbec@evilplan.org>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 11:29 PM Sayali Lokhande <sayalil@codeaurora.org> wrote:
>
> This patch adds configfs support to provision UFS device at
> runtime. This feature can be primarily useful in factory or
> assembly line as some devices may be required to be configured
> multiple times during initial system development phase.
> Configuration Descriptors can be written multiple times until
> bConfigDescrLock attribute is zero.
>
> Configuration descriptor buffer consists of Device and Unit
> descriptor configurable parameters which are parsed from vendor
> specific provisioning file and then passed via configfs node at
> runtime to provision ufs device.
> CONFIG_CONFIGFS_FS and CONFIG_SCSI_UFS_PROVISION needs to be enabled
> for using this feature.
>
> Usage:
> 1) To read current configuration descriptor with index X
>    (where index X can be 0/1/2/3) :
>    cat /config/<device_name>/ufs_config_desc_X
>
> 2) To write configuration descriptor with index X :
>    echo <config_desc_buf> > /config/<device_name>/ufs_config_desc_X
>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---
>  Documentation/ABI/testing/configfs-driver-ufs |  12 ++
>  drivers/scsi/ufs/Kconfig                      |  10 ++
>  drivers/scsi/ufs/Makefile                     |   1 +
>  drivers/scsi/ufs/ufs-configfs.c               | 237 ++++++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd.c                     |   3 +-
>  drivers/scsi/ufs/ufshcd.h                     |  18 ++
>  6 files changed, 280 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/configfs-driver-ufs
>  create mode 100644 drivers/scsi/ufs/ufs-configfs.c
>

Reviewed-by: Evan Green <evgreen@chromium.org>
