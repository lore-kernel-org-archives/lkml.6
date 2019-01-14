Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4854C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F4120657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547479747;
	bh=tahnnmd9lsQ09IO7SrteKJdzvRqFj8e+5N1Fn6n1TxU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iUX/ZeVql5IYWdSdhDXibEeZiWiFjR3kmBzOF7S4Eeu+VY0G15zWWfqd5m6N+m4RB
	 R+GZCAnGqr26mKgjp81iJfrtHPFnUEfuvLN43ZZEg1UTzaXLLq9OsRPQEQ4jRrehq7
	 3UZxh1AZPTq6WeYSC+VoFxaD0zeK0ocIzsOo4jCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbfANP3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:29:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbfANP3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:29:05 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED97A20657
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547479745;
        bh=tahnnmd9lsQ09IO7SrteKJdzvRqFj8e+5N1Fn6n1TxU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gRfT5ctC3jJsMRuvIKp//f2/ZFU4+4qMU8zr+V2VAJ4sOYAJiZgJKreYi1qmgzb+J
         yuiN6U06nWZk+6Y647QVdISzu26AyugDD5VpFlahikH+pzNl9Cbcujn9Ne5i7k5ooP
         Wn5GPpE+bxQsuS09VnfFkvUhfGlhcTOVl8JJjQhI=
Received: by mail-qt1-f176.google.com with SMTP id p17so26900290qtl.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 07:29:04 -0800 (PST)
X-Gm-Message-State: AJcUukeQuf7KtiQtbyQQw7qHKW8TvZp9dTLBGRzmGWVV8KskXQwzRXez
        F5ZRP60954iR1OshPJjQBWTYyURRwT9Wpjj7LYc=
X-Google-Smtp-Source: ALg8bN5MoUrfK5G9HdwDOtKUAM8hJWc4e/AJs4PEPknluyOGCPsdcNksw7qSFkabdwCoW8v4j9SfPemp7S8qo6KdDU4=
X-Received: by 2002:ac8:68d:: with SMTP id f13mr25060826qth.166.1547479744183;
 Mon, 14 Jan 2019 07:29:04 -0800 (PST)
MIME-Version: 1.0
References: <BN7PR12MB2660B14B55248BDC8BAF800AA0BB0@BN7PR12MB2660.namprd12.prod.outlook.com>
In-Reply-To: <BN7PR12MB2660B14B55248BDC8BAF800AA0BB0@BN7PR12MB2660.namprd12.prod.outlook.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Mon, 14 Jan 2019 10:28:52 -0500
X-Gmail-Original-Message-ID: <CA+5PVA4+AKOnKR8VXdXoCkMj=KJ08-vrvkJNDWpuhB_z1EPunQ@mail.gmail.com>
Message-ID: <CA+5PVA4+AKOnKR8VXdXoCkMj=KJ08-vrvkJNDWpuhB_z1EPunQ@mail.gmail.com>
Subject: Re: pull request: linux-firmware: update cxgb4 firmware
To:     "Arjun V." <arjun@chelsio.com>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        dt <dt@chelsio.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2018 at 5:21 AM Arjun V. <arjun@chelsio.com> wrote:
>
> Hi,
>
> Kindly pull the new firmware from the following URL:
> git://git.chelsio.net/pub/git/linux-firmware.git for-upstream
>
> Thanks,
> Arjun.
>
> The following changes since commit 0f22c8527439eaaf5c3fcf87b31c89445b6fa84d:
>
>   Revert "amdgpu: update vega10 fw for 18.50 release" (2018-12-18 15:38:53 -0500)
>
> are available in the git repository at:
>
>   git://git.chelsio.net/pub/git/linux-firmware.git for-upstream
>
> for you to fetch changes up to 80dee3102fe05ec44afe281818259160df3117c5:
>
>   cxgb4: update firmware to revision 1.22.9.0 (2018-12-24 00:17:20 -0800)
>
> ----------------------------------------------------------------
> Arjun Vynipadath (1):
>       cxgb4: update firmware to revision 1.22.9.0
>
>  WHENCE                  |  12 ++++++------
>  cxgb4/t4fw-1.21.5.0.bin | Bin 561664 -> 0 bytes
>  cxgb4/t4fw-1.22.9.0.bin | Bin 0 -> 565248 bytes
>  cxgb4/t4fw.bin          |   2 +-
>  cxgb4/t5fw-1.21.5.0.bin | Bin 648704 -> 0 bytes
>  cxgb4/t5fw-1.22.9.0.bin | Bin 0 -> 652800 bytes
>  cxgb4/t5fw.bin          |   2 +-
>  cxgb4/t6fw-1.21.5.0.bin | Bin 695296 -> 0 bytes
>  cxgb4/t6fw-1.22.9.0.bin | Bin 0 -> 703488 bytes
>  cxgb4/t6fw.bin          |   2 +-
>  10 files changed, 9 insertions(+), 9 deletions(-)
>  delete mode 100644 cxgb4/t4fw-1.21.5.0.bin
>  create mode 100644 cxgb4/t4fw-1.22.9.0.bin
>  delete mode 100644 cxgb4/t5fw-1.21.5.0.bin
>  create mode 100644 cxgb4/t5fw-1.22.9.0.bin
>  delete mode 100644 cxgb4/t6fw-1.21.5.0.bin
>  create mode 100644 cxgb4/t6fw-1.22.9.0.bin

Pulled and pushed out.

josh
