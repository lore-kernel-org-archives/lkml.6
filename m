Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEC9C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63182133F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544792800;
	bh=wbxjKhc6jjziiU/uuePafFXbrTOvphkww8nwNXs6pJE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eHOwDb6NUlv1C7K/fATV+jOQTD4pVCUUshuLySvsLwoXH6+ZL6J9o9HUvO5EClzvN
	 Vd/IyyZB4gpmxOe8oHT3qgE8nig0qpjArve4qw/21Qh49vcGCWeayO7fqJt2YCour0
	 ius2Y48g0NUanc28UfYZEFLc349sAAlmRKugY84o=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63182133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbeLNNGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:06:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729706AbeLNNGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:06:39 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57C152145D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 13:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544792798;
        bh=wbxjKhc6jjziiU/uuePafFXbrTOvphkww8nwNXs6pJE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=spy3UG87kDnebttATgeH3wfRGfVMQNPJIh5hBSU/4JiGmvHhLIt5nbH3jgy6h0kyh
         Voha8o5sF3WRrEvxoZxMlJBWEGFCPFQ4JPuM/IsFE89HWaZRML/CSjQMRF2v0Liahr
         Xsk1NmdG1LOzkg7uueUUyuFsOon+DtvvPOWuEuiI=
Received: by mail-qk1-f174.google.com with SMTP id y78so3142438qka.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 05:06:38 -0800 (PST)
X-Gm-Message-State: AA+aEWYEPEvdXrJhLRam4BhaOsZ372q3wFo3dQiMrGWH/yn6TyHu+6W5
        oP9XReZ7x0fxtcq4mSpgaQYXzfa3hQymsUrObW8=
X-Google-Smtp-Source: AFSGD/VNiCVavJ+RZ8X8vvmcDS1X4viE+ao5AlqlvdrWwBF8b8b9SO2foumq+OoEt3xDqukzX1LKPTaUAtg3HG0OCWo=
X-Received: by 2002:a37:f706:: with SMTP id q6mr2362806qkj.96.1544792797550;
 Fri, 14 Dec 2018 05:06:37 -0800 (PST)
MIME-Version: 1.0
References: <20181129183805.14808-1-john.allen@amd.com>
In-Reply-To: <20181129183805.14808-1-john.allen@amd.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Fri, 14 Dec 2018 08:06:26 -0500
X-Gmail-Original-Message-ID: <CA+5PVA7jALa3uZJuABiB4s_Z9kiqQxGpA7Td6bpmeMpP3+CdWg@mail.gmail.com>
Message-ID: <CA+5PVA7jALa3uZJuABiB4s_Z9kiqQxGpA7Td6bpmeMpP3+CdWg@mail.gmail.com>
Subject: Re: [PATCH] linux-firmware: Update AMD cpu microcode
To:     John.Allen@amd.com
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Suravee.Suthikulpanit@amd.com,
        Sherry Hurwitz <sherry.hurwitz@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 6:13 PM Allen, John <John.Allen@amd.com> wrote:
>
> * Update AMD cpu microcode for processor family 17h
>
> Key Name        = AMD Microcode Signing Key (for signing microcode container files only)
> Key ID          = F328AE73
> Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73
>
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>  WHENCE                                 |   2 +-
>  amd-ucode/microcode_amd_fam17h.bin     | Bin 3364 -> 6476 bytes
>  amd-ucode/microcode_amd_fam17h.bin.asc |  21 +++++++++++++--------
>  3 files changed, 14 insertions(+), 9 deletions(-)

Applied and pushed out.

josh
