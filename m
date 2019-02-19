Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A058BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1212147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jwLt0N8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbfBSTG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 14:06:26 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37025 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfBSTGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 14:06:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id q3so3498244pll.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 11:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=I4LcM2XBTrkfUUVyaeSdAN2dPlTfFQPTd7YEe6AD0zw=;
        b=jwLt0N8fNHdUwJdXOlSYTSlQ/1fyUotRs62f6sGjPZo/svxilSw2rroNDsQJjE7Az7
         fcleijRl2Nch8HGAbgFT4Nwzsn4hzIcau3+sIPMK9r08ATUIkGVTqksfFs7BYCgLQk5x
         1nwLx2wn6XiPPixZXxcoVZdQ9xcku/PosugqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I4LcM2XBTrkfUUVyaeSdAN2dPlTfFQPTd7YEe6AD0zw=;
        b=USluJut7xxrwNLlsB7jueEpZMxqVrzpsF72lQuXoBsZUl0cgNhJpGN1MpfgjQogBAJ
         pj2uwiGIZj2+mcfpam+0nhzP7W48yQexlbFGiCkHuEk3ev86QW2sRTXEMYfjEnyuSGw6
         XnnekDjjDPRRfvVqEIJvkn2Z4AFb+YkdY+0JQ8uTNGObooZPNV2ZA7Q8EmEXoB7eoFje
         jPqkTKwf5Pj/+RC8ZXgEs/TBvSgMGfq1QeiRnnky890HuULdWFrSC1LMWW6Oz+UVLm8V
         GI93Q/jJT/6032BdmHNZt07pj5vuBfjEy0uPgsNUHZuylQz5rRDOxFgaJFBBWQ2iz8JZ
         MHvQ==
X-Gm-Message-State: AHQUAuZLgWsgdTQ4Ri9bd4kgVO/9/hrkAoeqFOtM3ZR77twp110MuPys
        b4xolJA7WEyDlRdyW7JZwNBHfA==
X-Google-Smtp-Source: AHgI3IY6yq/EMfadrl0MmfNVvwCACvmtBhV57YHyZcEeoTEYGMvvCmQD0Xtuf+Z1/OtiHtfXzUA7Rw==
X-Received: by 2002:a17:902:1e8:: with SMTP id b95mr32109887plb.325.1550603184871;
        Tue, 19 Feb 2019 11:06:24 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id n85sm5092156pfj.177.2019.02.19.11.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 11:06:24 -0800 (PST)
Date:   Tue, 19 Feb 2019 11:06:23 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: Re: [PATCH RESEND 0/3] Add quirk for reading BD_ADDR from fwnode
 property
Message-ID: <20190219190623.GA116191@google.com>
References: <20190131221021.176809-1-mka@chromium.org>
 <D45CF782-148F-4076-911B-50AC28718701@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D45CF782-148F-4076-911B-50AC28718701@holtmann.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On Mon, Feb 18, 2019 at 11:48:21AM +0100, Marcel Holtmann wrote:
> Hi Matthias,
> 
> > [initial post: https://lore.kernel.org/patchwork/cover/1028184/]
> > 
> > On some systems the Bluetooth Device Address (BD_ADDR) isn't stored
> > on the Bluetooth chip itself. One way to configure the address is
> > through the device tree (patched in by the bootloader). The btqcomsmd
> > driver is an example, it can read the address from the DT property
> > 'local-bd-address'.
> > 
> > To avoid redundant open-coded reading of 'local-bd-address' and error
> > handling this series adds the quirk HCI_QUIRK_USE_BDADDR_PROPERTY to
> > retrieve the BD address of a device from the DT and adapts the
> > btqcomsmd and hci_qca drivers to use this quirk.
> > 
> > Matthias Kaehlcke (3):
> >  Bluetooth: Add quirk for reading BD_ADDR from fwnode property
> >  Bluetooth: btqcomsmd: use HCI_QUIRK_USE_BDADDR_PROPERTY
> >  Bluetooth: hci_qca: Set HCI_QUIRK_USE_BDADDR_PROPERTY for wcn3990
> > 
> > drivers/bluetooth/btqcomsmd.c | 29 +++--------------------
> > drivers/bluetooth/hci_qca.c   |  1 +
> > include/net/bluetooth/hci.h   | 12 ++++++++++
> > net/bluetooth/hci_core.c      | 43 +++++++++++++++++++++++++++++++++++
> > net/bluetooth/mgmt.c          |  6 +++--
> > 5 files changed, 63 insertions(+), 28 deletions(-)
> 
> I am getting compiler warnings when trying to apply this set:
> 
>   CC      drivers/bluetooth/btqcomsmd.o
> drivers/bluetooth/btqcomsmd.c: In function ‘btqcomsmd_setup’:
> drivers/bluetooth/btqcomsmd.c:120:6: warning: unused variable ‘err’ [-Wunused-variable]
>   int err;
>       ^~~
> drivers/bluetooth/btqcomsmd.c:118:20: warning: unused variable ‘btq’ [-Wunused-variable]
>   struct btqcomsmd *btq = hci_get_drvdata(hdev);
>                     ^~~

Sorry, I missed that the variables aren't used anymore. I'll send a
new version soon.

Thanks

Matthias
