Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596A2C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD5F2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544792272;
	bh=Biden9z8fZVlIfaw3ebrGLN6a/bmTmWGcn9W9eS+8FQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ePeqPBYk4vMIheCZ+97qgGmp4YEr7UIyolqSC7HgkHtjvQw1dz5jfWPH0ZyMDQT+d
	 iLo+OUAdGmkGqo5s9PeHrRigPEUjNOHd54dSOeIHp6NlEdaQcf5oNge+cTs8sxqDlD
	 Y9rxWbOkmvqArM3J5/k2iLP0cfPgsGvlhqbUD/lQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD5F2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbeLNM5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:57:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:36186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbeLNM5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:57:50 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F12292133F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544792270;
        bh=Biden9z8fZVlIfaw3ebrGLN6a/bmTmWGcn9W9eS+8FQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ItrqPJnyhZiwyD/MnAal5cyiMnoVMxIY8rz1WEBsxvsIaakAhM9bWlSCnMLu55MZn
         rcA/erz/1tvVkHY5FIqjE5b6NWbUtFZIgH6Yy1b89k72VFLDi9spQuCTdeBn976VS0
         g4AMSYHgrOQEGz0auVYnZ7qAl1uUOYWxgXPdSdxk=
Received: by mail-qk1-f173.google.com with SMTP id y16so3145203qki.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 04:57:49 -0800 (PST)
X-Gm-Message-State: AA+aEWbipHUc2gSRqfuI8yd2MTCDNTEDAIJ0AF2nrF2TDh+EhtVq9815
        8x/fSg5qdbBlvHCVjPuAKKblx13l1vAra4jRAAs=
X-Google-Smtp-Source: AFSGD/WuD7KIjKUhPdgOLVshcC167OleIQXN/JWRsSArV5+rxeCDWZlkLMdBhF56E0eD0hBwSgzIQDGGQVJBBq3tMJc=
X-Received: by 2002:a37:bb82:: with SMTP id l124mr1793047qkf.188.1544792269163;
 Fri, 14 Dec 2018 04:57:49 -0800 (PST)
MIME-Version: 1.0
References: <20181206103348.m7dtld3hccuhfeuf@qschulz>
In-Reply-To: <20181206103348.m7dtld3hccuhfeuf@qschulz>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Fri, 14 Dec 2018 07:57:37 -0500
X-Gmail-Original-Message-ID: <CA+5PVA5NViTUECEfrw3SqjUUx=qSoQJr6EQvvZ_Liv+B+aYr6Q@mail.gmail.com>
Message-ID: <CA+5PVA5NViTUECEfrw3SqjUUx=qSoQJr6EQvvZ_Liv+B+aYr6Q@mail.gmail.com>
Subject: Re: [GIT PULL firmware] microchip: add firmware for VSC8574 and
 VSC8584 Ethernet PHYs
To:     quentin.schulz@bootlin.com
Cc:     thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        antoine.tenart@bootlin.com, allan.nielsen@microchip.com,
        steen.hegelund@microchip.com,
        Linux Firmware <linux-firmware@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 5:34 AM Quentin Schulz
<quentin.schulz@bootlin.com> wrote:
>
> Hi all,
>
> Both VSC8574 and VSC8584 Ethernet PHYs require a firmware patch to be
> applied before making use of them.
>
> This adds the firmware for each of them.
>
> The Linux driver using the firmwares is already in Torvalds' tree:
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a5afc1678044a3eea48f0295ae7bc2b13d59b128
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=00d70d8e0e7811ed8acba24e04b9f193c3b84beb
>
> Thanks,
> Quentin
>
> The following changes since commit 1baa34868b2c0a004dc595b20678145e3fff83e7:
>
>   Merge branch 'nxp_mc' of https://github.com/NXP/linux-firmware (2018-10-26 08:13:19 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/QSchulz/linux-firmware MSCC-PHYs
>
> for you to fetch changes up to 57d49d580af5c67d7f725dda75aa71cb94505514:
>
>   microchip: add firmware for VSC8574 and VSC8584 Ethernet PHYs (2018-12-06 11:02:51 +0100)
>
> ----------------------------------------------------------------
> Quentin Schulz (1):
>       microchip: add firmware for VSC8574 and VSC8584 Ethernet PHYs
>
>  LICENCE.microchip                            |  40 ++++++++++++++++++++++++++++++++++++++++
>  WHENCE                                       |   9 +++++++++
>  microchip/mscc_vsc8574_revb_int8051_29e8.bin | Bin 0 -> 1655 bytes
>  microchip/mscc_vsc8584_revb_int8051_fb48.bin | Bin 0 -> 92 bytes
>  4 files changed, 49 insertions(+)
>  create mode 100644 LICENCE.microchip
>  create mode 100644 microchip/mscc_vsc8574_revb_int8051_29e8.bin
>  create mode 100644 microchip/mscc_vsc8584_revb_int8051_fb48.bin

Pulled and pushed out.

josh
