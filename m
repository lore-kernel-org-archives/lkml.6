Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84A5C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FEA208D8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wplsx+Cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbeLNOEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:04:32 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43093 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeLNOEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:04:31 -0500
Received: by mail-ot1-f65.google.com with SMTP id a11so5438184otr.10;
        Fri, 14 Dec 2018 06:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nYfQip329vh5gO6GSW1aFoeLmv78Jj86Ak92QuFMBfM=;
        b=Wplsx+Cw8G2dW2ohfb3MP0evmphEPXMrdHN9qJlYw6GeCbIEBFBhFmoIsAvyaUmOwN
         I8KLqgIkaHTIRkiPk0HZlKnXo05zXX7+qR/1/JlDixdHGzrZW6ss3Ev+GB0EhC4goDYM
         T2dU/n2BnDz9OYx9XfMwp6um7PxvSeQRTMUt0/Vxopnc/BhEwbobtoOUtJNoRaLa0FY6
         03Z0gz/LSr2cSi0o5djmIpzoB9lEvtftwnvFOtVu9CQiiNEAQD9fre8loIpHB6J6rL0s
         DnWA4oD77kziS3xN7Yx2DEIvOti8bYVgHhK1KfWkqtwk65JPeilEPB+Rgv84D3gt+tkj
         Vzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nYfQip329vh5gO6GSW1aFoeLmv78Jj86Ak92QuFMBfM=;
        b=QVX2DU1r8pcfQ4m8jh2otbL8btTjKb5kMq1Ckk0aYltnoyXvVTTfSOq/PJ7aWU01ja
         8/unbqT2D2heAvghk7HNkcrcme6u/3YtqLKqS3O/IBVNvSkGnUYuUXmML+tb2tPOuWr1
         Q1qJ8651ydiPTGM6iF3D3rbQ1C21tIJlq37UBZs1EZc3fc8Shf3okHi3nBArz0h+W3A0
         WP0PAd4WaIzNj0oUD/eEQrwbFZK6c2bQW/WoizLMZCM0SW40hAciUgAYCkMHtnnOteub
         sdedkQ/wCKhcTWzhwmEpZsYg3dg044lFEx/nchbWrEMira9ARoAUecjY1mwH/bwgCxFe
         /Kmw==
X-Gm-Message-State: AA+aEWaM05AbcApPZW+h32ICzBZqKSQPQwBOEYpLgv/UocZSMa74fmEu
        ztJCUIQqKkccLavOt9+tagcBN/gbrmeliPhbF+M=
X-Google-Smtp-Source: AFSGD/UImDqZzlX5XNLqTO684M+ZcclPs0eeGE59rRhHv4kqwLi+ntUDfl5eDuBSQ0l2V7BzQXXP3rmXPPYHlQ+4N/8=
X-Received: by 2002:a9d:6143:: with SMTP id c3mr2211217otk.227.1544796270896;
 Fri, 14 Dec 2018 06:04:30 -0800 (PST)
MIME-Version: 1.0
References: <20181214115729.658859279@linuxfoundation.org> <20181214115730.277730409@linuxfoundation.org>
In-Reply-To: <20181214115730.277730409@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Fri, 14 Dec 2018 14:03:55 +0000
Message-ID: <CADVatmN2tM+zNFmz+upPpV4+g1R1+kg62yL8Q=8jJ4Sy2EU6Xw@mail.gmail.com>
Subject: Re: [PATCH 4.14 12/89] tcp: Do not underestimate rwnd_limited
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, edumazet@google.com,
        soheil@google.com, ycheng@google.com,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Dec 14, 2018 at 12:08 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Eric Dumazet <edumazet@google.com>
>
> [ Upstream commit 41727549de3e7281feb174d568c6e46823db8684 ]

There is one upstream commit which fixes this one.
f9bfe4e6a9d0 ("tcp: lack of available data can also cause TSO defer")

-- 
Regards
Sudip
