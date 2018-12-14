Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9350C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7102133F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544792038;
	bh=Ti3RnVhaAJbxhs+XP+FgSFV9+BKdeOBemVe96cWWCK0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ns6NsBkcraT7FjUC2JrGjnjjmhZ9/1qtG6Vj0AJtaFHQvsPwWdFSk0BBoN41XnL+4
	 tnepa2jXWEbyxZH6IHWppFW5tzL64jzskyJmdFOp1WPQ8s2FKO6fsOSZrdR+eL8lod
	 87wvKH402ZXGg7BZruUh2VYh8CNQqDqINNyhxv2k=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7102133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbeLNMx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:53:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbeLNMx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:53:56 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB49B2145D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 12:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544792036;
        bh=Ti3RnVhaAJbxhs+XP+FgSFV9+BKdeOBemVe96cWWCK0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aeZ+t5hGS4Ny+DqQK0QLGttPqZmIq2loS+3+DNqC21mRD3i2jkcWUo7yArhjiOKZQ
         wUa9cqkK3v+KeyaFpT/sxOWDuxVV7FnI1gpWkeMPfksLH/LJ00wpQRiFH8shl2Quy3
         218nkqmA63ZPy6ntPrf7S8Mg9k33yYYkpKLTvGLs=
Received: by mail-qk1-f182.google.com with SMTP id o89so3157250qko.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 04:53:55 -0800 (PST)
X-Gm-Message-State: AA+aEWaaC+HSE8TnNpQagC+ZmGSsXnM9Bk+9iKV+To3imUSkJbM5uMoA
        wKtfCcHii9Z5rfJUqQhx7p2B00hpVJb005RFveQ=
X-Google-Smtp-Source: AFSGD/VyvvIejuyMeVGdbudmeVgjpDJMZdGlmgRJcpCC+GohqjnGSb2i3GDne1/9opf8IycIwMkTB0eTAigQUiGp1v4=
X-Received: by 2002:a37:f706:: with SMTP id q6mr2314341qkj.96.1544792034950;
 Fri, 14 Dec 2018 04:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20181102111248.GA19135@chelsio.com>
In-Reply-To: <20181102111248.GA19135@chelsio.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Fri, 14 Dec 2018 07:53:43 -0500
X-Gmail-Original-Message-ID: <CA+5PVA6a9Gm71QY-ifntaXzOZH5rkDOBYia1nFVkFruC-EDvqw@mail.gmail.com>
Message-ID: <CA+5PVA6a9Gm71QY-ifntaXzOZH5rkDOBYia1nFVkFruC-EDvqw@mail.gmail.com>
Subject: Re: pull request: linux-firmware: update cxgb4 firmware
To:     Ganesh Goudar <ganeshgr@chelsio.com>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        nirranjan@chelsio.com, dt@chelsio.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 7:56 AM Ganesh Goudar <ganeshgr@chelsio.com> wrote:
>
> Hi,
>
> Kindly pull the new firmware from the following URL.
> git://git.chelsio.net/pub/git/linux-firmware.git for-upstream
>
> Thanks
> Ganesh
>
> The following changes since commit 1baa34868b2c0a004dc595b20678145e3fff83e7:
>
>   Merge branch 'nxp_mc' of https://github.com/NXP/linux-firmware (2018-10-26 08:13:19 -0400)
>
> are available in the git repository at:
>
>
>   git://git.chelsio.net/pub/git/linux-firmware.git for-upstream
>
> for you to fetch changes up to e7cdec460311a76e4f99e6bed763628af5fc2208:
>
>   cxgb4: update firmware to revision 1.21.5.0 (2018-11-02 03:38:38 -0700)
>
> ----------------------------------------------------------------
> Ganesh Goudar (1):
>       cxgb4: update firmware to revision 1.21.5.0
>
>  WHENCE                  |  12 ++++++------
>  cxgb4/t4fw-1.20.8.0.bin | Bin 559616 -> 0 bytes
>  cxgb4/t4fw-1.21.5.0.bin | Bin 0 -> 561664 bytes
>  cxgb4/t4fw.bin          |   2 +-
>  cxgb4/t5fw-1.20.8.0.bin | Bin 646144 -> 0 bytes
>  cxgb4/t5fw-1.21.5.0.bin | Bin 0 -> 648704 bytes
>  cxgb4/t5fw.bin          |   2 +-
>  cxgb4/t6fw-1.20.8.0.bin | Bin 692736 -> 0 bytes
>  cxgb4/t6fw-1.21.5.0.bin | Bin 0 -> 695296 bytes
>  cxgb4/t6fw.bin          |   2 +-
>  10 files changed, 9 insertions(+), 9 deletions(-)
>  delete mode 100644 cxgb4/t4fw-1.20.8.0.bin
>  create mode 100644 cxgb4/t4fw-1.21.5.0.bin
>  delete mode 100644 cxgb4/t5fw-1.20.8.0.bin
>  create mode 100644 cxgb4/t5fw-1.21.5.0.bin
>  delete mode 100644 cxgb4/t6fw-1.20.8.0.bin
>  create mode 100644 cxgb4/t6fw-1.21.5.0.bin

Pulled and pushed out.  Apologies for the large delay.

josh
