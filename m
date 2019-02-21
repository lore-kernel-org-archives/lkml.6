Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D668EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3272084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huer4L0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfBUSpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:45:00 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:43721 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfBUSo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:44:59 -0500
Received: by mail-lj1-f181.google.com with SMTP id z20so23863032ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 10:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=erb/ZZVVUXu0jVRC08dI9qBTtYZ3RazMaV0KrqTNQaw=;
        b=huer4L0vNJMuDKadrotY2ax3Sy3CtTdmZqKEfVtjfgeenLVyOP5p4tNUhQnEhIbak+
         QBFwoIhb+HL3cN1DfOH6QJ4jbD7xce8Mc600Z2jOPYLJou1Wyu+YIn3cnhqa3sssT78V
         KWKy/6VJ/NNfekHa1IJGydaFMQEXi7QywZAPqC2GV/CJ/DQF5SPCoo3WOLCscOI4sjan
         lmAUCxMA6m1qjPt7Xjxwjm6dtoaoldmj7Pq4PazDlPZKc/BdYbAwZk6tsadD2/Nb2vvr
         5Q78QmjLoKDSLrUEC67LnG5eawXGZM0arCF39dSz5GcHeC3ljXOTlxZadPbgfstQXxTN
         6rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=erb/ZZVVUXu0jVRC08dI9qBTtYZ3RazMaV0KrqTNQaw=;
        b=boA/q+mNg4goUB+jzrvHLWWfhQTiZERkdH4hCTNSA5zu/+uOyNx8qRA7Od0MO+/uRl
         3wwQOOMDHLtPX0e3PAV/yFT/ZdrgI+Sty33VaL/GX8CsBDxlTFt8yXCrDU3Y5v5Nz4GA
         qxdD6P6cgMcu/U7acVVXnOdlMfjNcGrkHEQjWp0ZRWjAJE5yBdsncg5NkBnQxY8je59g
         wBuP7y7e1NLrYIbHIbtCHqUkYlfV+mY/ZlkgJJ8sI806sOG1BHxTMZS7NEQScbEM0qoZ
         PwjObgRieFHEIHlYIXoV5yP5QBBVgra3gUgUXQ51NhOQyXMELI8TgXHE/ZKGfIcbOlwb
         knng==
X-Gm-Message-State: AHQUAua5eNZg2VwMH2jxex5r+CJwrYgdQe0mZkx3hHSXWEytsurDdzxE
        B2CRC2AKaw2C1ottppzhk3A89Ku+iJjUJK7WtIY=
X-Google-Smtp-Source: AHgI3IbeNoCSi9Ayo4PhYvXuoa26tT8STzkK47TKjTPSADbaV+ZtaA+dDuRNSTO0F3PcPKYftaofRBocYabE59B6hNs=
X-Received: by 2002:a2e:b014:: with SMTP id y20mr13754403ljk.116.1550774697513;
 Thu, 21 Feb 2019 10:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20190221003231.31625-1-alistair.francis@wdc.com> <20190221115227.ipwjpn3xm4q7jfg2@sirius.home.kraxel.org>
In-Reply-To: <20190221115227.ipwjpn3xm4q7jfg2@sirius.home.kraxel.org>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 21 Feb 2019 10:44:06 -0800
Message-ID: <CAKmqyKM_pb-riJ+jO65eT0SsVDxrstPOgurPuDf92Fd4C8k1Ug@mail.gmail.com>
Subject: Re: [PATCH] drm/bochs: Fix the ID mismatch error
To:     "kraxel@redhat.com" <kraxel@redhat.com>
Cc:     Alistair Francis <Alistair.Francis@wdc.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david.abdurachmanov@gmail.com" <david.abdurachmanov@gmail.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 3:52 AM kraxel@redhat.com <kraxel@redhat.com> wrote:
>
> On Thu, Feb 21, 2019 at 12:33:03AM +0000, Alistair Francis wrote:
> > When running RISC-V QEMU with the Bochs device attached via PCIe the
> > probe of the Bochs device fails with:
> >     [drm:bochs_hw_init] *ERROR* ID mismatch
> >
> > This was introduced by this commit:
> >     7780eb9ce8 bochs: convert to drm_dev_register
> >
> > To fix the error we ensure that pci_enable_device() is called before
> > bochs_load().
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Reported-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
>
> Pushed to drm-misc-fixes.

Thanks. Any chance this will make it into 5.0?

Alistair

>
> thanks,
>   Gerd
>
