Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C6AC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D153A208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHRHZ9n9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D153A208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbeJAUlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:41:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729325AbeJAUlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:41:25 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B692145D;
        Mon,  1 Oct 2018 14:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538402607;
        bh=dVzN15P1ujtGyPVBDMKLe1jUOH8YWQ6Gr1OczTauwFA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AHRHZ9n9yA7EOsjZ4MRrozc+GWqYQZ0x7gA8oToAGCysHK7Sc6+2i/VV3E3Ev8ZXF
         MYC1Oozbh/quL29wFRe8+qRuREp5oBBcxYK6y3BJwvynqJym67ljT9V20ppYqkfKGn
         EZVTXFDIqHUJmB4EUt2uqEtOFOpL4Z7fUcxmf4DY=
Received: by mail-qt1-f176.google.com with SMTP id q41-v6so9221110qtq.10;
        Mon, 01 Oct 2018 07:03:27 -0700 (PDT)
X-Gm-Message-State: ABuFfoj6D6jBQRbWRP5lVwIQQDYH9FEhO39/wZVlxGhBOzqv/DJZ1usc
        Q1Lj/1VGkw1Z/RKl/1cLjKbcj5EjHzkwRVN3Pik=
X-Google-Smtp-Source: ACcGV61C1iQh0gkVx4+LnhYcjn4kP2dHjEVPBo/NdG6JBzjyZMhWXcD0wqLM+wlO+zOGwn2Drv8SR2b7vSZ58Z2u634=
X-Received: by 2002:a0c:87cc:: with SMTP id 12-v6mr8570988qvk.113.1538402606775;
 Mon, 01 Oct 2018 07:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <6fdc3e0ac48354760038988e0f9f3197cf611ccc.1537507210.git.sean.wang@mediatek.com>
In-Reply-To: <6fdc3e0ac48354760038988e0f9f3197cf611ccc.1537507210.git.sean.wang@mediatek.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Mon, 1 Oct 2018 10:03:15 -0400
X-Gmail-Original-Message-ID: <CA+5PVA6HZnFJthYrgicOki-BH1s_fXOru6RSs_AZ4md_M4YAxg@mail.gmail.com>
Message-ID: <CA+5PVA6HZnFJthYrgicOki-BH1s_fXOru6RSs_AZ4md_M4YAxg@mail.gmail.com>
Subject: Re: [PATCH] linux-firmware: mediatek: add firmware for mt7668u Bluetooth
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

On Fri, Sep 21, 2018 at 2:56 AM <sean.wang@mediatek.com> wrote:
>
> From: Sean Wang <sean.wang@mediatek.com>
>
> Add binary firmware for mt7668u based Bluetooth devices.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  WHENCE                  |   2 ++
>  mediatek/mt7668pr2h.bin | Bin 0 -> 170990 bytes
>  2 files changed, 2 insertions(+)
>  create mode 100755 mediatek/mt7668pr2h.bin

Applied and pushed out.

josh
