Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4F5C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E71208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0H9QczW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E71208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbeG0Qe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:34:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732099AbeG0Qe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:34:27 -0400
Received: from mail-qt0-f169.google.com (mail-qt0-f169.google.com [209.85.216.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56533208C2;
        Fri, 27 Jul 2018 15:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532704326;
        bh=7MjVmSkWomSbcbk+s+qIQZg8xozjA7TQoZ8M6ac6Hvk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m0H9QczWgipMw/BmSfFl9JWxTWFxXiCATgDNijDQnaNhPPTj4DMCVjwm236lxBLcW
         FRVZvDh3dzPDBxSPuQhka77BqtLgiell0o+LmM3uc7E710C/Mq2Gw4SIUf5FlArqid
         3g6JAjxrNEBwR6DzXpHU+8U4Fiaef1FC72PmuJIs=
Received: by mail-qt0-f169.google.com with SMTP id d4-v6so5357554qtn.13;
        Fri, 27 Jul 2018 08:12:06 -0700 (PDT)
X-Gm-Message-State: AOUpUlFKlszRPUeQ6+tSw2hnpN8O7e1KI/6ywmvU6QmlppwKBAFIHACK
        zR6DNsy4LyZ/2GBxBrm5fPLS0NLaiop2g1KJ9Jc=
X-Google-Smtp-Source: AAOMgpcykMApzcJ18OByj08kBHuxO0ywxecbbZvtQ15rhQuaFhwZdct3e7LMaw181UD/wgMTvuRgoLcspit725OXNJ8=
X-Received: by 2002:a0c:d957:: with SMTP id t23-v6mr5925809qvj.149.1532704325499;
 Fri, 27 Jul 2018 08:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <df27512d09d5be118ef4228a559b770f3bd0e2e4.1531830577.git.sean.wang@mediatek.com>
In-Reply-To: <df27512d09d5be118ef4228a559b770f3bd0e2e4.1531830577.git.sean.wang@mediatek.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Fri, 27 Jul 2018 11:11:54 -0400
X-Gmail-Original-Message-ID: <CA+5PVA4D=1GAzs9k3pxyqOE7eruhuoWz=5T4sh2EQzRUkYAvhA@mail.gmail.com>
Message-ID: <CA+5PVA4D=1GAzs9k3pxyqOE7eruhuoWz=5T4sh2EQzRUkYAvhA@mail.gmail.com>
Subject: Re: [RESEND PATCH] linux-firmware: mediatek: add MT7622 Bluetooth
 firmwares and license file
To:     sean.wang@mediatek.com
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Firmware <linux-firmware@kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 8:32 AM <sean.wang@mediatek.com> wrote:
>
> From: Sean Wang <sean.wang@mediatek.com>
>
> Add MT7622 Bluetooth firmware files, along with the corresponding MediaTek
> license file.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  LICENCE.mediatek        |   9 +++++++++
>  WHENCE                  |   9 +++++++++
>  mediatek/mt7622pr2h.bin | Bin 0 -> 78158 bytes
>  3 files changed, 18 insertions(+)
>  create mode 100644 LICENCE.mediatek
>  create mode 100755 mediatek/mt7622pr2h.bin

Applied and pushed out.  Thanks.

josh
