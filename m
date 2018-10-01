Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33390C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4780208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzYd94zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4780208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbeJAUfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729272AbeJAUfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:35:20 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA159208AE;
        Mon,  1 Oct 2018 13:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538402244;
        bh=ymRxw/t+u2tT5u5gy/HGslM0ZO4mDu7qsc7OeBvuaoY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MzYd94zcjTd0sd2il+wr6WtmbK2QfoNUD91fbntf0p/tP0G25dFx0TgNkw1Tj2/X5
         +s7n6OM4CjVcOdontNl9qg89EGuUssAY+J/qonJVxHQkWJSIUBoEH2dx9FgYwqnHqT
         r3XZo445HuvPzBJErwBK9yA6N/wpw5OAOFT9/ehE=
Received: by mail-qt1-f169.google.com with SMTP id n6-v6so14027120qtl.4;
        Mon, 01 Oct 2018 06:57:24 -0700 (PDT)
X-Gm-Message-State: ABuFfogjYP7J9zV/oz573GjkPuUv089Gq7J9J96SvKoLUbgGBwMvjV00
        4tWFt4C7vK5lGfreN2NZlhbCoqc/F6MWmMVGFUw=
X-Google-Smtp-Source: ACcGV63CoSEItXunQG/yaTRDtavboVoUSc5JaYb1w1boqjrmW0UlmoQodl6/UnaXperfmROItx5PenrPoONAaAPjJwk=
X-Received: by 2002:ac8:4a11:: with SMTP id x17-v6mr8568211qtq.232.1538402243903;
 Mon, 01 Oct 2018 06:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <c56b472fa06e3a5e8127c2043c77305b@codeaurora.org>
In-Reply-To: <c56b472fa06e3a5e8127c2043c77305b@codeaurora.org>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Mon, 1 Oct 2018 09:57:12 -0400
X-Gmail-Original-Message-ID: <CA+5PVA4JQEwATu6ZR8H0vL04nyZzD5Cmnub-SSeJ1DNRpg7dww@mail.gmail.com>
Message-ID: <CA+5PVA4JQEwATu6ZR8H0vL04nyZzD5Cmnub-SSeJ1DNRpg7dww@mail.gmail.com>
Subject: Re: qca: update BT firmware files for QCA ROME chip.
To:     bgodavar@codeaurora.org
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        hemantg@codeaurora.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 6:49 AM Balakrishna Godavarthi
<bgodavar@codeaurora.org> wrote:
>
> Hi,
>
> The following changes since commit
> 44d4fca9922a252a0bd81f6307bcc072a78da54a:
>
>    Merge https://github.com/pmachata/linux-firmware (2018-09-13 11:45:40
> -0400)
>
> are available in the Git repository at:
>
>    https://github.com/bgodavar/qca_rome_firmware master
>
> for you to fetch changes up to 534daf431c88b24236d23572039cdd79223b246a:
>
>    qca: update BT firmware files for QCA ROME chip. (2018-09-18 13:11:47
> +0530)
>
> ----------------------------------------------------------------
> Balakrishna Godavarthi (1):
>        qca: update BT firmware files for QCA ROME chip.
>
>   qca/nvm_usb_00000302.bin      | Bin 1953 -> 1996 bytes
>   qca/rampatch_usb_00000302.bin | Bin 32940 -> 64168 bytes
>   2 files changed, 0 insertions(+), 0 deletions(-)

Pulled and pushed out.

Thanks.

josh
