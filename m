Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2197BC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED8D21907
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfAZQGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:06:10 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43451 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfAZQGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:06:10 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so13970296qtj.10
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 08:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bY9vGXVMTGEOxoB/WP7Wl37Twk7fRvbBncYG2Yr9uXU=;
        b=jAobbGKAv1mdYz8tyTCjq2oRNwbTrih096GbKi9j4Ohcyfn3iAuJRwN+CKSo3nPx5Y
         FzrKjcZbjbdIZHg+wVcolhtLyzxVL8RvOtrRUcPUYGVH7hMPlFZP9YrDe/7mp5Tinomv
         +zeNnotsRbTtgFqwrqYysrJc2PFkS5ZlLpeJZKKhHGxoY47mWaRxL33A9ERc1PO4nyuy
         /fi6dqLl2IeT5lzlA5JKBSMpzKxypiruDFcCkKGsm5a9TPPHGJNQErNY+GWOqGSnXLpT
         /b8e9guMfOA1MIYidaqx0fBoEAp/eWe96yCJkYkV7FM7nVdw2yaLKM5LARsAN3w3mdHv
         vDxw==
X-Gm-Message-State: AJcUukfbURTDGjEvS9TLj+ySdv/Y2JMD1FetAgc00X4hv4x4kCdTdvoK
        GwJwjhHpnvPZyRRCGKvEUV0HqDv4VxUUYwWVD0w=
X-Google-Smtp-Source: ALg8bN6DkAgQAs6tX9QmBn9TCyNjIPO3AEb2Fg65vPZ1TkMPHR0dme+JVic2uQ/TUqdXVq0IXAtPBdRxJpHD8TIRhcQ=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr14980508qtr.319.1548518769415;
 Sat, 26 Jan 2019 08:06:09 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <20190123000057.31477-2-oded.gabbay@gmail.com>
In-Reply-To: <20190123000057.31477-2-oded.gabbay@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 26 Jan 2019 17:05:52 +0100
Message-ID: <CAK8P3a2NX_SNZPfqE4fnVcnxmSfAEzWMODce3L-g6JJ0NSTuBw@mail.gmail.com>
Subject: Re: [PATCH 01/15] habanalabs: add skeleton driver
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ogabbay@habana.ai
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 1:01 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:

> diff --git a/drivers/misc/habanalabs/include/habanalabs_device_if.h b/drivers/misc/habanalabs/include/habanalabs_device_if.h
> new file mode 100644
> index 000000000000..9dbb7077eabd
> --- /dev/null
> +++ b/drivers/misc/habanalabs/include/habanalabs_device_if.h

Since this is a apparently a user space ABI, the file should be in
include/uapi/linux/,
not in the driver directory.

> +/* must be aligned to 4 bytes */
> +struct armcp_info {
> +       struct armcp_sensor sensors[ARMCP_MAX_SENSORS];
> +       __u8 kernel_version[VERSION_MAX_LEN];
> +       __u32 reserved[3];
> +       __u32 cpld_version;
> +       __u32 infineon_version;
> +       __u8 fuse_version[VERSION_MAX_LEN];
> +       __u8 thermal_version[VERSION_MAX_LEN];
> +       __u8 armcp_version[VERSION_MAX_LEN];
> +       __u64 dram_size;
> +};

The compiler will align this to 8 bytes on most architectures, and
add another padding field before dram_size. Better remove the
'reserved' fields, or make them an even number.

       Arnd
