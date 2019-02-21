Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00808C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B733F2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550751859;
	bh=9ILh9CC7tAgMYKxhVbSPMN3W8MvLdP1MIoUjk+hlmOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GPHAii7xZ35BVnrhFUWUSlOe+YpCTsk01GqHrKODUfDo4Gv2oV6E3Wv8HXOeZrrNk
	 xb7OfpvZhdT7+GBqLcFYMdxlFENapybbXHepvmShcY2Mn7nin/682HnHLuPRctOa2b
	 rymHRSx2SzbYh9IpEGrLSE7n3medBcVlrk8bkrcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfBUMYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:24:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfBUMYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:24:18 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 156412086C;
        Thu, 21 Feb 2019 12:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550751857;
        bh=9ILh9CC7tAgMYKxhVbSPMN3W8MvLdP1MIoUjk+hlmOU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VWztl3NmP2YenaUQp+kkvMmnfKIyKSijEYxlIXnMk17g8YpWk6hkaQRaUF2FniuZP
         UTu/JWDnhw+y5TtCkmWeKVDr/po/pkzpE94ZXyPOho8uY+XRIGn8LfMJUQMXC6AWwF
         f+ZnezAR+MOp196StL7xVL7JTK4H1meLXf389ZRw=
Received: by mail-qt1-f177.google.com with SMTP id d2so5517112qti.11;
        Thu, 21 Feb 2019 04:24:17 -0800 (PST)
X-Gm-Message-State: AHQUAuZE+JC8C+LGAq2NKMkV7kZTkusFMFy4b0T5+nVioSTgvnoE3t88
        Ta/8t1moSbNtnS/xM3Cha+tWQg4Ds2qld/yI5Pw=
X-Google-Smtp-Source: AHgI3IalFhvinEzqjpSQzBoj4P/usF0v98UMohZfTMKw+h1l8D833+vzZEQQBXokftOJJdYnUV2qcJdbrxVU0Q3bY/0=
X-Received: by 2002:ac8:23aa:: with SMTP id q39mr30474455qtq.82.1550751856300;
 Thu, 21 Feb 2019 04:24:16 -0800 (PST)
MIME-Version: 1.0
References: <26af87bceb0a7c355ba90cce863bfd1e@codeaurora.org>
In-Reply-To: <26af87bceb0a7c355ba90cce863bfd1e@codeaurora.org>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Thu, 21 Feb 2019 07:24:05 -0500
X-Gmail-Original-Message-ID: <CA+5PVA4HC-imfDHSECY3PntPRL0SquPmMkC7bzUVrabnJnYQpA@mail.gmail.com>
Message-ID: <CA+5PVA4HC-imfDHSECY3PntPRL0SquPmMkC7bzUVrabnJnYQpA@mail.gmail.com>
Subject: Re: Firmware files for QCA BT chip wcn3990
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Hemantg <hemantg@codeaurora.org>,
        Linux Firmware <linux-firmware@kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Linux-arm Msm <linux-arm-msm@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 8:01 AM Balakrishna Godavarthi
<bgodavar@codeaurora.org> wrote:
>
>
> Hi,
>
> The following changes since commit
> 710963fe53ee3f227556d36839df3858daf6e232:
>
>    Merge https://github.com/ajaykuee/linux-firmware (2019-02-13 07:42:20
> -0500)
>
> are available in the Git repository at:
>
>    https://github.com/bgodavar/qca_bt_wcn3990_fw.git
>
> for you to fetch changes up to f859d9fda9379205c9bcf2eab11fae68891085ee:
>
>    qca: Add firmware files for BT chip wcn3990. (2019-02-20 18:23:46
> +0530)
>
> ----------------------------------------------------------------
> Balakrishna Godavarthi (1):
>        qca: Add firmware files for BT chip wcn3990.
>
>   WHENCE           |   2 +
>   qca/NOTICE.txt   | 334
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------------------------------
>   qca/crbtfw21.tlv | Bin 0 -> 177060 bytes
>   qca/crnv21.bin   | Bin 0 -> 4587 bytes
>   4 files changed, 129 insertions(+), 207 deletions(-)
>   create mode 100644 qca/crbtfw21.tlv
>   create mode 100644 qca/crnv21.bin

Pulled and pushed out.  Thanks.

josh
